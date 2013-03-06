From: Jeff King <peff@peff.net>
Subject: Re: Using socks proxy with git for http(s) transport
Date: Wed, 6 Mar 2013 03:21:16 -0500
Message-ID: <20130306082110.GA31638@sigill.intra.peff.net>
References: <CABmRxH1g2BR+-MvGZ4J-2vC8NDq3x8pG148hXfuYTpUkX0L=0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Yves Blusseau <yves.blusseau@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 09:21:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UD9bc-0006pY-UT
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 09:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682Ab3CFIVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 03:21:19 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37866 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751514Ab3CFIVT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 03:21:19 -0500
Received: (qmail 23408 invoked by uid 107); 6 Mar 2013 08:22:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Mar 2013 03:22:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2013 03:21:16 -0500
Content-Disposition: inline
In-Reply-To: <CABmRxH1g2BR+-MvGZ4J-2vC8NDq3x8pG148hXfuYTpUkX0L=0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217504>

On Wed, Mar 06, 2013 at 09:12:30AM +0100, Yves Blusseau wrote:

> i have a socks proxy to access internet.
> I successed in configuring git (with GIT_PROXY_COMMAND) to use the
> socks proxy for GIT transport protocol.
> But how to use this socks proxy with git for HTTP(S) transport protocol ?

Try:

  git config --global http.proxy 'socks://yourhost:port'

That will enable it for all git repositories on your machine. Git should
also respect any environment variables that curl handles (because we use
libcurl under the hood), if you prefer to set it up that way. See "man
curl" for details.

-Peff
