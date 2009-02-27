From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Problems rebasing branch after renaming files
Date: Fri, 27 Feb 2009 02:55:31 -0800 (PST)
Message-ID: <m3hc2gup2n.fsf@localhost.localdomain>
References: <c64207c00902270055q57442e2dmd81c197419dda71a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Salvatore Iovene <salvatore.iovene@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 11:57:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld0Ov-0001vb-1B
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 11:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898AbZB0Kzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 05:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755368AbZB0Kzf
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 05:55:35 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:65400 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbZB0Kze (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 05:55:34 -0500
Received: by fxm24 with SMTP id 24so982731fxm.37
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 02:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=agJWxgxPtp35q6B+Pin4WrBZaeGrzo8feJD0/lrZMHc=;
        b=NOo7szMvloBadCXXO23HRaapVzaCjCgKoQuTS8yD4NPbp3ZpEZcsbBbfk4n5cO8oGd
         IebXmPXb8+yLPiZRqGmSoXy9C3tHjOOIe+CLJ15dlyUyMfrxKjJPHi/vjbGOu19+xX1A
         hhIX/tL5vT2gxUArfPhCBkVvD7Pdy0+JEYeLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=eDbRo6/VKDzCY41zV06k2AGnex1cso59qxuN+PZXq2m8NgB72axjaZ6J36baPw01/x
         0IkH2zJtY0k/2r11BFIaRtWsHgdU3BfKmo/qB3qgo9+VQKFEeyxkUxIDKYiGWMSO3Ume
         1Ynet7JO3U7Bt6s0JyIqIPZN+heFyCy/zPvjk=
Received: by 10.103.213.19 with SMTP id p19mr1242434muq.9.1235732131555;
        Fri, 27 Feb 2009 02:55:31 -0800 (PST)
Received: from localhost.localdomain (abvt245.neoplus.adsl.tpnet.pl [83.8.217.245])
        by mx.google.com with ESMTPS id s10sm698096mue.16.2009.02.27.02.55.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Feb 2009 02:55:31 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1RAtGgO014992;
	Fri, 27 Feb 2009 11:55:19 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1RAtD5l014989;
	Fri, 27 Feb 2009 11:55:13 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <c64207c00902270055q57442e2dmd81c197419dda71a@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111661>

Salvatore Iovene <salvatore.iovene@googlemail.com> writes:

> Hi list,
> I ran into a problem, and I'm unsure it's a git bug or a misuse of mine.

[...]
> 3) Create branch B and work on it. In this branch, rename a directory
> containing source files with git-mv
> 4) Merge B to master
> 5) Rebase A to master

[...]
> I found that, checking out A, my files in the now renamed directories
> are as the were in B, i.e. not including the changes made in A,
> because I have rebased A to master and git didn't realize that the
> files in old_directory_name are the same as in new_directory_name so
> they should have been merged.
> 
> Either this is a git bug or not, can anyone suggest a way to fix this?
> All I've thought so far is to git-format-patch the patches that I had
> in A, use sed to replace the old_directory_name with the new one,
> create a new branch called A2 at master's head, apply the patches
> there and git-branch -D A.

In short: you have rename in mainline, and want to rebase branch from
before rename.

This problem is not bug in git, it is rather limitation of default
patch based rebase. The git-format-patch | git-am pipeline is fast,
but it cannot deal with renames in mainline. You have to use
merge-based rebase, i.e. use

  $ git rebase --merge <upstream>

>From git-rebase(1):

  -m, --merge
    Use merging strategies to rebase. When the recursive (default) merge
    strategy is used, this allows rebase to be aware of renames  on  the
    upstream side.

  -s <strategy>, --strategy=<strategy>
    Use  the  given  merge  strategy;  can be supplied more than once to
    specify them in the order they should be tried. If there  is  no  -s
    option, a built-in list of strategies is used instead
    (git-merge-recursive when merging a single head, git-merge-octopus
    otherwise). This implies --merge.

Or use "git rebase --interactive".

-- 
Jakub Narebski
Poland
ShadeHawk on #git
