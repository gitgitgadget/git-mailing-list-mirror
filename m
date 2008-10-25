From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/7] textconv: don't convert for every operation
Date: Sat, 25 Oct 2008 15:35:54 -0400
Message-ID: <20081025193554.GA27457@coredump.intra.peff.net>
References: <20081025004815.GA23851@coredump.intra.peff.net> <20081025005256.GD23903@coredump.intra.peff.net> <7vhc71b5ai.fsf@gitster.siamese.dyndns.org> <20081025071912.GA24287@coredump.intra.peff.net> <7v3aika5l7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 21:38:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ktoxc-0006rp-NH
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 21:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbYJYTf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 15:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbYJYTf6
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 15:35:58 -0400
Received: from peff.net ([208.65.91.99]:1200 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062AbYJYTf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 15:35:57 -0400
Received: (qmail 2786 invoked by uid 111); 25 Oct 2008 19:35:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 25 Oct 2008 15:35:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Oct 2008 15:35:54 -0400
Content-Disposition: inline
In-Reply-To: <7v3aika5l7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99122>

On Sat, Oct 25, 2008 at 11:32:20AM -0700, Junio C Hamano wrote:

> The end result may not be that much different, but I find the latter
> easier to follow for three reasons:

Your reasoning here is sound. My initial thought was to make it a
one-liner change to "turn on" text conversion in other spots. But

  a) it didn't turn out that way, since you still have to keep track of
     the "did I textconv" when determining binary-ness, and whether to
     free()

  b) we don't actually want to do it anywhere else (except perhaps, as I
     mentioned, in blame, but that is a totally different interface
     anyway)

I will re-roll my latest series according to your recommendation
(unless you are set on reverting the first part; if so, please tell me
asap so I can work under that assumption).

-Peff
