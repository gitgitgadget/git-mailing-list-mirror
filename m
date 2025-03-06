Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E464E17B500
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275295; cv=none; b=M3Fy0M09ELJ3440pe197Slm14H2grbn2G4J9tbQZBUp/Ykw/a1aFY2aWu+0BJ6U1IAdTmanCwzFguywtkNmEi/jGvcxEnIDFgoTeD2hwk8RNE4XzTbueoYj/xzFTVw+X7jJnq+1Bh2Xq0sjK7v0EmyrKrMWM3aTB/j4/+QdwJUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275295; c=relaxed/simple;
	bh=69M7YqKd85HNNsr4sB64sui42VHvHnb25bSJUmLUmTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpxRPffsKKRgfBsotOFsqKEbf3yXGujVitmKPcqgorl1djGXe7TEUSEhzXqKv0lSVyEgvf7e6CmZJTAvKf5SLDGSyxq3ODBok8fU37TN5CFVqX3/MwrqXNfdcps823tpMnJqxoi/1kr0N4O1duzfFjQb8JXJZVavmPW3mDOabuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=UKq1p2tT; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UKq1p2tT"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6fb2a0e4125so5534587b3.1
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 07:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741275291; x=1741880091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yocGfzJ2oHnXPQpknLcpolahOqwghdX0qUvevE5Fd64=;
        b=UKq1p2tTKskklRy5S2HCUncmCninGILwDVYX/hw+Mwr8C4sxI2qk0rzb0YwIDoOL6z
         wwgdZ2qrSGDsJFcDtIbDNkop9E1SxG3gPK320r0dxooArfHz8CP/xjkGvt5+MppR5Qsb
         3wSzupOk0ynlNeelPH9cSJmYQ1Eg1Wi/CyB6B2CXLxRkbN3kKt6aU+RZbALz30gm8Da+
         Kokgr0EelBND9OTyexsapY8GSdtWkgARAUFP/bV+VgFJiV1CwaaMD4GRI7BfxGFzxeIS
         6Kk2fmpUGo3Aa+2LPPYbYKsFJcKA55WBcuKlpczLHH8SovgKnC0Hdt7fcEE5lYkgBmWr
         +c+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741275291; x=1741880091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yocGfzJ2oHnXPQpknLcpolahOqwghdX0qUvevE5Fd64=;
        b=IWYBDHd33pLmlPn76HOI2dro1HOcWQwPL+8t/lTM6+jfM+BlO2ZzkUt7+p94QTqRKl
         1HrJtvAx0Y4DSwP9j7mwX0M5rjEQZRaNDBKPgeLR4cfadSt8Hy3FZdpSmL3TG6Ns17cS
         /ThW/EGqGuhMKSAEZUNGFRqAUMvyzNGlRF+5PG9rcs+GKMryiOITO7c1jHuWdrBTKrHh
         fZc0xIip5zrFIfSNriR9CRY+BZlWhF+KS6puZ8xEDEvx4J5r5PTblOUw3sMjbdG2K4kZ
         EV2qLLELk75K6aPL/jSvnMGFjItV9VHVAwRNnqLxRq5WJoihNoj6C9LJD2hGss9rp0OW
         kcaA==
X-Gm-Message-State: AOJu0YzV/wu1kSNcQicYdRVdW8XaJu9zXBzOhE4UH7a6M4sK1+XvMO5m
	xVv0B3XqNrU/+nV1zjGZpzKmUnRJnFUkpT2D67/bTpO09bg8RnGzfWfEuxBgAT3TMb1UumEUKwq
	/
X-Gm-Gg: ASbGnct/DmvquFBrFLXpXfrxbME11s2Y5f9OmOKso9CiFqEinOJpu9lA3GN1Ln3KdaT
	o4HAmZC9lxF53YCC0CjADkP/a9uWQ8I/f2331cNyOBN47S27eyqh75i5Yk70dhF4IcMAhb/UZDx
	ckU2JynTQ/NudMob72IRwTbgTQ26rJAmNQqcYKjfed98ytGUY0TdMXIz70v6f1WrLCwwHCr39hx
	NNBDf8xx4+DdnU67qkPYb6guVRtyvM/7zBqQ2IoEXcs4QTX9xEnZXuupZYPimJwJw25VdK8Hxzj
	jdrJzsiEGsbjiwCWP0+NTFw9JGYpe+akSOFGie6Tw32p6NFQI3y1zqBYlCZhoyHT6jHLCo4J4Hq
	nDKfV6vL12XSLXLpu
X-Google-Smtp-Source: AGHT+IHs3zgC0O92okDTo0Cuc0cObwuAY/iKktAGiysIdkaIJOQFHJVXEHDNb7vFwiwyicP9mPI3NA==
X-Received: by 2002:a05:690c:4c09:b0:6ef:4ed2:7dec with SMTP id 00721157ae682-6fda30346afmr98425097b3.8.1741275291278;
        Thu, 06 Mar 2025 07:34:51 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2c4676fsm2987197b3.103.2025.03.06.07.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:34:49 -0800 (PST)
