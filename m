Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793471842;
	b=IrCRZooOSSxP4n87b3NsJ4zO6xKTDk62DaF5fiJTIrNGaaY6zSTlnfC303Sy/+dMYnc/
	 eQ16SNwymwLemqF/+KBy1DqKjP4+GIKlhFzRAESvjdu7Wnka446vcx2J2s16fxJ2J5oOp
	 fQjoazz1U7j2zUcBDWUqfNKspl6ElKVbOm3pPBvZn4rsI+GqbzCDEiBeGiir5ByqCOkED
	 RwHzOUc2ok6FvlsQp1KOGPnn8P5jwX69iqVcakx+Zv4HhWkWfKlBr24AEX6CxPyVixGAx
	 e0VXIetHeKJHMd4HOcS1+16R4FrtKRDkJuUeU404vlyVlCJJhnfsutBAC4nE0bWSing==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793471842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZyEZ/y4bFwl+PIuBuyJZgm+/52lqoHYwXYqA9UH1opw=;
	b=mwnUetvNZYIghOPkNuDnF7xft9BTMQtUhcu24gmiu2Yy8qzIOW6jpLFVoEX9rTKJwf1l
	 awmPUE6XjmOaZMZ4hhM0qtWjKvk3K3+0Wh+3MK/MTrGOdeALokQyMw9Z5At76ahl/ao99
	 UD3w8C25G6anl+eH5avyx2IoN0GD3TFB+Ts3nJVxYVwg6ScRvmdu4aVYUr1KpuhoS5Htx
	 4pNLhOP0ZmDXTLVJRmxTbW5tstGDEkC8x9opuWAsCy9eFxfnScFeZxC6k95VqAX8fus28
	 c6FeB/cikQsjLnUCOClXddBgmQIzI03BgBput/0UDvwLI4ujVnHZfsk9rzlr16F5kSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yi8SsqJ1;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CB6606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 18:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5CB6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yi8SsqJ1
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48afbd2c386so954779f8f.3
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 11:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793471840; x=1794076640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZyEZ/y4bFwl+PIuBuyJZgm+/52lqoHYwXYqA9UH1opw=;
        b=Yi8SsqJ1MYXPXIaEGEprWyIIqIFeJ7KyBUpXuW0Kz367S4K88qbwg8MJSJce2jkYIe
         0MFkroEyuvVcOsG0CK4omScCQXkzk8qlnDKBfXK1a5EIj4f7HqPrv/Sl2HsErvwesfg/
         G6QexZEu/khfejwgenDZl01OJ6eZI8mwbsHWfTbxoOffEZykQqrgv+gR4xCyyYZ7/pBg
         HNd+Fc+q90gyOwKz6YjV+ql9y1n711IxjD+TN3z+LrvW72FI5yDsdooqsqOcwWte15Tg
         ziMFsvAuVUgXKinAzAD3LLDMvaq6CyO9HCOlChBDUKFFbMniHcmPFWdvq3xmpHCcviQa
         jlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793471840; x=1794076640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZyEZ/y4bFwl+PIuBuyJZgm+/52lqoHYwXYqA9UH1opw=;
        b=pYsgVNlKYEJzRmt/Co3L8dDXSEnf2cZWZCjBytS+rc+C+Em6c/hXrFiG++sXblOp0I
         yTWxUyD+DykF3c+XodDqemTupwbAw8UW3wARbHdvT7jwJp5l3oVBnjqN8+G5iTwWjkr2
         eD5xS0gxj/bB8d7D6cT/glqadjpKwj7/LRTEPuSVDSv01DS8wjVzKNV00dUE6wX3MUzY
         6svfJDi4Qd20jYzfr1N/1YutTJO8um3zLscju5VTaf7kBZVWXiNXQTmlzMSzcQRvSuM6
         EyWJONY1/QRmv8z2o0/2emfgJyzVZYtkAvq8koCM0UYxy7LqGgYDZbIQCyqScPs/Qu1E
         10dA==
X-Gm-Message-State: AFq9FYKTwvX3MzY4lXE5MGX6q4r6I/5qrag51R4Le3RjR62M71hI3SsD
	PPsQ2jF52/Etg5j5o3LHxVLXj6segASAUX1kkb0F/TaLWRprHmiAWMvm0Yc7tIGO
