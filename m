Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9008727FB29
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419160; cv=none; b=MkL6zc0XNbdbHxmP8GWdOxiSnY7EWS2T5GxbcNFdDe7ptZy0pXef/r7++/7ftPVWAzuINgbVeDZK/Iafz1zih1nUqrtXn3y4AKHDYEOBF37oPqaHJr85XZvYF51wslgquNZfMF9ckT0RI2j9d5mJA37PBW4I/ptnqHzy4A1OCzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419160; c=relaxed/simple;
	bh=4x+9RW7eIOQUcTMC50mDoeBRnCAKperKP6TtxSEfnZ0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JPINkhENbKuX2FHhr10VF18dskXpXvwuHgjPQOKBY+bBc8iDu1MkArE7nZUuu8CSA4lDyta1Ulsijx+s0OSxTNniOH9ZdCP1LH6NBe/b9g4axbdC2Gd5kTaolr5ihK88SOor5TBe2exwk7WP8FpcwVi+sKCygo4LxA519LaiaCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8zOojYL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8zOojYL"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-441d1ed82faso17930585e9.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747419157; x=1748023957; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tCZEKvMYln5+ei3+4PKUjzM6cnU7786BeL97DxUwBw=;
        b=P8zOojYL+8wc2i8YCwVFkGL9HnJpNM14foYbFBrQS16JouPqz0reB7Ua3U7i0ahQr2
         rvPKcJnjT7yS5bGpLD62cakPsE6+b/7/5cylPj0mlGjXDSdFbCiIXqykm7TGJNBxwnjO
         dHx8yfJnlECDPvmPBLNtKXnyXRL33NhhmwFQx8ZwLwdFbiDGPYKUPZi3NW8LxjCYdblN
         l7d34wd2s7DfdGtKm3UvtUx1TJ4DRPQmetzPT0suMfIpRpy41TUj/DijxT0RIU+JFBPO
         nxVwNgmTw0nsA0fQ5+X51oEpQKjKt+zU85F7SJAp9pq538cRIHKcgkTHVYjE2vKhQ5eq
         HJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747419157; x=1748023957;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tCZEKvMYln5+ei3+4PKUjzM6cnU7786BeL97DxUwBw=;
        b=K5jq85UrDcDlyUELIwczd+nKRMVk7V991wdEsgNae9LLIfA9leS/RwCU7W3fPxJVKB
         4JJpLk5B8nDQKH/o6pDrW3EKsNAaPCaHQ0y/Jasa2iE7jEmjzGHna+Ft5IWLla23E6Nj
         N+LqNEt0ub3LFvo2aWCZ/u++Ka2QhXOypxPYScBniZu0JwoJ29t6IbTECJoV9mdiA8SW
         R50idbpZ7yMhqtvJxyZu0ABNGvdn3vnq3S/JixguNYlQleqBmphxVqhw4fwCQv2ob8qv
         nLz5l/rt4zw74SXPk0rJGOmxY9PnRTMqXnVhyoKmRfxY0GelcjoVttF99qNCttTjUobf
         YeYg==
X-Gm-Message-State: AOJu0YwjYmMlZEqAFo7Cf1pUG9bXpt7kpOsewxgE4Yfyh5kmWJtgxuK6
	LDd6KbEd3oh8caC4P4OV3TjVbChKbMNN3ey4XE+CM/Xx7iPy1S8Y+aW3bZGJHg==
X-Gm-Gg: ASbGncue2C95Tt72A963uinTsepBfkdm4yfYMpZuFxqw6F3QuazZGCH0i35gGbS/38I
	t1xqTm27g6W0ZnqXO0cslnXodMGG56VgmgXuRqGHX63dYh+NJaXfobcAqOmdROfRCk8Z75+OoIg
	qAZptrywnVZwfUuY0ZyB5ifuc8Iyd46CV/eIw/U1ck/b0iTXuQfaQuOmoXu1ASjVj0d59hg2DsY
	UmiBXr2tM6Rx+iAXlifXBOk9oo5uo3RrSHMxxg8/D8RfExkGlSnrkx6fTmmHoflTzDGcUUHSmWJ
	CYdS0zIvUwLz5mkVXG9x7ktfeFwHK7Eq1QYTpA0DB6GEdV8fhD5y
X-Google-Smtp-Source: AGHT+IHymFx+8ESFIFirGb70dRx0Y7pcfLnU0W/oPfedB9e+LaOJI9E4Z49Nrv7/czaTUneYZ5Ux3w==
X-Received: by 2002:a05:600c:3511:b0:43c:eea9:f45d with SMTP id 5b1f17b1804b1-442feffb5e7mr38122525e9.18.1747419156417;
        Fri, 16 May 2025 11:12:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-443003ab9e2sm25682625e9.7.2025.05.16.11.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:12:35 -0700 (PDT)
Message-Id: <a14d447d35eb32effadf58d4f93fecdcccaa12cd.1747419124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
References: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
	<pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 18:12:02 +0000
