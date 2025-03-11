Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA0D1C695
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 00:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741652511; cv=none; b=u65JAGsTbr48mqyzOxq53h1gKtGiPLiWW93owaVs7fcd4DjhYNcZgive6pp+Io7yv9CDzQEFIPKrLCDJcyFOoIyMnHGB245aj+O1xXDCB6/HhlFwENsBOiuu8Az5XfjvfAyjpQiQmFnLgk1sLqqxY1MmJKitb4Mmx+PyBp3f6z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741652511; c=relaxed/simple;
	bh=l6ue9Z9lM94WN/+NHToCp+1p4WjXKWnzYAWGBLBR+Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S15wUwYvihPFgInJCPtABplmDEEYSjH87duvzBcrJQrEzd9LF4MPL913DcWDJgpPP81cXFcfzEEPgt5ujvcMeLFoEWXbc4yiFo9n7xhYDHbEmgZv7ka+9zaNONTP7IsotsZoAaPDCJ+aYo0HN9BVKVE1LDu0foNh4HsusYoYRuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=x4hgy9U0; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="x4hgy9U0"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ff07872097so7004097b3.3
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 17:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741652508; x=1742257308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NlPJOxxU4Y+W3u0tmgeDZw8BlZuKCBgXzhnrKQJC7Go=;
        b=x4hgy9U0CNcP4QBTNt0zM4F6UifeIy1+ctSzGS6jfDMgqwaUO15X53kG8RZAFvsEBp
         eWEOPmLauAbk2Px7w1vCLK6aNF1Bh7gIVNl4W2v8UkIJEOr9Q+ie4fBEfwbkV4IYecI2
         qXFj1Plvvt4abLzJRG+Cg+tDKGH3KJttKbNkS8JjbGZ4MxxhKuShcivr3VbPdOGYarNp
         4xePXjZijsxSDqa9Hf6YVhtMOwJ2gA9kGTFOWDob6+ItuMEyJsnUysVqpwz2bqrLDnbC
         q9PGOMixq5bPb3FcrwxHmw8sdT462hE3ccI1GxNHH4U18KmmE1LJYpQ5N7T83kagwfTX
         LPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741652508; x=1742257308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlPJOxxU4Y+W3u0tmgeDZw8BlZuKCBgXzhnrKQJC7Go=;
        b=Lv8KTBxtJ/JA2GkZnssaN3IJcDyr9BXOEChi1eIbC9rn4snfjdGoQ+sjMD6S0NE2kM
         q12O+wvooUR3FLh4z+Xi6hmm0nNvwtBPbFNffH2sgkZyf/RsR2aq+ZZBO9Dp5Eet5qZQ
         Rc3IufWr+CPnyIN6GfiKWYin3IsbBljBfrQjR/K17oX16M/suMK2lH/h5avUmzWPVggq
         9W/MbWfK8bdQx9CxuN2SHGV4/1hcJQ2VHJ1KxrxF57LP378peUEkIp47OMj61nOzpjrR
         /Zmqq6F/IWJVeegEr0wzTYA3eS+PQrclIrF0OfAMaPQTh9Z0LLTYZz8b7qH1SaF1lWdq
         nbBQ==
X-Gm-Message-State: AOJu0YxLg4c1PHxPZUnkIu8aWVRjEi9fr+aMDc+Pfl0mtLVAza4LO1dy
	b6EQrc4qUrsElnKNmJjcr+iIQJ2r4nzyfnvsrZnz6TVJDszGR7wTp3BEUem2MgWomcwOQzqvtBe
	o20E=
