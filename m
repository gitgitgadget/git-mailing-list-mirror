Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8783E3DCDA4
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801744; cv=none; b=VNV1E/Hcp0LMC4XBXmc7XK5hetLC3TkpEhG7pApehyJ1Udlp8sZYSLxV7TTFLf0Ps9rDgpC6x/MPpzzlI73ncn+NKAeWWbzpqaO+xjGh7oKxEffq2ETfgsRjkQLUDECawuKIFmlVenFC4ocgQby9EEihuKOgXlhhJBvhf9e2kjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801744; c=relaxed/simple;
	bh=rzSb9qc8H1RnNoafnHhua7xNwhaeOfSMm4lgBSfZloc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQfVG5q08CXLeR7ejBD6/5cC96e3Na66WEXyHiCKXWuHAm/DO0Wf4bx404OMZFrY4IPDxSJL1MglSfScGpjw/G5RrJQbPIr+KWOScMoJ28J8nKt01PqMkz264GJo8wEF2lVUhQBgFoxIjmbZZlfp9x5YQAMj7E+qehRbZ57ODaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=UjBaTG3g; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="UjBaTG3g"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-694891f8f62so1246746eaf.2
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776801742; x=1777406542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CaCuDKVMzZzY6XW1bd4bWwa3G9c3mERXs5bJZ23iWTs=;
        b=UjBaTG3ggvW0Knr+fNXmo41jpDoAovviFbn944skEOgz4/U/y0Fsvjh1ZkqRfKi3dn
         4g4DRK9PtgvspsckngN2ucsdUlOcYCd5uSEbN2Ktwga1WmH2zfMPb/1zGnI/4kXPIa1s
         rtL7+/4eKhxgGov3g2pDkCx56ycd1twS17lN7/5gxTlUt8aDWkTccUVdWGcEv8gCqgKd
         NKXX4Ew64l3z6cwQpLZN2XBsCLV+/874/A2awqJ7QS7LpKw2EEuzmzyYh1pCwal/FOms
         0sDWa14LBilqt+t75k8ys2K3A91tLfQTW9p5nknra6sUAtGsIvBlvrYhcKvN3iWl+JSP
         SugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776801742; x=1777406542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaCuDKVMzZzY6XW1bd4bWwa3G9c3mERXs5bJZ23iWTs=;
        b=AsdrE8fVq37vM8NE5mS6FJuJhn+zcr3VNTghlSHlHgF60Iirvp1mdMrJ+TzBwqkXeb
         Lg1L7w2Q4lnwVkzf8z9BaXb7hhcM7nVUOopmT9VwEi67QrglZ2YNT9T2I3GJbJ0/P4FB
         dGnewjCMqQvMIk2mDiLTz2g02L+GZUDUzqJwNcQjkBF9WJRhPmJmWuYjzaBt9y0MHBbS
         EoqNBWAv6P1ZUnjIrvoT3jrgWFkKGKDuDAqpF2outoJlhEaWvAlKCmg64GRdwGmRR/oa
         1N7Cjdw0OHJ0AOjVOyYFM94ovXXvt2Etxb6ev0vQ89DTGnXvGQlhawDkJpz1axIq8Hh5
         r76g==
X-Gm-Message-State: AOJu0YyqNG8Uz9e2hszFWmYL3cGUnNmbPo+RoPtFgV+lXAOrGnXwL5b7
	jxrf4U+Rvxe6FcLk6QrgoeW9n6DAJ2sex1wZ1ii9TqXv+s8K6nK1zXXoBH3WSwC6nX8Mcdh3+Qk
	cqnRF/kg=
