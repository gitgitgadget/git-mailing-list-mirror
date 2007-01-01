From: Junio C Hamano <junkio@cox.net>
Subject: Re: i18n, alternative solution
Date: Mon, 01 Jan 2007 11:44:15 -0800
Message-ID: <7vy7om7cs0.fsf@assigned-by-dhcp.cox.net>
References: <200701011547.48697.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 01 20:44:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1T5K-0002Z5-Hl
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 20:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbXAAToW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 14:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753712AbXAAToW
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 14:44:22 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:54005 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609AbXAAToW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 14:44:22 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070101194421.BMKO97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Mon, 1 Jan 2007 14:44:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5vja1W00G1kojtg0000000; Mon, 01 Jan 2007 14:43:34 -0500
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
In-Reply-To: <200701011547.48697.robin.rosenberg.lists@dewire.com> (Robin
	Rosenberg's message of "Mon, 1 Jan 2007 15:47:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35739>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> What disturbes me is the complexity that the approach of storing multiple 
> encodings in the same repository results in.

We are not encouraging mixed encodings, mind you.

Even though we check and warn comits that do not have a valid
UTF-8 string, the users can make mistakes and people need be
able to look at them later.  That is what we are solving.  

At the same time we do NOT force inconvenience on projects that
want to use legacy encoding for whatever reason.  The world is
not UTF-8 only, and encoding to UTF-8 is non-reversible a times
(positive return value from iconv(3)).  Always re-coding to
UTF-8 will NOT be accepted to git for now.  We can revisit this
perhaps in 5 years.
