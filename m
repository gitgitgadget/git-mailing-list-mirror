Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616621;
	b=GaiFA9EJ8WSH1couZGjSbtBnbRD/N9lHhOZN4VpelzvChwpV0IMSHRjUSX+iRhjMlTWg
	 NeSlRUj6M0u85EnJw1U/CdYvNGbR24FrUqHZC3OnnAV+jqnH9+UMHPC5K3tq1IHDR8/or
	 qiSpl+skaTYMzDagGjdRE383bYaYN2BSA0f5Z29ROlWfMe0pT1dnneHEF/kIP0+BmwmCJ
	 7yjvTiviU+uqdwNS8+lhr/y+NBxpwPJrK7clm/CETgcVNfSoE/Up2moPMXrVgQjD59s8H
	 Zy7jnX8syTyS6mGfeX8e44LxcrP0l/rv+L2WfUmPLvAoMbBtU9wQi4X7jgfErOIcsBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=zb+y71uHur2+DLnZB6ERRNmMGGHpcFwfcAkbMgvnt/8=;
	b=X37ATEGSDRkGxw0Vc2j9M505JRGJ4Oe7FBdyFAbLw6UwrTCPCxajwrg4dQKBh3ntx60a
	 APLxXqjudKFQ9n4eFDhiATeykGAbI+pO0B+e+H3CmtHrFBafBE5H5QzRr4JAEIQApK5w0
	 hr1jYij59z2cnpotzoaTNTMmebUH0VCw5I4uhMH/6YMe7sE+GkdF5EBGtvYDtDwg0bmBP
	 Ej5okgxV7athjwrs3ftf2kyn50WKZMweReK7A4C7QzNtYteRnABPwJpe9px1FqrBatUkp
	 IQDEoVJ8W9epHtyR+bD1y4yr+UIzaKHCQO3eExFd+TNQWuMI3TcUkMdmGc5CmUs/kMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NrGlhWtt;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA3B606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 21:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DA3B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NrGlhWtt
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4b28d9537bcso185483b6e.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792616620; x=1793221420; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zb+y71uHur2+DLnZB6ERRNmMGGHpcFwfcAkbMgvnt/8=;
        b=NrGlhWttyTLOTfPOY1zirQoE1Jbr0S0lOdxXNb1HCcM/uapr1NUmHmqyXV7pcouVKB
         wZu44y+A/LfDY9tl+1+TNhvj6jNiTxSRKtpK2oc60HD5nZYwDaGKxUI73LcQvOcXn7wr
         eEJk+/tCbCi2BW0JT50fubS7Z224Wotex53A/AiyNFSLv0JBg60/lhoG+9DDr6NIHAgB
         hn7864Awbb61UwNUvtmwTevsMZgEUyyywjjhZp+9bnX/OZ5o3O8BLm4GmGSQq4Ysstr6
         ZUvLqVemhZ2fe91nxheOAgcE9BF5RfPJh0zylsSi0eZTdDYpreJGOcAvRnw5ZM1AOI6y
         068A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792616620; x=1793221420;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zb+y71uHur2+DLnZB6ERRNmMGGHpcFwfcAkbMgvnt/8=;
        b=QpB/jtav6lCtr/iSdVjVkoJqIVezm3T3X+NJvtoePtLBq32TJy5gh0QVHdJwVwgXNO
         UDGJRWdcuc4uANiOnwv5sVhb7w8i4KE93Vyfyh7PGeSVDpqrd7MOozEM3wzcDSZfxdyW
         gMYrsjzNJqbS/4TtiRgJcm+8kZFgosLnd+mhgMJ2AR/wPxjHbQqdFog3If3sOGfvd3oB
         xCVstNwPeR8QTFf68RR4dxdADcwsg77OPX13CicBXsJYejYotItEn28zIsKaqSIsbY1I
         BvFlLl3pV5Uu4wR8eYjsBlw83Uh0PewAewh9Odncx9ZUFn3Yhxfhnx0h8io6T5HW+o4v
         FZ9w==
