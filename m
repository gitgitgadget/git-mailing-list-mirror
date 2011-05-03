From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 3/4] http-push: use const for strings in signatures
Date: Tue,  3 May 2011 23:47:28 +0800
Message-ID: <1304437649-7052-4-git-send-email-rctay89@gmail.com>
References: <1304437649-7052-1-git-send-email-rctay89@gmail.com>
 <1304437649-7052-2-git-send-email-rctay89@gmail.com>
 <1304437649-7052-3-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dan McGee <dpmcgee@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 17:48:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHHpR-0003ZP-Sz
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 17:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282Ab1ECPr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 11:47:57 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52284 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154Ab1ECPrz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 11:47:55 -0400
Received: by pzk9 with SMTP id 9so85177pzk.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 08:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=yceGNIs5Ube9V4R2w8Fiu3t3VEqAXCoxCeZ6y0+p3Ao=;
        b=PGPZxX4uCuNs6dOnMXs8W39eG4rqnjy6Jcx6ej0GAM1EjLwUR21KXzRX9f51G1BrJV
         p/wgKlKHTBFtq4KYZQ/JZejdx8PgCldIlAVF9ujb0vb7Ua5RBpEwtbpOn9pfgpSrqrc9
         qI8MLefMrh2LYW8CZ9hYW9ef9cW04x+FxJjgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=T0GKfwmpSNxtuchMRYizJOzyMUpAb1cPp5KqOwfvKt2Amvs2F7K0aJpTwPIjqHw0gw
         U3TmUf7Lg8pikjcfERnCt12FhsghOjlDjt2K3qke9k9+YjVTJ0LpqkVvphItWOg67nIG
         wQ2Dxss6ckEHxciOuRBOvVjU5KO3YjUxlAnNE=
Received: by 10.68.49.103 with SMTP id t7mr10116385pbn.330.1304437675238;
        Tue, 03 May 2011 08:47:55 -0700 (PDT)
Received: from localhost.localdomain (cm134.beta238.maxonline.com.sg [116.86.238.134])
        by mx.google.com with ESMTPS id p7sm117856pbp.1.2011.05.03.08.47.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 May 2011 08:47:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.3.585.g74f6e
In-Reply-To: <1304437649-7052-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172665>

From: Dan McGee <dpmcgee@gmail.com>

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Split off from patch #4.

 http-push.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/http-push.c b/http-push.c
index d18346c..0fce38d 100644
--- a/http-push.c
+++ b/http-push.c
@@ -169,7 +169,7 @@ enum dav_header_flag {
 	DAV_HEADER_TIMEOUT = (1u << 2)
 };
 
-static char *xml_entities(char *s)
+static char *xml_entities(const char *s)
 {
 	struct strbuf buf = STRBUF_INIT;
 	while (*s) {
@@ -797,7 +797,7 @@ static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
 	}
 }
 
-static void one_remote_ref(char *refname);
+static void one_remote_ref(const char *refname);
 
 static void
 xml_start_tag(void *userData, const char *name, const char **atts)
@@ -1471,7 +1471,7 @@ static int update_remote(unsigned char *sha1, struct remote_lock *lock)
 
 static struct ref *remote_refs;
 
-static void one_remote_ref(char *refname)
+static void one_remote_ref(const char *refname)
 {
 	struct ref *ref;
 	struct object *obj;
@@ -1660,7 +1660,7 @@ static int verify_merge_base(unsigned char *head_sha1, unsigned char *branch_sha
 	return (merge_bases && !merge_bases->next && merge_bases->item == branch);
 }
 
-static int delete_remote_branch(char *pattern, int force)
+static int delete_remote_branch(const char *pattern, int force)
 {
 	struct ref *refs = remote_refs;
 	struct ref *remote_ref = NULL;
-- 
1.7.3.3.585.g74f6e
