From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 1/2] wrapper: supply xsetenv
Date: Tue, 13 Dec 2011 13:16:02 -0500
Message-ID: <20111213181602.GB1663@sigill.intra.peff.net>
References: <1323778227-1664-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 19:16:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaWtg-0002ry-2x
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 19:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108Ab1LMSQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 13:16:07 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49688
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753606Ab1LMSQF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 13:16:05 -0500
Received: (qmail 22061 invoked by uid 107); 13 Dec 2011 18:22:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Dec 2011 13:22:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2011 13:16:02 -0500
Content-Disposition: inline
In-Reply-To: <1323778227-1664-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187035>

On Tue, Dec 13, 2011 at 01:10:26PM +0100, Erik Faye-Lund wrote:

> +int xsetenv(const char *name, const char *val, int overwrite)
> +{
> +	if (setenv(name, val, overwrite))
> +		die_errno("setenv failed");
> +}

It probably doesn't matter, because the error condition is almost
certainly just "oops, we ran out of memory". But you could also print
the name of the variable being set, which may give the user a clue to
some misconfiguration (e.g., trying to put some extremely long value
into the environment).

-Peff
