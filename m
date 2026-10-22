Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792679374;
	b=0lBKc3AzW+7SyWri3T2TfjCH1SsBAzw/4X+OJVA7u4t4OJcOP/YB2qCvKGNSxjR9YW3/
	 07MRGiKTlP/E4gbaUpEsXJx6Sb89AXyGPNGEVuRP/TDXm9+1POZMQXXG276w0UnLC1DbT
	 6rNDXNVLnwHSEQ8b3IudCgjuUA/pTjH31wq+1wHviHFY1afaX/a+mqVIpPw+5zTCBmNbY
	 f8c95vAXLvPBnRFjrDx7jnqUW5Z+daP5lt8ciZSF+eePz0OqtHXdetZ46zPNKTUzSk9kx
	 3V8t2gYwawMSqZSwhmebm/F+hmnl1VQ6Fxx076oU+bFvvS0NNZBE3z1+t958Hw/X7fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:Reply-To:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=3u0Df0XLw/+iyx3CCdP4Be2ZFxvojqcobqWz3tb4H64=;
	b=w2NHZNgWhWCYETYbyWmy63DWb8qrdCtkomOtDn75UAVoD25eDUBMPps9FOA5zCKQzmt3
	 Xjj/dhUCFEAijPcG92+mQ7CYqjBrikhRaRsxb8b68xu/L92ZPa3pSGMAFcz+eqTigzszb
	 pMCVn9z6D28fOPEPciNS8o6nfsQ7hvk0vCaRBSp0Pv+Fu8ri8Smj8+0ZqjJ8TTR91broV
	 UzX1wdyAqJ1vPkaAOtSSR7BG5vmZG99Y0DatiIhvOlppI5p6c6gZYOKSwkhqYdk9CXLeJ
	 kVbUt8EOdZpse71neIYynwQp8PGH06k08JoHGYjIe+Q1DrVgDpcF0y8MM5F0xnsYnIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bBKnaCoM;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7695E60A2611
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 14:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7695E60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bBKnaCoM
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1df146015so15251525e9.0
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 07:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792679373; x=1793284173; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3u0Df0XLw/+iyx3CCdP4Be2ZFxvojqcobqWz3tb4H64=;
        b=bBKnaCoMyUZLi1hu9JFq5r4ONUaOIob4bxPms684eNixIJmAUAOKXLEyqXP6H8zB2x
         AQ1LKXIDrNqLp9TyJH9/mgQFVvKOhvB9vFDv+EDhPTfWzYpMtI5wZjL21Z606xDQiony
         J/98c0SIZOggWiyodO1JoO7qztuWkTI7lRvVNwO7pAjZEuzP3wATstAeRHDCZIzb0iV6
         nEUt1f/DG3aSb1E6UygEJiLIhEN52UgjqrHfiEJDYdCAqMji+PoJtvzg5rj7NWDiUR/w
         9cuTDYBqnaSN/bmcC/kxU3WuilbigZKkFvFD33WBFBcdiJR2VSUxielX2q1GTGdW19ub
         sNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792679373; x=1793284173;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3u0Df0XLw/+iyx3CCdP4Be2ZFxvojqcobqWz3tb4H64=;
        b=QfxdAMuLt6Uuzb+PjBPEpKWzNEviWZKi+aXfH6ghSEujaoscH86Mp2aPR3qGgjywaK
         XpoUXcgaExFny+mj5tpwOmzfGOrTQ/A7LLyN9gOiO5liPf45VvWpSC114mH4MrcWA3fa
         LhqmCVSBjvSTL161jup3BagTGM8LesPIKCAgJ0B6DiyJi/Ahjaxvse9eQqu43SYHB6/k
         DnmTHfvYsvEv6exXAL7JtQgdEWpY40djtmlxeVYYNDWrRgMiIAg46pE67hrVPHGred5f
         1KTocg/aCsrY1lw80TYJ+L8foXyoXNkUCcOdzNMah9udjrXsE/+V++ndqOwhO1dMf3hX
         dRyA==
