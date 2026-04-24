Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A0B33F5B2
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058103; cv=none; b=Oujjvj+OXAVlYox5sBa+D2Hdy5c6WfhQGmy8b8vUn7xTjCnYBpsG+uwtKeU0Nx1Si+A3cdyhglaxaxKAilBtN9EHTVn8N7jOl5CDEMhuz0LZazg4RQ9TjDFhkBRtq2A9kOj8R63SEpy1LyQfsvkkP40LSK34BhxMBCWr4b0iuLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058103; c=relaxed/simple;
	bh=+xIenzFrt+Ba3F9Rklfz8cY9m8eAOyUL8QziLL4Qyho=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=NsFv3NkGCcPuDMM5wzBg9MGRhdINpS+f2MKscjnVgEOSymbJs9THLIR/Sw7x0oK4xhJPtanmgN6Hqb8NZSOBtoImqG2dtag1lCUVLJmr6oaF58ekLKAfnrfW35KuJN5xwdeicUPWwhBmqU5bcwI5pTxa7VzxXcNDeX5FUFyWidQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n99QKyt1; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n99QKyt1"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8a0323830beso53315466d6.0
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 12:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777058100; x=1777662900; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sXExGzgDPOVWrlMDeyEWT7EjZI5vPD9W5+4X6ROwNUk=;
        b=n99QKyt10ZMH8XIGDJOzf9Tbqi2I4vS74ppUzkwF8oLCviHtodnpyQb2SMRZz5sIKL
         NhlYLOAbVAihnJTl0Q+YyA/8FNktwWBlFvzDh3PeWzdUvwVbl3/DsbSZ1uh1ysmipOkX
         Z9MJOp7Xuz4ccAcRLhjCAu20EmUssm6RodZPHrzHUXH2oIOiK+YC9xLTaxPxx/5XeVD/
         TVLoBCNEEthVslXi1eXslJndieZtN1Cco0VqKuSoG80t70puusF8R3/CM1Ij1q62nusB
         LXz2gbTyer+wAnH+EFQ/ldRCH1PbS5uk7H3wSjvicPbNAis/h2yOVp6y6zp2JGgqt/Fc
         ABeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777058100; x=1777662900;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXExGzgDPOVWrlMDeyEWT7EjZI5vPD9W5+4X6ROwNUk=;
        b=c5dX/JavC0RBRMbxqiBgdWGls7xiUWzdGQYdUkyxtXA8WAbI/A/q3DYcxvHYH8Pl12
         jXhGgIcr5aVtveiNkqzQgbInIj8+umvDFoS58tTCjF6baT4FLYijF9H52hj1BSWjwhiN
         cvjMuVGAdCjXruaQEH1ufCxczJPJom+OOVAswJNPr+LkUfCU2ALZXYohTKQHNscbJjEg
         OCqybgPdoJUsp+W5Q9Ckgv9StIKhRLsT0lA6hv0cY+tAcv95wGlbvlpjiwucC/UaAg7J
         saCk0GBTEkio0boPZeB4+Ys9hdg/aONVSgpXPfTr2ttCcd+AxU/1DejNCQbo2NC9r1ZQ
         5F1g==
X-Gm-Message-State: AOJu0YwmT5vfPF93ZuZzK1Ejf895ZruOJNa0fFdHpknP/JX5uRoEeI3A
	GUaclrrQIifmYVlrDk5OTnr0EPsbn5OhVRLaz8Bo4SiC4CGArgRiwtkXDRytIA==
X-Gm-Gg: AeBDietV0gytz5HUIDf+vE4jiILtjWILZI2jU+CqirkhG7zn6JvHU95AoNAASH7Ib5e
	FEcJBnZekfu4rDlzPnsAv4Hfe4gEx1jLKriap2NRor1iPye1c8v8mUuwzI+sok1oInSALCEA07A
	xwiuaLPrNXJPVGwrYKum3OwtNkv3uhd2PRsc2R/85/w80UgckA3XaawZeFzVTL9hLAan0hC2UNm
	mQRVG5XtSjHFmjWS+VeS2KuYBRqdJZhHZQRp1ytHtQdMshAk9Odjzf3atOKGAzgfUV1r1c36yf2
	O7NznpnHpdlp1a7ZV+gSIKfLTv0BRrT+aWwvgrkkxbhagnfSqikPYFWWzYQui4oSB9vUOyYQpMu
	TN5KAtUsKAt45Z2vw6jHsV4vXEfrcAxwSytjbHEiZRFIkaraaTXMUG9qspBoxRRr2AzaE8o3zeF
	gruNqJ1KrQcF1bFQWcLNXfMjDimvGRLLRYo2klw5HT0q6sCsBS
X-Received: by 2002:a05:6214:3211:b0:8a6:1545:41ae with SMTP id 6a1803df08f44-8b0280fab68mr516334716d6.15.1777058099980;
        Fri, 24 Apr 2026 12:14:59 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.200.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b205cc0353sm92794576d6.10.2026.04.24.12.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:14:59 -0700 (PDT)
