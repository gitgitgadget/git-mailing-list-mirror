From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] perl shebangs: Use /usr/bin/env, not /usr/bin/perl
Date: Fri, 21 May 2010 12:01:43 -0400
Message-ID: <20100521160143.GA29031@sigill.intra.peff.net>
References: <1274453455-1941-1-git-send-email-avarab@gmail.com>
 <1274454086-2312-1-git-send-email-avarab@gmail.com>
 <86tyq1gti2.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Fri May 21 18:02:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFUfg-00022W-1Q
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 18:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933830Ab0EUQBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 12:01:49 -0400
Received: from peff.net ([208.65.91.99]:49593 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758414Ab0EUQBq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 12:01:46 -0400
Received: (qmail 28901 invoked by uid 107); 21 May 2010 16:01:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 21 May 2010 12:01:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 May 2010 12:01:43 -0400
Content-Disposition: inline
In-Reply-To: <86tyq1gti2.fsf@red.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147475>

On Fri, May 21, 2010 at 08:32:53AM -0700, Randal L. Schwartz wrote:

> The official Perl should be in /usr/bin or /usr/local/bin, and that's
> the one you should use with Git.  *Or*, give the installer a knob to
> configure.

Don't we already provide a knob? The Makefile has:

  $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
  [...]
          sed -e '1{' \
              -e '        s|#!.*perl|#!$(PERL_PATH_SQ)|' \
  [...]

So just setting PERL_PATH should be enough (from which PERL_PATH_SQ is
derived).

-Peff
