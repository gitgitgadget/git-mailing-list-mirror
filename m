From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] builtin-blame: Reencode commit messages according
	to git-log rules.
Date: Wed, 22 Oct 2008 16:40:31 -0400
Message-ID: <20081022204030.GB4585@coredump.intra.peff.net>
References: <1224622557-6669-1-git-send-email-angavrilov@gmail.com> <20081022082016.GA18473@sigill.intra.peff.net> <7vd4hsv46z.fsf@gitster.siamese.dyndns.org> <20081022191415.GA31568@coredump.intra.peff.net> <20081022192253.GC31568@coredump.intra.peff.net> <alpine.DEB.1.00.0810222220410.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 22 22:42:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KskWe-0003t0-2z
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 22:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756598AbYJVUke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 16:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756182AbYJVUke
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 16:40:34 -0400
Received: from peff.net ([208.65.91.99]:1297 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755918AbYJVUkd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 16:40:33 -0400
Received: (qmail 4344 invoked by uid 111); 22 Oct 2008 20:40:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 22 Oct 2008 16:40:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Oct 2008 16:40:31 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810222220410.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98907>

On Wed, Oct 22, 2008 at 10:29:39PM +0200, Johannes Schindelin wrote:

> > Not all greps support "-e", but in this case we can easily
> > convert it to a single extended regex.
> 
> I really wonder if we cannot catch these things (unportable grep, sed, etc 
> invokations) with a simple patch to the pre-commit hook.

We could probably write a hook for some of the simpler ones, but we
would have quite a few false negatives, I suspect.

FWIW, I am not finding these portability problems by hand. I am nightly
auto-building and testing Junio's maint, master, and next on Solaris 8
and FreeBSD, and Mike Ralphson is doing the same for AIX. So while we
could perhaps catch them sooner, I am very happy to have caught several
issues recently in next, _before_ they hit master.

-Peff
