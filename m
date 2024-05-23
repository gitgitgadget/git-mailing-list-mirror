Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32FC5579F
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499572; cv=none; b=CsjHL3SJvy/Xn/canF6/K9JE4Dg1SN+FnirwFQXZrydjBS4to29IWhNinCgaLJWWJLrbp4efZt/diXmtVyaf6DY7axWTvS4ho00LI86V1R/nheV5UTtLd1d43iLqwbBoVsaEChRDAh5x4E69y4QZPzcqqAFoa+1KalxWDaAyQQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499572; c=relaxed/simple;
	bh=dmF1let0oYAxW9KgqUxwVzducZkvOfWpCZcqisUJWEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQZPQu7Qm9ct8eQnP2jqZu3T8a0p/KP/EyQpH9G0BeN+3Ou76KEtIK6F/I1okGUWhvhcWi6PmBgpoQfmXI+W/7/xeDW2aU7/pY4JVpC6hwaUA6Hrml97V6TUOkfjUno/4rzrlEWRPfnN9KJ3GYxm1lTYe13Ggj0+Pq1pEKmnTcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=dqczMwEO; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="dqczMwEO"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f855b2499cso570328a34.1
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499568; x=1717104368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/H0m9t5gdKWYRDmqzkasDPkQtY6bTayc2c+QYfBmGm8=;
        b=dqczMwEOk79L+WUw7Q9pywjVUq+0qtSf78Ds/uW4h5Ps1EdprCjxiru/AgshqJEnwz
         gnbcEgVQn1UjoEdlw+ViqKyly7R/XqWOU80nIuU3pcONsAqy2wf0Nmbl7mFO4tEB5Koy
         KZP9l3Ysdr2pnmiGRtXSokQlsSevLXFWc8i/bnUhbeMaiSH3ga0Ek5yhWv5KEi7LrEz8
         MEaNaSgGYHcZA4TxLXN1Bz5VkKAETu5INisadYvRSs87AYZ9DCB6Bi9jPrYm6/Ql3nCs
         4b+3nTv6ZsZBuHTN5UjZyGlxm5I9/nTlmZns8DawMWQtJ3Sy/m5OxdYkIIxZGwNqqnH0
         vLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499568; x=1717104368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/H0m9t5gdKWYRDmqzkasDPkQtY6bTayc2c+QYfBmGm8=;
        b=gRtGTZfhz5/9pU/j7zlJmrR0uFVreI34CJiGYAFbDJ4GvmXRFvAxY7k4TIowvNDKwT
         yvTpm3wWUIPgdD9g6axXI2wPAqMf24vsZJY6D/lfo0QKYXYqiDr568V8frdiQV8yhDVo
         kPR2SFbGda9YpS83+/SCAlV65q6oC1MO8gTm0psdl9nCzbx8ZIPI/U9omhd9Vy4nHtcP
         7DpF9Snv33yZGFRN3Jnw6j6v/UWhd+zMGcWFy4+sO3JNZ4U4Uy0wGR6OOCh0447+p/2d
         ESWprSUlyGzXIe4bxquzkxMqvmNrBN4fe8NiHX95XiXNHga22tV45ct/gnoQ4CoiwPPo
         KWXQ==
X-Gm-Message-State: AOJu0YzWsIAzE+4CxZ5tpHDoziyQI+4Vv+/UbEgqK+Z5Fu+tTTXxd7zf
	h6ZLX0PO7NsYOnsBPzmJNblbbuonCb/SYfdOqvNV0H21ZANTERPxfskHaWbI3Q0K0SX5uLj+vhT
	j
X-Google-Smtp-Source: AGHT+IGnabDn/rwI7cT7IUWjjKWr9xOHMSoJ3A0q17Don9lhNQDBlRvKaYtl5570Fb7k9G51gRdJEg==
X-Received: by 2002:a9d:6c11:0:b0:6f0:81f8:1ba7 with SMTP id 46e09a7af769-6f8d0a54836mr420897a34.6.1716499568407;
        Thu, 23 May 2024 14:26:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb15fcf2fsm721901cf.0.2024.05.23.14.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:26:07 -0700 (PDT)
Date: Thu, 23 May 2024 17:26:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 00/24] pack-bitmap: pseudo-merge reachability bitmaps
Message-ID: <cover.1716499565.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1710972293.git.me@ttaylorr.com>

