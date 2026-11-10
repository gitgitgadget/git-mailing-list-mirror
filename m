Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794315497;
	b=i46rZyGz88x4GrETdjQu1pLXMacw2Usuq79LfbQ/L2XVXt5H6zFYDw9Mczole4nkAF6M
	 QKkpyUiG9g3G5XcK0bHkNhvAlG5FIlSdmy2ZmCOAlPolg9TXy+IRFz7yt3Eg28kozb7jA
	 M0aAUMR40pIP/Y7pbIaKjkheeZti0f/QzeoaIrmBXweMN+HswB4NqZeAj7qjZhbySzIe3
	 opvxYNFhFQ6PGp2qDP2z2NBsz7dC3AuR//kZtNwgK6athFEVF/XuVTC9ALClcucKOV9qa
	 aBEEcLeHMFpJV16rby/C0qOUT34oZ0EzA6wISiN0jHPMjHy4yPy7N7gEI/DUSJINlhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=bywfQI7st4goOtqttFp5eXM4RISFkJGYUt09tYTLnTs=;
	b=q2mhPlPdLSwgE0ULK0Z1udR/0D2rNg92ePxttbl20DxFak+VvEhLk8PMqANwG/tf3bKB
	 5b6P6JGnCJdnpJSx3F7Ol22/SdaRN5ZCkKjaeZAb+PthjknL9eFwTi9ZJyfufqTqU7s90
	 C/oGFoDP/4deGzOR9K/mvik1NGmaqboKCZqIS9w/kF79VFVp6U5JeAS4J6HUsh52rGy3v
	 oGmIx12q+JfOs45C/r8BcxLfjxEi5Du6EDDLUrMD1TQMTW/XOgeDCYRQ8uv6By2bOZIT2
	 xSwspp2KRTGc4n7t1TlQyobXDrOJV4OBv3hF4jCB7R3demCoOArY4hObCZ9EdMjFTEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZnA2cQVg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECEE606A7EA
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 12:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AECEE606A7EA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZnA2cQVg
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ed08b07213so7917535ad.2
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 04:58:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794315496; cv=none;
        d=google.com; s=arc-20260327;
        b=bxd3FB7SvSoBunGqQq3xQuTW1HEbznoj6LbmyxYHGObkiMRkfh6tgyW+d4tjhX7nbV
         Cx5GxwmAplgATqPhXVQKCF4ZRB1oz3PDrOq99I5A8RTJ9Y5ApeKCJTSskn6yB+U6es9F
         AOKeWggg9Vv5xpadFJE0UDsBENZrb6cFTNVWeB9FzlTN9xlliKXdtRyjj8J6D23ll4yl
         3MAU8Vly7mGTUCyhbeAKfxvUUBrHETW88iXypbEpd78bprPh4C9PMrcp6jbCib5lgS2e
         IHwYIxd3LLc1apOamlplYN9/XjFLd6t8KFRdJM/8qhUpZpYD5mEVEY0+60l1luUXvaT0
         wnOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bywfQI7st4goOtqttFp5eXM4RISFkJGYUt09tYTLnTs=;
        fh=atP8lWAG0EAM2fhgsWQ4IeRIdE20y6RmRWmywBzJyMg=;
        b=oELHm6eB5YjiyGo1FNlujdDbDXXUQbCxRI0S3ojnIPS9Nuwr32r7QXAZ/jQPsmtKYK
         I3Jo6qqSbjBl+LDpsEkO1qRehKX46f2T1LwoeMLqham0yIleGouFJ2lFiMT3vcgz8KMM
         VcL9rZYG1gZBsiaKwZZc27b1QoCgENLZiG/P2dSKecSrE/Xwtn54AvvPjL+uf1PAFhrW
         e7FIC6BRxcL6iwPCrXAFUobaqXi1HNA4PNo5nIKCRAE4IOsDTCMD1lQUJBqoJ5T4CP7P
         MaMWGfkOJiF0I885uwG5r3IEJYdd9m1b8mWH5QSVtN9fIdNcINuE6B0oqi2AWA3tOGiO
         7b6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794315496; x=1794920296; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bywfQI7st4goOtqttFp5eXM4RISFkJGYUt09tYTLnTs=;
        b=ZnA2cQVgG3+M23cp8fwEorgGZC3WS0PpQOv0wpg2RZTFo/1wBSS6KXzOHu4hcjSFSH
         pEm59zI7XzSSmEo6A30RewfqgZwS9fXP3Ajtc1V+JhnHDhnEBWqlFm3VFLU5FarR0CfT
         SY9XVTVjPQJ7LY6fY1dxWekKKt9D5JscMSZSNvI881egKLR87uBGCfaKkzT1PzqIIvf1
         ttmuJFCmgERZU2r8B8JOmA30WwsBHur8gwVuCmfGIKmVJoCGExkQzy2vCfvXL7yX8DKD
         QkilvnZZF7+qCY3mkrhlvEFXWGPH2E3C4VU63DkU9xShPr9JkwLUYEU4iq9D0IRJT/TZ
         eO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794315496; x=1794920296;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bywfQI7st4goOtqttFp5eXM4RISFkJGYUt09tYTLnTs=;
        b=hoFKoC5saIgEl4+vr4tUDo9NYYZc6l4lUASbqzIKGkmGpkTk4KAFlnLu876htKoS4N
         6VbOwbMjV8VTlEX8Gwn2rXLRjswb3pE3yRG53bIXAzohGmcGHYrzTULmFKMw/uebrt2g
         U8FRlaVfPB5q+EtaIAC0ejlYCopkTOxHbu55J41DmLe4upChqFp9DflJe/Tln1rzau4/
         +aOphHQrD7/vnWfzTvtnjAgEuWhdO6cPK5q3PbSjzXlrEwJaGQG3BdyL1WY/IUolw12U
         oZ7pZy4BePVbIKL0VZuk73i8hAuU29vDaITaLQuIC5jtUSC2tnJPFyMzsc7XvYunnSXX
         lOfA==
