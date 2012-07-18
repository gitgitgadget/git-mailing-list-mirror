From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] docs/credential: minor clarity fixups
Date: Wed, 18 Jul 2012 08:04:02 -0400
Message-ID: <20120718120401.GA6726@sigill.intra.peff.net>
References: <20120718120307.GA6399@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jul 18 14:04:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrSzD-0005s8-OS
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 14:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152Ab2GRMEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 08:04:06 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39069
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753257Ab2GRMEF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 08:04:05 -0400
Received: (qmail 18904 invoked by uid 107); 18 Jul 2012 12:04:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jul 2012 08:04:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2012 08:04:02 -0400
Content-Disposition: inline
In-Reply-To: <20120718120307.GA6399@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201677>

The text in git-credential(1) was copied from
technical/api-credentials, so it still talks about the
input/output format as coming from git to the helper. Since
the surrounding text already indicates that this format is
used for reading and writing with git credential, we can
just remove the extraneous confusing bits.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-credential.txt | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index a81684e..afd5365 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -102,22 +102,20 @@ INPUT/OUTPUT FORMAT
 -------------------
 
 `git credential` reads and/or writes (depending on the action used)
-credential information in its standard input/output. These information
+credential information in its standard input/output. This information
 can correspond either to keys for which `git credential` will obtain
 the login/password information (e.g. host, protocol, path), or to the
 actual credential data to be obtained (login/password).
 
-The credential is split into a set of named attributes.
-Attributes are provided to the helper, one per line. Each attribute is
+The credential is split into a set of named attributes, with one
+attribute per line. Each attribute is
 specified by a key-value pair, separated by an `=` (equals) sign,
 followed by a newline. The key may contain any bytes except `=`,
 newline, or NUL. The value may contain any bytes except newline or NUL.
 In both cases, all bytes are treated as-is (i.e., there is no quoting,
 and one cannot transmit a value with newline or NUL in it). The list of
 attributes is terminated by a blank line or end-of-file.
-Git will send the following attributes (but may not send all of
-them for a given credential; for example, a `host` attribute makes no
-sense when dealing with a non-network protocol):
+Git understands the following attributes:
 
 `protocol`::
 
-- 
1.7.10.5.40.g059818d
