Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793375032;
	b=SWWrG+Vru3biratv0oCmHIDmcyabzwT0WS+DeF+itgJ1pTehDeBLRnZLQoO1ZygRSBNJ
	 Q0A5L6fFG7BlNNfC3c8snQ3BEy9dSnMrBJ9WGGIF5Rm3xmuvZuYf14t5x3Syy5EVpBnfK
	 45StrpcGMChK49J0KaqubtdTEOrJwb+yIppQSPYcdwlrmVgo+wVuB7o7MAM8BsxWN4xVw
	 tAjUt9yIPxIIMOkDVP+fqGkaYg3CD2bh54B8AAJhM2XLw9XSz5fivmGfUvLqaPbUR/C3v
	 jUrBkojs4XOECESSDjwvdIA+AyO1VhBTcBt+/tyUdAsheTxSELca8lfuwEL02RArsMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=5A1G7DmyQjCY04RV3LMCgRJUnJs6X5k4HY9b6kXmAI8=;
	b=Gdwq+h1BPajjadRGCKcL/1D3rz7rW98ECaB3v6jvpYRGk2SDdWDspqkVSrqBCoWAi03w
	 ZfrNGDrPNNU4Q/auod2WZy33ugE9dujF6ee31GPCjZZrIeJK87T8dJsGOHu5qlkLccrMc
	 aihs5RBnTUk9yHzYdsdn7yW9xAZKto4Z7xZg29vfFMHJuGPh0oZk2GXRR5kihOESnK+af
	 q2L27xTXOTeoQMB/e3f3/uUQscOABllzo0FSMBdMdKbUAJfu9+nKDnWfkoFgGzT8wxpua
	 2QFEKLaoJILzqqpGq1KKtGiyQ/akONMSu3sr8XXsgm6Qz0Rv7WppiZzYgAdQIDyWwJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=edubMDlW;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C76606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 15:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52C76606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=edubMDlW
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-84a248254f4so626290a34.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793375031; x=1793979831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5A1G7DmyQjCY04RV3LMCgRJUnJs6X5k4HY9b6kXmAI8=;
        b=edubMDlWx3BZLF9T5YVQoFaDAgBmKPvtu1+V7mgTE/IPWPhIfbFfXwNfneTYjVisOY
         FwA61/9dJefsAHdC6YRz8ZOdfraFT+yn/HlM2DsJaZhpVJi4b0Zgs4gxMWudM2VyafwK
         9foJ5KFGpkBjiqh+dfLIIGp92xt9CDpvCbORMYNkvtERmG691BEQVRAgEaSmH3CoZU/o
         8jibNCBbilWCmPFWj4fUR3zhpkRvBWgScHEEwf/n5WKgRy2FI9M/yTNdxflbu2NW8b2N
         7fnfYVbtD4mKCGCJmyYCAuLIO/V+XLG0hMwAA2yNXhecCCnjtsCFYnH7rQBkh58sESY7
         8Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793375031; x=1793979831;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5A1G7DmyQjCY04RV3LMCgRJUnJs6X5k4HY9b6kXmAI8=;
        b=lTMdh86bD9BbXQmPOortJeWWEBRWUGDLR+GS+77i5ZhQrLx3F21Ifa2DpVWt87+NU7
         sif9ySNwahfvjgM7hYTomGxy7U+b90MOr8aqglKdRYM/kIRhTW83s682sL9a1lndQvQy
         CfDSYMEEVn+HYWqDYgr1oaUMuvP4tZmvqMDqgoCoNEPTiuSX6tI3blxy5yIuBwDnrsAd
         EI96ASh03D+Tb86ARAKZtsQYZ1AkIvYO7b48LPdxYxGFNVDbU62ZXxnjPKw+ZEM6/LnU
         e8xYC3I4Pt8Bt9mHuhZ6NJ1l7dcH62ftmduA99VFCABxl5jm6R8E95ILHw5ZkGwDd9Sq
         M50w==
X-Gm-Message-State: AFq9FYJSaUNYLg94xFC0PYLHvocxcuYrKo1oLlvE0zpU7LBWuJzpGAgb
	LSuOaaZyRe9YYGqSL+G5g8nol9gLnpis8vpyh8Tl38Cq0Cwg7ffEgFYffTXq0A==
X-Gm-Gg: AYBFou0tX+93/Y5r0vRfvYfTh42L+mDQITOljRl2XE/gdemfyWpOUuZu2f7O8ELaEB9
	8lyjgY2QKUB0rhF418NoXc0OKfkQYFB8BtUcQRRy1q13UgtxqyvgWyi5wyg0W/tNLF5A2j4aP/z
	R9Mum0tND1sH3qynV5sqBk+U1YhegARAS4jhYX6oJXzVbhbEwu6Kx8UjTG4IFzJ38GUswcYIick
	TNLZn5L4BNXh1B9SiQRSU0KRUK0RyvLQQG3CEcvpQs5zWtM0CAK+lT7NblALTM5W2zfdaIi+PA7
	AyTS8phwsqFIMQeqWxYt0CWipAR/rY97GHhGeovknI5YltuUhrzAnM3IyTFSXcdGwcpZ81Ox0TM
	UPQl5Bv+nx4HGNe4SexG3qTzYlY6iN+8vewaKTvpV7VT2MkqSWbJoat7WAW2aHoBDBxZaxO3BxQ
	b69ByVGdaTG0+xL9voXrWbRhJbTfWuK1NHa2+17AltObt3ORxM15ZQU6dUApIkYD/mWihRXsFq6
	PRUFrsCvf7nlm4Mn17fqJCl860lynHMOpEqf7jUEvxMwuYSkgmZaqGTg7PZmgydK9c4kykT/Lr2
	Z7SmQ/7ielBa48EY/tfYZTqxdybFyyc+8nBo9KM/SJ4hiMdf8g9VQg==
X-Received: by 2002:a05:6808:c233:b0:4f8:4a95:994f with SMTP id 5614622812f47-5640df40633mr1995373b6e.30.1793375031285;
        Fri, 30 Oct 2026 08:43:51 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd9888bsm1869307b6e.5.2026.10.30.08.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:43:50 -0700 (PDT)
Date: Fri, 30 Oct 2026 10:43:49 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v3 0/4] loose: fix migrating "loose-object-idx" with
 batch fsync
Message-ID: <auS6c_Ov1JOUtr4P@denethor>
References: <20261029002413.3291184-1-jltobler@gmail.com>
 <20261029232220.1245827-1-jltobler@gmail.com>
 <CAOLa=ZT_ZNcXztxE2gmTORD2o72f3u2i0Ptj5tgNzS54_V1MTg@mail.gmail.com>
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
In-Reply-To: <CAOLa=ZT_ZNcXztxE2gmTORD2o72f3u2i0Ptj5tgNzS54_V1MTg@mail.gmail.com>

On 26/10/30 07:38PM, Karthik Nayak wrote:
> 
> Will dig into the patches...

Thanks for the review! IMO, I think the suggestions left are probably
not worth a reroll, so I plan to leave the series as-is, but please let
me know if you feel differently. :)

Thanks,
-Justin
