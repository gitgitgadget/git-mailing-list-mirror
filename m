From: Jeff King <peff@peff.net>
Subject: Re: fatal output from git-show really wants a terminal
Date: Mon, 15 Dec 2008 03:25:15 -0500
Message-ID: <20081215082514.GA32123@coredump.intra.peff.net>
References: <ghop5d$qud$1@ger.gmane.org> <200812111051.20322.bss03@volumehost.net> <20081211215554.GA11565@sigill.intra.peff.net> <200812111645.10067.bss03@volumehost.net> <7vr64eb9ha.fsf@gitster.siamese.dyndns.org> <7v3agpzwet.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Boyd Stephen Smith Jr." <bss03@volumehost.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 09:26:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC8mj-0004dY-7Y
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 09:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbYLOIZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 03:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752186AbYLOIZS
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 03:25:18 -0500
Received: from peff.net ([208.65.91.99]:1032 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752131AbYLOIZR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 03:25:17 -0500
Received: (qmail 3803 invoked by uid 111); 15 Dec 2008 08:25:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 15 Dec 2008 03:25:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Dec 2008 03:25:15 -0500
Content-Disposition: inline
In-Reply-To: <7v3agpzwet.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103140>

On Mon, Dec 15, 2008 at 12:15:38AM -0800, Junio C Hamano wrote:

> I haven't heard anything more about this, but if you were indeed
> discussing the change made by 61b8050, I think the fix should just be like
> this.
> [...]
> -	dup2(pager_process.in, 2);
> +	if (isatty(2))
> +		dup2(pager_process.in, 2);

I can't speak for the original poster, but I do think this behavior
should be less surprising to users who perform the one particular
redirection (and in the other 99% of cases, should behave exactly the
same). So I think it's a positive change.

-Peff
