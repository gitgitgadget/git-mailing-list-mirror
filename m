Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2702C1C5F23
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220985; cv=none; b=WW6vFUv4R0gjwJnveJMxWyi7nO8mMs93JV2H+3dl+lwpcADf81xPrABb9DXIgYbtq5VqYN/eJCayv8dNmdYSlhbI0F0j0Ak6kRSNdgg/uldtIlxWB4+ix8eMLKLV2LJFP2egEGNK+mhTtj50MYnEtekVbahqu6z2x1Rz/w7vUBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220985; c=relaxed/simple;
	bh=oIPEtVLCXDmtznHcf1E97QMnrm1OGhtHEzf05RF8/x0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=o8MV+vzp2X3pkfggbcdjilgTzskfGM87H71QxgRIym9onU475axmgF/xv5+mxkYho+DGDwkWQz9yNeCqzdm82ax1hPK1YsKvlZNNfAiqNgoVzwUwo3xHiuD3zDYVV5AOdrkKlTt+d6+ho/eYaau7MjDIFA5LWOQsAt584zv8Z+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdg1gC7/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdg1gC7/"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso10572675e9.3
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 18:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755220981; x=1755825781; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gqSZrzwmAhY1ycbZZvFyGq9/InariMvI+QQ39U/1nY=;
        b=fdg1gC7/5Q1/DUJJXWPbM/7geinnT3G0Xq2h7QGUIyFx3ipIiqV6OGblJFtWo/7vLS
         W7m3Xtclv+nPWFOTXyFSlVx8Nw4CW9HD1KB4y8PS0XyjrMnxnQWG/lb6eK/eULngO3SS
         leYUM6AAV1PIi8lvD2Y7Jo5fjdSEgx8GRH30CtYBvPywWOeV3e/8+Gcka4Ks4ScHCaRB
         SZjeWLi2s8T9QEw3+v7J44QBnkKcXz38ETejIKN3iuUktovar1FQPnxmB3W13H1azqbG
         xcgrnqNT9wQ1GpnDDa+vnHAbeHl9VjcRWZNIQRM9xFb+pegrAirerO9zYi8LDZyRZGdu
         7klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220981; x=1755825781;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gqSZrzwmAhY1ycbZZvFyGq9/InariMvI+QQ39U/1nY=;
        b=W+lQXmhjDYdQHndn0kzljH1P96lWHhAbVplZxeiNpvfg5nTixcEG/j15NDg+2gn0D8
         Pkg3BO187lOkder0a/JQoMiIaRXh4+/m3CTU+wJxwa2iGjAgCs1IBoU1N1v/BYWPNVuE
         bFA5RnxMjFSgyxBzTIr3ngDtK3FV1MGldhyw6beIBtB47h63JhNu/gPWq657oVMLd8bP
         eSPqIN7v2jAfTjeF+dAcQC5sIpeHSRAcod6o1kBNub8goKtinHpygzYrwmINW043Ozi3
         xLtdy4pyuuohJKZCADhFrjxNWUp0pCd/bZL0bCy8ksLNSxvabje8RZW7bgmzSDC9/z6u
         5d/w==
X-Gm-Message-State: AOJu0Yxlt3ekCjNjDnf1o72AVrP35qs5IBj/6Nx/zTsjPXpDlkCa1Fjk
	rFPMIT/Y7Vj4z/8xt10MQ+JisXj6ScGqNUlqPe3W/AzC+EmBRDpXRgq7zBRvJw==
X-Gm-Gg: ASbGncsbgvf6KQaQyX5y61KMVNEtJavsU7+ItU8ChcGiXphbkQNYMTjxVhwk+ZbM1Vs
	SSqxqjQeKq/nwnd6xhh3j3ka894Zn+Gb8+D1jk9TsjCgntA6n1kJu/s2avqUpyZIwTYKSkOQ4BV
	3nqO3xJdIQ6e7OKwABz7SYWYU0bap4OydxZzbGjeOjlmXneKAnBfYnNKBbT4raWCd9Rmf+4zsl0
	seSET/UFTkZZTRTR03kJt2zjtmlbi6/F2mt5HZ8oNAMU/p8TcznALhEd7wOH2vh4PW3q+WVXeHy
	uBd8oC/VVwBy74RPeY7PMyuHSw7sSeDTFo0E8P61bybPGKzqFdAaWh4esD+c47nLBQiXrMH/idR
	Y+Kx7QIKj2KwOhI31ztReD0EMQWegk0zizA==
