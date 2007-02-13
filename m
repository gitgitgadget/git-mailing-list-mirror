From: Jeff King <peff@peff.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 00:18:16 -0500
Message-ID: <20070213051816.GB328@coredump.intra.peff.net>
References: <45CFA30C.6030202@verizon.net> <20070212042425.GB18010@thunk.org> <Pine.LNX.4.64.0702120839490.8424@woody.linux-foundation.org> <7vps8f6l81.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702130020450.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vfy9b6iyt.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702130046450.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45D10D86.3030508@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 06:18:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGq3a-0005xZ-4N
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 06:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161065AbXBMFST (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 00:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161066AbXBMFST
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 00:18:19 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3052 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161065AbXBMFSS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 00:18:18 -0500
Received: (qmail 31824 invoked from network); 13 Feb 2007 00:18:23 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 13 Feb 2007 00:18:23 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Feb 2007 00:18:16 -0500
Content-Disposition: inline
In-Reply-To: <45D10D86.3030508@verizon.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39492>

On Mon, Feb 12, 2007 at 07:59:50PM -0500, Mark Levedahl wrote:

> fail to set the correct file type somewhere. Current cvsnt is fairly 
> good at autodetecting and setting text vs binary file type, and enforces 
> this across all platforms, so things don't go awry too often. It is in 

There is obviously much sentiment that this should _not_ be the default
(and I agree). But if arbitrary filters are possible, then you can
theoretically write an 'autocrlf' filter which will try to do the right
thing, and you could set it for some or all files:

  echo '*: autocrlf' >.gitattributes

but it would be off by default. If we implement this, everyone has to
"pay" for .gitattributes (even if you don't use it, we have to look it
up to make sure you're not using it!), but nobody has to pay for any
filters they don't use.

-Peff
