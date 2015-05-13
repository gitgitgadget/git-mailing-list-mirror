From: Jeff King <peff@peff.net>
Subject: [PATCH 8/8] doc: put example URLs and emails inside literal backticks
Date: Wed, 13 May 2015 01:06:21 -0400
Message-ID: <20150513050621.GH6821@peff.net>
References: <20150513045650.GA6070@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 07:06:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsOsG-0001YP-D0
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 07:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbbEMFGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 01:06:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:57628 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750875AbbEMFGX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 01:06:23 -0400
Received: (qmail 2472 invoked by uid 102); 13 May 2015 05:06:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 00:06:24 -0500
Received: (qmail 7032 invoked by uid 107); 13 May 2015 05:06:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 01:06:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 May 2015 01:06:21 -0400
Content-Disposition: inline
In-Reply-To: <20150513045650.GA6070@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268934>

This makes sure that AsciiDoc does not turn them into links.
Regular AsciiDoc does not catch these cases, but AsciiDoctor
does treat them as links.

Signed-off-by: Jeff King <peff@peff.net>
---
Note that this _does_ change the output in AsciiDoc, because we convert
other forms of quotes into backticks. For HTML, that gets us a
typewriter font, and if you have MAN_BOLD_LITERAL, it gets you bold in
the manpages. If we really prefer the emphasis, I think we'd have to
manually escape it.  This seems to work with "\http://" in AsciiDoc, but
that doesn't work for AsciiDoctor.

So we may want to just drop this until we better figure out AsciiDoctor
escaping.

 Documentation/git-http-backend.txt | 4 ++--
 Documentation/git-svn.txt          | 4 ++--
 Documentation/git-tag.txt          | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index d422ba4..3ca18c4 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -65,8 +65,8 @@ automatically by the web server.
 
 EXAMPLES
 --------
-All of the following examples map 'http://$hostname/git/foo/bar.git'
-to '/var/www/git/foo/bar.git'.
+All of the following examples map `http://$hostname/git/foo/bar.git`
+to `/var/www/git/foo/bar.git`.
 
 Apache 2.x::
 	Ensure mod_cgi, mod_alias, and mod_env are enabled, set
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 1377008..11d1e2f 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -70,8 +70,8 @@ COMMANDS
 --username=<user>;;
 	For transports that SVN handles authentication for (http,
 	https, and plain svn), specify the username.  For other
-	transports (e.g. svn+ssh://), you must include the username in
-	the URL, e.g. svn+ssh://foo@svn.bar.com/project
+	transports (e.g. `svn+ssh://`), you must include the username in
+	the URL, e.g. `svn+ssh://foo@svn.bar.com/project`
 --prefix=<prefix>;;
 	This allows one to specify a prefix which is prepended
 	to the names of remotes if trunk/branches/tags are
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index f5b267e..034d10d 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -158,7 +158,7 @@ This option is only applicable when listing tags without annotation lines.
 CONFIGURATION
 -------------
 By default, 'git tag' in sign-with-default mode (-s) will use your
-committer identity (of the form "Your Name <\your@email.address>") to
+committer identity (of the form `Your Name <your@email.address>`) to
 find a key.  If you want to use a different default key, you can specify
 it in the repository configuration as follows:
 
-- 
2.4.0.192.g5f8138b
