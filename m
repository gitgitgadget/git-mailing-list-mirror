From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach filter-branch about subdirectory filtering
Date: Thu, 07 Jun 2007 17:57:33 -0700
Message-ID: <7vzm3bmfeq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706080130000.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 02:57:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwSnP-00047I-07
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 02:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbXFHA5f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 20:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759797AbXFHA5f
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 20:57:35 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:47122 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438AbXFHA5e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 20:57:34 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070608005734.NIGQ12556.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 7 Jun 2007 20:57:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8oxZ1X00E1kojtg0000000; Thu, 07 Jun 2007 20:57:33 -0400
In-Reply-To: <Pine.LNX.4.64.0706080130000.4046@racer.site> (Johannes
	Schindelin's message of "Fri, 8 Jun 2007 01:30:35 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49422>

Good thing you folded git-split into this, which is an obviously
right thing to do.

But it makes me wonder, if it is common to want to split a
combined project into two (or more) sets, taking more than one
directories at a time.  Contents of directory A and B (without
hoisting them up) are filtered into one history and remaining
bits (again without hoisting them up) are filtered into another.

I do not think that is common, and you can easily do that with
the index filter, I think, so it probably is pointless to make
this new filter to try supporting that mode of operation.

We might however want to make sure that we detect an attempt to
give more than one --subdirectory-filter parameter.
