Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059CF2F8EB0
	for <git@vger.kernel.org>; Mon, 11 May 2026 00:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778459590; cv=pass; b=FbPgmCz9Kc2iAp5HPYe5g/RhUwGy2nfUWae9DODOc3cUXEdhHmJHSE3GARYmYJqLga8BW0frXoDq3VxQWAGaBRboddf7eRnvnVnw6wE5lyn36+p6PN67OrZdMaqsWOMhhO1gMoPJRSbOH06pkrzUYQzjbfuiPh0Mh9OdFgjQPKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778459590; c=relaxed/simple;
	bh=WC7TE+Ci2y4g+aMrEuzBf7jcPVexLulxFSfAoZrxGCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=htJQiiECoWrmskOQIoljKymmY0LAs4SV1FSnapHqyFTGbScdqzmCt+ProVmT8gMdz3aphuOyU85kMY1T33Nt4TcpsQmGSxIkGNMJ+T4F2Dx+27JYG9ijAHuffqrXtSQI7qACv4cnldcHyPffRrlSU29SIjJ9EwnYx/3i4AhxGm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXOvynA3; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXOvynA3"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-393da8f389bso35762351fa.1
        for <git@vger.kernel.org>; Sun, 10 May 2026 17:33:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778459587; cv=none;
        d=google.com; s=arc-20240605;
        b=Z84hO+UoJ9Hd/RgfzDzV0mb8dApBK0boeWU16zkXiKe08KmMr9FGe3qLX/r6IQ3LwH
         Miv+3Pnp/vivRHUrFuu4bHz5u8KOXFocYk9qOVkzBtiVYq8WUQy/AURjjiFuO3iRAn+M
         7N6AuSUbe+jK8Fr81Tvs7DWfAVL55CO52Yj67MD1rlm0Mcd25DS21CLnGu2pJgCcx3kL
         Y8OAbzfIux0dQ1ctBQ1CQofVYj1eQbX9gfw4NZ653MlTR+lc6Ox6asOeijn5A1wtLV6R
         ub14gc2KJoBI0uJyZqp1qC3qIdUnzTCjlowm5PV0ZXE8JMdjTYBm4C15xbkjYW7YYbVW
         Oomg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=88ObbYyrqdkXI/LhfoZUWWhvJyFx75HztwMZ3IVgMUM=;
        fh=DOj4aov6QCZNHIut7J9bRSVLpYXeERrLPgwttad+t8s=;
        b=DiPIktCkoHwvAPWIRkN9lFmEXQkOXbsF6VqPH9QLcVMebyCDB08X2nYoxyyijd+top
         6o1PIEM7Q3qw2NoENdLQe0i1MIU6JM4y7HJbxD41lNwDhLmxlsGu0v9P08LMsTn+XmOO
         MR2Fm+tHDCHNM41Bg9DC+Rf1u6yqTp+riaD1R2+fFXImk+OsjgUIaRE9jQcXIUrYuzJu
         7IWbS7jPhWn5zx5kg+ltcwB5/lG7VJQmDzJPjObpuqPSuSpujMR+n8I0netJpzz7sN1/
         tSVbEHHCbAvoGAMVBAbD9APp1NVFJZKxDN96IMvj9VHzH/zxHHd7CEot3jHi5sqIhtq6
         gigQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778459587; x=1779064387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88ObbYyrqdkXI/LhfoZUWWhvJyFx75HztwMZ3IVgMUM=;
        b=fXOvynA3Fm6iztj8inT5/NqGF05ZKyi46+FX50ce/s1km9DY0iZ3OyNfggegaimIPF
         XomWXMjC9ciPnnNxmDVV61RzAkEQiXmc6AkabzDqQcm5xlQJZzqLY6FjswfT0zFHoU1b
         SQyNWl0CpeNyD441Y2NyioteUD98yBXk2I4WwRB0pteAUxvOv/iHpKbzjLMZK5fxyUlj
         KGspHOVrhOuidlvIdgHEVQuthz39AGeg8T4RGw0RcUtrhD1m1uQ+fqObP9UX5GcuGLxZ
         Olip92zSpo/w09hUtidMMz8kKeEYhgWFRoQcpgZbCUfaJiM0uNlA8+YXmDOBhMCGUNBs
         gECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778459587; x=1779064387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=88ObbYyrqdkXI/LhfoZUWWhvJyFx75HztwMZ3IVgMUM=;
        b=Fat3Np6D1poQQStrEBOrcte4SsIF8p5mYzIvZRtaY0KBXvnP9zbGz631V/f5bKvcM0
         9QhdhdNX+uZagDAFxpcsIzCUWn3f1o96LWHqlV9jkHdWHiYjiiE6f3fUKolTXjkqIYdA
         0RRnJLIQN84sgHN6tlBIICY8N9sozclM0SqoaCvwnUKWOjUUTyugK8jQTvXYj3DF9dkG
         9U1GbJ9mtaEuyePeOYvmdA2BKMNbuJ9d3oTtjkTfChIsRP43mFhLyor2QamHf2+hbQ/x
         TbDai1S4nE3cdjUaN2ZavQ9WLINlvjOHSAESP+7KZhtekALsgBG2PMMuNVCjv+5TVQ39
         I/yg==
