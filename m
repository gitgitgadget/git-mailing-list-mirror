From: Jeff King <peff@peff.net>
Subject: Re: Fwd: [PATCH 4/5] Replace {pre,suf}fixcmp() with
 {starts,ends}_with()
Date: Tue, 3 Dec 2013 07:46:45 -0500
Message-ID: <20131203124645.GB26667@sigill.intra.peff.net>
References: <20131201074818.3042.57357.chriscool@tuxfamily.org>
 <20131201074919.3042.92026.chriscool@tuxfamily.org>
 <CAP8UFD0jg_Vr7Zf+DiMX9RG6vmmQvmk2NvmL7j=MC-x3fLOOBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 13:46:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnpNM-00089R-QW
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 13:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049Ab3LCMqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 07:46:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:49614 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752465Ab3LCMqs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 07:46:48 -0500
Received: (qmail 23479 invoked by uid 102); 3 Dec 2013 12:46:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Dec 2013 06:46:47 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Dec 2013 07:46:45 -0500
Content-Disposition: inline
In-Reply-To: <CAP8UFD0jg_Vr7Zf+DiMX9RG6vmmQvmk2NvmL7j=MC-x3fLOOBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238688>

On Tue, Dec 03, 2013 at 08:03:39AM +0100, Christian Couder wrote:

> I am trying to forward this patch from my gmail address, as it doesn't
> seem to go through when I send it from my home machine.

This made it through to me, but not the list. There are at least two
things going on:

  1. The message is 172K, which is over the 100K limit imposed by vger;
     the list is silently dropping it.

  2. In my case, the direct mail was being flagged by spam because it
     contains the blacklisted domain "old.name". Which of course is not
     a domain at all but rather this code:

       old.name = old.path + strlen("refs/heads/");

     I've tweaked my server.

I can't say why it wasn't getting to Junio via direct mail. Maybe the
same spam thing, or maybe something else.

> From: Christian Couder <chriscool@tuxfamily.org>
> Date: Sun, Dec 1, 2013 at 8:49 AM
> Subject: [PATCH 4/5] Replace {pre,suf}fixcmp() with {starts,ends}_with()
> To: christian.couder@gmail.com
> 
> This patch was generated automatically using the following
> commands:
> 
> git grep --name-only prefixcmp | grep -v '\.h' | grep -v 'strbuf.c' |
> xargs perl -pi -e 's/!prefixcmp\(/starts_with\(/g'
> git grep --name-only prefixcmp | grep -v '\.h' | grep -v 'strbuf.c' |
> xargs perl -pi -e 's/prefixcmp\(/!starts_with\(/g'
> git grep --name-only suffixcmp | grep -v '\.h' | grep -v 'strbuf.c' |
> xargs perl -pi -e 's/!suffixcmp\(/ends_with\(/g'
> git grep --name-only suffixcmp | grep -v '\.h' | grep -v 'strbuf.c' |
> xargs perl -pi -e 's/suffixcmp\(/!ends_with\(/g'
> 
> It was generated on version 1.8.5 of the git codebase.

I skimmed the patch and didn't notice any problems. It's
whitespace-damaged by gmail, of course. The simplest thing is probably
to just point us at a public repo with the commit, if you have one.

-Peff
