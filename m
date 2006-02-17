From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: reuse data from existing pack.
Date: Fri, 17 Feb 2006 10:18:31 -0800
Message-ID: <7v3bih4zns.fsf@assigned-by-dhcp.cox.net>
References: <7vd5hpm2x0.fsf@assigned-by-dhcp.cox.net>
	<7vbqx8m62q.fsf@assigned-by-dhcp.cox.net>
	<7vu0ay8v4f.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602170738390.916@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 19:18:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAABh-0004Uc-Fg
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 19:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWBQSSf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 13:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWBQSSe
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 13:18:34 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:59893 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750820AbWBQSSe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 13:18:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060217181722.WILF15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 17 Feb 2006 13:17:22 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602170738390.916@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 17 Feb 2006 07:39:14 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16361>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 16 Feb 2006, Junio C Hamano wrote:
>> 
>> This one has one nasty data corruption bug, which fortunately I
>> think I have figured out how to fix.
>
> Circular deltas? What else can go wrong?

Circular deltas are prevented by not using deltified objects
check_object() decides to keep in find_deltas(), so I do not
think it is an issue.
