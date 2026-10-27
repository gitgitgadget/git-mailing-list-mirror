Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793105008;
	b=3LYf1Lu1VLqjrbSxtIDlro+Txdh0IsJtmfLGvwJXl9IhzpllRZ5/BDY2Dy8kMsoTJBbG
	 QXzKBfOzDUZN+1Od8pmmgqxQyYlvZfZhkaN1DTfPTWm94IF8ubQzLmgo2Ki2TzG5vSHEU
	 g2o8LMC7tK6GBPfMAheevJ28nX7YJCdKX8x+sU4+m+7Re6gTUe3wI0dGEQFellTJyseFn
	 4DNOw4ePgBCq2sBPcNHFGwN8YoPJXkiNvD8sMEHN20t6DJmIjsvQiJ3Du4rPWllJ3G7Pn
	 99z8ypoGOv1vy1WmKrYk6r9AzTfkalxNitq7ltx3dTyy05tlF8qmAOBPR2zR6nufDmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=d6vwVD88qo5dUI0gcfzv1oenmjpIza28EFYJMze61lE=;
	b=0WVzRL+kkCk7oe5ugZRg/KAwfQ9ltU9f140mTOX4nNFxhE8Hc42hVxgl9HYU0qeqnk1B
	 j2Tnu7zsTIQpoSZidv9/2vrdlP/xN53vMbxEPsOBm9Ubfy9ZJca/UzWHwtYPejMOpxD2A
	 dPgThni2bvYmsaL71zuJRO3w608lVGIY7C+afjUYI27COrI2v4Vqz8YvKBWEyC51c5Izm
	 GEHZLFpCK/VyPn1OOyI6rTk0CiS6C8pvEXJW1+/dNpzhHBvHzSePPhih43M7eLguvcQwK
	 zCbQIu2ZsTZHxYQYFYg7vwxSdI9/gIHULUuw7b82iU75ddO+aUzjG8rmIOFsNp67uRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MC0aW4yS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B30606A321
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 12:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33B30606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MC0aW4yS
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4b28d9537bcso588400b6e.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 05:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793105007; cv=none;
        d=google.com; s=arc-20260327;
        b=qv3LgeFlC7PqLYODxTRA0AChQ5NVkfVlU46u6b/bCbLlmXaotfXePUi6sHuzyVvGWk
         UvNDtxm2lHJntpgu9a3aVAzPp3wkYAnCL8vLYdT8f7nRHG0HaJMS9sPLMG/UyeF1vhQA
         fsErHvzrrAie3h0FpV1S3xZSTd5HfABGhIFwvcv07YQEhebiWUtBiUtivUeM8GzcrlDV
         Ikx3bZACbBFZkyViuHMmLOFA39sGXAlh7ZxrvL5s1svviWoQu3nJGymQMWA6YLCMEzXI
         xbTI7VjYKu220Q9C+jR2TcuPzKvvK3RUH/5qEuX5HEGf7umAVc7q1bbY7c434dZmVziG
         08uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d6vwVD88qo5dUI0gcfzv1oenmjpIza28EFYJMze61lE=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=Mvu0iNmxVxkAaiZtN2UN5mhvwgCmFFZRjgerka7Zw5tEFA0gFVYYzB9leULtSDYUif
         7up/v3AqvA+SJgqnuAxL5SvPIo/rWpk4BB8q3R350627422GqcwkB4exT10N7LVaNGms
         2BtJ+a6RPmQwGfbBaOMqyKeOS6vTzhQUrXQgNP3ps06/za/5X/nQ7KsNvPUgEH8ImLqm
         zYWdzmDyL3fgqQLR2/T4Frj4Db8/Dcj+LP/d+LMEmbEkLBElneniHno3Er+xhn93Y350
         NYmqqLl/66xU+olQomxmxIfC+Ih6ZIKLpzzNXwhJoTheHvYdREJmzb++hYiJpx2PJQs2
         M35w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793105007; x=1793709807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d6vwVD88qo5dUI0gcfzv1oenmjpIza28EFYJMze61lE=;
        b=MC0aW4ySVD8N4KhSdDOHu0akGlwux7v4mJpy0QHXs2BSckn+xmeaPy+yBCbkDv3+57
         eiDGznEMPiN0GQdc9Fj4Qbw1zgX+a7h4YcDgSLw+M330utQE3vAbZnL5ld9JXPVeqY/h
         WYW5s8qXBxmj5S3tZfdVbRTDnROkmXYBZsZGjpWNf0czlQfiA2lbdUgL9VtxdzzZ3g2j
         KgIIcRf7Tp+V3Q8LRmBQ37hAulQRj2rTJwHQ/0mEM4MZhMHxtnE/46SVYxAkyDem61lv
         uAXJSILkDenIi/GI1vDcJcLbs8bJTKHjfr3aydDpDgxTHmit4E0ESSe/S2Ueg6H9Fd4E
         1Grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793105007; x=1793709807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d6vwVD88qo5dUI0gcfzv1oenmjpIza28EFYJMze61lE=;
        b=nE8xi/rNHj495s92cKqBdGYQm+KjRYJ7dquIIlO1snQuY/C+G4kdqjBxNxi4PAW7W1
         7F70OraVospY/DYIBMDoIiUR8CYVFvsEGJBcU3cbGHjWOgljw87p+zX1ygznBMf7sr8y
         udeLY3L9kF3LlmpePnEQqf6AndWu9O0+qk2uK9M317g/SnsXC2D/3a7FdV7DrK4Gkpca
         aZSXE4bnkIRVTRcPrtORUaj/xblZfOrpOg67sCskYrHyqMQ4cxjqckXHMDvpWnemXDFk
         9/K6qnUYkMv2c8enUQay50QWNAZ68ODPRcldYh0wqdPdKRE67JFhODOjKyc++yvBujkx
         sOlA==
