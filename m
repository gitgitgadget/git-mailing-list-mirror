Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92FA341660
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777306120; cv=none; b=cWydFnFP9Orhr7z2YVwAOiXFXPxcidcjtf95cJCRQ22kz8kN4/LmJdjDVvJ8W5JuG6XhNiGMtbZBgIhvpF4/8dxCbdJCF7OYWqabvHw8/kktO1yCpryyUiR/JXtVJ8kCRThS0dqaSmY+9LiGPjHqVoGmbpq51YxvXeg8xYQ/FYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777306120; c=relaxed/simple;
	bh=t13AdDny/23NJhGY1g3X0LJdJ9rf7Kyt/KhHXf0y4mg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Xk9i/D4unTP62oeSBHSAVxl+bdh5OUTu9+wD0uFGNNgPn0e7WRwwCzAlVNmR+f2hleEG9HvXQvHmvNJbD46kRgbjlNGawO90PMDd3qjhcEJbCWlJBLg6QQ7sntjr03t/3BICYLmgNdfSpUcqN0jZTRrs+kbteP0WcN/MF2n8R1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5tMw0mi; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5tMw0mi"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so1102591eec.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 09:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777306117; x=1777910917; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWjwAn3Pu+V9RrBPGF6MkSeQBe1Sa6IgvOKUGeHuzNw=;
        b=l5tMw0mi07BathwyTLflTtvDuTwLLfBwh8xk00rAyk0s/smDyCuq/wmZg+DR34ZkL1
         EjJxiCO06/6UiAiZzvg930taH+JhpzYkx40TimBQdYdrmP+KL15gdecxd0pLWem8Snmk
         AusmCapRcpIomsUFfyqlud1cSpvm6J3DwDY++qYNwg38ksSLxCQTkYxArR4++/D1Cgua
         PeCZx2KSFshRrRSlUbb5bLUja8pOr3vqyUoW5z1SPWI6wz7b3btbZ+5BsH9rGZKpVGhy
         H3WkBLigWsutcBukI6/KPK16A6+RKep2PPjxSmYVEKKoxWYNqfqMJjSv/zPqaQDRKJ/1
         UGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777306117; x=1777910917;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eWjwAn3Pu+V9RrBPGF6MkSeQBe1Sa6IgvOKUGeHuzNw=;
        b=CkSV9f1/PQnrGYeZLR68fQcbNjPjgK9oqvv1Xkls3VdRPHpClLU4T1ZUVs+zRl7OxZ
         I572AtV8tEApTfCg/riyJCEmXvp2j7S5O4k269l3XjO0mOE4VdxiFNeKUZN7qh/vNDF2
         G7nc63BLECD1chsgdrMvqFACkBqHNCzwTtuzTb7sht+4gba7k8QjgaV7KfNWjxjO7hxm
         fgMWKSQOwhJetzfSIzyZxQV2/RJidVjUa4va+hF2oFpw0hcfabK1HNTLvRTglyeJbDbA
         Eg5gmMBThunsNy6VoItfosYcKU57l9ZcPooYkY1I/3GbC7oPdG0VSH0HuNtRDjg2zLCo
         gOag==
X-Gm-Message-State: AOJu0Yw4NIFzxmIwL6L/VqDFdtOy6qgtAiy9bpLL1L2EOzI8q+bMqOK2
	gKL2yrml4NUlO2pvkQrmqPqLSokKyzWREH01vDiVW8VghNaFkwClih/Etloy4w==
X-Gm-Gg: AeBDievUGZLfYNoHOg7UnXkECIwDE1AT+U+a4FnOi6v6AUaHM5FD/fcHTqEws3iqP0l
	kb/LcnnuFIeZyW0UuUwmoRu5xOvJwtPDF53ZJYcp5+zBuoOyXrCL1cIxXy2mhI4V3vbzIGErMC0
	ntkpQAg/18aA1HMUTr3NiMScUap9ZZ8Cie7jZNpj/UmrQyN1vIq/OaoRcAzDFDNSrHujH6snV3D
	B8SUJWkqj279q7PB7ZImDnpfB0E+kapa60bnU+/aFCHa3g1yGw77mDNCHj6uobG60RLR76KvJbs
	Zpz0dZ1K1H78d2LSvyI4r/ayPE9jrlNAOgKTaLfY/m6MI4uinLkoybV7WDmba7PAJ0qJLXa6/ft
	+mnGccBm4L5o/m51DOjNyOuDJZCO5SjOHSo7qxyfVviHOPGNm/HIucLiOTYgFgJdGAYUD9P6Afc
	kdRPZC+a8nh93306o1rRtDIupcVLqbi+CmXQpDPQ==