Here is another reroll my topic to introduce pseudo-merge bitmaps.

The implementation is still relatively unchanged compared to last time,
save for the review that Peff provided on the remaining parts of this
series.

As usual, there is a range-diff below, but the significant changes since
last time are as follows:

  - replace git_config_float() with git_config_double() (and matching
    tweaks in the callers)

  - add a NOTE to gitpacking(7) reflecting that the pseudo-merge bitmaps
    feature is considered experimental

  - add a length check when reading extended pseudo merges via the
    pseudo_merge_ext_at() function

  - replace the new `--date` option for `test_commit_bulk` with a
    `--notick` option (and set the GIT_COMMITTER_DATE values
    appropriately at the callers)

  - fix broken performance tests due to a typo on "pseudo", and include
    results from a large repository.

The series is still based on 'tb/pack-bitmap-write-cleanups'.

Taylor Blau (24):
  Documentation/gitpacking.txt: initial commit
  Documentation/gitpacking.txt: describe pseudo-merge bitmaps
  Documentation/technical: describe pseudo-merge bitmaps format
  ewah: implement `ewah_bitmap_is_subset()`
  pack-bitmap: move some initialization to `bitmap_writer_init()`
  pseudo-merge.ch: initial commit
  pack-bitmap-write: support storing pseudo-merge commits
  pack-bitmap: implement `bitmap_writer_has_bitmapped_object_id()`
  pack-bitmap: make `bitmap_writer_push_bitmapped_commit()` public
  config: introduce `git_config_double()`
  pseudo-merge: implement support for selecting pseudo-merge commits
  pack-bitmap-write.c: write pseudo-merge table
  pack-bitmap: extract `read_bitmap()` function
  pseudo-merge: scaffolding for reads
  pack-bitmap.c: read pseudo-merge extension
  pseudo-merge: implement support for reading pseudo-merge commits
  ewah: implement `ewah_bitmap_popcount()`
  pack-bitmap: implement test helpers for pseudo-merge
  t/test-lib-functions.sh: support `--notick` in `test_commit_bulk()`
  pack-bitmap.c: use pseudo-merges during traversal
  pack-bitmap: extra trace2 information
  ewah: `bitmap_equals_ewah()`
  pseudo-merge: implement support for finding existing merges
  t/perf: implement performance tests for pseudo-merge bitmaps

 Documentation/Makefile                       |   1 +
 Documentation/config.txt                     |   2 +
 Documentation/config/bitmap-pseudo-merge.txt |  91 +++
 Documentation/gitpacking.txt                 | 189 +++++
 Documentation/technical/bitmap-format.txt    | 132 ++++
 Makefile                                     |   1 +
 builtin/pack-objects.c                       |   3 +-
 config.c                                     |   9 +
 config.h                                     |   7 +
 ewah/bitmap.c                                |  76 ++
 ewah/ewok.h                                  |   8 +
 midx-write.c                                 |   2 +-
 object.h                                     |   2 +-
 pack-bitmap-write.c                          | 274 ++++++-
 pack-bitmap.c                                | 359 ++++++++-
 pack-bitmap.h                                |  19 +-
 parse.c                                      |  29 +
 parse.h                                      |   1 +
 pseudo-merge.c                               | 756 +++++++++++++++++++
 pseudo-merge.h                               | 216 ++++++
 t/helper/test-bitmap.c                       |  34 +-
 t/perf/p5333-pseudo-merge-bitmaps.sh         |  32 +
 t/t5333-pseudo-merge-bitmaps.sh              | 393 ++++++++++
 t/test-lib-functions.sh                      |   9 +-
 24 files changed, 2590 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/config/bitmap-pseudo-merge.txt
 create mode 100644 Documentation/gitpacking.txt
 create mode 100644 pseudo-merge.c
 create mode 100644 pseudo-merge.h
 create mode 100755 t/perf/p5333-pseudo-merge-bitmaps.sh
 create mode 100755 t/t5333-pseudo-merge-bitmaps.sh

