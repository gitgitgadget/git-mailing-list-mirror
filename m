Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655804;
	b=Vcl8smt766FOzzqBt3LSbFxHHEWZHWXjs4zrixDDqRnsGmVzx6f3/O91vUEyHJGy+7Id
	 LTpg1YkdpwBzCTXsHQ57728BNhqvZ31fqqxg7AF45VGOMWm1ThrCoArXn5Ba7p+PwSV1p
	 LxFj+Wov3NSV1y0QKIv6Vkdo48Q2LkIptZiRleiJt+03WWpY6u7Tb1ZKF48GMu9BkDFVM
	 iGVgrDVJb69guG9D2BWaKJw/QsDniYu9k1esHMzHyt04FLKG669Jw2aw4ZEOqF8RPhzNZ
	 XFjgcRT1amytnSHftNsfmN1MD0ICkDcThaf5om8cQVqsqPJF4UavTlQiqw3jgXjiZ/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2NgHDpJIzU0hSpuJai2DAYiKwsMcvgn3OtjdvFBI6Ik=;
	b=b4mtbzFF+xCRrk3+D8T2fOaz9O80AJO8jP/3BGjRnG9vOU3416QEPIk6Zdzu0eMVQ9Pn
	 6CsKgIsj464kwizwIC5u9LVTRO7qV4EX0Nsh9tBFiY+6i+JIqN84wLx9wspwhDxHdLMKt
	 rLQn3jiHpvvKOV876NChhiNfCGfyD1rNm+fpuyJQKUBoWMPWxE376no/Af9Rvc9pr08ru
	 rpknx5ePeCFG2OkxHK5kQ7DZvKW5GLeFg+hAJKFXKCngTLF2VLh0XtD/pi2UTyEdyNeXE
	 ++ukM0gSjvz1VyPVJmAqOMVQ3IGaKo/9x+WTtndijNPVCZhD4/75iO8AsfRESWHpvMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VaAdJQfU;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BD9606A327
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 21:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6BD9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VaAdJQfU
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6b8e2d8df4fso2516299eaf.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 13:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793655803; x=1794260603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2NgHDpJIzU0hSpuJai2DAYiKwsMcvgn3OtjdvFBI6Ik=;
        b=VaAdJQfUM+HWD8P4HC/13y3l5fIb+7FwdP5LHU/jz9CI64rQclumiY1/EXxUODVg8W
         ZLuWxzm2ZyY5wpPuLOVyc75sTWYFifnj6X5ZSs9Ovkqzq/tDGgoRlVXS47C0rvPwgZaG
         FXbN+6bXYs82EszxBYAVlNx0pdPM3w5XoTE0XXWE6oNffTGGue9F3IZH2LeZtChfQ3T3
         DnGnPd6zwy67gqlRN1ObGEmTf129GgklqxKPf/V2Udj5rNReqMxe8Ek2UXdOFbjaYN16
         TPgRum/sqXIcdJ4MLomr83H9FYGkEVyf5BhAQZqsZxf1XPP9giAO/9S1TfpGvRrFzYTb
         Shyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793655803; x=1794260603;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2NgHDpJIzU0hSpuJai2DAYiKwsMcvgn3OtjdvFBI6Ik=;
        b=lOzBhHZ3QMDaHDY77k7vYQ5RA6TkSj2DDqXmoOZwl3l47vXCQEhoHauYpEqQVegWcy
         3G0sxu7fJm+gOZI0tLzNYFc2L4v7rWbik09mQH2TG8h0vZ/5Au2SVxwiasBkXO9VZa4l
         Pagk+tfKLTYBHP6+MS0VSN3yaABSxwfDfFtA0+DB7+lPATDYZ/oSJdh1AuEdsgNHi64r
         XzyeaQERjWbvW2cZtNeGd26uvR6Cc7Vh6obZ/fFe3W6tc7bPDfg4WfJei3tmVFKWKJSZ
         Grv+J3tIVYGc5KwGzdzpP/EefU6+QVT106VJN5HvAW1bbnW77NrwuFnzj2l6QmrWk2R1
         TPPQ==