X-Gm-Gg: ASbGncubIB4dqKKbkzmQ22tcuwklvJf7qiw3n8wW+E+nch1WXIT+qGHOLZBKlA9Gz2G
	lbFn3Ce/LtEDg63zacjAg29yEQMZcngvkHQO9xXyCwyBkShOjiPpzLbQ97IrYqFgAaMLTRQ6BIG
	WxImXjCCZ8uv+6mSIA8M+dx60FldcjaUY4PqZqgs/TrOg8LLhClI6SRge4HtnsfoWFKx4l1fY4n
	sf5ZLUcBaYYZmLimNkXamFZpXqzN2kpqQ85kZZwqIVB8uRU5VzdmhfBhNNPqcPhUjcQeVAM1DJQ
	xIb77+MdKkmHCECGdKfqJ1alYPMUa1I/c1fHmE2baARdHf+a6nM1MPhQkxkBiiXBrpGiCbSndbN
	lCdbgDjhVNDttLk8Q
X-Google-Smtp-Source: AGHT+IF4aCRmDtgy3bS2iHTIvHQ0mIT3pUXTM2JjX6Z7F8QSCv6rQpdYqRbT6mSQTOiT+XToGVPYUw==
X-Received: by 2002:a05:690c:6813:b0:6ef:48ac:9d21 with SMTP id 00721157ae682-6febf3c252amr220439427b3.24.1741652508185;
        Mon, 10 Mar 2025 17:21:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2a5beb5sm23948827b3.34.2025.03.10.17.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 17:21:47 -0700 (PDT)
Date: Mon, 10 Mar 2025 20:21:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 4/6] pack-objects: generate cruft packs at most one object
 over threshold
Message-ID: <f2ca92245ada74825806b50f786aab312275fd85.1741648467.git.me@ttaylorr.com>
References: <cover.1740680964.git.me@ttaylorr.com>
 <cover.1741648467.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1741648467.git.me@ttaylorr.com>

When generating multiple cruft packs with 'git repack --max-cruft-size',
we use 'git pack-objects --cruft --max-pack-size' (with many other
elided options), filling in the '--max-pack-size' value with whatever
was provided via the '--max-cruft-size' flag.

This causes us to generate a pack that is smaller than the specified
threshold. This poses a problem since we will never be able to generate
a cruft pack that crosses the threshold. In effect, this means that we
will try and repack its contents over and over again.

Instead, change the meaning of '--max-pack-size' in pack-objects when
combined with '--cruft'. When put together, '--max-pack-size' allows the
pack to grow larger than the specified threshold, but only by one
additional object.

This allows cruft packs to become just a little bit larger than the
threshold, allowing cruft packs to accumulate past the set threshold and
avoid being repacked in the future until a pruning GC takes place.

Noticed-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/pack.adoc      |  4 ++
 Documentation/git-pack-objects.adoc |  4 ++
 builtin/pack-objects.c              | 32 +++++++++++++-
 t/t5329-pack-objects-cruft.sh       | 67 +++++++++++++++++++++++++++++
 4 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/pack.adoc b/Documentation/config/pack.adoc
index da527377fa..0a90931b93 100644
--- a/Documentation/config/pack.adoc
+++ b/Documentation/config/pack.adoc
@@ -119,6 +119,10 @@ sizes (e.g., removable media that cannot store the whole repository),
 you are likely better off creating a single large packfile and splitting
 it using a generic multi-volume archive tool (e.g., Unix `split`).
 +
+When generating cruft packs with `git pack-objects`, this option has a
+slightly different interpretation than above; see the documentation for
+`--max-pack-size` option in linkgit:git-pack-objects[1].
++
 The minimum size allowed is limited to 1 MiB. The default is unlimited.
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 7f69ae4855..aee467c496 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -161,6 +161,10 @@ depth is 4095.
 	`pack.packSizeLimit` is set. Note that this option may result in
 	a larger and slower repository; see the discussion in
 	`pack.packSizeLimit`.
