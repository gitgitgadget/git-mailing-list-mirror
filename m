Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEDF28DB57
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092906; cv=none; b=Dvi6o2ubjqnBWPM+y5hlgerG5Z/ciiNgj1JmMdRxyB0CCrPYpVdkNuAzdlTfm/e/GJfE/tlsbrLlJyGiG/YkHP0IZRTPCjxOjmeGLT61larY7Ixa4RoM221C5A6sYumoRONq6InmMnDYeaE7E4Lx9bdZHu/DLDrjdRYy0sx38Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092906; c=relaxed/simple;
	bh=6vxrHTKelk5JRkWZogNNxBGkAMf+SScIMaqopwPq+wA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5dApIEbiBixnKSBq4ELCxY3xC0uEn/A5OSvBOKmnBouFl+zGZ/TEXsiPFeCEGSpFwZfEVZYO5tX0kARgbbSGQ2aQ7UkdMli+BU9dwSo+AaRiSSQwwYvKX+6xppbJhTvYGCiKLYN49PUSYyfyWkgeR4OSKJ2LxNnw7T5YxGOZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7TQw6Bo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7TQw6Bo"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-454f428038eso34784875e9.2
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 03:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753092902; x=1753697702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mP/Hyt+jRIXTfU/7XGumBwGV2absecaVhZFaewfpiq8=;
        b=c7TQw6BoOoXiqSRYwwKX8YDZKqBMHFy/LlaRfpCNDAK4GfaCUrZpI+E1Vh12t0NVNE
         L5JG38pBJ7L7WpDgkFr23aUkHKriH/WPToCBD+TSVr6F2lPeNkziP7Z7U2FbUhCoFEhD
         eO/J5Z3OkJpd6qbyNrejNPNaH/VsYIFrMNm8D+MrWECow1R74amuByoVqmhy1tjUsQx+
         3BodTxcY5toxjCt6F67DVeJ2o+1EcJJm9b8Kk1XcIzI6zlI7KRFsESj+J8Tz4/WBkf/v
         cyfojf+erQ5D/hJM6c9XpvLvYPZ5HzTtUfGZUpmNuE9NEHwUTZuIzewvRBJmhhVmep4n
         zR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753092902; x=1753697702;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mP/Hyt+jRIXTfU/7XGumBwGV2absecaVhZFaewfpiq8=;
        b=DtOSy2hKQ8Sv1zjgoldUi0NJVjbE2dVDzbsKUV2pY/FjpJyVvIOblyHKK9ysjiXgss
         EI455qKDLBxE9Xd9VYaza3jp5vvjw2IYn4Q0CVXz8bB6txmZR1VZF28c4YSVX4JXX0Xn
         TUV9WBC9Ecel7asXAXkcbMGuqw7RySLHQT5W4sCzopzoZ9xvAhe2eEG2Ea1ygL0jS3hK
         XthkTW4XeeKKGhwr/JoVXM5ovuSOsFKoKdAV6sbrLo+SJavtUnXn4PdUGzp3OLkmlFZH
         6z9ZVIE+u20xVM7Bqse8AYQUeA02szuYb0+HnhBdh3z7XfnGZ8bsgejx8JgTfpysnoRh
         Rjog==
X-Gm-Message-State: AOJu0YzjNQYA0wU4sCzDDwiAy6HbG8T2DuE9e9/rejwPRwEdjsuSmm0Y
	+uy+ecs6u1kflb2V+dGPSEz3NqmPBCfqC74nxDNo3iLn8TuYDaLqjS5F
X-Gm-Gg: ASbGncvvj8ti8OKkC8SjU3aK2j9NEzCe3YM2gnws1bJYMc5N635SvkToqT+ZRE7dcZd
	wxRGkZ95TqCZYoX7e31I8y4NmbwSmg+j+x3V3Rn4tKYZ21d9zMdfJ/N6SLSKQSoQxlT7jZaUKL+
	kyOVA0G1KZrOBEwxtIJl+XdMCJHPF+1/gCtY9VHeDKc/gNRL5WTAbS9FFpFFNjYVoVSo8HCZLst
	PvX+oDVxkDvopqtknuLptW4tshn5H3mQ3NGKdAg3HPawktDTS5WQWehKM55F8ACEn8pD2+TpT4A
	k60ociOPO6NMRTZQHkLhts5JsiMuIymecgAdp0VZin0Xy3noI0Ng409XnVtdsLcNPWxhLsNMJui
	TuVW+naa/ayruZkJ8lDtTAHlbxuHjQzIJAY6Jir2ym1qYX8A=
X-Google-Smtp-Source: AGHT+IElP6wfABzTy9VPUUykXCsyknGJQb6w8hEegkf9hka2HqHV1c1s+8GxgCWhjdBvRyUXYxS9sQ==
X-Received: by 2002:a05:600c:1d1e:b0:455:f59e:fd9b with SMTP id 5b1f17b1804b1-45636aedcddmr130236995e9.24.1753092902142;
        Mon, 21 Jul 2025 03:15:02 -0700 (PDT)
