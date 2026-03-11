Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C5A3D47B6
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226447; cv=pass; b=RVnbxS+egqOjpqJhEYLDBGtOUjmdbKTj22nOz2dYgaSaEOl6JG63qm8gNX3XURZ+R1K4pS3UMM9i8s9mLVpV3uiUBSqI66d0avnQYOne15kniV/0xP4AHiPeA9dm3IpAeR/CuU2pABTnmPFogrc/FyZ7tPWiQ6QwttvDxSyjoaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226447; c=relaxed/simple;
	bh=cpRznEj6EdRTfJtkkpnm061TIj+nhhuozKMlfY4QhVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=D8hfzM/6/8sZX6s5XmXp+j0iAiDJEjYmpzCIEX7q1sgk+zAXgcy0LMKBW08GZhROkDatTXQg5fV5t/ajXFshqJlm31t+4p+ovhT2ftsvHGP2eS8TT0ruydSPPWSDmjLlP79FgOJ5ro3bF02XUHUl9vJ3M165DJzAf9TYd8U53L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4P9vw9X; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4P9vw9X"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79495b1aaa7so124797987b3.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 03:54:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773226444; cv=none;
        d=google.com; s=arc-20240605;
        b=JQwnhyL+w4ua7Cnjgpxf3sJJWkQMbpG6RohQ6UgspT4sJHkD3Is9ZABqsOxmAvH0MT
         w+FMeXIWTQ1Tvy+Zag2b/LfCoMGgxbsk4mAD2nhddTxATeovqWJbMhZS7jINVs6ZrOWv
         vceP6t7d2VeS9sErDmqSTHB6GLqa0o5oj4MlC0nq9/6E52NcsgBpOGf+4bQIVDmlywKe
         FlThrYIg8X3myJd2hrWAGKTYMEEf8kmskdP22eN1AHbXVlRo+U0c43kWxw1X7zIDRzfU
         9JIUB6vhfAB6TugSmqBT5Zq2I90dHehzEZWcf8TE6aWaU2+sxoqJvwGXNXuVQbfFwVG8
         k0zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=cpRznEj6EdRTfJtkkpnm061TIj+nhhuozKMlfY4QhVc=;
        fh=tEqxrRpDzi30Smfngwt0DpbMVN7fSkopalTjnX/15Sc=;
        b=j1cnjEvLRMAvdsRxSbOTVcw/lQpVcq95Q/PTIiorZCqSWYEp4H8K4YuVPXUZMOkUUB
         sGLV+e6f5udkombMr7Ty6EvTfDO3EOfmu3IfH7OEWFpHgw30xQo9Sa6hg9vvk8MM413Q
         HMwsoT1u6HYyFLMShtrrTvjgGwZgAeuNDz3Mmz4YNPq0kRAhX5L0HfX4eyzLBoSC5gBq
         U7JES3/YRjpQp6awxUGhG8tqlOGZxuUIIUDo2orShIK3PYbIgC8yGD3VbUN0S+DHIOQu
         5AhE0VBO6w8SIrhprX7OTNVdwfTlQNTRegVqnYbr6mjI81dEcLACT3kZjo/+diNS5O8w
         6Xrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773226444; x=1773831244; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cpRznEj6EdRTfJtkkpnm061TIj+nhhuozKMlfY4QhVc=;
        b=d4P9vw9XkK9vSIixX5F0qcWEJIbrHPTWqqjxHwCP/gYXjcsPlxA7z6Jrgk4c2sAI2w
         z5+ifwrlXqZLd4E9MaIf6qpekpEJ6hdhs23NXGkcfC8H7IpWkf9qCHHM2qF6Sk8G8a0m
         CNaa1Ikh/6wN69DqNurCJCcqaHgzGO9timFk2FXUlCn2VbUVpD1ClkG6ZR8b80RrHpCE
         eTl1IX1WhAGlO98ir6fEADiwa2752C58Kj9oaMoVIwlrvWHkV8Tn7VkUisNDgOYiin4J
         5/7EIle1VfW1vmlQPTy8HiPQ3LSByFVnDQ7V9hwNoQsg4lagE87bC03gH29wGipHw5VC
         Vbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773226444; x=1773831244;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpRznEj6EdRTfJtkkpnm061TIj+nhhuozKMlfY4QhVc=;
        b=t0/vNC7cLf7ov3f5Tpbn94Orj1t0+JYibhVEMbtPtdN3UgkMxF0D6QbhGd34oxxYc0
         j1VihaKcaWJ7XRpIpMUnzXT4OhMaL3+g8kGHUCzE4Az4/DObVgb6+XWEdc6i4lPAWaEj
         krerbysLQHes9bmy2q93hH3qOA1IyO5nRAYSoSSQCUfPDnb7zey9ETKRJGYcPdakhpr0
         Uq0cTvw/kygYRbArVudl6FdDVCI4SoxaimdDe9H61rn8xOlm8WnT6rmMq5OufD5PxnAg
         pU7TOLhBwk6oU41LlpHq5DgEpFtUXPGHWqIW37mfedHgYi/x6duH4im7frlKNTxn3KU/
         P4HA==
