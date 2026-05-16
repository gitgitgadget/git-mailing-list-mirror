Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE71B983F
	for <git@vger.kernel.org>; Sat, 16 May 2026 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778938718; cv=none; b=BCjeTc/hpsTv+eMA4l0JWrF48g90MFwv6yqk8WK+Zw7QFB7h1EbJ0HCAohYhTBjyT1E8PXL1JpP6MnoK/BZbNDSiVJxepV2TpNfBb9lV1aZ3t3GG0zkArcgsx17GE/FqhOCdEChuqXtyCrGVrWPTj1ym9jsXzn0MzfW1k03UlYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778938718; c=relaxed/simple;
	bh=j44DAzcSih9G9B+Z9lG+hIAdP1Rl2RQeSrP9Bjs2SSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cnay471KmIepuVdAAMfibVPAytrkd7PVZ9pBm3G/svCtQcrKxaeMdjsU8R/AyUooxi40MW1qWbcseaAfnKJJIZ/HxcMXZDMKKJPBLTHraa7MEFi8A3LmjYszElXTAY/h/MfWZSpSAPQXyDASmLIW3/0JqR3tiEUSIfSejWXkz1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDojB+so; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDojB+so"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-90ca6f20872so255508585a.0
        for <git@vger.kernel.org>; Sat, 16 May 2026 06:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778938716; x=1779543516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j44DAzcSih9G9B+Z9lG+hIAdP1Rl2RQeSrP9Bjs2SSI=;
        b=QDojB+soQEK2aU2s0UU1x5aDRuDtHk0vIFTGWieVhNB6WPg8ENWJKjHlVmVU06GAgT
         7rWNem8hBVy/WsBXFadiLatVA6+8LelTpT9wS5tp99OldT62QsE2fucV0FgvE0LIljpR
         1lKpvoXgga/+PGYojxfTjlBdITdQC2k2kNw6pvjypeixGNeHWqYGk97kC6LNnIk9u4XE
         C8fp3JQx/2tU+wHcUr9MyfWmf0JeKQtED9pHHN1mUC0WOMA3+kKAgfgu48qy1eTzHu5z
         mar8vDno2hUDxWyfnfQoz8tpBfDZ6QD5TAgMyz/GJ1Rvxty2XyIxJ4rFaPHymZRXyBBe
         I2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778938716; x=1779543516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j44DAzcSih9G9B+Z9lG+hIAdP1Rl2RQeSrP9Bjs2SSI=;
        b=jbcZT6io5JHhv3IfZI6JQsWxVUeG7BaqW9OT7C1Z8ovJcSrvs/W3RHXZFWNXDdg3DX
         IxTcdfGzH/Jv5oa+bL/QPLeOZrr2tRFzrmsVa6IcN9LoHxzqtSepCPBGaRVuoreUfqMP
         UY8quLOjrhx3EAsG6oim39Dk6LZcQ6uDHEMveCxgexbJZRg93nGwZoE0aeiUQl6Bv47g
         xRTNyYQa4i3Q/D5pLIzFkyXawuKOc66wDntQfrxGW+zZsbcUusOlopvhskM5ct1AIjXc
         560hdlqvnS05nValHr+67Iu2hEVI3rtXKGKIaW/3dQJiw6UnDORcCXm9Nz/B6TbYjxnM
         +Ksw==
X-Forwarded-Encrypted: i=1; AFNElJ/kcZQz08ksE5DMT5EJZytknwfVO3bvRymJYJiV8l74E8T16TOyHdGGDWLVMHrYtcB4cuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC6kpkrMSXy63GjdEmFssnI94w7IaEoAeBb3OUTY/KXUxOfjwt
	/SG3hS66vRwDmOTFWprurWFsdMSERxMCqGICtJu99S7gAd9dtmjm9gxF
X-Gm-Gg: Acq92OEaatl0nSXf6bY/yIOHb1kjLdWEI09LkJqr+VPfhjoP6kVgLKORnBVyxxo7uhp
	B2Fae3KzxYFGCPrcPTFq3qJTFUNsteqRL6vmqcQ+IveKcQHtLMbA7csEsL2OSP7m50BIGqpvFAQ
	mkyXpZnkeLYnpWFHvN0+Ph8ofpe8Ji7ruGqBVkPCZNXRJFtkKP8WEgrwNSS5XVCpcXK2vwM8+vO
	83Gi0dN6PRx+jkVldWeUOY3VCnG35oSuEtQSE2a13qsNx6ivUldQv8hu9iijhcB2M7LOcqivsxd
	ek/lZoQg4ZBUX8+RSzKMVLYtuOfsmVxVR2j7j1N1+aqg/bJkWjWXoYItfvTfVGhm0tXYtet5vPw
	ygjikt33goNfDYyHjHsl/d6nJWBHwxwW2uIC+RpsmX0L1BmnB6E9SwsDMGo7JaDGpNBYEKU370I
	c+B9D/bhbOoto5vcb1dNVkeQaW7fYsLTilqpDbSQfATiqos4GmtsRG/8qRIck5/SaR+3P52dQ=
X-Received: by 2002:a05:620a:4541:b0:90d:6c7b:d6d9 with SMTP id af79cd13be357-910b06378f0mr1681722785a.20.1778938716336;
        Sat, 16 May 2026 06:38:36 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bd623819sm869464285a.43.2026.05.16.06.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 06:38:35 -0700 (PDT)
Message-ID: <9ea3c399-70d4-4f4d-80bf-159d1086c15e@gmail.com>
Date: Sat, 16 May 2026 09:38:35 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/11] git-gui: allow specifying path '.' to the
 browser
To: Johannes Sixt <j6t@kdbg.org>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-2-mlevedahl@gmail.com>
 <796217c3-8998-47a8-9a46-298541708d41@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <796217c3-8998-47a8-9a46-298541708d41@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/26 11:54 AM, Johannes Sixt wrote:
> The description isn't precise, though. '.' means to list the current
> directory. The mentioned problem happens only if this is also the root
> of the working tree.
Easy to fix, will do.

Mark
