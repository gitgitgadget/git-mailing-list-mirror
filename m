Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D5D24293C
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 18:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533842; cv=pass; b=Px6GFBEwkjOypWKNxcxu6grSJgSiqMkOXUmZAuj3rLCndb1/CVVkcM20o2oSr0BDPC65ehtZPW+QSn8HXGRXaYz7bk189FAY1IWQdCei+NaTkVxDTIxgjBvRET0DK8SpGcjNcM4pDP5PhiBe2hqba+PdezbS4nFaFlnawocGB5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533842; c=relaxed/simple;
	bh=GST65JeTtM9hPEGODzfd3RmyK6OSH9X8ttAj6jjwXyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehg92XNxjOJbt9vM0Yaf+lLPGVrQ5xtFUK/CFgY1ISGq7Q863X4gZt5E5R1hUnw9AshIoPDVgcNooJ5Qg6M9mlwhCJyZsMtXtyp9bI4M6hOZWWlT9sUwCam3QBmaOsQu16ExQseq7N0kESqsy30CYlVRpJVraZRPLwOQKi5wtcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=Lq629lT8; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="Lq629lT8"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66666bad8beso1364131d50.3
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 11:04:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783533840; cv=none;
        d=google.com; s=arc-20260327;
        b=gYOIH5VaXyT97amRmceKUJ/KHQVy69jQ31eMylmELNfTsKDIxz+jTLkk1kUMoblt1W
         Fmt3bemjy5Ui0rUNWRX0t1H7zuvd5iNReVE2AONpoqiS0jBziiDS/MjkGatGdFNXuXEL
         JXTNM0417V/pmSldMRgoqhtjY2xdvXfcMqiH/c8V6czzmDn2v0OFUNt90+sqANP7F+pe
         qy0dQ9z+5wlbuArqBqnaouViwUHnlAykPUmO+o2O81/oMCUXCrxmwdqYC/FaNemskeLw
         dG0C4cwhSt5p5wzJEqZt0HMmHsoqqRM8STIZ3u0B5gc9KreMfXCeYK0DrjyL4zlNudJZ
         LzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2y6xZ6OsTOYH8/FdVIio1upOtnAoMkX4kHQRZqLTGbg=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=KQm51q7ISQsNliw+CJ+v719LfsVo0BLY7xa9WtoM9wjOR7fPx6CiDoz9c/MiV/L7/2
         7+URM1CD8rkc3FeIkowobX/JthfZm1lTkPHUgrxKKqrtfTo/Dpx1nEP4kkYvIRVs4RDR
         6M1mKU+rtXtHgnjyhKToCoTa62XGmdN6c/K4ubeTbC6qAai1uNQJoY+gYelxVjKV9I8h
         3nD23TlKdRZIE7yOrx+p2HC+ssX9qGjBDe0+wTmxAYAZYKwFV2PvLq9XsIcg29anpujv
         kHmqlKvl2kwhOErtltTG/R6+JLzaE5jmAzmc1ndm2JqAuXrzMuiCOoVQoBhkqTXgRT+T
         3DLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783533840; x=1784138640; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2y6xZ6OsTOYH8/FdVIio1upOtnAoMkX4kHQRZqLTGbg=;
        b=Lq629lT8aKRV8cSYTAevp9QnypNhSXpyW6JL5tMggwR6YLOS/CIdmrpdTE73WigEaX
         VQqAl8z/piCqKXEOpeKMWgfOFfcuwCjn4TYnYvWeN51XfE0e75bp81IvWwC/3u5mc1AT
         SEDFB0TEdzypS8rHTpZyNqhKJq3QeacOvBzk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783533840; x=1784138640;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2y6xZ6OsTOYH8/FdVIio1upOtnAoMkX4kHQRZqLTGbg=;
        b=sa84hTfF0gKBrio57zWUg3wgJKI/qBlBV7uLjS0H5J2nqRAT8CXOXIvlZ4xCtyCcgq
         ztP07H7/srdlej8QbxxNlVp4pWPhfcVQvRx3BPHPOzhiM5JIzPY4Zf64Tqhstc0xiOwN
         KNlDAGiDSkgP8BYHmSxIawmJP/po3jFAQnbjAMpQQim5vBjo5avs08cLIcbYDx4K2KuM
         blZoaiXudnCigXhzRjGfCBP2wcR/0VhWAaov3PfwHnzsnYM/hKVsslV4VnZMl/VtSQo0
         ZhcNJdQoHVBViIronwewSqyjwksMMOHeSDNjX1fEZ31LBl7Wdi3z6CAqr9wqkEQj2E+a
         3pVA==
X-Gm-Message-State: AOJu0YztBDukQ7yfhnGUPr0yC0NzGViAfecPCEtWB2TB8+ZoKSRrfC09
	CLpAH0cE26EZ7sCXlBARaH+ufObo5dRrFOXY1V7Zu8z+I7BSaJZVlJ545oESSUECEJu0ysFjSu2
	+MoJY9GjEjWHN0e1qwmFK69EsGiVBtuO6hwQop2Aq3MoGELDy7g/uBLc=
X-Gm-Gg: AfdE7cmTlOxk+SoBKxzssEvbViNXUwUYpYf5mmJjLfFDKOedKU2bjBK2338/zWlSgbI
	x6w5gGf8CceGZguRC7ytfd/w9oFPFTBmn4MMsLLrr4I0BBpemQay/FVUbA0NxKUUUo+cXdSl1Er
	gcxxN+0BgJEEoLxC/m+GpYGb6ArdwSTEV7jPQJNTvTQ0Pwk7eT1Ww1IwtCFEqKRG4TXAfX1smkD
	t8OmKxMnhHMpFOWGbIMl1KXkvZcEundy2Pd0i9FA//nxtDV+hVwRfDCKUP7KwApg+UAPKbt4w==
X-Received: by 2002:a05:690e:1288:b0:667:8b95:31b0 with SMTP id
 956f58d0204a3-6679f272c52mr2335308d50.103.1783533839713; Wed, 08 Jul 2026
 11:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqeche67lr.fsf@gitster.g> <CAL71e4MrQ25WJHp-08bTS2=y-gd36zs9CVYmYGeRv-6iCpdfdQ@mail.gmail.com>
 <xmqq33xtwj9m.fsf@gitster.g>
In-Reply-To: <xmqq33xtwj9m.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 8 Jul 2026 20:03:48 +0200
X-Gm-Features: AVVi8Cc8IPRIeQ0sG11MfGqmFp5iEAmb4ZukGnFxnEG9okFX0zagMcl4coT0W3g
Message-ID: <CAL71e4O+9MEf59XkC4iqPoxt4T6iZ174hWrPTDcjPoWaURj=aA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2026, #03)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jul 2026 at 18:14, Junio C Hamano <gitster@pobox.com> wrote:
>
> When topic A depends on topic B and topic C, rather than rebasing A
> on 'next' (if B and C are in 'next'), I would often do
>
>     $ git checkout -b A master
>     $ git merge --no-ff B
>     $ git merge --no-ff C
>
> these days to prepare the "base" to apply patches that belong to A.
>
> Many contributors mimic this and state in their cover letter that
> the patches in the series are to be applied on top of master at
> commit X with branches Y and Z merged, or something to that effect.

Yes, that worked locally for me but I think my mistake was
that I started off using gitgitgadget which only supports
workflows that reference an existing remote branch as base.
In the future I will try to learn the b4 tool so I can save myself
some headache.

Thanks for the guidance,
Kristofer
