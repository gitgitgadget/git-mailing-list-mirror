From: Jeff King <peff@peff.net>
Subject: Re: cherry-pick is slow
Date: Mon, 14 May 2012 10:54:12 -0400
Message-ID: <20120514145412.GA1159@sigill.intra.peff.net>
References: <CAPZ_ugYojqTaWi0atr2ApOu9xmcwy4y8FduNC+TDhgWgSxXNPQ@mail.gmail.com>
 <CAPc5daW6eBLUf55_Qk+4bA6Y16TehfOUGc1xFzhib9vm=8O2Yw@mail.gmail.com>
 <CAPZ_ugbV6hB+8z8UsQKdHhxGuHbLzC5WK19mK7M8k2tMz+mtXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster-vger@pobox.com>, git@vger.kernel.org
To: Dmitry Risenberg <dmitry.risenberg@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 16:54:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STwfU-0004KR-45
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 16:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755663Ab2ENOyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 10:54:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42745
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402Ab2ENOyS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 10:54:18 -0400
Received: (qmail 20311 invoked by uid 107); 14 May 2012 14:54:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 May 2012 10:54:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 May 2012 10:54:12 -0400
Content-Disposition: inline
In-Reply-To: <CAPZ_ugbV6hB+8z8UsQKdHhxGuHbLzC5WK19mK7M8k2tMz+mtXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197773>

On Sun, May 13, 2012 at 07:39:49PM +0400, Dmitry Risenberg wrote:

> However, cherry-picking is still not as fast as I expected it to be -
> cherry-picking a single-file commit takes about 14-15 seconds, fully
> using one CPU core. Anything else I can improve?

It's probably detecting renames as part of the merge, which can be
expensive if the thing you are cherry-picking is far away from HEAD. You
can try setting the merge.renamelimit config variable to something small
(like 1; setting it to 0 means "no limit").

-Peff
