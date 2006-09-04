From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-repack: create new packs inside $PACKDIR, not cwd
Date: Mon, 04 Sep 2006 03:13:24 -0700
Message-ID: <7vlkp0ndmj.fsf@assigned-by-dhcp.cox.net>
References: <11573485523752-git-send-email-martin@catalyst.net.nz>
	<20060904090833.GF17042@admingilde.org>
	<7vveo4nfbg.fsf@assigned-by-dhcp.cox.net>
	<7vr6ysneor.fsf@assigned-by-dhcp.cox.net>
	<44FBF9E0.9050800@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 12:13:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKBS5-0006bv-LH
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 12:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWIDKNK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 06:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWIDKNJ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 06:13:09 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:17024 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751342AbWIDKNF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 06:13:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060904101305.PSPM4015.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Mon, 4 Sep 2006 06:13:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JAD51V00J1kojtg0000000
	Mon, 04 Sep 2006 06:13:06 -0400
To: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
In-Reply-To: <44FBF9E0.9050800@catalyst.net.nz> (Martin Langhoff's message of
	"Mon, 04 Sep 2006 22:03:12 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26413>

"Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz> writes:

> BTW, I think there's a small error.
>
> Your packtmp includes $$ which means that rm -f "$PACKTMP" will only
> clear out old packs..

That was deliberate.  I hate programs that clean things up
behind user's back.  The first "rm" is to get rid of what would
collide with what we are going to do (i.e. protecting ourselves)
and "trap rm" is to make sure we do not leave the cruft we know
we are going to create.  I'd rather leave other people's cruft
around, unless the purpose of the command is to clean things up,
and repack is hardly that.





-- 
VGER BF report: H 0.149712
