From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/3] config: add '--show-origin' option to print the
 origin of a config value
Date: Mon, 15 Feb 2016 16:40:49 -0500
Message-ID: <20160215214049.GA10094@sigill.intra.peff.net>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
 <1455531466-16617-4-git-send-email-larsxschneider@gmail.com>
 <56C244D7.1030503@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: larsxschneider@gmail.com, git@vger.kernel.org,
	sschuberth@gmail.com, sunshine@sunshineco.com, hvoigt@hvoigt.net,
	sbeller@google.com, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 22:40:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVQt6-0000Tf-7d
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbcBOVkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:40:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:42438 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751120AbcBOVkw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 16:40:52 -0500
Received: (qmail 1921 invoked by uid 102); 15 Feb 2016 21:40:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 16:40:51 -0500
Received: (qmail 12052 invoked by uid 107); 15 Feb 2016 21:40:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 16:40:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 16:40:49 -0500
Content-Disposition: inline
In-Reply-To: <56C244D7.1030503@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286249>

On Mon, Feb 15, 2016 at 09:36:23PM +0000, Ramsay Jones wrote:

> > +test_expect_success '--show-origin stdin' '
> > +	cat >expect <<-\EOF &&
> > +		stdin:	user.custom=true
> 
> So, as with the previous patch, I think this should be:
> 		file:<stdin>	user.custom=true

That's ambiguous with a file named "<stdin>", which was the point of
having the two separate prefixes in the first place.

I think in practice we _could_ get by with an ambiguous output (it's not
like "<stdin>" is a common filename), but that was discussed earlier in
the thread, and Lars decided to go for something unambiguous.

That doesn't necessarily have to bleed over into the error messages,
though (which could continue to use "<stdin>" if we want to put in a
little extra code to covering the cases separately.

-Peff
