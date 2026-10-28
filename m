Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793181548;
	b=1c/Bk0KKUfHyOBLLZUBdDzcyQAXJlGlgdmxeiK6PxXzFvgxbCMWJbWwV8yvyFwBsk3Qq
	 jDCownyxtlQxukllQgmhlUcvJmKb6X0lu/ONLE+lXI+tI+MX2xlhS7fnk058NP2WVviqY
	 yuQ/rlLK74twqSyJ7jxdRXNl9QRKsUPqHcFA/Ekkp/ozara6Yzep2jv8VfWjWSIgSfPjB
	 CkdkRXvbNN/DOrCvE3/qB0Nfj3KG+3CJyhcWOhu8gVGyvnYlrkGmRpfs9X6ign8GcyYDB
	 5vL8lRrr6Fw3DsPhriPBXeO22Xq7w9Y4wXMxRmtuH9OOcYytmk5VyBVDi4Q2sA0C24A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=2xo888BG9d5OENvisJdxW3K6r8TpUcxSGZmPbVviN5c=;
	b=A8Ds9oizCiTDiLRQqx7ASfmkXzk1VaKcGoVRm8hGSJvTmxbvw370WgZ0v5UvZdWRWr/Q
	 nkrwGKN0Z1CNyUDwcUv4yggNvjsW9z6Ga/9JKmv3mWLAkdVH+rtrnHgfZX6bhXozUpvQ1
	 /GS09EhohQzaxpcttXUXGzbBZlleh5YEJ53X/Niu3XSLnmU201lalPl5seUZwO4+HIWI1
	 XMeD6qprFvlPfxEmV5mVA+vo43L5Gcmm4xh3gl4gCNvUk/hlyCXaytfdQqrmzIsWa5+Su
	 ZO0KIrOQ0DU49bV724jy+YKf2dHz1u8Uj6IecRDg3YwRGpODfviWBz2Kz3yEadUivhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dw7OxtMt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA4A606A324
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 09:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADA4A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dw7OxtMt
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6afafc89b48so1356715a12.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 02:59:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793181546; cv=none;
        d=google.com; s=arc-20260327;
        b=AA3Qapi8HfTjPhsU4y+p6nEnoS7UgupnymSp2CVsoPcL0PbMLbLlvFhM9ptk8X0MAQ
         JoDuiushTB5O7oWQwFoF2u/fGfqN3AaGD+KJa5XqMjpmUtqklwhr8QZfHKSoPBcqNzlV
         M6kGmb9K0bhZjohXmds1DT9nFecxyu4qPfairHFrzndyAv7sxe9fOSY5T4zOCLzCIt/G
         9F3HGcVaiILFtcRy2b94jxe30bKO5yD140+aO8juJfng6Hyc+xW1iuFYYZOTTzt4VSDT
         o0dfO0Zpv998D0PKt3WNsbaMIl6xrWppxiacj5Ni4DoCfsnnamu0WZTYCgQBTNQLEJpb
         +4mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2xo888BG9d5OENvisJdxW3K6r8TpUcxSGZmPbVviN5c=;
        fh=AyHon53BQbowG6xmc5TFidnVnBYCra4EfKEtk2mOkh8=;
        b=GSUpPBFjxHLBRSC0Nxs2McjQ9YOid+NWolyTAL+nSXU/+uUNQ8Drt/I74ZnTLNzr51
         nlXiCjA5CTn8n07kFoR6cXLAcUqk8OQ2PNM5itRis1JR4P4hX0HHJyX/kvwijIqiLx0+
         ptVKba/L2ZXdp/BbMzoYknQbv4iPP8B20Rp9U0XPv1w2kMEeg92FLY1C/q9ENHJfdaW+
         DlBZ+Gw2iTkvluoDacLP587LUoqVw07pNN8I5el9NIMq75FyF2cR1Ujdfu3RQLFreRER
         jRATwObXbnvOWZOiRWEqGrUEh0+XojPN7SIN4DaHhd6PttIJtm6KMZQKh2qm34++AIjZ
         ltsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793181546; x=1793786346; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2xo888BG9d5OENvisJdxW3K6r8TpUcxSGZmPbVviN5c=;
        b=Dw7OxtMtcqWm9Hf8LDpzOP9MlzZf7FjvGK9jHafg9iUhI5u+BPluK5CZ4MigTVzC7r
         dkIrkvU74qP9i13xP/a5o2n+siHxTD4uNdcjeDFpC2JWaR8EDgxkNL0qLq3ugdfphbDu
         4cPFz6yMN/iu3hxLUQWWAbwBXWAX8Kwa+RGU3fC3i25xwKpaCEoschB8+zNou1fCms5u
         WFaaQAUH+Hun8saBlAa0MDvkSaugemyq2yC8I12c1WWA1aNPt3LmuScSLIhCgVmfWTYv
         b28jzo6pTNAYuxPrOmNskzEspjnS+cjq3MVlsZZA9XDKTLPtNb7as1/2nckeLNnMZv1r
         UBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793181546; x=1793786346;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2xo888BG9d5OENvisJdxW3K6r8TpUcxSGZmPbVviN5c=;
        b=CqlCznVwyS+YETe4ANTDD5+PE/Sl85sbtdVb/AN01RpoRMWRb2yY70XwHWssunHPs2
         a+oPX1yC7y3hlsfr9KMT3TspZVCptN8oZdgb/UKEzbd1AfyKcen8NvAXRqSQDFYWPtGE
         FCHLRSIj35qxsVqP/47PXCqotiQdSE6zKh4dmZSxMkq1cYEP8Nm2fAg6/oaxl+uisRcd
         mJ3kRaFxZ0xdvYfI/jgRMJuCoMG5OlU6tsZj2+5LAf9nAEgF4kvZGCU8+TLDo63tzrUe
         rTVgg3Jl4cjpwcnY0TKqYV+sQQ1LKt8z+LsjnBLgaPgu0TInQDJwsaWo5l4PTEA+8cyG
         DLZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxi4JNn9dHWHPRe+bkcv1r7REXtkBD12b2PCmcFfTlt5cDcyEsOMDwAGdC8cBnJSi75V80=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFGkYHrVRWsgfgg2DmTWwoAttkIH4ZjCPzenc0eX0Z15ibJJ9R
	jbQxqdblACkPW0ziZUdQa2prWfuZ81PZgtsb3NsRLfnFCFsz4QfuD7d1y3Bb3/Y6zt/PhzvajZk
	OxLu2huhi3avPv0JNsHTbPcpkwj2R4LU=