Range-diff against v3:
 -:  ----------- >  1:  0f20c9becf4 Documentation/gitpacking.txt: initial commit
 1:  528b591bd84 !  2:  48afaa74928 Documentation/gitpacking.txt: describe pseudo-merge bitmaps
    @@ Documentation/gitpacking.txt: There are many aspects of packing in Git that are
      
     +== Pseudo-merge bitmaps
     +
    ++NOTE: Pseudo-merge bitmaps are considered an experimental feature, so
    ++the configuration and many of the ideas are subject to change.
    ++
     +=== Background
     +
     +Reachability bitmaps are most efficient when we have on-disk stored
 2:  12f318b3d7e =  3:  44046f83c1a Documentation/technical: describe pseudo-merge bitmaps format
 3:  40eb6137618 =  4:  211d6f14128 ewah: implement `ewah_bitmap_is_subset()`
 4:  487fb7c6e9c =  5:  650cac2dcf9 pack-bitmap: move some initialization to `bitmap_writer_init()`
 5:  827732acf99 =  6:  6647d8832ce pseudo-merge.ch: initial commit
 6:  8608dd1860f =  7:  e8ef1ef5ee4 pack-bitmap-write: support storing pseudo-merge commits
 7:  99d2b6872ba =  8:  fe458728c8a pack-bitmap: implement `bitmap_writer_has_bitmapped_object_id()`
 8:  e7209c60fa5 =  9:  6bf372f4020 pack-bitmap: make `bitmap_writer_push_bitmapped_commit()` public
 9:  3070135eb4b ! 10:  6c77671ae9c config: introduce git_config_float()
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    config: introduce git_config_float()
    +    config: introduce `git_config_double()`
     
    -    Future commits will want to parse a floating point value from
    -    configuration, but we have no way to parse such a value prior to this
    -    patch.
    +    Future commits will want to parse a double-precision floating point
    +    value from configuration, but we have no way to parse such a value prior
    +    to this patch.
     
    -    The core of the routine is implemented in git_parse_float(). Unlike
    +    The core of the routine is implemented in git_parse_double(). Unlike
         git_parse_unsigned() and git_parse_signed(), however, the function
    -    implemented here only works on type "float", and not related types like
    -    "double", or "long double".
    +    implemented here only works on type "double", and not related types like
    +    "float", or "long double".
     
    -    This is because "double" and "long double" use different functions to
    -    convert from ASCII strings to floating point values (strtod() and
    +    This is because "float" and "long double" use different functions to
    +    convert from ASCII strings to floating point values (strtof() and
         strtold(), respectively). Likewise, there is no pointer type that can
         assign to any of these values (except for "void *"), so the only way to
         define this trio of functions would be with a macro expansion that is
         parameterized over the floating point type and conversion function.
     
         That is all doable, but likely to be overkill given our current needs,
    -    which is only to parse floats.
    +    which is only to parse double-precision floats.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ config.c: ssize_t git_config_ssize_t(const char *name, const char *value,
      	return ret;
      }
      
    -+float git_config_float(const char *name, const char *value,
    -+		       const struct key_value_info *kvi)
    ++double git_config_double(const char *name, const char *value,
    ++			 const struct key_value_info *kvi)
     +{
    -+	float ret;
    -+	if (!git_parse_float(value, &ret))
    ++	double ret;
    ++	if (!git_parse_double(value, &ret))
     +		die_bad_number(name, value, kvi);
     +	return ret;
     +}
    @@ config.h: unsigned long git_config_ulong(const char *, const char *,
      			   const struct key_value_info *);
      
     +/**
    -+ * Identical to `git_config_int`, but for floating point values.
    ++ * Identically to `git_config_double`, but for double-precision floating point
    ++ * values.
     + */
    -+float git_config_float(const char *, const char *,
    -+		       const struct key_value_info *);
    ++double git_config_double(const char *, const char *,
    ++			 const struct key_value_info *);
     +
      /**
       * Same as `git_config_bool`, except that integers are returned as-is, and
    @@ parse.c: int git_parse_ssize_t(const char *value, ssize_t *ret)
      	return 1;
      }
      
    -+int git_parse_float(const char *value, float *ret)
    ++int git_parse_double(const char *value, double *ret)
     +{
     +	char *end;
    -+	float val;
    ++	double val;
     +	uintmax_t factor;
     +
     +	if (!value || !*value) {
    @@ parse.c: int git_parse_ssize_t(const char *value, ssize_t *ret)
     +	}
     +
     +	errno = 0;
    -+	val = strtof(value, &end);
    ++	val = strtod(value, &end);
     +	if (errno == ERANGE)
     +		return 0;
     +	if (end == value) {
    @@ parse.h: int git_parse_ssize_t(const char *, ssize_t *);
      int git_parse_ulong(const char *, unsigned long *);
      int git_parse_int(const char *value, int *ret);
      int git_parse_int64(const char *value, int64_t *ret);
    -+int git_parse_float(const char *value, float *ret);
    ++int git_parse_double(const char *value, double *ret);
      
      /**
       * Same as `git_config_bool`, except that it returns -1 on error rather
10:  3029473c094 ! 11:  180072ce848 pseudo-merge: implement support for selecting pseudo-merge commits
    @@ Documentation/config/bitmap-pseudo-merge.txt (new)
     @@
     +NOTE: The configuration options in `bitmapPseudoMerge.*` are considered
     +EXPERIMENTAL and may be subject to change or be removed entirely in the
    -+future.
    ++future. For more information about the pseudo-merge bitmap feature, see
    ++the "Pseudo-merge bitmaps" section of linkgit:gitpacking[7].
     +
     +bitmapPseudoMerge.<name>.pattern::
     +	Regular expression used to match reference names. Commits
    @@ pseudo-merge.c
     +#include "alloc.h"
     +#include "progress.h"
     +
    -+#define DEFAULT_PSEUDO_MERGE_DECAY 1.0f
    ++#define DEFAULT_PSEUDO_MERGE_DECAY 1.0
     +#define DEFAULT_PSEUDO_MERGE_MAX_MERGES 64
     +#define DEFAULT_PSEUDO_MERGE_SAMPLE_RATE 1
     +#define DEFAULT_PSEUDO_MERGE_THRESHOLD approxidate("1.week.ago")
     +#define DEFAULT_PSEUDO_MERGE_STABLE_THRESHOLD approxidate("1.month.ago")
     +#define DEFAULT_PSEUDO_MERGE_STABLE_SIZE 512
     +
    -+static float gitexp(float base, int exp)
    ++static double gitexp(double base, int exp)
     +{
    -+	float result = 1;
    ++	double result = 1;
     +	while (1) {
     +		if (exp % 2)
     +			result *= base;
    @@ pseudo-merge.c
     +					const struct pseudo_merge_matches *matches,
     +					uint32_t i)
     +{
    -+	float C = 0.0f;
    ++	double C = 0.0f;
     +	uint32_t n;
     +
     +	/*
    @@ pseudo-merge.c
     +	 *   { 5012, 1772, 964, 626, 448, 341, 271, 221, 186, 158 }
     +	 */
     +	for (n = 0; n < group->max_merges; n++)
    -+		C += 1.0f / gitexp(n + 1, group->decay);
    ++		C += 1.0 / gitexp(n + 1, group->decay);
     +	C = matches->unstable_nr / C;
     +
     +	return (uint32_t)((C / gitexp(i + 1, group->decay)) + 0.5);
    @@ pseudo-merge.c
     +
     +		strbuf_release(&re);
     +	} else if (!strcmp(key, "decay")) {
    -+		group->decay = git_config_float(var, value, ctx->kvi);
    ++		group->decay = git_config_double(var, value, ctx->kvi);
     +		if (group->decay < 0) {
     +			warning(_("%s must be non-negative, using default"), var);
     +			group->decay = DEFAULT_PSEUDO_MERGE_DECAY;
     +		}
     +	} else if (!strcmp(key, "samplerate")) {
    -+		group->sample_rate = git_config_float(var, value, ctx->kvi);
    ++		group->sample_rate = git_config_double(var, value, ctx->kvi);
     +		if (!(0 <= group->sample_rate && group->sample_rate <= 1)) {
     +			warning(_("%s must be between 0 and 1, using default"), var);
     +			group->sample_rate = DEFAULT_PSEUDO_MERGE_SAMPLE_RATE;
    @@ pseudo-merge.c
     +			struct commit *c = matches->unstable[j];
     +			struct pseudo_merge_commit_idx *pmc;
     +
    -+			if (j % (uint32_t)(1.0f / group->sample_rate))
    ++			if (j % (uint32_t)(1.0 / group->sample_rate))
     +				continue;
     +
     +			pmc = pseudo_merge_idx(writer->pseudo_merge_commits,
    @@ pseudo-merge.h
     +	 * Pseudo-merge grouping parameters. See git-config(1) for
     +	 * more information.
     +	 */
    -+	float decay;
    ++	double decay;
     +	int max_merges;
    -+	float sample_rate;
    ++	double sample_rate;
     +	int stable_size;
     +	timestamp_t threshold;
     +	timestamp_t stable_threshold;
11:  311226f65c2 = 12:  90df19e43f5 pack-bitmap-write.c: write pseudo-merge table
12:  55dd7a8023e = 13:  c653a10f8e4 pack-bitmap: extract `read_bitmap()` function
13:  3cc5434e44e = 14:  435ac048003 pseudo-merge: scaffolding for reads
14:  7664f5f9648 = 15:  fa7a948964c pack-bitmap.c: read pseudo-merge extension
15:  8ba0a9c5402 ! 16:  3a72e66cb69 pseudo-merge: implement support for reading pseudo-merge commits
    @@ pseudo-merge.c
      #include "progress.h"
     +#include "hex.h"
      
    - #define DEFAULT_PSEUDO_MERGE_DECAY 1.0f
    + #define DEFAULT_PSEUDO_MERGE_DECAY 1.0
      #define DEFAULT_PSEUDO_MERGE_MAX_MERGES 64
     @@ pseudo-merge.c: void free_pseudo_merge_map(struct pseudo_merge_map *pm)
      	}
    @@ pseudo-merge.c: void free_pseudo_merge_map(struct pseudo_merge_map *pm)
     +		return error(_("extended pseudo-merge read out-of-bounds "
     +			       "(%"PRIuMAX" >= %"PRIuMAX")"),
     +			     (uintmax_t)at, (uintmax_t)pm->map_size);
    ++	if (at + 4 >= pm->map_size)
    ++		return error(_("extended pseudo-merge entry is too short "
    ++			       "(%"PRIuMAX" >= %"PRIuMAX")"),
    ++			     (uintmax_t)(at + 4), (uintmax_t)pm->map_size);
     +
     +	ext->nr = get_be32(pm->map + at);
     +	ext->ptr = pm->map + at + sizeof(uint32_t);
16:  2c02f303b6f = 17:  42a836fda8a ewah: implement `ewah_bitmap_popcount()`
17:  82cce72bf55 = 18:  06ba1a5bbfd pack-bitmap: implement test helpers for pseudo-merge
18:  890f6c4b9de ! 19:  936f6d1b7e3 t/test-lib-functions.sh: support `--date` in `test_commit_bulk()`
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    t/test-lib-functions.sh: support `--date` in `test_commit_bulk()`
    +    t/test-lib-functions.sh: support `--notick` in `test_commit_bulk()`
     
         One of the tests we'll want to add for pseudo-merge bitmaps needs to be
         able to generate a large number of commits at a specific date.
     
    -    Support the `--date` option (with identical semantics to the `--date`
    -    option for `test_commit()`) within `test_commit_bulk` as a prerequisite
    -    for that.
    +    Support the `--notick` option (with identical semantics to the
    +    `--notick` option for `test_commit()`) within `test_commit_bulk` as a
    +    prerequisite for that. Callers can then set the various _DATE variables
    +    themselves.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ t/test-lib-functions.sh: test_commit_bulk () {
      			filename="${1#--*=}-%s.t"
      			contents="${1#--*=} %s"
      			;;
    -+		--date)
    ++		--notick)
     +			notick=yes
    -+			GIT_COMMITTER_DATE="$2"
    -+			GIT_AUTHOR_DATE="$2"
    -+			shift
     +			;;
      		-*)
      			BUG "invalid test_commit_bulk option: $1"
