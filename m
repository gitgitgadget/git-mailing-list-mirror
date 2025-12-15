Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A58A28CF5E
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765839738; cv=none; b=MWutqYTE3gJF2hRPWz+zOBf2zsijXETEn+kQksLjZX1oAguo1PDdE1yzoZoVOVwrT3vUyHXhLrRvXU35LSDIHz/AfR/Yt+XTC7hg3TgThDViFxlnaa4Ad0vGCB1jiG51nvt2kUYbI9yZlOMUZe5BxpDHLGOVEzwpMUJwrSxrb7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765839738; c=relaxed/simple;
	bh=Wl5rT6Ey1zGj/qsnlNHYxHVUJ9sDoar3/QUxclARTNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGNLWWknnthJpgrY+ABn/1+bCD3gQZdE3Yzw/JWzyrXEqjZz6tweupvgqnUaqfehRu3PtfaBTG2MkPcL3dMZjUFfg7l1P/f9fZ8YNt4KL+hz/m4hLvDLzws/PqbVoQZe9mkFzH16ssHkKlPbOtL/ckedP9QAbD6fN5mUAg2UrNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+bUE6lm; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+bUE6lm"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7cee045187so76692366b.0
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 15:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765839735; x=1766444535; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yGTLRM4A+jKdpSnZZy0AmzNvz6BG76hMeZtMcy1+1/c=;
        b=f+bUE6lmm9aLc+GYvCT91iY5fsEuFPp1++7dba1miX0VqUmUT0feQUT7RiTWzrC/MQ
         VpbTYaHf+JG0a+2h7j8ueIqcOOJRJ7sfnZM161CmwCayOz8HW45paPv17ndqu2l6jizG
         VJQb50JtaLdF/AcGNl29z9xfKvjpy3RfXp8S678EcrzL0JR8vHGtGa1QvaXazKrMUVQj
         9VoHfVUEa2neunc9UhcR6g5hu/jz+qZFBrzvXkIvjpVNEUHp8V7tiUWF/1pC9MXRPS0C
         EcSZiJijgaz40CEBH6Jxb+nwc32lvhtP9CPj0U7oaD3X3+bSlvYJrr1hzUMa/+lWuKDH
         y1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765839735; x=1766444535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGTLRM4A+jKdpSnZZy0AmzNvz6BG76hMeZtMcy1+1/c=;
        b=RpJBGNG/IJfzzrjCu83zTPylXQnjGRPRbRoApyJtyd/hIc0U/ALlf6EG4IF1XX8Zan
         uPZacNZLxiZjziZvpoEbxRkYVYK20fxIHPTKHcz3Qw+Aq9+URsKluCv1dtO6CvRKcv3N
         oqBift9ehxlORTDkmuPu3H4lLeGRTt19haAnBwkbRNxYwsuNRdQ86NVvZCz/Le0fN8bO
         A9FXfJ976ZSqWkKrw++6an6JtjrRsH44WoFkJUyEZhIg5PmpR46O6MqYJKtdesANONRD
         3w7g7EjsIuXM4RMcK2hc19Fqtv7JifRY4/9/Hk468Rr+nd7T8lruop0Ky7Xb2gpTlw/v
         gPRw==
X-Forwarded-Encrypted: i=1; AJvYcCXg2BDRk4Ws8NxNhPqNfHD5MUBsmGBuW6KqZdKDE2YHwX53oTHKSn3H+7jWvsWal5WTCNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0GkHtgStnLUP5+mE7b+bhK50Fn0tMEwPJ2sXuQgNliLbGEdsS
	r38XE7hQYwwX/gLbB3nKVPCUYqB/bHO+yfiYq0YOVIIEJccmIU1E9Zjz
X-Gm-Gg: AY/fxX6t0I2qEa+S4Gei0uOS7/Q3gw7W8oWy5qGjbzBABJDPisX9Vpd3E1h0DpKszUJ
	OzxrXsN1aOWojUfDQ03LLYb8VcV9oV0fNoXuD32XUhLAjed0Fl/tK5/LDpVz3R8ZiZAm4d5NcIu
	8g/c1LNUDY3U+OAJD+/ysbLRlDLb3pgsWwvH4k+3dv44/VeF6TnA/7XmYpiKejQq8stLgkNx6FR
	UU4AZL1eGFu+HGY+I4Mz+BvnG0UwQuS8Qy/nEU/oXCEB/+V01mv45h4NZRm/61X0b+oACJDiu//
	bgDU9l3/nF1jRWu2piYSBNIBDHI25xyZikS7TqzIUh9jIu1SGJMXHys2GWGXLUVj1zKcirsBC1V
	oT6fjFF2D+UhiP8st/nvgqJOhiI3OGj0GovV2C2V70DGeAXYodVB/W3p5XNYu9UtvTsr6VB8lyk
	YrPUHcFNPMD/V9Ad6YiJX5aiIiRhCgxwBEqM+a5dl/
X-Google-Smtp-Source: AGHT+IHWSYz8XcBEpX04/Lr0ZZXyrYcAhQ55qEbSZmDNuCHGFkOU5zxYIC4qlnp8lhCMMyP9Z25Iug==
X-Received: by 2002:a17:907:961e:b0:b79:ea1b:f13c with SMTP id a640c23a62f3a-b7d21664a1bmr1421041766b.1.1765839734596;
        Mon, 15 Dec 2025 15:02:14 -0800 (PST)
Received: from localhost (78-131-17-176.pool.digikabel.hu. [78.131.17.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa57192bsm1489834666b.53.2025.12.15.15.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 15:02:14 -0800 (PST)
Date: Tue, 16 Dec 2025 00:02:13 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH RESEND] diff-files: fix copy detection
Message-ID: <aUCTdUMKslSo3XR9@szeder.dev>
References: <4b06a448-0935-4f2a-9061-238c7cc800c3@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b06a448-0935-4f2a-9061-238c7cc800c3@web.de>

On Sun, Dec 14, 2025 at 04:57:06PM +0100, René Scharfe wrote:
> Fix copy detection by queuing up-to-date and skip-worktree entries using
> diff_same().

> diff --git a/diff-lib.c b/diff-lib.c
> index 8e624f38c6..5307390ff3 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c

> @@ -272,8 +276,10 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
>  		if (!changed && !dirty_submodule) {
>  			ce_mark_uptodate(ce);
>  			mark_fsmonitor_valid(istate, ce);
> -			if (!revs->diffopt.flags.find_copies_harder)
> -				continue;
> +			if (revs->diffopt.flags.find_copies_harder)
> +				diff_same(&revs->diffopt, newmode,
> +					  &ce->oid, ce->name);

Junio, this patch should be queued on top of 38f88051da
(diff-index: don't queue unchanged filepairs with diff_change(),
2025-11-30), because diff_same() was introduced in that commit.

  ~/src/git ((7077c385f9...) %)$ git log --oneline -1
  7077c385f9 (HEAD) diff-files: fix copy detection
  ~/src/git ((7077c385f9...) %)$ make diff-lib.o
      CC diff-lib.o
  diff-lib.c: In function ‘run_diff_files’:
  diff-lib.c:231:33: error: implicit declaration of function ‘diff_same’; did you mean ‘diff_free’? [-Werror=implicit-function-declaration]
    231 |                                 diff_same(&revs->diffopt, ce->ce_mode,
        |                                 ^~~~~~~~~
        |                                 diff_free
  cc1: all warnings being treated as errors
  make: *** [Makefile:2862: diff-lib.o] Error 1

