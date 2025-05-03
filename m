Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D22FB666
	for <git@vger.kernel.org>; Sat,  3 May 2025 03:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746244108; cv=none; b=n+p7t1Q4c5pLGTnfgnm4I01IcKBeDFuKA1JMr40g7asijl5Uw02Jc0tY2tjB9DeSLtkiXtaci0DCeXzvbgEFWxzzi9ATaqs1sCqd/8ZVBnp55NotUTAZz8WUm9ae8NUc4ixp73HZ4LSrAUqu+dJ8uY4ZChruf7VdBqfNP0u/DYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746244108; c=relaxed/simple;
	bh=01CrlUAmI438fo0Fpf3UCr8ubJDoajb+XDIJb3dv6BQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hQY57yrI6JSOqqbcIfjy0P59QrNV2WObN7EYVPHW6c8aAR9THHKvv92j+Pe+s0UU8TbXI2qKNIba8sPM69XWwAxNzXh0KnQUj7pds/1gqOyO76iqJ0k9HJ8WP+HRRBEmxbPaBGqNe7VunMyQI27YFDtgMdD3euW/OBnzgWmWpGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FV2oPicD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV2oPicD"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2240b4de12bso45654895ad.2
        for <git@vger.kernel.org>; Fri, 02 May 2025 20:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746244106; x=1746848906; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=01CrlUAmI438fo0Fpf3UCr8ubJDoajb+XDIJb3dv6BQ=;
        b=FV2oPicDPprjBkJDiwreudanF6/p8iribuIr2t4fD6iheVZTfFr/a8ckdCgQsAmAtP
         vFcoxJQmxrueMhKanOhI0E7jSLtU84xdLmb53nGGHnQkBSQbN1OtGhc7p74Bb6LSRssz
         Op+yhWi1D9lzfeW3OoUpS+qUS+5O4tx8yVW0jC7y7xTfEEpK4FFVI1BFucdGaUIqIXyS
         TWt6Zl3DWJWNEzXt53FUF5873oRf9s12BdGJoQONdKcYB9g014bHYpzYyNYSM58G23Ra
         0w8F0aWB7RsixizXOzN/LGHA+um73KbWmfdShFmOAzk/0UA8iZMjM++MH6AZj2Pbe9Ee
         iWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746244106; x=1746848906;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01CrlUAmI438fo0Fpf3UCr8ubJDoajb+XDIJb3dv6BQ=;
        b=WpO3llEBWddm77VGyOCzyiUWYR8eqtfvMEJIovT20d7OcqBrXP8d5N/k9Pwc7Ux8Wi
         OEJSkw8Gf2sanDc6p4QGD31o2+ppsyL/dKMg7nutD0SwFIKNkbQgqjwQMiSmsRRbglw7
         nML/KdhVZWnbQz4lnQdWpKYUVyoWHiN/VmdO8Om2SbvJaW/rk1dTnfBqhvQ4dTFgr9//
         tfuH9pXCD8ybp4K1FGe3hVpg2USMIfnYAkBOeBJK6+JLhDg/53ruCxzYG03pPX3FWHT0
         ZbmM/ET7k8PJALoU6pIDyXdYRPWREXKWEuPmEO0ziAnmAhNT2bM4W20gdNsN8yUt6Xr5
         Z0WA==
X-Gm-Message-State: AOJu0Yz17IQ4dQWUkTW9Yne4zMvltHek5ljpmIH++Ayv6qpPpmWF/Olg
	hxzIWsSE8EhenxFOJOYlJdsL5JoRNZS7J2XKtAOSN4/aOkr8A61b
X-Gm-Gg: ASbGncsGB5WpyLNXNQPSyHd5sIB1L0nZif8whfHhX81IwBNJ+q7UEo+pfj22WDUvkHC
	SWFKpxiO078erq4CxtuAB/gaRzitvoNcP1wP10dM/c/T9kDBkFhTaJlFSw5vXZPmFC8uWbx/R+I
	/yLjVNJh8GU/Y+uHZszvfJZGbaxHHOM6xrYPN9IFJH6dgMKYFl/9kCcJnBQUZDn2++o7HDPrI1O
	/KtY9+EOdT1/H/rRfCr9wnVw4dtfAm28ZiTHCMoDX9Z/SqYCvt2LTYFMZCt0iBvRPS22vWb0lzZ
	D5EoI88iKkERW4ehwzXsHQ==
X-Google-Smtp-Source: AGHT+IGP2SM6Xan7TEcZcAZ8ZvuEjSabD5Qhqf1a7u191CyGzXG7hShE9FNv27n+ZSWNRe9Em5PCfg==
X-Received: by 2002:a17:902:e54c:b0:21f:f3d:d533 with SMTP id d9443c01a7336-22e102ad311mr78915795ad.2.1746244105666;
        Fri, 02 May 2025 20:48:25 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::4bd0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e90b0sm15732345ad.54.2025.05.02.20.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 20:48:25 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  shejialuo@gmail.com,  Jeff King <peff@peff.net>,
  Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] wrapper: Fix a errno discrepancy on NetBSD.
In-Reply-To: <aBVp51yLwxBpRskt@tapette.crustytoothpaste.net>
References: <20250502233403.289761-1-collin.funk1@gmail.com>
	<aBVp51yLwxBpRskt@tapette.crustytoothpaste.net>
Date: Fri, 02 May 2025 20:48:24 -0700
Message-ID: <877c2ybbhz.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Brian,

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I suspect we'll also hit this on FreeBSD, which has a similar issue in
> that it returns `EMLINK` instead of `ELOOP`.

Good memory. I can confirm that FreeBSD fails in the same place with a
message for EMLINK. I'll write another patch for that.

> I do wish these two OSes would provide an appropriate POSIX-compatible
> `open` call when set with `_POSIX_SOURCE`, since this is one of the
> biggest portability problems with them.

It is documented in their man pages, so I assume it is intentional. But
I don't see any benefit to differing from POSIX here. I'll see if I can
find any discussion before I submit a bug report.

Collin
