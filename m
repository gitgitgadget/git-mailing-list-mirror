From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t3200-branch: test setting branch as own upstream
Date: Fri, 28 Feb 2014 03:37:19 -0500
Message-ID: <20140228083718.GA11480@sigill.intra.peff.net>
References: <1393556659-32717-1-git-send-email-modocache@gmail.com>
 <20140228053703.GA32556@sigill.intra.peff.net>
 <531032DD.9000904@viscovery.net>
 <20140228071401.GA1229@sigill.intra.peff.net>
 <20140228072606.GA622@sigill.intra.peff.net>
 <CAN7MxmXOvkrWPDEUH_Bqz5RVZUS7kuWkwi9kWmdwuwySszd=YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 09:37:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJIwh-0003wn-7v
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 09:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbaB1IhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 03:37:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:58566 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750927AbaB1IhV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 03:37:21 -0500
Received: (qmail 18596 invoked by uid 102); 28 Feb 2014 08:37:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Feb 2014 02:37:21 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Feb 2014 03:37:19 -0500
Content-Disposition: inline
In-Reply-To: <CAN7MxmXOvkrWPDEUH_Bqz5RVZUS7kuWkwi9kWmdwuwySszd=YA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242905>

On Fri, Feb 28, 2014 at 04:28:38PM +0900, Brian Gesiak wrote:

> I would be in favor of using test_i18ngrep, but it seems like this
> test file overwhelmingly uses test_(i18n)cmp, even when inspecting
> stderr output.

We generally prefer "cmp" checks to "grep" checks, because they are more
rigorous. However, when testing human-readable output which may change,
sometimes being too specific can simply make the tests brittle and
annoying. Using a forgiving regex that matches keywords can be helpful.
So there's definitely some room for judgement.

I think what you posted as v2 looks OK.

> Making double-sure that all tests pass when run with "sh -x" seems
> like a larger endeavor.
> 
> Of course, I'd be happy to submit several patches if there's support
> for such a change. But as Peff points out it will be a large diff.

Yeah, I don't think it's worth the effort.

If you feel like continuing on this series, converting the warning()
into a die() would be a much more productive use of time (but if you
don't, I do not see any reason not to take the patches you've posted).

-Peff