++
+When used with `--cruft`, the output packfile(s) may be as large or
+larger than the configured maximum size. The pack will exceed the
+specified maximum by no more than one object.
 
 --honor-pack-keep::
 	This flag causes an object already in a local pack that
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 58a9b16126..f701b4c9ec 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -692,11 +692,39 @@ static off_t write_object(struct hashfile *f,
 	off_t len;
 	int usable_delta, to_reuse;
 
+	if (cruft && pack_size_limit && pack_size_limit <= write_offset) {
+		/*
+		 * When writing a cruft pack with a limited size,
+		 * perform the --max-pack-size check *before* writing
+		 * the object.
+		 *
+		 * When we have not yet reached the size limit, this
+		 * combined with the fact that we act as if there is no
+		 * limit when writing objects via write_object() allows
+		 * us to grow one object *past* the specified limit.
+		 *
+		 * This is important for generating cruft packs with a
+		 * --max-pack-size so we can generate packs that are
+		 * just over the threshold to avoid repacking them in
+		 * the future.
+		 */
+		return 0;
+	}
+
 	if (!pack_to_stdout)
 		crc32_begin(f);
 
-	/* apply size limit if limited packsize and not first object */
-	if (!pack_size_limit || !nr_written)
+	/*
+	 * Apply size limit when one is provided, with the following
+	 * exceptions:
+	 *
+	 * - We are writing the first object.
+	 *
+	 * - We are writing a cruft pack with a size limit. The check
+	 *   above covers this case while letting the pack grow at most
+	 *   one object beyond the limit.
+	 */
+	if (!pack_size_limit || !nr_written || cruft)
 		limit = 0;
 	else if (pack_size_limit <= write_offset)
 		/*
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 60dac8312d..9cbc21a65d 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -3,6 +3,7 @@
 test_description='cruft pack related pack-objects tests'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-cruft.sh
 
 objdir=.git/objects
 packdir=$objdir/pack
@@ -695,4 +696,70 @@ test_expect_success 'additional cruft blobs via gc.recentObjectsHook' '
 	)
 '
 
+test_expect_success 'cruft pack generation beyond --max-pack-size' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# Disable pack compression to ensure the pack size is
+		# predictable.
+		git config pack.compression 0 &&
+
+		sz=524288 && # 0.5 MiB
+		foo="$(generate_random_blob foo $sz)" &&
+		bar="$(generate_random_blob bar $sz)" &&
+		baz="$(generate_random_blob baz $sz)" &&
+		quux="$(generate_random_blob quux $sz)" &&
+
+		printf "%s\n" "$foo" "$bar" >A.objects &&
+		printf "%s\n" "$baz" "$quux" >B.objects &&
+
+		A="$(git pack-objects $packdir/pack <A.objects)" &&
+		B="$(git pack-objects $packdir/pack <B.objects)" &&
+
+		git prune-packed &&
+
+		sz=1572864 && # 1.5 MiB
+		printf -- "-%s\n" "pack-$A.pack" "pack-$B.pack" >C.in &&
+		git pack-objects --cruft --max-pack-size=$sz $packdir/pack \
+			<C.in >C.out &&
+
+		test_line_count = 2 C.out &&
+		C_large="$(head -n 1 C.out)" &&
+		C_small="$(tail -n 1 C.out)" &&
+
+		# Swap $C_large and $C_small if necessary.
+		if test "$(test_file_size $packdir/pack-$C_large.idx)" -lt \
+			"$(test_file_size $packdir/pack-$C_small.idx)"
+		then
+			tmp="$C_large" &&
+			C_large="$C_small" &&
+			C_small="$tmp"
+		fi &&
+
+		# Ensure the large pack is no smaller than the threshold
+		# such that it does not get repacked in subsequent runs
+		# with the same --max-pack-size setting.
+		test $(test_file_size $packdir/pack-$C_large.pack) -ge $sz &&
+
+		{
+			git show-index <"$packdir/pack-$C_large.idx" &&
+			git show-index <"$packdir/pack-$C_small.idx"
+		} >actual.raw &&
+		printf "%s\n" "$foo" "$bar" "$baz" "$quux" >expect.raw &&
+
+		sort <expect.raw >expect &&
+		cut -d " " -f 2 actual.raw | sort >actual &&
+
+		# Ensure that all of the objects are present in the two
+		# cruft packs we just generated.
+		#
+		# Note that the contents of "actual" are not
+		# de-duplicated. This is intentional to ensure we avoid
+		# packing the same object twice (once in each pack).
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.49.0.rc2.6.g9a1eecd400

