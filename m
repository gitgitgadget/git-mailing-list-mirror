From: Jeff King <peff@peff.net>
Subject: Re: `git-send-email' doesn't specify `Content-Type'
Date: Sun, 11 Nov 2007 03:35:26 -0500
Message-ID: <20071111083525.GB30299@sigill.intra.peff.net>
References: <87ode3klc7.fsf@chbouib.org> <Pine.LNX.4.64.0711100052290.4362@racer.site> <20071110101420.GA21353@bulgaria> <20071110122528.GA4977@atjola.homenet> <20071110123505.GA24445@bulgaria> <20071110125126.GA7261@atjola.homenet> <20071111083224.GA30299@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Swetland <swetland@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ludovic =?iso-8859-1?Q?Court=E8s?= <ludo@chbouib.org>,
	git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 09:35:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir8IH-0004yd-J8
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 09:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880AbXKKIfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 03:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756674AbXKKIfa
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 03:35:30 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1276 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754880AbXKKIf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 03:35:29 -0500
Received: (qmail 30140 invoked by uid 111); 11 Nov 2007 08:35:27 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 11 Nov 2007 03:35:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2007 03:35:26 -0500
Content-Disposition: inline
In-Reply-To: <20071111083224.GA30299@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64428>

On Sun, Nov 11, 2007 at 03:32:24AM -0500, Jeff King wrote:

> -	return "$_";
> +	return "$_", $encoding;

This actually breaks other calls to unquote_rfc2047 which use a scalar
context. So that would have to be fixed if this were to start a real
patch.

-Peff