X-Gm-Gg: AYBFou1+AMz2E+fI8GmwbFabRL0OE6lPewY95jKVvyiD0NJPhhPNlveEV17RDs9+6j7
	gB0XlBEugJKZTk//GAQKf3dL679MAhQvLdYAIAWjjAfOBCje2YFdKBoFgt97czDViURL4EG0Vz9
	BR+fCpLGqqIzExmz828Y1qNtC130e54ay9CI+j7f8PU0uMGM0WojobjzC53gU5mF525Myy3DIO3
	D6XI7WuHwVEfl03A06BGcylvXqtlMUB3KitspOEtL2iCh2xykbvOeKtWdYwVAtmkSe7j39o8aOU
	v2RhD599eQibZXaa+PzJvm/FuXF2WQh78Akw6UwJcT4yBlJ3iWZykRUFA4Em8OEHTyYTu8ymc8I
	A0xdXHrlH/GaKJ+qMxUT8s2UnnyI0e9qhUiFPW1dfCm0sbWOMT+use5q721h0EzNYK3wmOTfiHA
	kpoDyLfHSnEHsnVuYdsyNbjVhVQWvFGWwLSg/dFX6OS4JmdizLWatBGt3hhHHcRGbkKGM37TJi+
	qq9g71D630Hxq8t6YjLoPW1s/Fn3iN0LTMEa64nGXadGwQnHSs8mSSqV5E0B94RHo8H7yi+hcDl
	pStKf7I30i8KAP3/ZTEmFyjg4CIUKu+iT0T+NDRGKZLdyTmuaemb56FieUz6b54=
X-Received: by 2002:a05:6000:c4:b0:487:27f6:a4e9 with SMTP id ffacd0b85a97d-48e6e506d26mr10175522f8f.57.1793471840091;
        Sat, 31 Oct 2026 11:37:20 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8a7d1sm10047872f8f.38.2026.10.31.11.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 11:37:19 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: [PATCH 0/4] use size_t when parsing and checking objects
Date: Sat, 31 Oct 2026 19:37:17 +0100
Message-ID: <20261031183717.273904-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <b6c3c811-cabf-4421-aab2-f6b4b30951c2@hogyros.de>
References: <cover.1793444420.git.gitter.spiros@gmail.com> <b6c3c811-cabf-4421-aab2-f6b4b30951c2@hogyros.de>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Nov 01, 2026 at 02:06:09AM +0900, Simon Richter wrote:
> > This series continues the search for truncated sizes on platforms where
> > "long" is 32 bits (Windows). It covers the functions that parse, verify,
> > and check whole objects in memory: they take the size as an "unsigned
> > long", while their callers have a size_t, so above 4GiB the size gets
> > truncated.
> Again, reminder that size_t is also 32 bit on 32-bit architectures, 
> because size_t is used for the size of in-memory objects.

Agreed. On a 32-bit system, objects over 4GiB cannot be held in memory
anyway. The mention of Windows in the cover letter refers to LLP64,
where size_t is 64 bits but long is 32 bits, which is precisely the case
this series fixes.

>
> Anything that is on disk can have a size that only fits into an off_t, 
> which is 64 bit if large file support is enabled, and 32 bit if it is 
> not. If large file support is disabled, opening a file larger than 2 GB 
> is supposed to fail (because you need to pass O_LARGEFILE, which is 
> defined only if large file support is enabled), but there is a chance 
> that an on-disk object got truncated, so that is not guaranteed.

>
> So, use size_t only for in-memory data, but if you are reading data from 
> disk piecewise, the total count of data processed needs to be an off_t.

Indeed. This series only deals with buffers already entirely in memory
(in check_object_signature(), fsck, parse_*_buffer(), and the message
helpers), where size_t is the appropriate type.

Your remark prompted me to take another look at the other patches. In
pack-objects, the accumulated length that write_large_blob_data() tracks
while writing the stream piece by piece was indeed a size_t. That fits
your point precisely, so v2 of that patch, which I am sending as a
reply to v1, uses off_t:

  https://lore.kernel.org/git/20261031180411.257932-1-gitter.spiros@gmail.com/

Thanks for the insightful review!

Elia
