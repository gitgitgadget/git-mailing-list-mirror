Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793784977;
	b=dtyTwAfai9RxnQfSIsU6gNwgk99Mmb+RksqxPVC1opLngH6SmEYJZMP5IV/SBqP2GRj3
	 ABtOTwMFxVPa8IfDIOu4siiq9nvJ4vsFdBibsRqtGz8MgUmmskpzp14mdHeqaOJUTyhud
	 0icg9zcE5b2zthP0IVB+/61wOfYDsjGPks4soioi5d9pDeNeILgdavyIUVA5J51FiM7bk
	 MrezVsFe96O1lvSNDuueSDechZv3fx13GWqoQVKkyYSh3LE57JUdbsveS5Pjgn7Z46dLI
	 /c2E7u+Mi3Cro1Sm0tmi56mDEz2KxkM7d43r7GFruKiwWpYlT+jn81g+Y93z8McGAJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=aY8YbIgp0PSr3nCvgj/iOnJxrPcyz4llSOkPJf/bP3k=;
	b=FOLyH2nsRcpj8PbD9uSDESrVsaq+mLEnyaxsbz2NVAzgtHLGcUmBVij2TQGm2VcijFO/
	 iLMNG5q45L+YS7BI8YCG+ReVPaTh/zd3M7MnKf7Dtflb9pDNKOtA0gYxkeCKzdTPpUyDY
	 uY47AKuyjuJfeWaCrwJlNs3RBZopnGlgT9hVu9NbSazmZvjnMbKOtFROsbHTEbaidYkYD
	 AXoUcNsg6l13W6WtXJvShmiGuvJvQ6t6aOQUqDb4QdqI8qusbYc7WEmnZOfyFJodAQBp3
	 y5VRCebY4hczWbhIn+rdBl2g81WlOg7SMlm2c1KqJYhWTsVnhVobOBBYR6+iozDv+bQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l8h2WyGP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AE1606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 09:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68AE1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l8h2WyGP
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b2fafe2812so4276327b3.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 01:36:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793784976; cv=none;
        d=google.com; s=arc-20260327;
        b=Ebfb0N8aV9p5zdRyXSsv4MlSDGzymXdJsuvZ3k6iF+a6YiuQcil/eDY97i9gPAgQWH
         gG+g0ZESCS+oF0adrGf0Fj1UGpKuOn3usg5N5Owf1ricwr6EtZJ3b5SfSNSQU69E5Q+Y
         AIfkdCF9ZfV8fu5zm7VOvOG87zZlLtZLvaLb9zRha/jNkY2VMBpLSU34jSOyN5DslgMv
         NCpDinbf54KgFCh1TMousenk9U7qH/cqKpDWKCDitHwooMauJNahHJhtg7uW2XAlixTJ
         MUXvGgMuL3R8dx/uObOxafEl//Xe+Mt41UpmI+y56IoiQwOZpJrHLEit8xO+SRyivo4g
         gqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aY8YbIgp0PSr3nCvgj/iOnJxrPcyz4llSOkPJf/bP3k=;
        fh=KGSfTkwf6H4hgoHPcpIkvLkK+JPv1ULiyzHb+Eo8KDE=;
        b=eSi4/b01GRawiF6lt+WMv4+7F+DX5btV05h/1dr6SuhHyR+caKRunBae2xO+vPi8dA
         gBvkOgrWc+u8ObG1Wq+9SjW/q2NVafRq0FTBlB497EZWrZLyQVZ1rD9PVRoejJ+0z6pH
         4Cvv7Kh0oFa2ggh/U50O0hkCmnLR6Yym26h/kkmkT7w9gg0NB0UQuzWeloYxMXurFlVI
         C17kpvPmLQAvKzzC2m1hjC/StBq8Cuv4duffYckbKm1lVcG8QEPuM79JiiC4tlbBjlLG
         KyQZxqIevPJ/vMec2zMjgaCYB4+QeJarLTBlGrfGbq6zKyMuK5tiy5xh6AM8RLWUxnJA
         QR6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793784976; x=1794389776; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aY8YbIgp0PSr3nCvgj/iOnJxrPcyz4llSOkPJf/bP3k=;
        b=l8h2WyGPgDYMDiKHb1OnQNpW50el6VLZC4PvLz2XOYNQ6FY+oRe5aZQ/SHA8MwG73G
         YM076m+xLkwSerlLUlNQB81IOxGFQdmqpbtmawMiaxry0fah0qsCQCLEBUooLykZUctn
         WCNAJTjw9J17bLE6hbx9e9kfAZUWF0Daxd5mxqXGhr/R2A88asZmyxXVpxe3++98Y2Zo
         rfbeKQ+q2++obG70UP+jV+B4ts9ay6Kv7bu16PsbIMDDT1iNqhe60Z6+bw7v8uOF9b0r
         9OFJ/uSSVIlKa8cCb1WHTpU32cgV1tpU0Wi8BPobu+xa97psNoBkhqCyQmgn8jp618Bl
         h2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793784976; x=1794389776;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aY8YbIgp0PSr3nCvgj/iOnJxrPcyz4llSOkPJf/bP3k=;
        b=hfMiTIMuIMaVvODHao5z1JSxP/exTEZPBXr+0hQPvu9pNTGjYsiqU4QcAadFZCYuAp
         n5zSEpa9mmttrEkYicUJwhGSpO59ykQj5dfmRJdgRrEmwOncdyeB7Pi7YR0Qy/0VShxC
         mPw3zXfTm9BAxNle+8MwrFBlUdbprTrlTshleQrIKUXRgLwF8yjgtDzpnLpJVRolAIZN
         2IFRDbaL1O6STBnkeHxC+uzdNFRJkUrFY0dRFI0CyQXShflK1TJKOdMdONo4ebot7Whq
         WrCMcNcm38gzZlU6z3s+/487oiK7WsCW+1Tce2G0aPWLTctRp/VBjy0uVBQIflL8VK2j
         RKYw==
