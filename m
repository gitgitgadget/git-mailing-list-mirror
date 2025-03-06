Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D1D1591E3
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741223997; cv=none; b=gsHRb9xptXTIUG7eak+VkInBxkVQnzVc0WKkL/hIhjHbxoA01kJPdhWuOyB+00OgktNlIR3+lgAFpoiJOMOMtj19+EjHwaboEUm/5L0wCHc0pgndV9yvtSWOwh2HJROz/9RR/8Ut2H0zyV0aYyrkoL9UlS94Rc0MV1eCWJqFn3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741223997; c=relaxed/simple;
	bh=ZpYp3bVFF8e8NUhXg2zaJNu8Ew+74i4rY8q1i2U7zMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyJYdheTm41e+ECT31WyqzehjScw+reGysXgG7WKGANS2W1xoePm4omPNSbkXL7oDFso16PBFRJqkRfu868YqQp3aznh7Nonubo2TEUGRfrYapafjTIOWX5mxa3OtI4K8cU23q2HGFoB6/GidLMiMeDxXAHOXWoy2o2x5d5cBTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=hjGX0y2Y; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="hjGX0y2Y"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ef60e500d7so1368507b3.0
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 17:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741223995; x=1741828795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cbbQVtOm11QHP6Z52nec9fMJz6DcThYfWFWvq2KcSfw=;
        b=hjGX0y2Yctg38TtCwGnBHQ/11PjSKRoNZSpANv+wAbTkZd28O5B8EOdF3Gy7HV0rG4
         S5XBnPpjAVAESGm760jr9v2lmeq8iEovveBw2kD7xQo9+ySRGxAN0sD3BbJb0krNkKCT
         +6pyB1nwSyfQRxsvdGTj16dpdyEgsk8Lz9ydkpPeWuUqWygbWTmFicdB8fUpG+6PvUfK
         FeIyMa1CN+zyRGdr9toi9/PFFawj3DXEaalMFa7S0QdV6bmjOP8TnK56EDN/8ox3Uo55
         Fnnqx2RGIMqzQVNVsA6pXMOG0ok6o0c+mYSvfNK0Tq41DcgMcG+4e0DWxG0U28wV/cy/
         z0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741223995; x=1741828795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbbQVtOm11QHP6Z52nec9fMJz6DcThYfWFWvq2KcSfw=;
        b=PkAJgg9dGniWR1fkb3fhkYQWKeh5Mb6lW6Xj2NNItEB6BjV0eAhRt5bsVmp7BQXUE6
         8ItfX5NEyUD+/oBbXARRAX42JmNE1OH5H5XCHgKurz/cXroRzOn+m3BGOQi1ad6L3hH0
         n7FwvhH7lfmPTpH2UYFHO5b/2rITdZ1gh/5XKMfhGJq/p1DFAI++p8+hFLnqzcIRQMBn
         jjftsQpfaPZNwiQp1oDc1szLQ6ChALrcOq9OGPnHHNfa3l1w8ROQE2naV7VS6cgs4z9D
         4Cxtix67+jh1v47T6660yPH8zIKKfVO3yFdyWFqMz1D+7y3ERCc+wNnMUojU/BhRRUtT
         osZA==
X-Gm-Message-State: AOJu0YwAGbxd46EzFtFWInXHPgxtnsYF5kTW9/aOhr+Tb1Z94IFVCt1f
	2xD2Wtt7WI7Ml9CuD72CNuf/CiHW+UvAhbNCCSaNLxPgST2iPAO9jQv8X7H2NZ2FlApi925iaZ/
	A
X-Gm-Gg: ASbGncsikKRpezp6vOClftlPin6agwHNPOY+vFn3ZrOULVa2eM1J4CPfu4oiMUjd/Xf
	vd49xXmeaUR4ox9S17H6XBPZsigVq3gW1PUJEA360THpYYvlo9IzRhlNT6A93uM5QXAZ0lIBgDZ
	xV6J8iFbm645hCGjwKNO5hXUlrNm7o/BjnD8J8lNZ+nIwAPQH2J1J4KyE0EypSuPxV+MPbp7qrV
	fH6zYi7tlvIaro74ZD4HIMNuG4NXtgG0DY7HEP695+u+l9NM/Ssg2a/PbA2IiXGK3pMm7DjWbXj
	SQzS/Rmno71qSIg4X9CCq46cxYZ5I3aHHUIuC5dcH14rszqQUCdHREXhYcev1l87ip3MEYfpMyB
	dlhYpXAunX8aQpLuE
X-Google-Smtp-Source: AGHT+IFp2kYSWNUUeG5r99Hlix2YePDMvOifhRaCK6AX2gZ0W0sOOzKRtVjAzL91r2n8vOI2nfhTIw==
X-Received: by 2002:a05:690c:4984:b0:6fb:9822:bbd7 with SMTP id 00721157ae682-6fda2f5432cmr78700027b3.15.1741223994660;
        Wed, 05 Mar 2025 17:19:54 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2c66819sm245307b3.124.2025.03.05.17.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 17:19:54 -0800 (PST)
Date: Wed, 5 Mar 2025 20:19:53 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	SURA <surak8806@gmail.com>
Subject: [PATCH 2/2] refs.c: unify '--exclude' behavior between files and
 packed backends
Message-ID: <7e6a5e020bad14b782a8c85518289220579fae64.1741223981.git.me@ttaylorr.com>
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
way.

Reported-by: SURA <surak8806@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 refs.c                  | 6 +++++-
 t/t1419-exclude-refs.sh | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

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
index fd58260a24..d955cf9541 100755
--- a/t/t1419-exclude-refs.sh
+++ b/t/t1419-exclude-refs.sh
@@ -101,7 +101,7 @@ test_expect_success 'adjacent, non-overlapping excluded regions' '
 
 test_expect_success 'overlapping excluded regions' '
 	for_each_ref__exclude refs/heads refs/heads/ba refs/heads/baz >actual 2>perf &&
-	for_each_ref refs/heads/foo refs/heads/quux >expect &&
+	for_each_ref refs/heads/bar refs/heads/foo refs/heads/quux >expect &&
 
 	test_cmp expect actual &&
 	assert_jumps 1 perf
-- 
2.49.0.rc1.2.g7e6a5e020ba
