Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A8632B125
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784978354; cv=none; b=DGYCofLvRQP0X2Boa9CCrggCBxzN4lF8uF86ZOyicTGYxTtmEIKKxCd3l4T/ArV1O1GXA1ErNGkoNbomFPETfHCKN25Ii01ek5tgMEuSN0RGybuDGM+S+olTwEbXjJ9Adx9oljbLDxZ/ihODFKjtNKX3YBx9pvh4FAJM/mmyHIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784978354; c=relaxed/simple;
	bh=1pz+tSMhC7ooFgT2dsJa0k8JOo0o1Rx/nOoD05P3JjU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=bjUmyvAwIu239kfs4ByRZv711txVbtjFHfar+UPjmH3r31PSC6DVRJIjSJ3/+ClMNrH0dE3yFV4636ac5e1ffAO54FEeV29lL8q019Ey8aHHdcUqmzEzbme2Rxgz98Y7jIalDiK5INZMV2aJXrfSlYiMUiR1C3wkd2YWQ1+Wp+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljBlLaQ9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljBlLaQ9"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso1025471a91.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 04:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784978353; x=1785583153; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y7VOjM3ZnZcKNsAleTh4XKVnDaGFBnGckmmVi6cvmn0=;
        b=ljBlLaQ9ScBVH/kJOz7Da5Ir9nnrRQMtjdFy6tTY8SExuC0DfqOsyrjH5oD1T8QEI8
         SkqOV98IXuAzXGHSGF8QBgjIlRzAJ3SyUsrA4b5FDm04ma5TjcFlVKvevyp4cvQvoQcv
         LDvUMXgWlmehtiRpadRb4cMo7zUiHGrTxcWa542XcfOw164KcOXkh2e1CxyOc5cZdaP9
         C/pxSwgwnigmAKzy176xa+f+SJcqkglm9aBPj/MJ5X5Ccn06B9HDVEGiJoMVUiJcUtGb
         GmOrnzhpPYP9CcgzI8yA6/8ELgiddNBd9GHVesoYtWRHCZL0ykDRioph8p68tevhBcPK
         npPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784978353; x=1785583153;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y7VOjM3ZnZcKNsAleTh4XKVnDaGFBnGckmmVi6cvmn0=;
        b=gC20i9a1UXg0iCCTx/wZND5LRi+UvzLMoAsAh0t0xvSEThfsf8EAiosLsAMv707hxz
         kIogft3UtXp8II6DNKkPY+ARMNIOCar/3fgSYZA07Ov8L/XcAapFQ7tVYOMyF84fmCMp
         Xs+8IfHuz83DnDTGktTsNcBWWeE7lLCS/KV3VNw5o2G7VyHpSPU8xVrsiJgv1fqoquzE
         VkXsesvrEkpu0M1uX2YcYn6hwfTmSPcUZNYXC9AmDAcXe6BSAA6mNxsHTHpyLn+dd83z
         hUpZMWH6sGqu4jxW+HZDGlXZ1Bp/1T2s9JMuune2pdeudFyoQp0J0WFq1dtum6U1G6oN
         MseA==
X-Gm-Message-State: AOJu0YwoYMHYeKIP9TO7hSVkNLDnOo/0sQGV5RFOJLfMni8LAvP/jUb1
	52w8nR5rJUf7qT7ebz43FDBPSMDUCwGPxWQiOKNGi6p70BGzY+CirUBIXSpbBg==
X-Gm-Gg: AR+sD11MX8utqhakEnYtok73nFjzqVBamA5X7LhCbbT20po9SHlMoTtZI9RtA3cZO6A
	aHVsqXXCD8HKzuEiZkCK13ZPeBpbbzy70oZhdq/kIHMYn1qsXelIheWt9/I9J2Qb5UXA9KUm1rL
	Z0JMJ4KQlis3rn4BCNVULrwwAj6Og045uYyGYIRtaoM84rs0NdLrC8wlNR0h541cgSmRdolosAv
	BFzrGtVQWE8pfGLM0V/6GxZ7+T30bbvwvFCuuB/9nEWdyqvjyCbVIbbhNfKudBxgO00+S5OA7ym
	8Qp23M91b3Bxzg9X97fREC7C/Iu7dm7lXJ/Lq4a3IFRSi9XdDD1REqb/R8mTj5+qt3tzoGQohKI
	5Q3vuhX/trzqlX1hqvQ5vdCoMaNwfTUfIt4OSoG9VtxM3zZ/tQxMkni0OUoD8j8AH3p6ismmUvE
	FjM9g7qVY=
X-Received: by 2002:a17:90b:53ce:b0:38d:a150:ee04 with SMTP id 98e67ed59e1d1-38f2965eb5emr1931452a91.30.1784978352639;
        Sat, 25 Jul 2026 04:19:12 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.216.193])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13015052sm32843482c88.5.2026.07.25.04.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:19:12 -0700 (PDT)
Message-Id: <ec682d75f3a7848dc36f82cf36bbdff6fd283e2d.1784978348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2187.git.1784978348.gitgitgadget@gmail.com>
References: <pull.2187.git.1784978348.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Matthias=20A=C3=9Fhauer?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Jul 2026 11:19:07 +0000
Subject: [PATCH 2/2] worktree: reject empty string
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Marc Branchaud <marcnarc@xiplink.com>,
    =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy <pclouds@gmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

`git worktree add ""` errors out with the message `BUG: How come ''
becomes empty after sanitization?`, but not due to a bug in the
sanitization code. An empty string should remain empty during
sanitization. Instead reject the argument as invalid user input,
if it's already empty before sanitization.

Signed-off-by: Matthias Aßhauer <mha1993@live.de>
---
 builtin/worktree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d8188035db..113dbf98d3 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -496,6 +496,8 @@ static int add_worktree(const char *path, const char *refname,
 		die(_("invalid reference: %s"), refname);
 
 	name = worktree_basename(path, &len);
+	if (!len)
+		die(_("the empty string is not a valid worktree"));
 	strbuf_add(&sb, name, path + len - name);
 	sanitize_refname_component(sb.buf, &sb_name);
 	if (!sb_name.len)
-- 
gitgitgadget
