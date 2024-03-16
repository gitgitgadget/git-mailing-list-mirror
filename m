Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CEB184D
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710553803; cv=none; b=tkDe+hIenDInYokj4ISstxVEff6IQYnmHBJzoxytvhOAsN9hVwut7ubh4OW4OfP6kQZRFVXGTSrsnAf2KzIONy2SqRln4FA0iWBwTaiiZ71XBnUbnbKKqv7Tp70Df+/DOKNfQVHN7P+ydjZeVDuy3cOuOTF+SEbNhwGfXkhyt/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710553803; c=relaxed/simple;
	bh=XOLLjREfCpECFBvEwckNDiG/GQceHCTaISzxWujTJJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlsEBpaqtbMYI+9GAUziDEUbwGz+YOUS8j27xHD2rXpIAkdjsEu1+gOmTWBdqP5kc5/VWpCFhXrQsSgHga1fAARpgGLiFqp1AXvYLr4T527z05wsoMweZXnXEzZvfEctFemSjI8/SJ67CaXgm6gfuDoVf/IvaOeiPW0ZF6vMNbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ZPV+bBaP; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZPV+bBaP"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-690cbf99143so14839216d6.3
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 18:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710553800; x=1711158600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KoKvplAH8HrizHHdnc2KwWisyRXtMSqbXOACZ9zE0fA=;
        b=ZPV+bBaPTaX7pvlGqGK1i9yIqQPPjUYdeGtPvHT4ySypPh9t1nHLF0gt7JOP9Hf/He
         SAj6KzYOhWKcw1CwKjBmefyXuSAVA21F8ZQX7sdzCoN44M38D9QN5WisICnQTxwc1jaL
         k04Y9SZFQI3M1X3wkTzmrXb5dHI2bD2aryR8dBurNLzEixTLx8gbS5shVhPs2Le20/44
         boIPTRgKHYmZPTj4dJ10+CJJuyZmF+rlTMTWF8Khe5NqqFmc/J2sYfISy1V3TDEJcQor
         xPf9F4kzzdPL7AXHFOgAGdsE0LDWoCEf529qaF+ZaWGK3LeOzvSHai0wtlMPsozGMPqU
         NCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710553800; x=1711158600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoKvplAH8HrizHHdnc2KwWisyRXtMSqbXOACZ9zE0fA=;
        b=Q0EQUutKteaAjRvRriULwSf/0o3naxrsVpLqbhFK5sMfQddB9IjHX9I9+W+g89Davs
         YVwocWXqj9yKWzGM4LqI8oertmvsk3YZPlaOeipyYqFRJPa60fG9MQGnVVQXgAGUJL1N
         qaV2/s7g7vAm67/zB3B0uWxWFebEma7a3k4w/Z40T6NYQQlnvjleHOvESnjAKvJLyx7H
         ph1G8jg4KX1cD3PW+vVYp6oQBM12zWLbDYCFXBwSWH6d62jCRJY72MlT8RDDnKPZGcIU
         QsdgkdamMS17xw83d50nKuysN4P9A/1aOYgSxdRj9ewglSEn5hO4xjnKJaEJ+bvy/FFI
         isiw==
X-Gm-Message-State: AOJu0Yy0Oqzck6xlpQQYaaytZsIzr9BnMO0tGwjJfmHu9Til1V5x0PAs
	pltuoiv3TbVOdwv/cr9Dn8HKid5STpTg/u8DGvbel8dVrBfopo5YNQKR9HFMo5A=
X-Google-Smtp-Source: AGHT+IGd+JPWy38mdU34zlTcc7nOLNMCY7heRbUTIe93QrnGzBGGwOWk+14ZibDgJux1yLxLMbkyMA==
X-Received: by 2002:a0c:f88e:0:b0:690:b8d3:97b9 with SMTP id u14-20020a0cf88e000000b00690b8d397b9mr7009342qvn.59.1710553800339;
        Fri, 15 Mar 2024 18:50:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id gc14-20020a056214230e00b00690fd3f6e3esm2615407qvb.104.2024.03.15.18.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 18:50:00 -0700 (PDT)
Date: Fri, 15 Mar 2024 21:49:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Beat Bolli <bb@drbeat.li>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2 16/22] t/t3*: merge a "grep | awk" pipeline
Message-ID: <ZfT6xxBnQs6ppYB2@nand.local>
References: <20240305212533.12947-1-dev+git@drbeat.li>
 <20240315194620.10713-1-dev+git@drbeat.li>
 <20240315194620.10713-17-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240315194620.10713-17-dev+git@drbeat.li>

On Fri, Mar 15, 2024 at 08:46:13PM +0100, Beat Bolli wrote:
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  t/t3920-crlf-messages.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
> index 5eed640a6825..50ae222f0842 100755
> --- a/t/t3920-crlf-messages.sh
> +++ b/t/t3920-crlf-messages.sh
> @@ -97,7 +97,7 @@ test_expect_success 'branch: --verbose works with messages using CRLF' '
>  	git branch -v >tmp &&
>  	# Remove first two columns, and the line for the currently checked out branch
>  	current=$(git branch --show-current) &&
> -	grep -v $current <tmp | awk "{\$1=\$2=\"\"}1"  >actual &&
> +	awk "/$current/ { next } { \$1 = \$2 = \"\" } 1" <tmp >actual &&

I think that using `next` here is fine to ignore lines that match
`$current`, but the canonical approach would probably be using the
`!` operator instead to negate the match, like so:

    awk "!/$current/ { \$1 = \$2 = \"\" } 1" <tmp >actual &&

Not worth a reroll, of course, just something that I noticed while
reading.

Thanks,
Taylor
