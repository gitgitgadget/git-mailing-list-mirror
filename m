Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794612365;
	b=OKfW8xxKQKCxfSW4veOGcBAmjR5ChFn3tBlttisZt4mxGEakq/zN7INrDZOpKvGubqL+
	 BDOK935HhQu92Pf/yEASfz/CZDnkhHy0b5OAt0bG3n0d7Tc1o0FwLiDmK4oXC6I74xHKB
	 6b+hibuUyxAs+yaCsRbY6xFzjBKQSO4AUf/t6TjZyUyjDwOXWgDdi6MvV9G64rkBXKc8M
	 lEQiNde9JZRcBJ7cFXjGa7T01hTiEtTi3DMdknhIGwe4V6ksiTPKshBt2AK+2cBEjiXOI
	 tBLhNDxEv01d8Yf8FO8o3HF1r6XTs9qUpLPMeJAD+C34uhun9L2jtVmc0bswbDah8aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794612365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=u3ODy8LPgD6dBFkcRhd76QMLfz4n0I69jGj787E0vJA=;
	b=0spr+4BvwyAqZwz4FxiZGnLU1Mp5pRXCflvh+RW8ciAGqpvlEG3b1X320puPYV8F+V8V
	 xHUcxils71Ft+V4AClb1VJxv5j4WvvXLWYUyCpLReinq5oNgoJsYFRybU98A0i/E4BGbz
	 rNXV03krHa91PHNK57OtO8nOw9w90QhM8ySkR10D/FTn4y6snD7njJDZX/DJcX6X3Di8d
	 8k9pkeONPXR6wmN7WwxEo/6AuTbcuFAxBt0crA+zzY1njEKz4LLOwI4AQNjBOgFz4JHU9
	 iFV7mjOy+cK3wvZVxo5e1Vm4wJXYixmszF5KBNwSjf3yqch+oX0sdEiu/9sWDZS8Vmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nortesoftware.dev;
	spf=pass smtp.mailfrom=nortesoftware.dev;
	dkim=pass header.d=nortesoftware.dev header.i=@nortesoftware.dev header.a=rsa-sha256 header.s=google header.b=DA30sazz;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE4606A89A
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 23:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BFE4606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nortesoftware.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nortesoftware.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nortesoftware.dev header.i=@nortesoftware.dev header.a=rsa-sha256 header.s=google header.b=DA30sazz
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-716c0217635so2633504eaf.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 15:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nortesoftware.dev; s=google; t=1794612364; x=1795217164; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u3ODy8LPgD6dBFkcRhd76QMLfz4n0I69jGj787E0vJA=;
        b=DA30sazz05jY0uQQq0CA1BArVr7o9lZ8yLyFGPFyVfPVghGNyDoA+sVTdnhgwj3/Qh
         YXqyM/TXGYfsg/yGNpdrDyjEnxDZvtsgVS0DwQeO95oQxR3rhHIkZgIAtL8PykOVwPMy
         1+H8Pdpr1L4UGwkFHhXTNvfon10UZGO7x2/ltznx22MS2Z6D8EpZnMXqkOnsiJgNOMNR
         INRLXimjoAXKZegV8jVUDl84iWnEBozhyow4p0gvBNnlGtPFp05ImKJ0mQmN6x3661b0
         bkM6AVg4JTLVAcwHMAcVG97eQcbWOh4m9j/v8QRQ/WzXuxiJonwRuHlqrFsdT9Hv6Bqi
         TT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794612364; x=1795217164;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3ODy8LPgD6dBFkcRhd76QMLfz4n0I69jGj787E0vJA=;
        b=ZZUu86Kem2ie+jiR05a+ILicSW9bXHKHaxuiWlokfJPHwgmG8MBazl+k4RLQugZQJM
         qxfTjQrrzVbhqSl5c5PXJdERRc99ThD7LAt4loHH32UQkZA+l3o8GDhdgvyKIezd0fBM
         DFFgt742Z5FDF0d6kJwvgHQA3yyJBZ6JEh+xNI2Zs85/ATb492Qj3ioyXMWkV6Ry6CrP
         1sqmZjv48cyzm5gZvnQxLMUhIj4pxOuIvqPhJiacB0Vh+9i3yHqw3XxlwRv3knWyNcOg
         FPUmzGVCaaOkWeJV7c+6XnhJIz4+9wCTerkDOdaschA7638wmp+0JBeaR6Zz2OOykfCc
         LZ0Q==