X-Received: by 2002:a05:7300:641b:b0:2df:7fe3:96a with SMTP id 5a478bee46e88-2e4522010e4mr27750558eec.0.1777306117088;
        Mon, 27 Apr 2026 09:08:37 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm55461523eec.8.2026.04.27.09.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 09:08:36 -0700 (PDT)
Message-Id: <pull.2282.v2.git.git.1777306114914.gitgitgadget@gmail.com>
In-Reply-To: <pull.2282.git.git.1777058098756.gitgitgadget@gmail.com>
References: <pull.2282.git.git.1777058098756.gitgitgadget@gmail.com>
From: "Scott Bauersfeld via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 27 Apr 2026 16:08:34 +0000
Subject: [PATCH v2] index-pack, unpack-objects: increase input buffer from 4
 KiB to 128 KiB
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Derrick Stolee <stolee@gmail.com>,
    Scott Bauersfeld <sbauersfeld@g.ucla.edu>,
    Scott Bauersfeld <sbauersfeld@g.ucla.edu>

From: Scott Bauersfeld <sbauersfeld@g.ucla.edu>

index-pack and unpack-objects both read pack data from stdin through
a 4 KiB static buffer. In index-pack, each fill() flushes consumed
bytes to the pack file via write_or_die(), capping every write(2)
at 4 KiB. unpack-objects uses the same buffer pattern for reads.

On FUSE-backed filesystems every write(2) is a synchronous round
trip through the FUSE protocol (userspace -> kernel -> userspace ->
back), so the 4 KiB buffer turns a clone into many unnecessary tiny
writes with noticeable latency overhead.

Increase the buffer from 4 KiB to 128 KiB. Introduce a shared
DEFAULT_PACKFILE_BUFFER_SIZE constant in git-compat-util.h (next to
MAX_IO_SIZE) and use it in index-pack, unpack-objects, and the
hashfile layer in csum-file (which already used 128 KiB but
hardcoded the value).

Syscall counts via strace on HTTPS clones of git/git (~296 MB pack,
5 runs per variant, isolated builds from the same v2.54.0 source):

  index-pack pack file writes: 72,465 -> 24,943 avg (65% fewer)
  total write() syscalls:     310,192 -> 259,530 avg (16% fewer)
  writes of exactly 4096 bytes: ~40,077 -> 0

Wall-clock time of git clone over HTTPS onto a FUSE passthrough
filesystem with writeback caching disabled, 3 runs per variant:

  vscode (~1.26 GB pack): 84.5s -> 75.7s avg (10% faster)
  git/git (~306 MB pack):  22.6s -> 20.0s avg (11% faster)

Signed-off-by: Scott Bauersfeld <sbauersfeld@g.ucla.edu>
---
    index-pack, unpack-objects: increase input buffer from 4 KiB to 128 KiB
    
    index-pack and unpack-objects read pack data from stdin through a 4 KiB
    static buffer. In index-pack, each fill() flushes consumed bytes to the
    pack file via write_or_die(), capping every write(2) at 4 KiB.
    unpack-objects uses the same buffer pattern for reads.
    
    On FUSE-backed filesystems every write(2) is a synchronous round trip
    through the FUSE protocol (userspace → kernel → userspace → back), so
    the 4 KiB buffer turns a clone into many unnecessary tiny writes with
    noticeable latency overhead.
    
    Increase the buffer from 4 KiB to 128 KiB. Introduce a shared
    DEFAULT_PACKFILE_BUFFER_SIZE constant in git-compat-util.h (next to
    MAX_IO_SIZE) and use it in index-pack, unpack-objects, and the hashfile
    layer in csum-file (which already used 128 KiB but hardcoded the value).
    
    
    Syscall reduction
    =================
    
    Measured via strace -f on HTTPS clones of git/git (~296 MB pack, 5 runs
    per variant, isolated builds from the same v2.54.0 source):
    
    Metric Unpatched (4 KiB) Patched (128 KiB) Change index-pack writes to
    pack file 72,465 avg 24,943 avg −65% Total write() syscalls (all
    processes) 310,192 avg 259,530 avg −16% Writes of exactly 4096 bytes
    ~40,077 avg 0 eliminated HEAD / file count / fsck ✓ ✓ identical
    
    
    Wall-clock time on FUSE
    =======================
    
    Measured wall-clock time of git clone over HTTPS onto a FUSE passthrough
    filesystem with writeback caching disabled. 3 runs per variant:
    
    Repo Unpatched avg Patched avg Change microsoft/vscode (~1.26 GB pack)
    84.5s 75.7s −10% git/git (~306 MB pack) 22.6s 20.0s −11%
    
    
    Changes since v1
    ================
    
     * Introduced shared DEFAULT_PACKFILE_BUFFER_SIZE constant in
       git-compat-util.h (next to MAX_IO_SIZE), replacing per-file #define
       and the hardcoded value in csum-file.c. Placed here rather than
       environment.h since it is an I/O buffer size, not an environment
       variable or repo config.
     * Added wall-clock timing on a FUSE filesystem.
     * Cleaned up the commit description a bit.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2282%2Fsbauersfeld%2Fsb%2Fincrease-index-pack-input-buffer-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2282/sbauersfeld/sb/increase-index-pack-input-buffer-v2
