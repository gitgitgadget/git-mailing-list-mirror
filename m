From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Stacked GIT 0.1 (a.k.a. quilt for git)
Date: Sat, 18 Jun 2005 08:28:58 +1000
Message-ID: <2cfc4032050617152878b75c97@mail.gmail.com>
References: <tnxy899zzu7.fsf@arm.com>
	 <Pine.LNX.4.21.0506171750180.30848-100000@iabervon.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Jun 18 00:24:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjPFV-0001LG-Oe
	for gcvg-git@gmane.org; Sat, 18 Jun 2005 00:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVFQW3A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Jun 2005 18:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVFQW3A
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jun 2005 18:29:00 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:4395 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261181AbVFQW26 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2005 18:28:58 -0400
Received: by rproxy.gmail.com with SMTP id i8so916614rne
        for <git@vger.kernel.org>; Fri, 17 Jun 2005 15:28:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IRjISIkybAI7xBXWIDXnzT/IBvsgvGiy2owa6p/M1LyidcUs7CTqW/R+QjCqY+twfU21Gf8yE0yQwTQy7Jarr5P07w2GUMwQWygVii7jMFUF8mIRgFx35Lehhob1VLaya3XXI1pTWzg0DEPS9x0DL/YDoNO+h1U+qVimuXPvVBY=
Received: by 10.38.181.17 with SMTP id d17mr1277467rnf;
        Fri, 17 Jun 2005 15:28:58 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Fri, 17 Jun 2005 15:28:58 -0700 (PDT)
To: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0506171750180.30848-100000@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> 
> I think it would worth exploring defining a git type for patches and
> storing the patches inside git as well. Then a commit could identify the
> patch it applies (when it is from applying a patch), and a rebased patch
> could reference the patch it replaces, and then (with a certain amount of
> handwaving of implementation) the system could notice when the patch
> you're pushing got applied upstream. Or, at least, git could avoid
> throwing away the history information when it goes through patches. I keep
> thinking that this would be an important feature, but I haven't got the
> familiarity with quilt to know how it should work.
> 

I also think it would be good if patches extracted from git
repositories included some information about exactly where the patch
was extracted from...something like...



signed-off-by: Name <user@host.domain>
---
commit: sha1 -> sha1
tree: sha1 -> sha1

The reason for including the commits is to allow the maintainer to
track exactly where the a given rev of a patch was from. The reason
for including the treeids is to allow appliers to verify that the
patch has produced the same result as the patch submitter.
