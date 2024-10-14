Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9179D1411DE
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728944354; cv=none; b=jaLlnplZPaxKZrYsqgH2VXNcZ1Al7arfqzSO3qyzxHs3hBKPLsT0/MRi3svy7qxLjX+/9AgITURUFaEcbjyr9J4JIyyO878/Ef9JISVXQdGPCOUkMTzV2QEAeyesC/Zej77ldvAj4sGhBvvgZKd5eK10KdPv+Z9WNLaxx3gcxMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728944354; c=relaxed/simple;
	bh=DZLtWI/eddbC9cchlKGaOm8f9kOdBlfZUoWgLCD5CuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fs+I7iU+NpAui+eNtkAcpG+AJR/4xqULOvtWBt6yB/pa8C7TWY3cdR0D3c+YGKPyErxdE+XrRGBcn+iLxDfkL+ahI2oTtp6KfWtWp/BVPDy0ViCnTgArNkHv4H9wUfyzITWp/atXCQJiscs9rq3/h8GrRpMEHqBaFk9luJNj+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=oNxjNuyo; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="oNxjNuyo"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e2f4c1f79bso40825987b3.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 15:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728944351; x=1729549151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y+/Lw0S9m1Geib73rC/4q6COp21udNm7TMg/om2NQQk=;
        b=oNxjNuyoQVnCsDj08yTrYfE+JHahPla7j2au8FmHyNlsmATv3jbWYxBsebTCbAkUA/
         l56YawtIOcGKteJWHkWB+36bL43274imfVIo+hEiFT3loovvbu2e52YWsFlTZqJ+P2YE
         smxyxur/mCJpgOzEXdUb6O9g2NKBkKpvkaRQ6rHgNc9jbPDw933jtMBe7tdfP0g63YIm
         TB4qMsNJV/cMDWwiTuapfUllUE9BXwGJNS16Po3PYA/IwiDYVrJHWrTLAokUBKDObi7l
         SsA+LpGvKGf7+BwdhAz6xVQ7jTpfl5PrNYJoaQtVfNxjhd4YoVuvXovqCn1hgzlhnTsm
         wbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728944351; x=1729549151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+/Lw0S9m1Geib73rC/4q6COp21udNm7TMg/om2NQQk=;
        b=Tml/2tp2j94snImsvBI9UHk/7tljjSKVbMtAvwWKovv76OghlCAYXh9gTUQYJ3OQ86
         Ujg/dD1eedOGi90PLQeeaoZfO65Mu68dgxUC+RF6Xl2N2QbZ/3wevwpttHwDxuerhcxK
         th62A1AjtACKFSuY/hXF78ZmTXsHA1VdS9Duq1CdW+qIWnRW9CbFuXs3sF/PHn9LawOx
         3QxGt3MBGPGyzx0CzS1aI/jko3cymejrq6sRmWC8IXaAQw+VUJF4CM/dZLDk/KQbWjVy
         cB9WdP8sSp5bCW/akdKeRdhX8fNdT0wivsKdh9KjJqrW2sZt75E0i5EUDEUOyHzGdAwM
         ySeQ==
X-Gm-Message-State: AOJu0Yw3ea1AKDuYdsxc1p3hUruI6TDoHh/4ZIyFlgm6MKWY9zcv4kil
	2evFn01/nffqGJ6jnO+DiTRpnNh//T+vplW3GKF3siVtMtdpxsfzcTEHwPSDZF03KIDwQd1KzEC
	6
X-Google-Smtp-Source: AGHT+IEQ469abThgSFU6H2RgtFMHw4GI7nCWPChgEElBviLS2wKp0Y8CEqHXrbvaitRZvbJ6Q045mw==
X-Received: by 2002:a05:690c:dc5:b0:6e3:3716:2d42 with SMTP id 00721157ae682-6e3477befd7mr117161867b3.6.1728944351508;
        Mon, 14 Oct 2024 15:19:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5d4a505sm64507b3.132.2024.10.14.15.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 15:19:11 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:19:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 01/10] reftable: stop using `strbuf_addbuf()`
Message-ID: <Zw2Y3cOz4px0TEsj@nand.local>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
 <7408482c152bbf465ecd098059b1477fd38c251a.1728910727.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7408482c152bbf465ecd098059b1477fd38c251a.1728910727.git.ps@pks.im>

On Mon, Oct 14, 2024 at 03:02:19PM +0200, Patrick Steinhardt wrote:
> We're about to introduce our own `reftable_buf` type to replace
> `strbuf`. Get rid of the seldomly-used `strbuf_addbuf()` function such
> that we have to reimplement one less function.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/block.c  | 2 +-
>  reftable/record.c | 6 +++---
>  reftable/writer.c | 7 ++++---
>  3 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/reftable/block.c b/reftable/block.c
> index 8d41a2f99ed..cd4180eac7b 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -60,7 +60,7 @@ static int block_writer_register_restart(struct block_writer *w, int n,
>  	w->next += n;
>
>  	strbuf_reset(&w->last_key);
> -	strbuf_addbuf(&w->last_key, key);
> +	strbuf_add(&w->last_key, key->buf, key->len);
>  	w->entries++;
>  	return 0;
>  }

OK, this makes sense. FWIW, it feels like this would have been an easy
function to port over to the new 'reftable_buf' type. But I understand
wanting to implement fewer functions if possible.

Thanks,
Taylor