X-Gm-Message-State: APuU4Z9H5fKIhlOuVto7Nli5kYnX291vTKlOmfHEBD3S2U22lRbn9NMF
	WCaNe1vLt8BbAxAkLaBpYY6jOBG/mJ5lKtg7dxGUVPZP/Ky292pikjFSSc7egKZCIYTj5eEfAp2
	rw2brGDgr
X-Gm-Gg: AYBFou3yW+IQGI0RdQF7BHhXoCcIL9PuWqrQwz9N94JugIYTc6a3xvbBwMGQQtKm+lh
	A+MtxDF4XRTFFUeEEMaiaK1+v0SsAUG6eNdOAvbIaDaZUEtAXDSYDL4YDIqYi9nSxCKJR9PMyD5
	1gu83+8r0mF3Vy9zvuwmySuE9T38vB3oPG0c8QdYTTy86Nm48eae4qZib1ete0eck9CDw6u8eDZ
	vxRz8dq+f4qPXF6JwtNckGu3OXa+SBtfdmzkQTh+FuxJm4BUGnDCDkQBcox5NBHU5fLhnQ23Ebc
	ixCIz8VpQNc2RLX0+VYNFowiaNvK0HOzwZntdWS/l+Fb2gG1zJ2NTHDe/XGsz6Nx0KAjzF83j5U
	TdhJGoLHodQ/yhEneyDeoL+BYDRtLfbjy03LN+ePHfimlR6dOam4J/tH95kHKyDRmssj366asSU
	RgnJjN5lgLVvdidmK65klrattnDFEIgTgy8T1oy4Z1uDAjght3ryA+vIJ4pXsXpFeRHPDzgYTM4
	29qyICR9aFHH6pfUpxvp6CH5ou5WCp2B7yJA35sO9JJIUfRkRquxlkv3Yz/1SuOqGDS5jzKHdmj
	A9D997sfdoab6XMBeCmOHE6dK30USvfX9r0UX+xy3NH4JzLdAzsPC37mGjp3Rzk7aRd7lt6A9OS
	H9VeOHIlPhvYLZq6rH048N6GjnwM1f7zHLsUjaF1AE73spPyJAWt1zpMxAw==
X-Received: by 2002:a05:6820:1991:b0:70d:a1df:7dc6 with SMTP id 006d021491bc7-7197cf4827emr4638386eaf.54.1794612363961;
        Fri, 13 Nov 2026 15:26:03 -0800 (PST)
Received: from nortesoftware.dev ([189.150.57.229])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4afe2206d6fsm2284276fac.3.2026.11.13.15.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:26:03 -0800 (PST)
From: =?UTF-8?q?Christian=20No=C3=A9=20Ramos=20L=C3=B3pez?= <chris@nortesoftware.dev>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] gpg-interface: fail when the ssh revocation file is missing
Date: Fri, 13 Nov 2026 18:25:09 -0500
Message-ID: <20261113232552.1325109-1-chris@nortesoftware.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <xmqqa4o6oq1y.fsf@gitster.g>
References: <xmqqa4o6oq1y.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> By the way, it is not a problem this patch introduces, but the
> comment at the end of this block is a bit misleading.

Agreed. v3 replaces it with one comment at the top of the block,
which says check-novalidate runs there only to display the signature
info.

> I wonder if we should be able to somehow fold this into the earlier
> "if()" block, making it the single place that deals with failures?

Yes, that is better, and v3 does it: with the file missing, a known
key gets the error and then its signature info, as an unknown key
does, and %G? gives "U" for both.

v2 went out as a reply to this message instead of to v1; v3 will be
a reply to v1.
