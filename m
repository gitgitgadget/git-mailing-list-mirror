From: Junio C Hamano <junkio@cox.net>
Subject: Re: "make test" fails with current HEAD
Date: Fri, 18 Nov 2005 11:13:09 -0800
Message-ID: <7vveypkbwa.fsf@assigned-by-dhcp.cox.net>
References: <pan.2005.11.17.15.31.56.755022@smurf.noris.de>
	<7v7jb6o1kl.fsf@assigned-by-dhcp.cox.net>
	<20051118075117.GK31613@kiste.smurf.noris.de>
	<7vbr0imlha.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511180812200.13959@g5.osdl.org>
	<7vwtj5lvvc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 20:13:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdBff-0007ZK-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 20:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVKRTNM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 14:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVKRTNM
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 14:13:12 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:20115 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750734AbVKRTNL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 14:13:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118191156.WOVU17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 14:11:56 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vwtj5lvvc.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 18 Nov 2005 09:16:23 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12248>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> Umm.. Why not just say "if the line after the 'diff' line doesn't start 
>> with '@@ ', then it's a binary diff"?
>
> Thanks, that makes sense.

Maybe not; parse_single_patch would have eaten '@@ -' lines so
in practice that amounts to not checking anything at all.

Which is not a bad idea, though...  That means we would treat
all empty patches as binary diffs, which is certainly simple,
but is it safe enough?
