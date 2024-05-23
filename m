Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82CB128361
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499578; cv=none; b=IXQUcdeucaOBv4nkn3Q+MU9Sa9mJ+yHl4EOsp5z0AYlH1Yh8AbiGzgkC5ttaHFiAUhWHEktn70xGu7TAteYNlAQfKC6OP4FRtsVcZdRcX/NHawlg4e0LNQn2kEb8dJBaiqNQY4q6AwjoXQ0w3S+SZwiwETo5KVQv+BPiAMT+bTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499578; c=relaxed/simple;
	bh=j5CFMMfwPchfRmJqAzHYwsSLaCwYG+H9x1ZiPDAFiDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcgLaJL6twKD3vVniU/6AGuXaEP9SpCagnqgZ4I4uaaPAVTbMT43pu0boTGzxKD+kyE71VSh+G8OXSzRFKUxr/4FYobBKDleTNN/9rWDz9p+KdTyvn5lZesBPsYtG9TgTiiCkBpNCwI1/vWsAUBK/0XHij/JUerVn3qOXi2ws2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=wcbJ5yaB; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wcbJ5yaB"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7948b7e4e5dso321028785a.1
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499575; x=1717104375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7rI4QUSPIQ2Hdy7WIB777QCejc22IuI5udZAXpV0vog=;
        b=wcbJ5yaB/gea9lUwdzCE0EEqH+0iAnRiUgtMccX1lVlWTqj3/jFbaeVkkGlIfVMymf
         bkiilZZudyHzqqHJkhXvYJPkZumvZ5fLJ6fC6AucbjfRjyVBqv2qa/dv8nzGWKttc+R5
         bA/EX/pOTvjqky1XwuJeMWwFMGdetU02q8mMDEGwceHIBws7As/dnVakZ3bXCDoVPIlz
         6VnqUFaNR8iwRL1TTZEkkIWn+Z8ZlQbzplBD58+GVDywlQbkmRCyaJasyncUj9h2ik4m
         BS8jWCLExDhEyvQ4NVMl7x78cqp6A7wnyxXHBzhb99+lJPeysS63ocgvhW6ZhH6S6DNT
         qUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499575; x=1717104375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rI4QUSPIQ2Hdy7WIB777QCejc22IuI5udZAXpV0vog=;
        b=AGyiLnUY3WA1T5RgJNyWD9zbNBUre8mtylEKEyBfhyykACAcFpyq9UIJAoRnKZgrbk
         UU4MAWCU/ly9CngAlJ8EyHO7+QRqXizToTpGCdhsdJ6jFnbmAzXsMZ+qGgNMC5R38RiR
         SpT1FWW8gTYEpQEqDavZOzadN83UMPgmtVRq1aSTKlLMFJA+k8CZ9R1hjWYXSHCNqi3f
         NqpdiUSWYk9z/ZwhqJuS5IjzgzfeNX9JXHVpGqOYfztveP6mSQKjsPI/SMnyQ/4jIy9H
         YQd9eCem6Tf9WQ9h3aAjf4hFQyFLr87dKBX500Fr3ZBpKjPfn1QnGE6bTdZF+dmqPz3L
         xMgw==
X-Gm-Message-State: AOJu0YzFMhKfjzH0hZwM0NhZ3gyhQfdwUdGLjTQeP4ZCgjgGraxS2n+z
	ZFNy5eAxFGXOXdysXvP6H/wG+zGXm3PLnp7LHBhXvKRGRCkDvjZK0ComwMkK1rzpwxYgmM6S+Ws
	M
X-Google-Smtp-Source: AGHT+IGFNx92phmsp4f1Smnt/q72Dj68F66XiPMvAi3pX2BrktnEIp7arQfN2FVLI/05oFM73BwYzw==
X-Received: by 2002:a05:620a:2fb:b0:792:beda:304a with SMTP id af79cd13be357-794aafa6764mr52112885a.0.1716499575163;
        Thu, 23 May 2024 14:26:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abcc5844sm2776485a.53.2024.05.23.14.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:26:14 -0700 (PDT)
