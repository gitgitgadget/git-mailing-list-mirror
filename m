Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB691D364C
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054068; cv=none; b=bn1w2qBmR1DWQdJsFUI/n4SSEC92ZQz9pDpTXhNIhepz87t8JG54SnM9EraSRjH0dBPXjS3njWmVl96q8ENIO3IeAxjRLcfykwxxI+y9t4wMBEg/bd62CS4b+wzGAhcLSwfZFQmiCWnidUl8m70g2Tn4UHoqsnd7HjPvoMCQdRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054068; c=relaxed/simple;
	bh=X9P8XxaaenCg1LL8ZQEqCn69baQaOCMwAYsBx2uW9n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCGHptRsPAWG+ryM3zKS5Zuf3uUQFXZOKP3My2YwG2m1qVquQrf0RySF2d7CREERnOfiepQelpcY1uG9T29ky1tPI8Sv3EH0B2xvvlHPYj50NKIlPuuruKFwdQQsxESXLnt9rUSC9rpIP3DLoQfwgM2C5sU35pMNsOa/jco6ORw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=I9dRViZD; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="I9dRViZD"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6eeb3741880so11213407b3.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 14:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732054066; x=1732658866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YWL+XrEmUVHpg0K9uA7HH32ZlL8NHHXUKTQ4UcHypJc=;
        b=I9dRViZDYM8uV7ikMqpIdz97wxn3gk3pA4i7N/OnxTnYo1JF5Zfzca/L20cmeS6mO/
         fIM1hXbVhlkOsFcmVUYDfen1EjN0siE6FeqJPNdGbQaFexRhMjmC7urGMxKgXCag7GsP
         v0GD9hvFc33895TwLZKNdmoKf3+ayCbPnZLwcaC+3eRym1bJa8qHMocGXTt5vX6VVdmS
         9TNREcg5Wt8G6u/JEufh3kstNHwcDb5JKA/Sq8Ie+G1CPEaTTIIEnxYTQOjICqnpxyn3
         FzJeOXz4dyxQHRBeW4Mf5iN1qQx14Gec3cIUCrmNkL5vv6UxbUkX/oZWx1spxB8ky473
         lp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732054066; x=1732658866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWL+XrEmUVHpg0K9uA7HH32ZlL8NHHXUKTQ4UcHypJc=;
        b=nADz7KwoCQjJJ75vWArIR00X1fRnBPrXV0M6p+bFf3eIXS0MAgGsEPi32u+o8SAzyI
         9KqucAA43MakU2wNab/jmp796b7LDm9P0PrGFh14s7zTwSgcZcQ7m+gTfqkFCCJi0jaw
         T/5i36pHlsZTXx36P5YExK40ZN2jpZdtqMzN11Z08h1+2yy/Wy2BzM9IDiGC2v8xQK+i
         oBx3VwbUFhxKI3jdDUIoi6BRfz8Sj3z4aQD1wT2X0NnsxR66+/KFEZIoDbGA/W6jTYDO
         Y0dWxIBzrCYS/QvZr64gdurgnfE9enyBoTMK2euWX+WAoHzIQE6YBuol9K1CJV/dMz+U
         Xv1w==
X-Gm-Message-State: AOJu0Yze6YwtCn/igZoivYm50VMrz8dZiD+z9lYhvSF7YBjXlF0ELKhZ
	aZE+zyfSb4ERILQBpZom+qZQVwCHRThh8rd7aOo2ytUhTbARtmarKds7yB4XKFDSx+s6xbeyKKU
	NYos=
X-Google-Smtp-Source: AGHT+IEGZInJ0z0nvjxyruh70K1GSC0T8rV7FsyTiJBV8FZNtzBXgr7rL/5QriyGiYh+dJ3K1XK/tQ==
X-Received: by 2002:a05:690c:3342:b0:6ee:b38c:b6e1 with SMTP id 00721157ae682-6eebd167c8fmr4845127b3.14.1732054065949;
        Tue, 19 Nov 2024 14:07:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee713425e5sm19345677b3.96.2024.11.19.14.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:07:45 -0800 (PST)
Date: Tue, 19 Nov 2024 17:07:44 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/13] pack-bitmap.c: apply pseudo-merge commits with
 incremental MIDXs
Message-ID: <0b4fcfcecb6043534424c3c7ffc80a63dfe63f3c.1732054032.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1732054032.git.me@ttaylorr.com>

Prepare for using pseudo-merges with incremental MIDX bitmaps by
attempting to apply pseudo-merges from each layer when encountering a
given commit during a walk.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index b48d6b144d8..570f6dbdad6 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1087,10 +1087,15 @@ static unsigned apply_pseudo_merges_for_commit_1(struct bitmap_index *bitmap_git
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
2.47.0.301.g77ddd1170f9

