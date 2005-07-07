From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Thu, 07 Jul 2005 15:10:01 -0700
Message-ID: <7vslyqp8sm.fsf@assigned-by-dhcp.cox.net>
References: <20050703234629.GF13848@pasky.ji.cz>
	<42CBC822.30701@didntduck.org> <20050707144501.GG19781@pasky.ji.cz>
	<7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
	<7vbr5ejso2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071456570.25104@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 00:15:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqeey-0005Go-Pg
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 00:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVGGWNy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 18:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVGGWLI
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 18:11:08 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:52976 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262074AbVGGWKD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2005 18:10:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050707221000.GOGR1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 7 Jul 2005 18:10:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507071456570.25104@g5.osdl.org> (Linus Torvalds's message of "Thu, 7 Jul 2005 14:58:56 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

>> (2) When "showing --objects", it lists the top-level tree node
>> with no name, which makes it indistinguishable from commit
>> objects by pack-objects, probably impacting the delta logic.
>> Would something like the following patch make sense, to name
>> such node "."; giving full-path not just the basename to
>> all named nodes would be even better, though.

LT> It doesn't impact the delta algorithm, because the objects are sorted by 
LT> type first, so it never mixes up trees and commits.

You are correct.  I forgot that it does sorting by type.

What do you think about giving full-path so that Makefiles in
different directories would get different name hashes?
