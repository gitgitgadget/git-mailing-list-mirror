Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7BC42376D
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208571; cv=none; b=RJ5MMVWH3jcqHgJZJRJ9pVpNbP+7bShMDNn8d64ORMlVwCwv0FAwf8RXSZFyECd43Anms1Rqizo5+TvtqZUk6/rvaIQJUTeHiPMIJJIuFBAPm9yWz8dA+1oHBo1IQ6PO7QFO8u+XP4bnnHMpSUjTS8fYdmqQZ2GXmHMvWW8nZZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208571; c=relaxed/simple;
	bh=OH3Dp4sfiXhGm585jlrpCwLrjAccLc/blmDWwk31oVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dwt3RYmNFr8/BNaRikAmIRT25uJ0bwMJ4LlQ+HhAx+YfAPekLlb9BNtqB9AuikhfiGuPWomsTCxza1086KPddiXzksLssWRKyA+D4HRkM48GH4kHFywLN/fJmA6BqTQkWd9qKz2dumlZCJiE2SpOs3e8qxuS0l4kSMrL21RFjRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j18+V04+; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j18+V04+"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so335630a91.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 06:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784208570; x=1784813370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F3kx+6cDE5yXv2teinNwnIIoA9DNgl7wFzkkNgDV9cc=;
        b=j18+V04+49ywAbQ9e69d8fky/2Fac5CIGRBy4fqmYPf2qRo2NBRLPIDx/LPJ59sJjA
         HEBExQL93KZhA57X0TT3NAgaOqAnQyroFVqlUmDSbrxwdCStF2M4t8CgZ9JHEcaMMTI5
         Xjn9FMrE8e1T5wmH4uXTzSK3ZalMTNnrfq/3Zg3kVn5kDoOdnM4DxypVptWYk1Y2Z4aO
         UdSUuKAKzkk8HbemujQstAVXRs8n05Foos8Xh/dBA2Pf4o3nl9lpqUe8N2laZGK15I0w
         IstXi/IMdeTEN9j73CZLvp6YX0SXcFOnHnOi69h2/n4Or0HKDTFwWjHeG221H7+hqhNf
         rpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208570; x=1784813370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F3kx+6cDE5yXv2teinNwnIIoA9DNgl7wFzkkNgDV9cc=;
        b=CPhXr2rjBYMUVdmZ6HrtmsKHYI+ybkh+Gq9kSk7ICepyMeCR+NCaRRC/TBr+QWH7Dz
         9TPPFoBHxr214BS9kXts/bU7we3jOUkko3Un9ritG1QsdgQUgKkNC6ki6HCfjcw9s0N8
         2i/BE+SKTBkhb3REZn401bNs53+boWmvXaFD6XKEEc60xDZvnJkzJ+sX41iAXtIQ40p9
         a2/w5W/gfBHQDzrjPVtlOiTn5XIU2bhLpBXdQ5C1wkDJ52y4koi7j4ldwGCrkB9vz07X
         v/CstqE4hV0dokaFN2ieIhvjA+LC3h8kxyUG036HhFDZAv27792AuroQQn3seMSbEh9o
         sQoQ==
X-Gm-Message-State: AOJu0YwO8P8jOtT9X/E9RxaIHhTXc32mxT0Fmvfm1W5+3AvXnuS429N0
	cdAf86TTbBwXZTSBeuN6Tji0g41rDZoFSbkU7yL0RKX1zS1erc/hzPLKl8geYTah
X-Gm-Gg: AfdE7cnB0H1Dv8jnrqd/LFH/emP/+/co0xyYxwJbluqVb0nmPrMR5RbGYeEzch/ajeJ
	unASgX15NdTsMqnqYGAfs4Jze/IGzFUSgYAgMc2DOU1HQSmpay49R23kzQecDj8SrW4Sh59cfQI
	SnYggUyrBRWM9YqgqI1i+VbsuuR4Ki+LhvC4Eynwk6dA7EMAE60heUXUucEQ/43nV34juZtS6Dq
	oVb4XLhVtl3x3egosiGZhYKcN0WTUWc7/mtpsBvSSInIDF/wxzEnGT1OdQg50OovhiAHk1YLeVK
	uUaFEafG8fYLacDrD5binw1ody8PyTwwoR3NjS+APrk7MhUrNA86Wbv87Q01bkAzGhYQicjsJiV
	vU8Tx4Q3UzkHRG/sNxeiXqxw66qIGEzz/q5Gxz1RUHy6I9RdWcJb595dl7MWorgDSrS5zxY/9yo
	nFYRkGgokaSEAX34Gx8/F89wL0qym8LqNSU0OqWrmEPgn/fzNGCXwe+J/K6TcsPQMVnXZD4u721
	t7aXpTJR+UMwqWa9x1cBoPaoC3/mqfT0u8KdFA1C/6h
