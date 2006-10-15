From: Junio C Hamano <junkio@cox.net>
Subject: Re: Recent and near future backward incompatibilities
Date: Sun, 15 Oct 2006 11:14:03 -0700
Message-ID: <7v64elzbtg.fsf@assigned-by-dhcp.cox.net>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610151133450.17085@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Stephen Hemminger <shemminger@osdl.org>
X-From: git-owner@vger.kernel.org Sun Oct 15 20:14:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZAUy-0004Bg-PM
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 20:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422680AbWJOSOF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 14:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422678AbWJOSOF
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 14:14:05 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:26331 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1422680AbWJOSOE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 14:14:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061015181404.EMHR18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Oct 2006 14:14:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aiE61V01L1kojtg0000000
	Sun, 15 Oct 2006 14:14:07 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0610151133450.17085@xanadu.home> (Nicolas Pitre's
	message of "Sun, 15 Oct 2006 11:34:20 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28922>

Nicolas Pitre <nico@cam.org> writes:

> Actually it doesn't have to be that expensive to convert deltas v2 to 
> deltas v3 on the fly.  They can be inflated, parsed, the copy ops that 
> exceed 0x10000 converted into multiple ops of smaller copy blocks, then 
> deflated.  This is certainly much less costly than rematching deltas 
> from scratch.

True, when I think about it.

>>  - we need to add .git/config item that tells pack-objects to
>>    never generate version 3 delta for that particular
>>    repository.  This is similar to the way we would need to
>>    control the use of delta-base-offset representation currently
>>    cooking in "next".
>
> This is different. The delta-base-offset representation is decided at 
> run time every time a pack is generated and regardless if delta data is 
> being reused from another pack or regenerated afresh, and so with no 
> cost.  So this is no issue for users of old GIT versions since the 
> native GIT protocol already handle it in a backward compatible manner.
>
> The only issue here concerns users that don't use the native GIT 
> protocol.  But in this case they have two options: either they switch to 
> the native protocol, or they upgrade to the latest GIT version which 
> can always be pulled with the native GIT protocol.

True again.  Thanks.