Pull-Request: https://github.com/git/git/pull/2282

Range-diff vs v1:

 1:  c388e1dc2f ! 1:  ac2559ccb5 index-pack, unpack-objects: increase input buffer from 4 KiB to 128 KiB
     @@ Metadata
       ## Commit message ##
          index-pack, unpack-objects: increase input buffer from 4 KiB to 128 KiB
      
     -    Both index-pack and unpack-objects read pack data from stdin through
     -    a 4 KiB static buffer (input_buffer[4096]). On each fill(), consumed
     -    bytes are flushed to the output pack file via write_or_die(), so
     -    every write(2) moves at most 4 KiB.
     +    index-pack and unpack-objects both read pack data from stdin through
     +    a 4 KiB static buffer. In index-pack, each fill() flushes consumed
     +    bytes to the pack file via write_or_die(), capping every write(2)
     +    at 4 KiB. unpack-objects uses the same buffer pattern for reads.
      
          On FUSE-backed filesystems every write(2) is a synchronous round
          trip through the FUSE protocol (userspace -> kernel -> userspace ->
          back), so the 4 KiB buffer turns a clone into many unnecessary tiny
          writes with noticeable latency overhead.
      
     -    Increase the buffer from 4 KiB to 128 KiB, matching the default
     -    already used by the hashfile layer in csum-file.c.
     +    Increase the buffer from 4 KiB to 128 KiB. Introduce a shared
     +    DEFAULT_PACKFILE_BUFFER_SIZE constant in git-compat-util.h (next to
     +    MAX_IO_SIZE) and use it in index-pack, unpack-objects, and the
     +    hashfile layer in csum-file (which already used 128 KiB but
     +    hardcoded the value).
      
     -    Testing with strace on HTTPS clones of git/git (~296 MB pack, 5 runs
     -    per variant, isolated builds from the same v2.54.0 source) shows:
     +    Syscall counts via strace on HTTPS clones of git/git (~296 MB pack,
     +    5 runs per variant, isolated builds from the same v2.54.0 source):
      
     -      index-pack pack file writes: 72,465 -> 24,943 avg (66% reduction)
     -      total write() syscalls:     310,192 -> 259,530 avg (17% reduction)
     -      writes of exactly 4096 bytes: ~40,077 -> 0 (eliminated)
     +      index-pack pack file writes: 72,465 -> 24,943 avg (65% fewer)
     +      total write() syscalls:     310,192 -> 259,530 avg (16% fewer)
     +      writes of exactly 4096 bytes: ~40,077 -> 0
      
     -    All clones produce identical HEAD, file count, and pass fsck.
     +    Wall-clock time of git clone over HTTPS onto a FUSE passthrough
     +    filesystem with writeback caching disabled, 3 runs per variant:
     +
     +      vscode (~1.26 GB pack): 84.5s -> 75.7s avg (10% faster)
     +      git/git (~306 MB pack):  22.6s -> 20.0s avg (11% faster)
      
          Signed-off-by: Scott Bauersfeld <sbauersfeld@g.ucla.edu>
      
     @@ builtin/index-pack.c: static int check_self_contained_and_connected;
       
      -/* We always read in 4kB chunks. */
      -static unsigned char input_buffer[4096];
     -+#define INPUT_BUFFER_SIZE (128 * 1024)
     -+static unsigned char input_buffer[INPUT_BUFFER_SIZE];
     ++static unsigned char input_buffer[DEFAULT_PACKFILE_BUFFER_SIZE];
       static unsigned int input_offset, input_len;
       static off_t consumed_bytes;
       static off_t max_input_size;
     @@ builtin/unpack-objects.c
       
      -/* We always read in 4kB chunks. */
      -static unsigned char buffer[4096];
     -+#define INPUT_BUFFER_SIZE (128 * 1024)
     -+static unsigned char buffer[INPUT_BUFFER_SIZE];
     ++static unsigned char buffer[DEFAULT_PACKFILE_BUFFER_SIZE];
       static unsigned int offset, len;
       static off_t consumed_bytes;
       static off_t max_input_size;
     +
     + ## csum-file.c ##
     +@@ csum-file.c: struct hashfile *hashfd_ext(const struct git_hash_algo *algop,
     + 	f->algop = unsafe_hash_algo(algop);
     + 	f->algop->init_fn(&f->ctx);
     + 
     +-	f->buffer_len = opts->buffer_len ? opts->buffer_len : 128 * 1024;
     ++	f->buffer_len = opts->buffer_len ? opts->buffer_len : DEFAULT_PACKFILE_BUFFER_SIZE;
     + 	f->buffer = xmalloc(f->buffer_len);
     + 	f->check_buffer = NULL;
     + 
     +
     + ## git-compat-util.h ##
     +@@ git-compat-util.h: static inline uint64_t u64_add(uint64_t a, uint64_t b)
     + # endif
     + #endif
     + 
     ++/*
     ++ * Default buffer size for buffered I/O in pack file operations (index-pack,
     ++ * unpack-objects) and the hashfile layer in csum-file.
     ++ */
     ++#define DEFAULT_PACKFILE_BUFFER_SIZE (128 * 1024)
     ++
     + #ifdef HAVE_ALLOCA_H
     + # include <alloca.h>
     + # define xalloca(size)      (alloca(size))


 builtin/index-pack.c     | 3 +--
 builtin/unpack-objects.c | 3 +--
 csum-file.c              | 2 +-
 git-compat-util.h        | 6 ++++++
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ca7784dc2c..d86476676f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -145,8 +145,7 @@ static int check_self_contained_and_connected;
 
 static struct progress *progress;
 
-/* We always read in 4kB chunks. */
-static unsigned char input_buffer[4096];
+static unsigned char input_buffer[DEFAULT_PACKFILE_BUFFER_SIZE];
 static unsigned int input_offset, input_len;
 static off_t consumed_bytes;
 static off_t max_input_size;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index e01cf6e360..da8ec83d9f 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -23,8 +23,7 @@
 static int dry_run, quiet, recover, has_errors, strict;
 static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict]";
 
