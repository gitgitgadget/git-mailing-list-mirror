Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4051E2848
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 05:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739251133; cv=none; b=dXdaUaFB6CDqz1jiDSPx8BcErBs9jCeHPcOeX0cundKwspHxGUywBqS4gRSCzzjGvV3doT/Z2DsqcLGjJEtN7h8sIsbzTSGKpg124ucmsYghTWgsZrznvnOT/j4LdWhm51MbzNOv1gKdx94pLPUhRVAaUG+SuMgNjfBo07OViOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739251133; c=relaxed/simple;
	bh=oc/06JdobrzXJbRXKMDzT2HRfeACNL7wPzXTuxjm6hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKnR9TdW0WFqtzuvjoCHMXCgPoy0NqWloU5a2uiAQJGA15XN+XpBmgr1kH5FqicVln7uCdtKPa96Dm47t735kl9BF9/0Nl6nhO6GrfJi3Qw2VICAozMARLjIUAlvzF38UI7OlI4MzgsF2s1gbO2x2zjTLlJI/Hldsm5sdgg8mJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrX/Ehw2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrX/Ehw2"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f3e2b4eceso96784445ad.2
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 21:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739251131; x=1739855931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7I6KR4WqFDkZatA/J5dFWvkaZKQtmA7tDmbCZIqMceE=;
        b=KrX/Ehw2Sgxlg0GWFjia903DS1R4OEcpviVJJCOoDAVApln4llgz7eTt5ko2o7HF1y
         ArJ6wi3kBf6l9Xdez3VLGuUaX+fmCpiTiNH6b+ILdQrfjKLTtH6zvwIefK9fej1fKvFr
         Q7bX3ZKBSBQERkOrP0QzEfMbViqjap5Cryfyi3xTupaie51SSvPxSo0J9vBktJ3lfOkL
         S7KUxYU9lGCYPJGUHLUx7a/R0H+VJGpjWBwB2vnRz/qSV2xr65IxM2xlJkXP1nlnUJ2/
         S0q5laOov4t93s122scufDnH1AdjYbOHPlVJSyY0w/BHuVyqRCupvgtlCWLuDz14SGDG
         v6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739251131; x=1739855931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7I6KR4WqFDkZatA/J5dFWvkaZKQtmA7tDmbCZIqMceE=;
        b=qeVCByMKogCO/gjyds6ticjGyx5IKBCnbdb46CHcZU5kS0quPgT7LLBNRzggDMUWFd
         J3skQnbWDi4M4j4K7Og/quK+ItJ7AwDuDZ0YNVq/eeIXWeGDa+xrf9P1TAoXNKe21ELY
         YKm+oV0v5sFL+MVz7SjSfdyhZdxm3Q26UFV+HBMvc7664IncDcI5kaNo2CAlB9vpTpcb
         e365duUddPj2FnAyptQ4iKGu18sepzFoV+nILqKUmi5SBOq42s4K18nlUs9cZXFsV6RE
         Fr4B/GapXM1HMLtew5K9U0oWxaJlfKWPShT/hupAu0op98B1nzwz/lkCbhD38seqbWTR
         5ROw==
X-Forwarded-Encrypted: i=1; AJvYcCXYp37x1APWq3VZIFM0R2vVxvNp2Bst2GGDYPpXNzt832OoHxTpMAtInrofjOh1kY+hKuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr5R0SxCzsYl4RDamOGssTNNCRDcazywDGTWq+DlQEya413ovT
	UkrXbp/hlLgqc1Ysu2dPaIxZYoQ7p/ClOuXoEwKXmQtWq1aX0wGd
X-Gm-Gg: ASbGncsu7sKO/Xg1zSU3suk/IYd+sBRej56AwrhbfNmRgr8VufzR+0Tl7y0GBUec06l
	CzdLYNU6GzG7t12xe7CGWWbQtfeCAE53k6SkerzQhqb8eN7JI51lyAvzWN964dcT5gg6X9du/AG
	EPmivICKCmpE3tYpPBG5S2AMyOqLslx3zj16YUrkAQ1RoHd4ErnbW2OqlmOvZg371QaCXmg26C3
	9tnEvnvFj8HQs0A+QPTxM3Dz7xRZa59dIr1Ff777hEYCthSBX04JXK7jK8siN3wlFIeK5V5bqEs
	HvqJg/rwCi9bQWH6S3g8WSVzV2XkICSXi+9cEOpeK2H6wlXv+jFJB0BEQrHBnN/XK5M7
X-Google-Smtp-Source: AGHT+IHeT8kHGB05ukuNKV4KUthOnf+auqN0teEHboDDNbPijeZXC9AGWu36ettPWap+AUyHg9+gNA==
X-Received: by 2002:a17:902:ce03:b0:219:eb2a:dfa5 with SMTP id d9443c01a7336-21f4e75e6femr260058805ad.39.1739251130937;
        Mon, 10 Feb 2025 21:18:50 -0800 (PST)
Received: from ?IPV6:2401:4900:4c12:fe76:547:fc92:af40:dfb? ([2401:4900:4c12:fe76:547:fc92:af40:dfb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa4ee2ebb4sm6225198a91.12.2025.02.10.21.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 21:18:50 -0800 (PST)
Message-ID: <fa9ad3c6-3b3c-4f3c-89c6-101ed1b51eb6@gmail.com>
Date: Tue, 11 Feb 2025 10:48:22 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git in GSoC 2025
To: Patrick Steinhardt <ps@pks.im>,
 Christian Couder <christian.couder@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, Jialuo She <shejialuo@gmail.com>,
 Git Mailing List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im> <c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com>
 <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com>
 <d5cba1a9-fe51-4f3f-970b-3ef8a7a2e459@gmail.com>
 <CAP8UFD0GEmsJDFzVAV1bgBNeD6K3auH4paWEKE6=f0=_E6gifA@mail.gmail.com>
 <a2a76725-5778-4b7d-a266-c3a1431316ce@gmail.com> <Z6Xmrfut7jdsVAfg@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <Z6Xmrfut7jdsVAfg@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick, Christian and all,

On 07/02/25 16:25, Patrick Steinhardt wrote:
> One thought: From my point of view I'd strongly favor extending
> git-refs(1) over reftable support in the dumb HTTP transport. So if I
> had two applications, one for each topic, I'd lean towards applications
> for the former topic. That might easily cause unfairness in case
> students aren't aware of that.
> 
> So unless somebody else wants to be main-mentor in that project, I think
> we should either drop the HTTP transport tropic, or communicate our
> priorities clearly.

That makes sense. I've added a note to convey this clearly. Kindly check 
if the change in the following PR looks fine.

   https://github.com/git/git.github.io/pull/750/files


On 07/02/25 13:37, Christian Couder wrote:
 > Yeah, but we have time to decide on this. It seems to me that we can
 > still come up with new project ideas and possibly new mentors or
 > co-mentors until it's time for applicants to send their.application.

Indeed. More volunteer mentors and ideas are always welcome :-)

--
Sivaraam
