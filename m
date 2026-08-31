Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E643C1400
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158798; cv=none; b=mFg786wYMliqPJI6EaWr5g56wcsdEENw4wTCQljdZJW8455vIHd68kxvxxfMzkoHLDbfobSKeNVmdKdf+MTo/yiBShojPQnZuyZlHNykiu4KwAP1qqLwmLtnaLxCD4OMkjwsI9xTGKT7XdbugZROqlaiqu1WY/138CQulB0u1tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158798; c=relaxed/simple;
	bh=EmxNwMDquZ+7ykuocYAy8CX1aQSYJQ3BwR5XOAc+6BE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dZMV2s9/SozOogVjq4eGc9R8a5B+FxaVmSVbQnPFw0DU1AASvLfnlLt74pV+tPovynbzzX3S2moWxb6/sJxRzE7hAWLvUD/Zu3UvLmI+4+pA4e6Lm/k6EDqDQuWWKpe4xsqnSxEprFmB+1JtkJv2UvkcWUZhhX+WJR0ZCTR7FTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FKjgdhRs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xum1QjQP; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FKjgdhRs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xum1QjQP"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3A1037A0115;
	Mon, 31 Aug 2026 02:46:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 31 Aug 2026 02:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788158796;
	 x=1788245196; bh=GQt1aHuuLhqY+zaZvpHM5d/PtpmG4JSmekQxFRpMRsc=; b=
	FKjgdhRsg1g7oOMVacep7qRoJHeY4D5rwLb/7ZwuvhN18tyYjA9KrKfBh6KLD3VA
	NSmkSonwNqu+nmtTLmvkmX2mrPvb4tSLDiiouPIAg77uDN41CWsD1sU8XiOEKA5g
	O3Zfd80hIH8MK6/uWsynk9t6O4tLLGkt0q9o2TFhS+Ch6RyOaCWw6cTmNrWtRQdw
	BgyMeXOyRsmp6AhP77KZXVipf9QHi+t09akFtFeatWhL2Ow5ddIiSnw93PPsg7AC
	NQlGgvgMoMQz5HiFsjiih1Oh1QZModZAao40BfDktGPJNHR5wZ1TngxhoxLaRS1G
	AadsehMy21o4921+NNCQKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788158796; x=
	1788245196; bh=GQt1aHuuLhqY+zaZvpHM5d/PtpmG4JSmekQxFRpMRsc=; b=X
	um1QjQPlbRFp2NtuDDsuL5BeZQ7+yHyRNCqbua6RjMWZPFQxm6Bwaht98clmXnQL
	9BqNAzh1JdSn2MI44lryBHfZxZaZNIe8cBnhIzN89wlRtZA+MrQFKVnrySpqaEHN
	6Ma1qui/dLkgG9draHE8bL8712SmxfWXQWiW/mVth3Rvai7JiMw97VUujGlvIIyV
	+rTAHcH2PLsdqF+kZM+lrbTEaAzICEm8FLebm+ENrPLCHhFJprwYh58CGGoFX3lZ
	G8N7Rr20eyTyhMOAy5vodhcBzyz3F2O9Vd5qhBK98WVRzP3i46HjlayRlEvrcr8B
	wT+8iR2T48LyEEvNYCrPg==
X-ME-Sender: <xms:TCOVavWaIbYlQYUJf6Z-MQHY2PMkyNZCPwYXXaDWnsMALUeCWJ5_jQ>
    <xme:TCOVatm39uXEQYfuoHQlT-X7aDECb92ClE6SvPh2tBKgKNHn8xUcdq-s8i7L8H6AN
    QT372qn49aN25skDgpOtaVhNuUq2YLcKG--mmv6KyuiUZXH6yN2hA>
