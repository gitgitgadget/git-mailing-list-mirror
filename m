Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200D917B500
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275291; cv=none; b=NR9yNHWeG0fH415Bn97BgrQz5Er8UshlGeV3fzrSaU4FQ+10LFQ9Xp7W2+B4+jFHiRsBROBaaL4A6rnV4Y9xXsqCPZ0WkST30DI0AIgi9BT7O00nI+Y3TOzwNCA5kTgo8PNr6ThDDuz9lH4L6wdwX6vyEfpGq04Rm8oKNLjyZc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275291; c=relaxed/simple;
	bh=A9UAfD20j/2XTJHfVd+E8WxMkALknrk9PKOGSBtlVKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXy5cBnkzK98Iwfb5ksOKGlpjtIlduApV9zEKUlFj1LsoYQ2RedX5PHdwiwkPp9mX7nJIkJyYaUs8mV4nAgzvqOR4hlUO4tbxZ2DCxb0LoLwqSRZKcs77BMdVOu9bWgr1YXUDHJpYM0ue/vvyb0V3lr0wfmg8u4i6WZ83P9gQkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jjLZwP6I; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jjLZwP6I"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ef7c9e9592so7486117b3.1
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 07:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741275288; x=1741880088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8tm4mx7/to/8iG22ZoULEZ+dOsGO1FI+1JF58WrRPLo=;
        b=jjLZwP6I71jTgIkfVNI41gGh1IgFl3U08an5nHeH6m0upREKmjouswqbD0F3kjrzd7
         2OmbybRh56dOA/6MxLbvlIrZ+EoVOB5EwQGH9dNNahQqeECcMGQgBvJ40CXwM7rUK6YZ
         rNG3jFh85Q1EkRta8g6BAKXGdzUsMtdmF3Am5pqLWtJ37E3bJgrvTLbrrhO/g3pjBaSv
         NpBdHBKGVIQFtgwZuf+UmNyTep/N3QQhqCVvf/UTSaRVRKhNYlnAQXFaRyydfslapNRz
         Msl803GpIgRIwtC6wldtVfXQdgzZB6yko4DV5Ue2NzJnYid0PCfp45HhorseWYJOS5FT
         kxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741275288; x=1741880088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tm4mx7/to/8iG22ZoULEZ+dOsGO1FI+1JF58WrRPLo=;
        b=bbNF/pobEX4d+Ocq0iJjQWYw79HmvXMkxLAP1dT48T0c0WXOMO9LsVUnvGpH0T/GCp
         nkVn/X1TkCQhCca5VKhyhyhE8eK4qWFB+PesXjPFbB28UARAXSxXNHffMtvjAkAQWt2G
         muoTC24VYpeE8o5hJETZCSPyxEJWDHRHNOBfx+m/9VRy4KSCW0uwff+bkA7gQH7GcxsZ
         xVJ9aTsxQUmFheLtXbZS+4NP31nXjG+HSKwf4HYh3pWVwr0CwoX3H93OS5J7i4n60wXl
         Jh7Tdr7ygRXbyJqLRjdXHN5SDi6FxD17Vi5F6yIU9y+Ou9B8b5l+nuR6MCPiM5Ir+/gg
         qVuQ==
X-Gm-Message-State: AOJu0YxyeJlmc0vAR8NmpdtCkszmgxFSNZ6TFCd3neFndCfIf1cDUigE
	8YPqxf0xM8R0TApuLpBVPN/VzNCGrPDCMQ9vdQznVYuPjOVvgck3mB7K0ET9I1TIvADYsuQFlU1
	h
X-Gm-Gg: ASbGncvKx80JNh4Ko0FInKx8vdgCBjDU1rovheM2rVgnEvXMd6wEiwv8i+XlYwVjHEo
	p0qrlRgl/WBeA26FOrAm9hoXKsFqubYfA+yn2r5blx6yN/F9HZho9irQzm+Lnnpd/Jk9hLwUAM7
	JKDKhNJNyKLL9jocEZ4O6672r5yoyjdrI8GZzwZl88R3PVD3cdrE04DrQTBeSerU8FZTZHzPsrf
	Hz76ifYhhuiJwSmqMYlzGN/b2eW4yteSzPbQo3NIiuX5bsJujEB3Vh68XsarGuP+A+EZI1JcBQm
	lcafrsg1DQdmYiwPdEmCPUP7L1Ih4d+pj+785OXvBwkjc4vepO91j9zXPQhAZjIuTR8blDTaN78
	93ijre+ip1ur/L3yZ
