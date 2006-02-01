From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] Use local structs for HTTP slot callback data
Date: Tue, 31 Jan 2006 18:00:37 -0800
Message-ID: <20060201020037.GG3873@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Feb 01 03:00:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F47Im-0003Ed-TQ
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 03:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWBACAi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 21:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWBACAi
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 21:00:38 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:25748 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S964851AbWBACAh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 21:00:37 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k1120bkW009985
	for <git@vger.kernel.org>; Tue, 31 Jan 2006 18:00:37 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k1120brl009983
	for git@vger.kernel.org; Tue, 31 Jan 2006 18:00:37 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15374>

There's no need for these structures to be static, and it could potentially
cause problems down the road.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 http-fetch.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

6146f9e8be9d4bb49b7008af5b99853ee7c0afc1
diff --git a/http-fetch.c b/http-fetch.c
index 92326f9..97ce13c 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -375,7 +375,7 @@ static int fetch_index(struct alt_base *
 
 	FILE *indexfile;
 	struct active_request_slot *slot;
-	static struct slot_results results;
+	struct slot_results results;
 
 	if (has_pack_index(sha1))
 		return 0;
@@ -555,7 +555,7 @@ static void fetch_alternates(char *base)
 	char *url;
 	char *data;
 	struct active_request_slot *slot;
-	static struct alternates_request alt_req;
+	struct alternates_request alt_req;
 
 	/* If another request has already started fetching alternates,
 	   wait for them to arrive and return to processing this request's
@@ -618,7 +618,7 @@ static int fetch_indices(struct alt_base
 	int i = 0;
 
 	struct active_request_slot *slot;
-	static struct slot_results results;
+	struct slot_results results;
 
 	if (repo->got_indices)
 		return 0;
@@ -699,7 +699,7 @@ static int fetch_pack(struct alt_base *r
 	struct curl_slist *range_header = NULL;
 
 	struct active_request_slot *slot;
-	static struct slot_results results;
+	struct slot_results results;
 
 	if (fetch_indices(repo))
 		return -1;
@@ -900,7 +900,7 @@ int fetch_ref(char *ref, unsigned char *
         struct buffer buffer;
 	char *base = alt->base;
 	struct active_request_slot *slot;
-	static struct slot_results results;
+	struct slot_results results;
         buffer.size = 41;
         buffer.posn = 0;
         buffer.buffer = hex;
-- 
1.1.6.g1417-dirty