X-Gm-Message-State: AFq9FYIADS/YyNVD4Ayr3hwqIHAH/vlDtq1xDdULiNIKWtPwEN4rGRNu
	EEckHrCVptRmZEDcmx41yY7Tb3LbL12Jvh0pESWeEFWTatA8n8suJlM/wbHEb7Q2
X-Gm-Gg: AYBFou36Lo90ZsIwr/aixPPesuj7kY2Caa1blzhYQN0FocsJmqy+07R7IOsS6k8kewv
	Vde0N7hahtNp22C8rLXPJ7hOjZoom/jtGCy8izDigybNMbfZHyUSw3jFEYu1iYHSwKwxhT2dYpg
	iJN6pBiu9hIRomUejBAq2H6b6qKvA6LhjztzK+IHwvjZGTmRjdKxegYJfl3ye0uTk0IBjYsV81/
	QghAl+chesRO+zMdK3WR0sIkxEoltzqguF9YEBasMZtGXcKIld0g/VIk2Y2HO153EMOuEB1fK60
	MbJKf3ghKdB/m3osZRmAhTwH2NT6jZR23fn5vYxRZaszw7T52u5km6DoxM0B1DPn7CyVKYMQf4k
	dsx2YnUjxRuH8DkyvSR0qsSPgcOaAj5qOQDB4Qg10Y2HBDBuuDk/TMhD7b83vfHAHG/aqyOHEMo
	xHFF/2vaBxvHXQJtChbmZPjgCUHsVtzf6CwcSK/O0+8611GfzHfRjpcJ6jPWqIAViCdvSkHhsnv
	FyggjxBxNc659dNwfos2MUHR1IzR+g/HiG5/0FfUbHYxRHFfZZNfD4mEAWOSRYLxyODZBUYpAW5
	RA4cZA==
X-Received: by 2002:a05:6808:320d:b0:546:306d:45eb with SMTP id 5614622812f47-557edb091fbmr314159b6e.35.1792616619786;
        Wed, 21 Oct 2026 14:03:39 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.19.225])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-552b8ba5107sm2918332b6e.17.2026.10.21.14.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 14:03:38 -0700 (PDT)
Message-Id: <pull.2255.v2.git.1792616615.gitgitgadget@gmail.com>
In-Reply-To: <pull.2255.git.1791989883899.gitgitgadget@gmail.com>
References: <pull.2255.git.1791989883899.gitgitgadget@gmail.com>
From: "Matthew Suozzo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 21:03:33 +0000
Subject: [PATCH v2 0/2] reftable: widen allocation size arguments to uintmax_t
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Aniket Gupta <aniketgupta3001@gmail.com>,
    Matthew Suozzo <m@suozzo.co>

Changes since v1:

 * Fix the truncation in reftable_alloc_size() and reftable_calloc() instead
   of checking the count in reftable_obj_record_decode() (Patrick, Aniket).
 * Test reftable_alloc_size() directly instead of the decoder (Aniket).
 * Move the Makefile change into its own patch (Patrick).
 * Rewrite the commit messages (Patrick).

Matthew Suozzo (2):
  Makefile: build the reftable record unit tests
  reftable/basics: widen allocation size arguments to uintmax_t

 Makefile                         |  1 +
 reftable/basics.c                |  9 +++++----
 reftable/basics.h                |  5 +++--
 t/unit-tests/u-reftable-basics.c | 18 ++++++++++++++++++
 4 files changed, 27 insertions(+), 6 deletions(-)


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2255%2Fmsuozzo%2Freftable-obj-record-count-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2255/msuozzo/reftable-obj-record-count-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2255

