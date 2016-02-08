From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t9100: fix breakage when SHELL_PATH is not /bin/sh
Date: Mon, 8 Feb 2016 14:35:09 -0500
Message-ID: <20160208193509.GA30554@sigill.intra.peff.net>
References: <982f6f499c988e1063275e2951c9856d622a83f3.1454872161.git.git@drmicha.warpmail.net>
 <20160208135013.GA27054@sigill.intra.peff.net>
 <CAA19uiRSu_6Os3b498obSNec7b2uiYv20SZ=y93CkjsWqhqHzA@mail.gmail.com>
 <20160208163700.GA22929@sigill.intra.peff.net>
 <alpine.DEB.2.20.1602082027550.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 08 20:35:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSrah-0007OA-8Z
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 20:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbcBHTfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 14:35:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:39387 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751075AbcBHTfM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 14:35:12 -0500
Received: (qmail 13292 invoked by uid 102); 8 Feb 2016 19:35:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 14:35:11 -0500
Received: (qmail 8232 invoked by uid 107); 8 Feb 2016 19:35:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 14:35:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 14:35:09 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1602082027550.2964@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285792>

On Mon, Feb 08, 2016 at 08:31:54PM +0100, Johannes Schindelin wrote:

> On Mon, 8 Feb 2016, Jeff King wrote:
> 
> > Assuming your patch works on Windows
> 
> If it re-introduces that chmod +x, it won't.
> 
> Please note that my *original* patch actually only guarded the chmod +x,
> but Junio suggested switching to write_script and since it passed the test
> suite here, I though it would be safe.
> 
> I still think write_script is the better alternative.

I'm confused why it matters. write_script() unconditionally calls "chmod
+x", doesn't it?

I just double-checked its definition in test-lib-function.sh; am I
missing some Windows-specific magic that kicks in?

> So why not just prefix it with `SHELL_PATH=/bin/sh`?

But then what is write_script buying us?

-Peff
