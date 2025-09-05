Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F391E350D56
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079653; cv=none; b=M/pxIVvWtDL2DNr6hR4jE1Z7SA8Oy6b5CCCklwF3mGX9P1O53GPX5o/tS3/UyNnpTcr7fcLuE1i4llUyosaUT4cL4OAtczdAHnhPxIeTiAcW67IFULBgw0uQcaTAKT85I0WxVisLHVk/CaA0gYHjJ3ePSRi0YRHP7HiJg70fHzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079653; c=relaxed/simple;
	bh=jZ8CqQZcrp4IJb5pnvDbyEjiI8YJ77WtPF4/8Vynyss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJSsC3U+VvV7G16wf0udZ6WxHe/eejaghcRTobzgw+G4/SQ2c+Q3t194P6UG96+M30bjpWzEJPLcMfiglSP0281brNdlAagpZ/4PmNiCZYgL2zBrIO1Lv9qgTDaopyvbJJMRoebQdL+Ts7VOTPxEqBiIxHqHIb+PNXhSlGrIh+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ku+SEEvG; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku+SEEvG"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-80c45a0b023so207324285a.0
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 06:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757079651; x=1757684451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jZ8CqQZcrp4IJb5pnvDbyEjiI8YJ77WtPF4/8Vynyss=;
        b=ku+SEEvGiYwM12kIjgcDChctKiSWfryyHig9fFrlfQM5Oy3ZqT6fyo64D1gY+HIDNe
         9tD5YEFJoUD4iiL/DP7Vm/47sOrSIXsB9mj04zzwu50d4j9U4eOs8nPc7fT+m0or8CBi
         f22yTKwlae3wSYwyfjL2Ap1vajT37Wbs5qF6+t8dsFVLkaXTtUaVNon5cZ4beqd5P0DJ
         I4kGdri6BKDUI+RY7YKjLJ5WHP3b8l4E5PKTMvfweBksCm18JFoEVVVBKfNXLXk1xgNP
         YWPG8mYfA5KpYufNhECTlwvBdzCz3GsOvBtFkUJU3A5f+zoWzAr5tIq+PLgdu/I0MPo/
         zXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079651; x=1757684451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZ8CqQZcrp4IJb5pnvDbyEjiI8YJ77WtPF4/8Vynyss=;
        b=Oggpdmg/VHdJI5s0u98NdXWevXgus+3T11u5wBFNdOsLF3IWYn/OIcvJcAquwPjHN1
         XSe7jHgw/kOlvTnf/ilJXiGvxglfyRafbZnprFFvynpRXFZF9ZlA6t7h4/eeN2MvCv8C
         UnxAcMCc7NtArkyttadZZbmg9ZV0TFQz6jQwSayG2EyzuQrKFdCVNFTrvo0GpWSlTybP
         bVSDnwyUqGQP7Gjh+TaolalNTEddKe1YUH0+OkiJ+xtIBvRm8Bpe790RTw1JeSrqSfoU
         tbKDafbE9GDg6NmsM5wF+IHW+N6KWWB49XZxtNqbEP2FsSL7YjBhjUT/cdzWcpw/r1Aa
         KiZw==
X-Forwarded-Encrypted: i=1; AJvYcCVg1E0ZqSiMq1uDyCgSNHkLeZakZvphecTH2dUGQDZC+8FYmYSFoYIv9hRHdxauH3zl3IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxEsKMueggIA5fzIQo3kraY0jSe2ynnGKtBtxmaKiRxYE1TkX4
	+j/d42KTLu+WlBSCcmrb2RPuWPvJtl2g5CRf9/E+1vZeonlurPvpYAY2KV97pHLo
X-Gm-Gg: ASbGnctQH8944iDqBTxPQub6R1pt0wmKAsX4dznb6umtvezyrEBncrA9lXI8ZFyNI2O
	1ebrIizPouUZvoYl5smgqVa+IomgZzV74juJUpcEqlhAsHtfYdN2O1ZHfJpPzPs0FFLafJy8wOV
	Hsw9atKrKqEm252zJeP45+XMSsBnybI2V3QpFFPkk250Bv2mCviWkqT20ju6VewDBHubNodyhiN
	e8J6ZD5RzQPf5n3VA+EpblNLHOp+PzdRHKwNUK+XftdTBrRA4AgpHp+CdesK1OQovgZHFA3DXx9
	0ACwNZJvq3K0Noz25llyBbA7aw6SJLPtkagTar50i+6tOTKF9FklheoQRU+gmnjV4PNnDCahFir
	y3AhsVgKvKXuTP0mfeMGsGeCYsRkCir/6AgQnyPP2HQ5b8GTX5swDsB00MwD3rfqZwMryoPE7ig
	==
X-Google-Smtp-Source: AGHT+IErZ25gV+eXgW2FfiqdWsERg74MYX9egJ0dNA3utVbKlHHADknNBucW0o7iJsJnYq6T+ycH3A==
X-Received: by 2002:a05:620a:4693:b0:811:cc7d:5096 with SMTP id af79cd13be357-811cc8c957dmr195712585a.72.1757079650679;
        Fri, 05 Sep 2025 06:40:50 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6de:d300:7483:aeb9:86a5:6b19? ([2605:a601:a6de:d300:7483:aeb9:86a5:6b19])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f756d16sm45197811cf.34.2025.09.05.06.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 06:40:50 -0700 (PDT)
Message-ID: <a1f72b71-2068-4526-920b-bab82137a509@gmail.com>
Date: Fri, 5 Sep 2025 09:40:49 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Doing blobless clone by default; switching between blobless,
 treeless and full clones by a command
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?=
 <dilyan.palauzov@aegee.org>, git <git@vger.kernel.org>
References: <79ed51fbd94ec2793ab0388b33963b366e48c590.camel@aegee.org>
 <2ebdff4d-8adf-45d9-8cb5-6d7ee39f218d@app.fastmail.com>
 <7713256d-e258-4356-b303-128fdb417972@gmail.com> <aLrWUhtCqp1hMcQS@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aLrWUhtCqp1hMcQS@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/2025 8:23 AM, Patrick Steinhardt wrote:
> On Thu, Sep 04, 2025 at 08:19:59AM -0400, Derrick Stolee wrote:

> So in general, the recommendation I typically give is to not use
> treeless clones at all.

Rather, I'd say that treeless clones are useful if you want the
speed of a shallow clone with some need to analyze commit history
(with no path history) for an ephemeral scenario like a CI build.

Treeless clones are not a good approach for doing ongoing work as
a human. They are a tool for a very narrow case, so don't use them
unless you understand how to avoid their pitfalls.

Thanks,
-Stolee
