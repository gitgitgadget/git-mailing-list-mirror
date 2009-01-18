From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] color: make it easier for non-config to parse
	color specs
Date: Sun, 18 Jan 2009 12:36:46 -0500
Message-ID: <20090118173645.GA22680@coredump.intra.peff.net>
References: <20090117152108.GA24899@coredump.intra.peff.net> <20090117153229.GA27071@coredump.intra.peff.net> <4973628C.8080501@lsrfire.ath.cx> <20090118172802.GA17434@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jan 18 18:39:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LObbB-00046c-B4
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 18:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765568AbZARRgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 12:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764991AbZARRgt
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 12:36:49 -0500
Received: from peff.net ([208.65.91.99]:39575 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763987AbZARRgs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 12:36:48 -0500
Received: (qmail 22111 invoked by uid 107); 18 Jan 2009 17:36:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 18 Jan 2009 12:36:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Jan 2009 12:36:46 -0500
Content-Disposition: inline
In-Reply-To: <20090118172802.GA17434@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106248>

On Sun, Jan 18, 2009 at 12:28:02PM -0500, Jeff King wrote:

> I don't know if this is really even worth it. The timing difference is
> pretty minimal:

BTW, if we really care about every inch of performance in
--pretty=format:, it would probably make sense to pre-parse the string
into a mini-bytecode. So any complex parsing or lookup that is not
dependent on the commit itself can be done once, instead of per-commit.

I don't think it would make a huge performance difference now, but there
has been talk of more complex substitution syntax (and this %C() is an
example), which would probably benefit.

-Peff