X-Gm-Message-State: APuU4Z8WmtwwMSbz/P7CTYueLrnbC5NoXIxpc5DkYQ9XKu8bKGn7SLJJ
	hl0CJjakntLq8X3T6nn5yHzFBbPTthRCnYzGwpR4XxBaqRPUMRVf9cPWeTK3OJ9EPPNv2ZATGbI
	mee6DUOKSWfG+z5wyD2P/JL2yZcIInSI=
X-Gm-Gg: AYBFou3RLGdmF9NUrVO7DpFGRPCCg0oXnwdRTOAWB5Jm2gcccW6GNehAHeWU5ZkevNV
	Xv73veaaG4u6mN01+NhVudV9Sl2wsHu56PxW2h9jA0p/vhcqZhou1pnc08/gHeSSrMVoVDBstcz
	VCKwDzKvx5oIeR/1EVd9n55Fs/mfN23pX+MvgSL335i5dFq0fNN0xaWloj//ozNNNC2B0kmG0RZ
	0GayxSGyw2k4F2ZLGMCbKVsl0rh9IXv7NswUOeInq2eznovId4Nz9+YmDU1jvr4qCqPm5ve/BqW
	XvacHCGAqKSbHIhn+I7mvAxveqjLUAHz+c1u0/X+R2E3M2PHpwau0k8gLAI2T1RlA5PepQeGP4F
	jc81+4oO/jkQ4cdwCXduaKw4YHodmmj61vwIxXBXpO83JJXbU+WO7vkgSIZtVWj6IIX3pLC7dco
	vM69kJZjcn9wLbFzPX
X-Received: by 2002:a17:903:1247:b0:2df:9655:fe24 with SMTP id
 d9443c01a7336-2edb91d1d2cmr23090215ad.30.1794315495955; Tue, 10 Nov 2026
 04:58:15 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <xmqqo6bz2kxd.fsf@gitster.g> <20261108192232.681-1-husainsitamuwala21@gmail.com>
 <xmqqcxse101u.fsf@gitster.g>
In-Reply-To: <xmqqcxse101u.fsf@gitster.g>
From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Date: Tue, 10 Nov 2026 18:28:05 +0530
X-Gm-Features: AclHuK-bIsDj793GbveHhcgJ04UAh9YTDhjMmmgN-xFXh0PSjN9WjDk4eN1RZsk
Message-ID: <CANRKfoDaaF+Dp8b_7GvXsH9mGWqHSxDWK9HbxCcc_j=gz+V=Tg@mail.gmail.com>
Subject: Re: [PATCH v2] doc: describe promisor remote fetch order
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 9, 2026 at 9:15 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Was that extra "not wrong per-se but totally unnecessary without
> adding any new information" sentence added by LLM by any chance?
> Just being curious.

No, I wrote that sentence myself. I was trying to spell out the
fallback behavior explicitly, but you are right that "tried one
after the other" already covers it.

I do use an AI tool to clear up doubts while I am learning the
codebase, but I did not use it to generate the patch text.

Thanks for queueing v3.

Thanks,
Hussain
