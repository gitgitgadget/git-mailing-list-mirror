Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508710;
	b=sNVnNW1qPPUGt5/GLolVNIGpwy7jpx9CB+Exl/VP/XtnnAGLETTdpUI9zSyxNast3Kxz
	 yL1rPwFZ2YIfDpngjnH0B4l0mazOfWJqjEMTS8rZ8mpXvbs7Cy04fCC08swGBoJAF55Cc
	 pS8Mucp/bNOPb8eo7pjiRkoazySTJDasgcaAu5/ycHKf2LjiD/ZXR8wqmOe7slWuU63a4
	 iBQQT/y3vnDHnF7mc1GbPMcl8fkxhvrHQaTn1BPJWUgbyk4604PmjFmZ+lgnVDKnCzVSD
	 b1NUd+OaBMSgDV2dXjX9Yujt7x3ENuZ+XFm4bqlnsKJcQsWCkVAjrCnhAGV7Tmn9z5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508710;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=FVO73lO9tiq17NrStBzm1RrKbt0tHSLTkpl8lrvKYOA=;
	b=xtIHVk1OatELVp4no69g6kS5rWiFfSUdTIXoOsE+2m2LJEAd6fyeTa5lH12JQeJ2+/gU
	 xe8+BSX4rDbNFLTBO4O48rGdS6rIXKPli1YGITZqihOd8mSttAuPJbXJxwh4xT5T5mgTu
	 ogdvJ2rlW0aBlAEfnTg4nLNMmR+Eep8ftLIuOuPJw6SK33kYcwPikQ3RU9YHcWPHwj/wD
	 nfz3Nk1GVHajelh/QIoqBvEEMPkH1z4iibZJZhtrtAkVHUJGM0kZwkXSlTH7YyLGnwmnf
	 Q06Jv2ctS/t/AfduDGGusl/19hK4/Rk/nnGOMcwjQUo/VeaFQ7rvFyVvvMQ4Bu6X5ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XQdKtUi8;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF7606A31C
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3CF7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XQdKtUi8
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c169ae1cb26so139007466b.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792508708; x=1793113508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FVO73lO9tiq17NrStBzm1RrKbt0tHSLTkpl8lrvKYOA=;
        b=XQdKtUi8DO0VAy5wYURcu4mHG5NXJGjwe4XZ4+vOVmkg/9YR5dlbB6zivQzbJ96LuG
         opKCFDFj5K0SfLfQcM6+etLPkGo0fz4eVuHmmhNRpA1BksH63IPtIo9VkHIW6dYSVvfo
         HgUHqVAm2AL9VH5BCQwgK4kg9UkOBxI8zBuk5lULX4cvm/GDBRHlYsUQTHzofD7vkIpA
         vtK09FB/IvsVvMXlm3tjRL3s+sI4+pKfZcFWb6ilbkHuPRxTTw9PSyhnjBJ6TThp8Vat
         usszG9I1ejPnl11aLMWdCrwsr/dPbzEX6koxPMYPRKTS+idiX6jAGGuGLRtFafPtvnu7
         MoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792508708; x=1793113508;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FVO73lO9tiq17NrStBzm1RrKbt0tHSLTkpl8lrvKYOA=;
        b=aj1Fg645ebU2sl7hjP4f7PVe9rqx1TpiEzqddtVYlt2ibGFnuKZF7OIDvX3OabTAvV
         kBkOp9Eyog16TkfuB/wz+8P+wZtZX+VbDmsswhjDWRxsNbq5vcDxo4Q4R0NOcJtetOUp
         3FJrxTSNd2OS3Tf6dMFRO7qvSfU8SYmVqbAskXx+qhvg6+d8Hbj96eWbprJLY7Sd4BzU
         II8WRIs7TZk2UlWhE9KLj9ISRsGab0UP++w3rw7oNg8XUqFZL/6JShABGkXkE8gPpf+Y
         tZRNs1sW2L+wedJQcyLf/11Xr9lFbMl5gJTpDHZrGdtX0G3jfXClJwmTChsuyd+O/S5F
         +aiw==
