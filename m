From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] difftool: add support for an extended revision syntax
Date: Mon, 23 Mar 2009 09:33:44 -0700
Message-ID: <20090323163343.GB16258@gmail.com>
References: <1237803348-9329-1-git-send-email-davvid@gmail.com> <49C7A20E.7060503@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 17:35:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lln7k-0002Xa-Lh
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 17:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758794AbZCWQdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 12:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758642AbZCWQdJ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 12:33:09 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:48446 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758609AbZCWQdH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 12:33:07 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1517613wah.21
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=IOpfqhppoybIIPVdqE7qmrNhua4Q2TUxtzpe2CihAog=;
        b=b6RTMvtwjXRJ3MMJ6EDVxRE9ng6Li+hmFV4w1cLCOZMq9w/X6M85VCQiz/Wwmfy9te
         FQztZnd1hnaT5heYg38BaEKda1jRNy2QQ3YN8ZeLFXzVDFv1z5hEGoa8jep/0+0YqwHF
         V6HhqhGyBsXdJstRZu2PcZPLCo5zM1Yonq7Ew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sW62xOHnUYe1sOlSpLMNulZOXeiYnQ0+eKRjCc0G93B/dZXdflKKM1UC184Z3FqdPP
         OEb8G0Dcl5I/WFg9h1m+eODxRorwxkLNEeyhjkjEodl7rkQrfgvmD6xpv45E3bZITr3A
         fKgXesBp+eBKFf9XQi5es+CgB8GuGusXdweRA=
Received: by 10.114.133.1 with SMTP id g1mr4890903wad.162.1237825985339;
        Mon, 23 Mar 2009 09:33:05 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v9sm5433425wah.60.2009.03.23.09.33.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 09:33:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49C7A20E.7060503@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114331>

On  0, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> David Aguilar venit, vidit, dixit 23.03.2009 11:15:
> > 
> > This makes answering that question considerably easier.
> > Users can now simply say:
> > 
> > 	$ git difftool <file>~
> > 
> > to compare <file> in the worktree against its
> > previous version, and:
> > 
> > 	$ git difftool <file>~2 <file>~
> > 
> > to compare <file> from 2 versions ago to <file>'s
> > previous version, etc.
> > 
> 
> I like the idea of having a shortcut like that a lot, but I'm sorry I'm
> not supportive of a tool-specific rev syntax extension; for principal
> reasons, but also because diff, checkout and maybe others could make
> good use of it.

I completely agree.  I want a convenient shortcut to use everywhere.


> Work is underway on clearing out the issue of forbidden characters in
> revision specifiers. We already have commit:file. I think something like
> ~2:file would be short enough as well as in line with the usual
> semantics. Similarly,
> 
> git diff ~3 ~2 file
> git diff ~3 file
> 
> would be short and simple as soon as ~3 is implemented to be a shortcut
> for HEAD~3. (I'm not sure we can actually use ~, even though it would
> fit in with the usual "if it's not specified it's HEAD".) This would
> only need a shortcut for HEAD, such as not even specifying it (as above)
> or c~ with c being our new fancy character for that.


One of my ulterior motives for sending this patch was to
start a discussion on this topic.  I missed the discussion
about clearing out forbidden characters so I'll see if I can
find it in the archives.  Do you happen to have a link?

Keep in mind that the syntax that this patch added does
not have file~3 = HEAD~3.  file~3 means finding file as it
existed 3 changes-to-file ago, which is != to HEAD~3 if file
did not change in the last 3 commits.

It basically runs 'git log -- file' so that only the commits
that touch file are considered.

Are you suggesting that ~3:file could be the shortcut for
this, or would we need a different syntax since you just
said that ~3 would be a shortcut for HEAD~3?

If there's work on syntax-sugarfying diff/checkout/etc. with
these kind of shortcuts then I would like to help out with
patches, testing, etc.

This is a feature that lots of users would enjoy--I know that
for sure.

-- 

	David
