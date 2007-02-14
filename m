From: Junio C Hamano <junkio@cox.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 21:16:57 -0800
Message-ID: <7v8xf1uxme.fsf@assigned-by-dhcp.cox.net>
References: <45CFA30C.6030202@verizon.net>
	<200702130932.51601.litvinov2004@gmail.com>
	<Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
	<Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
	<7v7iumx7hu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 06:17:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHCVz-0004mA-Ae
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 06:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbXBNFQ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 00:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbXBNFQ7
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 00:16:59 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:50426 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbXBNFQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 00:16:58 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214051658.GAVI4586.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 14 Feb 2007 00:16:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PHGx1W00C1kojtg0000000; Wed, 14 Feb 2007 00:16:58 -0500
In-Reply-To: <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 13 Feb 2007 11:07:23 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39615>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> NOTE NOTE NOTE! The "is_binary()" heuristics are totally made-up by yours 
> truly. I will not guarantee that they work at all reasonable. Caveat 
> emptor. But it _is_ simple, and it _is_ safe, since it's all off by 
> default.

It might be safe for some definition of safe, but it is very
Asian unfriendly.

I'd probably suggest replacing it with what GNU diff uses, which
we stolen and implemented in diff.c::mmfile_is_binary().