X-Forwarded-Encrypted: i=1; AKwUvByHudjpv7tVLSWeWRBAnG1Dq/LpAZ6GjbESfPMncOzE6BPwTJ8yoNMkuppB7PQlXXwIhs4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdcgs9O1o2CoCr6PBR/bMf2uTVzIdY91XQ2SGSRl8lwlfXWx0A
	KBxEwf+CkVhVLdMsOaF/aWRZTGXGVP7QWR1saRTDzpD1L2zus0vEXnX9uOIQGA==
X-Gm-Gg: AYBFou3Nmez3/ZF6q5pyKgVWmGszwxlHJtoUUCPHOipCrfGuozXUANEm1yajCaCoSZf
	TQbKrOy63VAs1zpr21kiemuxIbhlynFvJxrUnWDLdpa0nUtUw2YgQcmHjQ0ll3nT5QnnAienvgq
	6UCrqOiWGb3ay7m7WYwmLLng2UZWaK6r9FSW8pWg/gP2zqx83Two+uHAy3BszO4kY2fbfKqKPI3
	Fpy6jeFPmCBI0wxD6t4wxXYMvxrwgU4cQdy3kHo3kQl3Q2PFR8Ce3gs5ag0pCb3mg5q8CLeE2xX
	YIE7OqnR4QdQ11KuC+29rRhD+K2dqNbHRL0Hze0tITSuWGMcfB4ShKrDhxYsVh6nYpeW1aPyB+s
	68d/dFe/kGTJ3pbR2F1e33HH55XTPlnSvFx7bC75Kiqb8XR59iJ6aF9kRNUMVUxJxFDf0MigJa4
	n+HBvKOM97RJgbdxky2TyC3R4ARJ1EieN+pp4lZm43Hy73rBIusSU3ZyigyeKWsLm5uDo9+UIxL
	/0qq3N5V+uXA+1HQrfjP4rMuvMrJvzMwZW4k7r7UsipL1/uH9Zo
X-Received: by 2002:a17:907:cd07:b0:c2d:c6e7:9e9a with SMTP id a640c23a62f3a-c4602939f5amr223425666b.11.1792508708042;
        Tue, 20 Oct 2026 08:05:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40918c5f47sm494012166b.51.2026.10.20.08.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 08:05:07 -0700 (PDT)
Message-ID: <c578557c-c38e-48f3-ba61-fb2e0b139099@gmail.com>
Date: Tue, 20 Oct 2026 16:05:06 +0100
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
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/1] archive-zip: refactor 'path too long' error
 message to use Q_()
To: kerylefondji7@gmail.com, git@vger.kernel.org
Cc: gitster@pobox.com
References: <xmqqmrs92y4c.fsf@gitster.g>
 <20261020102210.829-1-kerylefondji7@gmail.com>
 <20261020102210.829-2-kerylefondji7@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20261020102210.829-2-kerylefondji7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keryle

On 20/10/2026 11:22, kerylefondji7@gmail.com wrote:
> From: Keryle Fondji <kerylefondji7@gmail.com>
> 
> @@ -328,8 +328,10 @@ static int write_zip_entry(struct archiver_args *args,
>   	}
>   
>   	if (pathlen > 0xffff) {
> -		return error(_("path too long (%d chars, SHA1: %s): %s"),
> -				(int)pathlen, oid_to_hex(oid), path);
> +	 return error(Q_("path too long (%d char, SHA1: %s): %s",
> +	   "path too long (%d chars, SHA1: %s): %s",
> +           pathlen),
> +	       (int)pathlen, oid_to_hex(oid), path);

The indentation seems to have got messed up here, the level is wrong and 
it seems to contain spaces as well - if I apply the patch I see

Applying: archive-zip: refactor 'path too long' error message to use Q_()
.git/rebase-apply/patch:17: indent with spaces.
            pathlen),
warning: 1 line applied after fixing whitespace errors.

The code should be wrapped so that lines are not much longer than 80 
characters and should be indented with tabs (possibly followed by a few 
spaces so that the arguments are aligned).

Thanks

Phillip


>   	}
>   
>   	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {

