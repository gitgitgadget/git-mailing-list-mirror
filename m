Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CE140242A
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777318004; cv=none; b=JwTrk7WOLmsKumAm3ZlpNO7Ar5Cz2e8GpgR0BmhzbkxGMuMihPEqwJxZLyuSc33T9rm3803F+gO8U4ZFNgiXgXnbriXhpCKSDqMxZB5gF0sw8pS9oZwOD1o3bBtL/9l58mHt31NIn27igJwAAhTAOhx+N6FFqPhwyKhNbGq/nys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777318004; c=relaxed/simple;
	bh=F5zIFp7yvnZ2in+s6DL/gBvdI9AEOkx1Kn3NgANAhPQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iKQJqlMcmBho8oy6U3tLGnMZzy4x1tPvHBg8DWsY9wLTBY2qwB+5UVNDnxKIVOm4cWMm0t+1DWyWbGb10AxzL6zlRe/gGPZVEkQ3kAQj4YyiTeCjZe0dgO6uA/EHBSAPYYIuOhcu46s1qH8cqmHgv/yXJVEhweIwClIGp+FKsvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tMGqsnaa; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMGqsnaa"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7de4ebe10cbso3709713a34.3
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777317999; x=1777922799; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuv2wH2bN8jh+JFlmrM2qiExnTy2f+a0KsmnB1G0HBE=;
        b=tMGqsnaagEtw8YqS+7Im9L+vfH6d63bhnuuA7qlg2rHo47v08odyIk5aGMEAqbj9sj
         9oTT7sqBpPg9JKzgU7oURTV3l9NJF5ud/XbOfle4lM87i1WaMDtGWzhhJaVhRtGWkdpY
         4w8ioNro18y7BOuxMCw+IxcQoBjEej6ZFw9T/09swvoBxXS34ikk5seqCpey0BO8iXhE
         1mQ5iX1wNgwi3or0nQ1Cz6EKGtwhgwtrzGgfSl4euEH9YVnoVJ9Cebij9dcAAePX/ZPD
         XFcNI4MLR1zJxXqlNO1aYhEb41HubCE1JaponsB0+uZYYiimv19CZ2+OUViVSqyKly+/
         G8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777317999; x=1777922799;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fuv2wH2bN8jh+JFlmrM2qiExnTy2f+a0KsmnB1G0HBE=;
        b=qClOJOgY3yqBjMLoxJpetdjjL/qhUDudxx5HcefdgYzm1URjOyKutRfyH/PmEdnt1t
         3csxeLXw0A6aL0FtdRoOy6Ix1E3xRQ2IppODt+H7gT1n38SBY1S6w7HHW2fE9lNVI352
         nfIhN2VoWTJLw2OrKUYu8WzbL6oTRIdSa6R0MDGzumDa4sbmWNjp7ORHm1fesVK5YNob
         Bw2/kU6S0FbsbiYZjjVlEIPLUAiJXJarJwF4xXu7OcgSwCLp8QCE/9B/xnUamzIipddh
         E9xwwxR0bOrxo4NRbtpNjoole3fhl7Jl4+A5YcfcnZ8WEZySLj6YNRPfIY+X47pBJAS3
         d1Fg==
X-Gm-Message-State: AOJu0YxxwNGxObBnusDaPZttbWrkiZjGnrxVpdQRq7VTEK7KNXF7FmJp
	So3egfmOTplnz8N3pHKe6Y3jDoxttWwkDF9Q5VA+TQua//dRypbyJggt4wnNFA==
