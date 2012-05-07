From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] status: respect "-b" for porcelain format
Date: Mon, 7 May 2012 17:28:36 -0400
Message-ID: <20120507212836.GA19753@sigill.intra.peff.net>
References: <20120507212125.GA19532@sigill.intra.peff.net>
 <20120507212504.GE19567@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Zak Johnson <zakj@nox.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 07 23:28:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRVU3-0008Tx-9l
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 23:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525Ab2EGV2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 17:28:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33264
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932337Ab2EGV2i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 17:28:38 -0400
Received: (qmail 27586 invoked by uid 107); 7 May 2012 21:28:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 May 2012 17:28:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2012 17:28:36 -0400
Content-Disposition: inline
In-Reply-To: <20120507212504.GE19567@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197314>

On Mon, May 07, 2012 at 05:25:04PM -0400, Jeff King wrote:

> There is no reason not to, as the user has to explicitly ask
> for it, so we are not breaking compatibility by doing so. We
> can do this simply by moving the "show_branch" flag into
> the wt_status struct. As a bonus, this saves us from passing
> it explicitly, simplifying the code.

I forgot this, which should probably be squashed in:

-- >8 --
Subject: status: fix "--porcelain -z -b" documentation

It is no longer the case that "-z" will not respect "-b".

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-status.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 2883a28..67e5f53 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -184,7 +184,7 @@ order is reversed (e.g 'from \-> to' becomes 'to from'). Second, a NUL
 and the terminating newline (but a space still separates the status
 field from the first filename).  Third, filenames containing special
 characters are not specially formatted; no quoting or
-backslash-escaping is performed. Fourth, there is no branch line.
+backslash-escaping is performed.
 
 CONFIGURATION
 -------------
-- 
1.7.10.1.12.gd79f7ab
