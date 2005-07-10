From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rev-list: add "--full-objects" flag.
Date: Sat, 09 Jul 2005 23:28:36 -0700
Message-ID: <7veka7uqcr.fsf@assigned-by-dhcp.cox.net>
References: <20050703234629.GF13848@pasky.ji.cz>
	<42CBC822.30701@didntduck.org> <20050707144501.GG19781@pasky.ji.cz>
	<7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
	<20050707221443.GB7151@pasky.ji.cz>
	<Pine.LNX.4.58.0507071549330.25104@g5.osdl.org>
	<7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net>
	<7vfyuqfa6r.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071657140.25104@g5.osdl.org>
	<7vvf3mds9c.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071841010.25104@g5.osdl.org>
	<7vy88ica8e.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071928220.25104@g5.osdl.org>
	<m1pstrr8k1.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507092206480.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 08:28:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrVJ5-0000mL-4I
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 08:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVGJG2j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 02:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVGJG2j
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 02:28:39 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:52463 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261856AbVGJG2i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 02:28:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050710062836.FSFO8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 10 Jul 2005 02:28:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507092206480.17536@g5.osdl.org> (Linus Torvalds's message of "Sat, 9 Jul 2005 22:11:07 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
>> On Sat, 9 Jul 2005, Eric W. Biederman wrote:
>> I assume the commit graph information will be fairly modest.

That is true.  My experience from the one I have been cooking,
Gitified 2.4.0->2.6.12-rc2 BKCVS export results in a bit shy of
600KB commit ancestry information.  The full development trail
for that repository contains 370152 objects among which 28237
are commits; when packed into one pack-idx pair, it is around
a 170MB .pack with a 9MB .idx file.

LT> But a _truly_ dumb server (ie one with no CGI at all, just "raw data", you
LT> really end up with just effectively rsyncing it. Yes, you could create a
LT> new "commit index file" every time you push, and maybe it's worth it, but 
LT> on the other hand, what's wrong with just rsyncing it all and parsing it 
LT> locally instead?

Nothing, and you convinced me to drop the one I have been
cooking.  Maybe its time to either change git-fetch-script to
use wget -r for http transport for objects part, perhaps?
