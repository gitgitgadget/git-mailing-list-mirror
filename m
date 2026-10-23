Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792769613;
	b=dVkRcLo+cxXnlmAllRw1yk4pdEOBVL2sfRLRkuwhUzZoT62CBJ7scgnmVOr+eJtZf4oE
	 v+MoM4eth2ePst2xELo+cH2VM9dNoi3idd0IXVZM3AmW0WCnO9YG1rPb3lGIo1l/UUUF/
	 tA3agvvvD3SR/2g6qxPHEmnK209MTe4PMt4u89QihKi1sAq4OlCifch8a8hsVBBDurHfU
	 KP9CXYhwKH89n1hB8+Ux5vOgv1xwPZrGoHQehKRY/6f0KMkC5SvkJ3jitAepoz4MvzhaA
	 7ZNzNctzfedU8DWcMPUv2y9fnSnbLbHas0DCiJtJR6uzUpKtfB6c7vOr3ozlPgZn2uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792769613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=EwruQhRjXZFGRBjUC16hTs3uYdIVVX9UscfMpCKCupk=;
	b=Mb3joJsDaHkQJrYDSiqCT+IhWCS9ip7xxYBSoOpSJ1wRlGcuAvm4nkfyTBNFC0Dm/lA7
	 JJq9jHnij1Pjlj1jR/yARpzKGNOcSRH+fWPE0ajCSKbHt1bESGNQ+nj6n3wAoSIVzkLic
	 XNcgAwIvmCrsBTm/szulv+ADmy1mrpmZaCzb/s/7qwyRiXwxQrSiiy08e7syFPAlnpQJx
	 uoNgtPC5qYw5MmyaTYgopCMaKW+Sstrfr8WG9VOZe7m+nfxv9N3+tvPiUpAlS4dKP5iU3
	 nVF/Xv8awXyg6oJC+LosVjtcMWzY6a13enJZUd9XbY9ag9GzBbx5wOTiZRziFgqoRGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QO2G8502;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796EE606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 796EE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QO2G8502
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so1546468a12.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792769612; cv=none;
        d=google.com; s=arc-20260327;
        b=am1+C28GhfwYsEca0xsbw1BmaS3fCYlDSeGB2S1BLtgNgWCZFRmB3IHBLHFoAjRXyG
         IuHgGK6As2QcT4xWC65Poxl5Twt8vbIY1TruZG4qS3OxgBMYtQx5JlsxTAqmutmm/tc0
         eWLOvgs8SOl/4GyXrSBQcK9q6Fq68Soam16CxFaB3yMug223YG2vgaouEdsWCLn98pO1
         Hi/2qQg4agcB7R6/X6axm1M9QRI8yF1DfhEaY0+UMxrdg/NdMoDJoSrPHbefJyxWIrem
         t7fowkH6M/iU1XY/P2H6QgHnCFA6yVjUV+eJKw32mOPvwlNPS09qeLv6e2E0sX0tWC4h
         0g+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EwruQhRjXZFGRBjUC16hTs3uYdIVVX9UscfMpCKCupk=;
        fh=dqXuqACRcHtT96zAYKRQ28Slvlmf7HHAc1VPrOq4oYk=;
        b=SF0g/4VepeqTSgMcQg9vOp78hUfLTPsID/beb4eKfNrr8jlFwlotbGHf+PONyPAMgr
         tUYXJJqLfflwjaBITWXnGEPTWRoTF4dC64Cu2YgLP4oa683PmZZHTO+09tcX2FQBiUsi
         9fvH/7yGOb/KrYApgBBUCqAAZWsKe3mHNSMur//9u6qh6OYbGkyanut3De0Qxof08HL0
         uP5/gGEVl3bZmYf+X9mJWuVDc5DQ60UczD/Dt5akwUTa0G9SFxFCl18kMnAowhF2vlOD
         1Ik3EL8OGq4kikD1fTgXPokT+g2AAYLVrvuJfCFY5I023GgZKKNECNOJQO+C7REen7XM
         0GCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792769612; x=1793374412; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EwruQhRjXZFGRBjUC16hTs3uYdIVVX9UscfMpCKCupk=;
        b=QO2G8502VA+DlEspruovfxZVL7crNNDOxAkcXK9CuN1Y2EeoQ6VWFob+XpT9NUwz79
         vEJCclwDcpRMbWS4n4VO4rU1t94FxTBvUHQ9ABwbgZZIIz2trqZV6eByse6XiPa2JWcC
         7HQ59o+HLAqof5jlGtfEW70yVrvpyWt2kbW0fyvKLo7JFgmrboj0EFWGojA7M7ecqBo6
         zjUl5VY0OHACyvr8qTO+hPPUJl4nLUUOlWtmh0Fc0yCxCRxR/s9FF7ZkOrfy26Lxx2Ee
         Ylsp3KfaZqmMQqWR+2FuXQwxrXGrno0lMvigmrIkJNEfSW2IFNjOg/pOh0pRaYTnuDo3
         PAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792769612; x=1793374412;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EwruQhRjXZFGRBjUC16hTs3uYdIVVX9UscfMpCKCupk=;
        b=BVNyR4a1+qQwusXMKtGX4+CzEgQzgwAHGmwdMq8WyWIVBq9BM89kxqgswzfAp+qBry
         OvBVU2UQwCX/nb9EKw2diQVXMdYD4k2pxEsZSdtr6v9a72/GL61GCHVJd+8ucN/qDAFf
         8iu+yI5jlvPg2lN3r26FWv5E2c3j6Mc5U0KMENu0bce7OxclWvmwgw6fka2hmvOHtSaB
         GwMqULoI7AqEuQMQbwI8AQFCr1ESzyLvUOLZgl8JYm07iNIJS6isjDZKHMXeW5wfy7Oa
         AQaRs6HMq2uX+FEZX7ebOWCQfAKleALqkwOr6zCgBAsjqXbSHajrjCYRoL79DEDjdkNh
         xixA==
