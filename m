Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1434A3C
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 04:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764391469; cv=none; b=nWh3yLsp19GKyUsg0kM9258KbflVmAM6L5DFhpoUg85OyfgKv6MXV5xuJc1gqj+tD2bsY2cNbhm59ng8PxDHdxTp+VyeK3skormx53es02o02wWvFwiY7qUrQivRzgCknLrIc5R5cHMIcITwFG5BEoFnDer43Ch002byiFvaVs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764391469; c=relaxed/simple;
	bh=LVVaexCAW8fZOrNzI3HDove7X59quR1IUQbjT+kX56I=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Ib5qlJgjVY/iu5OB4BK10i3wskHjhD/pl+MS5jt5wqIv7iviV2xqmWKVbeKSb82wHIjStzKrWWfUONvAyQuekD9enjKHmNXLOJFlYTvUG9yNigsNi03DyQHPrDFzob+ErfpwmisFf80V9FxVLALYI2vnlQZ2tuhsMN/pBRUzeY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCImmyRU; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCImmyRU"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-43346da8817so13276145ab.0
        for <git@vger.kernel.org>; Fri, 28 Nov 2025 20:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764391467; x=1764996267; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4VeZA0Y4Zoy7Hw8dD9PXAoWpS48czEUmad2W+rjBI0c=;
        b=GCImmyRUnMEbsGk/9vz1s84Yktv9ALVSSxkKr5kjBj43g/TGHEilBmBUtEihAEgsUi
         1MQkTNSGFk3NXMLsulI4kRGPeSp3oK5+SVDEY5P6fDYbbGxV2YjKaLJ6BcRPB1Xn/URp
         RFGLIbe3mgCfvl4hX4ELZPxKyn1bjHlYjmps7m4JYUEtVliwR7Xz0zLBhfWrjijOHNq4
         681Z600fJy5gRPJ3R6p+jZ3z0nk/aCU3O0FAk1/odXuTbpQB50C4osgdp/++EHWvWI0z
         2RE5O1ZmQR7/SNIEc1oBhI0Ssm8J3D5iEtCDEUVXOCIyu2x8APS8yzqpJuJXZf/Yrxt/
         6X3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764391467; x=1764996267;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VeZA0Y4Zoy7Hw8dD9PXAoWpS48czEUmad2W+rjBI0c=;
        b=TfFZQoOwQdLTYbGmn/vYNFAjhcTbLBiqDW8qVlsi6jq4O2kuzUwdGqvlHZaNB/xGzg
         H9e5T3rlKJ+aIfyejI1UmX0utX2+f1w/COGl5ul2fB7yOBnpvHYZDgBzfjtGck/A/bfh
         B2V/sS9cWgYR5E1VPtv+6N4EOmNOW+rlHDrFqPyl/q8EfxjTNwwo3/tRtuROrZFGajuu
         UfqNHU1G7mgS5rdhh0f9ffFixltXEpD34dGp3agsfI1si5I2DKxVZ1KsgmisZjlRD6xR
         6PF+EOM5bBiBkq/XpIOzRw24zELHoinmkIwEsE/rlsFtxIbYc+AchqImxX+xur/TrbbO
         flZA==
X-Gm-Message-State: AOJu0Yzy1jWF31XbUXQwWJODUoS9ZeMxkUtikVfDusW7YAenk+R+p0dx
	ZxNH61StHTCJ/IEj1nblecGYqsTaHh2i2uMv6Mhjw6SY/tKeVgOViphY9qPGbQ==
X-Gm-Gg: ASbGncufCI4ovRa0g8IIalRP7oknpD6KtHGT6wNCzowU8s0pAI3Gw8kFvCoxD8y+Ozv
	ZWpcfZ7hxYOm+JGXG+1otZl4/v1RvsLWtJR5rFjC+VjoZwhZT3mPQJMlawT3MJIgwh688IVR+wn
	klHwu5oZE8qOHcuw8XXqFyqmgjQMKJkRqSoN/q254PxB1whQJeVDHWgzW5vNEsmRnNAuSpwBM0F
	vrc6uspn070JRCcOH/dyOZ7pMBUFTIq8ajZvBbddawtldamSuUSZk/gvofos+p5Xdd1cv+i7I+L
	r48XAhf4NyJsuxrc/36QPLnyyvbycZucqJw69LkylkYrEKNgQKuj2fvVvkwfHIZJPdrBBU8fzVB
	MHIl1AaBPR1hkxh+ghzk7ZwGCYsYGPu09cIne7kVBjDwfbz8jkEMS36Z0+brDKFYGFfiXooBNYm
	NjGoE/DXNzWKOC
X-Google-Smtp-Source: AGHT+IGCjDrfrcICvfRN8Lp4PNpXokP78mrrjH5iaGHui4l+7bar9WJhpKt0pmr/ueg3QIjseCvUfw==
X-Received: by 2002:a05:6e02:dc3:b0:433:2499:92f8 with SMTP id e9e14a558f8ab-435aa880f52mr260562215ab.5.1764391466912;
        Fri, 28 Nov 2025 20:44:26 -0800 (PST)
