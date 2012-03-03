From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] http.proxy: also mention https_proxy and all_proxy
Date: Sat, 3 Mar 2012 15:50:53 +0100
Message-ID: <20120303145053.GA29948@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 15:59:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3qQi-0006wf-Js
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 15:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813Ab2CCO7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 09:59:24 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:55592 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753762Ab2CCO7X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 09:59:23 -0500
Received: from localhost (p5B22F7B3.dip.t-dialin.net [91.34.247.179])
	by bsmtp.bon.at (Postfix) with ESMTP id ECFFA2C4005;
	Sat,  3 Mar 2012 15:59:29 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192115>

The current wording of the http.proxy documentation suggests that
http_proxy is somehow equivalent to http.proxy. However, while
http.proxy (by the means of curl's CURLOPT_PROXY option) overrides the
proxy for both HTTP and HTTPS protocols, the http_proxy environment
variable is used only for HTTP. But since the docs mention only
http_proxy, a user might expect it to apply to all HTTP-like protocols.

Avoid any such misunderstanding by explicitly mentioning https_proxy and
all_proxy as well.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

As you can maybe guess from the commit message, I was bitten by this
myself. I also found a couple of questions online where users were
expecting the http_proxy environment variable to apply to HTTPS as well.
Hopefully, this will prevent some confusion in the future.

Clemens

 Documentation/config.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index abeb82b..7d197bb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1258,9 +1258,10 @@ help.autocorrect::
 	This is the default.
 
 http.proxy::
-	Override the HTTP proxy, normally configured using the 'http_proxy'
-	environment variable (see linkgit:curl[1]).  This can be overridden
-	on a per-remote basis; see remote.<name>.proxy
+	Override the HTTP proxy, normally configured using the 'http_proxy',
+	'https_proxy', and 'all_proxy' environment variables (see
+	linkgit:curl[1]).  This can be overridden on a per-remote basis; see
+	remote.<name>.proxy
 
 http.cookiefile::
 	File containing previously stored cookie lines which should be used
-- 
1.7.9.1
