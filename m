Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C60720F071
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275299; cv=none; b=c/tmquAayW2QTw8bkGxNw3OnNtU+iszKvk4lm5I361CTPzKG0EqmSyUgObuJ+28TlS0nIAID9vkbSzOJ54YHStqUEcIievjbRyC4KnU8kXs03QzjyEkwLh6OfpRkfht16no98MKOL50M4OaL2FpieFcWD1g6OhnOyGSZvlQ2FNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275299; c=relaxed/simple;
	bh=Bt768Z6Xli0s+jmh5b12qEb3kmkh0pu4FdDz0Y4EhUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkm39858UN8XGok3nECh9+BGJZrd7fKdnsVptWxFgkNZyQmixkZYKzZbYcm1PJNU8Sl2P4bRzVLJe777if4TIgXo8DP2xhEUfcQGE0UqLiRJwfcMFI/bLkAr7oV7x/3TtNaSgiAugtRE8gD1FRmW4xOX+S7/VLXdt9J8Lf+IbBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=CMikSIH8; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="CMikSIH8"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e60b75f8723so560187276.0
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 07:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741275295; x=1741880095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2gmj7umx8YEC2iDBDgR3dP5G/jqE0yB0Le6C+vecL4=;
        b=CMikSIH8gAfgbuz7w1/PuFYBBHt0+PekipMEOUBxI9jFOF3Io6azX4VL9wprAQy9MW
         IXdJBnoZzUOuV9oVY5sCRZUl7Cxv8ED7EHqVyhJNPakyj2v4QsUgbsa2lV0dWcJfus+0
         09/VVvyuC3vKjk+dppkBotKZPCzJdoEnHTqByx0WrmOBQi/2wg0ie5mS/+r+ByTu15qa
         IcMWVngykicXSYBiYsgir3FYhoj9XNUd9Gb4YjWIbSXLneSUJ7CUhs8+g49KgQWQqQDC
         h4Vrw0lqkMcvCRKWKi+72zYSpbDauJHR4hKtpdd5GzQpV9LvhqQQvjJ4mq3/p/QwM0tC
         OQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741275295; x=1741880095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2gmj7umx8YEC2iDBDgR3dP5G/jqE0yB0Le6C+vecL4=;
        b=Hi+catyjG9MpoHPoVXZRrNFzga3tnhFosF+9VtSwxnBmAESvDo7iqtWQHBeek/bSZp
         i4gz97BBTtEqj+ergKpTJ7NiuGWEWvVS3nl4/08FXyFTJVnYgdzXUXhaCWatYFTH/LAv
         8mEWIbW39EmfFd3/3PGIjDjxTPZf8BliFbZdeDXBE8TxSM2AqAPcn88tsrP/aJk0diNV
         YdSgutePOTP+2nnbBztL3Ccc7c0c/ioCDksXLT5CRcVEA7KxqB3/Ij9uj7FrOF2Qn2fn
         3jr6vKG0IM3XBCkR982DuTvGM8/uJTKcZkCtkNuX/zs9CVvvSaFhWVwEMXxd312fH/5Q
         8+Rg==
X-Gm-Message-State: AOJu0YxOUlzK7FjDVVcBj/Hn4ntfrM96EbE5JVxhqObxPhjewcZiKFb4
	WHPOjpzRAIAPJ0wNwNpYXsYCbWr9LB8uQDUlYI+iY7u/hIaX2BNREeXWOrAAPBqzfxpaSoXBfDy
	j
X-Gm-Gg: ASbGncud007sTiYEeNXHnJe9NNhNqcTKAeU5AmVn1J8ZqlCISKDxguCtVy2OnEYzEWJ
	SFm4LHKfuNf8yJSkRRdDqOZzOa1zdzpj725OvCxjuRezK8B81Lvx7EsynTsTC3sLMJx61MvEfga
	QybHESjLwZH9ztcTp8XgOD/obTVRJ5ZtmzyU2FWsXiwpomxWeW3NEIsIHLDGWAwAT26N41bQn2N
	99pHHO+pYJaaMoCTw1KsVkDny8REd7eetmcEnTFpCUgv7YemE4OM4GPl7thA3sMdkAQn73H1bMa
	T0RLgz0ZfLFNdJXUt9KPqvv3Lwcw4iCVAOuxLJxwM3fO1vdF1OQHoiSogW9EYSmfZTE8VLb1VcV
	odivFNOi7QZqScsCP
X-Google-Smtp-Source: AGHT+IH7S/fa788jYavvk1pinUjhZxgLzG1yTOhCzW5mmPSX0OIiezyYRfG49ELQfzA8U7RlVIdPYQ==
X-Received: by 2002:a05:6902:1b8e:b0:e60:a93f:2a86 with SMTP id 3f1490d57ef6-e611e329e49mr9611803276.42.1741275295545;
        Thu, 06 Mar 2025 07:34:55 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e634b8e8fa5sm361809276.44.2025.03.06.07.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:34:54 -0800 (PST)
Date: Thu, 6 Mar 2025 10:34:53 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	SURA <surak8806@gmail.com>
Subject: [PATCH v2 2/2] refs.c: stop matching non-directory prefixes in
 exclude patterns
Message-ID: <67c8c5f797833a9a35f4805059d7e759020f54bd.1741275245.git.me@ttaylorr.com>
References: <cover.1741223981.git.me@ttaylorr.com>
 <cover.1741275245.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1741275245.git.me@ttaylorr.com>

