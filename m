From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: git weird pulling issue
Date: Thu, 3 Jan 2008 23:08:37 +0300
Message-ID: <20080103200837.GM8046@cvg>
References: <20080103121114.GE8046@cvg> <7v4pdusspu.fsf@gitster.siamese.dyndns.org> <20080103183631.GL8046@cvg> <7vprwiptmx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT-LIST <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 21:09:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAWNV-000862-Rd
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 21:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbYACUIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 15:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbYACUIz
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 15:08:55 -0500
Received: from fk-out-0910.google.com ([209.85.128.185]:47243 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbYACUIx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 15:08:53 -0500
Received: by fk-out-0910.google.com with SMTP id z23so6827204fkz.5
        for <git@vger.kernel.org>; Thu, 03 Jan 2008 12:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=6ACmDGlFtmAzeuKzi2X+g8Qawnfl96zyoyyYpeoLjzc=;
        b=OFZ9Mx8h64vCWstGn01zV+yEbbl7XI3nD5IUzxJZkOe616FDIQHFUFICDiOBkzmUiJdJ+28SVzbyPyZw3YuF3sJwiTa3D5sfZlSVVUYQGPbirL8qKi9GSm8EZX658QblFKt5deVkYSTeXgmjTOX00mC3QFOBSPM4YRw4hOzuIEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=f9YvaZgtl8QZoGdj0YbvD/WpxMN0O2Ek4fNR9ercqaCI4/SX0uX3/ay79bBxoM39yJECLhzssINgMUPjXdbqdTc4wq7fioKQ6bftex8dwph1VTAcpQrOWl6ARLzzy1sFpeCiQvihJajlcZ+yLpp+0d2vs294z9Lg7ltvDs+iOl4=
Received: by 10.82.159.15 with SMTP id h15mr28349010bue.36.1199390929906;
        Thu, 03 Jan 2008 12:08:49 -0800 (PST)
Received: from gorcunov ( [91.122.85.165])
        by mx.google.com with ESMTPS id b30sm146001ika.11.2008.01.03.12.08.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Jan 2008 12:08:48 -0800 (PST)
Received: by gorcunov (Postfix, from userid 1000)
	id 6E46D7B27; Thu,  3 Jan 2008 23:08:37 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <7vprwiptmx.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69531>

[Junio C Hamano - Thu, Jan 03, 2008 at 11:59:50AM -0800]
| Cyrill Gorcunov <gorcunov@gmail.com> writes:
| 
| > so i hold only Linus's and Ingo's changes in repo not mine.
| 
| Thanks.  I think I know exactly what is going on.
| 
| BTW, do not drop git@vger.kernel.org from the CC: list without a
| good reason, please.  Otherwise I'd be spending my time *solely*
| to help you, in which case I have to charge you for my time ;-)
| 

oops ;) actually it wouldn't be a problem if (1) i've a well-paid
work and (2) wouldn't live in Russia (from where is no simple way to
pass a bit of charge to anyone from a regular men ;) So i prefer
to keep git@ then ;)

