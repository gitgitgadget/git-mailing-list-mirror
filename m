From: David Barr <david.barr@cordelta.com>
Subject: Re: [PATCH] fast-import: Allow filemodify to set the root
Date: Fri, 8 Oct 2010 10:45:46 +1100
Organization: Cordelta Pty Ltd
Message-ID: <201010081045.46642.david.barr@cordelta.com>
References: <1286448906-1424-1-git-send-email-david.barr@cordelta.com> <20101007202847.GA13234@burratino> <AANLkTi=K0NsKB0uBpHs+mB=PubieX7jO7vFiqrs+dnqB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 01:46:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P409y-00049c-FF
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 01:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522Ab0JGXpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 19:45:54 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53849 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab0JGXpy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 19:45:54 -0400
Received: by gye5 with SMTP id 5so159303gye.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 16:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=Ftb9Gb8WAeaONsAP+HMUzVLQGMO1oWiPXGZlRSQD8QU=;
        b=GEaGG79HtpCHKbQ7j8PArno0K91NnzprsKIvLNs6Kf93svYsmOILaXumwFOUKiMTT8
         1Cdg4UIZhZsTaH5Yw5DQbdDwhpK22ByeodB9mAGEaZz+c7MJ48JfsRw7Sudlr+rnZoxG
         Ne1UvzZy2GHG+Ix0BRu9GqmCXBslB2f5s+Qq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=TODZhSW1uBEf4t+pRUfwNMYHsSYEJ2dMnpuo0U+dwI3RdREqFbW8s1yK88v0Jj363w
         LthYKDmpB9nLNHAad/GhZWxjam1gtAPwMoL0TbXkkiOaJ74LE360isNRG23zlsHfNQGi
         QfNLaUXw1Yg9eFEG1kgUaT+d+H8ChF1sFWlWg=
Received: by 10.150.160.1 with SMTP id i1mr2056439ybe.95.1286495153562;
        Thu, 07 Oct 2010 16:45:53 -0700 (PDT)
Received: from dba.localnet ([119.15.97.146])
        by mx.google.com with ESMTPS id u3sm2765704yba.22.2010.10.07.16.45.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Oct 2010 16:45:52 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.35-22-generic; KDE/4.5.1; x86_64; ; )
In-Reply-To: <AANLkTi=K0NsKB0uBpHs+mB=PubieX7jO7vFiqrs+dnqB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158462>

Hi,

> | For a command (like filter-branch --subdirectory-filter) that wants
> | to commit a lot of trees that already exist in the object db, writing
> | undeltified objects as loose files only to repack them later can
> | involve a significant amount[*] of overhead.

> [*] how significant?  Numbers are always nice. :)

Using git hash-object:
real    2m51.748s
user    0m25.460s
sys     0m23.890s

Using git fast-import:
real    2m13.337s
user    0m28.010s
sys     0m18.100s

> 
> > Ok, so maybe I do understand, is it basically 'git read-tree
> > 4b825dc642cb6eb9a060e54bf8d69288fbee4904' for fast-import?

> Perhaps mention that in the commit message as well then. Of course,
> the fast-import doc needs updating, and it needs test.

| is a synonym for the deleteall command and the fast-import equivalent of
| 
|         git read-tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904

--
David Barr
