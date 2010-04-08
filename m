From: Jeff King <peff@peff.net>
Subject: Re: Re*: Extremely slow progress during 'git reflog expire --all'
Date: Thu, 8 Apr 2010 02:52:21 -0400
Message-ID: <20100408065221.GF30473@coredump.intra.peff.net>
References: <201004022154.14793.elendil@planet.nl>
 <201004022350.20999.elendil@planet.nl>
 <20100402224100.GA997@coredump.intra.peff.net>
 <201004031629.01970.elendil@planet.nl>
 <20100403203507.GA12262@coredump.intra.peff.net>
 <7vy6h36pt1.fsf@alter.siamese.dyndns.org>
 <20100405062621.GA30934@coredump.intra.peff.net>
 <7v1vetpw63.fsf@alter.siamese.dyndns.org>
 <20100406060217.GF3901@coredump.intra.peff.net>
 <7vochvcdkc.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Frans Pop <elendil@planet.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 08:52:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzlbb-0001UH-3y
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 08:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758384Ab0DHGwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 02:52:42 -0400
Received: from peff.net ([208.65.91.99]:44515 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758285Ab0DHGwl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 02:52:41 -0400
Received: (qmail 16963 invoked by uid 107); 8 Apr 2010 06:52:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 08 Apr 2010 02:52:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Apr 2010 02:52:21 -0400
Content-Disposition: inline
In-Reply-To: <7vochvcdkc.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144333>

On Wed, Apr 07, 2010 at 11:39:15AM -0700, Junio C Hamano wrote:

> Actually I do; I think it breaks correctness a big way (the second
> paragraph of the proposed log message of the following).
> [...]
> However, it is a different matter if a commit is _not_ known to be
> reachable and the commit is known to be unreachable.  Because you can
> rewind a ref to an ancient commit and then reset it back to the original
> tip, a recent reflog entry can point at a commit that older than the
> expire-total timestamp and we shouldn't expire it.  For that reason, we
> had to run merge-base computation when a commit is _not_ known to be
> reachable.

Oh, right. Didn't I even mention that case earlier in the thread? I was
just being dumb. Or maybe I was pretending to be dumb, so that I could
trick you into writing the patch. Who knows?

> [patch]

Patch looked fine from my reading. I no longer have Frans' gigantic test
repo available, though, so I can't test whether it fixes the problem
(but I'm pretty sure it must from my earlier analysis).

-Peff
