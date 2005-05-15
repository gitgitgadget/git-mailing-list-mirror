From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] Ignore rules
Date: Sat, 14 May 2005 23:52:06 -0700
Message-ID: <7vll6hugkp.fsf@assigned-by-dhcp.cox.net>
References: <4283CAF8.3050304@dgreaves.com>
	<20050513231229.GI32232@pasky.ji.cz> <4285B6A8.4080309@dgreaves.com>
	<7vy8ai2nb6.fsf@assigned-by-dhcp.cox.net>
	<20050514142421.GG3905@pasky.ji.cz> <42861584.6020601@dgreaves.com>
	<20050514153027.GN3905@pasky.ji.cz>
	<7vsm0py8vz.fsf@assigned-by-dhcp.cox.net>
	<2cfc4032050514181127c02e43@mail.gmail.com>
	<7v4qd5vxao.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, David Greaves <david@dgreaves.com>,
	torvalds@osdl.org, GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 15 08:52:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXCz0-000282-BV
	for gcvg-git@gmane.org; Sun, 15 May 2005 08:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVEOGwL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 02:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVEOGwL
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 02:52:11 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:57814 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261537AbVEOGwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 02:52:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050515065206.WFCW8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 May 2005 02:52:06 -0400
To: jon@blackcubes.dyndns.org
In-Reply-To: <7v4qd5vxao.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 14 May 2005 23:05:35 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

JCH> ...  For example, in linux-2.6 git tree, you _ought_ to be
JCH> able to say something like this:

JCH>     cd fs
JCH>     find ext? ../include/linux -type f -print0 |
JCH>     git-path-helper -z |
JCH>     xargs -r -0 git-update-cache --add --

The above example has an obvious thinko/typo.  It should have
been like this:

     cd fs
     find ext? ../include/linux -type f -print0 |
     git-path-helper -z | {
         cd .. && xargs -r -0 git-update-cache --add --
     }

