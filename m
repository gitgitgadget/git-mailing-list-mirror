Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793436365;
	b=oCoBnP5AqtParuj9regOAcx45AB4Pp49+6D7tvi4lwGy8BZpYkKjVoHN81bj6SrH6Ul9
	 EIkNeWSYUIvG45icO6sppq/PJqtjBKwOu2r7Ihc9NDyDT18ZAQavkBlQijYq5OuVbDnwJ
	 S3ORpgL8UkqYmbuRomFfeG3a7X5JMz2rpHUSeEIsu4fPluEG7lxHrHj5hG/8eBeSdjtuE
	 TiYEcZLzu8ipixRNdSaM+YdzegfF78099oTD6+HzDDdh1lV+FcmpRxKmaUpKo4lfZQk78
	 6kYHaY0scpvmhsRWwDjNc/ZPxWNZZg8QrvqqY7NOP2J99OF6g/xV6OVgV0Y5cSDGCUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793436365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=5/Bnl1IZWVlVxC5jcH0L+/RxTVto69m99nrIGUBRfpE=;
	b=yPYsdYoPmeT9eUKyhm6tlpap5RsDUJh+jL9QouoOLVPgiz4h8rzZLN0EfV3Shd6z0U02
	 ANLPmktj+R5PIiMAIzCo/P7rk86WSiGlB28GOqUAroRvkRKeLiav3iJX4jMHuYficdQFH
	 62Dmd6fuRe5aon/9vh8ZBOPDXSWFJYrzXpgmlRQ2GM9pJBva6Gozoeqc+621eIvZ1Z306
	 uRfEYB35bLkl2j7mEI7A+IjbcyJOm9tAxR6EO6NdF/c7UIxuxooRYdtkthBs16w1/obkA
	 mAeRw+877/UmK3vkh1OWv6O1a+Eg2SnDQAehK6/vZEi+PaQFOuO3fknv4u0fCmeTq7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XJmvfi1F;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8783606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 08:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8783606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XJmvfi1F
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36a315ed211so1788738eec.0
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 01:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793436364; x=1794041164; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5/Bnl1IZWVlVxC5jcH0L+/RxTVto69m99nrIGUBRfpE=;
        b=XJmvfi1FMhK6ZLrVDTXJUDc+0LbEG3MIK0/+fc7qnETGX0MM4i4ud1dNEwtl+BohDd
         iLyY8GwvkojgBs1fPDUk41H8zIjXgCgwfihv2hlCpMzq4rsf151XUz0ZwMxcHX2t3bbf
         z50XiOR+JZLaAsD+maM1q38l9V0uHexgTm2ZXPUItZMcrB8MTr0+V3X3RmXm/hs+uZb/
         1n8XRY7sBbPBOPZkRbce9RIfGp1yOPXF+2bJd/AYO2Zcbja70/MdbpPIk2gPO8pMLMFu
         pCF5GhraP6Sgj9rvujl5vs4IOWoULj2xt2guX/ed4sgSV1w4ExysvBSSpsBg1ULxB3tp
         7QNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793436364; x=1794041164;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5/Bnl1IZWVlVxC5jcH0L+/RxTVto69m99nrIGUBRfpE=;
        b=k++/0l0Vpr7V8HAUqHH16tZSzSyFXdrPlUPE2wsgBSegJd69T2cH8i+Ly7wzW/76Vc
         8/Y1kGiB50ytoloNp8FctJNHCERiWwZroMMtOeSCoc/YVv5GPPJ22iPgh1S+URGSO0N4
         fVekmacqh4VJDagNJcZGJsY32UMVJLzjPb+Fe4JcA+AgzrNMimq7FoRBr0fKnmB9w1kf
         BPTwdIT0m5JdD/hsWKiGw4kjlZAGle3r66uUZpXyZq5IYr+nGurNKBIEOaKqshpdRiDS
         ly4ZJse9RHR90dpHKhPKd8JyxOwHzrlJmC+nWzTEShOpP/SCJCUM/PZY6UbX5qLSBSg2
         H4+g==
X-Gm-Message-State: AFq9FYIHUSvvedrf6zN2eCdUQrmS8RBJWnjc6mF3ACADzUtLwE+/thvG
	Xm2qrYc+dyEkZu135dLnyQ5C93cMONlb0DbaMi57Jisx+FGJzOWfcGww
X-Gm-Gg: AYBFou29Lr9L7IvNt+rCXSrwl1bVkxuMQHXTkDGuzAi8rtwnsnP/V7L8HVSyRTRzwog
	gJoij/q241Piu2dv/EJzmzy+n0V7g/H3SXxBWRdDutDk/Ue5tK3n+TZT0pI9A5/vq69uAWfogFB
	5S2reV+SJLZ9IypoV9lxs5cHKTy82xCs+eF+zqTqKzL4sP33GfX09GKlK5T4ABQrF9xsnK0Nt2c
	Nnarl+BF8RM8dN4rMWZOdggPdOottIonv66VYzVYXlgK/Sott2rRribaHqvTL1u8f/JGPI4Kv8B
	DgQIQTQYZmldzEa0/QD8t4sQeGg9KP2twkQzq2173Chb03wvTDNPo3FHRT4LIb9TOe5m9xDtKtA
	4krM0E0Qf3BFpDOtyeXUg+SCLcIHTkGxjmZ54YLSkywQ0lf5VR8h1L04Qcr8cSVda/ygt5JVH99
	2blgsLmWpVkJOq4eUTSOh+3jKSdhL47oxya/4ieiHjs9f/6/hbrEmmqwg1I+AMdTRTQR9cgEMnv
	tKzBjqX2INIwnuDfp6Saw1349lDHiApFkXzYBbMaxS8nEUZagRz9QOgLJjrnP5Op1xUdqoJCz8H
	FVLPwiHFMu8Hw22RSqagEwh/
X-Received: by 2002:a05:7300:cd91:b0:369:f231:b98f with SMTP id 5a478bee46e88-36a300084d3mr14341181eec.4.1793436363616;
        Sat, 31 Oct 2026 01:46:03 -0700 (PDT)
Received: from localhost ([220.158.183.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428aed76sm15195736eec.9.2026.10.31.01.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 01:46:03 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 14:15:53 +0530
Message-Id: <DMIW4MQ45760.PE3EFBOA3KEX@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] doc: config/log: fix typo in git config docs
From: "Hardik Kumar" <hardikxk@gmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, "Hardik Kumar" <hardikxk@gmail.com>
X-Mailer: aerc 0.22.0
References: <20261030-config-typo-v1-1-f9797f518c43@gmail.com>
 <auRkba74Y5LD0Ubc@pks.im>
In-Reply-To: <auRkba74Y5LD0Ubc@pks.im>

On Fri Oct 30, 2026 at 3:03 PM IST, Patrick Steinhardt wrote:
> On Fri, Oct 30, 2026 at 10:47:20AM +0530, Hardik Kumar wrote:
>> Fix an obvious spelling error in `Documentation/config/log.adoc`
>> "overriden" -> "overridden"
>
> Tiny nit, not worth a reroll: we tend to finish sentences with
> punctuation.

Thanks, will take care of that from next time.