Range-diff vs v1:

 1:  5fb73ec0a8 ! 1:  0d083bc81f reftable/record: bound an object record's offset count by its length
     @@ Metadata
      Author: Matthew Suozzo <m@suozzo.co>
      
       ## Commit message ##
     -    reftable/record: bound an object record's offset count by its length
     +    Makefile: build the reftable record unit tests
      
     -    An object record's count of offsets is a 64-bit varint from the table,
     -    and reftable_obj_record_decode() allocates the offsets array from it
     -    through REFTABLE_ALLOC_ARRAY(), which takes a size_t. Where size_t is
     -    32 bits, a count of 2^32 + 1 allocates room for one offset, and the
     -    loop, which runs to the full count, writes an offset from the table
     -    for each varint left in the block past the end of the array. Where
     -    size_t is 64 bits, a large count only makes a large allocation that
     -    the decode then fails to fill.
     +    The Meson build includes the reftable record unit tests, but the
     +    Makefile does not. The suite was dropped from the Makefile when the
     +    test was converted to the clar framework in 2596bef5841f (2025-07-24).
      
     -    Nothing in Git reaches this decoder from a repository: a block of a
     -    type other than the one wanted is refused before its records are
     -    decoded, and the object index, the only reader of object blocks, is
     -    used only by the unit tests. The decoder is still wrong.
     +    Include the reftable record unit test suite in the Makefile test
     +    target.
      
     -    Each offset takes at least a byte, so refuse a count larger than what
     -    is left of the record.
     -
     -    The Makefile did not build the reftable record unit tests (the Meson
     -    build does). Add the suite there so that the new test runs in both.
     -
     -    Assisted-by: Claude Opus 5.5, Claude Fable 5.1
     +    Assisted-by: Claude Fable 5.1
          Signed-off-by: Matthew Suozzo <m@suozzo.co>
      
       ## Makefile ##
     @@ Makefile: CLAR_TEST_SUITES += u-reftable-block
       CLAR_TEST_SUITES += u-reftable-stack
       CLAR_TEST_SUITES += u-reftable-table
       CLAR_TEST_SUITES += u-reftable-tree
     -
     - ## reftable/record.c ##
     -@@ reftable/record.c: static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
     - 	if (count == 0)
     - 		return start.len - in.len;
     - 
     -+	/* each offset takes at least a byte */
     -+	if (count > in.len)
     -+		return REFTABLE_FORMAT_ERROR;
     -+
     - 	REFTABLE_ALLOC_ARRAY(r->offsets, count);
     - 	if (!r->offsets)
     - 		return REFTABLE_OUT_OF_MEMORY_ERROR;
     -
     - ## t/unit-tests/u-reftable-record.c ##
     -@@ t/unit-tests/u-reftable-record.c: void test_reftable_record__obj_record_roundtrip(void)
     - 	reftable_buf_release(&scratch);
     - }
     - 
     -+void test_reftable_record__obj_record_decode_count_larger_than_record(void)
     -+{
     -+	struct reftable_buf key = REFTABLE_BUF_INIT, scratch = REFTABLE_BUF_INIT;
     -+	struct reftable_record rec = { .type = REFTABLE_BLOCK_TYPE_OBJ };
     -+	uint8_t buffer[32];
     -+	struct string_view dest = { .buf = buffer, .len = sizeof(buffer) }, in;
     -+	int n;
     -+
     -+	/*
     -+	 * A count of offsets that a 32-bit size_t truncates to one,
     -+	 * followed by two offsets.
     -+	 */
     -+	n = put_var_int(&dest, ((uint64_t)1 << 32) + 1);
     -+	cl_assert_gt_i(n, 0);
     -+	string_view_consume(&dest, n);
     -+	n = put_var_int(&dest, 1);
     -+	cl_assert_gt_i(n, 0);
     -+	string_view_consume(&dest, n);
     -+	n = put_var_int(&dest, 1);
     -+	cl_assert_gt_i(n, 0);
     -+	string_view_consume(&dest, n);
     -+
     -+	in.buf = buffer;
     -+	in.len = sizeof(buffer) - dest.len;
     -+
     -+	cl_assert_equal_i(reftable_buf_addstr(&key, "\x01\x02"), 0);
     -+	cl_assert_equal_i(reftable_record_decode(&rec, key, 0, in,
     -+						 REFTABLE_HASH_SIZE_SHA1, &scratch),
     -+			  REFTABLE_FORMAT_ERROR);
     -+
     -+	reftable_record_release(&rec);
     -+	reftable_buf_release(&key);
     -+	reftable_buf_release(&scratch);
     -+}
     -+
     - void test_reftable_record__index_record_comparison(void)
     - {
     - 	struct reftable_record in[3] = {
 -:  ---------- > 2:  8f4a8389d0 reftable/basics: widen allocation size arguments to uintmax_t

-- 
gitgitgadget
