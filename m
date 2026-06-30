Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA6F40683C
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820105; cv=none; b=bUXXkckX4w9WRnq/4kMyBnWQi456Cy3kELI07D97BXon/WBnH4Z1nk+/a5zUZlgU4Yzb4le5kGYXFPX6k/HSxs5n08mQGtuIUB3g0n4GQ3eorHDb9Yg5NozH3RLd2ARSlvXh7Ku1jsFDNeQ4+euL3oaG2iJsif0XplaCW+QWujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820105; c=relaxed/simple;
	bh=gQoHveg6MJHOf3py8uL1Ya4rB3c9I/dgZ7/4GS0LV8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FzeKQG3oRh2VZ9TKkPMQ+6/Q8Q+/4pwc2kDCTWXOgNaBK2aXyvZp5rRbWLTSaWwhCgATYvyRKdz2x31OHNvOtUyUaz+tiXTsQkC/d8ZJTqoQNYGPo5KMK66n+PE3J1iYbDG5EeI3h6zt+DkddMM8mMDnuzPJmk9vgzLBVWRzy+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e3vUddIs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JWl/HQhs; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e3vUddIs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JWl/HQhs"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D28ED7A00F1
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 30 Jun 2026 07:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782820103;
	 x=1782906503; bh=aFLUH5xv6cZIa6hjXAaLnw4G1GbFEukOxFJEtzb1p3I=; b=
	e3vUddIsJdrbHO8M97AV34q/lQ3UeTmQHArxsHvtMALejAeT06uGkSIMH6RkqqVD
	BwqiTBOE1aOEJ54Anuhfn6E/YlDoKx3XKgLx9UPT10XdSqR5w1SupRu0+BMQBWG3
	1mU1244/o+MbmJfIPnpQ8oiAOCUbh34tmM0TLaMIriNWXwBoNGgJ12h4EdzNtJFN
	4v5qjuK1WpHaI6BQpt9+4ZDMiFpy5iOeWM4tDV6tp4CtQ/QosErQXKy+WJ0DVEjr
	IVu9KGqsEPZRLzymulHQm17insPqwcx+Dyegw+kOALj0LZeYajOtxV0Ij3RQInaC
	L/tHucexc0SvZt6ltIWw/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782820103; x=
	1782906503; bh=aFLUH5xv6cZIa6hjXAaLnw4G1GbFEukOxFJEtzb1p3I=; b=J
	Wl/HQhsiWmRLBkjvVrCDP0z5HhJN/RLLYghdrmAAFSZ3b7KEKgJiKfJlp1Nz4h+m
	WOS+kRRHEtBsAR/71pttAUH2SHHmQAMpipUS+rlxqWY8OundTE2n4uAnoiIQIT18
	3rHkFk4g+HWglpIvFUx/ix5AFKZl/r4bsdijxrL0ovZhwLYRXhNUO6EyZzDARa+y
	32BypkO848N+vDbcnwaXpyHwrTFJvTuI9hPOaQAZBVJ+TiutvuPSav57txlGC/JC
	gLMZt+Xn54u466kcDb3uvP4r/9noGcjEkI9lc932sa9JwgBkU4ZClHIJ4Zarhoi8
	C6D2Hj6a8vgG+cptJKT2Q==
X-ME-Sender: <xms:B61DagEEX2wlbPD_MA4tka8bDw4XQ9ifN7WqzLRGJ3ey9y0DC2NzWw>
    <xme:B61DagSvmbdLUIKS_W6VxdHX2tZHzns47nIIhBHiM7rS9ZbFP-e5anViAT4ztEu2v
    pYR2qMrpvouDJTyez9IC8DtaYJM1LxktLXIbh-7pVOhJX5LxGqx>
X-ME-Received: <xmr:B61DavyHf4uO9GYUB6Dbb1l0Idj3CLn446W6qrgBVJRUsIl0dJaQhsgMbOzgBUMBSyCb9rIo4Ar5bf0jxO0xNj-8Zn_5O-nDtKdGNenui8WKVA>
X-ME-Proxy-Cause: dmFkZTFMj0npvFJ5xMu5TnTZGwl/kjNgIE3c+0+JrvywJVsBHvwNH0JmEkV9/sHb7KtHci
    MWHt4fCw++BHgU20LsJIOXEGWWe7laoLapVct5ezFWgUrSK246UxYzIlrE931fJU7zptCb
    Kt8ycW9gOfxVEBILBMqaO/gR7ZjX830aRvEzgMVkDX71WFJ1OAahhczPptAaL8l+tOR3ej
    9r8uWRRiGNgTXQd7Q16Bn4Ti/3nvp69LgGzwNNdE7d9Zs6RyP3ilqh9SA/M1mBNs2+qPBf
    vwS5f4zH1TbnYNSv0Awptv9a5rucDDTqwCIXVp+kgUqtQvSOo6yzZiVbOAfdN362M5E2Xe
    G69II6221dJKVADa4+R721a1q4qsP5v3z991+JPJPERGAUdN2Af+yis9HH8hjBXbYAfLL6
    tiTqxPgnwEBkFZYEELCSjX7G+JEhJ7CpnB2pNwITlZ3DjBLUV/OaousLuxKizeSYiYzZR0
    xrgSXYRQ54dN3zAkLPN2FY1YPIojn7I/dUFbRAD1KMjdakztU91tutl8BGZdViWA/3fNsT
    AWxAifiCKbJngACQyFRaeJAyZc6YwzCUVRld2GlItuT9rNYf7r4LkWZu6fKGOnQMC9PKk8
    TXU7WY/ysGuBwSWGqb4fD6Mfz5R/BZq+jW6Fd7onIQB9bGPzBysrxSmHvddg
X-ME-Proxy: <xmx:B61DanPPPkbgTz4biaWC2XevhtFGqbWPVZAFS5SSxZ34Yl3jGu8IEg>
    <xmx:B61DamObSPB_WxXVkcWMOHg8yPCLItHm-1qWZZLxtxbc_CXRiuS5kw>
    <xmx:B61DahQIdGUaF109V2u7IRFoxcBpLVSaL2Y-okYtmXapftEclxgOlQ>
    <xmx:B61DagByGEtQ6SKYojJbKFz_gGkSFGnq92Oo1gFRB_-sSEos2Ua1FA>
    <xmx:B61DaqXhodXAgpKYxtX8efjnN7qyFLRYTufe5_TFjUj__kWqfWcC_n66>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b92798f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Jun 2026 11:48:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 30 Jun 2026 13:47:50 +0200
Subject: [PATCH 11/13] setup: drop redundant configuration of
 `startup_info->have_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-pks-setup-split-discovery-and-setup-v1-11-13864eb5a032@pks.im>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
In-Reply-To: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In `init_db()` we set `startup_info->have_repository` twice: once before
reading and applying the repository format and once after. This is
redundant though, as configuring the repository format does not rely on
this variable at all.

Remove the first such site. While at it, fix up formatting a bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index 7715f3ea85..4f37a7b642 100644
--- a/setup.c
+++ b/setup.c
@@ -2847,12 +2847,10 @@ int init_db(struct repository *repo,
 		apply_and_export_relative_gitdir(repo, real_git_dir, 1);
 		git_dir = repo_get_git_dir(repo);
 		separate_git_dir(git_dir, original_git_dir);
-	}
-	else {
+	} else {
 		apply_and_export_relative_gitdir(repo, git_dir, 1);
 		git_dir = repo_get_git_dir(repo);
 	}
-	startup_info->have_repository = 1;
 
 	/*
 	 * Check to see if the repository version is right.

-- 
2.55.0.795.g602f6c329a.dirty

