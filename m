Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B3447D47D
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632957; cv=none; b=hpm1iQMPDXYVJvgGPOv7isyxIXDRThgjO1in4y6uvh6XoDRimGk1J1Is6g9K5+qYi/iMQwNColoTTWhEYpFzzrqCteaRa7VNu5wnURzPeUcuDX5lcC9jxZum9i6gQFLpmqVHzGVk/1zecY8iHr9Ng/stfyTJSD3/T91OpfR3FTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632957; c=relaxed/simple;
	bh=nYDRxAyHlsFYCtj43+qzvE+T9JnBvcNmamiLVlbPI4o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tJD+omFK+InR77OY8EncEHFIUhX9pBKpWNsFSNh8oDhNwpjrglix2apuJMPr9LWHUaVJCG6iZE7JnrwQZBVMRLF0e3Shr8J6jZ6BMpXkmArbB7RZNdFsIFkp+ghALtRg7iHHhEbqDvg71hn8roL7YbCIgzQUwKAxctXzw3B0rCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaTqod+H; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaTqod+H"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6a168dc590cso12787eaf.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786632954; x=1787237754; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RrJK4dZyzwvrgi0UVXYskeNW8qIaeh0CR2dM+eMr4XI=;
        b=iaTqod+HklA1w0214e97yDxS1LgEumppjz478nSK26hy1iD8mEZQxftRlo2+oxRsuK
         5JY+g6/cmb6G+koqizwgmzTeQTmoEDvybMtdSgCafVl3tI0CZRsae2qtWiruly3NvWM4
         KJBE55lgyrfO/66ahBBbBM7oMcIuS5byViGqJUtfptvqN8rPLOUNdin79gwwj1QlA3g8
         pzmxaIpVhiOrVPRAoBAU24l0yrI+4YX0ou9RqdgI2LneeVvv+/gQkZKazDO4RJXq670s
         pt73OTGM4ZB5muoNyqXHiPVzUq4hctkMcPIkO5jVNh+bz2cDB6eoFNjgyHuM2dI47f16
         LkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786632954; x=1787237754;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RrJK4dZyzwvrgi0UVXYskeNW8qIaeh0CR2dM+eMr4XI=;
        b=ECr+pTUWegxDjb/iZwTnov4bD9or4F74JMZy/x+oTu0b2+tKBPFD2LwFqeGDAGi69f
         XTo8JQhod1Jb4Jze6d/e2GdL2QQL/nrn50ZMP88IdXhVEgj+zm69fQ1bGIvI/FL+vAl8
         W0apnulV6UgyRKfooZR6u15bJJ3/jpmXhV+0zDcNHWDs+QfZ2SN/Vtqi2wI9CDIeOc8Q
         DB9KxlPGON0xeMq0Q5QK2WgB6SsD0VpjYGLUd1xzNayMUriCaoAMuZ2uYI+0V3dtopJI
         5i4G2OYBO4W9E0BgIWpTCD+oNsv+LL5Pyg0+ECvFwua9Q4ItuD/bOhoB3NLKztBVvMrD
         XKhA==
X-Gm-Message-State: AOJu0YxzcYD8AGhTfpbHsZXk7Gzceju36H6zPeTge8/205FGCv0hVYYU
	aAhdbDttMy6RopmLXQ48uXTN2CM6lgxDGO47Qw1fREeSSYpk6irFdHS6wzO/dg==
X-Gm-Gg: AR+sD12MrnFxFd+8ZtCmcP/z/hzyD9RG7Fo58kge7TseeBBJGIkwgZiAwKkk361KlsB
	/8r13Dz0mOGTmzCYm9LAGhnBNQdrW45Pn/U2JTJiRizmhap9PdvckPxALeL4LeX7KyhbCuwW8sK
	jwrstKG/MJCqrMGqwJQCQHf91PDtJoqRbi+M1APHKi867ue9sY5ZWGEDF0UmFG6N1hJ0W2Ob9cr
	cRA0hQP3knMTkY3+q55h2ivZECuzMMoNcCHM1GAFa8XVko94QHzjv20HPrWK7KED8YwwT1qDReV
	YAXs3sBZPGnbIpehQcIVNfHwYfbLccxiJRNb0nqOSA7JbGoIH2MZiagjqCexl2mz4d1BDMCezVH
	JCn4pY6SKGI7lBXm+sQc565PqgNMDlQ/b2+9l35XMq03/33NoY4Fh6t417lDLDlMI7KiQDvcnhN
	l5aqoXogPhhUASCV/dawEWsDuh0HKLwUNg0eJedMXw4AspvRohzEsQCQQFMx/NOYdG
X-Received: by 2002:a05:6820:4c11:b0:6ac:ba90:2e9b with SMTP id 006d021491bc7-6b0c4220d22mr5331771eaf.12.1786632954260;
        Thu, 13 Aug 2026 07:55:54 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e656a9a33sm1719619fac.14.2026.08.13.07.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:55:53 -0700 (PDT)
Message-Id: <pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 14:55:38 +0000
Subject: [PATCH v3 00/13] Next size_t stop: pack-objects/delta
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
    Johannes Schindelin <johannes.schindelin@gmx.de>

This patch series continues the effort to stop using unsigned long where
size_t should have been used in the first place. This makes a difference on
64-bit Windows, where unsigned long is 32-bit.