Date: Thu, 23 May 2024 17:26:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 02/24] Documentation/gitpacking.txt: describe pseudo-merge
 bitmaps
Message-ID: <48afaa7492815350ae17405da1a8d09eb8e97c15.1716499565.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716499565.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716499565.git.me@ttaylorr.com>

Add some details to the gitpacking(7) manual page which motivate and
describe pseudo-merge bitmaps.

The exact on-disk format and many of the configuration knobs will be
described in subsequent commits.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/gitpacking.txt | 72 ++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/Documentation/gitpacking.txt b/Documentation/gitpacking.txt
index 50e9900d845..f24396f0173 100644
--- a/Documentation/gitpacking.txt
+++ b/Documentation/gitpacking.txt
@@ -24,6 +24,78 @@ There are many aspects of packing in Git that are not covered in this
 document that instead live in the aforementioned areas. Over time, those
 scattered bits may coalesce into this document.
 
+== Pseudo-merge bitmaps
+
+NOTE: Pseudo-merge bitmaps are considered an experimental feature, so
+the configuration and many of the ideas are subject to change.
+
+=== Background
+
+Reachability bitmaps are most efficient when we have on-disk stored
+bitmaps for one or more of the starting points of a traversal. For this
+reason, Git prefers storing bitmaps for commits at the tips of refs,
+because traversals tend to start with those points.
+
+But if you have a large number of refs, it's not feasible to store a
+bitmap for _every_ ref tip. It takes up space, and just OR-ing all of
+those bitmaps together is expensive.
+
+One way we can deal with that is to create bitmaps that represent
+_groups_ of refs. When a traversal asks about the entire group, then we
+can use this single bitmap instead of considering each ref individually.
+Because these bitmaps represent the set of objects which would be
+reachable in a hypothetical merge of all of the commits, we call them
+pseudo-merge bitmaps.
+
+=== Overview
+
+A "pseudo-merge bitmap" is used to refer to a pair of bitmaps, as
+follows:
+
+Commit bitmap::
+
+  A bitmap whose set bits describe the set of commits included in the
+  pseudo-merge's "merge" bitmap (as below).
+
+Merge bitmap::
+
+  A bitmap whose set bits describe the reachability closure over the set
+  of commits in the pseudo-merge's "commits" bitmap (as above). An
+  identical bitmap would be generated for an octopus merge with the same
+  set of parents as described in the commits bitmap.
+
+Pseudo-merge bitmaps can accelerate bitmap traversals when all commits
+for a given pseudo-merge are listed on either side of the traversal,
+either directly (by explicitly asking for them as part of the `HAVES`
+or `WANTS`) or indirectly (by encountering them during a fill-in
+traversal).
+
+=== Use-cases
+
+For example, suppose there exists a pseudo-merge bitmap with a large
+number of commits, all of which are listed in the `WANTS` section of
+some bitmap traversal query. When pseudo-merge bitmaps are enabled, the
+bitmap machinery can quickly determine there is a pseudo-merge which
+satisfies some subset of the wanted objects on either side of the query.
+Then, we can inflate the EWAH-compressed bitmap, and `OR` it in to the
+resulting bitmap. By contrast, without pseudo-merge bitmaps, we would
+have to repeat the decompression and `OR`-ing step over a potentially
+large number of individual bitmaps, which can take proportionally more
+time.
+
+Another benefit of pseudo-merges arises when there is some combination
+of (a) a large number of references, with (b) poor bitmap coverage, and
+(c) deep, nested trees, making fill-in traversal relatively expensive.
+For example, suppose that there are a large enough number of tags where
+bitmapping each of the tags individually is infeasible. Without
+pseudo-merge bitmaps, computing the result of, say, `git rev-list
+--use-bitmap-index --count --objects --tags` would likely require a
+large amount of fill-in traversal. But when a large quantity of those
+tags are stored together in a pseudo-merge bitmap, the bitmap machinery
+can take advantage of the fact that we only care about the union of
+objects reachable from all of those tags, and answer the query much
+faster.
+
 SEE ALSO
 --------
 linkgit:git-pack-objects[1]
-- 
2.45.1.175.gcf0316ad0e9

