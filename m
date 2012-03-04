From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH v2] http.proxy: also mention https_proxy and all_proxy
Date: Sun, 4 Mar 2012 17:50:43 +0100
Message-ID: <20120304165043.GA4677@ecki>
References: <20120303145053.GA29948@ecki>
 <20120303174252.GC28602@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 04 17:59:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Emf-0001vS-1n
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 17:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535Ab2CDQ7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 11:59:12 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:36227 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754518Ab2CDQ7L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 11:59:11 -0500
Received: from localhost (p5B22CFB9.dip.t-dialin.net [91.34.207.185])
	by bsmtp.bon.at (Postfix) with ESMTP id 19713130044;
	Sun,  4 Mar 2012 17:59:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120303174252.GC28602@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192166>

The current wording of the http.proxy documentation suggests that
http_proxy is somehow equivalent to http.proxy. However, while
http.proxy (by the means of curl's CURLOPT_PROXY option) overrides the
proxy for both HTTP and HTTPS protocols, the http_proxy environment
variable is used only for HTTP. But since the docs mention only
http_proxy, a user might expect it to apply to all HTTP-like protocols.

Avoid any such misunderstanding by explicitly mentioning https_proxy and
all_proxy as well.

Also replace linkgit:curl[1] with a literal 'curl(1)', because the
former gets translated to a dead link in the HTML pages.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Sat, Mar 03, 2012 at 12:42:52PM -0500, Jeff King wrote:
>
> I think just using: `curl(1)` might be sufficient.

Done.

 Documentation/config.txt |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index abeb82b..f0ab288 100644
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
+	`curl(1)`).  This can be overridden on a per-remote basis; see
+	remote.<name>.proxy
 
 http.cookiefile::
 	File containing previously stored cookie lines which should be used
-- 
1.7.9.2
