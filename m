Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890318;
	b=bgGs9GuMBWDN78RDth93nZlRvFacZJ23H+1t8VikYO4J+UBk/2JMFpSPnl4xvJLqba5A
	 teraqBpCj9Ibcyxm+TMJPGAUHfQ44dtvKAYbZL/khIqiE+RNzrgWgILnW8IQEFYI1DHED
	 i2Ux1fPvxsPequZwS7FTIRRzCO6LIDYCCpphZK+WJFp+0HJ6z0Z/OhOdZ/Fz+RjZUH9Xr
	 1q4dG6/kbFtohynpyAZbNMSAGbR9GPEIOd7dZ3F96ufxVHkJbmDC+P3XXjjhhtZGdxbZN
	 7+b7x1KYgDbXrX0bP0MG9U/qwsgN29Hrg00aTfXeT6WGUq5VgPtSri+lBcCtNV8o5ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:Date:From:To:Cc:
	 Subject:Message-ID:Mail-Followup-To:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PQuelLknK2Mjf3N/zrzpSStEGzYPCampTbnFWVeJ4Qc=;
	b=X0lmXCwu1S5FDkQsdX6OxdvonXRhFMcTNjPug9nKVNKjDM9Kv6p4InQ/w+Hk+hxe5vwE
	 fTIAwZjdtq3wQJVr5dwdYtp/NGp4xdgZ3+VD/enKCAzAZiguPqqJ72Wi0hOVRcVdVa1ZF
	 MbtIPQlLYMsu+a+SIvz9FYYJoYYyvXuMcXFqU3aHWhWo1BvRksbtX7A/6gMP0xQZiwssX
	 bb48onRxruRmrZl0cTTjM8cuQAIJ1O7GySV8YGb+ETvnm7ilbtBheXr4zfcXbrx8TKkOM
	 F8nj/8nA6ykFRDQJo7kwDmirFfw+bl0s7v+6dlMkFFSddbwswdmgd1FPcbQ/Xn8yWNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=cervined.in;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QUpPfx55;
	arc=none smtp.remote-ip=209.85.208.182
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD7C606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 14:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADD7C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QUpPfx55
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3a1f628b1d1so15385251fa.0
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 06:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793890316; x=1794495116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PQuelLknK2Mjf3N/zrzpSStEGzYPCampTbnFWVeJ4Qc=;
        b=QUpPfx55kcNPDygojAwJyR5g5+JoxUY1GnBUSUSXeI3wVkrFgxn28V/ieAxzPZ7iDQ
         r0oI8VUIdvgcyYqLbacu+gD6ras60b2NEaHsfdUzbB6SxeLFs3WhrXQRJhA841Hg6jPf
         P7SdWnvt93qd3F/5z0mbgFJI6OS4Id1tA569EtPBpuCpqvMrqhpr5ustDox3IFVO034u
         XlX0ruFQzrmvnv0HRyf2gJ2wsOpBYZZPptANR3s5KmYKa7o0APAB1B9j3GqUWpYUoJ6I
         bxJjriHDP4vG6MNIg6t34jgapnmb0rjV9N7Zso7A+Q+I7b1z62lQ3z/xdxHP/ch89S4D
         7Y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890316; x=1794495116;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PQuelLknK2Mjf3N/zrzpSStEGzYPCampTbnFWVeJ4Qc=;
        b=rOcW+rVsTPYe/RxuDlZFXCNp2W+pvrFiu9E4vaZaKSjLUIXJUUv4qb1jAfFUXmWgkQ
         1KlHQKfaCneEPv3S9AuGq067SeSQqXYyZIs91PLJGwkTm/br2uG7429wb7DSmSO27uW3
         e+YSn0hpUIhiFqw0zO02yfVUmRmunhcsrnQ3SS5YbMOvKLJ+MDgdErPNXNVJ6Cokl1m8
         VJh52LnBKUU+wyfG208PAVNxQMagd4CJwy/Z985fjNSZKpJGlkt614JQbbfw9Nr7FexX
         U+owzvhnZ1llVRdnGfCFKas1F9PaX9bIU6nrMexsr9lerVGshUjq9aEwEg4vVlA13ZHf
         9CmQ==
