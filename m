Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28B276D1B
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 23:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740699229; cv=none; b=nY21H/2zy0Q7ZRnoJy9LhiMSOlASFf4nj4kMvJs9CQ/dofGCuwqypW5/JP5tO8xSWFc/6svXRYqH8FUUDbXoLdQG3h+0VP4iGycbnATVw2z1kAJCDaGQjIQ22IpKoBkLXDDgfQOxpW7Mijyg+aKVaEQGLImUeTbQCbZOZ4bT1s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740699229; c=relaxed/simple;
	bh=1r5Dt5wVC1RxDdPVQmZEiZllHC/y3wlo3fuFSDxKxxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qC/nXoNKrYoqEDrfAEFkqlP2C8FtRW0hL/0qwQYkct/ykOuHfirG+Xmq499RTkCB8dHFoN61pBbB1EYFZgW9MCwwc8c0p/ZuYfIiI5DDXtGufocFxWPFE0HH1p19PrtUsFS+PllREy8aeRxvRBTvvMA7tYh3ZTkpolyUyCD/7pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tfdfk6ej; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tfdfk6ej"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fcd8090fe7so12470747b3.2
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 15:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740699226; x=1741304026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XAm0+wmrjklB5VJPc0NVTyd0jWLWjghzurHC4GxyZWU=;
        b=tfdfk6ejc7SBs05lYWjJ6tOpTgZxjqR/M7/RLf/GSmILr8IlqJ+rdcagiYXLZ49c4L
         uFsslfd6qWo0BZeZ+mBQQTYS+6eZzrLBqrYKXdBRZgFxgeG9mAdMaRdtYZhA6coc3nB9
         xCpSOfNEyW2JcOEj8UBXMM/xMYNJbBzbcAsiIW6Mx0LkeSkqkCzJD/fmP1kWJgIz2RH0
         m0E+0QAzjQhxgd8+M52WBmRATJ96jFG45MbvIlbzhWEtTPffO5wt4lhyX587GtcuzPPG
         OqadZwtM8RiU6utSie64HFgrq8k5z75hOndsAVuWvYCmAwyrSzoeS8gVijWdr+aC61+u
         2y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740699226; x=1741304026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAm0+wmrjklB5VJPc0NVTyd0jWLWjghzurHC4GxyZWU=;
        b=N0wqu1AYviI4WsGmtza6d1TTBzCMR8zFTodQBDzH0lsRRkX5QRkXw5/gzk47Q5JV/K
         cw2f8G8TPNO2ADN1DIbCRlYDRuB+TSyqvhWirh22vTQBTudQ/B3Z6yD95p9zOd7Pibxg
         ydyJYiawFeHkMVG7TIe0D7fwVARICSidG26uFUiIhud5B6BbUbz4GOyx3jyBwy5aZ0gv
         tmnyqPUPCwchaLAfrSqgVc+yVwHSo7O57x3j3/cpusJVVsbAY+S+H8jABBQbuDRVXnnR
         1BrTxSuMEOgqI4m0ebMCTJih4saJSoNLpvQnyc18faOlQBhg4krO/VvRTLjhUhi1aX5V
         WjmA==
X-Gm-Message-State: AOJu0Yz3C3KQdSL1IM8kKOViyvD4rXjC7WjVUyEV9/AokC8HC1QFfhNN
	ca6rEng/VtOFVw+owG03RJwko/clWACI1QtJWKdkyyMBEDxAoGpjEsFe/FG9qRU=
X-Gm-Gg: ASbGnct9PBGDLaOg3KouFgQ5kk/IqPm8nO+LG0JqWR7P1Ri4vpoQrEnc92y5Id1di4Y
	zSn2jfQHmNeo61An63I/gj4sOgqWxYjBZIRG71wOsaRCmctWNBKIkAGgpoYFSQU5pEWA0t7guRT
	ShLOrIakUe2fnL/55E1ybBWdRFxAnvFLH2i3DGx2wqYTwLdJYPST5GxPabnyYJNOfLKs4AyaSgd
	w1Eya8wECztucYWMmKI9zsmZN4IpVOomAmyrt6wjDFNpgohy27VBdynPhHKhrM1O/v+O0SgQUZ4
	Ezw/Hhg5B+VH5qGYpHq+hTkucomZWtUPT5490gJIZxVJhWIe0bCE1jyaa0NS4B/IvEBg2tAqDw=
	=
X-Google-Smtp-Source: AGHT+IHG0PqywawFdtxAFYS4Kw8kMy6XwaVUrR6jx0MhhwVFGmleea1HH51tGeaxM//Hh4GNR+B8LQ==
X-Received: by 2002:a05:690c:905:b0:6ef:64e8:c708 with SMTP id 00721157ae682-6fd4a019cdcmr19867677b3.17.1740699226592;
        Thu, 27 Feb 2025 15:33:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3ca445a7sm4967747b3.37.2025.02.27.15.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 15:33:46 -0800 (PST)
Date: Thu, 27 Feb 2025 18:33:45 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/9] pack-bitmap: introduce function to check whether a
 pack is bitmapped
Message-ID: <Z8D2WUZIu041l0WZ@nand.local>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
 <20250221-pks-cat-file-object-type-filter-v1-7-0852530888e2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221-pks-cat-file-object-type-filter-v1-7-0852530888e2@pks.im>

On Fri, Feb 21, 2025 at 08:47:32AM +0100, Patrick Steinhardt wrote:
> Introduce a function that allows us to verify whether a pack is
> bitmapped or not. This functionality will be used in a subsequent
> commit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  pack-bitmap.c | 15 +++++++++++++++
>  pack-bitmap.h |  7 +++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index fc92e0aae65..3cbe5bfe909 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -658,6 +658,21 @@ struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
>  	return NULL;
>  }
>
> +int bitmap_index_contains_pack(struct bitmap_index *bitmap, struct packed_git *pack)
> +{
> +	if (bitmap->pack)
> +		return bitmap->pack == pack;

The bitmap_is_midx() function should be useful here. I don't think what
you wrote is wrong per-se, but that function is supposed to "hide" what
exactly constitutes a pack versus multi-pack bitmap.

> +	if (!bitmap->midx->chunk_bitmapped_packs)
> +		return 0;

What is the purpose of this check? The BTMP chunk was a relatively
recent addition, but it came long after multi-pack bitmaps were first
introduced. The BTMP chunk is necessary for multi-pack reuse, since it
indicates what sections of the bitmap's object order correspond to what
packs.

With or without a BTMP chunk in the MIDX, a multi-pack bitmap is assumed
to cover all of the packs in that MIDx. So I think the above check is at
best not helpful, and at worst will return incorrect results for
pre-BTMP MIDXs.

> +	for (size_t i = 0; i < bitmap->midx->num_packs; i++)
> +		if (bitmap->midx->packs[i] == pack)
> +			return 1;

This part looks good to me. If you end up pulling in the incremental
MIDX bitmaps series in as a dependency of this one, this will have to be
rewritten something like:

    for (; bitmap; bitmap = bitmap->base) {
      if (bitmap_is_midx(bitmap)) {
        for (size_t i = 0; i < bitmap->midx->num_packs; i++) {
          if (bitmap->midx->packs[i] == pack)
            return 1;
        }
      } else if (bitmap->pack == pack) {
        return 1;
      }
    }
    return 0;

Without pulling in that series as a dependency of this one, I think the
function would just contain the body of the above 'for' loop, but not
the loop itself.

Thanks,
Taylor
