From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] object.c: Fix a sparse warning
Date: Sat, 01 Jun 2013 18:46:11 +0100
Message-ID: <51AA3363.8030705@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Sat Jun 01 19:48:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uipuy-0006NY-Hj
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 19:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569Ab3FARs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 13:48:28 -0400
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:34962 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751289Ab3FARs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 13:48:27 -0400
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 524AC18CA6A;
	Sat,  1 Jun 2013 18:48:26 +0100 (BST)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 8E38118CA5E;
	Sat,  1 Jun 2013 18:48:25 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP;
	Sat,  1 Jun 2013 18:48:20 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226143>


Sparse issues an "'object_array_slopbuf' not declared. Should it be
static?" warning. In order to suppress the warning, since this
symbol does not need more than file visibility, we simply add the
static modifier to its declaration.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Michael,

If you need to re-roll the patches in your 'mh/reflife' branch,
could you please squash this into the patch corresponding to
commit cbdeb23e ("object_array_entry: fix memory handling of
the name field", 25-05-2013).

Thanks!

ATB,
Ramsay Jones

 object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object.c b/object.c
index 2976b2e..0de4c91 100644
--- a/object.c
+++ b/object.c
@@ -269,7 +269,7 @@ int object_list_contains(struct object_list *list, struct object *obj)
  * A zero-length string to which object_array_entry::name can be
  * initialized without requiring a malloc/free.
  */
-char object_array_slopbuf[1];
+static char object_array_slopbuf[1];
 
 static void add_object_array_with_mode_context(struct object *obj, const char *name,
 					       struct object_array *array,
-- 
1.8.3