X-Gm-Message-State: AOJu0YyczdmfAjUqwav9oDd9YBFGqSlt+WhLj6WDqckhC/Dsq8q386NZ
	A9Y/0i9RofYVEQ8Gx+P2YfeUhax8+hI0tM01UEkfRStgFmv8WOQoYtBDe5f5j0yDxR6cs0oUnrN
	ChF++fSiCqnY3oIVEgIxyTn3hSwjI29hgdnl8BSU=
X-Gm-Gg: ATEYQzxRi5WqZYrlbyMCE3mTaE03iGiYZSxLwwBaWUtGVK5Tzkqfvhr2S6B8kf6X2Gy
	PbXnhYf4dw8ppATIXDCahG4yHnytFWTXB15XBI25FfPacduQmBNN8nol6fsMK0pM54X0394sb4N
	MVhjZRPqdoeKIUfAzvlkGKqfNwckSqR6z/rYkfZ5Wg6qmXld2+QRHT5fJsw3LW8TBZyVmbxJzl5
	TwOFRQNMILxWVIcmQJvGNAvtmatJiRTkvzp2683AlYWFchThD4Gcw4VUKWZ1Mxa7i/HSYDfQNT/
	zzW2YLxLA2gHWsSUtTw3ObwKw7nkeg2N16e3ezMefmDJ4SvfA/+xjlN2b8BWS1RWHzsAa1xWKeU
	QY5D/XZZgobIoJ/yNXLKp3zs=
X-Received: by 2002:a05:690c:386:b0:797:d997:d837 with SMTP id
 00721157ae682-79917ff271cmr16014397b3.57.1773226443679; Wed, 11 Mar 2026
 03:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310183513.1077875-1-pabloosabaterr@gmail.com> <20260311031442.11942-1-pabloosabaterr@gmail.com>
In-Reply-To: <20260311031442.11942-1-pabloosabaterr@gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Wed, 11 Mar 2026 11:53:47 +0100
X-Gm-Features: AaiRm52Kmq_Vq7aaqCNjcDKqI6mdnXmeXlFcG5Zh_WSJZ04M5Gy2L5PXdK8lH2M
Message-ID: <CAN5EUNTGO8hUms5mBPtW4XJtx+v1_bi2NoL0=titbeJ5asgrHQ@mail.gmail.com>
Subject: Re: [GSoC PATCH v2] test-lib: print escape sequence names
To: git@vger.kernel.org, christian.couder@gmail.com, 
	karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Adding project mentors to CC, sorry I should have done this earlier,
but I didn't have the project clear and didn't want to spam, I'll CC
on the proposal, introduction and microproject as well.

Thanks.
