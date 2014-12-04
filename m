From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/23] expire_reflog(): rename "ref" parameter to "refname"
Date: Fri,  5 Dec 2014 00:08:17 +0100
Message-ID: <1417734515-11812-6-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:16:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwfcv-0006mJ-EI
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933317AbaLDXP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:15:57 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52154 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933210AbaLDXP5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:15:57 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Dec 2014 18:15:57 EST
X-AuditID: 12074412-f79e46d0000036b4-93-5480e98130a2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id FE.82.14004.189E0845; Thu,  4 Dec 2014 18:08:49 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8de2027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:08:48 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqNv4siHE4HGjpEXXlW4mi4beK8wW
	b28uYbS4vWI+s0Vv3ydWi82b21kc2Dz+vv/A5LFz1l12jwWbSj0uXlL2+LxJLoA1itsmKbGk
	LDgzPU/fLoE7Y13zRqaCP/wV/5buY2lg7ObtYuTgkBAwkdjUb97FyAlkiklcuLeerYuRi0NI
	4DKjxNeVC9khnGNMEu9frGUGqWIT0JVY1NPMBGKLCKhJzFw1G6yDWeAEo8Svyd2MIAlhAW+J
	tX83gRWxCKhK3HrwkQlkG6+Ai8TyA4kQi+Uktq7zBqngFHCVmDqzFaxTCKji2aaF7BMYeRcw
	MqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXTy80s0UtNKd3ECAksoR2M60/KHWIU4GBU4uEt
	3F0fIsSaWFZcmXuIUZKDSUmU9+zThhAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrzGR4ByvCmJ
	lVWpRfkwKWkOFiVx3p+L1f2EBNITS1KzU1MLUotgsjIcHEoSvFwvgBoFi1LTUyvSMnNKENJM
	HJwgw7mkRIpT81JSixJLSzLiQXERXwyMDJAUD9DeMpB23uKCxFygKETrKUZFKXHeepCEAEgi
	ozQPbiwsXbxiFAf6Upi3FKSKB5hq4LpfAQ1mAhp8tqEWZHBJIkJKqoHRe++7AOHOTU8ldt+r
	FuHa1Or2hkV46Y4l/xj7JkxTqnGxV3y5w4u5a53rq4n1FpnzTa9m3vndvbsx7dSMM7PbvasT
	oySPLzDhvOk/7/EavrpG05Ie9ReHvdqXy7lxTrx8cM55PXf5cMWpSYUvvVh69j2f 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260831>

This is our usual convention.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/reflog.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 3e11bee..df302f4 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -349,7 +349,7 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1, int
 	return 0;
 }
 
-static int expire_reflog(const char *ref, const unsigned char *sha1, void *cb_data)
+static int expire_reflog(const char *refname, const unsigned char *sha1, void *cb_data)
 {
 	struct cmd_reflog_expire_cb *cmd = cb_data;
 	struct expire_reflog_cb cb;
@@ -365,20 +365,20 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, void *cb_da
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
@@ -407,7 +407,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, void *cb_da
 		mark_reachable(&cb);
 	}
 
-	for_each_reflog_ent(ref, expire_reflog_ent, &cb);
+	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
 
 	if (cb.unreachable_expire_kind != UE_ALWAYS) {
 		if (cb.unreachable_expire_kind == UE_HEAD) {
-- 
2.1.3
