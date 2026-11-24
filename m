Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531486;
	b=0VnHYCnRGuzTM1Rq5xewQOIOoU4mHux1ZINa/AoeN9bNgbptoGx/a4nwHrm93UfGmQGa
	 oZJPqoedwHRB+O67KmH9r/mbFqDmJkFYQKsqbHHwr/Glc7vqleJsrmqLC+0Pt6LsaU8b9
	 iAWcogeNgxrQxQCBCDewh5+77jC0yNkhmfBYqLJmxNh+nmejoC5CggxSjeZCd6ESrtaoo
	 G+LutduVEDSL+hTTUKp1aUryDqIb4o4UjPX0J4iS7FGGMknTWDxVoMVO0JmQvzhDIpRWb
	 rnmKiQ3mhnyF3YngJZr122N8hfk2higtO8E1hO3vX551OsvGgapvMQX4GzrjryUkEpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=iQfBiK7s8/xtwKaRViJE7IHOrIW3gDh7YhjhyhjweLo=;
	b=vnIzjul5z0ulwNZao+UHFk+2n5SR44E5dhBOBCS20RXXTOFKLr90ibhlyu3hmEynf2H4
	 v7hCfcFhZKbsGBfj069iBZZ6wcAxmf4QUyh7XCgHIPRlKDkDCuQIOmAW1CmlPIoj3nXZw
	 fzjX6Kzj/gdSfU2it2XiC14Mwl5jJJFoeQo/rik0aauZBLnldBYVpFxur0cr8Uc3HAd7f
	 d+Vr9mpj3J8o+qbaVZLeVtGfNo+wi0Kh3kOPk6q+hiGu/VkdVqGVtMNmnr8TA8JlZir1t
	 xtcGs0EchmJpEQv199KNTBI8gi/6PP5oNr7Z6nhuV06YqmqsoeyQ1LmsVarFOU4zR3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cWjfB9mo;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715A6606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 14:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 715A6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cWjfB9mo
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso44641335e9.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 06:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795531485; x=1796136285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iQfBiK7s8/xtwKaRViJE7IHOrIW3gDh7YhjhyhjweLo=;
        b=cWjfB9mofljbH+rNDi0SaXa0UNTTth7AcrbJLR9adEcsNF3mHPGsMr7P8k6iqsDKWP
         gROkItIQGvfrGHvN6FpwAq1SV65NSo3VvWNorDD5yMGWFVDWWlDONCDWlFrLlMY778QR
         2MXmU8enGqBpelqZjvSmthR6cLPKxvN7QdaIhxjYSK5hL1cvJ0RUNzxpiI0F703HMo1H
         6TmckgdYhZ5CR9xKs0FGZUBvYlOQbWnb6LBtozNTrFQCog7Cet0mOj56e/NLvSlTgWVu
         hkk+h4FY1bf3D6F+Gf/y0b8dzQtK5Y3p1unfwGoFQrJipOj5IWzTioJSMLLmVp0DQILa
         Zs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795531485; x=1796136285;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iQfBiK7s8/xtwKaRViJE7IHOrIW3gDh7YhjhyhjweLo=;
        b=0OsJEHuJHNmInoPs3v7lUoYc9r7d75NjM9l5i7Q5QLziJru3GFFa4EbOdZfA3L9Htb
         AEd1UQJ9+YeYOA6ar7zNQT05YPES2uZDzGIGE+byXKQLcHYjLBqcMxEucGaWbrD9DCu9
         /GdpvLrmcY91LcrZCm+yn6yOgQrLVesSqJLYFs3MtFnO+q8CStx/wdC/zrtjFztF8nhE
         MjZxEcRoBxwj0BpPaUemWgnjJxinY/oalMS4+p7bYSAIDo5GuwM3d6wTeolhSbXiTA+i
         3ByxaDEgpjACsdehWS4mnmistSyKfxROcSRbTCZymsLxpMqXiF3yz8bE67sbXPZnxtfm
         uR/w==
X-Forwarded-Encrypted: i=1; AL+hErFY7cEW4Omg+f54we4qX5JKa82sMa9X6q8DJnPc3pKy5/JvZ8AjMcOA3fUfo2/TAazBMnY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9DWIP5BlSX6L6sVSE1/yzoZ/1K53PWOExkOh0GmjaiBpT/3HTB
	oMkyorfueF/q/6EVzknrcogfAXItpICsFEoRUrdE90QYJqImfTonHpUr
X-Gm-Gg: AZFdTZfjpi1fyYXS1aNFHzf61xlyvAozasuHZYhYn8UHBxYLd3DX6rDvsQdOM5llbVb
	J0pmkuH2FDCQiTDywf4UKwVyq3CS7lHSVY2ysPjRHJPXFGoyApVkYnxnGWrE4WAiBaw80Pex90S
	Ea5t8ZF50Ee252DVs4a/bRpI/72H57/1Na8Blt4SI7ZyuzQs1d/ka6n2O8//tUpndpzB0Y72fR7
	dfvvcWHI4kMuheaxfpwTjTj671Rsei4VdS/eWjqoD95Erq5hiCYVrvi/UBYeNaZKAolS0AUMKbZ
	EtK1LPn87aNJ9SFCPCqUZs4VR6gUdpp66cd/Y/ycSrI4WB4sGvwT4E3x9DvWbuVyjLlGNBpmBu/
	DAdvyCErJXF28Km3O6gxu6+GT9QfaS0T+tpQSTiSsc29i1oUdacH8LM+f/PNEkpGjbqHsE+J9KQ
	0l5YGpxwRH9xNZSPVr8hzaLj5gpGWwGefCXN2NyJBEAbs5O2MxpA44EaoZN7MrlCijoPwbMxxWa
	gcvps5WJioJCnYE35IkXB4ey9owMCtuLPEBdysZZl5EJfkUa7w1aN9i7qf3HM6QvaSJ3ZGtiHSg
	vSBYpIOC2EzCyYAn5gU8GzLHdir5yDOVisO1XfBvuDh9joFrTbqeCyUcTHTHlsOVAVU5C6tR12b
	ns2xHzGOgSaS2CPt1QE2oSH2FrVxL
