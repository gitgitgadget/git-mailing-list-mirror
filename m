Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C5E286D7C
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 00:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769128431; cv=none; b=IDtUoVjMYukt0fwPwvg71ccto+KND1xCYR1i0LXhvs+FTCBo54uX/RbwEYu1X4tnG7Gl6BokqFG1Dm8Q37z9PUYzCngnbAMizhkj3N/J3uM9CpFhrnlYxnMMlA514HLig75Nrztk9NB8YVrhtM+ABPkrpUR76EVzhFchav9PRB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769128431; c=relaxed/simple;
	bh=vPWHiBGOx5LO1qyCR4QRJC6SG4gxNIFjSgJDKyQwjqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIjl3MdOqe4yYFJnAezgWDTkG9DmiNTd3APqBXE0Fc1FSp0MLnf4Q6ZYHznhT2JP8QW+FiWddNy/URexXYsOpDJ6sikCOk6nh/8FrjnWQA7r5ATwIDDTa/G5S+02+L5sbJlmFnUsqKa7kZOwamEIWrWcaf6MSOWE8ub8U/zUdro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=EBu4465r; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="EBu4465r"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-502a98c66f7so14623661cf.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 16:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769128421; x=1769733221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZL2k160VI+t0BKWFq3JHbBlx0Y/gowxJjqHWGIECpI=;
        b=EBu4465rFgE3y+ihDgThZUCbefRi5ixcO/iIeoomrlhcCgXphePq/TeuzAmgtHj7Xa
         BB/SAB6Zm+1FO/q2V+Lps1HkmPRdHGtgj7DM9h7MmKbAZf0i5jX79DHKKwI1QBTsgKrz
         4MmhYJz8SVXdnLbr4JbpBYpu3Q2DuzFovdV0pFdoL5pCfA12tANWrs5C7WGO3d74ZbPl
         nXI7Xj/KSl1vaZL6DtlrT1dzQ6vD1dCgUSOwfMP0ZZxqLrUSMWCwtTfA7KBTdLVywC9l
         AswATUh0+Prnkwf2kSoAw3PQKxgqN4L5LhboiRaOUqgTXnRSpgtRkRdVXxY2q7vlyHkG
         7sJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769128421; x=1769733221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZL2k160VI+t0BKWFq3JHbBlx0Y/gowxJjqHWGIECpI=;
        b=bgPm31OeqdRYtDKD+pOairlJDbxpln4tbC4yeIzwfgeub8cDB8ZYcr+1O1C0ZB/Rdi
         uUFNFIM6x4xnyy0RK+j35pLM8E1tVVpCPO47o8YBT3P10BhJ7Mt6eDsR/i6EBiIsx1I4
         8nVmSULb++3BuAsXb2Djskpq0DE/c+berPl7m3tBItluG4rp4WguOXjLNKYql7u752wY
         Fu7pBqWKqHWlo9UVSAdhupa6kIx9F6q56n+w/SE+3Ole57ITyaZ7VgVt4jFYmveWmDYP
         GwLTulOXpvw8LAWFCRkOMTi/Jp24c1ySBCvRmd9hnxVmmW9f1NzCkba/JpIykPPm5IyF
         j3ZQ==
X-Gm-Message-State: AOJu0YzIHQMAAOfJSEqRh0/fpLCpcfiq0v26v/PDaFga78Bz5+PhnXNY
	9vXFG1G98toCx0y/ZJnQaR9EQdNVBzOhrf67Zhn7UCkt9E8qRYVpdV+esUKwiqUHBEhxKi8ekiY
	DfFme
X-Gm-Gg: AZuq6aJnLLf2SBh/B8wgYx48THK1s0ekGQEh5te/IdRe7bPIyaUngLlUmjWDF6xsSkI
	j2rV2EeQdEm0j6u92hWoRiENTgJjVCCzjVhKsRHrO+aNMupiuQ4wXGUyigl9wCMvzYg06xhZEpR
	rHV7Zw+h+Y+V298Bc3I4aY+2gwAtoiBb9fyKWzWJTKhGkYOImb79w5rapCIu7O67+49+vZHWVbi
	cUJPlTppUfAYTqK2k1fdsIuJV+Am2DtLNRy44i1rAWpisdbH9+ohaM1MbBQX9CEu05b+grWhFyI
	NDmA5yqyvJd7C+MchCLFXqQBu0QqJWzpAe74CnZf9rqWMjdpcRlv3gWfa9ftlqbhluJec3Mqeij
	6+oBxPOT36H++RLoyyKMZOGNDptXotOR7cd1qiXREGKe4bxUFEkbpSn+LTpEaEy6o9HuEDxrAvq
	cyp9lMzYlkiywm7E/0t9ja78nzXQvYplZ867w2QMaSjkGFNN+pcMFFWHcYr+5mTxE+BxIi2VqUS
	jid3VOrFKqofpYf+Q==
X-Received: by 2002:a05:622a:44d:b0:501:4859:c7aa with SMTP id d75a77b69052e-502f7777d50mr19784641cf.20.1769128421540;
        Thu, 22 Jan 2026 16:33:41 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8949158087asm5587516d6.0.2026.01.22.16.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 16:33:41 -0800 (PST)
Date: Thu, 22 Jan 2026 19:33:40 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 09/14] treewide: enumerate promisor objects via
 `odb_for_each_object()`
Message-ID: <aXLB5JxuCeQchOzl@nand.local>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-9-12c4dfd24227@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260121-pks-odb-for-each-object-v3-9-12c4dfd24227@pks.im>

On Wed, Jan 21, 2026 at 01:50:25PM +0100, Patrick Steinhardt wrote:
> ---
>  packfile.c        | 37 ++++++++++++++++++++++---------------
>  repack-promisor.c |  8 ++++----
>  revision.c        | 10 ++++------
>  3 files changed, 30 insertions(+), 25 deletions(-)

All looks very sensible. Thanks for structuring the series in the way
that you did, it's very easy to follow these conversions and see that
they were done correctly.

Thanks,
Taylor
