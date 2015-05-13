From: Jeff King <peff@peff.net>
Subject: [PATCH 7/8] doc: drop backslash quoting of some curly braces
Date: Wed, 13 May 2015 01:02:22 -0400
Message-ID: <20150513050222.GG6821@peff.net>
References: <20150513045650.GA6070@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 07:02:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsOoP-0000Jx-Qb
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 07:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbbEMFCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 01:02:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:57625 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751207AbbEMFCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 01:02:25 -0400
Received: (qmail 2168 invoked by uid 102); 13 May 2015 05:02:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 00:02:25 -0500
Received: (qmail 7004 invoked by uid 107); 13 May 2015 05:02:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 01:02:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 May 2015 01:02:22 -0400
Content-Disposition: inline
In-Reply-To: <20150513045650.GA6070@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268933>

Text like "{foo}" triggers an AsciiDoc attribute; we have to
write "\{foo}" to suppress this. But when the "foo" is not a
syntactically valid attribute, we can skip the quoting. This
makes the source nicer to read, and looks better under
Asciidoctor. With AsciiDoc itself, this patch produces no
changes.

Signed-off-by: Jeff King <peff@peff.net>
---
Same arguments apply as the last commit. I split this out because unlike
the "--foo" thing, I don't actually know what version of AsciiDoc
changed this rule (if it was ever in fact necessary). So this one is
slightly riskier.

 Documentation/gitremote-helpers.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 8edf72c..82e2d15 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -408,14 +408,14 @@ set by Git if the remote helper has the 'option' capability.
 	of <n> correspond to the number of -v flags passed on the
 	command line.
 
-'option progress' \{'true'|'false'\}::
+'option progress' {'true'|'false'}::
 	Enables (or disables) progress messages displayed by the
 	transport helper during a command.
 
 'option depth' <depth>::
 	Deepens the history of a shallow repository.
 
-'option followtags' \{'true'|'false'\}::
+'option followtags' {'true'|'false'}::
 	If enabled the helper should automatically fetch annotated
 	tag objects if the object the tag points at was transferred
 	during the fetch command.  If the tag is not fetched by
@@ -423,7 +423,7 @@ set by Git if the remote helper has the 'option' capability.
 	ask for the tag specifically.  Some helpers may be able to
 	use this option to avoid a second network connection.
 
-'option dry-run' \{'true'|'false'\}:
+'option dry-run' {'true'|'false'}:
 	If true, pretend the operation completed successfully,
 	but don't actually change any repository data.	For most
 	helpers this only applies to the 'push', if supported.
@@ -434,18 +434,18 @@ set by Git if the remote helper has the 'option' capability.
 	must not rely on this option being set before
 	connect request occurs.
 
-'option check-connectivity' \{'true'|'false'\}::
+'option check-connectivity' {'true'|'false'}::
 	Request the helper to check connectivity of a clone.
 
-'option force' \{'true'|'false'\}::
+'option force' {'true'|'false'}::
 	Request the helper to perform a force update.  Defaults to
 	'false'.
 
-'option cloning \{'true'|'false'\}::
+'option cloning {'true'|'false'}::
 	Notify the helper this is a clone request (i.e. the current
 	repository is guaranteed empty).
 
-'option update-shallow \{'true'|'false'\}::
+'option update-shallow {'true'|'false'}::
 	Allow to extend .git/shallow if the new refs require it.
 
 SEE ALSO
-- 
2.4.0.192.g5f8138b
