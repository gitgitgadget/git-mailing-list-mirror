Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1D35AADD
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756240828; cv=none; b=twVN2YHsSY2wFyjWp7uXeITrCfrEQAby6iod0hotLZhPDeE78baLFlFjAGzIabseh+YIBlkwrmXFCnUhO6iu7gx/gx1F4OD/hi5uAcX54N8cz1ktee2q/oiFsDAmokBwHJpV/bx8cqzOolTOeRlrux22hnINZTFI5a4bm/ofBpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756240828; c=relaxed/simple;
	bh=5NKdRg3M22KOg2ONq6pM5InjkQIU5F8qE3l7B04IAd8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=CFPfT9sNI9XWHefqCUGLvlJ2nJLU51L6effkjT4IImr+waIN0UGp5SLd1R0BcpczNOrWfkSkjhenJu3yIMObKFQ1E46sBfJWMjK0oLOz3j6b4OSZxtfUr9tpMyNq3b2BPdvBzYml5T9U3kVGMzcVtZhTI8l9DGGslNgSnoViWxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZJmUP1h; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZJmUP1h"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3c7aa4ce823so2185014f8f.0
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 13:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756240824; x=1756845624; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JB/7Z/qW6aDenOx7N5O+f/v91MUjMPQel0JnzM9NZk0=;
        b=OZJmUP1heKADkpoGLKsjv+UTGChW6dCi322y5ytw2gHiiyVEeOVwONDLmn9JftJItW
         a96e5l2tbRUMRdz9rEPZkPZ5INz4d5JaMOBL5ye8wvraUF957YNU2sYOnWmCo5B0DtYN
         lTE26HRv+8r4EcfK+Pl46rgKuuG4KKrI2aYlxQjdOfnqLjpFz/2pBOIG9ItP+G1S+1id
         /qd4IobQXsDsjsgVs8aPT0p4zoTPaF9vq37tmh35gEsK6YKZmAHCYOPI5VnbM4jofUq1
         9PiJscDALAZbRMPuiH4Nf16EgaQN4RGA1/B2Bvbmx0DSpobIaat2RlnABIp17TwOQFwS
         Pdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756240824; x=1756845624;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JB/7Z/qW6aDenOx7N5O+f/v91MUjMPQel0JnzM9NZk0=;
        b=wuwvDvKNhSTyfU4XUe7MAIvYbs3kNEPjx7ARy267RWOTspE2gGXXHe8iarGUVCjzlB
         esytjkH6oeziHQcyEHR94VfbGlrOZS4rZYHoJ4IUDk5eYd0MmBi5xRm6oZYQTq3GLMMG
         7vB+eRttFZAhB78HHJNxi70sZcujDZeaabQDsPwGkCJfdCJcKNyK4BSstFVNMrAHCFdx
         3lRuWhtAe+Osrprfr/pGsNSStGjj3G9tY+iuKiZWJIApP0yuiICqu4tUt5trFJtAQbhr
         SNaGwvw0c7Y3828RusfcN9TtY1AtHxkIMiq5gBHspMjiinoX6CJVE4k1HjsEISDkeiv7
         GatQ==
X-Gm-Message-State: AOJu0Ywt3B15n1CSchobPniYulWSD79QBlSPJJ8QLCA6DF8mUOYmMn9s
	V9I6Ge/hhhCfBolVqBX6vz/tO/G4ErcGS6p0eseaIukAwivBqrwnD72eDo7lzQ==
X-Gm-Gg: ASbGncuaYrcWrBiMqZJTV+2KrTIeFbMP0Xou1LwoNBPiO0Ov2UdEJxryHaJtxOEFm2m
	jOEvarTI/F12miWwJX6ABIi22neaVwmUcC2SNw2EKFI4HlosVUnwabjNQpuUMqqHEyoBUnpHVna
	KpGGE4qg6Vc6o32AFUYqUUDMlQjsjn+3MwUssDknFqSMj8tR3LorVa8owGFLyZnutryPjzYCUlu
	LbHafU4oAm9p9/rHLpsAWs/GLWWY00ctm9K5ubXmXixcjI7IflmSgkK5O5+bBJogcFnm0VZhJJP
	kr2b0rUUPtKTgRj24Z7x9ElrM1HdZ8DYS7q8zfdWf18y4x+b24YUkBv9DwaPTKAqVvsQ3ghebfx
	2zLhjbCpvDNA5BEshxJCmwZi9mQcchlwUoxMhnA==
X-Google-Smtp-Source: AGHT+IGFgYJ0ufOGMhIJxwsJRuvNkVEQku5lXmm3vLrBBDzEqMwHXjCCqYRpKQffMB4lJOeiOfoqPg==
X-Received: by 2002:a05:6000:178d:b0:3b7:820b:a830 with SMTP id ffacd0b85a97d-3c5daeff689mr14085999f8f.25.1756240824141;
        Tue, 26 Aug 2025 13:40:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e1fsm19246240f8f.14.2025.08.26.13.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 13:40:23 -0700 (PDT)
Message-Id: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 Aug 2025 20:40:18 +0000
Subject: [PATCH 0/4] doc: git-push: clarify DESCRIPTION section & refspec definition
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>

I surveyed 16 Git users about the git push man page. Here's a rewrite of the
DESCRIPTION section and the definition of <refspec> based on the feedback.
The goal is to clarify it while communicating the same information. The most
common piece of feedback was that folks didn't understand what the term
"ref" means. Most of the users who said they did not understand the term
"ref" have been using Git for 10+ years.

The rewrite of the <refspec> section is more invasive than I usually prefer:
I've tried to keep as much of the original text as possible, but if there
are too many issues with it then I'll drop that patch from this series.

Julia Evans (4):
  doc: git-push: update intro
  doc: git-push: clarify "where to push"
  doc: git-push: clarify "what to push"
  doc: git-push: rewrite refspec specification

 Documentation/git-push.adoc | 204 ++++++++++++++++++------------------
 1 file changed, 103 insertions(+), 101 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1964%2Fjvns%2Fclarify-push-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1964/jvns/clarify-push-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1964
-- 
gitgitgadget
