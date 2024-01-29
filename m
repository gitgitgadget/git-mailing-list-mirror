Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453405EE89
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529809; cv=none; b=Gn/WD5LQRaaiUAPiqvDN1nrDBaN6a2rJ7B0z1JHwLerVjwHLpV2JMWNAVlhL5jA4IG8r2EVo+IxU5CIXVF8313clzZRFfgegCfxKjUsUy/YQ97yBlsOAAEdLfQSHa7vwD4y9b2Y0sH/Xa9woE6OPFcjcsNFt5MDhznBRaOHTYwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529809; c=relaxed/simple;
	bh=ynPH/WjerDgWsqrQd94eH34TwK5CAmyuLwsqItdQwXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QH5g8b7HR/TsbQC1UQSAPSQtGqRMjUQf9qxVHXfbLiJwqFFmHy2X+N8WLcnVtE17Ciakuovk0Nhhr3MzoRpwTj6EPgzbVourGi1OZcrzoVExbZPuzu5mIQBlUoZPb4QJN4/iEXRRnj6egz44EUdPsk+je/6GX50QhPYRAkCXplg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPAWPgx1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPAWPgx1"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a293f2280c7so264888366b.1
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 04:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706529805; x=1707134605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynPH/WjerDgWsqrQd94eH34TwK5CAmyuLwsqItdQwXU=;
        b=HPAWPgx1Z4C7eYKTkY9OliPfO5ohIs6Y4e/wMj+JnG28uwq9bQIS2MGL8w2oXgWTrx
         W4OZ9TLImhVMnLE6LlsBUmluU+dz32ldHxXjOYYe0O0Z340dIwvwIS1Do0QpZO81CPJE
         T+FsCFFSoxcq1IkOcXHaobYaHuOmix+tsvBwjwzRyFf5LGSnN6b/b/PZlQY/O9gTPGbQ
         cKMWxMYYEQg2owsJny5hXPIZPoYi/V86c/gyJdVbv7321H+sOt/aKreI+EUNA3d/ZMc0
         GHYMAy6R2ai1XlGx9QjcutUJGGn+RXojfrK/4mcVO5FXsk4gDJ1L9gGykqIf8sQyToSS
         yF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706529805; x=1707134605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynPH/WjerDgWsqrQd94eH34TwK5CAmyuLwsqItdQwXU=;
        b=dfY5waIwcFthUQ5P6TArcMvcszYAeSdQov5Nibv6JyUswuGI/5c4pLUZZEDtDW4YCT
         QGw5NqCmSzxDxbZ83x+sLey8tpNaVvLa8PYHdYGwY8VtVbF+mK0KG68w9gisDsSiimWC
         wbUM4ZxAxNVvzx4CLpwRc3JGc5S5F7haFHcqpUlJEcjFTNyU8Lx6PuSfSFLtU4EES7dd
         XP7Neg46BTV8Ca+cc0b3HQ4BtbAvvRR5pSH23rXz1tGucobDD2yfQXWhxxCtS/0wHNAO
         KXDJTew6Ge0sQ4xsy/R2duf0tDQ2XV4QXh4dcbTE4BmDZxy4FhpHWqiN3oRjHva6Z7vh
         fqQQ==
X-Gm-Message-State: AOJu0YwTJEFVXh1PvWI9vtTyWGGXmFcvw05z1l0lQfr/yfS+/HVc46OB
	QrUN9QTYjyoqlA2sQdyZ8KRVis+ZcbiL5kECIErGv0yitEQqHQnGPsenKdtbmx0Ku/KZLSBogwW
	7AVuH5X6kUr/JL0LLFrGWFsoUjYs=
X-Google-Smtp-Source: AGHT+IGPGycNApOfo7akRAOS4eCXem+wyaGdrlGsGApNAiszfED9bjTbvM3ttqmw0tjqzmW41Cl01Jydh7AjXPmP2Sw=
X-Received: by 2002:a17:906:168a:b0:a31:9b4:aa2 with SMTP id
 s10-20020a170906168a00b00a3109b40aa2mr4577378ejd.51.1706529805236; Mon, 29
 Jan 2024 04:03:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704802213.git.ps@pks.im> <cover.1706525813.git.ps@pks.im>
In-Reply-To: <cover.1706525813.git.ps@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 29 Jan 2024 13:03:13 +0100
Message-ID: <CAP8UFD3xWW-WvLPnHNVyJbbXDvs85TTq-wVVZ-qnJLSdqtR4bg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] t: mark "files"-backend specific tests
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Toon Claes <toon@iotcl.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 12:07=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> Hi,
>
> this is the fourth version of my patch series that addresses tests which
> are specific to the "files" backend. There is only a single change
> compared to v3, which is an improved commit message for the first patch.

I took another look at the patches in this and it looks good to me
now. Feel free to add my "Reviewed-by:"

Thanks!
