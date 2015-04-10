From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] t/lib-httpd: load mod_unixd
Date: Fri, 10 Apr 2015 05:09:14 +0200
Message-ID: <20150410030913.GA11280@peff.net>
References: <cover.1428505184.git.git@drmicha.warpmail.net>
 <53b238530469330255d13209c2df4f11ef5b2edc.1428505184.git.git@drmicha.warpmail.net>
 <5525A208.6060807@web.de>
 <55264615.2050107@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 10 05:09:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgPJr-0006db-KS
	for gcvg-git-2@plane.gmane.org; Fri, 10 Apr 2015 05:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbbDJDJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2015 23:09:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:44131 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753109AbbDJDJS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2015 23:09:18 -0400
Received: (qmail 32043 invoked by uid 102); 10 Apr 2015 03:09:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Apr 2015 22:09:18 -0500
Received: (qmail 6610 invoked by uid 107); 10 Apr 2015 03:09:39 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Apr 2015 23:09:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Apr 2015 05:09:14 +0200
Content-Disposition: inline
In-Reply-To: <55264615.2050107@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267003>

On Thu, Apr 09, 2015 at 11:27:49AM +0200, Michael J Gruber wrote:

> In my case (apache 2.4, fedora 21), t/lib-http.sh failed to start the
> web server, so the tests above would (succeed trivially but) not run.
> 
> Maybe debian is using an apache default config that has mod_unixd built
> in, to ease the transition from apache 2.2? Many were bitten by these
> new requirements after the switch to 2.4, and some distros may have
> worked around that.

Yes, this is exactly it. On my Debian system:

  $ apache2 -l
  Compiled in modules:
    core.c
    mod_so.c
    mod_watchdog.c
    http_core.c
    mod_log_config.c
    mod_logio.c
    mod_version.c
    mod_unixd.c

> Do your tests run with this patch applied?

Yes. I think your patch is fine, as the IfModule means we handle both
the built-in and dynamic cases.

-Peff
