Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509663;
	b=uLCRUUR/IgUFFBuMZDowSH0c6UHeLZ2BTGkeu8AUGzJ9EZWntIqz+zqEEbWRZjiY8mId
	 Zk8+K1XwPmNtHE14PV8OkvD+kE74L3v3OwL1jhDTG1s93EyK7hUbosHftz6MqcfEw7UNI
	 gR671XMbfryWasj5OlPgzc62gkyrSkTR6Ot+eb+TWu+ijPImUTbvEl71E/iy6dZRPFPck
	 rTgqSmB8tHuMi4ZU+u5+BDdeaV329cfqzP0TKGGKcKj1sqXmjtUnYf03w1T65lOS21EPK
	 qkgTtm9ajEMnAdj5WWDe2GxwAZE/hoJNKEMG6+/wqzWZJZzDVeALzXcMkB9cgVT6J5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n/xzFBhBid8rjWWdzadBRA9xnCIBg67YKwhkDAQRonc=;
	b=e9rFBEbAexmepCzcDVmnqMt1yTOFDrH2eDiuENJK3RgCy7yRVm7OB9WVb1pBKdrESytR
	 YH+Zg+4eLbSwLb/Czb/YwCJcnCwsxOzTlcrAdKCZT96hyIIyf2DIX2BmwzjwrSkPpkbth
	 N7orDnZaMsxEXCCnwGZq6OKoP3PUSsewgag24z1CVMMNiGI4OUEd3rfRMyXIOtomWwNSU
	 A03IF80DblRGbYGAUUInWLp8NbtqF/3Hw/+F/gN4rVZnxlqmyvSROFJaOxjks2Rps3JcT
	 hlDNE+IVIJgrDQmMuVwD3eHhY2qWmraiKIO4ds47ktuiR+oNKAN+zAupX5aanXJJ7Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YWsst2Et;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D83B606A321
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D83B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YWsst2Et
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so2437282f8f.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792509662; x=1793114462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n/xzFBhBid8rjWWdzadBRA9xnCIBg67YKwhkDAQRonc=;
        b=YWsst2EtgZ0shqMt0/do8LWJ38meTIvBtTGXdbOWXaw87pUl3/BfuoxtcQEDjASccp
         /R2iRT4b7PSEE3OP4NeFNVlUwWkZYlOeQ+1B6u3IObGfdVPgHwca7dU32QK5o/+Di6RT
         ozDNal8oDG6BsnvVutKuid3Le9bbpXfHSUaLOTO5DTmPrfc5ubfSxII/3KFWJks+IBFY
         4pZnAqz9EGzVnetZTK/v4Zd3oOI951YIRYjNtGKPbw6pHKYmqN+XZTjowzH9iVHxL3bQ
         Nn0dUad1x4oIklIe1XTEeSqj4cM4VmyD/LoHc08J90Fmhj8T/rfzGOFuJe8SgA7z75hw
         YusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792509662; x=1793114462;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n/xzFBhBid8rjWWdzadBRA9xnCIBg67YKwhkDAQRonc=;
        b=pZlDVA9FribIv/jIqniNYLancvr3GiwWYTvpyy08V6Pc2gYyBrAhR6cO0oSX9hoegW
         0ysELWOZRRR7eZD6eipxJMd0VE9XmIJOmg+PgNzZd9IQDKITcwHb/wmbZ6sSvPmuqKrK
         LGy7JU4tIXRL/03NjfBImlnbNvc/16AHgHixigtU29dlclhbwhX/2smGu9OG3nmnS6GE
         iui5qzvywsETo3e60+9UTpoLp7m0CooXkOquduUOUq//eOdYkzgOB+l0n0I8Qeq0JW6t
         7fNH7TkhRKun38C4eG64qiKp/eQh+W8zos3UNOeoxssQfW8F40pl2QeJ3byfrG6W/R7k
         8MHw==
X-Gm-Message-State: AFq9FYL9E9A1QdZo19xfBjesvN8Y+ilO0qceH9jmTzQANAv8VI5Nztgo
	MtuYwD3/xkunULdG/W51N3MzB/KEoAWCgnWs6NVxWVPRDz3sIpUiGC/2HFBfLQ==
