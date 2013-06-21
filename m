From: Jeff King <peff@peff.net>
Subject: Re: HTTP tests fail on OS X
Date: Fri, 21 Jun 2013 00:42:37 -0400
Message-ID: <20130621044236.GA5798@sigill.intra.peff.net>
References: <C44E969B-A5AE-44EF-BFCA-CAEF69516BEB@gernhardtsoftware.com>
 <20130621043052.GA5318@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 06:42:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UptBP-0002RZ-2g
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 06:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201Ab3FUEmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 00:42:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:34882 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753883Ab3FUEmm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 00:42:42 -0400
Received: (qmail 12792 invoked by uid 102); 21 Jun 2013 04:43:42 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Jun 2013 23:43:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Jun 2013 00:42:37 -0400
Content-Disposition: inline
In-Reply-To: <20130621043052.GA5318@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228570>

On Fri, Jun 21, 2013 at 12:30:52AM -0400, Jeff King wrote:

> > OS X 10.8.4, apache 2.2.22
> 
> Hrm. That's quite odd. The patch in its entirety looks like this:
> [...]
> So it should not be having any effect at all on apache 2.2, unless it
> somehow does not like the <IfVersion> tags.

Just to double-check, I ran all of the http tests in "next" (with my
series) successfully on apache 2.2.16. So the good news is I haven't
broken apache 2.2.x entirely. :)

I'm not sure if there is something different between 2.2.16 and 2.2.22,
or something with the particular build. Here's my -V output, in case it
helps:

    $ apache2 -V
    Server version: Apache/2.2.16 (Debian)
    Server built:   Mar  3 2013 12:12:28
    Server's Module Magic Number: 20051115:24
    Server loaded:  APR 1.4.2, APR-Util 1.3.9
    Compiled using: APR 1.4.2, APR-Util 1.3.9
    Architecture:   64-bit
    Server MPM:     Worker
      threaded:     yes (fixed thread count)
        forked:     yes (variable process count)
    Server compiled with....
     -D APACHE_MPM_DIR="server/mpm/worker"
     -D APR_HAS_SENDFILE
     -D APR_HAS_MMAP
     -D APR_HAVE_IPV6 (IPv4-mapped addresses enabled)
     -D APR_USE_SYSVSEM_SERIALIZE
     -D APR_USE_PTHREAD_SERIALIZE
     -D SINGLE_LISTEN_UNSERIALIZED_ACCEPT
     -D APR_HAS_OTHER_CHILD
     -D AP_HAVE_RELIABLE_PIPED_LOGS
     -D DYNAMIC_MODULE_LIMIT=128
     -D HTTPD_ROOT="/etc/apache2"
     -D SUEXEC_BIN="/usr/lib/apache2/suexec"
     -D DEFAULT_PIDLOG="/var/run/apache2.pid"
     -D DEFAULT_SCOREBOARD="logs/apache_runtime_status"
     -D DEFAULT_ERRORLOG="logs/error_log"
     -D AP_TYPES_CONFIG_FILE="mime.types"
     -D SERVER_CONFIG_FILE="apache2.conf"

-Peff