-/* We always read in 4kB chunks. */
-static unsigned char buffer[4096];
+static unsigned char buffer[DEFAULT_PACKFILE_BUFFER_SIZE];
 static unsigned int offset, len;
 static off_t consumed_bytes;
 static off_t max_input_size;
diff --git a/csum-file.c b/csum-file.c
index 9558177a11..c1aeaf587a 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -178,7 +178,7 @@ struct hashfile *hashfd_ext(const struct git_hash_algo *algop,
 	f->algop = unsafe_hash_algo(algop);
 	f->algop->init_fn(&f->ctx);
 
-	f->buffer_len = opts->buffer_len ? opts->buffer_len : 128 * 1024;
+	f->buffer_len = opts->buffer_len ? opts->buffer_len : DEFAULT_PACKFILE_BUFFER_SIZE;
 	f->buffer = xmalloc(f->buffer_len);
 	f->check_buffer = NULL;
 
diff --git a/git-compat-util.h b/git-compat-util.h
index ae1bdc90a4..a2f037811c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -712,6 +712,12 @@ static inline uint64_t u64_add(uint64_t a, uint64_t b)
 # endif
 #endif
 
+/*
+ * Default buffer size for buffered I/O in pack file operations (index-pack,
+ * unpack-objects) and the hashfile layer in csum-file.
+ */
+#define DEFAULT_PACKFILE_BUFFER_SIZE (128 * 1024)
+
 #ifdef HAVE_ALLOCA_H
 # include <alloca.h>
 # define xalloca(size)      (alloca(size))

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