With these fixes, the pack-objects machinery works as intended on 64-bit
Windows (and any other 64-bit platform where unsigned long isn't 64-bit).

Changes since v2:

 * Now zlib_cap_buf() is also widened in this patch series (I had left this
   for a later one, originally).
 * The unpack_object_header_buffer() function is now also widened in this
   here patch series.

Changes since v1:

 * The return value of sizeof_delta_index() is now included in the unsigned
   long -> size_t work.
 * To assign correct values to the now-widened max_delta_cache_size, a new
   pair of helpers are introduced and used: git_parse_size_t() and
   git_config_size_t()
 * There are now two references regarding the provenance of the
   deflateBound() formula in the corresponding commit message.

Johannes Schindelin (13):
  diff-delta: widen `struct delta_index`' size fields to `size_t`
  delta: widen `create_delta_index()` parameter to `size_t`
  pack-objects: widen delta-cache accounting to `size_t`
  pack-objects: widen `free_unpacked()` return to `size_t`
  pack-objects: widen `mem_usage` and `try_delta()`'s out-param to
    `size_t`
  delta: widen `create_delta()` and `diff_delta()` to `size_t`
  packfile, git-zlib: widen `use_pack()` and zstream avail fields to
    `size_t`
  archive-zip: widen `zlib_deflate_raw()`'s maxsize local to `size_t`
  diff: widen `deflate_it()`'s bound local from int to `size_t`
  http-push: widen `start_put()`'s size local from `ssize_t` to `size_t`
  t/helper/test-pack-deltas: widen `do_compress()`'s maxsize local to
    `size_t`
  git-zlib: widen `git_deflate_bound()` to `size_t`
  packfile: widen `unpack_object_header_buffer()` to `size_t`

 archive-zip.c                |  2 +-
 builtin/fast-import.c        |  6 ++++--
 builtin/pack-objects.c       | 32 ++++++++++++++++----------------
 config.c                     |  9 +++++++++
 config.h                     |  3 +++
 delta.h                      | 14 +++++++-------
 diff-delta.c                 | 14 +++++++-------
 diff.c                       |  6 ++++--
 git-zlib.c                   | 18 +++++++++++++++---
 git-zlib.h                   |  6 +++---
 http-push.c                  |  2 +-
 oss-fuzz/fuzz-pack-headers.c |  2 +-
 pack-check.c                 |  4 ++--
 packfile.c                   | 12 +++++-------
 packfile.h                   |  6 ++++--
 parse.c                      |  9 +++++++++
 parse.h                      |  1 +
 t/helper/test-delta.c        |  2 +-
 t/helper/test-pack-deltas.c  |  7 ++++---
 19 files changed, 97 insertions(+), 58 deletions(-)


base-commit: f85a7e662054a7b0d9070e432508831afa214b47
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2175%2Fdscho%2Fsize-t%2Fpack-objects-delta-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2175/dscho/size-t/pack-objects-delta-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2175

Range-diff vs v2:

  1:  0012c1007b =  1:  0012c1007b diff-delta: widen `struct delta_index`' size fields to `size_t`
  2:  75500c5abb =  2:  75500c5abb delta: widen `create_delta_index()` parameter to `size_t`
  3:  5b54041baf =  3:  5b54041baf pack-objects: widen delta-cache accounting to `size_t`
  4:  9850de1a91 =  4:  9850de1a91 pack-objects: widen `free_unpacked()` return to `size_t`
  5:  c301958284 =  5:  c301958284 pack-objects: widen `mem_usage` and `try_delta()`'s out-param to `size_t`
  6:  cfbf6c9567 =  6:  cfbf6c9567 delta: widen `create_delta()` and `diff_delta()` to `size_t`
  7:  ca928b4579 !  7:  e4528f9034 packfile, git-zlib: widen `use_pack()` and zstream avail fields to `size_t`
     @@ builtin/pack-objects.c: size_t oe_get_size_slow(struct packing_data *pack,
       	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
       		size_t sz;
      
     + ## git-zlib.c ##
     +@@ git-zlib.c: static const char *zerr_to_string(int status)
     + 
     + /* uLong is 32-bit on Windows, even on 64-bit systems */
     + #define ULONG_MAX_VALUE maximum_unsigned_value_of_type(uLong)
     +-static inline uInt zlib_buf_cap(unsigned long len)
     ++static inline uInt zlib_buf_cap(size_t len)
     + {
     + 	return (ZLIB_BUF_MAX < len) ? ZLIB_BUF_MAX : len;
     + }
     +
       ## git-zlib.h ##
      @@
       
  8:  9f379ee7aa =  8:  4521a41ff6 archive-zip: widen `zlib_deflate_raw()`'s maxsize local to `size_t`
  9:  ff103a0ee1 =  9:  f0765f6ed6 diff: widen `deflate_it()`'s bound local from int to `size_t`
 10:  c701d2f9b2 = 10:  c91b4d7a7e http-push: widen `start_put()`'s size local from `ssize_t` to `size_t`
 11:  e6175d2d87 = 11:  f4f2fa75f4 t/helper/test-pack-deltas: widen `do_compress()`'s maxsize local to `size_t`
 12:  762e716afe = 12:  b4004b1067 git-zlib: widen `git_deflate_bound()` to `size_t`
  -:  ---------- > 13:  bc4a58336a packfile: widen `unpack_object_header_buffer()` to `size_t`

-- 
gitgitgadget
