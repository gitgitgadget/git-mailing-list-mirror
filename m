From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] http-push: don't assume char is signed
Date: Mon, 20 Mar 2006 11:50:51 -0800
Message-ID: <20060320195051.GM3997@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Mar 20 20:51:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLQP2-00051N-2P
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 20:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWCTTux (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 14:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWCTTux
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 14:50:53 -0500
Received: from 241.37.26.69.virtela.com ([69.26.37.241]:1357 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S964950AbWCTTuw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Mar 2006 14:50:52 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k2KJoqN2012451
	for <git@vger.kernel.org>; Mon, 20 Mar 2006 11:50:52 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k2KJopYC012449
	for git@vger.kernel.org; Mon, 20 Mar 2006 11:50:51 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17763>

Declare remote_dir_exists[] as signed char to be sure that values of -1
are valid.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

446e5a54db80664a0ae2a418766811136952067e
diff --git a/http-push.c b/http-push.c
index 42b0d59..a35e74d 100644
--- a/http-push.c
+++ b/http-push.c
@@ -66,7 +66,7 @@ enum XML_Status {
 
 static int pushing = 0;
 static int aborted = 0;
-static char remote_dir_exists[256];
+static signed char remote_dir_exists[256];
 
 static struct curl_slist *no_pragma_header;
 static struct curl_slist *default_headers;
-- 
1.2.4.g55c6-dirty