Received: from [192.168.1.194] ([90.254.76.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e819e04sm156310175e9.18.2025.07.21.03.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 03:15:01 -0700 (PDT)
Message-ID: <45ea5d1d-05dd-4f7a-bee5-ea3936d23d0a@gmail.com>
Date: Mon, 21 Jul 2025 11:14:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
To: Junio C Hamano <gitster@pobox.com>,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <xmqqjz454l96.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqjz454l96.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/07/2025 15:38, Junio C Hamano wrote:
> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This series accelerates xdiff by 5-19%.
> 
> ;-)
> 
> Do we know how much of that can be attributed to the hash algorithm
> difference, and how much for languages?

That's an interesting question. The two patches below [1] switch
xdiff to use xxhash from libxxhash. On my computer the rust and
C implementations both speed up "git log --oneline --shortstat"
by 15%. Just over half of that seems to come from hoisting the
check for whitespace flags in xdl_hash_record() out of the loop
in xdl_prepare_ctx() and the rest comes from the change in hash
function. As I understand it the hash is implemented using SIMD
compiler intrinsics and the rust implementation is basically a
copy of the C code in libxxhash. I wonder how well xxhash performs
compared to our existing hash on platforms without an optimized
implementation.

Thanks

Phillip

[1] These patches are available in the xdiff-hashing-experiments
     branch at https://github.com/phillipwood/git

---- 8< ----
 From 06e7abdcfb9fc3f143ef84644966d6fce128d8ae Mon Sep 17 00:00:00 2001
From: Phillip Wood <phillip.wood@dunelm.org.uk>
Date: Sat, 19 Jul 2025 10:58:48 +0100
Subject: [PATCH 1/2] xdiff: refactor xdl_hash_record()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Inline the check for whitespace flags so that the compiler can hoist
it out of the loop in xdl_prepare_ctx(). This improves the performance
by 8%.

$ hyperfine --warmup=1 -L rev HEAD,HEAD^  --setup='git checkout {rev} -- :/ && make git' ': {rev}; GIT_CONFIG_GLOBAL=/dev/null ./git log --oneline --shortstat v2.0.0..v2.5.0'
Benchmark 1: : HEAD; GIT_CONFIG_GLOBAL=/dev/null ./git log --oneline --shortstat v2.0.0..v2.5.0
   Time (mean ┬▒ ¤â):      1.670 s ┬▒  0.044 s    [User: 1.473 s, System: 0.196 s]
   Range (min ÔÇª max):    1.619 s ÔÇª  1.754 s    10 runs

Benchmark 2: : HEAD^; GIT_CONFIG_GLOBAL=/dev/null ./git log --oneline --shortstat v2.0.0..v2.5.0
   Time (mean ┬▒ ¤â):      1.801 s ┬▒  0.021 s    [User: 1.605 s, System: 0.192 s]
   Range (min ÔÇª max):    1.766 s ÔÇª  1.831 s    10 runs

Summary
   ': HEAD^; GIT_CONFIG_GLOBAL=/dev/null ./git log --oneline --shortstat v2.0.0..v2.5.0' ran
     1.08 ┬▒ 0.03 times faster than ': HEAD^^; GIT_CONFIG_GLOBAL=/dev/null ./git log --oneline --shortstat v2.0.0..v2.5.0'

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
  xdiff/xutils.c |  7 ++-----
  xdiff/xutils.h | 10 +++++++++-
  2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 444a108f87..e070ed649f 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -249,7 +249,7 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
  	return 1;
  }
  
