Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664CB33031C
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 20:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770668311; cv=none; b=Q0U0IiUedLlHIrhdgsSjH8JbcL52VEPiF4BX5oPFAtbn0PP9q9igosYLn8WwwIP/nyU7csypB4A4dr0XEibaEP7/2nz8oI1MS5IoZPmw+pzF3B0B/7BnfSdO1dmdtg8dzW2xfkhx7hLf+LcvwGDQhDQoj3jtIfb8C3BOtQzTPnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770668311; c=relaxed/simple;
	bh=PaCxUijW49Xlh/RSmaI2GgvbjHMNfnmtzNmbXivLr9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edVqzks+8Vgh0+gtwWotGWkuNahNFO4cwukuPsDjDFMLkMBrqZskna7x3JTpwydoslKu35VcK9GBEH1zZ0XHafGqCJOyPX5I1jM/TqOBdmrMT++fhevm+pEsaGHXgAA9wA8tJYn+OD6oeJfHrgv8fi9fV93PRaXzbcasZMGTJwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvgaHV1x; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvgaHV1x"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40866608701so65033fac.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 12:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770668310; x=1771273110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vhhTm7T5DanmODZIEVrE0mIcjyft8/ESCph5L/g6TbQ=;
        b=TvgaHV1x9YplPC6+UmzPgHchFmUJzTQR/ZlPeJ8A3NsULxBdyOs8XXajQehycmYtRm
         Z32V6J1zu9oI/AXPVqc8XYKyRJBXQnvO0EzjsZXXvZFYYyaIycwXI1tvJoSsd2WF+7v1
         HhJA40VX6KfzD8OEVOrFxCtQPQH6wkk/vtU8KEurUYcWuu/Hvtc2fkqXlrnPlRvYypyM
         LtUSr7cxCIH3+9skoYHEcpvMQKtzLtGPRdt3DavtMOFcKwuW023s7w3f5oCHr1Zn9FEp
         hO867lew1NdZfj0ArCbrw42jRIregrgjAxbAXynn//inBjsyCOMS3+eIHEdRotVSGlav
         VqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770668310; x=1771273110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhhTm7T5DanmODZIEVrE0mIcjyft8/ESCph5L/g6TbQ=;
        b=VcMIZ1rH+DvSB53J4ql1Tq9XTSAMzIO6BXuCZbG9aVtOP9cbUtqV2xLOpbXylnIWzN
         KMEYUMFq4A8J6Xie2PWcNE0ryfvkoKOCSCAaBCaGdqjzm/Yq45ok+QagF82sIm+uZ4bm
         3w5+dVpFcZQDA7R91y1DbvASM2Cz7riDWnJbipSBWmk6642wCMSPMYhykZ1Ond2V/YKs
         pB7CT9fsyS1AgZ745Kxlo2HEQXKYt7hlBUqv1huj+CroSt5dVKDkXeh4+dp5D8w9D7bR
         WPyqVlN/u/rzSxrXTutcTMDqY52E+5J3xJn1OfcMEIDmhXEsDqIMo+hicmwpiwp9fyJd
         T1vg==
X-Gm-Message-State: AOJu0YzPH/7ZKCoRmiGdW7c97EBrYO8Tpm5ysFBj1HK0ff71fP6i+sxO
	TJZa7jgEcak6sGulq+lXdHcG/ZN/ezedux1j1+pEzYOPIuefU3WjzfcZMX4ZYQ==
X-Gm-Gg: AZuq6aJz8Nl5XHnueuCHNJdyH5fiMDOvgGa+PIaQg7Oy0FVfQFGITgoxOZZRQIA/qup
	qzdnAvStUbEtF9EtyWqDwcbcM6DvuGrOgk9NarMn+jSlTDwveIsngVYz+PmXtD9utTaO1j2as45
	jT4I8ssY5HwhzmLgT2FqTz6D4hkAW1FuPgrG6IFIY0QtdNW2j1WkSBHr0MsPLo7DOT4/yBFUgUT
	zStwR2iH7Z4jyRke3QmoHsS8cHLhghAPOVnANoZU7D9Q+G8CcjQO2rWKZwh/OGPOZQeNAfMXbWz
	2UPgMCXnLgCvHNEsL641ZiItdDVf08dSa5zkyz4aEjrqlcJAaZjspx/9YDsKAfSydIvsy6a3VE0
	f+LrLZ83yCWeJhPHBdDztWPg7JWNUWQvUocqeEuJuwAyXUnnokoUihucsej7t909I8+TtXTJ1LO
	pGT/oKQ2YLGMwvpIM=
