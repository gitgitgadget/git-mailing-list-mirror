From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK) v2 4/4] gitk: Implement batch lookup and caching of encoding attrs.
Date: Sat, 11 Oct 2008 23:03:34 +1100
Message-ID: <18672.38422.200764.101389@cargo.ozlabs.ibm.com>
References: <1222772422-28020-1-git-send-email-angavrilov@gmail.com>
	<bb6f213e0810100522v653507d6r75cc4c64b57aa459@mail.gmail.com>
	<18671.62417.328489.317909@cargo.ozlabs.ibm.com>
	<200810111328.50951.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Johannes Sixt" <johannes.sixt@telecom.at>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 14:04:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KodDI-0002dX-49
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 14:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbYJKMDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 08:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbYJKMDk
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 08:03:40 -0400
Received: from ozlabs.org ([203.10.76.45]:39135 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433AbYJKMDj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 08:03:39 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 34BEADDDFA; Sat, 11 Oct 2008 23:03:38 +1100 (EST)
In-Reply-To: <200810111328.50951.angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97977>

Alexander Gavrilov writes:

> > And if [tcl_encoding] is slow, then it should have a cache.  There's
> > only likely to be at most 2 or 3 values it gets called for, and it's
> > a constant function.
> 
> In git-gui the slowdown appeared during the construction of the menu
> listing all available encodings, so a simple cache would not have helped. 
> I  reimplemented it using a lookup table to resolve aliases (constructed
> on the first run). But it can be thought of as a precalculated cache.

Hmmm, one that uses more time and memory than it needs to for gitk's
use...  I guess it's not a lot, but it still seems unnecessary, unless
you can see a need for a menu of encodings in gitk.

> > At this point, what I think I might do is apply your set of patches
> > (but with 2/4 and 3/4 folded into a single patch) and then go through
> > and do another commit that addresses the concerns I've raised.  OK?
> 
> Maybe I should resend the patches, scrapping path_encoding_cache,
> and adding the optimized version of tcl_encoding?

OK.

Paul.