X-Gm-Message-State: AOJu0Yy1hFN52hOv1wnVxbmBQCfJdfL/2jsx1Ni64L414c8CMHYfLkg5
	qNy8kqfxKtsVjf00P7xpWTQUNZbTEkyWAyzM3sfGjCBo1Qqm7oVBrSkOv4zQ7keSGw50YRZbX9M
	DrmTtUKnH1eHY0BOMauqFUO9dv2DAtMI=
X-Gm-Gg: Acq92OEL3hmzEvRY+1WRlFpwmP4Ra6vPbBOd27tQuDeuT0oCMiFS3U9E0Gm3cw2wkm/
	Hzyu3ulTYCPnXpF3OKDR6Jow41uLgWYZmP2WAKxuU2m1VtRBM0muLxvyBg7sm+zUcY2SlktRfhP
	iURz3x7GF1wvsIvcnfckFietdsNOHlSUONa8nB0YWB0ypnCzKkVq3r+r4Avw8vOovMbMLeCEXRV
	qgNA4hYOuKhShW26PdjPiM5aWyjjTGnyOGuu2U1iycUjWv1vqeMNs2ploaXbPob61pj9Tj8EzT4
	wKDGv+oZ2mCXVN7gxmGpVaiO7EM31KC/Tm2QlAuejugjE6qHZeVQB9VXay989HOLaIubtU14AxL
	G4VIxx05hL6JlVG5fzWY9EE9JqwS91cACI2wb7b4OZEYCXmzhy/lHli6GX9dviz8=
X-Received: by 2002:a05:651c:995:b0:38e:9638:d718 with SMTP id
 38308e7fff4ca-394080971afmr26330621fa.13.1778459586886; Sun, 10 May 2026
 17:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-document-log-no-follow-v2-1-ee7bcbbe612f@gmail.com>
 <20260510-document-log-no-follow-v3-1-d6d3368c64bb@gmail.com>
 <xmqqik8u95yn.fsf@gitster.g> <CAJ-ks9mPzCr3obAw5cE071GNjzy_ZLzF4mQdnUbQY5H4WPw3sA@mail.gmail.com>
 <xmqqv7cux0q7.fsf@gitster.g>
In-Reply-To: <xmqqv7cux0q7.fsf@gitster.g>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 10 May 2026 20:32:29 -0400
X-Gm-Features: AVHnY4Kd2ZNd7uk6wVuM84Z4Bb0Q32SvWnaVxSKdzRLmjNhODvA5uQ-qtd-ejL8
Message-ID: <CAJ-ks9krzLO_+O74omAfeVByUBh=rDGSVSarf5PGwkdWepzubw@mail.gmail.com>
Subject: Re: [PATCH v3] doc: clarify --follow and log.follow for git log
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 8:13=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Tamir Duberstein <tamird@gmail.com> writes:
>
> > I observed this "undefined" behavior, which is why I started working
> > on this patch. I think it is not reasonable to deal with undefined
> > behavior by pretending it doesn't exist. The documentation should
> > acknowledge and explain what happens when this option is used for all
> > ways that it can be used.
>
> No, you are misguided.
>
> Undefined behaviour can change without notice, and users should be
> strongly discouraged from using it.  Describing what the current
> implementation happens to do moves us exactly in the opposite
> direction.
>
> `--follow` is a checkbox feature. You can use it "only with a single
> filename on a linear history" or all bets are off otherwise.
>
> That is what we should describe if we want to be honest.

At the very least the documentation should state this...?
