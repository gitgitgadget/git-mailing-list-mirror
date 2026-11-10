Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309293;
	b=kP3WmvouQsxwBuVqm42E/Dh8ilJqUH3aJJBe/JSw8favWe+ObnI1qA8lm/bGqfu2cGdV
	 Z8mB0ymjhAPLtuK14Vtu4oCQn0lE4VhCOOpsakoQIEAMHd/FFwJlOpUrpiDR2KquPFZ43
	 4mZMB87Atmkqq96erGHA2uOpJfDTZOhs0F49hQwrMVJE3fPFxUFQWGinEFI26kmi3cErk
	 KirrJMFHuyAAJrr3YpsvXi0un6lrGRAMCXgW0SReejY1xyB4bZyZsHoQiku7betWXz2Ot
	 +LZswx7VFAiMGITuiYxdJKtgB/yuVk60WuCjLTdClXg5VgMAs/loXVEvrY/Q9PT2c2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=EuwTZ+LOGDDaP8ZLuhosSgSqzGeT04bAGP7XNSlby6o=;
	b=Pt4EDErvD41/SMpVMCs7mxVy4kXBtNCCLujSRORMDTDq4VZQ2uuAQ6OoEcYzJ2AHqDBe
	 QENsZPAaJ2RdxetdXiFkWXeo0zjKuHxP75qRhUjUDI5DWb22qxYpVeOa8yFEcjScl4ra+
	 wrOiQiI1wq6O/X1ld40Y1YQrQ5sEy+EG+1ZVOn8pa0zwLwk4xRy/oKc+/Y/v4szL658Gv
	 RUgsLZuM2eqYZxxm7SrKswi2987S/IDD2d/imjAo+Vq5Scw0NR6Xf8M4iQh/ix9BNyOe4
	 YcmlEe7Vp1e1tCzJM7aGKYt1va+huLFbZP5zBy5p8X52YraxYgS2+rVA4PQTDlYHnGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WwYfP4iz;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316BF60A2613
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 316BF60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WwYfP4iz
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a214af2076so13621895e9.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794309291; x=1794914091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EuwTZ+LOGDDaP8ZLuhosSgSqzGeT04bAGP7XNSlby6o=;
        b=WwYfP4izgKJ908CjjSmTzrmW2M0/yqVnRXTZU/HX9h6MPoW9+0fjyI9Agaqpkdw0XO
         rCc7rGW0Z87PgoxKqxi5DeVEEOhZuVKf/bfAqy2RYEHituKjzKSzcxAPuDVZYOYBJob2
         PNYV+9dDv47Gawnpj859iorv97uadtzwxxGfCZpDPj038769tEpdN2iSTk01Xo25h1H1
         1febN5bZIuZdKGnclCF+AVekdxitpK2G6AmMTEK68ziIaIoVmdI6p9HdnSU79ym1ujXn
         89mM+dLlkKuDPY73AbUljcRexOmXZYu/2ikv4qUHUdeDEO+rUmVVjZpylZ9J+ONcX2Qk
         HZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309291; x=1794914091;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EuwTZ+LOGDDaP8ZLuhosSgSqzGeT04bAGP7XNSlby6o=;
        b=k7Me6kUndaTVlYwstzLSx2F6bcILiza0zPeoNU7lckMg3HAmiN9RUdWIZB4pZX5bn2
         omoBS+Y43jV87foC/mNaJS6CvwzT+nm0N8WqWgL4eS+BkDI+GzF+56b/QndLbjePeyEM
         PiLaVn6XgG0DOpyKZIwPoiCZ2k5q72eVtrWb+u5Cy6mASvXSqbDeuefNTmkCRMVWZX/1
         zOoGQcY+Wu4WMx+/1FUeq0nDh/TgdB+MEXV/ur99yZj913bW0J2i4oLZLHuUhWARQ7sU
         N224alSoq20SYcS7lySfOhFZWoVU1RrwXb/iHY6RT4kM1MQRl/RX8QDeeUhTwxhU4rqI
         UvkA==
