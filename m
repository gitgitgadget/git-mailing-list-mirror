From: Dan Zwell <dzwell@zwell.net>
Subject: [PATCH 0/5] Colors for git-add--interactive
Date: Thu, 22 Nov 2007 04:54:37 -0600
Message-ID: <20071122045437.46ee4638@paradox.zwell.net>
References: <47112491.8070309@gmail.com>
	<20071015034338.GA4844@coredump.intra.peff.net>
	<20071016194709.3c1cb3a8@danzwell.com>
	<20071017015152.GN13801@spearce.org>
	<20071022164048.71a3dceb@danzwell.com>
	<20071023042702.GB28312@coredump.intra.peff.net>
	<20071023035221.66ea537f@danzwell.com>
	<20071102224100.71665182@paradox.zwell.net>
	<20071104045735.GA12359@segfault.peff.net>
	<7v640ivagv.fsf@gitster.siamese.dyndns.org>
	<20071104054305.GA13929@sigill.intra.peff.net>
	<20071110180109.34febc3f@paradox.zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 17:26:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvEt0-000592-Ox
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 17:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbXKVQ0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 11:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbXKVQ0X
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 11:26:23 -0500
Received: from gateway04.websitewelcome.com ([69.93.154.2]:50322 "HELO
	gateway04.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751053AbXKVQ0W (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 11:26:22 -0500
X-Greylist: delayed 19877 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Nov 2007 11:26:21 EST
Received: (qmail 12685 invoked from network); 22 Nov 2007 10:55:26 -0000
Received: from gator290.hostgator.com (74.53.26.226)
  by gateway04.websitewelcome.com with SMTP; 22 Nov 2007 10:55:26 -0000
Received: from [143.44.70.185] (port=40107 helo=paradox.zwell.net)
	by gator290.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <dzwell@zwell.net>)
	id 1Iv9hx-0006fx-UB; Thu, 22 Nov 2007 04:54:58 -0600
In-Reply-To: <20071110180109.34febc3f@paradox.zwell.net>
X-Mailer: Claws Mail 3.0.2 (GTK+ 2.12.1; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator290.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - zwell.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65830>

There are several changes since the last iteration of the
"colors for git-add--interactive" patch set:

- Added parentheses around arguments to all user-defined functions.
- Reading the configuration is done in a more organized, robust, and
cleaner way.
- Fixed bug where color keys could inappropriately match ("colored"
should not match "red", for example).
- Users can now set a particular color key to the empty string, and
this is equivalent to setting it to "normal". (This is the behavior
exhibited by git-diff.)
- Color configuration information is case insensitive.
- Added warnings when color configuration keys contain invalid tokens.
- Refactored a few variables for stylistic reasons.


Issues:

- Does not always properly color the output of git-diff --cc, because
  the diff-coloring regular expressions do not match every diff line.
  I'm not sure that git-add--interactive normally gets used in the same
situations as git-diff --cc. They don't seem to work well, together,
from the little that I tested (without the color patches applied).
There are a few solutions, but I haven't thought of one that's both
reliable and clean. My impression is that diff --cc is called any time
that HEAD has two parents. Is this correct?

Dan
