From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 20:46:55 -0700
Message-ID: <7vac3tx900.fsf@assigned-by-dhcp.cox.net>
References: <20061018053647.GA3507@coredump.intra.peff.net>
	<Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
	<20061018185225.GU20017@pasky.or.cz>
	<20061018185907.GV20017@pasky.or.cz>
	<7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610181510510.1971@xanadu.home>
	<20061018191834.GA18829@spearce.org>
	<Pine.LNX.4.64.0610181525410.1971@xanadu.home>
	<20061018204626.GA19194@spearce.org>
	<Pine.LNX.4.64.0610181358200.3962@g5.osdl.org>
	<20061018214143.GF19194@spearce.org>
	<7vwt6xxofi.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610181542160.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610181910440.1971@xanadu.home>
	<Pine.LNX.4.64.0610181655430.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 05:47:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaOs4-0001iH-2o
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 05:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423247AbWJSDq6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 23:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423245AbWJSDq6
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 23:46:58 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:23745 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1423248AbWJSDq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 23:46:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061019034656.YEIT18180.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Wed, 18 Oct 2006 23:46:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id c3mi1V00V1kojtg0000000
	Wed, 18 Oct 2006 23:46:43 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610181655430.3962@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 18 Oct 2006 17:07:57 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29317>

Linus Torvalds <torvalds@osdl.org> writes:

> Actually, I've hit an impasse.
>
> So there's _another_ way of fixing a thin pack: it's to expand the objects 
> without a base into non-delta objects, and keeping the number of objects 
> in the pack the same. But _again_, we don't actually know which ones to 
> expand until it's too late.

pack-objects.c::write_one() makes sure that we write out base
immediately after delta if we haven't written out its base yet,
so I suspect if you buffer one delta you should be Ok, no?