X-Gm-Message-State: APuU4Z9d4avf7gtajaeBHOAR2h16X0+kB+X08moUHo6X1jZn/cQL4xwY
	qeJDz/O43tsaTWl6x2IUVVknr1Fds00KP4vjBADk9fv+KiF9SoktL3LT3x9Zuw==
X-Gm-Gg: AYBFou2lUEwU144DLvIAG7RCUSz5ktllVgi4Hk0bfsVBtyoksV5aeBARUlYiCT27Nwc
	YxPA5/0WbXCPAJo3amqhrmugIA1asQjaRJDl9P09gRaknm0sa7Id+EK5+sMgJw5oIxb8/Y9JlmT
	+7UQd6T/ETsf4PglUoVCZFEQELwjNvzhKzKt1xXEr7MdfpJzYFfxy3SIf1t8/d7eX/iordTlDrI
	z5e/kS6IwsjhMiD0S74BEDXahri86OQhT5JNoGZH7OpROIHd8jXT4b5IV3aTQ06CQCryZysHvVy
	G3bLfF4VKYqg0o/CeGq5QQEXMFxPaMt4MOmeC973vgDJWdYMvS8eJbodXjFZA3LcohRKOglxBn7
	MI/xKT7S7q69hNJz7XYoQJm/O426J1DVOlp+FYypg/d071rzLTLiIfJjBwDiYEGvvYH+4JawqNu
	MZOI1Kgc440cCKLPyOfPT+TK8lO1yG+JUbNTX17dayr2BdDPIHTLkU7DZuvBLWFwGl2zaroAh9B
	Lu0BzgALyrJ/21zLcMEtWW9ngBU6S1GY5r75avmoPYX3FD9SF08gGUAkPb8v0y4BTuOer6mzDuy
	90R4Z10lYr0Mc6SIcv6vpaxvZFg7pgxvvZSuNYwATEbS5+QwJ6JzDLMhJ3tQq9O97oZt09MxXTC
	qr5e6eoQlgmM18uOhiPY9CwVYYLm7dtPAMVESyTIclIVU9ZvawA/t
X-Received: by 2002:a05:6512:124c:b0:5bf:d7e4:3c4e with SMTP id 2adb3069b0e04-5bfd95991c8mr7345061e87.51.1793890315446;
        Thu, 05 Nov 2026 06:51:55 -0800 (PST)
Received: from localhost ([185.104.15.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bff38b44b4sm900793e87.36.2026.11.05.06.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:51:54 -0800 (PST)
Sender: Erik <erik88@gmail.com>
Date: Thu, 5 Nov 2026 15:51:52 +0100
From: Erik Cervin-Edin <erik@cervined.in>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 0/2] commit: allow -m/-F/-c/-C for all --fixup
 variations
Message-ID: <auyXU7spezFBYohU@mbp>
Mail-Followup-To: phillip.wood@dunelm.org.uk, git@vger.kernel.org, 
	gitster@pobox.com
References: <cover.1779792311.git.erik@cervined.in>
 <cover.1790082176.git.erik@cervined.in>
 <ba174a25-f7bc-4a5d-918c-87229b2fb5f6@gmail.com>
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
In-Reply-To: <ba174a25-f7bc-4a5d-918c-87229b2fb5f6@gmail.com>

On 26/10/21 04:13PM, Phillip Wood wrote:
> Hi Erik
> 
> Sorry it has taken me so long to get round to commenting on these patches

Thank you for reviewing it :)

Sorry for the slow reply.

> think that supporting -m and -F with --fixup is useful and I cannot see a
> reason not to support -C as well. I've left a couple of comments, but the
> only thing I'm really worried about is calling test_set_editor() outside of
> a subshell in the second patch.

I glanced over your review and from the looks of it, it makes sense -- I
just haven't had the time to reroll a V4 yet. But I plan to!

- Erik