-static unsigned long xdl_hash_record_with_whitespace(char const **data,
+unsigned long xdl_hash_record_with_whitespace(char const **data,
  		char const *top, long flags) {
  	unsigned long ha = 5381;
  	char const *ptr = *data;
@@ -294,13 +294,10 @@ static unsigned long xdl_hash_record_with_whitespace(char const **data,
  	return ha;
  }
  
-unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
+unsigned long xdl_hash_record_verbatim(char const **data, char const *top) {
  	unsigned long ha = 5381;
  	char const *ptr = *data;
  
-	if (flags & XDF_WHITESPACE_FLAGS)
-		return xdl_hash_record_with_whitespace(data, top, flags);
-
  	for (; ptr < top && *ptr != '\n'; ptr++) {
  		ha += (ha << 5);
  		ha ^= (unsigned long) *ptr;
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index fd0bba94e8..13f6831047 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -34,7 +34,15 @@ void *xdl_cha_alloc(chastore_t *cha);
  long xdl_guess_lines(mmfile_t *mf, long sample);
  int xdl_blankline(const char *line, long size, long flags);
  int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags);
-unsigned long xdl_hash_record(char const **data, char const *top, long flags);
+unsigned long xdl_hash_record_verbatim(char const **data, char const *top);
+unsigned long xdl_hash_record_with_whitespace(char const **data, char const *top, long flags);
+static inline unsigned long xdl_hash_record(char const **data, char const *top, long flags)
+{
+	if (flags & XDF_WHITESPACE_FLAGS)
+		return xdl_hash_record_with_whitespace(data, top, flags);
+	else
+		return xdl_hash_record_verbatim(data, top);
+}
  unsigned int xdl_hashbits(unsigned int size);
  int xdl_num_out(char *out, long val);
  int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
-- 
2.49.0.897.gfad3eb7d21


 From 16f3b26624dc17002f3e507cd1e260deadfe1de8 Mon Sep 17 00:00:00 2001
From: Phillip Wood <phillip.wood@dunelm.org.uk>
Date: Sat, 19 Jul 2025 14:52:48 +0100
Subject: [PATCH 2/2] xdiff: use xxhash
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Using XXH3_64bits() from libxxhash to hash the input lines improves
the performance by about 6% and equals the performance of using
xxhash-rust.

$ hyperfine --warmup=1 -L rev en/xdiff-rust/v1,HEAD,HEAD^,HEAD^^  --setup='git checkout {rev} -- :/ && make git' ': {rev}; GIT_CONFIG_GLOBAL=/dev/null ./git log --oneline --shortstat v2.0.0..v2.5.0'
Benchmark 1: : en/xdiff-rust/v1; GIT_CONFIG_GLOBAL=/dev/null ./git log --oneline --shortstat v2.0.0..v2.5.0
   Time (mean ┬▒ ¤â):      1.575 s ┬▒  0.032 s    [User: 1.406 s, System: 0.168 s]
   Range (min ÔÇª max):    1.541 s ÔÇª  1.651 s    10 runs

Benchmark 2: : HEAD; GIT_CONFIG_GLOBAL=/dev/null ./git log --oneline --shortstat v2.0.0..v2.5.0
   Time (mean ┬▒ ¤â):      1.569 s ┬▒  0.018 s    [User: 1.382 s, System: 0.185 s]
   Range (min ÔÇª max):    1.546 s ÔÇª  1.596 s    10 runs

Benchmark 3: : HEAD^; GIT_CONFIG_GLOBAL=/dev/null ./git log --oneline --shortstat v2.0.0..v2.5.0
   Time (mean ┬▒ ¤â):      1.661 s ┬▒  0.026 s    [User: 1.475 s, System: 0.186 s]
   Range (min ÔÇª max):    1.630 s ÔÇª  1.696 s    10 runs

Benchmark 4: : HEAD^^; GIT_CONFIG_GLOBAL=/dev/null ./git log --oneline --shortstat v2.0.0..v2.5.0
   Time (mean ┬▒ ¤â):      1.800 s ┬▒  0.023 s    [User: 1.611 s, System: 0.187 s]
   Range (min ÔÇª max):    1.772 s ÔÇª  1.837 s    10 runs

Summary
   ': HEAD; GIT_CONFIG_GLOBAL=/dev/null ./git log --oneline --shortstat v2.0.0..v2.5.0' ran
     1.00 ┬▒ 0.02 times faster than ': en/xdiff-rust/v1; GIT_CONFIG_GLOBAL=/dev/null ./git log --oneline --shortstat v2.0.0..v2.5.0'
     1.06 ┬▒ 0.02 times faster than ': HEAD^; GIT_CONFIG_GLOBAL=/dev/null ./git log --oneline --shortstat v2.0.0..v2.5.0'
     1.15 ┬▒ 0.02 times faster than ': HEAD^^; GIT_CONFIG_GLOBAL=/dev/null ./git log --oneline --shortstat v2.0.0..v2.5.0'

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
  Makefile       |  1 +
  xdiff/xutils.c | 14 ++++++--------
  2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 5f7dd79dfa..6de7ccdf3b 100644
--- a/Makefile
+++ b/Makefile
@@ -1390,6 +1390,7 @@ UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
  # xdiff and reftable libs may in turn depend on what is in libgit.a
  GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
  EXTLIBS =
+EXTLIBS += -lxxhash
  
  GIT_USER_AGENT = git/$(GIT_VERSION)
  
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index e070ed649f..43fce4b5b1 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -21,7 +21,7 @@
   */
  
  #include "xinclude.h"
-
+#include <xxhash.h>
  
  long xdl_bogosqrt(long n) {
  	long i;
@@ -295,14 +295,12 @@ unsigned long xdl_hash_record_with_whitespace(char const **data,
  }
  
  unsigned long xdl_hash_record_verbatim(char const **data, char const *top) {
-	unsigned long ha = 5381;
-	char const *ptr = *data;
+	long ha;
+	char const *eol = memchr(*data, '\n', top - *data);
+	size_t len = (eol ? eol : top) - *data;
  
-	for (; ptr < top && *ptr != '\n'; ptr++) {
-		ha += (ha << 5);
-		ha ^= (unsigned long) *ptr;
-	}
-	*data = ptr < top ? ptr + 1: ptr;
+	ha = XXH3_64bits(*data, len);
+	*data += len + !!eol;
  
  	return ha;
  }
-- 
2.49.0.897.gfad3eb7d21