Date: Thu, 6 Mar 2025 10:34:48 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	SURA <surak8806@gmail.com>
Subject: [PATCH v2 1/2] refs.c: remove empty '--exclude' patterns
Message-ID: <c3b5ca597330275391704a0653398ee28f911fc1.1741275245.git.me@ttaylorr.com>
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

In 59c35fac54 (refs/packed-backend.c: implement jump lists to avoid
excluded pattern(s), 2023-07-10), the packed-refs backend learned how to
construct "jump lists" to avoid enumerating sections of the packed-refs
file that we know the caller is going to throw out anyway.

This process works by finding the start- and end-points (that is, where
in the packed-refs file corresponds to the range we're going to ignore)
for each exclude pattern, then constructing a jump list based on that.
At enumeration time we'll consult the jump list to skip past everything
in the range(s) found in the previous step, saving time when excluding a
large portion of references.

But when there is a --exclude pattern which is just the empty string,
the behavior is a little funky. When we try and exclude the empty
string, the matched range covers the entire packed-refs file, meaning
that we won't output any packed references. But the empty pattern
doesn't actually match any references to begin with! For example, on my
copy of git.git I can do:

    $ git for-each-ref '' | wc -l
    0

So "git for-each-ref --exclude=''" shouldn't actually remove anything
from the output, and ought to be equivalent to "git for-each-ref". But
it's not, and in fact:

    $ git for-each-ref | wc -l
    2229
    $ git for-each-ref --exclude='' | wc -l
    480

But why does the '--exclude' version output only some of the references
in the repository? Here's a hint:

    $ find .git/refs -type f | wc -l
    480

Indeed, because the files backend doesn't implement[^1] the same jump
list concept as the packed backend we get the correct result for the
loose references, but none of the packed references.

Since the empty string exclude pattern doesn't match anything, we can
discard them before the packed-refs backend has a chance to even see it
(and likewise for reftable, which also implements a similar concept
since 1869525066 (refs/reftable: wire up support for exclude patterns,
2024-09-16)).

This approach (copying only some of the patterns into a strvec at the
refs.c layer) may seem heavy-handed, but it's setting us up to fix
another bug in the following commit where the fix will involve modifying
the incoming patterns.

[^1]: As noted in 59c35fac54. We technically could avoid opening and
  enumerating the contents of, for e.g., "$GIT_DIR/refs/heads/foo/" if
  we knew that we were excluding anything under the 'refs/heads/foo'
  hierarchy. But the --exclude stuff is all best-effort anyway, since
  the caller is expected to cull out any results that they don't want.

Noticed-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 refs.c                  | 16 ++++++++++++++++
 t/t1419-exclude-refs.sh | 10 ++++++++++
 2 files changed, 26 insertions(+)

diff --git a/refs.c b/refs.c
index 91da5325d7..17d3840aff 100644
--- a/refs.c
+++ b/refs.c
@@ -1699,6 +1699,20 @@ struct ref_iterator *refs_ref_iterator_begin(
 		enum do_for_each_ref_flags flags)
 {
 	struct ref_iterator *iter;
+	struct strvec normalized_exclude_patterns = STRVEC_INIT;
+
+	if (exclude_patterns) {
+		for (size_t i = 0; exclude_patterns[i]; i++) {
+			const char *pattern = exclude_patterns[i];
+			size_t len = strlen(pattern);
+			if (!len)
+				continue;
+
+			strvec_push(&normalized_exclude_patterns, pattern);
+		}
+
+		exclude_patterns = normalized_exclude_patterns.v;
+	}
 
 	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
 		static int ref_paranoia = -1;
@@ -1719,6 +1733,8 @@ struct ref_iterator *refs_ref_iterator_begin(
 	if (trim)
 		iter = prefix_ref_iterator_begin(iter, "", trim);
 
+	strvec_clear(&normalized_exclude_patterns);
+
 	return iter;
 }
 
diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
index c04eeb7211..fd58260a24 100755
--- a/t/t1419-exclude-refs.sh
+++ b/t/t1419-exclude-refs.sh
@@ -155,4 +155,14 @@ test_expect_success 'meta-characters are discarded' '
 	assert_no_jumps perf
 '
 
+test_expect_success 'empty string exclude pattern is ignored' '
+	git update-ref refs/heads/loose $(git rev-parse refs/heads/foo/1) &&
+
+	for_each_ref__exclude refs/heads "" >actual 2>perf &&
+	for_each_ref >expect &&
+
+	test_cmp expect actual &&
+	assert_no_jumps perf
+'
+
 test_done
-- 
2.49.0.rc1.2.g67c8c5f7978

