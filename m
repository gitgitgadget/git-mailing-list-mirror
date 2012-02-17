From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] docs/api-config: minor clarifications
Date: Fri, 17 Feb 2012 03:18:38 -0500
Message-ID: <20120217081838.GA11418@sigill.intra.peff.net>
References: <20120217032325.GB5738@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 12:38:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyM9I-0006NG-Qs
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 12:38:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501Ab2BQLi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 06:38:28 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41018
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097Ab2BQLi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 06:38:27 -0500
Received: (qmail 6397 invoked by uid 107); 17 Feb 2012 08:25:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 17 Feb 2012 03:25:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2012 03:18:38 -0500
Content-Disposition: inline
In-Reply-To: <20120217032325.GB5738@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190952>

The first change simply drops some parentheses to make a
statement more clear. The seconds clarifies that almost
nobody wants to call git_config_early.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-config.txt |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index c60b6b3..67984da 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -11,9 +11,9 @@ General Usage
 Config files are parsed linearly, and each variable found is passed to a
 caller-provided callback function. The callback function is responsible
 for any actions to be taken on the config option, and is free to ignore
-some options (it is not uncommon for the configuration to be parsed
+some options. It is not uncommon for the configuration to be parsed
 several times during the run of a git program, with different callbacks
-picking out different variables useful to themselves).
+picking out different variables useful to themselves.
 
 A config callback function takes three parameters:
 
@@ -47,11 +47,12 @@ will first feed the user-wide one to the callback, and then the
 repo-specific one; by overwriting, the higher-priority repo-specific
 value is left at the end).
 
-There is a special version of `git_config` called `git_config_early`
-that takes an additional parameter to specify the repository config.
-This should be used early in a git program when the repository location
-has not yet been determined (and calling the usual lazy-evaluation
-lookup rules would yield an incorrect location).
+There is a special version of `git_config` called `git_config_early`.
+This version takes an additional parameter to specify the repository
+config, instead of having it looked up via `git_path`. This is useful
+early in a git program before the repository has been found. Unless
+you're working with early setup code, you probably don't want to use
+this.
 
 Reading Specific Files
 ----------------------
-- 
1.7.9.9.gcf58
