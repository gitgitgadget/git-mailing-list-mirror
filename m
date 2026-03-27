Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AE134F49C
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627965; cv=none; b=dMnTEsL6a9ml7pSmTssrR5IL+HF7IzQGjA4gHNzGoaIKuZGv5cZ6ln+bJzCFZl/YwNflqcixgbw8r7CrzvpQHjQBy8Gap8KfiDOF6h3xsJxV4IA1azvHiuRx+X/qVDV1rGunGK6ccJNE0bsUomfuYWeVZNLDve1KXJW9uLGzt3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627965; c=relaxed/simple;
	bh=6AREtm540bmrdXjOyrUYvIra1l1HxmzXPL2GUQj8ju8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IHcWvVbOk3ZsLnxHHTNpV5+xOhWa/mqHvayHUqQvgjFrbmpmDwiBQcUaZ3vf2Db+8S8VOMx1YkI6e1dhYriG7rSLMeszZCTp3e91r8TctYPJbPxGKZfTa6WyDsr0RCcrFyQj7UfvVEQxD5tVr7lJFAnOBi0rkV3mKJNvTbll/j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oowEz3qp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oowEz3qp"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486fd27754bso21598965e9.3
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774627960; x=1775232760; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r+nhc0kGw0g35W0beA+CqNWtCwu6jsFyM6+lIkeFjMc=;
        b=oowEz3qpVJUJj7pDt75blD8RYPRcqYkFI476w5RmOpMXq/m6mkRpNr1t/CFSaphDHk
         oL57/+gxzPOcBOaMFq1ly4QcCkmx/Sp05ltYw3ZV6+Pb45SlaNAPN9Wt/aRMghNjRn/6
         5OZfGATRi7gD91/3dZ+3vaDyrrnPScGfysNoTNdD06PSzE3i/mn3lqlJOcQ0Imw1+EC5
         IlhiEFttJnJBwQ7eQpaJYjqmjq9x14X7DqCWSTF+RFEkDFAy4VEWYAYZvtCn/ICREJ0W
         wNOo1sqlImG/RcaqJVkMQ+X7QmkKICZCYkPI4AFCMYumjw80IybbHHh+0QNxHbvlKwdB
         KDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774627960; x=1775232760;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+nhc0kGw0g35W0beA+CqNWtCwu6jsFyM6+lIkeFjMc=;
        b=hp5rC0//k/bhtlGRpyuIzVz+r4CiLKtxLnKUq8cIa3W6ICjr8zJ0j+Ir6lYqLCbJfb
         1wAZ+nXhy3mfud+PhFMvQYT2Zt3fbJ5MKlI5jdqy7PcJsXCH/9IfEO56f6Em4BkvcSuS
         Irms3UzZUfXoLG/Pqqi5w49b3J1D1wxFC17dWdtupsOIM6MWgOJyEmJm25PPVGjYyvN2
         a5QugWPSXahIkwTsy0vru71CdGKWMx6SSrGkCqY1npu3133yS5Hv1S9Py883t7HDZXKM
         MaCtrbpPJYUwo5x1kb1jeDXyk+vHdWIKWExcMRhuh8s5PUmfu/Pew9LrCZAzvUFb41tf
         MW9w==
X-Gm-Message-State: AOJu0Yz0xx6Vxn2s3TqXZ9VSZvFfvy/Qn+Jitq8HImLov7B4HT5tLnTW
	dsWfIMrhnTbYVkhnlHXTi0uONpGAoYsrVMYz1GUhH2XV7tbi7/a7bY4am0JAMAN7dzo=
X-Gm-Gg: ATEYQzzr1qYdOFTcg0CGe3Nny2P26YRNwVdR1nB2ImaSEzEVdijyd4dchAs1FGxy30H
	m0+cG9cMzMdANvR5heCzvcZAe6ggpUXjvQ6m0cstrnQA6e/pN7g9aYo58DkNkN7eyrklLlyyTz4
	xMGNkYjRmViMGHauE28kSWfBPUUVVuKEjYz8L0+HoSoi0IDMyN457MTptn4EaQUURpMgx27nAN7
	ElRNXljw0yGugsUI5qam4c5mhmfKvRVd4amE+/yKr8kb6u9U0wNEa/lgLHqKp1cpCrdCToBZVzU
	BvH/Fh5xfkO3/XN+p4Cf9IXo87gO+S+gSUOMsW0dRqQVx4DLyxtb7MwAyjozRMOri5i7uJIK9w0
	imq9aOowSJp9uR2tdqYu0546n7hsx6Xhbcoz2KNFug3/V0+NVOUN2fFi1hSggOHSSgQ03G/D6Y7
	1eogdRmj8HskpEbKJvNgg2GRh3pg==
