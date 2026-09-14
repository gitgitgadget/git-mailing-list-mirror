Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682D14446FA
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385490; cv=none; b=jAyy6xIh+SmV8Ini2pZLN9RDIc10OPWr4cqjNiLFsjXbjTQm7MXzRxAZwkY6498eOyZKUHdDAj/08enHU9zd5M1QZK/DC9CmUwDRuLyWh1iu3W3tfDj5wMCjvCD4yEqWelCZUIvDRmjSJ6N45qbTS6NI/0tppZkl7/4/uwcmZs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385490; c=relaxed/simple;
	bh=7FQAv0xilKM7BMUM0aO7Fp0DEYdLipfXCdSd2TSOJxc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JESnxwwOoGWQXGCSLkMj/RybyZ3oHYSPUcRlg1MrkOFe77cd2+RpjsEURdIhsBNc58L2fgDvVSeGZHrZyFS4mbTGG56HHOjXPUXGlQl6LovPuGUSR77V99zuSRBSC8koAUY41S27UcVfUSKWvKgVyENNQ7U+9bcEBVMkpTvF+iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeCYwYwY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeCYwYwY"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-86ec25cf7ecso704822b3a.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 04:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789385489; x=1789990289; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s0kLvt0TiJhwJWZ30oqJfPT3F0Eu8GP8xiOBtyQM3TU=;
        b=OeCYwYwYLLWVScGy7XvmaZvYiAebg5NR32AWXvxs3HWbTDINBefPKX0OFBXiHl9IsS
         xmJ3Q9pOsi3G+K0sQfh9BGAuJ2FLYzCwPb8VzbMu98yqvz6xhATi0VfUrUfM6dsTTHu4
         omfUJ48nlHFCsFrQVhhZnhsvQa2vq0bw3Ifm9txglqyxDDlgvDUch9ukEIQdl3l4+W7v
         bltZ9PdH3BiYG07UvnIyJSnFTwGCYKvVxLgzeHV/2JfdoaxAfwMoIOeOwtQBJ2TkcLKK
         8LJeQd4oK4C0vXxU8n/bK4vWKwjzbyovn6HaocjuxSWpAcuhfZCXKFub8WJQXKzA6Wl4
         ECdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789385489; x=1789990289;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s0kLvt0TiJhwJWZ30oqJfPT3F0Eu8GP8xiOBtyQM3TU=;
        b=ggtvl48UuEXRd2zxxVogkTyfh4Wp1TtHHd9RBdr1i9YXZRdQnfwbFDY5bC2GebSGwe
         Kl1x5nDgovS08CbuOfQKpFahX9lwPDKx7KTVWJ6Z35jOM0Ch1bOi4bn6LDqQRgU0GbDA
         1sZ1edMwHnoRDgqVCQP5LdWKzlemyaSQbyi1gtCNpG0BlW7m36dVZxRyQrQirMSKy8al
         WQlxgxF5WQTZDPRxi50OL3CcvrSP3RBp8qMpIdm0v3TjmGVX+zGFp2BFmT454I8GCmHl
         Idf7ZRLGYMeO9h3+zybFUL0Bl8WLQRNcBTDxG39AQ/GUXBL7kUapXxji/vVYxDc8jm3b
         0uIg==
X-Gm-Message-State: AFuF++lJbNrLt+g18h9tkxNzkImbHKvajUIXJq13PjEKZfay21/ERDe1
	rn6dP12CVumrZbHMPxSClCvQE2Mzs43FMOI+yfjpBq/ZeTOvMnJNfqL75tKYyQ==
X-Gm-Gg: AYBFou2A5dTXz0MQa1wrN11Lja/6Op8bGxKa52s6YCH4kgzejixCrYb+3ZagbRLdi28
	Gt2tSRlWoNiSyWXdLQ0jZjoqpF7gzeMOLFJ46YarENSL2LoLM1lFwSNUJzJMs/z3MjLh+nt3rR7
	oAKhCraVv8/gmVyqgQAsBL1U2qS6JCK1SyJxPQv/NhbF17wiCPTHYdHj4dEC+tI26lzrkPXikvb
	9tzVS280BL6uiVoR7YCtWBb70uFErRRzJpEpzHM5VH6rGUiN5dqS4D3MDqZ1DrYRBaxczP5wXup
	CDQFctwSF213FbgHZs9wLdBu8yGYZv2/t778ul8im5eNmd+KNqX+3ZxJc+zkwu1/T2fG0WJOTO9
	Tfxq9yceCFabOIF7wJgI7o8rNQpi3gzWu+zU3T96BpDqVlyi7q0n3vJ0A3kpmoDbEkOATpYRGC8
	3EJTwGz7IpFBYZ90cnFvwz8FpPCg6o7iZhqhdoJ0O5njFXgDSAVlqa8K9/zxStL290rTIcRR/+v
	xwG