X-Received: by 2002:a17:90b:5291:b0:385:39ac:fe4b with SMTP id 98e67ed59e1d1-38e3d26bc3dmr2596381a91.17.1784208569411;
        Thu, 16 Jul 2026 06:29:29 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:88fb:4543:3010:936c:4da8:7aa1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e4fcd31sm13291188eec.4.2026.07.16.06.29.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 06:29:29 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [RFC PATCH 3/7] repack-promisor: allow excluding objects from the rebuilt promisor pack
Date: Thu, 16 Jul 2026 18:58:44 +0530
Message-ID: <20260716132848.95982-4-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a to_drop oidset parameter to repack_promisor_objects(). When it is
non-NULL, write_oid() omits those objects from the rebuilt promisor
pack. This is the mechanism --drop-filtered will use to remove promisor
blobs, i.e. rebuild the promisor pack without them.

All existing callers pass NULL, so behavior is unchanged.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 builtin/repack.c  |  2 +-
 repack-promisor.c | 15 ++++++++++++++-
 repack.h          |  4 +++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index f4db0fc535..433b2c8205 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -406,7 +406,7 @@ int cmd_repack(int argc,
 		strvec_push(&cmd.args, "--delta-islands");
 
 	if (pack_everything & ALL_INTO_ONE) {
-		repack_promisor_objects(repo, &po_args, &names, packtmp);
+		repack_promisor_objects(repo, &po_args, &names, packtmp, NULL);
 
 		if (existing_packs_has_non_kept(&existing) &&
 		    delete_redundant &&
diff --git a/repack-promisor.c b/repack-promisor.c
index 90318ce150..fabfdc168a 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -6,10 +6,12 @@
 #include "path.h"
 #include "repository.h"
 #include "run-command.h"
+#include "oidset.h"
 
 struct write_oid_context {
 	struct child_process *cmd;
 	const struct git_hash_algo *algop;
+	const struct oidset *to_drop;
 };
 
 /*
@@ -23,6 +25,15 @@ static int write_oid(const struct object_id *oid,
 	struct write_oid_context *ctx = data;
 	struct child_process *cmd = ctx->cmd;
 
+	/*
+	 * Objects in to_drop are being removed from the repository, so
+	 * omit them from the rebuilt promisor pack. Each such object is a
+	 * promisor object and therefore remains recoverable from the
+	 * promisor remote.
+	 */
+	if (ctx->to_drop && oidset_contains(ctx->to_drop, oid))
+		return 0;
+
 	if (cmd->in == -1) {
 		if (start_command(cmd))
 			die(_("could not start pack-objects to repack promisor objects"));
@@ -81,7 +92,8 @@ static void finish_repacking_promisor_objects(struct repository *repo,
 
 void repack_promisor_objects(struct repository *repo,
 			     const struct pack_objects_args *args,
-			     struct string_list *names, const char *packtmp)
+			     struct string_list *names, const char *packtmp,
+			     const struct oidset *to_drop)
 {
 	struct write_oid_context ctx;
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -98,6 +110,7 @@ void repack_promisor_objects(struct repository *repo,
 	 */
 	ctx.cmd = &cmd;
 	ctx.algop = repo->hash_algo;
+	ctx.to_drop = to_drop;
 	odb_for_each_object(repo->objects, NULL, write_oid, &ctx,
 			    ODB_FOR_EACH_OBJECT_PROMISOR_ONLY);
 
diff --git a/repack.h b/repack.h
index f9fbc895f0..a5a3f7c6ba 100644
--- a/repack.h
+++ b/repack.h
@@ -3,6 +3,7 @@
 
 #include "list-objects-filter-options.h"
 #include "string-list.h"
+#include "oidset.h"
 
 struct pack_objects_args {
 	char *window;
@@ -100,7 +101,8 @@ void generated_pack_install(struct generated_pack *pack, const char *name,
 
 void repack_promisor_objects(struct repository *repo,
 			     const struct pack_objects_args *args,
-			     struct string_list *names, const char *packtmp);
+			     struct string_list *names, const char *packtmp,
+			     const struct oidset *to_drop);
 
 struct pack_geometry {
 	struct packed_git **pack;
-- 
2.54.0

