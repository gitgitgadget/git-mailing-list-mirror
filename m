From: Jeff King <peff@peff.net>
Subject: [PATCH 9/8] doc: convert AsciiDoc {?foo} to ifdef::foo[]
Date: Thu, 14 May 2015 00:34:48 -0400
Message-ID: <20150514043448.GA21855@peff.net>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
 <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
 <20150513021556.GA4160@peff.net>
 <20150513045650.GA6070@peff.net>
 <20150513224131.GC425227@vauxhall.crustytoothpaste.net>
 <20150514042544.GA9351@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu May 14 06:34:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YskrH-0003gh-LK
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 06:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456AbbENEev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 00:34:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:58419 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750760AbbENEeu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 00:34:50 -0400
Received: (qmail 7644 invoked by uid 102); 14 May 2015 04:34:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 23:34:50 -0500
Received: (qmail 19729 invoked by uid 107); 14 May 2015 04:34:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 00:34:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2015 00:34:48 -0400
Content-Disposition: inline
In-Reply-To: <20150514042544.GA9351@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269025>

The former seems to just be syntactic sugar for the latter.
And as it's sugar that AsciiDoctor doesn't understand, it
would be nice to avoid it. Since there are only two spots,
and the resulting source is not significantly harder to
read, it's worth doing.

Note that this does slightly affect the generated HTML (it
has an extra newline), but the rendered result for both HTML
and docbook should be the same (since the newline is not
syntactically significant there).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/diff-options.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index ccd4998..b7c3afe 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -23,7 +23,9 @@ ifndef::git-format-patch[]
 -u::
 --patch::
 	Generate patch (see section on generating patches).
-	{git-diff? This is the default.}
+ifdef::git-diff[]
+	This is the default.
+endif::git-diff[]
 endif::git-format-patch[]
 
 -s::
@@ -42,7 +44,9 @@ endif::git-format-patch[]
 ifndef::git-format-patch[]
 --raw::
 	Generate the raw format.
-	{git-diff-core? This is the default.}
+ifdef::git-diff-core[]
+	This is the default.
+endif::git-diff-core[]
 endif::git-format-patch[]
 
 ifndef::git-format-patch[]
-- 
2.4.0.327.ge28c153
