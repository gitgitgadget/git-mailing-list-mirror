From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: HTTP tests fail on OS X
Date: Fri, 21 Jun 2013 00:45:25 -0400
Message-ID: <26902D6D-D105-4943-BC67-461CEF82D888@gernhardtsoftware.com>
References: <C44E969B-A5AE-44EF-BFCA-CAEF69516BEB@gernhardtsoftware.com> <20130621043052.GA5318@sigill.intra.peff.net> <20130621044236.GA5798@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 21 06:45:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UptE4-0006JA-GP
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 06:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912Ab3FUEp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 00:45:29 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:53726 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832Ab3FUEp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 00:45:28 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id EA35327362F7; Fri, 21 Jun 2013 04:45:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-142-105-190-134.rochester.res.rr.com [142.105.190.134])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id BAC8D27362E1;
	Fri, 21 Jun 2013 04:45:25 +0000 (UTC)
In-Reply-To: <20130621044236.GA5798@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228571>


On Jun 21, 2013, at 12:42 AM, Jeff King <peff@peff.net> wrote:

> I'm not sure if there is something different between 2.2.16 and 2.2.22,
> or something with the particular build. Here's my -V output, in case it
> helps:
> 
>    $ apache2 -V
>    Server version: Apache/2.2.16 (Debian)
>    Server built:   Mar  3 2013 12:12:28
>    Server's Module Magic Number: 20051115:24
>    Server loaded:  APR 1.4.2, APR-Util 1.3.9
>    Compiled using: APR 1.4.2, APR-Util 1.3.9
>    Architecture:   64-bit
>    Server MPM:     Worker
>      threaded:     yes (fixed thread count)
>        forked:     yes (variable process count)
>    Server compiled with....
>     -D APACHE_MPM_DIR="server/mpm/worker"
>     -D APR_HAS_SENDFILE
>     -D APR_HAS_MMAP
>     -D APR_HAVE_IPV6 (IPv4-mapped addresses enabled)
>     -D APR_USE_SYSVSEM_SERIALIZE
>     -D APR_USE_PTHREAD_SERIALIZE
>     -D SINGLE_LISTEN_UNSERIALIZED_ACCEPT
>     -D APR_HAS_OTHER_CHILD
>     -D AP_HAVE_RELIABLE_PIPED_LOGS
>     -D DYNAMIC_MODULE_LIMIT=128
>     -D HTTPD_ROOT="/etc/apache2"
>     -D SUEXEC_BIN="/usr/lib/apache2/suexec"
>     -D DEFAULT_PIDLOG="/var/run/apache2.pid"
>     -D DEFAULT_SCOREBOARD="logs/apache_runtime_status"
>     -D DEFAULT_ERRORLOG="logs/error_log"
>     -D AP_TYPES_CONFIG_FILE="mime.types"
>     -D SERVER_CONFIG_FILE="apache2.conf"

Doesn't look terribly different from mine.

$ apachectl -V
Server version: Apache/2.2.22 (Unix)
Server built:   Dec  9 2012 18:57:18
Server's Module Magic Number: 20051115:30
Server loaded:  APR 1.4.5, APR-Util 1.3.12
Compiled using: APR 1.4.5, APR-Util 1.3.12
Architecture:   64-bit
Server MPM:     Prefork
  threaded:     no
    forked:     yes (variable process count)
Server compiled with....
 -D APACHE_MPM_DIR="server/mpm/prefork"
 -D APR_HAS_SENDFILE
 -D APR_HAS_MMAP
 -D APR_HAVE_IPV6 (IPv4-mapped addresses enabled)
 -D APR_USE_FLOCK_SERIALIZE
 -D APR_USE_PTHREAD_SERIALIZE
 -D SINGLE_LISTEN_UNSERIALIZED_ACCEPT
 -D APR_HAS_OTHER_CHILD
 -D AP_HAVE_RELIABLE_PIPED_LOGS
 -D DYNAMIC_MODULE_LIMIT=128
 -D HTTPD_ROOT="/usr"
 -D SUEXEC_BIN="/usr/bin/suexec"
 -D DEFAULT_PIDLOG="/private/var/run/httpd.pid"
 -D DEFAULT_SCOREBOARD="logs/apache_runtime_status"
 -D DEFAULT_LOCKFILE="/private/var/run/accept.lock"
 -D DEFAULT_ERRORLOG="logs/error_log"
 -D AP_TYPES_CONFIG_FILE="/private/etc/apache2/mime.types"
 -D SERVER_CONFIG_FILE="/private/etc/apache2/httpd.conf"
