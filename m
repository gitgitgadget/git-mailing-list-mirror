From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fixup no-progress for fetch & clone
Date: Sat, 24 Feb 2007 00:14:45 -0800
Message-ID: <7v7iu80y6i.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702232002480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfy8w3add.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702240217550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<alpine.LRH.0.82.0702232046300.29426@xanadu.home>
	<Pine.LNX.4.63.0702240314250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<alpine.LRH.0.82.0702232123110.29426@xanadu.home>
	<Pine.LNX.4.63.0702240336130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<alpine.LRH.0.82.0702232141040.29426@xanadu.home>
	<7vbqjk17a8.fsf@assigned-by-dhcp.cox.net>
	<alpine.LRH.0.82.0702240005270.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Feb 24 09:15:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKs3b-0004Gp-Ko
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 09:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933430AbXBXIOs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Feb 2007 03:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933433AbXBXIOs
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 03:14:48 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:46735 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933430AbXBXIOr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Feb 2007 03:14:47 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070224081447.VYKL6078.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 24 Feb 2007 03:14:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TLEm1W0011kojtg0000000; Sat, 24 Feb 2007 03:14:46 -0500
In-Reply-To: <alpine.LRH.0.82.0702240005270.29426@xanadu.home> (Nicolas
	Pitre's message of "Sat, 24 Feb 2007 00:14:55 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40505>

Nicolas Pitre <nico@cam.org> writes:

> And how would the remote end distinguish how to split the info from the 
> progress noise?  Teaching pack-object about another file descriptor?
> And what happen if pack-object is run locally in that case?

That's true, and your convention to classify line with "\r"
noise and others as info is as good as anything, and does not
break any existing system, so it is very good one.

> How does that solve the issue with servers (currently all of them) that 
> don't know about the new sideband?

I actually happen to consider that a non problem.

It is true that you can only prepare the client and server side
by 1.5.1, and new clients talking to 1.5.0 or older servers
would not be able to squelch the noise.  But that is _not_ a new
problem anyway, and given time the server side will eventually
be updated to 1.5.1 or later.  If anything else, it would give
incentive to people to upgrade their servers to 1.5.1 ;-)