X-Google-Smtp-Source: AGHT+IH3QW1Dwi2oRFydK1MwYzV1/aV6NmJfwW6W5bgMgZQD85mOQOYQAbwhIkOfLj2Z/KdZNRCXdw==
X-Received: by 2002:a05:690c:3607:b0:6f7:55a2:4cd8 with SMTP id 00721157ae682-6fda2fe1661mr107711167b3.5.1741275286879;
        Thu, 06 Mar 2025 07:34:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2a51821sm2990077b3.39.2025.03.06.07.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:34:45 -0800 (PST)
Date: Thu, 6 Mar 2025 10:34:44 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	SURA <surak8806@gmail.com>
Subject: [PATCH v2 0/2] refs: a couple of --exclude fixes
Message-ID: <cover.1741275245.git.me@ttaylorr.com>
References: <cover.1741223981.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1741223981.git.me@ttaylorr.com>

Here is a small reroll of my series to fix a couple of quirks with the
--exclude pattern matching.

The changes since last time are fairly minor: the second patch's subject
line was reworded (thanks to a suggestion by Patrick). Likewise, its
test script changed slightly to reflect that "refs/heads/ba" and
"refs/heads/bar" are no longer considered overlapping regions.

For convenience, a range-diff is below. Thanks again for your review
:-).

Taylor Blau (2):
  refs.c: remove empty '--exclude' patterns
  refs.c: stop matching non-directory prefixes in exclude patterns

 refs.c                  | 20 ++++++++++++++++++++
 t/t1419-exclude-refs.sh | 26 ++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

Range-diff against v1:
1:  c3b5ca5973 = 1:  c3b5ca5973 refs.c: remove empty '--exclude' patterns
2:  7e6a5e020b ! 2:  67c8c5f797 refs.c: unify '--exclude' behavior between files and packed backends
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>

      ## Commit message ##
    -    refs.c: unify '--exclude' behavior between files and packed backends
    +    refs.c: stop matching non-directory prefixes in exclude patterns

         In the packed-refs backend, our implementation of '--exclude' (dating
         back to 59c35fac54 (refs/packed-backend.c: implement jump lists to avoid
    @@ Commit message

         But that test fallout is expected, because the test was codifying the
         buggy behavior to begin with, and should have never been written that
    -    way.
    +    way. Split that into its own test (since the range is no longer
    +    overlapping under the stricter interpretation of --exclude patterns
    +    presented here). Create a new test which does have overlapping
    +    regions by using a refs/heads/bar/4/... hierarchy and excluding both
    +    "refs/heads/bar" and "refs/heads/bar/4".

         Reported-by: SURA <surak8806@gmail.com>
         Helped-by: Jeff King <peff@peff.net>
    @@ refs.c: struct ref_iterator *refs_ref_iterator_begin(
      		exclude_patterns = normalized_exclude_patterns.v;

      ## t/t1419-exclude-refs.sh ##
    +@@ t/t1419-exclude-refs.sh: test_expect_success 'setup' '
    + 			echo "create refs/heads/$name/$i $base" || return 1
    + 		done || return 1
    + 	done >in &&
    ++	for i in 5 6 7
    ++	do
    ++		echo "create refs/heads/bar/4/$i $base" || return 1
    ++	done >>in &&
    + 	echo "delete refs/heads/main" >>in &&
    +
    + 	git update-ref --stdin <in &&
     @@ t/t1419-exclude-refs.sh: test_expect_success 'adjacent, non-overlapping excluded regions' '
    + 	esac
    + '

    - test_expect_success 'overlapping excluded regions' '
    +-test_expect_success 'overlapping excluded regions' '
    ++test_expect_success 'non-directory excluded regions' '
      	for_each_ref__exclude refs/heads refs/heads/ba refs/heads/baz >actual 2>perf &&
     -	for_each_ref refs/heads/foo refs/heads/quux >expect &&
     +	for_each_ref refs/heads/bar refs/heads/foo refs/heads/quux >expect &&
    ++
    ++	test_cmp expect actual &&
    ++	assert_jumps 1 perf
    ++'
    ++
    ++test_expect_success 'overlapping excluded regions' '
    ++	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/bar/4 >actual 2>perf &&
    ++	for_each_ref refs/heads/baz refs/heads/foo refs/heads/quux >expect &&

      	test_cmp expect actual &&
      	assert_jumps 1 perf

base-commit: 6a64ac7b014fa2cfa7a69af3c253bcd53a94b428
--
2.49.0.rc1.2.g67c8c5f7978
