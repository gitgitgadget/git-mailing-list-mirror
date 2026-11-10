Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309261;
	b=NiPTpCKFDPvtYZx8sw7eXtsFUznioHSNwp7VZkTjUhOaeKYMLnmSKFijZQsQ7fZlneOH
	 BQnvCsx9EMjNNFS5prfUn6mta2lVe359d4qmH29RFC58vc4W0yVPRvvTQg74NbKfcoX8e
	 Tr4VugeibSkNx7hSahpf9n2sLgZsIjIsrFba+ZK34DVCLBcBsViv1GYzcA857YKvS0578
	 p8qxX9Qj8QO2+rb0CnbhhdmTSwCOrjhMWXYkq2L5+L8W4ofUsD28/n5asK2YsHRHusY+K
	 W8SF/qZyCmX93p6OiFO+VrhxUX4WaDH8asY34JcErTEeSjyukQMovAZbTAqhFQEMAAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=UMrzV6ANU+Z7imihL7imdGdlayE3BoAYl7GBUMj3vHU=;
	b=CYNp+jXN4aXy7E8AKtPBP2g4x5VUxVqnANchUgIGMFih/mEsHLpq9BjRBcBpiwnerMt2
	 Ir4WTJUC7EV9O4U2DRd5yp4wWJbVqfBhzJKVDam6ilgX8Jj9kV5+fWx+fIuwaNqSaZzG5
	 ds0i1KEIp2X/u2wvRtBvaru0hJT38DoKLdG2xv9QbbQtvHdcPc3B7YN9mADLJiq0i62/8
	 8S6pTZPlbxXrddtv5t/sMogo8w/fDJQUZ0433JTzXB7VVnJy33s3oUzAu5khJsRlthgIV
	 duBHXbcb58K12aKtU8jRr8d52H9va7T5yzgYJ3SHSjNZUXDJPlK4gO+T7kYBveTRJ9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AZegPHOf;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03237606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03237606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AZegPHOf
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so16626015e9.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794309259; x=1794914059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UMrzV6ANU+Z7imihL7imdGdlayE3BoAYl7GBUMj3vHU=;
        b=AZegPHOfQpVYeqNACk6JuEpBxy2BtyCzaP187VTLkZ9B5dG+nytOvBvdG9aOBSe3/3
         yBxmUMxdeLtazvvgxJTGYKm5E8aFIBIEp+AqXEV9hITv0mykI+T111DTY2Wnc+RgnYsv
         josIMm13AWg22uskG87Ci2Mho7jLshmVsfktIapH6OMF9kmsC9HVaPeuUQoiC8ZEHp0H
         t0C1ePV0X4EchDBYWv35NL6KLpVS6VGJbDsywi2qmGe0ZsTlS1a6hz46Xd3g1xlqzmWa
         E3uT45/SyaWKOOUbScO04R/AO9ynvJ/lmhM6zZM9dF+j6Z2NBLb4Vif2nZ5HFvNjg/jh
         SJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309259; x=1794914059;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UMrzV6ANU+Z7imihL7imdGdlayE3BoAYl7GBUMj3vHU=;
        b=yU8Lwgasx1FkvVcUF5FUpYd5kB8pItazYHz0740hbOjYSPN+kVZPzrVpgLZnNzYai4
         VEZNL2M/qu1thwzxpXpmmLOftuHKg4IurwUgrfzkSO48D1hsgnsTObaK1xBXtfSfhd2k
         rsSqaLBoQFUPq6A+C8nLmw4aEs3KwZdY1eRm06eUYBiJNXDSmF8lDxxorII+Yv14qhDp
         zeSS5sN6PTVwNP53uOBrFoeTILqCMf5nGP8F7V528BbWT0EVN5gP73M1/GnL/bVAmlVm
         PQFe/kvFqTavCY7bhZhLnim5euTVa5agyr+IJ/sVsaeYOxtJlSgbe/oBAPNXPa2tTF1s
         0w3g==
X-Forwarded-Encrypted: i=1; AL+hErEpIcN4Hm/3kzWaLMg3RLTI0pRlBXaAaY1T0PDMZbtaHYEToLUyrh6SpjrLxiWDQpeg44c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sAHJ8A9gBpeYwtPXl7nXuKlZyE1AhlBtOwneJXDZ8dEoW0syp
	8z+Jf1aYKku9lNFjtCOKKjQ+BhUq0FHeHyx4ub9ZISKXdeAkyYp383aU
