Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5008227BA4
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493420; cv=none; b=dffJbTGk2U9H6ZddfqDOZidah88pTrG4eszGoSih8T1hn3lliDTc1u4U3EuY1OuuGMn4Cb3fvriChQJohyADBPavqmymtZdPYtTkq1Agmb2Q9m+yIu6ToMZw6nMlUZI8Qdj4oO7fCJ+5P6Kh/IZdbaPdYoSXzV98rqGLqeR2F44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493420; c=relaxed/simple;
	bh=YlLB7/xYkhjl7q+m4k6TmRGshg2jAEQ8u6Df3LLcGp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixpjOd35MTnthgxn8YmW7eSP3tJtEgbaMe2m+IKwP+gvVA/6GsgvqRai6rpk3vMutogq9uAPTObgmjdMmrLlZ5aT1KRGRMPi30+yIa4huQMcRu2aRVaH/x/Ru4M6h9+ogaBChcADe65itAxYuK+SPFJvobul2N0gKjmW2zZ+8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mb+DBpM/; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mb+DBpM/"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c546334bdeso86893185a.2
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742493417; x=1743098217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JDQIoLoAUgXTqiT5jBUIoin5F22MGC/vCDB/rmDZyLQ=;
        b=mb+DBpM/zY1av52vkeEMjIKcryCyRD6zKWo2HcLgQln3CwGaIycdxslozq/S5QQ5i5
         VDKEjFxOgGf7OJbrwdN7S/udSRZc4PQfaMZtRdK1Aa9WuhrKc7EditoNHJAv3ZKsfM42
         S6VRc4HrhVYcJpHxQ0JINCVWQUViKsk/mEFUHbju0azFcH0PhAXy684MNHw0NVrQ3gn7
         r3PVk2lojIt3Sh9/vj9A2NudnGfo50LnvMapLOKA5DPBOgjrCDT9mA5BSqAvqKhBlYW5
         Xhg/P2s+pMPc8CR7G+5bDwXO3ifzMlcmxxutf8lQBz4wWXsTh1PhjVdIqZXbtseQBM/i
         y/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493417; x=1743098217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDQIoLoAUgXTqiT5jBUIoin5F22MGC/vCDB/rmDZyLQ=;
        b=gdFGwS2iedpX12C2uyc+SsSSClhO/wGAitadRwUAdVFyfi2ZmtrWmyynU+zDDHoIZP
         OPy7dF7WBAoOMOiyaOGVRPU3x7RJQXXe55s5CMYJZtFOOwLkUkJDPdR8TWzO8gykMkdv
         QzpdRVpCw2ALnvcZUJLUglo2cAljJPedOXJHt1ZuJa3+Zx7plANoYRC62+PeGDMxHH1I
         20ogVVquErLB3bkwCWj/JiyFZbDZWnqzGsQraz/cIEH6qok1xH4/faJs+YzNm1VnaPl9
         AbBw/+vupd5eSPuKWdqM7F85KNiVP71x88/BDZ/U+sGHczz67RQxt98EuYquikgoF1Cs
         fd8g==
X-Gm-Message-State: AOJu0YwNquKPcnPUMX8py2H7ZiY+clmzs5fqPrwn0zSY8I8zdXI9y77Y
	HE7T41y+TuKRxWQwOaWMlJG0cuAB0U5hxENyS7IA8zca8n8ZmstJBTa3BlK8MPfOUo/7FsPDA63
	mkM8=
X-Gm-Gg: ASbGncu/B1AV2SZ4atJW/CRpotjEePRzcLRZ8eJWvND8ZIqcHUS+uKkW8KAWmqs4bhc
	0+51YEMSlWajp30RatfVN6JcyKCPQnrZ+anuTn/mRMyG6Y+rvFWx9tTqQDsfkF2QYAO0526IRgM
	UvDPkxgGW1KLA8UXhbYBsUXqBLIOPkJ+abXKIkhZYPFDc989S9orBEjSKEvuA7an/Kxx4aMH6w4
	IYcqryV6Zvbv22P9S4fjKVHbrWK+agmmQVLfFNjhq5K4/o+q9nI2NDesRuIwti30GlCXrp8I7XY
	tH8IlHdEQ25dO2rX4ImuVo2hCP0pAqPUI52rhA14rDS+7HNQS5n41m+n3n6CqMDD2Hir21xTxzl
	xiGpBrYEEoULflFGx
X-Google-Smtp-Source: AGHT+IFTndx6RUr2DePd1XoRyUNZF8StSHm+Fy/t2fDB0cC8rMcd6fckJx7zHo2YvSJnBMj5j4bimQ==
X-Received: by 2002:a05:620a:8019:b0:7c5:3b8d:9f29 with SMTP id af79cd13be357-7c5ba15ee0amr18715885a.21.1742493417674;
        Thu, 20 Mar 2025 10:56:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c5b92ed0a9sm16158985a.65.2025.03.20.10.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 10:56:57 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:56:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 10/14] pack-bitmap.c: apply pseudo-merge commits with
 incremental MIDXs
Message-ID: <7477a8ac03737afcb42c54739931311539eaaf8e.1742493373.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1742493373.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742493373.git.me@ttaylorr.com>

Prepare for using pseudo-merges with incremental MIDX bitmaps by
attempting to apply pseudo-merges from each layer when encountering a
given commit during a walk.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 4086277de8..1d1e1a65ca 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1082,10 +1082,15 @@ static unsigned apply_pseudo_merges_for_commit_1(struct bitmap_index *bitmap_git
 						 struct commit *commit,
 						 uint32_t commit_pos)
 {
-	int ret;
+	struct bitmap_index *curr = bitmap_git;
+	int ret = 0;
 
-	ret = apply_pseudo_merges_for_commit(&bitmap_git->pseudo_merges,
-					     result, commit, commit_pos);
+	while (curr) {
+		ret += apply_pseudo_merges_for_commit(&curr->pseudo_merges,
+						      result, commit,
+						      commit_pos);
+		curr = curr->base;
+	}
 
 	if (ret)
 		pseudo_merges_satisfied_nr += ret;
-- 
2.49.0.14.g88b49c1b34