Subject: [PATCH v3 12/13] path-walk: add new 'edge_aggressive' option
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In preparation for allowing both the --shallow and --path-walk options
in the 'git pack-objects' builtin, create a new 'edge_aggressive' option
in the path-walk API. This option will help walk the boundary more
thoroughly and help avoid sending extra objects during fetches and
pushes.

The only use of the 'edge_hint_aggressive' option in the revision API is
within mark_edges_uninteresting(), which is usually called before
between prepare_revision_walk() and before visiting commits with
get_revision(). In prepare_revision_walk(), the UNINTERESTING commits
are walked until a boundary is found.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/technical/api-path-walk.adoc |  8 ++++++++
 path-walk.c                                |  6 +++++-
 path-walk.h                                |  7 +++++++
 t/helper/test-path-walk.c                  |  2 ++
 t/t6601-path-walk.sh                       | 20 ++++++++++++++++++++
 5 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-path-walk.adoc b/Documentation/technical/api-path-walk.adoc
index e522695dd9fa..34c905eb9c31 100644
--- a/Documentation/technical/api-path-walk.adoc
+++ b/Documentation/technical/api-path-walk.adoc
@@ -56,6 +56,14 @@ better off using the revision walk API instead.
 	the revision walk so that the walk emits commits marked with the
 	`UNINTERESTING` flag.
 
+`edge_aggressive`::
+	For performance reasons, usually only the boundary commits are
+	explored to find UNINTERESTING objects. However, in the case of
+	shallow clones it can be helpful to mark all trees and blobs
+	reachable from UNINTERESTING tip commits as UNINTERESTING. This
+	matches the behavior of `--objects-edge-aggressive` in the
+	revision API.
+
 `pl`::
 	This pattern list pointer allows focusing the path-walk search to
 	a set of patterns, only emitting paths that match the given
diff --git a/path-walk.c b/path-walk.c
index 341bdd2ba4ef..2d4ddbadd50f 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -503,7 +503,11 @@ int walk_objects_by_path(struct path_walk_info *info)
 	if (prepare_revision_walk(info->revs))
 		die(_("failed to setup revision walk"));
 
-	/* Walk trees to mark them as UNINTERESTING. */
+	/*
+	 * Walk trees to mark them as UNINTERESTING.
+	 * This is particularly important when 'edge_aggressive' is set.
+	 */
+	info->revs->edge_hint_aggressive = info->edge_aggressive;
 	edge_repo = info->revs->repo;
 	edge_tree_list = root_tree_list;
 	mark_edges_uninteresting(info->revs, show_edge,
diff --git a/path-walk.h b/path-walk.h
index 473ee9d361c8..5ef5a8440e6b 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -50,6 +50,13 @@ struct path_walk_info {
 	 */
 	int prune_all_uninteresting;
 
+	/**
+	 * When 'edge_aggressive' is set, then the revision walk will use
+	 * the '--object-edge-aggressive' option to mark even more objects
+	 * as uninteresting.
+	 */
+	int edge_aggressive;
+
 	/**
 	 * Specify a sparse-checkout definition to match our paths to. Do not
 	 * walk outside of this sparse definition. If the patterns are in
diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
index 61e845e5ec25..fe63002c2be2 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -82,6 +82,8 @@ int cmd__path_walk(int argc, const char **argv)
 			 N_("toggle inclusion of tree objects")),
 		OPT_BOOL(0, "prune", &info.prune_all_uninteresting,
 			 N_("toggle pruning of uninteresting paths")),
+		OPT_BOOL(0, "edge-aggressive", &info.edge_aggressive,
+			 N_("toggle aggressive edge walk")),
 		OPT_BOOL(0, "stdin-pl", &stdin_pl,
 			 N_("read a pattern list over stdin")),
 		OPT_END(),
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index c89b0f1e19d9..785c2f22373d 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -378,6 +378,26 @@ test_expect_success 'topic, not base, boundary with pruning' '
 	test_cmp_sorted expect out
 '
 
+test_expect_success 'topic, not base, --edge-aggressive with pruning' '
+	test-tool path-walk --prune --edge-aggressive -- topic --not base >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	1:tree::$(git rev-parse topic^{tree})
+	1:tree::$(git rev-parse base^{tree}):UNINTERESTING
+	2:tree:right/:$(git rev-parse topic:right)
+	2:tree:right/:$(git rev-parse base:right):UNINTERESTING
+	3:blob:right/c:$(git rev-parse base:right/c):UNINTERESTING
+	3:blob:right/c:$(git rev-parse topic:right/c)
+	blobs:2
+	commits:1
+	tags:0
+	trees:4
+	EOF
+
+	test_cmp_sorted expect out
+'
+
 test_expect_success 'trees are reported exactly once' '
 	test_when_finished "rm -rf unique-trees" &&
 	test_create_repo unique-trees &&
-- 
gitgitgadget

