From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC 4/4] commit: reinstate commit behavior before 3f6d56d via a config option
Date: Mon,  6 Jun 2016 18:16:43 +0700
Message-ID: <20160606111643.7122-5-pclouds@gmail.com>
References: <20160606111643.7122-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: thomas.braun@virtuell-zuhause.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 13:17:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9sWz-0008Hz-Jw
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 13:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbcFFLRN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 07:17:13 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36580 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbcFFLRL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 07:17:11 -0400
Received: by mail-pa0-f66.google.com with SMTP id fg1so11637366pad.3
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 04:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x1xW2HkscqMCwLfs7hyvuWpMBVPr0dHEOUeKlCL2KaE=;
        b=oqLZ0+zEkwBxnwHWSeV3iX78RuGUaMz5hI9QynOpA6AwchpF682tlM84NPs5klbww2
         so5Htnwki2PJkatg8/je6PydL3HdslP+dPZu7wXTOEV/M9bvTf8ez7m6mgJ2irTx3bgu
         eyjNUos7Tfo/sANJBtNLkSLNJGTKVQ6oyh2sn54yayFmOtLpvwi1JthxTXjSivCcfXQV
         F/Gz1g1z3MFfroUEDBkfn5NRyxHAidP0OX+0rG8T3noJAscfpN6t2pWk3wV1N7rRhSAT
         RafyaNgPGvJirxVOqtAwSLWDvg+819zlbCA+K5D73oXqpl6IDG/kFQ7Q41P7AwfoCE0P
         L7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x1xW2HkscqMCwLfs7hyvuWpMBVPr0dHEOUeKlCL2KaE=;
        b=gyXOiG1fZMwUEfBJ8Hthr0m/w5XlW+oQ5JkJzizOwp4Alw+PXgIWsL274GlYYbC9Lk
         V6xkDya4z92enO6QOJZCNrZ1uTVarT0zwin0CxJysL5pApD8+oaaVIjFJIIEavLvYZ21
         n8FfcsMlMPmYH/jXvGhcS/4C3qaso/2Rnht6qvipWxkEsIEGEy7eouTVCEOxYzUmAoYk
         537wKHzKz5ooJbxaQGPqMLVVO8vQGR+ocYvQZmycocLR19uqMRLnf4WROEIcDIgmulWg
         oDN3TgB483IigRkGwx8ZT5O1Umb8K/YFr+UfKayiHu5IdnQvjeK6YRIB3n++vMKrYuY+
         OsBg==
X-Gm-Message-State: ALyK8tKG54tyvO1R7m79Uv4k3/KI4jL6Qv4qBVHKlnnYp4KyTwlPa4jAxwgR+4oHPXLLsw==
X-Received: by 10.66.55.69 with SMTP id q5mr24100096pap.145.1465211830275;
        Mon, 06 Jun 2016 04:17:10 -0700 (PDT)
Received: from ash ([115.76.150.26])
        by smtp.gmail.com with ESMTPSA id c16sm26961894pfb.33.2016.06.06.04.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2016 04:17:09 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 06 Jun 2016 18:17:06 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160606111643.7122-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296501>

There are two groups of users with regards to "git add -N". One uses
i-t-a as a reminder that certain untracked files must be added before
the next commit. Erroring when i-t-a entries are still present
(i.e. real content not added) out gives the user a chance to add real
content.

The other group that sees i-t-a entries as a way to make Git aware of
some untracked paths so that "git diff" and "git status" show them
correctly. If they decide that some content should be staged for the
next commit, they "git add" again for real. If content in these paths i=
s
never added, the paths are simply ignored.

3f6d56d (commit: ignore intent-to-add entries instead of refusing -
2012-02-07) changes the behavior from the former to the latter. This
patch brings bach the former behavior if core.errorCommitIta is true.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache-tree.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index ddf0cc9..b87bd3c 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -155,20 +155,28 @@ static int verify_cache(struct cache_entry **cach=
e,
 {
 	int i, funny;
 	int silent =3D flags & WRITE_TREE_SILENT;
+	int core_error_commit_ita =3D 0;
+
+	git_config_get_bool("core.errorcommitita", &core_error_commit_ita);
=20
 	/* Verify that the tree is merged */
 	funny =3D 0;
 	for (i =3D 0; i < entries; i++) {
 		const struct cache_entry *ce =3D cache[i];
-		if (ce_stage(ce)) {
+		if (ce_stage(ce) ||
+		    (core_error_commit_ita && ce_intent_to_add(ce))) {
 			if (silent)
 				return -1;
 			if (10 < ++funny) {
 				fprintf(stderr, "...\n");
 				break;
 			}
-			fprintf(stderr, "%s: unmerged (%s)\n",
-				ce->name, sha1_to_hex(ce->sha1));
+			if (ce_stage(ce))
+				fprintf(stderr, "%s: unmerged (%s)\n",
+					ce->name, sha1_to_hex(ce->sha1));
+			else
+				fprintf(stderr, "%s: not added yet\n",
+					ce->name);
 		}
 	}
 	if (funny)
--=20
2.8.2.524.g6ff3d78