X-ME-Received: <xmr:TCOVapAzjnGbi2PB0E22jhVj8DdsNSS6WQRmj_tAsyJ7VUt5y7YGGlmcrElx_oOovoy_6A>
X-ME-Proxy-Cause: dmFkZTGC6azt8fZxsbiV4h74gPgiyQrFs8RtvLQk63BD8aaoeZRbwo5JXHdlCvDI7cZbse
    9DMAH3qggFq55LinW++2wt+D9bLEjcMs+Da4yzi4h17iFwcUrfN5bOMfBfpLWSICecUplo
    Qqa9ZFl0tMY6nHTXiPQ9qQ95qP/YznRt1OAkm3DMkT60CvRVS9eFQ+NN89uLhlxp0/C9bD
    ZhZHLm8K95v8OTDdtTo4U0AnkrlF/sZKYPryZXeiiaVyBmFQCGhSuT3E0INtAtgo6q11XH
    D9HZ7uOPQCldHKsos50b3VhukfBJxQWsFSx9BucRfzYiGZU6XVi6aJ1iVDK0Qh1386OdRG
    9oqloTZ/CESvCqHzcW/g3GPaPYQRsn92M9Q3YuJJJYk+FXYgUGGpcoizEoR0g+P4UHgBuL
    lFbHxoB7M+5+3M3TENyygqEfIlIv8HkBXi10jCf/CDHmRs7TuIjHtsQWbNUd9ARnmTqLYA
    OwJ2EAHgD+5EGI8ZzzLQcOxBsc4YZL6dZOaiF+ncb9hM6/JHgbarnPQxIv3YsMq4q42hEC
    m1ieKItIaiu8358PIGjIpWTqcGKqW/B10eD3NLGZKgsRc2FlOVMK/euRftc5RsDztoZoTG
    MMtoeW/YxsMGw8AWFs6gkMw6kdzQApdnEoc2Kru3gvAzQsM7dj30Wr0qZFHQ
X-ME-Proxy: <xmx:TCOValedeaxQNwkOmgP__2xY4sJjVhWO9PGNWSb_Rsee_fVuuW9n8g>
    <xmx:TCOVasKlHht0i8-crW0bVJXsgNRuZBpKqb6zmcb5j1v4HkAw9AXzLA>
    <xmx:TCOVagfLaL15Nl3UtW3apFBGpWbT5keNTGoyP3O8RXPClGN3xoG0ig>
    <xmx:TCOVar1uD-TzFjtw3tLrtPAK_Wl_corpIlaXY4XS3jYG0LQZI_a1iQ>
    <xmx:TCOVakF9vsJCjIzNWYZpqquO2oNamPF0Vjfq4chqiwN2-KRboWyXHVGm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:46:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3a660395 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:46:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Aug 2026 08:46:20 +0200
Subject: [PATCH v2 06/10] builtin/fsck: move packfile verification into the
 packed source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-pks-odb-source-fsck-v2-6-f9b16ef4957b@pks.im>
References: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
In-Reply-To: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Move the packfile verification out of `cmd_fsck()` and into the "packed"
source. While doing so, thread the progress meter and object callback
through the newly introduced `struct odb_fsck_options` so that the
caller's preferences are honoured without exposing those details at the
"builtin/fsck.c" level.

Note that the old code reported failures when verifying packfiles with
the `ERROR_PACK` bit, which gets returned to the caller via the exit
code. This bit is neither exercised in our test suite nor is it
documented anywhere in our codebase. Furthermore, this bit is highly
specific to the object storage backend, which makes it a bad fit for the
new pluggable infrastructure. So instead of retaining these semantics,
we drop them and return the generic `ERROR_OBJECT` bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c      | 33 ++++-----------------------------
 odb.h               |  7 +++++++
 odb/source-packed.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 54 insertions(+), 32 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index adbe192e56..e504dae904 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -7,7 +7,6 @@
 #include "blob.h"
 #include "tag.h"
 #include "refs.h"
-#include "pack.h"
 #include "cache-tree.h"
 #include "fsck.h"
 #include "parse-options.h"
@@ -49,7 +48,6 @@ static int show_dangling = 1;
 static timestamp_t now;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
-#define ERROR_PACK 04
 #define ERROR_REFS 010
 #define ERROR_COMMIT_GRAPH 020
 #define ERROR_MULTI_PACK_INDEX 040