X-Gm-Message-State: AFq9FYLf9a4DXwsYMHQhXchXQZaxCkbHQT1l9DN7jhMwwy+QZ29UR1rf
	thy8thSwUPcVucwcCLAkiybnzQyaHhbQG6P1JXxv948ApmhUxo8VC1fLaV7RwppyHD2z+UHsvhE
	dUN7gwfmiBHBXL+cq9MiwZNUCJ24J0+Y=
X-Gm-Gg: AYBFou0c2Qsi2Jjnd6VjAE+QmxIOtiuFR1vb33adX+P/0K68o1WRBv4JrdSfyPxBIQR
	v7wVMfzE3/XooFUiQpoxyq5WD6meDrm00XU4CLZYGrUGmo3GlPOAIv+egpBfJj1qteMHj0TCcGm
	sBh9xVSSaoTIVVd1tB9JR8KaYHV5yX7nIsuaNk6n+sWW6hRSKydH+Bmp0NCSMsRjg3QyruNP/CL
	zwvN3oJco2wuIrCYlnYVS8R4WgD2+t6bHWlF52KsCW1AUyK4GwB5O9IaV1sskR/IYgc9j3uMKJ5
	snxt6x09QXEWsKEKbTVD5v/8jf+Nylem6MXRbAtmJYpMps3GUzwbFTl+Ne6MsA8+6pTGY+mONfR
	f/clkHRgZ1Vnwi4cHtQ/5HvNzCS+yZQZCer3OrxU1v07ck3r4B8ck2nH+YFbEv4iyg+YjdDi09N
	c4U/IAaMDgGJKBvQ8SlcsfjhIL2m+ZL6ZgQPP9D291p+EVQMYyA/hTtsB/ow//DHLwgcs15Wa74
	lezCKMhjEtemSABhNmnKDekMstYjdWzt2VZ5OzKqD4WuQ==
X-Received: by 2002:a05:6808:244e:b0:4b8:4703:db92 with SMTP id
 5614622812f47-55f7f94cca2mr1400315b6e.27.1793105007113; Tue, 27 Oct 2026
 05:43:27 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im>
 <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
In-Reply-To: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 27 Oct 2026 13:43:14 +0100
X-Gm-Features: AclHuK8JNetJf6-w1J-y7h2rb1ATzxu-yu35gk-qQOe_g6XfhHkRHp9dnPFKp4Q
Message-ID: <CAP8UFD3Y8ded9U7pzVi_iH8YgAsfpbuZV3NSqf=ySOgUKuXbyg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] odb/files: reload alternates on retry again
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 2:48=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:

> In any case, this patch series fixes that. In practice, only the second
> commit is really needed to restore functionality. I was a bit unhappy
> about the performance impact of this change though, as fixing the logic
> regressed us from 180ms when looking up 20k missing objects to 309ms. So
> the last two patches do some optimizations that bring us down to 197ms.

It looks like some sentences in the above paragraph are still related
to the v1, especially:

- "only the second commit is really needed", and
- "the last two patches"

Thanks.