Message-Id: <pull.2282.git.git.1777058098756.gitgitgadget@gmail.com>
From: "Scott Bauersfeld via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Apr 2026 19:14:58 +0000
Subject: [PATCH] index-pack, unpack-objects: increase input buffer from 4 KiB
 to 128 KiB
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
Cc: Scott Bauersfeld <sbauersfeld@g.ucla.edu>,
    Scott Bauersfeld <sbauersfeld@g.ucla.edu>

From: Scott Bauersfeld <sbauersfeld@g.ucla.edu>

Both index-pack and unpack-objects read pack data from stdin through
a 4 KiB static buffer (input_buffer[4096]). On each fill(), consumed
bytes are flushed to the output pack file via write_or_die(), so
every write(2) moves at most 4 KiB.

On FUSE-backed filesystems every write(2) is a synchronous round
trip through the FUSE protocol (userspace -> kernel -> userspace ->
back), so the 4 KiB buffer turns a clone into many unnecessary tiny
writes with noticeable latency overhead.

Increase the buffer from 4 KiB to 128 KiB, matching the default
already used by the hashfile layer in csum-file.c.

Testing with strace on HTTPS clones of git/git (~296 MB pack, 5 runs
per variant, isolated builds from the same v2.54.0 source) shows:

  index-pack pack file writes: 72,465 -> 24,943 avg (66% reduction)
  total write() syscalls:     310,192 -> 259,530 avg (17% reduction)
  writes of exactly 4096 bytes: ~40,077 -> 0 (eliminated)

All clones produce identical HEAD, file count, and pass fsck.

Signed-off-by: Scott Bauersfeld <sbauersfeld@g.ucla.edu>
---
    index-pack, unpack-objects: increase input buffer from 4 KiB to 128 KiB
    
    Both index-pack and unpack-objects read pack data from stdin through a 4
    KiB static buffer (input_buffer[4096]). On each fill(), consumed bytes
    are flushed to the output pack file via write_or_die(), so every
    write(2) moves at most 4 KiB.
    
    On FUSE-backed filesystems every write(2) is a synchronous round trip
    through the FUSE protocol (userspace → kernel → userspace → back), so
    the 4 KiB buffer turns a clone into many unnecessary tiny writes with
    noticeable latency overhead.
    
    This change increase the buffer from 4 KiB to 128 KiB, matching the
    default already used by the hashfile layer in csum-file.c.
    
    Benchmarked with 5 HTTPS clones per version of
    https://github.com/sbauersfeld/git.git (~296 MB pack), using strace -f
    to count write() syscalls. Both binaries built from the same v2.54.0
    source tree in isolated directories to ensure the bin-wrappers resolve
    to the correct binary.
    
    Correctness verified via git fsck --no-dangling, rev-parse HEAD, and
    working tree file count — all 10 clones match.
    
    Results:
    
    Metric Unpatched (4 KiB) Patched (128 KiB) Change index-pack writes to
    pack file 72,465 avg 24,943 avg −66% Total write() syscalls (all
    processes) 310,192 avg 259,530 avg −17% Writes of exactly 4096 bytes
    ~40,077 avg 0 eliminated HEAD / file count / fsck ✓ ✓ None
    
    Raw data:
    
    unpatched (input_buffer[4096]): run 1: total_writes=311787
    ip_pack_writes=72353 ip_4k=35311 run 2: total_writes=310252
    ip_pack_writes=72348 ip_4k=38024 run 3: total_writes=309737
    ip_pack_writes=72303 ip_4k=43003 run 4: total_writes=309801
    ip_pack_writes=72661 ip_4k=42349 run 5: total_writes=309383
    ip_pack_writes=72662 ip_4k=41702
    
    patched (input_buffer[128 * 1024]): run 1: total_writes=264659
    ip_pack_writes=26605 ip_4k=0 run 2: total_writes=264276
    ip_pack_writes=26568 ip_4k=0 run 3: total_writes=227796 ip_pack_writes=
    9762 ip_4k=0 run 4: total_writes=262464 ip_pack_writes=27830 ip_4k=0 run
    5: total_writes=278455 ip_pack_writes=33952 ip_4k=0

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2282%2Fsbauersfeld%2Fsb%2Fincrease-index-pack-input-buffer-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2282/sbauersfeld/sb/increase-index-pack-input-buffer-v1
Pull-Request: https://github.com/git/git/pull/2282

 builtin/index-pack.c     | 4 ++--
 builtin/unpack-objects.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ca7784dc2c..81a628bf34 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -145,8 +145,8 @@ static int check_self_contained_and_connected;
 
 static struct progress *progress;
 
-/* We always read in 4kB chunks. */
-static unsigned char input_buffer[4096];
+#define INPUT_BUFFER_SIZE (128 * 1024)
+static unsigned char input_buffer[INPUT_BUFFER_SIZE];
 static unsigned int input_offset, input_len;
 static off_t consumed_bytes;
 static off_t max_input_size;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index e01cf6e360..535c019f82 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -23,8 +23,8 @@
 static int dry_run, quiet, recover, has_errors, strict;
 static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict]";
 
-/* We always read in 4kB chunks. */
-static unsigned char buffer[4096];
+#define INPUT_BUFFER_SIZE (128 * 1024)
+static unsigned char buffer[INPUT_BUFFER_SIZE];
 static unsigned int offset, len;
 static off_t consumed_bytes;
 static off_t max_input_size;

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