@@ -967,6 +965,8 @@ int cmd_fsck(int argc,
 {
 	struct odb_fsck_options odb_fsck_opts = {
 		.flags = ODB_FSCK_FULL,
+		.object_cb = fsck_obj_buffer,
+		.object_payload = repo,
 	};
 	int keep_cache_objects = 0;
 	int name_objects = 0;
@@ -1019,6 +1019,8 @@ int cmd_fsck(int argc,
 		show_progress = isatty(2);
 	if (verbose)
 		show_progress = 0;
+	if (show_progress)
+		odb_fsck_opts.flags |= ODB_FSCK_PROGRESS;
 
 	if (write_lost_and_found) {
 		odb_fsck_opts.flags |= ODB_FSCK_FULL;
@@ -1056,33 +1058,6 @@ int cmd_fsck(int argc,
 		if (odb_fsck(repo->objects, &odb_fsck_opts) < 0)
 			errors_found |= ERROR_OBJECT;
 
-		if (odb_fsck_opts.flags & ODB_FSCK_FULL) {
-			struct packed_git *p;
-			uint32_t total = 0, count = 0;
-			struct progress *progress = NULL;
-
-			if (show_progress) {
-				repo_for_each_pack(repo, p) {
-					if (open_pack_index(p))
-						continue;
-					total += p->num_objects;
-				}
-
-				progress = start_progress(repo,
-							  _("Checking objects"), total);
-			}
-
-			repo_for_each_pack(repo, p) {
-				/* verify gives error messages itself */
-				if (verify_pack(repo,
-						p, fsck_obj_buffer, repo,
-						progress, count))
-					errors_found |= ERROR_PACK;
-				count += p->num_objects;
-			}
-			stop_progress(&progress);
-		}
-
 		if (fsck_finish(&fsck_obj_options))
 			errors_found |= ERROR_OBJECT;
 	}
diff --git a/odb.h b/odb.h
index 76c15e48f5..0bf6c8d7d2 100644
--- a/odb.h
+++ b/odb.h
@@ -215,11 +215,18 @@ enum odb_fsck_flags {
 	 * verification of their metadata.
 	 */
 	ODB_FSCK_FULL = (1 << 0),
+
+	/* Display a progress meter, if sensible. */
+	ODB_FSCK_PROGRESS = (1 << 1),
 };
 
 /* Options that shall be passed to `odb_fsck()`. */
 struct odb_fsck_options {
 	enum odb_fsck_flags flags;
+
+	int (*object_cb)(const struct object_id *oid, enum object_type type,
+			 unsigned long size, void *buffer, int *eaten, void *cb_data);
+	void *object_payload;
 };
 
 /*
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 7aacf4bc45..0d3599f8fe 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -9,8 +9,10 @@
 #include "midx.h"
 #include "odb/source-packed.h"
 #include "odb/streaming.h"
+#include "pack.h"
 #include "packfile.h"
 #include "pack-bitmap.h"
+#include "progress.h"
 
 static int find_pack_entry(struct odb_source_packed *store,
 			   const struct object_id *oid,
@@ -827,10 +829,48 @@ static void odb_source_packed_free(struct odb_source *source)
 	free(packed);
 }
 
-static int odb_source_packed_fsck(struct odb_source *source UNUSED,
-				  struct odb_fsck_options *opts UNUSED)
+static int verify_packs(struct odb_source_packed *source,
+			struct odb_fsck_options *opts)
 {
-	return 0;
+	struct progress *progress = NULL;
+	struct packfile_list_entry *e;
+	uint32_t total = 0, count = 0;
+	int ret = 0;
+
+	if (opts->flags & ODB_FSCK_PROGRESS) {
+		for (e = packfile_store_get_packs(source); e; e = e->next) {
+			if (open_pack_index(e->pack))
+				continue;
+			total += e->pack->num_objects;
+		}
+
+		progress = start_progress(source->base.odb->repo,
+					  _("Checking objects"), total);
+	}
+
+	for (e = packfile_store_get_packs(source); e; e = e->next) {
+		/* verify gives error messages itself */
+		if (verify_pack(source->base.odb->repo, e->pack,
+				opts->object_cb, opts->object_payload,
+				progress, count))
+			ret = -1;
+		count += e->pack->num_objects;
+	}
+	stop_progress(&progress);
+
+	return ret;
+}
+
+static int odb_source_packed_fsck(struct odb_source *source,
+				  struct odb_fsck_options *opts)
+{
+	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+	int ret = 0;
+
+	if ((opts->flags & ODB_FSCK_FULL) && verify_packs(packed, opts) < 0)
+		ret = -1;
+
+	return ret;
 }
 
 struct odb_source_packed *odb_source_packed_new(struct object_database *odb,

-- 
2.55.0.979.g7e5102b832.dirty

