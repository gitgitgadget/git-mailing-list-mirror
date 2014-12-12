From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 05/24] expire_reflog(): rename "ref" parameter to "refname"
Date: Fri, 12 Dec 2014 09:56:44 +0100
Message-ID: <1418374623-5566-6-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:58:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM3Z-0005ZP-LO
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbaLLI6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:58:33 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:59919 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934675AbaLLI5U (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:20 -0500
X-AuditID: 12074414-f797f6d000004084-86-548aadef37d7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C0.13.16516.FEDAA845; Fri, 12 Dec 2014 03:57:19 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nF023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:18 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqPt+bVeIweaFkhZdV7qZLBp6rzBb
	vL25hNHi9or5zBa9fZ9YLTZvbmdxYPP4+/4Dk8fOWXfZPRZsKvW4eEnZ4/MmuQDWKG6bpMSS
	suDM9Dx9uwTujCP3l7IWfOKvOLa+gbmBsZm3i5GTQ0LARGLm9yvsELaYxIV769m6GLk4hAQu
	M0oc+3+ECcI5xiSx/8VKZpAqNgFdiUU9zUwgtoiAmsTEtkMsIDazwAlGidkNISC2sICfxPpN
	r1i7GDk4WARUJRrfVYKEeQWcJfq65jGChCUE5CS2rvMGCXMKuEhcbHkCNkUIqGTrik7WCYy8
	CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpWujlZpbopaaUbmKEBJbIDsYjJ+UOMQpwMCrx
	8L5I7QoRYk0sK67MPcQoycGkJMr7fTJQiC8pP6UyI7E4I76oNCe1+BCjBAezkgjv3yigHG9K
	YmVValE+TEqag0VJnPfbYnU/IYH0xJLU7NTUgtQimKwMB4eSBO/RNUCNgkWp6akVaZk5JQhp
	Jg5OkOFcUiLFqXkpqUWJpSUZ8aC4iC8GRgZIigdoL9takL3FBYm5QFGI1lOMilLivKdB5gqA
	JDJK8+DGwtLFK0ZxoC+FeR1BqniAqQau+xXQYCagwcu3dIAMLklESEk1MHY1a11vmnrqTtq3
	FlMviTDd3wU93mzMd65FL5ZyXvCyM5HZaHXysY8C0vtjI1hkiy/tkL9Ys2UL++QHSooKe+e6
	8h/eqqsuJiRx4ZBXr0br0YbI2zZbxLm+uwTeejAv5mfj/xaGNerRKw9tCWqrjz+U 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261344>

This is our usual convention.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/reflog.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 160541a..ff51dbf 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -349,7 +349,7 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1, int
 	return 0;
 }
 
-static int expire_reflog(const char *ref, const unsigned char *sha1,
+static int expire_reflog(const char *refname, const unsigned char *sha1,
 			 struct cmd_reflog_expire_cb *cmd)
 {
 	struct expire_reflog_cb cb;
@@ -365,20 +365,20 @@ static int expire_reflog(const char *ref, const unsigned char *sha1,
 	 * we take the lock for the ref itself to prevent it from
 	 * getting updated.
 	 */
-	lock = lock_any_ref_for_update(ref, sha1, 0, NULL);
+	lock = lock_any_ref_for_update(refname, sha1, 0, NULL);
 	if (!lock)
-		return error("cannot lock ref '%s'", ref);
-	log_file = git_pathdup("logs/%s", ref);
-	if (!reflog_exists(ref))
+		return error("cannot lock ref '%s'", refname);
+	log_file = git_pathdup("logs/%s", refname);
+	if (!reflog_exists(refname))
 		goto finish;
 	if (!cmd->dry_run) {
-		newlog_path = git_pathdup("logs/%s.lock", ref);
+		newlog_path = git_pathdup("logs/%s.lock", refname);
 		cb.newlog = fopen(newlog_path, "w");
 	}
 
 	cb.cmd = cmd;
 
-	if (!cmd->expire_unreachable || !strcmp(ref, "HEAD")) {
+	if (!cmd->expire_unreachable || !strcmp(refname, "HEAD")) {
 		tip_commit = NULL;
 		cb.unreachable_expire_kind = UE_HEAD;
 	} else {
@@ -407,7 +407,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1,
 		mark_reachable(&cb);
 	}
 
-	for_each_reflog_ent(ref, expire_reflog_ent, &cb);
+	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
 
 	if (cb.unreachable_expire_kind != UE_ALWAYS) {
 		if (cb.unreachable_expire_kind == UE_HEAD) {
-- 
2.1.3
