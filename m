Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793015902;
	b=ol3aFV0HBz8mWTn/z7G952dyB7eaqK/Ilcr1PCQgCOqnMrZ129fI4TMn6jNn8RU8s2MG
	 sZHIymXEMi5DbsHeH55i5/s1me4kmY4/8vHzh3GDPQUf+9eE8S/E3zaxS3T5fYMTsBNGu
	 WhBhbEM0zs1E2J677iDj7jlbd/ds2MQjFVA6lbFpOIoDhjBYJUE+o+t++mNtJ2k4h0dLF
	 9bM1eojZDGPVdUGJFI8pKfrUfQgxxtrtRZ2M4qNRJTiwj/0xVPo4TbZyyloEGWOXJVX1N
	 8WAl96pQZzIxu/x4tPVm0ER3cy1Yom1oNdjo+mqEtllhc6/93Fg//FfhFXP32i/B94w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=Y1wk/+NZsxPS5hWblmtDIMb9qmn/lYMpx4cTIewXhW4=;
	b=q6PZIJ4sCb98g0TyAGiOlet21a0jMQuAqigs4rWrH2H/I9020yVNdJsLV5bbWf8+oA3S
	 MUy2St/fmd/jNADrNH1QBxawiB2v2o3BoJdGoWfdmVwH4n+5PdR8/U8sI10NgiLnnizmn
	 q8Fr0yR4z4Sj3nqW1SucrVwHMsSq7xhat8VgFHtUqZII8Pj/+nxzK2i6gYr0PTaMDgqf6
	 QYUnj+ItmBRsvfJ3UCpYKnJK36vgC8AsbipOGRmeIGI2W+opxPao6yEAHo4qqbAJr7JNj
	 aqQM3aNYe0XXPFPlqEK1PWO1KSAV0onnAbj0c0R5fQE8A0hIShbwMUxG4B0rb2bYhvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s7ZQXee5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60D3606A31D
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B60D3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s7ZQXee5
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b13c7bb0deso17244347b3.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 04:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793015901; cv=none;
        d=google.com; s=arc-20260327;
        b=AosIzHWNWUTodudHghPbfsJJM3CnFalRNCql4JuTDX4J1aBZjZRXvCqk5xGDv11XGU
         TBn2+Z7m1Tqgb637t2o2Ye8CQzWbt1jZsRfC4nw9eos8Y8VxU5YCyT2dSlZEdGFvAMx0
         V6RD/SGsozMR4Xq7Cl911JZsofE5ICMt7YSUPjQSOIBljwpjIWut7mHHVDFr3mv5Dxnx
         fxSPJTGTEyDJc48aJLSHoEyLJeAHQooLbkcZ6kkmp7ii7W3eGMir96WYrjtBwNn4t00s
         uk3UdAXPzbyETthzYRsUTYYEdKOrawj58qdPEgSAnKw/LeVGI9Z/v+vRmSGHl1UCOkfU
         ElVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Y1wk/+NZsxPS5hWblmtDIMb9qmn/lYMpx4cTIewXhW4=;
        fh=hIzMqH9vtF6hTCMPH1CwC4iasS4kLBtDt9YK+UGWA84=;
        b=V/VKFEZpUwghIwM8C83oZh7ES8+U6fnJ25HZMgSkP3aw2Xf0PSXHN2p8og/KqGtszK
         97TCVRHy2DATQoQaEw3RHv7N2xOJY5NpN50CHQNM/Iut8bj/ACYP1Xlmp8vAVz3KKG2D
         odHmXh6KeGD/JaB0Ph74iIlyK+qskLZRtT0Xy3HVA4x4P5M+2c/Y2v2bTAtzHDGo6GmM
         aTDAzRpZ4GsTRQhDFKSYXvCDWA4NBslFU3peILwEMLaj4gY28YHTJ9Gh0CoWYhuUmf2Y
         RWEcpbmElYVIoS3gJHCYxH39fdrlgQOJEQmUmYC7p5ejbwPkKgvnXerqo1seazxE3waO
         RgUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793015901; x=1793620701; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y1wk/+NZsxPS5hWblmtDIMb9qmn/lYMpx4cTIewXhW4=;
        b=s7ZQXee5uVeviMzy3LMbBZuSrtPVAuNofiPOlHKPu7Kw68KUoGTOP9au/Kzf0z39DI
         JA70nV1MCDUfio7Q09oZsEx7kkXPbTvWqTeGt4qTU6YSN2N46yDIh6Y89kLMTI/AlQJF
         DKCqqkfOdlFHwLZCbnEPPThKuimfWzROuFtfIbWDlcAZIlUZ0GdaJeFq0goosbsWe+DF
         rAwcmtTZXl3jr0EgMWeCwDvaKcaSzsj2IX0gw/BeRy0ttsbGj5ti+DMqfp5e24HToWZV
         ZFykzLZmOyfGXpWkVFy9NZGBB/6PB0c7zkbSlmtekv2brDDi2ENuVctCbdpn8ZzagZjn
         ymwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793015901; x=1793620701;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y1wk/+NZsxPS5hWblmtDIMb9qmn/lYMpx4cTIewXhW4=;
        b=lPoO4g7fiOy5KVETSgNToZ+SMCY2m/+Ylao4ufaqWBsjqlKUqS9l0OPRARK55e79ON
         X5WQUFwhjx30AySmkdH+k/zjoyd2lOUfF5dlbG8UAqlCfLttF0t0rBa3RG76jmVlFnww
         50NOzqXzeaJlAjhHvFCWu8SLM04JNGpoiw3h1HpD9b7xZbkBObmjCjc4B4NJejnBsjj0
         cM2QhG++7dK4AXCc+jOJvRdfGavz6F+GDpPBRGXiOVBXPyTOGI0aXtvdmsDT/hgjiE0S
         G84NHGzKrWCjIDmPYQ7VYdBx2Ev1vidGVgrJffBwdb5+aAzsEcQtvpH9Be34bcai5Ktl
         UCwg==
