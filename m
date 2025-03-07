Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5109D33DF
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 23:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390644; cv=none; b=qpJdnkDDe7K/8fSPKKrDp3GswmaOabMxhxvztjz7eHeXENp/TivEOBpkgsznW/SqpnDKFinFguyLogXIRS7QnjQW5IcPjRa5imuf+pK3Xw6v0SFlirT48eTQO7xmxLS3phRajBdBY6l+JcUHG4GEbZ0BSiehKevWUTb9iX0vjdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390644; c=relaxed/simple;
	bh=mKScvp8IkzRl5f0d2uqZ69E+nar0OOy6YKv0dEfxe38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQCibJKXDKAxuowUb5dPmfuR4I98ZlOFlRiEkYvJIZiC0ELwllPrcxUruGLci5PWm39foq29Xzws/Rpiam9+HHziEuYX2AQ+auHKj+R84F8lLkuiw+BXhI+Pk2pVHxfh2RCUNjm0I1LRnsaONhRX1p2owbKU7G/lfIwh4PzI8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=pWkIzxsJ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="pWkIzxsJ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6feb229b716so22675187b3.3
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 15:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741390642; x=1741995442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mKScvp8IkzRl5f0d2uqZ69E+nar0OOy6YKv0dEfxe38=;
        b=pWkIzxsJcTlQQ07RsL5zOfsuGnI2ntkjzGaq9wMeUMk9FhTQvBw8eZSJQzUAYRDGbe
         qjQvyY1vU67lTmBXwtS+fQkxILXt0gaotvvANxDraW7bNs8AdeOInc4ZsYc/NHi6x1kc
         V074O/LfiSzRepiJsBcuYOjq28Am+hqw3mXEYemWsDM047gA6HwLQa9YCEODPh5zIBx9
         FRnIEugZhWBgai6p2B2Nol0ckNNyD9jJ9uMZKSyxhKLNbJQFozHZxjMzylX4uYdlsi1F
         rtF34TKczgnsuOpuZAdKNThQOwuHZ8H8ZHocYExucrkm0kBsD/m/4EdPKw8hCM8GIDMr
         JwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390642; x=1741995442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKScvp8IkzRl5f0d2uqZ69E+nar0OOy6YKv0dEfxe38=;
        b=ZrWevsvKym8F4qMSddMMKrwbisRqvUOVd5F/PY3EZmrTSlKHOnEyqS5Vup4zeoeR/9
         +3F9Ts6tOydsd6kzzlvz/UbWGu45PucsPfD/VekiMWUiSXkPHhcvJUV37vSpQdqk4Wfw
         EXdvcypl5CC/wNfgBp7ocyODwA2GWzVGzg/B5GQOeeZMjCiGggOK0hBOkKbsSSz0SMqI
         ZgDmmruRjbuWbmUdl3hUXd+yc6F7taJmGzO8AAj5ttkP96vcYgYSlB3wGiI449PgxwCi
         F0Q6VUz0XLkOaVyzGfE+vi8GIzbWFe0mVHuWaqJSG97/6TjBRPbuf8pV1AT+eebpl2bu
         gGOg==
X-Gm-Message-State: AOJu0Yxsjmf5CgBBHD9VLXtwR+sId0UY3hN8tcoaAlre0rkkzTtRdL+r
	Fa3WLIV1yBbWr0WprhS9O/6qWMctkX8FkT2mjnaZVpOa+Zt37CJAf/cPk7H5/hE=
X-Gm-Gg: ASbGncvMSt1IrnK85fu+Rsl7b8VS/beH8SQbnA3t7hFrhxMDZtqiVytMYMhnQwOe3/+
	q904oasx1FqFl6ASI1+PT7Elc6MjIcakT5qJ44XpFb6w9d738gkxLDZQFt/cQzEIPmoCglOcVb6
	gS1axLBgfeKzDnvVQ3bw3+FtXJESnuLg93EIb6TQbSVjQU+B3B2VKfSCT2BoaYv8+7PXUK0Chq/
	hA5zm/mXhAWILouWzhrKMJ6O5I5emgYmA0N1CfFKYMuOyEZyeZL5kFQzCRPSHmBTP/x/ghPCvFa
	bpsYa9iWlE3EjxJANSCnGy64MLo5HTmQQqkSdcAmZHBvPtTX1bMHlI5Wnyl/3dwKSduCaBFoLSA
	vSjj3KiYNPmHQjI4V
X-Google-Smtp-Source: AGHT+IFmR8f/pI6mij7fpextrMDwa719V/YxxDvMo6QB6w/XSkEYb/8KxJnZaJ20vHVbSKUsAxf3KQ==
X-Received: by 2002:a05:690c:48c2:b0:6fb:9c08:4980 with SMTP id 00721157ae682-6febf37b540mr73097217b3.27.1741390642273;
        Fri, 07 Mar 2025 15:37:22 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2c2fcacsm9482607b3.81.2025.03.07.15.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:37:21 -0800 (PST)
Date: Fri, 7 Mar 2025 18:37:20 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	SURA <surak8806@gmail.com>
Subject: Re: [PATCH v2 1/2] refs.c: remove empty '--exclude' patterns
Message-ID: <Z8uDMHclfE+KqBMz@nand.local>
References: <cover.1741223981.git.me@ttaylorr.com>
 <cover.1741275245.git.me@ttaylorr.com>
 <c3b5ca597330275391704a0653398ee28f911fc1.1741275245.git.me@ttaylorr.com>
 <CABPp-BE3u=YVCU20Bz4jZc90DkmArE=v02WjOzr-uO6kV6Zfng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BE3u=YVCU20Bz4jZc90DkmArE=v02WjOzr-uO6kV6Zfng@mail.gmail.com>

On Fri, Mar 07, 2025 at 01:32:49PM -0800, Elijah Newren wrote:
> Makes sense...but doesn't the second patch also fix this issue without
> the first patch being needed?

It does, but the mechanism is pretty round-about. (From a quick glance
we'll turn the empty pattern "" into "/" which won't match anything, and
thus won't contribute to the jump list).

But there are a couple of reasons to keep this patch. Most importantly,
it hardens us against potential future regressions here with the empty
pattern. And it makes dealing with that case much more explicit by
throwing those patterns out before they make their way to the backends
instead of the quirk above.

Thanks,
Taylor