X-Gm-Message-State: AFq9FYLdNo9jBvCvNNE1hPqo4Q+gLvYub3uqc7eoMPcA/9EqUKKA4FYF
	Pfj4p01ocQG5bUs5e9jLhxDAF/8HkduUHO7CZpkXAV5Gq3/L9h2xBDr/
X-Gm-Gg: AYBFou1CDEVGyXmacQNubSr43TXv6Fix2AAQeK2Ubu2NaMvXBIkqQ5Ed+SV3Q4Xddq0
	Uev1a4Tvnub+64s/63ljx6PPknQLE8xig6nAopocL2rA+ToazgSetIaFfsVygRW2KEw8d/tjDGD
	ZhUb7LSjKVZsFWMks9jaHr0tgSspjI2XlcJErxGsIzkeb+3WkAuIestF1JeWG+70FdY/NfeYd/O
	g/QHyYEAnwHwkihPXb4DXZ2xxO2kXHZ1x0xuDcj92HcMoeMv1/WdpcyFOq7KkGjC6ekK9sprV0C
	msxvqp7A309lGt54qKFKQZEiiWbsOatEiRFWfow6BnQZRUXFHv6Z2W7HYfZrjRZPZ1jrGhkD1Ih
	9kHIm7jWWhyx9dNR3eT4AgzBrIL5ZZhW++UJsFEol8k967kVcwHJnALdKCB8skWRIOTCLEGd5sv
	xySN4OYDsvljwNBxmGFxnkLQqj+0VmbRFPDG3DkEccRcJyIsYixyi6SH5oijirSTNwKJDbUHCKy
	lea/jVAuLcOKnBXsMjrct+HoAbq45DLcfqlD3Nt8F5mJmb+XziwjLjIoh13dEAG5niixgutoKPo
	9vXPMwwy92noxa1+Iw0J84al/IjGSgKrPPZ2
X-Received: by 2002:a05:600c:3490:b0:4a2:84c:52f3 with SMTP id 5b1f17b1804b1-4a2084c543fmr40891385e9.6.1792679372491;
        Thu, 22 Oct 2026 07:29:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:943:f41d:f056:35e7? ([2a0a:ef40:724:6601:943:f41d:f056:35e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203b66f6bsm104377065e9.15.2026.10.22.07.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 07:29:31 -0700 (PDT)
Message-ID: <57e076d3-cfea-475d-b68d-a9f36746db35@gmail.com>
Date: Thu, 22 Oct 2026 15:29:30 +0100
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
Subject: Re: [PATCH v4 1/1] archive-zip: refactor 'path too long' error
 message to use Q_()
Reply-To: phillip.wood@dunelm.org.uk
To: kerylefondji7@gmail.com, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
 siddharthasthana31@gmail.com
References: <xmqqmrs92y4c.fsf@gitster.g>
 <20261020183908.861-1-kerylefondji7@gmail.com>
 <20261020183908.861-2-kerylefondji7@gmail.com>
Content-Language: en-US
In-Reply-To: <20261020183908.861-2-kerylefondji7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keryle

On 20/10/2026 19:39, kerylefondji7@gmail.com wrote:
> 
> diff --git a/archive-zip.c b/archive-zip.c
> index 6f73ca6d58..5ab3ba786f 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -328,8 +328,10 @@ static int write_zip_entry(struct archiver_args *args,
>   	}
>   
>   	if (pathlen > 0xffff) {
> -		return error(_("path too long (%d chars, SHA1: %s): %s"),
> -				(int)pathlen, oid_to_hex(oid), path);
> +	 return error(Q_("path too long (%d char, SHA1: %s): %s",
> +	  "path too long (%d chars, SHA1: %s): %s",
> +	 pathlen),
> +		(int)pathlen, oid_to_hex(oid), path);

The indentation is still messed up. If you look at the deleted lines you can see that
we've lost a level of indentation inside the "if" block and the function arguments no
longer line up. It should look like

	if (pathlen > 0xffff) {
		return error(Q_("path too long (%d char, SHA1: %s): %s",
				"path too long (%d chars, SHA1: %s): %s",
				pathlen),
			     (int)pathlen, oid_to_hex(oid), path);
	}

Thanks

Phillip
