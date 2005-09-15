From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tool renames.
Date: Thu, 15 Sep 2005 01:52:19 -0700
Message-ID: <7vr7bq4ssc.fsf@assigned-by-dhcp.cox.net>
References: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl>
	<Pine.LNX.4.58.0509050738340.3504@evo.osdl.org>
	<46a038f90509051713389c62c8@mail.gmail.com>
	<Pine.LNX.4.58.0509060013520.4316@evo.osdl.org>
	<7vll2atz8a.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509060057491.4316@evo.osdl.org>
	<7vwtlusi9t.fsf@assigned-by-dhcp.cox.net>
	<u5tek82bmlb.fsf@fidgit.hq.vtech>
	<7v1x41g3c6.fsf@assigned-by-dhcp.cox.net>
	<7vfysg2wvo.fsf_-_@assigned-by-dhcp.cox.net>
	<43290D0F.9060408@zytor.com> <7vr7bqahb8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davidk@lysator.liu.se,
	Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 10:54:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFpUA-0007Af-WD
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 10:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVIOIwW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 04:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVIOIwW
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 04:52:22 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:59874 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932251AbVIOIwV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 04:52:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050915085220.RPVR3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Sep 2005 04:52:20 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <7vr7bqahb8.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 15 Sep 2005 01:03:39 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8598>

Junio C Hamano <junkio@cox.net> writes:

> "H. Peter Anvin" <hpa@zytor.com> writes:
>
>> I noticed you also renamed git-ssh-{push,pull}.  These tools rely on 
>> having the same names on both sides, so you have introduced a major 
>> version skew problem.
>
> True.  It seems that both myself and Daniel did not think that
> would be a major problem when we were discussing the tool
> renames.
>
> As a workaround, you could always say GIT_SSH_PULL='blah' and
> GIT_SSH_PUSH='bah' when you run either side to name what will be
> run on the other end.

Come to think of it, I should be able to build git-ssh-push and
git-ssh-pull as fully backward compatible way to call the
counterpart with original name, instead of supplying just
symlinks the same way I do currently.  Let me work do that
before I do 0.99.7 this weekend.

> Now the interesting problem is if we should rename these
> environment variables ...

And the old and new binaries will be built separately anyway, I
could use GIT_SSH_FETCH and GIT_SSH_UPLOAD in the newname
binaries while keeping the old names in oldname binaries.  Ack?
