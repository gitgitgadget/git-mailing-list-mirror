Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795293434;
	b=WSf8UKbRzbjjzv4Be729QM7IG2H4xYwW5XQPjotX8DZNGc/gMlWxSQCgl/L3mWWYS5mi
	 4pof5mwvRIIRaJPhDQ60BvDXN6UCmsapf+xkHbeN4CiWIGHPxA/FN1m9q29SB3ecugfo9
	 vO3qnMurXeoYel5yNhrAGCDiXHR5/ez3bKvrkk0rsByUbtf8BIzgPYoFTBb0Hyk0NfPI3
	 H7Y7S53DoXdL51+5Gban4UdQg4MBRLd/sxy2sGPd3ihtpmE4yj4lVWXiFfn5leg6YdQnr
	 VRMFQp6jtOSlM0sY5xG1ED7BxU21jgkA6jWSzMZo1QmiXBFV8sDq6b1DLgne3V5LykA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=jMezZ3xwmkxlc9w8IXbimBosbsKo81k/sAwQFdOukjE=;
	b=Hy1qmw1agvk0peialmE4GIrtY7u/qskL27r4Ur4DVyiPkWaPQ8BTUUKcCeBfXz1jkRdV
	 tMAKlVf4bGQvEsA9awlH07hIBTLMbwyVqeiAJEH9415yLhDv5X65OqXnk2IZO303o8tMZ
	 WGv03U3CvmGKso57IIi879FtLTDOiN53h5AjFqZebA5Hvl28zHp8WJh71nzrm8+GRujlX
	 vfh2UxcJID/RQzchbogYvALPCBGnQn2tFLDTRxHWQdmx7AWDoef7s8heHw8jGFa0KrLpy
	 JKml2APzsobzdBQDRrchSqpkIpljIkINvzLI2Vzp6Ndv8QD/cC8bDFPEoDu4lireJWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U10onaE+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F16606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 20:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19F16606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U10onaE+
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b86fcbd647so3330208a12.1
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 12:37:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795293432; cv=none;
        d=google.com; s=arc-20260327;
        b=dzVukRTD+VU5wXFaQCyZNQzsFf7lKgBupzAPW9TJFdQ9lVmrZyc+ToG7kUQjdNWY/U
         TmWNoZwS/F/fJ3ETQLM9Cxan6ZldbhXB7R4qhHt9odyX/D8ug89KiwbPSEa+kvLk7Lp4
         EKtofpXG8t/PyXX0XSMXjs+gc+j7XfjBMgbwU3v+gjN0NSpYGAlDTqoyTP36np4EbWqg
         KCAoEg67uySW4ZaLl7w2Vk1XBqlnRFnaehshZALZYgOvKUgZh6JIY96nWFOFQyue6MS2
         mbH3F/Bzm04JXsOZeP+woHg2y5911B555rhgR+RZxj70ahSLz6wGxyIzUIFc+nwE9JCF
         EBYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jMezZ3xwmkxlc9w8IXbimBosbsKo81k/sAwQFdOukjE=;
        fh=Ga3fZ/f/CL8prFPNonpbKk00fBdV318PaUcVHr63qfE=;
        b=H6INWmFVjarty+VKhQHrVeRtRTpmwAQh9VQR4yCJpGzWus0FWyG2pd2AV8jWCBW3Lc
         dyk8x4RgE3d1RpM3GggWW/gkqeljFaNYaPgR4pnm4BgyfUhi1LypL1o4Ty0dGREsaE1b
         GRPCtSjQmvYxI77TjauANT95zP+jQghUCt1olvwCJ5hoNTrhheEvKbeXKVh3dHT+TQJa
         TObjrfs8+YE0SxB4Z8x9SiBd7GAKkM/X7zVC5M+iYnGYotVjhSrSlSw2EPujwD/fHljr
         OyHCPOPaqEn4BPw9WAgLCzxW9pHL0yIfCDjb2q4s/66R1pDKC+f4hcrWz1yo2T+q1s2X
         jldg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795293432; x=1795898232; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jMezZ3xwmkxlc9w8IXbimBosbsKo81k/sAwQFdOukjE=;
        b=U10onaE+hkc0hs7ff4Z0hd6Fvn9A9WM6istM6sre+KlCX9v1sxOU1qYbYisQmPREWZ
         jSFyT8gpFnTjy7Rg6c0aZJYjch/3E6NHk6KtnhWxcLl+1HnsWAagpgyzSkiXCZDIrLt8
         k44RTqsZx/+zfNe2lEfgRzFSDnueozwOATCQxICb94yk/7GPcjiJQiahDUbqgTt4dai9
         FK0HrOevKB+VfLET2G7zYOmH50+g5hozyDVg8HFjo5MpKQKYJw/rDh9/RAAz8mmWTRMW
         xT5YhpX1d46WvQ2h+zBDKOyru0y0/vYV1Fa/A2nLnjtTr6e9cK7YfgEsx2ohk6e7tItp
         0bxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795293432; x=1795898232;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jMezZ3xwmkxlc9w8IXbimBosbsKo81k/sAwQFdOukjE=;
        b=VgdYMtLwxPw81N1Y1FTb2bJAZ3P2mJbwcPNpacaolFZUqAvQH5HZSxsoHLfVJbUbGX
         14ggw3HVbeSQBFBnNOV1R0AXEY4pkGBKEfZXGu/BSGPkUhciWEVUR4Xjx2HK9O905E+3
         wYI3TGmUN4FsZUexh8NRAsbuzyHzNQet8JZZlMIVdeq3GHfZAJoEzvUxxINMJkdScSNO
         OcYI7LbWz3x+3a8zUJ/QTTuogu8UDg0lYNqwU07fgGDQVCoIGEHRv7r4dGZTBTlOlr7g
         BVRcGL9qICK0Buj30BfPyi51Vqo2kSfvQThNTfctQ94vXS1b0DbfU1C38Dn39FtjExHJ
         yxGQ==
