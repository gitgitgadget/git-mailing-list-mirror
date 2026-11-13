Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794579808;
	b=wwaOFapWrTm9c+DWZMqWriyMCDduVG+aoskTub5DPR9+EZgyo1uBfszKm0enofb309Np
	 06/Tb+qiitqGhV55lJWDtx8jAFfcceS+ZdFGr9uwwnHmXFoQaeq5HNkOCi+bpBceqiA+a
	 vEHz6H7b+vhQVi3j4FnCifYM2Zv2lDf7ooY8c2wyrDwgrWZCmtHCM9SnxWcQfG92Rji/C
	 qIk0jiLei0xfHH43qc2QmTzm3FLLfOl2GxjSE50RZUM3k+8x4w2BKF7M/gOGo4012dm1U
	 V+ct1kQ4q3hfmqQlyuSSf8LZQ0VhNuiEZId+Buj2l11NPky6EQeXzerD3Ih5tEx+O/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=o3tfqbf3iDKWx4RSSQGG/sW/KSNjxe6PDALqQiUZNAc=;
	b=HQE8mQiy8r4P/cAOcvDTaiQFFqqwGa95e9VbFIYvE+I6PBa2nZ1qPnKuVcdYOvCfEgcZ
	 u1VqxVaEY0mF4xtStHhp0Tm1afX/Qh7AmxNiwbJiR2APdlYVcuUgLt/PeCojj+bYQpnV1
	 b6P9NJ+rlLkFDfPFy33M/duHnJTHWcJYfyl9m7Xw25Ob5WuG2bQ/ilPPZqvv5UokdQt5h
	 SZKfzOtK3Mkr/R90Ffe1zZQEoagnRJ6ZTiJVu1XPUjtgtfKfG6w5yZXVThUmkQ6rQj2WH
	 mJYe7ki69J4D2hQojYonQcnMpxq8Y4EOLmDim+mNQapUhTryBski/gK0DOTnTvfTh9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N6tbb7lu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F31606A327
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 14:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46F31606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N6tbb7lu
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9995ce866so15595795ad.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 06:23:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794579807; cv=none;
        d=google.com; s=arc-20260327;
        b=NwQbUYhzy9sezZE9xmNS1RNM4/k7O4uAGj2GNhXs8jS/t/Kvq00ZGgb5K8rI9RfOuD
         1TXaRnYppbTqEqa5/RvEnhUW2Vu6OpIK2txbFmvtLDbRhdBKgo5QwSvdEis1dL78lxP9
         G25q1SGWF+gZLfeWT6B1x7iwn59xavLWHLfTLT3IvKkOfqr02jFJk7MtIZjQFT6rXFKP
         Yw3E0IickUQzEoR89fTgyiEPWJsV0Zl9Y3deVkRu7cEPRz5KrQK0ZEYzWrHbwEjHjBIt
         Iquap4j0UGoMU/qoUDme0SC65VlGhhwUWil2ly+lRnZbVldGOdFnDkL1uwmK6a6Ovwdh
         gwyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=o3tfqbf3iDKWx4RSSQGG/sW/KSNjxe6PDALqQiUZNAc=;
        fh=X/JZtOIXpE/LbZsqbMxAX7jpAyJ9b3i8z/pTDEGWod0=;
        b=ZgX+a3p7Vg7gkF3RKiIiOj5ydlJUe3dcn0+3gtTf6HfJ991jaKHQnxj+7G+uSHmPDO
         di3eMaxOw9ooZ3rya8MwNip3O+jIXverSVqApegnE65AA8DmYvk5UpQGEJQ1j4CC2Y5g
         ELsS3R3zx1sJFq1VfDTIP+YQN78C6BPvztVmgzc6VmClz4cShOW7XXQ8fW/hupQJ3LgT
         Z/FG226eP6v5O/wjU9TGSj+TsrDfzVQYelo494p+AXBK+8fJ9Nt3S1tOuGaH85OV46C+
         oW3tNo55N5kpO15co+6tRzyuYGHPzGllciflskq/2ovSDDqKhSwt/HkhGKYv+j4LAgbJ
         rmwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794579807; x=1795184607; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o3tfqbf3iDKWx4RSSQGG/sW/KSNjxe6PDALqQiUZNAc=;
        b=N6tbb7luK1YVVgrvTB2RtBC/nil0OgO02tIdvGjJJybmkQZNBy5RN+CQMaT3jbmJaU
         6OmeHEwx2+XcSQgzA3hvTYDovw3tZxXPBhvWth/sFDU8a8WorYIicNrFCiwsGW0zm1YV
         jdLIdYdg38E2ZN/FXVP3Dg2kwgp2VA7Uk9gqnMzOH1GNTh1BIj28eQhjXBg4mZFpAjT/
         U3NmE2Pa9266DNtYXHKZ140Pg6+Jzb4DmP6gDV56WRq5rAgHDTZBD6q2PK6fpUFkyOrO
         5mE+bnivCcbZeQ/lYbktJQcU9ITsa4pJu86pW/vQlgzXVpSkee0D2go3miM074VvmBfZ
         JRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794579807; x=1795184607;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o3tfqbf3iDKWx4RSSQGG/sW/KSNjxe6PDALqQiUZNAc=;
        b=sGSEgIHR3RgI5j5ZSLI9eV3nnLHXJ3Ffyb7dwqZP8aEd4T/rAbp7JZtaG9B9dqLsUl
         IIlQlQkcnLUs3qhHliTVZwx/gynxaI/KCK8Afkq9UA9wCis+qJi4JSwHhvLlmR9uiVgv
         i+se+uV3MwoYU2q0hE0/GhMUGKK8rhX5EISF1ZBAa3rZziLlv1fBO5FyiEQYMc9orAH/
         Vng5V1MVuU2w6KU+G5xm3ssHBZyFNnTNF7OPjYXmDk2QUTO3NKK0+9Tx+f05PeF+50AF
         8xyBa6NUsY8CQejVit80ZCcI3633IS4F/8NYYHlXEE8pMkhyC+T6NIhLVG4w4pipq4MN
         tUXQ==