X-Gm-Message-State: APuU4Z9Tz9L5/YJLIKIL5y2X1bnKK4ohBuYl1Mr1CgYy3g8TcnCrlGY3
	DQrt40Yrch3z6Riez0KzQn4+ryw0+y0aQ5+YXcfRorViYSp9mToTZFFvBYFnI6jJs7+ZmQDOTRh
	ue4x4ckD8o6uHLT0YVVS6D6rvTnQa+to=
X-Gm-Gg: AYBFou2Dy6bLJYptl3OCKXFR5v4m4TfTdy/nzoT4J+AUq6FKJ3jKG6XKI3F9hrADTr9
	XqibvU0HLAPpw4iyeGEgoQkc6eTi1phFlqqCuRJ9K3PdtfnS/jehRDrMJjLZnSgQwqEha0LXQMm
	q3/zUFEJXQFgh/7UNi0qkkOkb5+wD32LkZe+KmfUlqbRALRHlE6eANupM8CbfQPOeYs0dQBQmhe
	fBOF5NvrwHqRd9q/yT6BQW6RLvvrgiWwLLqtQ+NxY+yqPPFv5LkzBGBAFAihML96dxoPJclSfrC
	9B9NsrUhgGEJ9oxAPsp2TelrHkad8TSM4E5PzX4stWmLYslzKFezYR38xE0oJgfA+P3hFzjJeJA
	QRl2/nTN9vF94V15DcqdrFuRG19UGbqT1bI67QJnynmC+E/B6xQo45XUZjarikMi39oHzJRV06r
	jvAuZV1sNsrGQxt73hHI+8bxXBVizDULL2ep3tF/o49ex9GC05xFGGFqixpniGE8P69/SuiuTJf
	WfH/iQhBESMluSaLATc3tkw6vxfiA8y0riNuMxc
X-Received: by 2002:a05:690c:a849:20b0:8b0:e13c:2852 with SMTP id
 00721157ae682-8b1c668f472mr94844597b3.7.1793784976196; Wed, 04 Nov 2026
 01:36:16 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAG7jffznkS4K4DGmHYjvzguWLTf5srip2eJz7B52TXE3XZwoSg@mail.gmail.com>
In-Reply-To: <CAG7jffznkS4K4DGmHYjvzguWLTf5srip2eJz7B52TXE3XZwoSg@mail.gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Wed, 4 Nov 2026 10:36:05 +0100
X-Gm-Features: AclHuK_XjU_Fszn30dpcGCucD3udj390FwWOBhbnXYaHSva8gwiu82o11DMVgkk
Message-ID: <CAFpMFfAD+bukn5esLRC-D7yxC6=7DMBaaT3AH4pmS0+NRVq85w@mail.gmail.com>
Subject: Re: [Outreachy] Introduction: Yopa Nelly Promisor remote fetch ordering
To: Tatchou Yopa Nelly <yopatatchou@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 12:43=E2=80=AFAM Tatchou Yopa Nelly
<yopatatchou@gmail.com> wrote:
>
> Hello everyone,
>
> My name is Yopa Nelly, and I am an Outreachy applicant for the
> December 2026 cohort. I am interested in the project "Implement
> promisor remote fetch ordering," mentored by Kaartic Sivaraam.

Hi Yopa,

Welcome to the Git community!

Before picking a microproject, it helps to search the list on lore
and "What's cooking" to check that nobody is already working on it.
Reading other applicants' patches and the reviews they received is
also a good way to avoid the same mistakes, along with
Documentation/SubmittingPatches.

Okhuomon
