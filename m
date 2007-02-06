From: Junio C Hamano <junkio@cox.net>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Mon, 05 Feb 2007 23:46:19 -0800
Message-ID: <7vy7nbiv90.fsf@assigned-by-dhcp.cox.net>
References: <87odognuhl.wl%cworth@cworth.org>
	<87y7nbdeaw.wl%cworth@cworth.org>
	<20070206072820.GC23866@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 06 08:46:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEL27-0003Wy-KW
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 08:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbXBFHqV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 02:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbXBFHqU
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 02:46:20 -0500
Received: from fed1rmmtai19.cox.net ([68.230.241.40]:42994 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750922AbXBFHqU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 02:46:20 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070206074620.DLYQ1349.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 6 Feb 2007 02:46:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id L7mK1W00G1kojtg0000000; Tue, 06 Feb 2007 02:46:19 -0500
In-Reply-To: <20070206072820.GC23866@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 6 Feb 2007 02:28:20 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38819>

Jeff King <peff@peff.net> writes:

> sha1_name: match refs in 'refs/remotes/*/%s'
>
> If no other matches are found for a ref, then look for it in every defined
> remote. This will not complain of ambiguity, since we only do the lookup if
> no other ref matches.

I think the abstraction is wrong -- why do you even need to
iterate over .git/remotes (and .git/config remote.*) when the
only thing this cares about is refs under refs/remotes/*
hierarchy?

Or am I missing something blatantly obvious?