X-Google-Smtp-Source: AGHT+IH3laeXcQY6HezuxhE6us5yfgLKuiivjtXeP/0q5tlb5jJx3RFwLwkAw2RDmPYlX4aRpCP2jw==
X-Received: by 2002:a05:600c:3513:b0:459:dd34:52fb with SMTP id 5b1f17b1804b1-45a2180557emr3005085e9.12.1755220981061;
        Thu, 14 Aug 2025 18:23:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6cec65sm41103505e9.11.2025.08.14.18.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:23:00 -0700 (PDT)
Message-Id: <d74fd4ef67a35fe453cbddab4641dfbef161c9c0.1755220973.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 01:22:42 +0000
Subject: [PATCH v2 07/17] xdiff: conditionally use Rust's implementation of
 xxhash
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Taylor Blau <me@ttaylorr.com>,
    Christian Brabandt <cb@256bit.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Eli Schwartz <eschwartz@gentoo.org>,
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    Patrick Steinhardt <ps@pks.im>,
    Sam James <sam@gentoo.org>,
    Collin Funk <collin.funk1@gmail.com>,
    Mike Hommey <mh@glandium.org>,
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

When no whitespace flags are present use xxhash, for faster
hashing, otherwise use DJB2a (which is what xdiff has been
using all along).

The benchmark below compares my series with version v2.49.0
(built in build_release/ and build_v2.49.0/ respectively),
running log commands on linux kernel with 3 different machines.

$ BASE=/path/to/git/root

    // laptop
    // CPU: 6-core Intel Core i7-8750H (-MT MCP-) speed/min/max: 726/800/4100 MHz
    $ hyperfine --warmup 3 -L exe $BASE/build_release/git,$BASE/build_v2.49.0/git '{exe} log --oneline --shortstat v6.8..v6.9 >/dev/null'
    Benchmark 1: /home/ezekiel/development/work/git/build_release/git log --oneline --shortstat v6.8..v6.9 >/dev/null
      Time (mean ± σ):     10.419 s ±  0.166 s    [User: 10.097 s, System: 0.284 s]
      Range (min … max):   10.215 s … 10.680 s    10 runs

    Benchmark 2: /home/ezekiel/development/work/git/build_v2.49.0/git log --oneline --shortstat v6.8..v6.9 >/dev/null
      Time (mean ± σ):     10.980 s ±  0.137 s    [User: 10.633 s, System: 0.308 s]
      Range (min … max):   10.791 s … 11.178 s    10 runs

    Summary
      /home/ezekiel/development/work/git/build_release/git log --oneline --shortstat v6.8..v6.9 >/dev/null ran
        1.05 ± 0.02 times faster than /home/ezekiel/development/work/git/build_v2.49.0/git log --oneline --shortstat v6.8..v6.9 >/dev/null

    // desktop
    // CPU: 8-core Intel Core i7-9700 (-MCP-) speed/min/max: 800/800/4700 MHz
    $ hyperfine --warmup 3 -L exe $BASE/build_release/git,$BASE/build_v2.49.0/git '{exe} log --oneline --shortstat v6.8..v6.9 >/dev/null'
    Benchmark 1: /home/steamuser/dev/git/build_release/git log --oneline --shortstat v6.8..v6.9 >/dev/null
      Time (mean ± σ):      6.823 s ±  0.020 s    [User: 6.624 s, System: 0.180 s]
      Range (min … max):    6.801 s …  6.858 s    10 runs

    Benchmark 2: /home/steamuser/dev/git/build_v2.49.0/git log --oneline --shortstat v6.8..v6.9 >/dev/null
      Time (mean ± σ):      8.151 s ±  0.024 s    [User: 7.928 s, System: 0.198 s]
      Range (min … max):    8.105 s …  8.184 s    10 runs

    Summary
      /home/steamuser/dev/git/build_release/git log --oneline --shortstat v6.8..v6.9 >/dev/null ran
        1.19 ± 0.01 times faster than /home/steamuser/dev/git/build_v2.49.0/git log --oneline --shortstat v6.8..v6.9 >/dev/null

    // router
    // CPU: dual core Intel Celeron 3965U (-MCP-) speed/min/max: 1300/400/2200 MHz
    $ hyperfine --warmup 3 -L exe $BASE/build_release/git,$BASE/build_v2.49.0/git '{exe} log --oneline --shortstat v6.8..v6.9 >/dev/null'
    Benchmark 1: /home/metal/dev/git/build_release/git log --oneline --shortstat v6.8..v6.9 >/dev/null
      Time (mean ± σ):     21.209 s ±  0.054 s    [User: 20.341 s, System: 0.605 s]
      Range (min … max):   21.135 s … 21.309 s    10 runs

    Benchmark 2: /home/metal/dev/git/build_v2.49.0/git log --oneline --shortstat v6.8..v6.9 >/dev/null
      Time (mean ± σ):     23.683 s ±  0.060 s    [User: 22.735 s, System: 0.672 s]
      Range (min … max):   23.566 s … 23.751 s    10 runs

    Summary
      /home/metal/dev/git/build_release/git log --oneline --shortstat v6.8..v6.9 >/dev/null ran
        1.12 ± 0.00 times faster than /home/metal/dev/git/build_v2.49.0/git log --oneline --shortstat v6.8..v6.9 >/dev/null

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 rust/xdiff/Cargo.toml |  1 +
 rust/xdiff/src/lib.rs |  7 +++++++
 xdiff/xprepare.c      | 19 +++++++++++++++++--
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/rust/xdiff/Cargo.toml b/rust/xdiff/Cargo.toml
index eb7966aada64..1516e829db18 100644
--- a/rust/xdiff/Cargo.toml
+++ b/rust/xdiff/Cargo.toml
@@ -13,3 +13,4 @@ crate-type = ["staticlib", "rlib"]
 
 [dependencies]
 interop = { path = "../interop" }