19:  41691824f78 ! 20:  cad38608aae pack-bitmap.c: use pseudo-merges during traversal
    @@ t/t5333-pseudo-merge-bitmaps.sh (new)
     +		new="1672549200" && # 2023-01-01
     +		old="1641013200" && # 2022-01-01
     +
    -+		test_commit_bulk --message="new" --date "$new +0000" 128 &&
    -+		test_commit_bulk --message="old" --date "$old +0000" 128 &&
    -+		test_tick &&
    ++		GIT_COMMITTER_DATE="$new +0000" &&
    ++		export GIT_COMMITTER_DATE &&
    ++		test_commit_bulk --message="new" --notick 128 &&
    ++
    ++		GIT_COMMITTER_DATE="$old +0000" &&
    ++		export GIT_COMMITTER_DATE &&
    ++		test_commit_bulk --message="old" --notick 128 &&
     +
     +		tag_everything &&
     +
    @@ t/t5333-pseudo-merge-bitmaps.sh (new)
     +		mid="1654059600" && # 2022-06-01
     +		old="1641013200" && # 2022-01-01
     +
    -+		test_commit_bulk --message="mid" --date "$mid +0000" 128 &&
    -+		test_tick &&
    ++		GIT_COMMITTER_DATE="$mid +0000" &&
    ++		export GIT_COMMITTER_DATE &&
    ++		test_commit_bulk --message="mid" --notick 128 &&
     +
     +		git for-each-ref --format="delete %(refname)" refs/tags >in &&
     +		git update-ref --stdin <in &&