X-Gm-Message-State: AFq9FYKnBrs/Mw5l5za81D6GedSG4y1YXeZFo3Oo+tHnjeTSmVDaDFDa
	mcrct0TEXzNzoF5mOIqNQ9J4PXcnV2c8XzH21Sc1xbReZu3xo4mIz51jnSZp8XkNBTqlwKKUGWB
	MUXFFi6YdJ/eXsK17hgLk3OJ3OdCFtq0=
X-Gm-Gg: AYBFou1FoEO+/l4KLwla5W5Turtv2Oa8xBTRAa8xVqK6sCg+fEvb8Zt+jVDMCcRD2B7
	sP0SPXkR33WA6G0AsZpinaM3VJ01Hkfw1ZNd66WT6XwL73TUceARQMMEC7Z6TCEI0NJAuo3YJe3
	56qiEF/yAZmzdmyFK2x8xrC/N7y2uRGZ5LAQDNsS9zA/X04Ul0o/A4PSmc0coAWO3J+dgWcBuNw
	wOjgKXS34MxijKnUb550+gET6OlEP+2AApiGtHl+thZGBzec9A7IPhIo8tDlvUWvfAdlif2sTCH
	BMYZu3X/E3ThCL0bbgN6ayEvhSAvTTMXuU+ud7hv4cVWETlSmYoUcmJy2jret4a9xgH/D88JBDR
	TPfCdhKNG7ODz2IGdmUjRRNRdcU0Cwl7361usvfMxXsRcqA4SwTJ65aod92/UUTB3KahZoDOF9W
	SSdWjkWpkD1b0njHZ/haux0ZLcRwGNOGVpTMOHYZWRuIGzM+j/s3q0VusYOxH6i7V+9oK+WAYdI
	oRs6wS6Ssr+iykPs+AhVrdQyYuFfUkZlR32NCGX
X-Received: by 2002:a05:690c:15:b0:8b0:adb0:b5fb with SMTP id
 00721157ae682-8b1669cb314mr47752537b3.2.1793015900638; Mon, 26 Oct 2026
 04:58:20 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024221341.92086-1-okhuomonajayi54@gmail.com>
 <at8w9u6qA1dhmw3r@pks.im> <CAFpMFfDaVf47QKkNROJAHJB7oJR+iPt5gkkCnj4KdZW_9MRqGQ@mail.gmail.com>
 <at8_ebX7cYMrlhU9@pks.im>
In-Reply-To: <at8_ebX7cYMrlhU9@pks.im>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Mon, 26 Oct 2026 12:58:09 +0100
X-Gm-Features: AclHuK-fcs_oc_7eofq2rItmpX1PSbLAGTFUad5QqtZ0EQ6Mp2WLT4AUQeTuKIs
Message-ID: <CAFpMFfDX9QiEnO3asWMREXmE2etYuk_NvgqmfgNUzP4cYQRMDg@mail.gmail.com>
Subject: Re: [Outreachy PATCH] diffcore-rename: stop using the_repository
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Nit: please don't top-post, the expectation is to write your answer
> below the parts you respond to. Thanks!


 My bad i am sorry i forgot ;_;