Received: from [127.0.0.1] ([52.173.181.18])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-436a52e7993sm35457455ab.3.2025.11.28.20.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 20:44:26 -0800 (PST)
Message-Id: <pull.2012.git.1764391464952.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 29 Nov 2025 04:44:24 +0000
Subject: [PATCH] Documentation/git-replay.adoc: fix errors around revision
 range
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Christian Couder <christian.couder@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

There was significant confusion in the git-replay manual about what
constitutes a revision range.  As noted in f302c1e4aa09 (revisions(7):
clarify that most commands take a single revision range, 2021-05-18):

   Commands that are specifically designed to take two distinct ranges
   (e.g. "git range-diff R1 R2" to compare two ranges) do exist, but they
   are exceptions. Unless otherwise noted, all "git" commands that operate
   on a set of commits work on a single revision range.

`git replay` is not an exception, but a few places in the manual were
written as though it were.  These appear to have come in revisions to
the original series, between v3->v4 (see
https://lore.kernel.org/git/CAP8UFD3bpLrVW97DH7j=V9H2GsTSAkksC9L3QujQERFk_kLnZA@mail.gmail.com/
, "More than one <revision-range> can be passed") and between v6->v7
(https://lore.kernel.org/git/20231115143327.2441397-1-christian.couder@gmail.com/,
"Takes ranges of commits"), and I missed both of these revisions when
reviewing.  Fix them now.

There was also a reference to the "Commit Limiting options below", but
this page has no such section of options; strike the misleading
reference.

It is worth noting that we are documenting existing behavior, rather
than optimal behavior.  Junio has multiple times suggested introducing
alternative ways to walk revisions and use them in `git replay
--advance`, e.g. at
  * https://lore.kernel.org/git/xmqqy1mqo6kv.fsf@gitster.g/
  * https://lore.kernel.org/git/xmqq8rb3is8c.fsf@gitster.g/
  * https://lore.kernel.org/git/xmqqtsydj2zk.fsf@gitster.g/ (item (2))
If/when we introduce some new revision walking flag that implements one
of these alternate types of revision walks, we can update the --advance
option and this manual appropriately.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    Documentation/git-replay.adoc: fix errors around revision range
    
    This has a minor conflict with Phillip's recent patch where he adds an
    extra sentence to the description for <revision range>, to note that
    empty commits will be dropped. (See
    https://lore.kernel.org/git/8a2a1215306452147cc7b803530ab2429bf57f15.1764260150.git.phillip.wood@dunelm.org.uk/)
    The resolution is simply appending that sentence from his patch to the
    rewritten description from this patch. If you prefer I wait and resend
    after Phillip's patch merges (which in turn will wait until after
    ps/history), just let me know.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2012%2Fnewren%2Freplay-revision-range-wording-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2012/newren/replay-revision-range-wording-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2012

 Documentation/git-replay.adoc | 13 ++++++-------
 builtin/replay.c              |  2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index dcb26e8a8e..d03235cca0 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -9,12 +9,12 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
 SYNOPSIS
 --------
 [verse]
-(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--ref-action[=<mode>]] <revision-range>...
+(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--ref-action[=<mode>]] <revision-range>
 
 DESCRIPTION
 -----------
 
-Takes ranges of commits and replays them onto a new location. Leaves
+Takes a range of commits and replays them onto a new location. Leaves
 the working tree and the index untouched. By default, updates the
 relevant references using an atomic transaction (all refs update or
 none). Use `--ref-action=print` to avoid automatic ref updates and
@@ -55,11 +55,10 @@ which uses the target only as a starting point without updating it.
 The default mode can be configured via the `replay.refAction` configuration variable.
 
 <revision-range>::
-	Range of commits to replay. More than one <revision-range> can
-	be passed, but in `--advance <branch>` mode, they should have
-	a single tip, so that it's clear where <branch> should point
-	to. See "Specifying Ranges" in linkgit:git-rev-parse[1] and the
-	"Commit Limiting" options below.
+	Range of commits to replay; see "Specifying Ranges" in
+	linkgit:git-rev-parse[1]. In `--advance <branch>` mode, the
+	range should have a single tip, so that it's clear to which tip the
+	advanced <branch> should point.
 
 include::rev-list-options.adoc[]
 
diff --git a/builtin/replay.c b/builtin/replay.c
index 6606a2c94b..e6d6d28239 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -366,7 +366,7 @@ int cmd_replay(int argc,
 	const char *const replay_usage[] = {
 		N_("(EXPERIMENTAL!) git replay "
 		   "([--contained] --onto <newbase> | --advance <branch>) "
-		   "[--ref-action[=<mode>]] <revision-range>..."),
+		   "[--ref-action[=<mode>]] <revision-range>"),
 		NULL
 	};
 	struct option replay_options[] = {

base-commit: b31ab939fe8e3cbe8be48dddd1c6ac0265991f45
-- 
gitgitgadget