20:  a34a60c3ef8 = 21:  9240b06a7d8 pack-bitmap: extra trace2 information
21:  da2fb5b4b48 = 22:  625596a1432 ewah: `bitmap_equals_ewah()`
22:  ff21247281f ! 23:  fdd506d4544 pseudo-merge: implement support for finding existing merges
    @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'pseudo-merge overlap stale
     +		stable="1641013200" && # 2022-01-01
     +		unstable="1672549200" && # 2023-01-01
     +
    -+		for date in $stable $unstable
    -+		do
    -+			test_commit_bulk --date "$date +0000" 128 &&
    -+			test_tick || return 1
    -+		done &&
    ++		GIT_COMMITTER_DATE="$stable +0000" &&
    ++		export GIT_COMMITTER_DATE &&
    ++		test_commit_bulk --notick 128 &&
    ++		GIT_COMMITTER_DATE="$unstable +0000" &&
    ++		export GIT_COMMITTER_DATE &&
    ++		test_commit_bulk --notick 128 &&
     +
     +		tag_everything &&
     +
23:  6a6d88fa512 ! 24:  cf0316ad0e9 t/perf: implement performace tests for pseudo-merge bitmaps
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    t/perf: implement performace tests for pseudo-merge bitmaps
    +    t/perf: implement performance tests for pseudo-merge bitmaps
     
         Implement a straightforward performance test demonstrating the benefit
         of pseudo-merge bitmaps by measuring how long it takes to count
    @@ Commit message
     
             Test                                                                this tree
             -----------------------------------------------------------------------------------
    -        5333.2: git rev-list --count --all --objects (no bitmaps)           3.46(3.37+0.09)
    -        5333.3: git rev-list --count --all --objects (no pseudo-merges)     0.13(0.11+0.01)
    +        5333.2: git rev-list --count --all --objects (no bitmaps)           3.54(3.45+0.08)
    +        5333.3: git rev-list --count --all --objects (no pseudo-merges)     0.43(0.40+0.03)
             5333.4: git rev-list --count --all --objects (with pseudo-merges)   0.12(0.11+0.01)
     
    +    On a private repository which is much larger, and has many spikey parts
    +    of history that aren't merged into the 'master' branch, the results are
    +    as follows:
    +
    +        Test                                                                this tree
    +        ---------------------------------------------------------------------------------------
    +        5333.1: git rev-list --count --all --objects (no bitmaps)           122.29(121.31+0.97)
    +        5333.2: git rev-list --count --all --objects (no pseudo-merges)     21.88(21.30+0.58)
    +        5333.3: git rev-list --count --all --objects (with pseudo-merges)   5.05(4.77+0.28)
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## t/perf/p5333-pseudo-merge-bitmaps.sh (new) ##
    @@ t/perf/p5333-pseudo-merge-bitmaps.sh (new)
     +'
     +
     +test_perf 'git rev-list --count --all --objects (no pseudo-merges)' '
    -+	GIT_TEST_USE_PSEDUO_MERGES=0 \
    ++	GIT_TEST_USE_PSEUDO_MERGES=0 \
     +		git rev-list --objects --all --use-bitmap-index
     +'
     +
     +test_perf 'git rev-list --count --all --objects (with pseudo-merges)' '
    -+	GIT_TEST_USE_PSEDUO_MERGES=1 \
    ++	GIT_TEST_USE_PSEUDO_MERGES=1 \
     +		git rev-list --objects --all --use-bitmap-index
     +'
     +

base-commit: bf65967764f34adc2ca00d4c8195840ad3e4e127
-- 
2.45.1.175.gcf0316ad0e9
