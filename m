From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [MinGW port] Unable to repack on Clearcase dynamic views
Date: Wed, 30 May 2007 11:33:53 -0400
Message-ID: <fcaeb9bf0705300833t6f0639ddx2f507996e48d838c@mail.gmail.com>
References: <fcaeb9bf0705300742u22b54c78vccbc037fb553141f@mail.gmail.com>
	 <34a7ae040705300811o22a7d9e9y1ca6e52c4bf23fcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Matthias Lederhofer" <matled@gmx.net>,
	"Junio C Hamano" <junkio@cox.net>
To: "Paolo Teti" <paolo.teti@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 17:34:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtQBu-0007lF-5v
	for gcvg-git@gmane.org; Wed, 30 May 2007 17:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486AbXE3PeU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 11:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754954AbXE3PeU
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 11:34:20 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:25119 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760AbXE3PeS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 11:34:18 -0400
Received: by an-out-0708.google.com with SMTP id d31so709208and
        for <git@vger.kernel.org>; Wed, 30 May 2007 08:33:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T2C+lM0KKDb6pN/k5ltR8MvQX6719/LqdScPSGb8G9PVxh5t6zGVEuhhL+n7Ue+BC3wMCvLYSzD2o7/KFjE62y4ZANMTH8EP8NlzCx8QpGjGwgspEmlYd6CWoGv+NB1WRBWWBFuP/PEG6fsG1gDAfhdTdiYRygWn10fpL7XL1sI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LBj0ZHcRe2nq8cqSGPOIgFbmnNYom+aqLZJ6f5ET7Zu0gg+5W/+LyatCjBky8CjlSKS8RaUDuVEEcW1MWKPR9wm/7ElN/GdI3BUrAME2jEMzeYKZf+p2V25kqM7SWha+5LwXt3d7Zz5kmWmRohn8YypdPUs8HAZ2W28ByChKn1g=
Received: by 10.100.213.3 with SMTP id l3mr6122809ang.1180539233697;
        Wed, 30 May 2007 08:33:53 -0700 (PDT)
Received: by 10.100.127.2 with HTTP; Wed, 30 May 2007 08:33:53 -0700 (PDT)
In-Reply-To: <34a7ae040705300811o22a7d9e9y1ca6e52c4bf23fcc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48767>

On 5/30/07, Paolo Teti <paolo.teti@gmail.com> wrote:
> 2007/5/30, Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> > Hi,
> >
> > On clearcase dynamic views (kind of virtual drives), "mv -f a b" won't
> > work if "a" is read-only. Because git-repack.sh removes all write
> > permission before moving packs, it fails on clearcase dynamic views.
> >
> > My approach is rather ugly. Does anyone have a better solution?
>
> I hate clearcase, but honestly I have used it forced by a customer..
> The real problem is why you need to do a repack in a CC view, but..

I don't like it either :) But you remind me the Matthias' workdir
patchset. With that I can move out .git to a real drive/filesystem
(which should also give better performance).

I think it's a valid use case. Anyone remember why Matthias' patchset
was dropped?
It was last mentioned in
http://article.gmane.org/gmane.comp.version-control.git/43041

Junio, Matthias? May I help?

>
> to move a file in a Clearcase view you have to use 'cleartool mv ...'
> (or 'cleartool relocate') and not the UNIX mv command...

'cleartool mv' is used for clearcase-manages files. My git repository
are private files.

>
> ..and he directory where the element to be moved or renamed resides
> must be checked out.
>


-- 
Duy