In the packed-refs backend, our implementation of '--exclude' (dating
back to 59c35fac54 (refs/packed-backend.c: implement jump lists to avoid
excluded pattern(s), 2023-07-10)) considers, for example:

    $ git for-each-ref --exclude=refs/heads/ba

to exclude "refs/heads/bar", "refs/heads/baz", and so on.

The files backend, which does not implement '--exclude' (and relies on
the caller to cull out results that don't match) naturally will
enumerate "refs/heads/bar" and so on.

So in the above example, 'for-each-ref' will try and see if
"refs/heads/ba" matches "refs/heads/bar" (since the files backend simply
enumerated every loose reference), and, realizing that it does not
match, output the reference as expected. (A caller that did want to
exclude "refs/heads/bar" and "refs/heads/baz" might instead run "git
for-each-ref --exclude='refs/heads/ba*'").

This can lead to strange behavior, like seeing a different set of
references advertised via 'upload-pack' depending on what set of
references were loose versus packed.

So there is a subtle bug with '--exclude' which is that in the
packed-refs backend we will consider "refs/heads/bar" to be a pattern
match against "refs/heads/ba" when we shouldn't. Likewise, the reftable
backend (which in this case is bug-compatible with the packed backend)
exhibits the same broken behavior.

There are a few ways to fix this. One is to tighten the rules in
cmp_record_to_refname(), which is used to determine the start/end-points
of the jump list used by the packed backend. In this new "strict" mode,
the comparison function would handle the case where we've reached the
end of the pattern by introducing a new check like so:

    while (1) {
        if (*r1 == '\n')
            return *r2 ? -1 : 0;
        if (!*r2)
            if (strict && *r1 != '/')        /* <- here */
                return 1;
            return start ? 1 : -1;
        if (*r1 != *r2)
            return (unsigned char)*r1 < (unsigned char)*r2 ? -1 : +1;
        r1++;
        r2++;
    }

(eliding out the rest of cmp_record_to_refname()). Equivalently, we
could teach refs/packed-backend::populate_excluded_jump_list() to append
a trailing '/' if one does not already exist, forcing an exclude pattern
like "refs/heads/ba" to only match "refs/heads/ba/abc" and so forth.

But since the same problem exists in reftable, we can fix both at once
by performing this pre-processing step one layer up in refs.c at the
common entrypoint for the two, which is 'refs_ref_iterator_begin()'.

Since that solution is both the simplest and only requires modification
in one spot, let's normalize exclude patterns so that they end with a
trailing slash. This causes us to unify the behavior between all three
backends.

There is some minor test fallout in the "overlapping excluded regions"
test, which happens to use 'refs/ba' as an exclude pattern, and expects
references under the "refs/heads/bar/*" and "refs/heads/baz/*"
hierarchies to be excluded from the results.

But that test fallout is expected, because the test was codifying the
buggy behavior to begin with, and should have never been written that
way. Split that into its own test (since the range is no longer
overlapping under the stricter interpretation of --exclude patterns
presented here). Create a new test which does have overlapping
regions by using a refs/heads/bar/4/... hierarchy and excluding both
"refs/heads/bar" and "refs/heads/bar/4".

Reported-by: SURA <surak8806@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 refs.c                  |  6 +++++-
 t/t1419-exclude-refs.sh | 16 ++++++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 17d3840aff..2d9a1b51f4 100644
--- a/refs.c
+++ b/refs.c
@@ -1708,7 +1708,11 @@ struct ref_iterator *refs_ref_iterator_begin(
 			if (!len)
 				continue;
 
-			strvec_push(&normalized_exclude_patterns, pattern);
+			if (pattern[len - 1] == '/')
+				strvec_push(&normalized_exclude_patterns, pattern);
+			else
+				strvec_pushf(&normalized_exclude_patterns, "%s/",
+					     pattern);
 		}
 
 		exclude_patterns = normalized_exclude_patterns.v;
diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
index fd58260a24..04797aee59 100755
--- a/t/t1419-exclude-refs.sh
+++ b/t/t1419-exclude-refs.sh
@@ -46,6 +46,10 @@ test_expect_success 'setup' '
 			echo "create refs/heads/$name/$i $base" || return 1
 		done || return 1
 	done >in &&
+	for i in 5 6 7
+	do
+		echo "create refs/heads/bar/4/$i $base" || return 1
+	done >>in &&
 	echo "delete refs/heads/main" >>in &&
 
 	git update-ref --stdin <in &&
@@ -99,9 +103,17 @@ test_expect_success 'adjacent, non-overlapping excluded regions' '
 	esac
 '
 
-test_expect_success 'overlapping excluded regions' '
+test_expect_success 'non-directory excluded regions' '
 	for_each_ref__exclude refs/heads refs/heads/ba refs/heads/baz >actual 2>perf &&
-	for_each_ref refs/heads/foo refs/heads/quux >expect &&
+	for_each_ref refs/heads/bar refs/heads/foo refs/heads/quux >expect &&
+
+	test_cmp expect actual &&
+	assert_jumps 1 perf
+'
+
+test_expect_success 'overlapping excluded regions' '
+	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/bar/4 >actual 2>perf &&
+	for_each_ref refs/heads/baz refs/heads/foo refs/heads/quux >expect &&
 
 	test_cmp expect actual &&
 	assert_jumps 1 perf
-- 
2.49.0.rc1.2.g67c8c5f7978