X-Received: by 2002:a05:6a00:240c:b0:854:b3d3:8631 with SMTP id d2e1a72fcca58-86e2acce598mr6425699b3a.12.1789385488673;
        Mon, 14 Sep 2026 04:31:28 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b5674bc2dsm4427220b3a.59.2026.09.14.04.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:31:28 -0700 (PDT)
Message-Id: <9349ea48b09347eff5da8a8862268d63605af690.1789385483.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
From: "Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 14 Sep 2026 11:31:19 +0000
Subject: [PATCH 2/6] pack-objects: keep --keep-pack open when following
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <ttaylorr@openai.com>,
    Junio C Hamano <gitster@pobox.com>,
    Justin Tobler <jltobler@gmail.com>,
    qeesung <qeesung@live.com>,
    Qin ShiCheng <qeesung@live.com>

From: Qin ShiCheng <qeesung@live.com>

"--stdin-packs=follow" distinguishes excluded packs that are closed
under reachability ("^") from those that are not ("!"). The traversal
stops at objects in the former, and goes on through the latter to
rescue whatever they depend on that would otherwise be left out.

A pack named with "--keep-pack" gets the same in-core flag as a "^"
pack, so the traversal stops at it too. Nothing warrants that: the
caller said not to repack it, not that it is self-contained. When it
holds a commit but not that commit's tree, the tree is never rescued,
and writing a bitmap over the result fails for lack of closure.

In follow mode, mark such a pack as kept-open instead, the way repack
already lists the packs it cannot vouch for as "!" on stdin. Its
objects stay out of the result, and the traversal can go through it.

This matters more once repack names its ".keep" packs this way instead
of passing "--honor-pack-keep": on-disk kept packs never were a
boundary, and they should not become one.

Signed-off-by: Qin ShiCheng <qeesung@live.com>
---
 builtin/pack-objects.c        | 20 +++++++++++++----
 t/t5331-pack-objects-stdin.sh | 41 +++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 708b719f40..6f579173b0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4999,7 +4999,8 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 	oid_array_clear(&recent_objects);
 }
 
-static void add_extra_kept_packs(const struct string_list *names)
+static void add_extra_kept_packs(const struct string_list *names,
+				 enum stdin_packs_mode stdin_packs)
 {
 	struct packed_git *p;
 
@@ -5018,8 +5019,19 @@ static void add_extra_kept_packs(const struct string_list *names)
 				break;
 
 		if (i < names->nr) {
-			p->pack_keep_in_core = 1;
-			ignore_packed_keep_in_core = 1;
+			/*
+			 * When following, treat the pack like a "!" pack, not
+			 * a "^" one: nobody said it is closed under
+			 * reachability, so the traversal must be able to go
+			 * through it.
+			 */
+			if (stdin_packs == STDIN_PACKS_MODE_FOLLOW) {
+				p->pack_keep_in_core_open = 1;
+				ignore_packed_keep_in_core_open = 1;
+			} else {
+				p->pack_keep_in_core = 1;
+				ignore_packed_keep_in_core = 1;
+			}
 			continue;
 		}
 	}
@@ -5443,7 +5455,7 @@ int cmd_pack_objects(int argc,
 	if (progress && all_progress_implied)
 		progress = 2;
 
-	add_extra_kept_packs(&keep_pack_list);
+	add_extra_kept_packs(&keep_pack_list, stdin_packs);
 	if (ignore_packed_keep_on_disk) {
 		struct packed_git *p;
 
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index c74b5861af..4e1fde1b08 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -483,6 +483,47 @@ test_expect_success '--stdin-packs=follow with open-excluded packs' '
 	)
 '
 
+test_expect_success '--stdin-packs=follow walks through a --keep-pack pack' '
+	test_when_finished "rm -fr repo" &&
+
+	git init repo &&
+	(
+		cd repo &&
+		git config set maintenance.auto false &&
+
+		test_commit A &&
+		test_commit B &&
+		test_commit C &&
+
+		A="$(echo A | git pack-objects --revs $packdir/pack)" &&
+		B="$(echo A..B | git pack-objects --revs $packdir/pack)" &&
+		C="$(echo B..C | git pack-objects --revs $packdir/pack)" &&
+		B_ONLY="$(git rev-parse B | git pack-objects $packdir/pack)" &&
+		git prune-packed &&
+
+		# Pack C is included and pack A is excluded and closed. The
+		# commit B is in the kept pack B_ONLY, but its tree and blob
+		# are only in pack B, which pack-objects is not told about.
+		# The kept pack keeps B out of the result, and the walk has
+		# to go through it to rescue the tree and the blob.
+		P=$(git pack-objects --stdin-packs=follow \
+			--keep-pack=pack-$B_ONLY.pack $packdir/pack <<-EOF
+		pack-$C.pack
+		^pack-$A.pack
+		EOF
+		) &&
+
+		{
+			objects_in_packs $C &&
+			git rev-parse "B^{tree}" B:B.t
+		} >expect.raw &&
+		sort expect.raw >expect &&
+
+		objects_in_packs $P >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success '--stdin-packs with !-delimited pack without follow' '
 	test_when_finished "rm -fr repo" &&
 
-- 
gitgitgadget

