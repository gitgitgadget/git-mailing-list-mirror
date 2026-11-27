Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795787586;
	b=MpAKatr4EIDyRHy3piHSjuunb1n7EtZ/wrDl4t1WpJq2C2igMGdZPDPI8JknI3smCEnL
	 27RP1zajcrfVB0wUm1WGMLLzA81TJWl4yNqC1tHYpCC9KV8/NZF36bLSNSoQeEi4bktIq
	 WugKBps5dfY65nEQVqjq7S7vT9AkDCLoFHe79Cb9GLCV3r1zSRJRwhWMjsfRujyln5lCB
	 Lof8GvP6353M54decJvzyXm7cjDeF44FyztkHWaxyD+oKq4zHR5i8fVoZH9lKYs1VMeuO
	 8bfDMgNcFE7tYV3CPAgXsz+MvpD2+MBoIuZmmUHIYPHVxP+xxaivDzw04AabfTc74ZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=UHAmvk4XNXxQs1fvHIyUdxATO8G+FAhSozaKP8Akh6w=;
	b=d2sDwfmtRaEh4iQBv9xpwyZL8cxBCnE68Uvwmmus36ZHKay5Ez/y7rsQKrZAvKo1E+wQ
	 WAfkq5Wh56O2+nbuDZg0X/ynFXGLI7qiIZKKIs5K79EAYPveohap6tExVieHo1/ZRvEGA
	 bMx6XDUqpSa8Y8S1OqPIr/px2D6MaFxjqMTZlUXOSxWMMWsrG2W3Q/7VJ7iIvfwg7Ikax
	 jgLJ5wyHEi5iScwvRkfdkKXGxMKx7CBuANLCmtImQ1JH6gdqam2rW1i9eQh1A+1wt2jgm
	 O4Rst13C/HYaSaN2rs7kj2Ln6mbuHy15Np5TfhyxmLwWLk+SAEUrhNjMLJLOkuy6irw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NRne0pRX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E5D606A326
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 13:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77E5D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NRne0pRX
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b4d5e645d1so50574367b3.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 05:53:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795787585; cv=none;
        d=google.com; s=arc-20260327;
        b=YzOarbsFBkOL8HNB8pk9EF85n1LXVxD7q5WeQuvdVfWLubibFFTYV9HDrmCSe4O3MM
         EvqLVAjLmgMtPeWj1iav2naw1z7OerkgHR03Q4aE4NHbeI9f/rvdztsBZuArzV9kvoGW
         PDMJgiIkxtdQg62t0b7HAnEVbzt2+4qTyIoNOmEFWX0xC17KtD7lWI0+Ktvfs0ah9kYl
         oSazNZQKi/iY0JTMaWE3yyWLI7RCigbggQUf64z9AosOcWV8tsXovFE7o7dOC5WOayMr
         Q7sqRF64yXL7+3VFHY7A3a5fGnmPaW36GGujJG8zDSCwjjQzJqYxY4JPjzMBPZrzQpzd
         jScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UHAmvk4XNXxQs1fvHIyUdxATO8G+FAhSozaKP8Akh6w=;
        fh=0tT4Lf0zTXOJfjJKq2/bzoPcX6phxAl8TjTn+DKN3A4=;
        b=RK+WtBZ67aHApgcZ9ql0D2iOYFm9cnLmtCJ0mL+i+0D/brmuh1uyXxag9DHMUAE+VO
         85lKz2ddg3a5QxrVs+AgIhYcng6dnYf3gdb7I8KFJ0an3jRCsC8ziq/7lHSTQ2v3NhDs
         wVEMe0tTpaJEnKkKheLyJcpQqeYkexxlLfLx/fkICE39I46DhR7IXXqCaJV10ME1wKWJ
         bqAWZZh0yUo+zXSCoT+HMQjWGaCwPJYOWwWOPVDRP25XYpq6oNHCeR6MfIWESzlGRzF0
         PvUjeOMoEWnd5E8j/37ncqKZ/2iD0f45ymtJ9OvySEy+Q9b1kB8y3WuM40IyWT3IojDX
         RjHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795787585; x=1796392385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UHAmvk4XNXxQs1fvHIyUdxATO8G+FAhSozaKP8Akh6w=;
        b=NRne0pRXy/h3Qu30vfvjfXR1wKmuCu8hoWtMdggUwQWG2B3SMNuWw/3Kkdw2GHSthM
         PxprrqZASTLfq8BrHHL9HNp/wknnKmnkCO47I9WYFCUUu+RMRMV0CSgC2zb67+t1ab+W
         jjikK3/EEm7SGrXu3/GHQFp6/QE/JkzQFAj0LlDUDqRXX6U0sJ/dyxJ9JmxDoYIB9TQ8
         ZVnXQH5IV2lqtNXxj1z/VSYSQ8xb3/TlI9RdXJucHo5WEoXArOcZFkj14DOouMVje3RL
         PDfhbM41lhX6SMc5w8fa0ECvOa4bKgni4QjNHTvOvC8267VpuhH2NpSioOFFFS277ZuQ
         MKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795787585; x=1796392385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UHAmvk4XNXxQs1fvHIyUdxATO8G+FAhSozaKP8Akh6w=;
        b=GRThZE56QMOxr92bDCVTfDydRMq50XxdscAZw422IdpWmngtZJew0tYHgf+bZ5ODBW
         B72vqCRE556oei9YNG4zm7ujaawosmKUmyjD/9oSersMcy+VocYDZBBVHYNxyK2tqSul
         5J0Exvq21rx1HmfV2gm5xmCUX6OBz8XsBWpr0Vf9cUrKWrwU1hUjB2UNb/yeW70HTBih
         5exv+0N8HTnM7NPcU7pgV+7S3qcmoneYw9uzw97N7WbVszz2XI3R1DCJpAxnUeQ+SHk9
         Jn7ONM2cg4eaSqPdeY4v/HBWFL0tOIkjXbu3wfeDMiQz4VrK8iGvMWM0Ej9I6IaYsfH9
         7zig==
