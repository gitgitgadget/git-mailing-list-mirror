From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 18/31] rebase: extract merge code to new source file
Date: Fri, 25 Feb 2011 04:02:39 -0500
Message-ID: <20110225090238.GB16861@sigill.intra.peff.net>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-19-git-send-email-martin.von.zweigbergk@gmail.com>
 <4D58E17C.9090001@viscovery.net>
 <alpine.DEB.2.00.1102232216180.11038@debian>
 <20110224080734.GB25595@sigill.intra.peff.net>
 <20110224080904.GC25595@sigill.intra.peff.net>
 <alpine.DEB.2.00.1102242229230.11894@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 10:02:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PstZZ-000415-B3
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 10:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255Ab1BYJCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 04:02:44 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35115 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932167Ab1BYJCk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 04:02:40 -0500
Received: (qmail 32489 invoked by uid 111); 25 Feb 2011 09:02:40 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 25 Feb 2011 09:02:40 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Feb 2011 04:02:39 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1102242229230.11894@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167887>

On Thu, Feb 24, 2011 at 10:32:06PM -0500, Martin von Zweigbergk wrote:

> Subject: [PATCH] Makefile: do not install sourced rebase scripts
> 
> When git-rebase.sh recently started sourcing
> git-rebase--interactive.sh instead of executing it, executable bit of
> the latter file should have been turned off and it should have been
> moved from SCRIPT_SH to SCRIPT_LIB in the Makefile. Its two new
> siblings, git-rebase--am.sh and git-rebase--merge.sh (whose executable
> bits are already off) should also be moved to SCRIPT_LIB in the
> Makefile.

Looks right, but...

> @@ -382,6 +379,9 @@ SCRIPT_SH += git-web--browse.sh
>  SCRIPT_LIB += git-mergetool--lib
>  SCRIPT_LIB += git-parse-remote
>  SCRIPT_LIB += git-sh-setup
> +SCRIPT_LIB += git-rebase--am.sh
> +SCRIPT_LIB += git-rebase--interactive.sh
> +SCRIPT_LIB += git-rebase--merge.sh

We usually keep these sorted.

-Peff