X-Gm-Message-State: AFq9FYKuEnYo4c6+d8/nyNix+vgpTBB+sUFazoxQwHS2PxV1mTSEkqp+
	qSF0exnN2ql+UoSfC3Gl/fic9VCAcAsAzeg7nhXqzlW4IihcuPN3jHSC
X-Gm-Gg: AYBFou3FzhzsbflWpIFA2MAledPYpQD+P1qBkr0YR+xOUGFfU2xNnEanTR2UsYGSmIy
	sCHr35hnnbPHQchv74bewtB54vo3h/0rqZlTzztR6OLMNFApIvEOG2kEzTPr8g5PYql1eokK/zS
	P6Vds1KvLlTxnr6mDqdVtRU3vPlY4uNcuCxtAc8BY3ppjcgnzrCzHgjDcr03ZGJ7+ZaI+D5Af55
	rz2Xbx8SdczP6bY5cV+adUq4C164sG75qOvA6h1ZmfB+rmUVznDsfBj3R9E7CS1eTQMOeOk7ywf
	Pvd4js1Qe4A/SeAilO/fVX6Rg/SBiC6lx9l1JeGgBrfeXLk1Fdp77zktq1qEI2eUYlv93QatEUL
	OmQbS0NPyHcnmezkKN24+0my+CuOG1SGFC7ySLZva9RR52SylJh7EmVR6M+bN09KHQBvE29d+39
	5t6GWe+rpRapZvUKErvshW6WZgZaWFFVkzfshFed/zqiAeZYmhNDMBwCMPyjQRrtpHBP+m/qSdz
	crDp2WFPM8BJ6t5ul9KzygI327L/6cPCLjdP8GoiUd+Exbne4wj6OYTJ9gicbuPvaiTmhR68KAj
	OtCUxX5wh2+842Z+w+h8OLIIM9DRGFYZlRX8U4Zl5dSA4m2UwlY6
X-Received: by 2002:a05:6820:83dc:10b0:6d8:e4b4:2873 with SMTP id 006d021491bc7-714f294aa4cmr5156725eaf.29.1793655802455;
        Mon, 02 Nov 2026 13:43:22 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a921a80881sm8193897fac.17.2026.11.02.13.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:43:21 -0800 (PST)
Date: Mon, 2 Nov 2026 15:43:20 -0600
From: Justin Tobler <jltobler@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, lucasseikioshiro@gmail.com, gitster@pobox.com
Subject: Re: [GSoC Patch v7 3/8] repo: add path.superproject-root with
 absolute and relative suffixes
Message-ID: <aukCnmlJzZmOTihM@denethor>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-4-jayatheerthkulkarni2005@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927114420.59724-4-jayatheerthkulkarni2005@gmail.com>

On 26/09/27 05:14PM, K Jayatheerth wrote:
> +static int get_path_superproject_absolute(struct repository *repo, struct strbuf *buf)
> +{
> +	struct strbuf superproject = STRBUF_INIT;
> +
> +	if (!get_superproject_working_tree(repo, &superproject)) {
> +		strbuf_release(&superproject);
> +		return 0;

nit: The early return isn't really need here. This instead could be:

  if (get_superproject_working_tree(repo, &superproject))
    format_path(buf, superproject.buf, "", PATH_FORMAT_CANONICAL);

> +	}
> +
> +	format_path(buf, superproject.buf, "", PATH_FORMAT_CANONICAL);
> +	strbuf_release(&superproject);
> +	return 0;
> +}
> +
> +static int get_path_superproject_relative(struct repository *repo, struct strbuf *buf)
> +{
> +	struct strbuf superproject = STRBUF_INIT;
> +
> +	if (!get_superproject_working_tree(repo, &superproject)) {
> +		strbuf_release(&superproject);
> +		return 0;

Same thing here.

> +	}
> +
> +	format_path(buf, superproject.buf, repo->prefix, PATH_FORMAT_RELATIVE);
> +	strbuf_release(&superproject);
> +	return 0;
> +}

The rest of this patch looks good to me.

-Justin
