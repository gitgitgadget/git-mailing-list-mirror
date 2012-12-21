From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http.c: Avoid username prompt for certifcate credentials
Date: Fri, 21 Dec 2012 12:09:27 -0500
Message-ID: <20121221170927.GA23574@sigill.intra.peff.net>
References: <1356107479-6668-1-git-send-email-git@unrelated.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Rene Bredlau <git@unrelated.de>
X-From: git-owner@vger.kernel.org Fri Dec 21 18:09:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm66X-00080d-OY
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 18:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932Ab2LURJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 12:09:32 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60957 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226Ab2LURJa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 12:09:30 -0500
Received: (qmail 24943 invoked by uid 107); 21 Dec 2012 17:10:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Dec 2012 12:10:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Dec 2012 12:09:27 -0500
Content-Disposition: inline
In-Reply-To: <1356107479-6668-1-git-send-email-git@unrelated.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211987>

On Fri, Dec 21, 2012 at 05:31:19PM +0100, Rene Bredlau wrote:

> If sslCertPasswordProtected is set to true do not ask for username to
> decrypt rsa key. This question is pointless, the key is only protected
> by a password. Internaly the username is simply set to "".

Yeah, that makes sense. I suspect the cert-unlocking code paths for
credential helpers are not that well used (and I do not think we have
any test coverage for them at all), so I am not too surprised that this
went unreported for a long time.

Thanks.

> Signed-off-by: Rene Bredlau <git@unrelated.de>

Acked-by: Jeff King <peff@peff.net>

-Peff
