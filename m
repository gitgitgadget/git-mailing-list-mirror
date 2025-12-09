Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C712FF151
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 01:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765244494; cv=none; b=CInzCIWwFXOVGecQN6H4L3Sob0xMzP4vh30uhiys803SyyWm5pXcs6zhYLvTxTasMw6KGiOJMHdT9XS25ysNcQDhTPYMHgkS86I0/igIvXzxg9w8Kt7tRRVAXnCGPxPdGVrpzeJuYbbYhiKtVAOINPUqmPMXkJzclvLlxDyw0F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765244494; c=relaxed/simple;
	bh=7vs5Yp9k+cMiteRoj4IEQaiN3Bbm6CHh21oIVMgtNZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjTx54OQ8TjCDaNMDY1Xy0hfKOD+7v9+PR7UViZp5zalBzUOSskFmEQFwPV128Wx/nKGmOiJKeujrjfIYTIVF2oqAjBGvr7KzGUL7T+HNlAKd4nfXMXJkyShyvr4vEJxB4lzQzBeHUIvGc+0PAPLdVvx40YmuI8KtZ1QRuy/TSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ZHqU0BdN; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ZHqU0BdN"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-640d0895d7cso6814735d50.1
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 17:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765244492; x=1765849292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7vs5Yp9k+cMiteRoj4IEQaiN3Bbm6CHh21oIVMgtNZs=;
        b=ZHqU0BdNf64BWCt49EYiTio4/lPiZQJpOHh02oQTOfIJeWzVW1qJyXMNxtiPirPrrJ
         zjJOtCDWPMq5fV6eceM1D6Jn2rnZzjA/QUg+JYlGN3NJ2aS0E1JAvKap4RUUUoee9W7W
         YC0AN89zQBo5wLwTnaBiYL49mgK+lwTny30CqdQLf6BRZr6Q9LNV2LgjXRy4Pz1GKyoA
         Sm89CQBWcsD5CNp6TAr3wONe9SxhbYCX/XB4K2XfiIvI2ijwu23nlb+YG7UpyyHduQ8d
         YkjmNwaBOAVpg/vr6iNB95A2F7Dp3HO5AoUiVl6ldNkyl6XhXxqHSCzJCoPwHvBz377V
         kMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765244492; x=1765849292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vs5Yp9k+cMiteRoj4IEQaiN3Bbm6CHh21oIVMgtNZs=;
        b=b4kh98yx3Lcz9ibk//xsCjBCZdsdHaMceBlxSI8o01h7eiyy/B4TV96gYztZWCAcs8
         hafzqG66ZFbDhof7MYGD7C8bWXWpb5w7oJrN4oY59n6zsxi6GzAWEkIWogJcRQKMXQdR
         5bzHA+KCB1T8Bxu7MQfN+jkzXtg1LRV/YMsFQHTm9thrKaFzw7XeAkAilfuy5Xxx+hgT
         iCuWDO48mlFVO6rzNEl84e+r/W7BqJeq8+JJxHPrKPPu7IwlJjXrd+Vk5M2QjtkMd0M0
         xRsIc5/1MDfX/UZquOWdoOp+j62dRYbkSrnr+47STV4UUxVfabAGHR4Tjl80CCWbVQ0h
         caaA==
X-Gm-Message-State: AOJu0Yyq2+EosfTACJkJ2+VbFGHos8M7rWlAYeRFee/+X2ZWpEOIw5iI
	1bfa3hqhnK2SviCLwqTkh9JDyWOMJpQVckGqeB1RG7Ye6v7jj2YyglOndEds2PZxc7U=
X-Gm-Gg: AY/fxX55fxgANGgAcQJoLuJpToD8FvgkiBQ9Bi3RW0yAP2ynyKt1FYucgofEraa6eSf
	kuGVHlxbHDDp7NUFgyuS1nYUdrin0xKxBoEcVj/vM9wVRqTQGiUvVZ1i9goDYKu5qDS/xbagAzt
	Sq6tXb4o/w+vvPqAei2/S7BcauhAYlb121HfnKtRI76ChpPUMLjaquK/1UfhFX0xpxNkzVjqvFH
	U1Vd0nAapT+m+L+m4w0nsaqUOGGbqOHnlcH7WGy+Z+EjSU3kCfP1arr/0jYWoPOjAWoxBtNlxXD
	kHUydl2dS0WnXJqIGAswbb/2aE9xYOZWMFL5Ih9Li8Jd0c7Ojs5lHxMUIaHg70Mjicq3aIeQs91
	FRgAzt89GEwc2k/b+Hhyq9+nAHWv4VG9v93Z8/8ap2d58y8AkOFi3q6zZ6p7wtURAvocn99DuG2
	h50rbLXiui6KKvytynksRHyU7sEIPkBd7hF9pSnoqfs4CPVhCpmclS3+COyCC3Z9TMSdcmqXdUe
	ShapA4BzghgrW1pqA==
X-Google-Smtp-Source: AGHT+IEoqWRs5CG+aCrqp4v8Of6L0X3c+nqM7VWcUdySA78APbMuoWIPt/D7CLeVbdwQ4H0NhffOCw==
X-Received: by 2002:a53:c046:0:20b0:641:f5bc:6953 with SMTP id 956f58d0204a3-64464b42d34mr971382d50.36.1765244492033;
        Mon, 08 Dec 2025 17:41:32 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6443f2abfe0sm5945906d50.1.2025.12.08.17.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 17:41:31 -0800 (PST)
Date: Mon, 8 Dec 2025 20:41:25 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/17] midx: mark `get_midx_checksum()` arguments as const
Message-ID: <aTd+RZpVxwRTM+1h@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <8cd8f6e8420a52030f92166d5a20387183cdbb6b.1765053054.git.me@ttaylorr.com>
 <aTcXKE9ZW2Um92n3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTcXKE9ZW2Um92n3@pks.im>

On Mon, Dec 08, 2025 at 07:26:45PM +0100, Patrick Steinhardt wrote:
> On Sat, Dec 06, 2025 at 03:31:01PM -0500, Taylor Blau wrote:
> > To make clear that the fucntion `get_midx_checksum()` does not do
>
> Nit: s/fucntion/functino

s/functino/function, but otherwise ;-).

Thanks,
Taylor