| If you find this message useful, you may forward it back to the
| list along with your message I am responding to.
| 
| Here is what is happening.
| 
|  (0) Ingo has this:
| 
|                       A---B (== I)
|                      /
|     ----o---o---o---L
| 
|      where L is the tip of Linus at some point, I is his changes
|      for x86.  You pull and get the same thing.  Your local x86
|      tip points at commit B.
| 
|  (1) Then Linus advances and Ingo rebases.  Updated Linus's tip
|      is at L' and Ingo has old patches rebased (A' and B') while
|      he added more changes (C and D).  His tip is at I'.
| 
|                       A---B (==I) A'--B'--C---D (==I')
|                      /           /
|     ----o---o---o---L---o---o---L'
| 
|  (2) You pull.  What is involved is:
| 
|      * git-pull is just "git fetch" followed by "git merge", and
|        in your repository "git fetch" can be configured to use a
|        remote tracking branch to keep track of Ingo's progress
|        (but I suspect you don't).  Your "git branch" output
|        shows your local branches, and "git branch -r" would show
|        these remote tracking branches.
| 
|      * The remote tracking is typically configured in
|        .git/config and would look like this:
| 
|         [remote "mingo"]
|         url = git://git.kernel.org/pub/...
|         fetch = refs/heads/*:refs/remotes/mingo/*
| 
|         Although I _suspect_ you do not have it (your $ipull
|         script pulls with explicit URL without using configured
|         information).
| 
|      The above (for normal people who have the tracking set up)
|      fetches the branch tip's from Ingo, and store them in
|      corresponding places in .git/refs/remotes/mingo/;  his 'mm'
|      branch will be stored in .git/refs/remotes/mingo/mm.
| 
|      But remote.mingo.fetch configuration above does not start
|      with '+' (e.g. "+refs/heads/*:refs/remotes/mingo/*", which
|      means "do allow non-fast-forward").  For people with such
|      configuration, "git pull" from him will fail because
|      remotes/mingo/mm points at commit B before you initiated
|      the fetch and now it points at D which is _NOT_ a
|      descendant of B.
| 
|      His recommendation about --force applies _ONLY_ to override
|      this, and allow your remote tracking branch that used to
|      point at B to be replaced to point at D.  I suspect it does
|      not even apply to you as I do not think you are using
|      remote tracking branch at all.
| 
|      In any case, once "git fetch" completes, "git merge"
|      happens.  --force does not affect this step at all.
| 
|      What's merged?
| 
|      Your 'x86' branch is still at B and you try to merge D into
|      it.
| 
|                             .-------------------*
|                            /                   / 
|                       A---B       A'--B'--C---D
|                      /           /
|     ----o---o---o---L---o---o---L'
| 
|      Because Ingo's tree was rebased, the resulting merge wants
|      to have both versions of A and B (the original and the
|      rebased).  As corresponding patches (say A and A') would
|      want to touch same parts of the code, and Ingo may have
|      improved the latter while all of this has been happening
|      (i.e. A and A' may not be literal rebase but can do things
|      differently), it will inevitably conflict with each other.
| 
| Even though the conflict resolution would be trivial (you would
| basically want to pick what's from A' over A), this is not what
| you would typically want to happen.  When dealing with a
| rebasing upstream, you often do not want to merge but instead
| rebase yourself.
| 
| So backing up a bit, here is how people would follow rebasing
| upstream:
| 
|  (0) Ingo has this:
| 
|                       A---B (== I)
|                      /
|     ----o---o---o---L
| 
|      where L is the tip of Linus at some point, I is his changes
|      for x86.  You pull and get the same thing.  Your local x86
|      tip points at commit B.
| 
|  (1) You develop on top of Ingo (although you hinted in your
|      description that you are strictly following, that is just a
|      degenerated case of this where (X,Y,Z) is empty in this
|      picture):
| 
|                             X---Y---Z
|                            /
|                       A---B (== I)
|                      /
|     ----o---o---o---L
| 
|  (2) Then Linus advances and Ingo rebases.  Updated Linus's tip
|      is at L' and Ingo has old patches rebased (A' and B') while
|      he added more changes (C and D).  His tip is at I'.
| 
|                       A---B (==I) A'--B'--C---D (==I')
|                      /           /
|     ----o---o---o---L---o---o---L'
| 
|  (3) You do not pull but instead fetch from Ingo to get what
|      happened outside your tree.
| 
|                             X---Y---Z
|                            /
|                       A---B (==I) A'--B'--C---D (==I')
|                      /           /
|     ----o---o---o---L---o---o---L'
| 
|     Note that your 'x86' is at Z and Ingo's tip is now at D.
| 
|  (4) You rebase on top of Ingo's updated tip.
| 
|                                                 X'--Y'--Z'
|                                                /
|                       A---B (==I) A'--B'--C---D (==I')
|                      /           /
|     ----o---o---o---L---o---o---L'
| 
| 
| I was told that our user manual is very good these days covering
| both workflows based on merges and workflows based on rebases.
| You may want to check it and also git-rebase(1).
|

thanks Junio, and sorry for git@ list being dropped from CC.
(didn't read this message in details) so i'll write you/git-list ASAP.
Thanks a lot!

		- Cyrill -
