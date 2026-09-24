Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D258C3C3F70
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261071; cv=none; b=HG9UEyO4SUtOZwgfiPHXZlcawSx2nKUNOgScAfalYqji2lSonnZF8RuuPlMtKhi7My+fzfF99Kd3XpNm/UqgXMHs3gTPrKR2qFav0+zGDgUDEYlJd4Bljf/c64y3ZpfEjWyGUiG/vP8HOhK5uYk/eKlzu86ktQXtVaTmDntna3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261071; c=relaxed/simple;
	bh=AiETOTLSFaWnJU0kwB2PRPvXx5kirhmKpuJuxL30+C8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=key6GnYJYRYQCEAFa81PTO/JFUBIIMU1wGmcpAmkg7szAWI+LFaZArKjUsGJYrVDV8+ZAvCvdrgBLtD2zc/24ywEb1d9x2OrARslcMlKIhZ9Tr1YDr/tg8p9tuKbid61vI3qTjcDdLxMRq4q7DpD82659wjmK5Y9qd9NxtI80Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBLvmLU+; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBLvmLU+"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccc02279so1369273a91.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 07:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790261069; x=1790865869; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L/TvqFN0e9LBQlQac9DCxDIgqA3SUcI9Jk6f/Z1p5GY=;
        b=TBLvmLU+mO6EW4rpEJeReE2u9XO2Vw3vjnL4pdxHgr/Uvd/uIqhFtp95zw/wtXDEm0
         gx3LijZ+iHc1WPmVjgyE2vQDP291s4CIynlT5SzfQU5zvV5VT3N1M3H+kcXm6Xxjagmb
         J3a2JZ/KE9XSocyQkEipmZMtpnfywVE5C6/zzbP5vMFGyP2QWermryCfu6QwapJ5qCLa
         S4Q3j99wP+ebCO/nwH6Ta97MTjfFtVd1j17uAz/uMPVlEGolfFSrbC5q6ilrzh51xLH4
         Ru60Pa1tFNUkxADCHCar6t8zvZHCZEtuidYd9xAPGcPFjtSWaX0LKPWjCvaECuESb7x6
         qALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261069; x=1790865869;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L/TvqFN0e9LBQlQac9DCxDIgqA3SUcI9Jk6f/Z1p5GY=;
        b=Ilqml1Wz7LVVMwApXVbVTek9pGfwfyHRwgv0VxTvzYOWGivb5Qcb6xqTH7r/lb2Tkf
         ikI7/TW2T/xd+24kFUe6TW6gmE12rA2HDm2UhX+65yDesxlMB+rkq3em2WJxUJ9UsIfO
         eNnmbKm9NEN86e6SxMic4Y2EDgahXmJ0vHYtxF4xVR6QmUOCUm6N+jLEOUC3ABzvVQlX
         OwEHwY4+4ZqVPQFx9CPk3/toVzSFCV6CdOwQuhUlNOIJ14B2ZiDY7e0X62HKi74WmS9x
         DSUtEc9kpgc2eUc9c/z/NyayWU6knuL6ODGurjad7K+5tdHrgUDzo4ncs2kQ8c8SlhXh
         Owrw==
X-Gm-Message-State: AFuF++ljxLflZaHJwrQQkyp0Yi27I1sCotG26dkjZjudKcUh1+7B59pu
	pV3fEi/WpDKSPkxSpL7L2DMIgOMXTcyaz9M7GVgGIzTkaX8cQBKGztgyCuP7HA==
X-Gm-Gg: AYBFou1FGtN7pHMD7lAYaeOODoOZgdmxuqZLqR1LxYfaqxZQepkqn35LEuLO55aQfP2
	n339E5UBbgF108+iTFmmOBHxAF6M7yEy5E93JU2XjUvpQxbdC6vlS0YDffEenjfHzgp0XrZ7wn/
	42ty6kMV3XEx6WclfVQGguD5kevtNkOQfJ4JD1nPuMdW5Nv5/hn4gS2shN8IWhR8xy7CHddfBCX
	OmgINhKIDCIEFS22Dsav0K15J1oApsqLkpiFcOnIajDOgQIIdOkCXqEUtLfRJ4DrVOc/9EUD2Wy
	7GFTL+DxIaVRZC71+ak+WC5uCjLwfJhJj9w6fFULJ2Aa84GzBcPv4FEuWG+kpCRTjayEsFB/wK5
	khCGPP292gwcucLRDxvryFinoQ5KDYZhkWOvy9VtRzeDzL8i0tEsx/2OBHTNN8kQh/C09U6JHLt
	8k7pUhyKVyTZrxRH3oRXa6doRV4UVf0U5EbaHaNR9WkliqXQM4TeFV+0JVWtPocMAOwmnggm6g0
	1Y=
X-Received: by 2002:a17:90a:1090:b0:3a0:a515:c478 with SMTP id 98e67ed59e1d1-3a0a515c8b7mr818982a91.62.1790261069158;
        Thu, 24 Sep 2026 07:44:29 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976c7435sm5641613a91.11.2026.09.24.07.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 07:44:28 -0700 (PDT)
Message-Id: <ab459231e024c5c254ee7f336fcac2e249309bd4.1790261062.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Sep 2026 14:44:19 +0000
Subject: [PATCH 4/7] [doc] git-revert: link to new merge conflicts guide
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
Cc: ps@pks.im,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-revert.adoc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-revert.adoc b/Documentation/git-revert.adoc
index ffba365e63..0a84447a47 100644
--- a/Documentation/git-revert.adoc
+++ b/Documentation/git-revert.adoc
@@ -31,6 +31,10 @@ both will discard uncommitted changes in your working directory.
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
 
+If there have been new commits since the reverted conflict, there may
+be a merge conflict. See linkgit:gitmergeconflicts[7]
+(or `git help mergeconflicts`) for a guide to handling merge conflicts.
+
 OPTIONS
 -------
 <commit>...::
@@ -162,6 +166,7 @@ include::config/revert.adoc[]
 SEE ALSO
 --------
 linkgit:git-cherry-pick[1]
+linkgit:gitmergeconflicts[7]
 
 GIT
 ---
-- 
gitgitgadget

