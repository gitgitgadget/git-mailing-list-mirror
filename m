Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FA718AE3
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766019966; cv=none; b=ZXJlw+3LsSyoTirbe4724m4mYpu/kW9yKv/0vy6oF6ZJdI7o0DWw16pMdT1iGdJ9RhD+4LnIYyrmXXS6w2xP8s/aUFanz2AEOUrUiCAUNGBplgWOPsOgBTLh3yTkzG53eMtw6CQDEbl5NWr7AUV/aRv+7mosM0ok9+wpW2hBHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766019966; c=relaxed/simple;
	bh=NouoH1lK9uTgwFjziNNWbh2bO1OBP8PfgyjI/CEfB5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2kQrjF0G6E/+vsBaVx9qcKpPJ3p+5CtfAQJ810QWo0HbFWHI34GpSP1JL8hnl5YXRCWSdOW+1NRXujoJQ7E5uccihssvTTmp4e1x9vLut83g8Jq+NHj53qGtFqpCk6EOYnivIZRvO3J6XGtkTNv90qT9EHqjG9GkODotbDewMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnFRfRaL; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnFRfRaL"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-65745a436f7so41397eaf.3
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 17:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766019964; x=1766624764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x4H2YLfREmgqjV5KIUppJfKJ4QfcJ96oflGf4J/NTuQ=;
        b=XnFRfRaLWHweBgGZzC8W4Dc7RYScmvY+9Bqv/THjFf8DPDqN5sY/bm7Xq2siuREKB8
         6Jzg1h7qlJkIvXr1CGApNBeOhc0zOOq1bo6VbdYtYBKAtlmfEjcv/xIHRozzBy3zIZsh
         +c5rPP8ooitSkfL87WroywyiC0534FylDSVTKFXitOuE10xuxBmVtyG1jTc4KlmloPcf
         iA7plraYtqTTf6Ju7/mJ82U/bGoy/zrQVsUU+0jN1LueDSrHS4QUnqsR2lJ+3mI+vhmI
         XaixImP9VLRhNoC2mRE5QslzbQXxb80NG6NPGDdags7uQtMR3PQARJXHYd7W+vXA4acp
         KqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766019964; x=1766624764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4H2YLfREmgqjV5KIUppJfKJ4QfcJ96oflGf4J/NTuQ=;
        b=ebTm46F/wizr1hskon/v+eeY7h0BbQmAVpfHpUJUQNtNaeOWYjCS3YwMW5srCMdKR+
         kcguhfNdcjJZ2GtkkxiLw+yUYIiqLRfVhM7CWbEkD1OrmtN7WDW2fmCHvaD/ENBpVuo+
         Nx6KSV89ETEYJ8TOpOVTmCVpZhLk158tsLLIn7fD0jB4DKWcLkOkAdugkC13Wp13sPLa
         veIlhrDl8dT1/K8fr2sY3+ONhUyHgoBGkSXX60b9bBa2HVGUG628gK0ycgvvfI8OZqXN
         Cn0lm2zyNyJC2rlvgqeaZaJtXN6Bb2d4MfUPUfew+UzjnQJerbFfXzjtmQQOMYgXrBhV
         PeSg==
X-Gm-Message-State: AOJu0YzuGDBXWWlIkuSSzG09EfkeR0H2Syp0Zn3etgb0HoerkfEj9FtW
	jmYbBIaGTNoO6zvS9Zmu6ulM/78v9TP6LjG1RjwUl3fhFXbwxCPNY50SnoGl7g==
X-Gm-Gg: AY/fxX6H8/00p0nPzILUbwIf1MByIlVYe9r1d2JIeHzLsg6/6ZoDsLEVlii3Ewq2bbI
	5Fo3k8MYhUvsHzC4+bBkBAPYsSObbTrs8j5n34D/TIO1Tg8ZBLR+5x/f4/tnQR2sOxQ7RifCyFJ
	pQlBjri3IbWSn7byWmFBJUpMtaARBpNTFR4yXxx6eSfyt/nL8jDK3LPlK/FB2OOFAg1Ihpf4a0n
	1NRIHUO9XiwJOti8aTVGZ0JHpXsxbPkzD2W5mqM0XiyFRDy5tXzdGqxx2ItRK2iL+yfcpXHuH75
	rM3ECIxNOVnTnRD1gCOxI105pNm5oIEwIE75ypPIOc9e4/188u3nm6CjUqxy73bQznKDJQbwif6
	HirZwTNifso77DW96ixPcD0U4mF0uCXIWAwmESOgJidE8D0mMNBcfIhV1gWItlYCvMLAHbbSMlf
	2K1YH7
X-Google-Smtp-Source: AGHT+IH+/TRU6IPQpaEB7ErwcXlAgIyW9Rg39Lb+hiVynIU4qHNBP2FrtoN92YLgWBQmb6he09DDmg==
X-Received: by 2002:a05:6820:f0b:b0:657:6258:9dfd with SMTP id 006d021491bc7-65b455bbac3mr8813052eaf.7.1766019963668;
        Wed, 17 Dec 2025 17:06:03 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65cff238d6csm449691eaf.13.2025.12.17.17.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:06:02 -0800 (PST)
Date: Wed, 17 Dec 2025 19:06:02 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/10] packfile: inline `find_kept_pack_entry()`
Message-ID: <qoh5ew72t4pdzdfu5slsc3lqnlai5crudrixu6ohn55cuy2c5s@lzxjijg4ho3p>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
 <20251215-b4-pks-pack-store-via-source-v1-8-433aac465295@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215-b4-pks-pack-store-via-source-v1-8-433aac465295@pks.im>

On 25/12/15 08:36AM, Patrick Steinhardt wrote:
> The `find_kept_pack_entry()` function is only used in
> `has_oject_kept_pack()`, which is only a trivial wrapper itself. Inline
> the latter into the former.
> 
> Furthermore, reorder the code so that we can drop the declaration of the
> function in "packfile.h". This allow us to make the function file-local.

s/allow/allows/

The changes in this patch look good though.

-Justin
