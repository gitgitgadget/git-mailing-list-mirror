From: Kent Borg <kentborg@borg.org>
Subject: Re: git-p4
Date: Mon, 13 Sep 2010 12:28:15 -0400
Message-ID: <4C8E511F.8000400@borg.org>
References: <4C8A8CE8.90600@borg.org>	<20100910235323.773d2c5b@varda>	<AANLkTinmG5BU+yswWQ8=cRKT5WL_h8vWuUCu2PjZYb87@mail.gmail.com>	<4C8CF231.6090403@borg.org>	<AANLkTi=yJ5kVA17+40xc6NpEczFjgmYh7=w5k=GL_U9w@mail.gmail.com>	<4C8D14F9.90705@borg.org>	<AANLkTi=NGsY3wDiTLwNLpw4TJMpiSY8A=az_=v2fYDLj@mail.gmail.com>	<4C8D3303.1030302@borg.org>	<AANLkTikrSt4djXep-o4Hr8EZAsiNXnqCHa2fLrys8T==@mail.gmail.com>	<4C8E33DF.7010904@borg.org> <AANLkTimL3mB8LeUOANsJO7p9uwqDCN9wKnLVMTq_-=3H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 18:28:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvBtK-0006UZ-5v
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 18:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903Ab0IMQ2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 12:28:17 -0400
Received: from borg.org ([64.105.205.123]:38334 "EHLO borg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204Ab0IMQ2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 12:28:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: kentborg)
	by borg.org (Postfix) with ESMTP id AA9D087822;
	Mon, 13 Sep 2010 12:28:15 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <AANLkTimL3mB8LeUOANsJO7p9uwqDCN9wKnLVMTq_-=3H@mail.gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156102>

Tor Arvid Lund wrote:
> git remote, shows remotes as defined in your .git/config file (the
> [remote "someremotename"] sections). git-p4 does not need nor create
> such entries.

I am confused trying to understand what kind of beast the p4/master is.

I think my fundamental problem is that I need p4/master to point at a
branch with a real git history, not a sync from Perforce (which has no
git history).

I tried pointing p4/master at a clean branch in my repository with "git
update-ref refs/remotes/p4/master ...", but every time I tried a "git p4
sync --verbose" it sprang back to pointing at the old commit (the one
without a full git history). 

So I figured I have brokenness I might be able to leave behind if I
tried making a new "git p4 clone", doing a "git remote add ..." to the
branch I like in my old git repository, and trying it again...but I get
the same result. 

After my update-ref I grep in .git for the commit hash that keeps
grabbing my p4/master...and that hash is only in
logs/refs/remotes/p4/master.    I do a "git p4 sync" and the hash
reappears in refs/remotes/p4/master.  Where is it coming from?

How do I change where p4/master points?  (Put another way, how can I
have a complete Linux history in git but only new work in Perforce?)


Thanks,

-kb, the Kent who is getting a lot smarter about git in the last few
days, but for whom git-p4 is not yet in control.
