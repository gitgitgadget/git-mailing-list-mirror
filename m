Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DCE223DC5
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745402683; cv=none; b=DTxZJ4atSt3HMgSE4M+djm+aqaGO/gwNC6T2rY8lravFc/42ok895+NoWZda8obrjSZpToqiNHdVVscDPSKc3dv9+Vk4WsmCe75hmPA2HG6P3bDox+9/GBZ049Uvp14rDFxd9qAoyHTK3P2AhYiKo2L/ABPCoLLUvA/ZfQjaX58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745402683; c=relaxed/simple;
	bh=c1jWWFocYYbUQPpoqvrGITjjpAsodpGW+8vUfudAxBQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=H2fEveEp9xSb0aEq0H36qsFrc9/uyx693pM774Azt39IA8G+LtARWPkDf6WRcvfo5WitxYUFsGDCbJcOF0UYsNre/2EwJnrT/ZyH6W5/8y1QOqr8d/F7iosnyNQhoOakaQzGjTYUH6ezZV5z44jtIK/2WP6Zm7u7WO9zABCj+ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgJjPDir; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgJjPDir"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso29786635e9.0
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745402679; x=1746007479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKRIPK9mLN9sR1PlGfqapFlexh9jSKJXsVplNoYcozA=;
        b=IgJjPDir9mKd7RuqknUYYHBv/NirPLh59HO6IeMG5hV/sjVnCpzmPX4XpNzoul6UjY
         6BIm+C9JueaeuEMHJXSYr20YVD8Vv3mhifIfwp2jisQj4z+xhMk7UhB9mcnFNSnxEXyR
         moO7Ya90VkM1cttzNboWxt+eP3wYZQImv9K4Tk67fzzxgclxxdCq0b7R/5qX9gMUmJ5R
         +vgxm6Cut9aZkNx/jIEGau3ahnFtq7UcU7uMZM7LyivIwzYSeSxpLNU7EqRWPnzccViO
         EPhixbkXVEds+Drags+n146V4NSVCAftqAurPtwRMjQxC0MwtloSUqGCG29Tc6WG9w/e
         +0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745402679; x=1746007479;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKRIPK9mLN9sR1PlGfqapFlexh9jSKJXsVplNoYcozA=;
        b=W88nnQX5IkgHUj9X82IS2ERs6zVmviDoyk77Opmx50xDjemQUaTFcOfKO9YEZ0f7f+
         p4JnJqoNWM+aThunvtCse+Y9OU7RCQ0iBvasPA0DnArrOd+FuyTnrwcaWDMKaZsT8q8L
         mvQkhhVZ3YQCt0W29NPMlzZnQ33miTjVKj/WuF7q5uPJ9OEYXZPLb/mC5yD/GRDYBRCw
         a0Tq5LIl4jobozxFXedl9a05Of39p3lC7/GuVYHcA8/nqJQ0BsT0Ay1D/pqt1yIWnusH
         zIOIl4FQWfR33Dn3X6BhZ5s6jSdg9G99RYfKDgfihMKMb/wHqWM79RUPnh7fZGIULCrl
         uMAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLS5Xm4tq79YqWd2eWglydJmxBkMiSIhVOA2Q2RJTB2OWfsVud12F6mEkqtML0Bg6Jbwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyToXdH/vvRcT6deF49jxMQe5UBQpSc+Y/3mm++Ne+Rb3X50yWE
	HxRcz29CS/ALrqG7twwX4kh8uWQfMEgR8k85NejG7uElfukBKcYs
X-Gm-Gg: ASbGncvlZuaINi3P6+51C64gplGvqC7MQJpGo1NarFMry270CMfz6quO2lX2pIHh5wS
	g1yfdmr+0unfVxiHyWRJluMATF+XXqTd8E9IPaIeNjab9UoFw21rCRA2FtSOGDDU5BVEZD1gm4I
	Nc/+TwSnLjOce0pUl2XS/ki3o4DUtG9mer/Oseh2V9Xgs5F15s71JGEkNkTHK/PspvhLjHUTh79
	8ipTAfr/RIqWGeNIWS4ARjmfO0sYSJsVDBFHdMsX6ngxix+SjtjyRgye/KhjAEocqpoQw6dPDtC
	szyevMVA4Qw1N/FC0xD38vdHvJ2DPtilj3kW0g4e5tbtbe2JeCI1Tfs86bZ8ymCTKHzBQ0qsL0y
	uV9mkot+6NJsWA8BZ
X-Google-Smtp-Source: AGHT+IFU2lYdIzUa6DzueBBWnb0MRVPQjxfYZlWps8nUkHW/pV+BxYaWNJq9kz3Hs+fNQp2Kofz2yQ==
X-Received: by 2002:a05:600c:5023:b0:43c:fa0e:4713 with SMTP id 5b1f17b1804b1-4406ab7efadmr193013255e9.2.1745402678502;
        Wed, 23 Apr 2025 03:04:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092d2eea0sm20054275e9.22.2025.04.23.03.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 03:04:38 -0700 (PDT)
Message-ID: <1996b081-2684-49e0-a99d-28f22063b4b6@gmail.com>
Date: Wed, 23 Apr 2025 11:04:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/5] meson: add corresponding target for Makefile's
 hdr-check
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
 toon@iotcl.com, ps@pks.im
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
 <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
 <xmqqh62i6jli.fsf@gitster.g> <8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com>
 <xmqq8qnt7c9w.fsf@gitster.g> <3389d086-4e6e-4896-94dd-9f62d7c4f2df@gmail.com>
 <xmqqplh55ju3.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqplh55ju3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/04/2025 21:40, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> Yuck.  I somehow thought that CI jobs are always using a git
> checkout, not tarball extract (after all, that is what
> actions/checkout implies to me X-<). 

That's what I'd assumed as well, I was quite surprised when I realized 
the "checkout" action was actually unpacking a tarball

Best Wishes

Phillip

> Of course it is good to
> automatically ensure that our tarball extracts are buildable, but
> the way tarballs are built upon release is probably different from
> how these tarballs are made automatically (*), so in that sense not
> building from a repository but building from "git archive" extract
> is not doing anybody a service.
> 
> 
> [Footnote]
> 
>   * "make dist" is how a release tarball is built for this project,
>     not "git archive dist.tar HEAD".
> 

