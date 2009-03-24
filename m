From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/8] Documentation: move callouts.xsl to
	manpage-{base,normal}.xsl
Date: Tue, 24 Mar 2009 04:51:47 -0400
Message-ID: <20090324085147.GA1799@coredump.intra.peff.net>
References: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com> <1237881866-5497-2-git-send-email-chris_johnsen@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 09:53:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm2O6-0003kt-Ce
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 09:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757558AbZCXIv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 04:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756286AbZCXIv6
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 04:51:58 -0400
Received: from peff.net ([208.65.91.99]:55654 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756323AbZCXIv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 04:51:56 -0400
Received: (qmail 28157 invoked by uid 107); 24 Mar 2009 08:52:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Mar 2009 04:52:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Mar 2009 04:51:47 -0400
Content-Disposition: inline
In-Reply-To: <1237881866-5497-2-git-send-email-chris_johnsen@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114428>

On Tue, Mar 24, 2009 at 03:04:19AM -0500, Chris Johnsen wrote:

>  Documentation/Makefile           |    2 +-
>  Documentation/callouts.xsl       |   30 ------------------------------
>  Documentation/manpage-base.xsl   |   30 ++++++++++++++++++++++++++++++
>  Documentation/manpage-normal.xsl |   30 ++++++++++++++++++++++++++++++
>  4 files changed, 61 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/callouts.xsl
>  create mode 100644 Documentation/manpage-base.xsl
>  create mode 100644 Documentation/manpage-normal.xsl

This is definitely a good change, though it would also be fine to
actually munge the contents in the same patch rather than duplicate them
(i.e., actually _split_ callouts.xsl instead of copying it to two
places).

I think it would have been much easier to read, though, by turning on
rename detection in format-patch (i.e., "-M"). That yields:

---
 Documentation/Makefile                             |    2 +-
 Documentation/{callouts.xsl => manpage-base.xsl}   |    0
 Documentation/{callouts.xsl => manpage-normal.xsl} |    0
 3 files changed, 1 insertions(+), 1 deletions(-)
 copy Documentation/{callouts.xsl => manpage-base.xsl} (100%)
 rename Documentation/{callouts.xsl => manpage-normal.xsl} (100%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 144ec32..e1562e3 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -41,7 +41,7 @@ man7dir=$(mandir)/man7
 
 ASCIIDOC=asciidoc
 ASCIIDOC_EXTRA =
-MANPAGE_XSL = callouts.xsl
+MANPAGE_XSL = manpage-normal.xsl
 INSTALL?=install
 RM ?= rm -f
 DOC_REF = origin/man
diff --git a/Documentation/callouts.xsl b/Documentation/manpage-base.xsl
similarity index 100%
copy from Documentation/callouts.xsl
copy to Documentation/manpage-base.xsl
diff --git a/Documentation/callouts.xsl b/Documentation/manpage-normal.xsl
similarity index 100%
rename from Documentation/callouts.xsl
rename to Documentation/manpage-normal.xsl
-- 
1.6.2.1.459.g5b99e