X-Gm-Message-State: AFq9FYKhntmpsYRO/JGXIuBAfLPR3Y7BujXQ6y1BWy/+2pbfYE076+19
	MNCU0pTH/YHbthrbBzvwDkouncmv+eBIEnAc8NmW7V0Mfc5Uz0BCEpe2C0Q/Y2k8XUCed8rWHSY
	3j8mipsz1ML17NCHXCl4XgcRds7Y5Tsg=
X-Gm-Gg: AYBFou1L0YBYubycGTUxiRpRKotglD290zQ2cuLXO1swaE6Y3yc0w8ieu1IsYobenXW
	3NsuhSQY7Hrowd4RRvpgcCvMF5oXo+RdHsZ+7KwOdUzX8BFn3X8yYrw6Kg+kbVIT7C2SRPo0T6T
	xEiZAbbMhKyj2AB8OyLjYPv1vFBlxtZkF/Y0TvhYm45rpFKDpn361Uk9sz4f8YhE5PVJ41kzBKd
	WASi4Ak7C5egR2hx6TbxRShGkjBBrzNaBzWcWyaGXa8ZQ7bLXCtp6fQqsglvIK1lnJrAiO9azxu
	IJgyF602LfnKP3IcnmqXkJw75dBoRsW8oVkwW9llHHL1t1AIyo/a6qQdq+DYGvfbH7fMdqKgHuo
	w8OzTcqpLitQE/b5VFYa0sEvsjLNbFe59LDvF
X-Received: by 2002:a05:6402:a511:10b0:6b4:2807:94db with SMTP id
 4fb4d7f45d1cf-6b432c021c2mr3092370a12.41.1792769611557; Fri, 23 Oct 2026
 08:33:31 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com> <pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com>
In-Reply-To: <pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 23 Oct 2026 17:32:54 +0200
X-Gm-Features: AclHuK-pPjkI2nPtnUKii2_x-kC0fr6CrxAPNR3ysQ_0Fmt4712RBREz7fcGopo
Message-ID: <CAHwyqnUGByZs20wbwcz009f2=XLzJB3BiPz7C7DRG8igYgx2iA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] reflog: add --operations and --historical-branch
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ben!

Would you have some time to take a look at the latest version here?


Harald
