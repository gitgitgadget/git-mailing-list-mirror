From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-repack: create new packs inside $PACKDIR, not cwd
Date: Mon, 04 Sep 2006 13:16:34 -0700
Message-ID: <7vslj7mlp9.fsf@assigned-by-dhcp.cox.net>
References: <11573485523752-git-send-email-martin@catalyst.net.nz>
	<20060904090833.GF17042@admingilde.org>
	<7vveo4nfbg.fsf@assigned-by-dhcp.cox.net>
	<7vr6ysneor.fsf@assigned-by-dhcp.cox.net>
	<44FBF9E0.9050800@catalyst.net.nz>
	<7vlkp0ndmj.fsf@assigned-by-dhcp.cox.net>
	<44FC041F.6010002@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 22:16:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKKrl-0001u0-FX
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 22:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbWIDUQO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 16:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWIDUQO
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 16:16:14 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:28632 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S965031AbWIDUQN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 16:16:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060904201613.CASV6711.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Mon, 4 Sep 2006 16:16:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JLG51V00P1kojtg0000000
	Mon, 04 Sep 2006 16:16:07 -0400
To: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
In-Reply-To: <44FC041F.6010002@catalyst.net.nz> (Martin Langhoff's message of
	"Mon, 04 Sep 2006 22:46:55 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26433>

"Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz> writes:

> Ah, ok. I misunderstood the use of trap -- of course, re-reading the
> man pages, it makes sense.

However the more I think about it your original idea of using
.tmp-pack directly in .git/objects/pack/ *should* have worked
(modulo two repack instances using the same name, which is fixed
by $$ there).  Not insisting on "pack-" prefix I consider is a
feature, but I do not see a reason to take a file that begin
with a dot.

Well, probably too late to deprecate, maybe not.  I dunno.