X-Gm-Gg: AeBDieus5umM8LRimECPEVyuITokWZXKSXqwLynZ0VplC4G+/aSvBNxhtYQQi9ven1o
	i5YIr+aYvj4wj9XXPNa1RUspptN9trZu9zOCBUwYFXBzwcHMdGDyN6a5uTYXKPUpuau1+5HXpda
	xmQ/6uZUv9eIbOAuOxz3c0n/430utp9fEXfk2pfOHSAIE3BvugjIVqdOoCaUaAUVmw44C25Q+cy
	JsPw5ZgXlU03CNpE91W/XZpsqJf8sM0WGeJwsg9PZkUQDkK+UX2Qki0I5L1icqb1HW1KXu1Zmxs
	PbY74i6Ps2tCIHAEv0DDd+AGAu77kBT/YtMQoR+eC8qjaRE74zKomPI2w055sSrDNJLcNCCqd1j
	yiSo6sQWRbW8st6vn2qIJFE9Xsk5aOU1ZznGOi86je/KJE9uGaaFiPC00mnxP80+O3PwqeXff/f
	pFgH8EzHLFBfJW7ozBsYWkBZb+mwiDcccyIIUGBxgFm95CkeCmC6l68fln894OgDW094NFZsfJm
	kPfXDbHcyCmdzQXb4BqNKd+snvJIANJkfLKA1H3ADcOklZ+hZEqDozULnkfuLVn6mbXJOBMTxtA
	79jSi9V2SRHLGqovdUQmvJrET2U=
X-Received: by 2002:a05:6808:4449:b0:479:d605:64ab with SMTP id 5614622812f47-479d60570d7mr5106836b6e.0.1776801741918;
        Tue, 21 Apr 2026 13:02:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479a02097b6sm9647781b6e.14.2026.04.21.13.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:02:21 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:02:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 9/9] pack-bitmap: prevent pattern leak on pseudo-merge
 re-assignment
Message-ID: <b905fd5d0ae206128aeb3ab2f4c3aaca6c8fe8d7.1776801694.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
 <cover.1776801694.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776801694.git.me@ttaylorr.com>

When "bitmapPseudoMerge.*.pattern" appears more than once for the same
group, `pseudo_merge_config()` frees the old `regex_t *` pointer
but does not call `regfree()` on it first. This leaks whatever internal
state `regcomp()` allocated.

The final cleanup path in `pseudo_merge_group_release()` does call
`regfree()` before `free()`, so only the intermediate replacement is
affected.

Fix this by guarding the replacement with a NULL check and calling
`regfree()` before `free()` when the pointer is non-NULL.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pseudo-merge.c                  |  5 ++++-
 t/t5333-pseudo-merge-bitmaps.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/pseudo-merge.c b/pseudo-merge.c
index 75bed043602..22b8600d689 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -150,7 +150,10 @@ static int pseudo_merge_config(const char *var, const char *value,
 	if (!strcmp(key, "pattern")) {
 		struct strbuf re = STRBUF_INIT;
 
-		free(group->pattern);
+		if (group->pattern) {
+			regfree(group->pattern);
+			free(group->pattern);
+		}
 		if (*value != '^')
 			strbuf_addch(&re, '^');
 		strbuf_addstr(&re, value);
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 3d0617a2e17..382513ca5cc 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -663,4 +663,34 @@ test_expect_success 'sampleRate=0 does not cause division by zero' '
 	)
 '
 
+test_expect_success 'duplicate pseudo-merge pattern does not leak' '
+	git init pseudo-merge-dup-pattern &&
+	test_when_finished "rm -fr pseudo-merge-dup-pattern" &&
+
+	(
+		cd pseudo-merge-dup-pattern &&
+
+		test_commit_bulk 64 &&
+		tag_everything &&
+		git repack -ad &&
+
+		pack=$(ls .git/objects/pack/pack-*.pack) &&
+
+		# Set the same group'\''s pattern twice. The second
+		# assignment should cleanly release the compiled regex
+		# from the first without leaking.
+		git config bitmapPseudoMerge.test.pattern "refs/tags/" &&
+		git config --add bitmapPseudoMerge.test.pattern "refs/tags/" &&
+		git config bitmapPseudoMerge.test.maxMerges 1 &&
+		git config bitmapPseudoMerge.test.threshold now &&
+		git config bitmapPseudoMerge.test.stableThreshold never &&
+
+		git rev-parse HEAD~63 |
+		test-tool bitmap write "$(basename $pack)" &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 1 merges
+	)
+'
+
 test_done
-- 
2.54.0.9.gb905fd5d0ae