X-Gm-Gg: AeBDiev5hHCM5nKSU3ibuauya8qR+gosOXbsyDHlLIGj2T8S3rb3ewUArwcaS2VbTqs
	dIy+lUcQz0hkQDNak722r4JG0/72Sp6FPKxghp0W2aF/v3Zd9YwdERvGZFKa8w/hyGpVbAGUvsO
	DWb8gYglhcyWTHMj6SYQDKNUUdT1HXPkpdyLF5KK4vAmOlPa2H7I21blmqWoGnjSC29hxd5OpLS
	yzGjGz+Yc09HGAxCn/Qf5/120WdK2ETLKXiMfJw0gDzHMYsJmxW6e0cjuUjLipWeTP477t+2y+X
	yeKJaioDrFyNL1SHNFyYpKHkH6uZd1kKIpTRj/2+cEkyM1NrtIF0M+5KtSOIgQoI23yMxtTsj2y
	zrSZgI/N1MWjJ7SQM3bJCVfxgNs0vUHu04U4Fvq1PSeQiwWC0jIvpLj/hi41gV+mrLbtZHYe5Po
	4hPVZLn8fjrqn4Mk8jHAGpWeW4W8U19VpWJD/k9A==
X-Received: by 2002:a05:6830:314a:b0:7de:4198:7a2f with SMTP id 46e09a7af769-7de9a0b607emr17324a34.16.1777317999491;
        Mon, 27 Apr 2026 12:26:39 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.164.17])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7de984bf8f1sm262317a34.1.2026.04.27.12.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 12:26:38 -0700 (PDT)