X-Gm-Message-State: APuU4Z8dWxe9RzhTCDRhLhzQFgC4B33sNfFTAwokScNvvX4BZ4ww2a2f
	fYg+AYAnqUgD+R93ela2WrpCSmIke8vlhoMFbJXLtQZytLEDaqT6rxvCokwgTeqPA0ydb0/Rn3m
	7Kd/agV/aSVTnKpLC/HAPG+cIwe1O0vE=
X-Gm-Gg: AZFdTZeaSnJSYZ8F7zt5MaBXuR/znPrwK9K4VMiHiN3sEo3aNv9P+MeuSbRVJ11zdhx
	hq6+yGrIYOx6YV/QrH+WxMgggkYcqgMFmX4Y4O6aiXgXHDgwih0tUSBnxdl3uTsaV3ZMGCFgU4A
	pf2MRQzFE+wfN2UWjCuv5D3PiZ7k+Snz+fbyrL9t0SEUDl8mYGE31MIoYJco6j0t1GURR0lZzwG
	k5YRBC3xyinab8KxuFC0SnZdVGd1bvCiO7Xuyqv2Ioh67QHz+zfPUgkdLp6c/OhQv72RyOMFhFh
	FVKOGHEDk1RQSKrazHKNeyLZYNzlcBWoAQAYZtT3xV1VDU9HF0s6dMpk80SR93XEwD5i4OaKceI
	bwhGeG/O+XoDB3PvY8XOKQHE73MkLOCFSuJ1tSXKZKrbD+Mwt4Sb2svJ2lSsJ+TcDpCY2AiM5Ao
	DBqGE3PUKvnHYh3i60BByjAiuRTiqKLPxZLhXhgd+W5abwh/oymsQac9ur9Tf1D1rfy5O5g4lB0
	+F3wYH02wqcnJQ00obv4Dt2b1olrBAFqD640dnl
X-Received: by 2002:a05:690e:419b:b0:67d:e9c9:8e29 with SMTP id
 956f58d0204a3-67df44251e1mr7642005d50.26.1795787585455; Fri, 27 Nov 2026
 05:53:05 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124172146.18330-1-okhuomonajayi54@gmail.com>
 <20261126213306.87466-1-okhuomonajayi54@gmail.com> <CAP8UFD3wt=at-HEg58UREPio+SVbzEL-G8YF5E++Td+fuW86cw@mail.gmail.com>
In-Reply-To: <CAP8UFD3wt=at-HEg58UREPio+SVbzEL-G8YF5E++Td+fuW86cw@mail.gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Fri, 27 Nov 2026 14:52:52 +0100
X-Gm-Features: Aa3M54rwBduXC3IxOWr6xMmoMWADNOW64KWsEYNZyNBKlmua92meUcDo7-wVx9c
Message-ID: <CAFpMFfC3sd7JkK-ewhvs-6g29AJzRMv4Crz0yTH3OSOFm=4LUQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] notes: start passing the repository through notes.[ch]
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 2:22=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:

> So in case you send a v7, please make sure the "In-Reply-To" of its
> cover letter is the message ID of this v6 cover letter.

Thanks for the review and for pointing this out.
I'll make the necessary corrections to the commit message
and ensure the v7 cover letter is properly threaded under
this v6 cover letter if another revision is needed.

Okhuomon
