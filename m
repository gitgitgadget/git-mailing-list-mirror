From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-clone wrongly setting branch.*.merge ? (Was: [PATCH 2/3] Rebase to parent branch after git-fetch in "stg pull".)
Date: Sat, 03 Feb 2007 01:17:51 +0100
Organization: At home
Message-ID: <eq0k8q$rih$1@sea.gmane.org>
References: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth> <20070201234805.3313.20525.stgit@gandelf.nowhere.earth> <b0943d9e0702020158o1a07b8efu9302794c57d050e1@mail.gmail.com> <20070202180706.GE5362@nan92-1-81-57-214-146.fbx.proxad.net> <20070202235655.GG5362@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 03 01:17:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD8aS-0005MD-T9
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 01:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933398AbXBCAQw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 19:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933399AbXBCAQw
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 19:16:52 -0500
Received: from main.gmane.org ([80.91.229.2]:57588 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933398AbXBCAQv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 19:16:51 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HD8a6-0005tk-O7
	for git@vger.kernel.org; Sat, 03 Feb 2007 01:16:40 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Feb 2007 01:16:38 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Feb 2007 01:16:38 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38544>

Yann Dirson wrote:

> With current GIT HEAD, plain git-clone creates the following config
> (when cloning a repo with HEAD pointing to branch "downstream":
> 
> 
> [remote "origin"]
>         url = /export/work/yann/git/stgit/tmp/.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
> [branch "downstream"]
>         remote = origin
>         merge = refs/heads/downstream
>                 ^^^^^^^^^^^^^^^^^^^^^
> 
> I would have expected "merge = remotes/origin/downstream" instead, and
> this setting confuses the rebase-after-pull logic, causing it to
> rebase the stack onto its own base (no-op).
> 
> Isn't that a git-clone bug ?

No, it is a feature. branch.<name>.merge is usually _remote_ head,
to allow pulling without local tracking branch. IIRC there was
patch to allow to use local head, if it is ambiguous.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