X-Gm-Gg: AYBFou3qR22VB+w0tZ4ai8dscgOoU93rx1AEDQSgpdgR5hR0nghZ9m3dANex02P10o7
	8DzM3zJFJHKPIIMri8y0YS7Pr0+rtjqs0ZDUV0dneuSTU/ZJb2IFN/w/feDrzYzqFsDPwCJXtO8
	BBwTqugSGK4RgJLsqQXzA3k4klum9kYG+6Myl4lgHbXyG+ZqxYaYtjhH475YXVFc0d8theMt5jI
	Svr9oavkX/3mxfLZ91zf9b9guFBwPTWYYrDd4l+muHSFcjHaCLkxonlY4zEbRYcG4pBnqyd+xW8
	E29Fvfr3fdEAgdo4Iqx+N1kiE9kiYvvbdrxG2vynRwrwE+FBYdsV+rcrK/VlwduhCQQO/4lqQvN
	80AsGGLCRwU0ii8BrSyO750Mh9mN3SfQm2kvjovdQcVXV2cEVdpZtV6WaKmnhzWgRmW+Lnx4KXK
	lGFapJIssT5+ZLxi0IT+U7g6sM/0N6aJ0EMU+IfeHf04T71Mr9OjU8fSejlp+SwIALunXN5jTaZ
	igiGZyEYXuTo16Pa3GzGW4HqdvprQyRvNjcEl7xcKClrC0/2aG/YE8yzMUcbjLsY7mi72zF3RlD
	LhGePrKzIjeMKPIzTVKBAkmDA3yrl5EhNo5vJITaW8ItinHIpMxPU3nI/dadSifJniXpweS1g4r
	aP8IewpA=
X-Received: by 2002:a05:600c:3143:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4ba02355f49mr33406485e9.33.1794309259209;
        Tue, 10 Nov 2026 03:14:19 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0234a5dcsm57869475e9.2.2026.11.10.03.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 03:14:18 -0800 (PST)
Message-ID: <17a690bf-23cf-456c-bb85-454ccd6571da@gmail.com>
Date: Tue, 10 Nov 2026 11:14:17 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 07/15] blame: handle NULL values for color.blame.* config
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Jeff King <peff@peff.net>,
 Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Colin Hinton <colinlewishinton@gmail.com>,
 Matt Hunter <m@lfurio.us>, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Miklos Vajna <vmiklos@collabora.com>, Junio C Hamano <gitster@pobox.com>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
 <260b90a4a23d9a94aea0ed2a2e28930a646d7fd6.1794040968.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <260b90a4a23d9a94aea0ed2a2e28930a646d7fd6.1794040968.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas

On 07/11/2026 08:42, Thomas Bachem via GitGitGadget wrote:
> 
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 48d5251c6d..653449c0c9 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -782,12 +782,16 @@ static int git_blame_config(const char *var, const char *value,
>   		return 0;
>   	}
>   	if (!strcmp(var, "color.blame.repeatedlines")) {
> +		if (!value)
> +			return config_error_nonbool(var);
>   		if (color_parse_mem(value, strlen(value), repeated_meta_color))
>   			warning(_("invalid value for '%s': '%s'"),
>   				"color.blame.repeatedLines", value);
>   		return 0;

We ignore an invalid value, so does it make sense to error out on a 
missing value? The existing warning does get a bit lost though as it is 
printed before the blame output.

>   	}
>   	if (!strcmp(var, "color.blame.highlightrecent")) {
> +		if (!value)
> +			return config_error_nonbool(var);
>   		parse_color_fields(value);
>   		return 0;

Same here

Thanks

Phillip


    	}
> diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
> index d2653b3c31..5eeb7338a3 100755
> --- a/t/t8012-blame-colors.sh
> +++ b/t/t8012-blame-colors.sh
> @@ -69,4 +69,11 @@ test_expect_success 'blame color by age: new code is different' '
>   	test_grep qfunc colored
>   '
>   
> +test_expect_success 'color.blame.repeatedLines and highlightRecent need a value' '
> +	test_must_fail git -c color.blame.repeatedLines blame hello.c 2>err &&
> +	test_grep "missing value for .color.blame.repeatedlines." err &&
> +	test_must_fail git -c color.blame.highlightRecent blame hello.c 2>err &&
> +	test_grep "missing value for .color.blame.highlightrecent." err
> +'
> +
>   test_done