Message-Id: <pull.2282.v3.git.git.1777317998098.gitgitgadget@gmail.com>
In-Reply-To: <pull.2282.v2.git.git.1777306114914.gitgitgadget@gmail.com>
References: <pull.2282.v2.git.git.1777306114914.gitgitgadget@gmail.com>
From: "Scott Bauersfeld via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 27 Apr 2026 19:26:38 +0000
Subject: [PATCH v3] index-pack, unpack-objects: increase input buffer from 4
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
DEFAULT_IO_BUFFER_SIZE constant in git-compat-util.h (next to
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
    DEFAULT_IO_BUFFER_SIZE constant in git-compat-util.h (next to
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
    
    
    Changes since v2
    ================
    
     * Renamed DEFAULT_PACKFILE_BUFFER_SIZE → DEFAULT_IO_BUFFER_SIZE per
       Stolee's feedback. The constant is not packfile-specific, since it is
       also used by the hashfile layer.
     * Stolee noted that WRITE_BUFFER_SIZE in read-cache.c could be
       consolidated. That constant was already removed in f6e2cd0625
       ("read-cache: delete unused hashing methods", 2021-05-18) when
       read-cache.c was converted to use the hashfile API, so there is
       nothing left to unify. The rename to DEFAULT_IO_BUFFER_SIZE helps
       account for the multiple usages of this constant.
    
    
    Changes since v1
    ================
    
     * Introduced shared DEFAULT_PACKFILE_BUFFER_SIZE constant in
       git-compat-util.h (next to MAX_IO_SIZE), replacing per-file #define
       and the hardcoded value in csum-file.c. Placed here rather than
       environment.h since it is an I/O buffer size, not an environment
       variable or repo config.
     * Added wall-clock timing on a FUSE filesystem.
     * Cleaned up the commit description a bit.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2282%2Fsbauersfeld%2Fsb%2Fincrease-index-pack-input-buffer-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2282/sbauersfeld/sb/increase-index-pack-input-buffer-v3
Pull-Request: https://github.com/git/git/pull/2282

Range-diff vs v2:

 1:  ac2559ccb5 ! 1:  df754ac879 index-pack, unpack-objects: increase input buffer from 4 KiB to 128 KiB
     @@ Commit message
          writes with noticeable latency overhead.
      
          Increase the buffer from 4 KiB to 128 KiB. Introduce a shared
     -    DEFAULT_PACKFILE_BUFFER_SIZE constant in git-compat-util.h (next to
     +    DEFAULT_IO_BUFFER_SIZE constant in git-compat-util.h (next to
          MAX_IO_SIZE) and use it in index-pack, unpack-objects, and the
          hashfile layer in csum-file (which already used 128 KiB but
          hardcoded the value).
     @@ builtin/index-pack.c: static int check_self_contained_and_connected;
       
      -/* We always read in 4kB chunks. */
      -static unsigned char input_buffer[4096];
     -+static unsigned char input_buffer[DEFAULT_PACKFILE_BUFFER_SIZE];
     ++static unsigned char input_buffer[DEFAULT_IO_BUFFER_SIZE];
       static unsigned int input_offset, input_len;
       static off_t consumed_bytes;
       static off_t max_input_size;
     @@ builtin/unpack-objects.c
       
      -/* We always read in 4kB chunks. */
      -static unsigned char buffer[4096];
     -+static unsigned char buffer[DEFAULT_PACKFILE_BUFFER_SIZE];
     ++static unsigned char buffer[DEFAULT_IO_BUFFER_SIZE];
       static unsigned int offset, len;
       static off_t consumed_bytes;
       static off_t max_input_size;
     @@ csum-file.c: struct hashfile *hashfd_ext(const struct git_hash_algo *algop,
       	f->algop->init_fn(&f->ctx);
       
      -	f->buffer_len = opts->buffer_len ? opts->buffer_len : 128 * 1024;
     -+	f->buffer_len = opts->buffer_len ? opts->buffer_len : DEFAULT_PACKFILE_BUFFER_SIZE;
     ++	f->buffer_len = opts->buffer_len ? opts->buffer_len : DEFAULT_IO_BUFFER_SIZE;
       	f->buffer = xmalloc(f->buffer_len);
       	f->check_buffer = NULL;
       
     @@ git-compat-util.h: static inline uint64_t u64_add(uint64_t a, uint64_t b)
       #endif
       
      +/*
     -+ * Default buffer size for buffered I/O in pack file operations (index-pack,
     -+ * unpack-objects) and the hashfile layer in csum-file.
     ++ * Default buffer size for buffered I/O in index-pack, unpack-objects,
     ++ * and the hashfile layer in csum-file.
      + */
     -+#define DEFAULT_PACKFILE_BUFFER_SIZE (128 * 1024)
     ++#define DEFAULT_IO_BUFFER_SIZE (128 * 1024)
      +
       #ifdef HAVE_ALLOCA_H
       # include <alloca.h>


 builtin/index-pack.c     | 3 +--
 builtin/unpack-objects.c | 3 +--
 csum-file.c              | 2 +-
 git-compat-util.h        | 6 ++++++
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ca7784dc2c..bb3639641c 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -145,8 +145,7 @@ static int check_self_contained_and_connected;
 
 static struct progress *progress;
 
-/* We always read in 4kB chunks. */
-static unsigned char input_buffer[4096];
+static unsigned char input_buffer[DEFAULT_IO_BUFFER_SIZE];
 static unsigned int input_offset, input_len;
 static off_t consumed_bytes;
 static off_t max_input_size;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index e01cf6e360..af67d1a1d3 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -23,8 +23,7 @@
 static int dry_run, quiet, recover, has_errors, strict;
 static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict]";
 
-/* We always read in 4kB chunks. */
-static unsigned char buffer[4096];
+static unsigned char buffer[DEFAULT_IO_BUFFER_SIZE];
 static unsigned int offset, len;
 static off_t consumed_bytes;
 static off_t max_input_size;
diff --git a/csum-file.c b/csum-file.c
index 9558177a11..d7a682c2b6 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -178,7 +178,7 @@ struct hashfile *hashfd_ext(const struct git_hash_algo *algop,
 	f->algop = unsafe_hash_algo(algop);
 	f->algop->init_fn(&f->ctx);
 
-	f->buffer_len = opts->buffer_len ? opts->buffer_len : 128 * 1024;
+	f->buffer_len = opts->buffer_len ? opts->buffer_len : DEFAULT_IO_BUFFER_SIZE;
 	f->buffer = xmalloc(f->buffer_len);
 	f->check_buffer = NULL;
 
diff --git a/git-compat-util.h b/git-compat-util.h
index ae1bdc90a4..5024814bd4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -712,6 +712,12 @@ static inline uint64_t u64_add(uint64_t a, uint64_t b)
 # endif
 #endif
 
+/*
+ * Default buffer size for buffered I/O in index-pack, unpack-objects,
+ * and the hashfile layer in csum-file.
+ */
+#define DEFAULT_IO_BUFFER_SIZE (128 * 1024)
+
 #ifdef HAVE_ALLOCA_H
 # include <alloca.h>
 # define xalloca(size)      (alloca(size))

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
