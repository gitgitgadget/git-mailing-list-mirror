Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C62F23E35F
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782060102; cv=pass; b=spHyFK03HWcNtdygThkH9PRuIcAWO6B+58v2w+uMDoi8BlMF1WN9DF8pvPCUXWTOI2waUijoBX+H3j2N8FHT8F5eidoh0xanVTxRpx8OKP2QvbTT7Q7dG2boP4hF1pnRh9raWud/aaUGR6zdsOM0sc5Cgzm5IldzQQ7eFBhBjC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782060102; c=relaxed/simple;
	bh=Q5nMMAL/5vm694jUCgkUg8+PnoATeJcw4cLfRVVtmGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZQyD0VZM+dU7hH2VxVVo8g8XbgRjVq5GNahzFhrtRAfHbdVycbsvDCiVQl5ne5+0iC1VFEDddQJtDjWhOVrxgOzq376CTmLiYig05SKTgS/CXrAxLcJtwYHsb7wX0HTeCaMUkxAW44kDdsRYd4Sfdekl2KtmTabBi7jE0aOaiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qre7CsfA; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qre7CsfA"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37c867bd3e0so1683933a91.0
        for <git@vger.kernel.org>; Sun, 21 Jun 2026 09:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782060101; cv=none;
        d=google.com; s=arc-20240605;
        b=dCR3kgrBeEVVeji7OmvAQNKsg7eYH4Q8CmVQGdRCxjHL0vnhKOgLW9aMSBzq05naJX
         adq9Vr++mx50GhdKxraeF0jMnZ5mMKcgnvhUeNMQAgDi2gkak4x1cnleW/rC+YMxgrLK
         T90BCb64iB2SnQyUlKg2Tj6fx3kzh6ET2sLmBLToZPl7TRo3KGCodhlWoVHuSRcCnVDf
         u+rTob/Ube6+vcqOc5wWrDDMxFuOqHJ73Gj5oKXYu3cCxCQDpce/Q3Nq83kkaJmhNaqJ
         F3Sq9vOWM64AgavWwylrwSNt4g7U1VGN0RUCYdtEDoM71xIVW58FIGq38P3NARewyQAS
         RY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FsP6RWn7/BjWspltKq1+rmrSF2mEOrJz3assGFx/Q4g=;
        fh=in+81jQ9xjE0SGm3xC5uXakBSuvQziTe50ttBzvjUtQ=;
        b=OZvp5LjUNMuAVJ/Ixf/LdkIYuPuzmasx4S8fBOcxJpAevMytQdPg2MSFyzXQ9etp+s
         xHU+lv7uXHH3OqHlPdXkhDiNKgOLUeKJg4g8/7xdzDbA2UGfu8nJOJgu8w19VOw69Mkz
         Y5beL2ishTl74bwwyI19c+TTrtX42AIvIWd6vYYtUXmRRJXLxYt1NuJHjt0Wo75SCNU5
         KIkEWp7qXaSvQatKk4PK4TYPhaTl9RmETVY09xZdd7eXIFoZ1NGlDTO3L1JQUzT2AEVb
         qkPkhppGsY88VhDF4TQGaz+sS2ju8G15YYzkKwLW5CozXfvz4WXSq6rmYyzbz4MLVf8R
         yhWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782060101; x=1782664901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsP6RWn7/BjWspltKq1+rmrSF2mEOrJz3assGFx/Q4g=;
        b=Qre7CsfAob/ROu2NUKs+pw6gp8GoziIaTb/oa5993BgZz9oi4Xcr0e4WYK6sCva1E6
         u89WxvlPfN7XnXRMBpumtHlqljjnQ865qm5vkKEKDCeo1YxrDY003j/BqlXYMNWAOnZr
         ih+9dOl6nWF5SRvhKIcsX75ek04+JSGc0QLCzq3R4Ap2GOTeQrlsXqVYuYY0SOzXLVb1
         cte49JOLjVVXXDEeUehFgF7eHtgcoTExzdeSYqwii6VAb+5nMZPXhmLG6onriABT+Oqu
         5Q90x/ORQiuNFYfZqiu699SQWZYBS7wTsbWGnfq8QZmQeMgRwxuYYxi9anyE6C+D6Xdn
         XbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782060101; x=1782664901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FsP6RWn7/BjWspltKq1+rmrSF2mEOrJz3assGFx/Q4g=;
        b=OeXIx9Br156gsUVY0SIkCYeKeQNMRhXJoQVfrziKJX1PA5vkhTQZc+GVG6vv6i9t8+
         SE4fd4v24i6vvDsIdLqDvafckJEC6nEcDfm480coVD41L64m1OA4tJkxvg5I9GjbQMTz
         /xs6eN9+AN3hxo/ELSaF3BHVNAGZwWB5ODGl1B9Agb+ZP1Jwtx6S9jiuR/otBrhuvPVq
         NZOTlU263aUUbckUwmMjTKWRci65kfb4gt+nM7ruM0Vpwflc+bwjog/CCbuLF7xGBT61
         NuEmA8TpQXIJo4r93TWY/2yBtNXzBLmB7xdK57CfeMjFmDVZB5Sui37PaazO5loJhUYs
         E2jg==