X-Received: by 2002:a05:600c:3b1a:b0:4bb:875b:3d91 with SMTP id 5b1f17b1804b1-4bb88820bfamr315970995e9.30.1795531484505;
        Tue, 24 Nov 2026 06:44:44 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b8429sm690744745e9.14.2026.11.24.06.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 06:44:44 -0800 (PST)
Message-ID: <778be7d6-4211-459b-9e12-f1d9455bc807@gmail.com>
Date: Tue, 24 Nov 2026 14:44:35 +0000
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
Subject: Re: [PATCH v2 5/5] date: avoid overflow in approxidate relative-time
 multiplication
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Harald Nordgren
 <haraldnordgren@gmail.com>, Simon Richter <Simon.Richter@hogyros.de>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
 <pull.2253.v2.git.1795472027.gitgitgadget@gmail.com>
 <6057734709542cfe83a0ae885cb588e01806f247.1795472027.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <6057734709542cfe83a0ae885cb588e01806f247.1795472027.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 23/11/2026 22:13, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Parsing relative dates can overflow `int` when multiplying a value by a
> unit length, before converting the result to `time_t`. Signed overflow
> is undefined behavior, therefore checking the converted value is too
> late.
> 
> Reject quantities above `INT_MAX` before narrowing to `int` on all
> platforms. The inputs are non-negative, meaning that checking unsigned
> arithmetic is sufficient. The product must also fit the native `time_t`
> range. Report arithmetic or conversion failures as parse errors rather
> than saturating the offset.

This looks good and is much simpler than the previous version.

Thanks

Phillip

> Pointed out by Coverity.
> 
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Assisted-by: Claude Opus 4.6 and GPT-6.1
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   date.c          | 26 ++++++++++++++++++++------
>   t/t0006-date.sh | 13 +++++++++++++
>   2 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/date.c b/date.c
> index c50f45d310..3cbfe20b37 100644
> --- a/date.c
> +++ b/date.c
> @@ -1307,7 +1307,14 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
>   	while (tl->type) {
>   		size_t len = strlen(tl->type);
>   		if (match_string(date, tl->type) >= len-1) {
> -			update_tm(tm, now, tl->length * *num);
> +			uintmax_t length = tl->length, num_t = *num, seconds;
> +
> +			if (unsigned_mult_overflows(length, num_t))
> +				return NULL;
> +			seconds = length * num_t;
> +			if (date_overflows(seconds))
> +				return NULL;
> +			update_tm(tm, now, (time_t)seconds);
>   			*num = 0;
>   			*touched = 1;
>   			return end;
> @@ -1377,8 +1384,11 @@ static const char *approxidate_digit(const char *date, struct tm *tm, int *num,
>   	}
>   
>   	/* Accept zero-padding only for small numbers ("Dec 02", never "Dec 0002") */
> -	if (date[0] != '0' || end - date <= 2)
> +	if (date[0] != '0' || end - date <= 2) {
> +		if (number > INT_MAX)
> +			return NULL;
>   		*num = number;
> +	}
>   	return end;
>   }
>   
> @@ -1404,14 +1414,18 @@ static timestamp_t approxidate_str(const char *date,
>   		if (!c)
>   			break;
>   		date++;
> -		if (isdigit(c)) {
> +		if (isalpha(c))
> +			date = approxidate_alpha(date-1, &tm, &now,
> +						 &number, &touched);
> +		else if (isdigit(c)) {
>   			pending_number(&tm, &number);
>   			date = approxidate_digit(date-1, &tm, &number, time_sec);
>   			touched = 1;
> -			continue;
>   		}
> -		if (isalpha(c))
> -			date = approxidate_alpha(date-1, &tm, &now, &number, &touched);
> +		if (!date) {
> +			*error_ret = 1;
> +			return 0;
> +		}
>   	}
>   	pending_number(&tm, &number);
>   	if (!touched)
> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index 6e63130ea2..2a33aaa327 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -211,6 +211,19 @@ check_approxidate 3.weeks.ago '2009-08-09 19:20:00'
>   check_approxidate 3.months.ago '2009-05-30 19:20:00'
>   check_approxidate 2.years.3.months.ago '2007-05-30 19:20:00'
>   
> +test_expect_success HAVE_64BIT_TIME 'parse a large number of weeks' '
> +	echo "Jan 1 2099 4000 weeks ago -> 1651778400" >expect &&
> +	test-tool date timestamp "Jan 1 2099 4000 weeks ago" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success TIME_IS_64BIT 'reject a quantity that does not fit in int' '
> +	git reflog expire --dry-run --all --expire="1 day 1 second ago" &&
> +	test_must_fail git reflog expire --dry-run --all \
> +		--expire="1 day 18446744073709551615 seconds ago" 2>err &&
> +	test_grep "invalid timestamp" err
> +'
> +
>   check_approxidate '6am yesterday' '2009-08-29 06:00:00'
>   check_approxidate '6pm yesterday' '2009-08-29 18:00:00'
>   check_approxidate '3:00' '2009-08-30 03:00:00'