X-Gm-Gg: AYBFou0S2GjzL75biQiETHNnwHABGlr5QXm2Ja8svncReJ9DlfUS241aZOdgqqoapdK
	MEXev8DhIAswihVT8W8IpBc1+xNv/cpcq98QZ8EWsNXEM+fLjkZ3LwoiEPA1NmCc/6WiQedsz9r
	QC8NSQMhnWBZxQNDzQAYgc2yRFSvTsTaDFUOkhyffgoWb08nQburSY3vesKTtMx2tY1gr03BbTM
	Qei1M1lBxKQUjs+zVe9A/W+5HcXsbgif3wM/5BN8Lo9WWCLOiqhVqsfcfXDdyO0SRDTzWMMq3Lg
	h3Mimxbtqz2iRVxNDBfE129O72ljpQjirLKq9kui2TIKULI86QN6IzDCSmcHqtIj5bpT0/cb93v
	13HYTjJmF+RooKfAJTAIovQymaRlmYzYVzN1uKGyErfVsDdzA5MtuEPnIQ8hj+iiZ1Fx/Ag==
X-Received: by 2002:aa7:cd49:0:b0:6b4:203:a183 with SMTP id
 4fb4d7f45d1cf-6b49cc10d44mr809430a12.36.1793181545826; Wed, 28 Oct 2026
 02:59:05 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2464.git.git.1793104847288.gitgitgadget@gmail.com>
 <579C36BA-1418-4E15-9CA7-70C752A69FCE@gmail.com> <CAHwyqnX3sR9YxfK3NtPxVgmTfzfbgXX2bzPKzGGAbfC9k1iF4A@mail.gmail.com>
 <CALnO6CDpsQtAX0rHr9Cuot08K4j_6WMpiPOKA38sjDbWB-wj7A@mail.gmail.com> <auGln4usFADtcUPB@pks.im>
In-Reply-To: <auGln4usFADtcUPB@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 28 Oct 2026 11:58:26 +0200
X-Gm-Features: AclHuK_XCyJIlVf3W5ue9m-SsJGY2kt_KGsmljtDr-eiGXbqoZuMVDeqhhT2IpA
Message-ID: <CAHwyqnW8kx7BmGq99twGfC2ZB0u0sj17345dcyZ7sxw8A4ZZaA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: let ccache cache objects built with the
 precompiled header
To: Patrick Steinhardt <ps@pks.im>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > > And, what about Meson?
> > >
> > > I think it's not touched by this? My goal is just to speed up my local builds.
> >
> > Yeah, it'd generally be nice to keep the 2 on par though ;)
> >
> > I don't know enough about our pch infra, though, so I'll bow out from
> > here. Just thought maybe we should make Meson do the same?
>
> As Meson auto-detects ccache I'd think that stuff like this should
> rather be handled in Meson itself. I e.g. found [1], which feels like
> the right direction to me.
>
> But if somebody wants to implement this in our instructions meanwhile I
> won't complain.
>
> Patrick
>
> [1]: https://github.com/mesonbuild/meson/issues/14662

Ok, so I'll leave Meson out of this. Maybe I'll look into opening a PR
there instead.


Harald
