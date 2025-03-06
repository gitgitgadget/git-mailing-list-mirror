Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAAF158DD9
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 01:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741223995; cv=none; b=DxGmGhlltQmUisMfupHiMiCmj4ozSAQEmjoKCpDHhpDFnWBI8DJCSQ8tmOUivHVJR5Wb4LNlmVMRwHPss4w+5Kl10gNldkZU1+JWVp9Oe+HQ9zAR368YrU16YO+GNgN5J/0i7WfObqxe/4XmazKNjRFXKnXgT2tppk9uKvLvKyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741223995; c=relaxed/simple;
	bh=hDE9gZmKVqjsDe4pM/NkBJ1oLcpRJO6rKKOk3EEDGIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=et8nh67z/6zlz0IG4rwyu6sh5rB07nKukf/eI/FWW9TWX+AX1UAsOvklv4cj/uuRyL5boTP043PkelXmKtsafffIhIxiW6qJWmuHaKxaURDHnkOmOMckdi2P9rVpFMvextYOUPhkZsFAbiLAeI6AakU2+GO+mb4T0cCuTiPzm6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=i8Lm4U/b; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="i8Lm4U/b"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f4434b5305so1262957b3.3
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 17:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741223992; x=1741828792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hKqoAGdoM0pPtO2+UbpI0k3bnC7N6rL2nNIDtxp0kL4=;
        b=i8Lm4U/bmVKXoAUgy6XnXoANH+rQ00u/vzu5LYDUCsq/u1MJdyAbKkDPOzIfXcQz1e
         +znzdThP4j1y18EnVa00wAn/rIsingL+Oy5jUyIj6e6EkaWYjOxUTWiugqRFXzMf2/fG
         KCiTt5KGyFdVloBda9XBaPKOtpj1RSKnHfk81B5yF8g05K6TLWr4r5HDnhRZnYeX/X9x
         ouxp+yx4w5f/CvauPobOGJRYpVePMm8g4jTMIw2NamY2VeckckCIioSXMjjJyw71dCdj
         clbm6qMjS2lKw+SOSK/qpUhLtUeZ03fxdozQi0toxoGCBHTr71DW/wWud6KQDAaDPYut
         7lbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741223992; x=1741828792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKqoAGdoM0pPtO2+UbpI0k3bnC7N6rL2nNIDtxp0kL4=;
        b=rhRGnLqtIRXeFGja+jXHsItwkr7o14uwgg6YCrKa5KKZWSHaa3PryGerjq0F5b1a2j
         Pj2nDTdrv5aXV/RnDW+Aw/9bZfgBOyel0c9u8KJQFyXotBX0AButEGOf3HNhKpsp+r2c
         ROE7D3aL7n6y1O16CDJauuZMwGmzgk2Q2k49aaBByHG9Z1KKU6R+BnWek2LGRRuMEbcr
         e9BZxcKCd9I2/hysNNNz71ZlqEnDGqDLHNAoN/ntVUuhtaA0UJXZciiWtGtghTTGIq2q
         imD/sQA6gAMzy93okhg0dJ9jzqkVlDET+oc/N4mt3W0eM+wmRdYaDdJhJguBjrvk5mWJ
         F9mQ==
X-Gm-Message-State: AOJu0Yw1Fji2J1Lc8hLb3LGZkZMv3OBSk9dvzmC8Urvj5IoqNOMreWwp
	e45dKziFoFr9OPzsxR0BOgdY0eIKLuu+C9D2fDbaHkFIQdimP89T5jlUTahs0i0pnFQUUSs87W7
	R
X-Gm-Gg: ASbGnctK8SwutuECcHw+zXQTE98u3BfbVb0KQ6wZpbRaZ3Z/rACeaRApoqR39ySYBNO
	88WU8lsYiCzvoQGdsVpwOejeDiW8gQebFDTD1LYVTTYWCrhmBK1MiAou3vQ7dBWvCvtko0hQSVL
	ADO2b4imRo5cIEjz3wUtXze1bHvXvOosSivibHur1NCiFwOFCyXi6GR0hfaU11IQaXlOGtMp4lJ
	4qJeMx7pIbF74i0KhXWNpmR/QYsxYs4DTCt7QzmI6KEYQRKDrcC2M6mHrjjo3HJ6b9a+IcW93Nm
	02uxAXspHz4ailC3gWjhcoL/MyEQEKJ0TbCLXjGduSAkAUJ29tBJBjtQZx1TDrxopqpqaz/N0G7
	yMGVOPLmft3hRASb7
X-Google-Smtp-Source: AGHT+IHhB92DyYBEvh9/K2uUuCQRJkYYXpKG+vS0cWEbKvLvPpeTHUyPlYEpoYwgqYDwuJthbqi+zA==
X-Received: by 2002:a05:690c:6513:b0:6f9:871e:6903 with SMTP id 00721157ae682-6fda3181209mr91690757b3.37.1741223991680;
        Wed, 05 Mar 2025 17:19:51 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2a6acd7sm288587b3.42.2025.03.05.17.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 17:19:51 -0800 (PST)
Date: Wed, 5 Mar 2025 20:19:50 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	SURA <surak8806@gmail.com>
Subject: [PATCH 1/2] refs.c: remove empty '--exclude' patterns
Message-ID: <c3b5ca597330275391704a0653398ee28f911fc1.1741223981.git.me@ttaylorr.com>
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
2.49.0.rc1.2.g7e6a5e020ba