X-Forwarded-Encrypted: i=1; AL+hErHXrdewgQ5rLdRaS141owhNc6neQpyIb/ksOLvE2DFQ80Rw2dEEWdp6s5oTW1ci0f6XpLo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Vapbp8ZlUefWD0xd+RCR16uuENAWX8nBSbGlnZ7ymVe2sQL1Y
	hQeHh47cJhnx/vHqUEfw8dBCpXpHt3hnvEttdOI/kWLP1ufDEGiac4oU
X-Gm-Gg: AYBFou0A/Mc3MoRo+j+J/b6DHk3EDc2XfFSOyzfEW7fjueWfMrwkWRNDho6YN2AfMQk
	fvLT7hLm0ZqFroaTACktEPv+k5SIAaLuxd6SYPx0H8DCCZJIDacgX5bnRDuuae1TgZ3OfrXU4wE
	eD2MzFHaYhz7tIv0I0ZWA7HddG7CTaSm5KG8xtQd+HHaYb4SnFWq5sE8xJgTNvJNjWioe3b9Sm+
	o2Oim13s7m/gKx+InpUJb7IMSWO1pvKV19xASr/6SQFgC4ogvvO/UgYUHbYvelmB3VBf03uXFYZ
	1NYPTyyxAtk1orhyhEc435EuwJrq4f/u7rTfnNZ6InggtXLGSFicC+NnWhACzMOX7BFK0SL1Wsr
	KUPl5FY1k6gKx58zEJq/BwPu5IG/lmhN1tFQ/irufzoq1z9h0FuLL6NfS6rvYFL/+Fvk1iTx0rP
	sZ/QbcelNsSwd1FhGdJjAC/dIGiKrfJj70J+K4LKWJFm3jn6yFW4jo8hJKlhTfMH5nljvjl1bGk
	G/Jmgcmkt2vVq3XvYeRqg3K+s/wBYamFU5MsnZmSHffCZUD5/dQ2ONFnzNdWhR/swURjCUROpE/
	Ft6pGG5IzF1kZA2h/C0E1BMK2VmLRMNPDGaf62rad4OS5bZZWJmb2YRJRHFRPvhbe0jJk1HhLcs
	JwSIN23Y=
X-Received: by 2002:a05:600c:34ce:b0:4a1:dda8:eb73 with SMTP id 5b1f17b1804b1-4ba0235675fmr37970565e9.27.1794309291316;
        Tue, 10 Nov 2026 03:14:51 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498363e0019sm4653496f8f.38.2026.11.10.03.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 03:14:50 -0800 (PST)
Message-ID: <3b91af26-c0aa-4442-b644-01fbdaef4f4d@gmail.com>
Date: Tue, 10 Nov 2026 11:14:49 +0000
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
Subject: Re: [PATCH 06/15] remote: handle NULL value for remote.<name>.tagOpt
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
 <e95249fb51b681b9d9db3bfb3368e1b3257337fd.1794040968.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <e95249fb51b681b9d9db3bfb3368e1b3257337fd.1794040968.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas

On 07/11/2026 08:42, Thomas Bachem via GitGitGadget wrote:
> diff --git a/remote.c b/remote.c
> index 71170f36a9..024cfc547d 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -556,6 +556,8 @@ static int handle_config(const char *key, const char *value,
>   		else
>   			error(_("more than one uploadpack given, using the first"));
>   	} else if (!strcmp(subkey, "tagopt")) {
> +		if (!value)
> +			return config_error_nonbool(key);
>   		if (!strcmp(value, "--no-tags"))
>   			remote->fetch_tags = -1;
>   		else if (!strcmp(value, "--tags"))
                          remote->fetch_tags = 2;
          } else if (!strcmp(subkey, "proxy")) {

We silently ignore invalid values which seems unfortunate, we could just 
print a warning for a missing value rather than dying, but at least with 
this change we are reporting an error.

Thanks

Phillip

> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 5fbfcb0848..bec2e51afa 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -90,6 +90,11 @@ test_expect_success 'remote information for the origin' '
>   	)
>   '
>   
> +test_expect_success 'tagOpt needs a value' '
> +	test_must_fail git -C test -c remote.origin.tagOpt remote 2>err &&
> +	test_grep "missing value for .remote.origin.tagopt." err
> +'
> +
>   test_expect_success 'add another remote' '
>   	(
>   		cd test &&