+xxhash-rust = { version = "0.8.15", features = ["xxh3"] }
diff --git a/rust/xdiff/src/lib.rs b/rust/xdiff/src/lib.rs
index e69de29bb2d1..96975975a1ba 100644
--- a/rust/xdiff/src/lib.rs
+++ b/rust/xdiff/src/lib.rs
@@ -0,0 +1,7 @@
+
+
+#[no_mangle]
+unsafe extern "C" fn xxh3_64(ptr: *const u8, size: usize) -> u64 {
+    let slice = std::slice::from_raw_parts(ptr, size);
+    xxhash_rust::xxh3::xxh3_64(slice)
+}
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 031c1752cc1a..c0463bacd94b 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -160,6 +160,9 @@ static void xdl_parse_lines(mmfile_t *mf, long narec, xdfile_t *xdf) {
 }
 
 
+extern u64 xxh3_64(u8 const* ptr, usize size);
+
+
 static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
 			   xdlclassifier_t *cf, xdfile_t *xdf) {
 	unsigned long *ha;
@@ -175,14 +178,26 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 	xdl_parse_lines(mf, narec, xdf);
 
+	if ((xpp->flags & XDF_WHITESPACE_FLAGS) == 0) {
+		for (usize i = 0; i < (usize) xdf->nrec; i++) {
+			xrecord_t *rec = xdf->recs[i];
+			rec->ha = xxh3_64(rec->ptr, rec->size);
+		}
+	} else {
+		for (usize i = 0; i < (usize) xdf->nrec; i++) {
+			xrecord_t *rec = xdf->recs[i];
+			char const* dump = (char const*) rec->ptr;
+			rec->ha = xdl_hash_record(&dump, (char const*) (rec->ptr + rec->size), xpp->flags);
+		}
+	}
+
 	for (usize i = 0; i < (usize) xdf->nrec; i++) {
 		xrecord_t *rec = xdf->recs[i];
-		char const* dump = (char const*) rec->ptr;
-		rec->ha = xdl_hash_record(&dump, (char const*) (rec->ptr + rec->size), xpp->flags);
 		xdl_classify_record(pass, cf, rec);
 	}
 
 
+
 	if (!XDL_CALLOC_ARRAY(rchg, xdf->nrec + 2))
 		goto abort;
 
-- 
gitgitgadget