X-Received: by 2002:a05:6871:151:b0:404:2c03:e408 with SMTP id 586e51a60fabf-40a96fa3744mr6483010fac.37.1770668310216;
        Mon, 09 Feb 2026 12:18:30 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a992eed6bsm7607035fac.1.2026.02.09.12.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 12:18:29 -0800 (PST)
Date: Mon, 9 Feb 2026 14:18:26 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] odb: drop gaps in object info flag values
Message-ID: <aYpAzVSUN9NcngFi@denethor>
References: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
 <20260126-b4-pks-read-object-info-flags-v1-3-e682a003b17c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-b4-pks-read-object-info-flags-v1-3-e682a003b17c@pks.im>

On 26/01/26 01:17PM, Patrick Steinhardt wrote:
> The object info flag values have a two gaps in their definitions, where
> some bits are skipped over. These gaps don't really hurt, but it makes
> one wonder whether anything is going on and whether a subset of flags
> might be defined somewhere else.
> 
> That's not the case though. Instead, this is a case of flags that have
> been dropped in the past:
> 
>   - The value 4 was used by `OBJECT_INFO_SKIP_CACHED`, removed in
>     9c8a294a1a (sha1-file: remove OBJECT_INFO_SKIP_CACHED, 2020-01-02).
> 
>   - The value 8 was used by `OBJECT_INFO_ALLOW_UNKNOWN_TYPE`, removed in
>     ae24b032a0 (object-file: drop OBJECT_INFO_ALLOW_UNKNOWN_TYPE flag,
>     2025-05-16).
> 
> Close those gaps to avoid any more confusion. While at it, convert the
> flags to be declared as an enum and use bit shifts to follow modern best
> practices.

Makes sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.h | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/odb.h b/odb.h
> index bab07755f4..1e4326b7f4 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -352,23 +352,29 @@ struct object_info {
>   */
>  #define OBJECT_INFO_INIT { 0 }
>  
> -/* Invoke lookup_replace_object() on the given hash */
> -#define OBJECT_INFO_LOOKUP_REPLACE 1
> -/* Do not retry packed storage after checking packed and loose storage */
> -#define OBJECT_INFO_QUICK 8
> -/*
> - * Do not attempt to fetch the object if missing (even if fetch_is_missing is
> - * nonzero).
> - */
> -#define OBJECT_INFO_SKIP_FETCH_OBJECT 16
> -/*
> - * This is meant for bulk prefetching of missing blobs in a partial
> - * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK
> - */
> -#define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)
> +/* Flags that can be passed to `odb_read_object_info_extended()`. */
> +enum object_info_flags {
> +	/* Invoke lookup_replace_object() on the given hash. */
> +	OBJECT_INFO_LOOKUP_REPLACE = (1 << 0),
> +
> +	/* Do not reprepare object sources when the first lookup has failed. */
> +	OBJECT_INFO_QUICK = (1 << 1),
> +
> +	/*
> +	 * Do not attempt to fetch the object if missing (even if fetch_is_missing is
> +	 * nonzero).
> +	 */
> +	OBJECT_INFO_SKIP_FETCH_OBJECT = (1 << 2),
> +
> +	/* Die if object corruption (not just an object being missing) was detected. */
> +	OBJECT_INFO_DIE_IF_CORRUPT = (1 << 3),
>  
> -/* Die if object corruption (not just an object being missing) was detected. */
> -#define OBJECT_INFO_DIE_IF_CORRUPT 32
> +	/*
> +	 * This is meant for bulk prefetching of missing blobs in a partial
> +	 * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK.
> +	 */
> +	OBJECT_INFO_FOR_PREFETCH = (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK),

The changes here all look obviously correct to me. Looks good.

-Justin