X-Received: by 2002:a05:600c:8207:b0:485:3f1c:d887 with SMTP id 5b1f17b1804b1-48727ee4d13mr52996335e9.26.1774627959535;
        Fri, 27 Mar 2026 09:12:39 -0700 (PDT)
Received: from localhost ([102.88.77.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725fd18b7sm19831015e9.13.2026.03.27.09.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:12:39 -0700 (PDT)
Date: Fri, 27 Mar 2026 17:12:43 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH] repack-promisor: add fake paths to oids when repacking
 promisor objects
Message-ID: <acasFS_UXC8NybtE@Adekunles-MacBook-Air.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This change addresses the NEEDSWORK comment added by commit
5d19e81 (repack: repack promisor objects if -a or -A is set).

When 'git-repack' repacks promisor objects, only the raw oids
are sent to 'git-pack-objects'.
This gives 'git-pack-objects' no information about the original
pack order of those objects in the packfile so it must
rely on its default strategy of sorting the objects by type and
then by size over again. This can produce suboptimal packfiles
because the objects that were previously stored in the same
packfile can become separated.

Provide a hint to 'git-pack-objects' when sorting, by using the
packfile basename, and the offset of the object in the existing
packfile as fake paths when writing the oids to 'git-pack-objects'.

This will ensure they can be grouped by the type and existing pack
order which will make them end up close together in the sort, improving
delta compression.

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
 repack-promisor.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/repack-promisor.c b/repack-promisor.c
index 90318ce150..3f3034fb79 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -12,25 +12,51 @@ struct write_oid_context {
 	const struct git_hash_algo *algop;
 };
 
+/**
+ * Build fake path for the objects to give pack-objects
+ * an ordering hint.
+ * For the packed objects: pack-basename/offset-padded
+ */
+
+static void build_ordering_hint(struct object_info *oi, struct strbuf *hint)
+{
+	struct packed_git *pack;
+	unsigned long offset;
+
+	if (oi->whence == OI_PACKED) {
+		pack = oi->u.packed.pack;
+		offset = oi->u.packed.offset;
+		strbuf_addf(hint, "%s/%05lu", pack_basename(pack), (unsigned long)offset);
+	} else
+		strbuf_addstr(hint, "loose");
+}
+
 /*
  * Write oid to the given struct child_process's stdin, starting it first if
  * necessary.
  */
 static int write_oid(const struct object_id *oid,
-		     struct object_info *oi UNUSED,
+		     struct object_info *oi,
 		     void *data)
 {
 	struct write_oid_context *ctx = data;
 	struct child_process *cmd = ctx->cmd;
+	struct strbuf hint = STRBUF_INIT;
 
 	if (cmd->in == -1) {
 		if (start_command(cmd))
 			die(_("could not start pack-objects to repack promisor objects"));
 	}
 
+	build_ordering_hint(oi, &hint);
+
 	if (write_in_full(cmd->in, oid_to_hex(oid), ctx->algop->hexsz) < 0 ||
+	    write_in_full(cmd->in, " ", 1) < 0 ||
+	    write_in_full(cmd->in, hint.buf, hint.len) < 0 ||
 	    write_in_full(cmd->in, "\n", 1) < 0)
 		die(_("failed to feed promisor objects to pack-objects"));
+
+	strbuf_release(&hint);
 	return 0;
 }
 
@@ -85,20 +111,13 @@ void repack_promisor_objects(struct repository *repo,
 {
 	struct write_oid_context ctx;
 	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct object_info request = OBJECT_INFO_INIT;
 
 	prepare_pack_objects(&cmd, args, packtmp);
 	cmd.in = -1;
-
-	/*
-	 * NEEDSWORK: Giving pack-objects only the OIDs without any ordering
-	 * hints may result in suboptimal deltas in the resulting pack. See if
-	 * the OIDs can be sent with fake paths such that pack-objects can use a
-	 * {type -> existing pack order} ordering when computing deltas instead
-	 * of a {type -> size} ordering, which may produce better deltas.
-	 */
 	ctx.cmd = &cmd;
 	ctx.algop = repo->hash_algo;
-	odb_for_each_object(repo->objects, NULL, write_oid, &ctx,
+	odb_for_each_object(repo->objects, &request, write_oid, &ctx,
 			    ODB_FOR_EACH_OBJECT_PROMISOR_ONLY);
 
 	if (cmd.in == -1) {
-- 
2.39.5 (Apple Git-154)

