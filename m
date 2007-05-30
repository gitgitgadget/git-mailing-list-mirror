From: "Paolo Teti" <paolo.teti@gmail.com>
Subject: Re: [MinGW port] Unable to repack on Clearcase dynamic views
Date: Wed, 30 May 2007 17:11:58 +0200
Message-ID: <34a7ae040705300811o22a7d9e9y1ca6e52c4bf23fcc@mail.gmail.com>
References: <fcaeb9bf0705300742u22b54c78vccbc037fb553141f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 17:12:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtPqO-0001ux-5l
	for gcvg-git@gmane.org; Wed, 30 May 2007 17:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbXE3PMI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 11:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbXE3PMI
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 11:12:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:9498 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbXE3PMF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 11:12:05 -0400
Received: by ug-out-1314.google.com with SMTP id j3so210465ugf
        for <git@vger.kernel.org>; Wed, 30 May 2007 08:12:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Co59eVQCAw7UoFLLani3LoUtkydQ1+jpO++wCYCpV2JdN7OURnUZOWuR+nKZ+ZLgbMsUm03NkEKhcyNada0qvW6LwRkffP8I/PekfilsNqywozWozvg9CrOlIAi1r+rZIMr6dWb/qIUTtpcVBIjad3yTzdZVmtiTFJCC4yckUPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o/XxSUrzK+lIflb7RWl3EbWs59fYjPgqYOK7N0qaqI0KwcpNmWVDkhM+gtgeleUQEUg1m4OAGWOhJH9D5XspSBxwenwg4K8XdWydnAk3VNB2M8yT1xikBxySnI/5ubKuIfnsv67j7JeZbjboDvn7UYqIE/N03exaKJ43ur9PYUA=
Received: by 10.78.156.6 with SMTP id d6mr471777hue.1180537923867;
        Wed, 30 May 2007 08:12:03 -0700 (PDT)
Received: by 10.78.183.11 with HTTP; Wed, 30 May 2007 08:11:58 -0700 (PDT)
In-Reply-To: <fcaeb9bf0705300742u22b54c78vccbc037fb553141f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48765>

2007/5/30, Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> Hi,
>
> On clearcase dynamic views (kind of virtual drives), "mv -f a b" won't
> work if "a" is read-only. Because git-repack.sh removes all write
> permission before moving packs, it fails on clearcase dynamic views.
>
> My approach is rather ugly. Does anyone have a better solution?

I hate clearcase, but honestly I have used it forced by a customer..
The real problem is why you need to do a repack in a CC view, but..

to move a file in a Clearcase view you have to use 'cleartool mv ...'
(or 'cleartool relocate') and not the UNIX mv command...

..and he directory where the element to be moved or renamed resides
must be checked out.