X-Gm-Gg: AYBFou2jMAwVjJnM182mCiVSDDmOwmUiJZbtz5BHfvQl8i30lXERqg5U75rAjuwYFIw
	oOPRI+uOGN3QQxszE4DA1NQ8ViEixpBIOzWkPsI3DXMYQgomYPgg83XCVP8E0uJJkdD+S8wny3r
	NXMxM7Vv6QXTpoI6omR3D91wjSzQrtjuuNCUQusJZFH9VSm02wyikrcK4XLM7kmWaC/8i3GtDqS
	J07hrwXRh9PM2DqFQ9vu/wxa7IpBar3UNSLdvpigr5crtRjiH/eFUihhUkazWF28U0C6pcEimAV
	6xGYre4K8ZRNBpUFUqb25wGZWqu+QaiFhXKwFy64UKWofVq84sQ1nCWzuQZPbwmww6PoXHElKX1
	546X5ZU4IYmmzKWsWzjtMIom9pDE5YOv+nhS58NcBsM+YCMSXJbQVc4S1/+b5tw7fhVDtrOW+eG
	KV8c7/m/QiYx+ZkTCw0pO5nPo4IwrybR3N4MiSk4qppt8Ntup/wmfPpS9wLjTXqGOR/NmL2BKcI
	g==
X-Received: by 2002:a05:6000:1865:b0:48d:f7ef:cd1d with SMTP id ffacd0b85a97d-48e07bb2cc8mr27666724f8f.9.1792509661582;
        Tue, 20 Oct 2026 08:21:01 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d823ca7sm6307355f8f.38.2026.10.20.08.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:21:01 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 5/7] stash create: rework temporary index creation
Date: Tue, 20 Oct 2026 16:20:40 +0100
Message-ID: <de5e0c196a9ff241861f5598ac9f6bc5c960f6ec.1792509606.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1792509606.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk> <cover.1792509606.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

We use reset_tree() to create the temporary index file used to stash
uncommitted working tree changes. Unfortunately, reset_tree() reads
the tree into the repository's in-memory index and writes the index
to the repository's default index path. In this case, we read the
tree that's already in the index and copy the existing stat data
across, so overwriting the in-memory index should not change its
contents. To write to a temporary index file, the caller has to
use set_alternate_index_output(). While that writes the index to a
temporary file, it updates the timestamp of the in-memory index so
that the timestamp no longer represents the index file the in-memory
index was read from. In practice that probably does not matter, but
set_alternate_index_output() also relies on a global variable which
makes the code harder to reason about.

Use create_index_from_tree() instead of reset_tree() so that we
can create temporary index file without overwriting the in-memory
index or relying on set_alternate_index_output(). This also makes
the implementation consistent with the way we create the temporary
index for "git stash push -p". As create_index_from_tree() does not
modify the in-memory index it is clearly safe to remove the call to
repo_read_index_preload() which saves one lstat() call per changed
path. It would probably be safe to remove that call without moving away
from reset_tree() but it is much easier to reason about now that the
in-memory index is not modified when we create the temporary index file.

In order to use create_index_from_tree() we need to add a new
parameter to control whether the index is reset, as the new caller
needs to merge the index rather than reset it so that we still detect
intent-to-add entries.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index b4fe7465e4..ddeb5a5d2a 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -374,7 +374,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 }
 
 static int create_index_from_tree(const struct object_id *tree_id,
-				  const char *index_path)
+				  const char *index_path, bool reset)
 {
 	int nr_trees = 1;
 	int ret = 0;
@@ -403,7 +403,7 @@ static int create_index_from_tree(const struct object_id *tree_id,
 	opts.src_index = the_repository->index;
 	opts.dst_index = &dst_istate;
 	opts.merge = 1;
-	opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
+	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
 	opts.fn = oneway_merge;
 
 	if (unpack_trees(nr_trees, t, &opts)) {
@@ -1399,7 +1399,7 @@ static enum create_result stash_patch(struct stash_info *info,
 		goto done;
 	}
 
-	if (create_index_from_tree(head_tree, stash_index_path.buf)) {
+	if (create_index_from_tree(head_tree, stash_index_path.buf, true)) {
 		ret = CREATE_ERROR;
 		goto done;
 	}
@@ -1458,22 +1458,15 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 	repo_init_revisions(the_repository, &rev, NULL);
 	copy_pathspec(&rev.prune_data, ps);
 
-	set_alternate_index_output(stash_index_path.buf);
-	if (reset_tree(&info->i_tree, 0, 0)) {
+	if (create_index_from_tree(&info->i_tree, stash_index_path.buf, false)) {
 		ret = -1;
 		goto done;
 	}
-	set_alternate_index_output(NULL);
 
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = add_diff_to_buf;
 	rev.diffopt.format_callback_data = &diff_output;
 
-	if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0) {
-		ret = -1;
-		goto done;
-	}
-
 	add_pending_object(&rev, parse_object(the_repository, &info->b_commit),
 			   "");
 	run_diff_index(&rev, 0);
-- 
2.56.0.134.g299a3c16181