X-Gm-Message-State: AOJu0Ywsrcjyh4G4bsh4srt45KfwjgvDdlf6lYTVyiIr1WBoM1oaM5I6
	ewBzbHtS39UJxac18o68REBxbk+c0wmBRg2zNkpfkjYzzWNpTtEgIM/FmS4lES3ii8wkq81UrPT
	VvHh6hlNLsxvJkEMX96Rxgf3P9lPa3Kg=
X-Gm-Gg: AfdE7cnAVItyMAktPhXIU0UnvccIETiLC6id/SFWOIYiyAxcb3IQsPYy6V/Ot8fpc2y
	g7JOvMi6HZCUQJ7/lDi0mRqbUwwmvhYCOyDyy9kP7ZNdP4J04JMBkNxSUpv/7fbT/+jO2aQYKfk
	lNyqTii2SS/5IEylqU7WLfVkN8zDVmHxb9y1tP4fHtkNZOLPXAIoYefE/49MF6nwf9Q/wny79Hr
	h9F4CCtIFoIgewrTun6xuqW5CkkqZIARj8t2hGZWIHe3NnP12zOtGvzBNz7qk6fPOXdKGBz2paX
	FQufrAP0zCDyXySYHopudCKw2a02uCJtBMI9Hib4TCQgi0QQbxqNgDHA9vu5LSexr9l20A==
X-Received: by 2002:a17:90b:274d:b0:36a:8240:2477 with SMTP id
 98e67ed59e1d1-37d15e8b6bcmr12932028a91.19.1782060100879; Sun, 21 Jun 2026
 09:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c4c5ade901ff95b0f95939ea818870e4f3d59da1.1781971201.git.ben.knoble+github@gmail.com>
 <xmqq5x3cg10a.fsf@gitster.g>
In-Reply-To: <xmqq5x3cg10a.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Sun, 21 Jun 2026 12:41:29 -0400
X-Gm-Features: AVVi8Ce1xpxwo_FhPFGxMLYCy33FI-PDBgEqzCF8HZlEkoVp3N4hzQMiL-wqry0
Message-ID: <CALnO6CADk607yWsN8b5r_mB5Hg4rm0m42YxsHfMSgzhOLayhfw@mail.gmail.com>
Subject: Re: [PATCH] meson: wire up USE_NSEC build knob
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 20, 2026 at 9:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>
> > Autotools-style builds permit enabling USE_NSEC for cases where that's
> > desired; the equivalent knob is missing from meson-based builds.
>
> With or without autoconf, Makefile based build can use USE_NSEC.

Thanks. I almost wrote "Make-based," but I wasn't sure how we
preferred to describe it.

> It
> is a welcome addition to the other side of thw world.  I do not know
> if 'meson setup -Dnanosec=3Dtrue' is a name that is easy to discover,
> though.
>
> Will queue.  Thanks.

Agreed for the name. Alternatives welcome.
