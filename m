From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/git-diff: remove -r from --name-status
	example
Date: Sun, 29 Jul 2007 00:56:46 -0400
Message-ID: <20070729045646.GB6858@coredump.intra.peff.net>
References: <20070729002427.GA1566@coredump.intra.peff.net> <alpine.LFD.0.999.0707281905050.3442@woody.linux-foundation.org> <20070729041159.GA5544@coredump.intra.peff.net> <alpine.LFD.0.999.0707282119010.3442@woody.linux-foundation.org> <7vbqdvolww.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 06:56:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF0pn-0004N3-NB
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 06:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbXG2E4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 00:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbXG2E4t
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 00:56:49 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4997 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbXG2E4s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 00:56:48 -0400
Received: (qmail 23829 invoked from network); 29 Jul 2007 04:56:48 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 29 Jul 2007 04:56:48 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Jul 2007 00:56:46 -0400
Content-Disposition: inline
In-Reply-To: <7vbqdvolww.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54082>

On Sat, Jul 28, 2007 at 09:48:15PM -0700, Junio C Hamano wrote:

> However, I think Jeff's patch always makes it recursive even
> when the user asks for --raw, which makes it inappropriate for
> inclusion whether before or after 1.5.3.

Right, that's the point. git-diff is currently inconsistent (unless you
understand that index comparisons are always recursed, and tree
comparisons need it explicitly -- but part of the point of git-diff is
to abstract those sorts of details), so this attempts to harmonize the
behavior no matter what you're diffing (whether it be --name-status or
--raw).

If you really want not to recurse, then you have to know you are
comparing trees anyway, at which point it makes sense to use the
git-diff-tree plumbing.

-Peff