X-Forwarded-Encrypted: i=1; AL+hErGfS/CqUMckR7g6CVNANrAUGQ/ibjh4ye2+gePQb2rtb4E/zdjIhCNZsDc3sAe6yc4rbU8=@vger.kernel.org
X-Gm-Message-State: APuU4Z99FP+m20JHZnAzK1bmMNpjAlHOA8p0BxrF0L4XboIqTFu3YC9o
	t3RV855ib0nfKF/EK5cGrTBHgBxLcm4jOnQjVcX4RXYC7GKe+nZtPJsgBzY21RCGxiCv1+jF2a+
	bn4GvnflYu2Xw8KhElIK+5YEmqqwUlpY=
X-Gm-Gg: AZFdTZcegZWDwkpUnMXsiy5OZQ5O/qv/3rYOgAKpgzBv21zxSBE1xQP545a3Vxkh6Fh
	62oZgvl5u+Nft56g+NfSuanVJVLRKlCvli5cYIfO4RcGH9BJW02HL6yU5Z6VyuLD/MZm/hNSvdu
	GXPkihDxi01N51NPbducbrrvoZ6heb2si705A5WM2Ntahtrk0wWSUGqkHi2+xzh0v6y0MXVgaNU
	GqERzPuXhKNSHxnspPmDCGFH0EWoG26Ds5Z8VmBye9XdXGrRDcueg7qYgyzm7S9qQ1uzCmhu7Wh
	4N8hdL4joQWgwlFBqstgVRxwNsIRd9WB80DUPIyabhAJ2RxVL/cAMfvyoVA1CjswWYl/FtbHYPf
	sO9l2Buh0Twk6Z84JkCWb8pItCXd7tzRzg4cPf+5AyfBahxcKqjpxdWLnMA==
X-Received: by 2002:aa7:c604:0:b0:6b7:b9ce:1de0 with SMTP id
 4fb4d7f45d1cf-6ba37e8a3f4mr3350914a12.11.1795293432246; Sat, 21 Nov 2026
 12:37:12 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <pull.2425.v9.git.git.1795184664.gitgitgadget@gmail.com> <c4513f9ec1315c34b7a75b95bf50bba59043c274.1795184664.git.gitgitgadget@gmail.com>
 <xmqqeccfpacc.fsf@gitster.g>
In-Reply-To: <xmqqeccfpacc.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 21 Nov 2026 21:36:35 +0100
X-Gm-Features: Aa3M54pG6_xn-ghtL28Y9OQAJP3SpPFROzZEthaqDc_TOLIFnQvW-YISuqCgUrU
Message-ID: <CAHwyqnV3Sh6DznVW++_BOjOKKLqTrDAwKXzfYtRdp-Rk75=OBg@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] branch: let delete_branches() name where a branch landed
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Jasper Mayone <me@jaspermayone.com>, 
	Tuomas Ahola <taahol@utu.fi>
Content-Type: text/plain; charset="UTF-8"

> I wonder if it makes the code structure cleaner to follow if we swap
> the order of checks between "are we doing dry-run" (which is on the
> outside in the current code structure) and "what is the reason we
> remove this branch" (which is the inner if/elseif cascade) by having
> these different message templates (currently a pair of three-message
> sets) in an array and choosing which set to use based on
> "--dry-run".  There are of course a few things that are done only in
> the non-dry-run mode (like removing the branch configuration and the
> branch itself).  In other words, a code structure like this
>
>         const char *msg_templates[2][3] = {
>                 { "Would delete branch %s ...", ..., ..., },
>                 { "Deleted branch %s ...", ..., ..., },
>         };
>         const char *use_msg[3] = msg_templates[!dry_run];
>
>         for-each-branch-to-be-deleted {
>                 compute if branch has landed;
>                 if (quiet)
>                         ;
>                 else if (landed)
>                         printf(_(use_msg[0]), ...);
>                 else if (remote_branch)
>                         printf(_(use_msg[1]), ...);
>                 else
>                         printf(_(use_msg[2]), ...);
>                 if (!dry_run)
>                         remove branch and its configuration;
>                 else
>                         what is only done in dry-run mode (if exists)
>         }
>
> may make it easier to follow for readers?

Good idea.


Harald
