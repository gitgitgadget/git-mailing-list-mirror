From: Jeff King <peff@peff.net>
Subject: Re: Why does send-pack call pack-objects for all remote refs?
Date: Mon, 7 Dec 2015 17:57:14 -0500
Message-ID: <20151207225714.GA3785@sigill.intra.peff.net>
References: <4766c8518c2a46afb88fc0a2dd9a1688@EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com>
 <xmqqvb89lw5f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Daniel Koverman <dkoverman@predictiveTechnologies.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 23:57:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a64if-0005IY-7Y
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 23:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756273AbbLGW5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 17:57:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:38612 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756066AbbLGW5R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 17:57:17 -0500
Received: (qmail 24207 invoked by uid 102); 7 Dec 2015 22:57:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 16:57:16 -0600
Received: (qmail 24785 invoked by uid 107); 7 Dec 2015 22:57:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 17:57:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Dec 2015 17:57:14 -0500
Content-Disposition: inline
In-Reply-To: <xmqqvb89lw5f.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282139>

On Mon, Dec 07, 2015 at 02:41:00PM -0800, Junio C Hamano wrote:

> Also it was unclear if you are working with a shallow repository.
> The performance trade-off made between the packsize and the cycles
> is somewhat different between a normal and a shallow repository,
> e.g. 2dacf26d (pack-objects: use --objects-edge-aggressive for
> shallow repos, 2014-12-24) might be a good starting point to think
> about this issue.

Also note that for a while the "aggressive" form was used everywhere. I
think that started in fbd4a70 (list-objects: mark more commits as edges
in mark_edges_uninteresting - 2013-08-16), and was fixed in 1684c1b
(rev-list: add an option to mark fewer edges as uninteresting,
2014-12-24).

So it was present from v1.8.4.2 up to v2.3.0.

-Peff
