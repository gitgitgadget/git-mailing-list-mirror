Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4308B2356CC
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138560; cv=none; b=ScRM3qOQTex/aHCFDDRXUK0yu5FzIH4ZSOxHIPadF7t/SZHtxcKHlE+n3HRQehBv4AAxi6DC4NUSDH3SVPEd8Ll/N2WUzIsyuqgkbZv1tSwa3ytWJmualbuH6kKJbVb+g+cJdE9mQstj7Hv6s9vWTwR5io8vfZ3UnRlixvMxJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138560; c=relaxed/simple;
	bh=TfEHwgSWEwvWrYE36wipTH2vZhk9j7lMzi2bNnmbQQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SIjs8fHsttz9zkB2Yz6v9UmtbU0e2VUFFCRs4Nk7RIH8DQQ+5OLB/k7/++XcRzi/UslwqngyxKyKsCCIqnHVSVT2q6300lbFrKFZBI6AAOP2rzOH3DEBroeHtBnOEcxNoym/SjmKezrG3AoNc869AfG5q7ZGT6IoMKBe6nZbMQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=9S7VQwsi; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=DlotNbGp; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="9S7VQwsi";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="DlotNbGp"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-22a976f3131so33292995ad.3
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 11:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744138557; x=1744743357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0m2XRBF2C7JdpKowzPGYKgRCGQpXI/dYheGHVe8N4Ew=;
        b=eJ19bKXziwJ+ZBNlEWRtm1A5M27LXO6N+BwxsnGNL3LEE+jIRBE7D2kY4GSGKI04Bi
         jyuekdiENM1TXhLuTCW+CekkGZJhmTA8CZXWDjkTPv4wdR3Da0KR4wA/vyM5T7FHc9tn
         OgRNNplxRddIjvT8ttesgy5hgIk4rjueAqtFLghCoEnGv2NOn8HjgJ0p24x/X1RSWswi
         v4RwEk++GWGFgfS+L1iH7UWhTEgxS1Tz/wehxqFAHJkRpS0p7No/5MGeXCgvpwaj6QsC
         1n+RnlZ9Tlw6WEkMfmkSQestk65LMdXsb4Cx7/AmxR0VEtXe31uXHIGni9PJ2HwSPqKI
         cU3Q==
X-Gm-Message-State: AOJu0YyX4EpN0XonWzZpt7LkBIvmEGQ9eUU5nQ8EgHUsCHpKFylkUghR
	Thm7fwm7cTmQvhNh/okNjvmu6g1m6g0TN4NSHoIWtTqgfQ6xIDYhw+VvSkEd+HhgyLuG+ExjeCm
	eBbDUraLRUrzSzeSQd+oetAcusiaMTEky
X-Gm-Gg: ASbGncuAChlIdYFgXAOdw9ZB+Zy+hhG310dnndHdi9OqY/r3LwOhd5ITM08dsm5fZv0
	GlN4Yn0n/AIzhCaL/h/1LCye0UG7apbMgL2+UUcg8vxg7gEo6EaxOiPhpgLJO3bhEcqT40MUNGR
	/Glx45GeMzwNoJICqeN6jrq4meHR7r3Jwxvnqus9LWAzbF769mXZMdOSDRibIYJkQ1zfQ6nHFgO
	cdFPhndM+Lde70sk/wRpYlhXQUcuh5yoIT7KtgK69HHPAZUXrxvpHfY3356XDQ2VJj1uua8oZBO
	bCKOavaY2+zV+TpGGlGy100Bklnmd4oZpf0X1SDEGBhvA9RifHbezw605WVWTKQdVM/PzYpAHIf
	5mfd48tfCNoQku9TxlBFmA9QmxbssAw==
X-Google-Smtp-Source: AGHT+IHeb8IJpK06X23p41j6c9lFgzUcKt3yUpy5zyTqHYp7zQY1jyd84gRAbGfBn4BQsu0YDDR4m7AdqtQ4
X-Received: by 2002:a17:902:fc48:b0:223:5e54:c521 with SMTP id d9443c01a7336-22ac287dd17mr5766205ad.0.1744138557349;
        Tue, 08 Apr 2025 11:55:57 -0700 (PDT)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org (pool-108-49-41-183.bstnma.fios.verizon.net. [108.49.41.183])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-739d9e9ccf7sm901764b3a.18.2025.04.08.11.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:55:57 -0700 (PDT)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1744138555; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding : from;
 bh=TfEHwgSWEwvWrYE36wipTH2vZhk9j7lMzi2bNnmbQQw=;
 b=9S7VQwsi+MLxM4rBXEKMcX0dmcA2bY7T89H3c1FT8c8/0q67tFqDl0Im+hzn+egJ2fs+R
 VeQLygSCcwoNTAqCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1744138555; h=message-id : date : mime-version : subject : to : cc :
 references : from : in-reply-to : content-type :
 content-transfer-encoding : from;
 bh=TfEHwgSWEwvWrYE36wipTH2vZhk9j7lMzi2bNnmbQQw=;
 b=DlotNbGpaJeR3nWmWfcT614NttnZdkBlaXKPJOjrbp770gvvMImEliOD41NiYqC2UCKNt
 QLG/rf9tNp4HiYq80dndk2xGKFgaCFRkfGuFdv6L7EL2B6GTr/Pgg1K832yPgo+DatZOqwk
 Vaafo3IbWib0L9m/FvOHbbnMRGuM4F6stySvlbRVxO4JYm49Zpc1TS7CWYUP0t3EjclYGkG
 Bz6bK8/0xWLdifeblNYaSfizOBDUhxDyhOZA+MG79HdXDpLd8yvTZI013Mv4ZX4DjBGCtLL
 nINWX/ZOyK9Sz3cNvbfKU4ePGewmDfAIgaoLzxO3lccG0IlMTNcbfs9Z1lIA==
Received: from [IPV6:fde5:2b79:35f0:2::166] (unknown [IPv6:fde5:2b79:35f0:2::166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4ZXFf35wW6z10KW;
	Tue,  8 Apr 2025 18:55:55 +0000 (UTC)
Message-ID: <aa5d0cf9-885c-4aa2-93bf-d8cbf715ccab@mandelberg.org>
Date: Tue, 8 Apr 2025 14:55:55 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] completion: fix bugs with slashes in remote names
To: phillip.wood@dunelm.org.uk,
 David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <17274df2746d304db876ebd82ad8d932@mandelberg.org>
 <5012fd2b-a68b-4267-aa4b-9dd04510986b@gmail.com>
Content-Language: en-US
From: David Mandelberg <david@mandelberg.org>
In-Reply-To: <5012fd2b-a68b-4267-aa4b-9dd04510986b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 2025-04-08 om 10:18 schreef Phillip Wood:
> Unless a patch series has already been merged to next which in not the 
> case here sending a new round of patches like this is the right thing to 
> do.

Makes sense, thanks!

> The range-diff (which you can add to your cover letter by passing 
> "--range-diff" to "git format-patch") below looks good to me

Oh, nice. I only learned about range-diff recently and it's my new 
favorite git command. I'll use `git format-patch --range-diff` in the 
future.