X-Forwarded-Encrypted: i=1; AL+hErHmx5n0O4fU/onbK3Y42gNT9V0vFY0u52NpSerYK5RlpdPI2ZrlC4Ln7EEtUkoknr8M2dg=@vger.kernel.org
X-Gm-Message-State: APuU4Z95BQqxe4Z9mPcUmeF3Ej1ASrUE768N7WY8NNoCAKfyANvnLCui
	flgXJTMP6SnHLblpaVZQZo8vx+LiQx9OHb4Op6Wk1wRDmkfWJTLi4R6DT+YL5a/Ho8BctPWmMC3
	5gjnpDUV5wFJzw2bo5ZDO3Kc61gaIp/z11w==
X-Gm-Gg: AYBFou1FIUkMAVAuLscn04Ni9zbVMo1A/A8sFcSMo5en+LEAW/TrZxqG3ODOuei+S2n
	OIfvPczVEiS9oUnHwKb0ZRs3mXTeWWl2DN7BOFIwo7+2le1296OWbJb/Ds9MO7aPZgPmjpm0rz9
	KvckSe3ELSksc8JaeRab7EodcQA2eW3w23sCl86hhckXpx74qzmCDY7V7Q5O9zgBG+HWt+n6GEO
	paIwoRtunQM+OtyetuKeNsH8ILZ2y/G9+hTzPo9KQUFwfiz8OFHVAGiuSdNOsAGs0Gu2SaxeIHT
	veBzCL2MRMgZh8ASfA7Z/ner1G1ctAN+7lQT+8dEp6zUM/OifG0eOK6WXrYkJ+Mc4YafatNpWCn
	2cpWaglDWTvd4qhaKtIyPyKNEIDZBG7t/8oxk6+fRbb5kp4I7Ad3W1dkZKKznZEuFOyY840d9
X-Received: by 2002:a17:903:1c1:b0:2e9:6333:fbb7 with SMTP id
 d9443c01a7336-2ee0dcada65mr30249095ad.51.1794579807472; Fri, 13 Nov 2026
 06:23:27 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107150433.17540-1-husainsitamuwala21@gmail.com>
 <xmqq5wy89rq6.fsf@gitster.g> <1c124d5d-790b-4d22-af22-c53573e6d2ec@gmail.com>
In-Reply-To: <1c124d5d-790b-4d22-af22-c53573e6d2ec@gmail.com>
From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Date: Fri, 13 Nov 2026 19:53:15 +0530
X-Gm-Features: AclHuK-hyM8UcyGBCP-omj-3LN40-M5uAgMDUsRipM-aOQBviferph-LhCyjfsQ
Message-ID: <CANRKfoCTtHrZ233nZyYQod6JJsNXve+Lofia7=8pnum6oEPF0g@mail.gmail.com>
Subject: Re: [PATCH] partial-clone: document promisor remote fetch ordering
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kaartic,

Thank you for the context on the project and for the offer to help,
I appreciate it.

For the record, the discussion on this patch continued in the v2
thread, and the final version (v3) has been queued as
hs/doc-promisor-fetch-order. The commit message explains that it
documents the ordering introduced by 8808e61fd3.

Thanks,
Hussain
