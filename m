Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795511170;
	b=dKF9gyxtNBUkuCaPffNpqH3BTCp+NEQUwNZa74Wb5wR/Tt8pQ07qOyJ+B/4h20ROeWEG
	 KT9ejvdCwDuJtPEBKI87Wxr6Vz63hGOS8Hy2J7onmHkhOELAR7grXWbat5a/BDQupjoaQ
	 pvNha6BsuZKDac6DyQwoPK8yxatqsIJ6ssG48N+v6PECJc4ICQ41S552SUyQVzm9ytkrD
	 fpUjYKchRbRNT4q+Pw6xahrHU/EMB9j0vVvDJ/WqzUhFETr1a1ePVsVO9rLbJOyH4dnXh
	 IrQDNzk2Db3sgMEH68OXWc5hHNzUbmqjuXwrwQ/2X4xM1+TVMbgP2h5Uh5PP0Ne21SQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZJMvCGnos9Jz54qvdIW4S7vkuiL6SKnCaAAg+sfpi9w=;
	b=JCTEdhtVNc6DpgIPmmFXq15KmKShHmv6tT2en4KzAJhirxg9OfnxBfSC/ilZhWjTWLrx
	 rjhNiBkRKTKjwMoa9lWee94Kd32NuEIp/+cJ/wEU079Q6W685oQGICujEK1MCnPetOjP/
	 /aDyCMQgEvK4jc2MN7cFi8SdQxNqR5qkCgSrIVSeY8vHxziRiVGCqHdwYGOt9CyutReSj
	 xFf57bPTP0d9Cx1CWW2GYSKMkmDifcKwdpw7mJ1UaYPeRBNKFX7j5VuxOz/vOFeSJ+Bs4
	 T8QEOZDE3UdJ42z9jh5GvSNWzhhzDuQGHfC9QHWoTE3gyF1gXnmHmBd2Y1rvxIFoDQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mSh8VUuG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18EF606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 09:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F18EF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mSh8VUuG
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b5786e099cso2031620c88.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 01:06:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795511169; cv=none;
        d=google.com; s=arc-20260327;
        b=T5mqFVUuaTIKItuIcbEZgBEa3ZgnTd9jas8WfngUpI/tCW+F23f67bSAc7gWAKFCO0
         20FS3uxyA9FyPPRGpS2UUA57Q4ehG1WzK9yTc1QivLMO1YNMug4aN5/wsPJVXXK4HQl7
         R8FByDA7DOPndYhlaDjXKtQg3I5YY6nBXRMNwR4TIdiGF2a3DRcpFFRg7kxuI26RJckt
         wD8hecjW6B0ZCot/UytEGwQF2aXfWjXBbF7EP1A4WAaQ0ZL3PPLUrBEbihtHOIi6RIKJ
         3eG7dtJBES0NGhUc9b85TJDjOIVqnqgu4iybHIOt0mkTFgn7sqyO5Ugu79opUDbdkdqO
         Bs/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZJMvCGnos9Jz54qvdIW4S7vkuiL6SKnCaAAg+sfpi9w=;
        fh=M0bpdXiSTXdD+3QsRqpLy8Sf9mfMfWjg6PwNpY05g9c=;
        b=VkQGXed6Ot8wjELrgwjwhH1Jg0ST4HiQKB0F7+S/gDldELUiwA3P7vJiR2ZlYeW2Lr
         pp+YQNHeoPTNnEDRPQmpPRwBUuUdV6X6QDdEtvC2aKR973xIPXiZ+4Q0+Fj51e50dv4i
         LqNRQMeGbLtXCuWabU+kF60a79uAGmYUXcQ4kMkL2djPdC41DK0OIJTGOo+Eg57C4k+c
         bgGI5N6o/l23aFOEkv4420Mv4F4RXEeGbiKO5ywGgFzVhVXp5NWOdR6jHM2CaDZnpALj
         5o+jRs/kf9BdOuIkXUgvXNJX4UFIIxqjDOC7Pud9EJaVppkm7qt1ieyiW7RKuq/tnNo8
         9vHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795511169; x=1796115969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZJMvCGnos9Jz54qvdIW4S7vkuiL6SKnCaAAg+sfpi9w=;
        b=mSh8VUuGDPD67aUZf41SLWZVchfKlbpSuk2PKOvIFXr6eb4/dgt2/pOZ8ifeF3kNin
         dZawPJqNrPaHDFjGpL2gMit3aqE+3douula3qvWBXauzbImMEZ6g6gpBDn9P8Uk8Xsrb
         LUZ9pVyKVqO3wqiyruClgUm6knifqTs6WuQSUb9Llja9cwbSwDszciVrj2alzgiyvZci
         7kqj4e18dHPPja/QpG+gymyPbDS7ZKtoRra0F6y2AidphZzzNG2yzCovN8uaAFipxypb
         VskYt9YTtdZ3nEQp+fTeta0FS7LC3mSOlfdg9gpsEV8K/Cr7EXL7QLuf5ZtwCLXozDLi
         JcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795511169; x=1796115969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZJMvCGnos9Jz54qvdIW4S7vkuiL6SKnCaAAg+sfpi9w=;
        b=epfFdPHRrKFAeavQhlyBE5YDoEt5PM4IHW43mKSGgA1LwoyyOALAwr5OIgAIrgxDf5
         3VvdaUxMOS3fcXBtCQ6fHwnZCI5PG3sa8renPtPkDaRh+/EPqdCa9TqXTbTLreDga+LK
         Qo7nfooBpYvVpyZkkr5ukWqsJpDdrF1r1ZdtSY9a9LVfuIU081+0MtqTN8PSga6LCHBH
         B83HInKYT9el/olnjCoa0xOzA3zPo76VeEZ9AISlDUeWG8PaE79t1+i92rWk0VEXjpdr
         z91Xxo7xNT+Aa5lGQUbVyGnS6ZeMaQhaLmI/x0ZjrIUrbPOZYllfjNgO7pP3M58RhMR3
         kQfg==
X-Gm-Message-State: APuU4Z9GsPq3Yh/aVUkBJewcmLMtzIyjjW2q/oZFndwpxArdD7KxycOG
	fCSjTfEBic5aKx44tVsysPHG2Hh4ewAJMYwnBIKQscvSP8+lBb9AEnkmvKtm3sOP6k9x9oljclL
	pmowRDQ9nBKCyMs0luTcVnqtDc+TVoG9sh5xv
X-Gm-Gg: AZFdTZf66Asy5zDgsaFTApQJZrfYKpBwsCSchgNT81UDSc69V4rqutQ3Ht95yln7drt
	l0QVTJfVeeb61X8h4kp6RfNi4LjTXxoxA7Qg/wi0e0m50ox7rG+By5XMvRaCH2xN5YL5sYBMEO1
	pet75T2Ga46O+5TqjBFJ18NfXKhFmTTADgcyq2hpTYxxdr6d3qj/5DYd9c+JLdee+yC2yWIJbFq
	8VuqeMGiLSQ2ln1JOF4vjdJtpPhHyeDAriYNn1Tlcx5wXceZVckliWM1a+DHxsz8S/39phE9ay4
	WAFOlmLctvRf0ZNS5EpB/fZM+3Bs97sI6SbdF86CttkAcJORSTOG5xV+R2PuYh5/0tNEvVBM6tf
	YwNAhhVnCGF5sSpSxyj7JDWQ/rw094rIO6ApEq+oP5FnhGTN3siUGJzmJ+YYg/S4iDD0ar8xpWX
	iHignd8ZY71rtf4woqhzlKIOu0FY4/4ha5HSPXk+ZRgZ1emHVvGD5Bp63M/XPmQRq7NmcVp7KWS
	0S+RvmhxvJMFyi5HLUSWMyA5bAgexEtto82loPQgCNqRQ==
X-Received: by 2002:a05:701b:4516:20b0:1b5:5a87:5862 with SMTP id
 a92af1059eb24-1b55a8759a7mr12694375c88.21.1795511168939; Tue, 24 Nov 2026
 01:06:08 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023211533.73433-1-okhuomonajayi54@gmail.com> <20261104090534.21838-1-okhuomonajayi54@gmail.com>
In-Reply-To: <20261104090534.21838-1-okhuomonajayi54@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 24 Nov 2026 10:05:57 +0100
X-Gm-Features: Aa3M54r1tcxMqAcDFA7bBVf0_ZM932x_lDoTUvVxMUWhVH221EcYfGtNvTnMbSY
Message-ID: <CAP8UFD2LLCCNT8YMZ0FKatY=dFsUdoX-waYGbN_TnaU86WFs4w@mail.gmail.com>
Subject: Re: [Outreachy PATCH v4 0/2] checkout: make unique_tracking_name()
 use the given repository
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, usmanakinyemi202@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 10:05=E2=80=AFAM Okhuomon Ajayi
<okhuomonajayi54@gmail.com> wrote:
>
> Changes since v3:
> - In patch 1, unwrap the lines in repo_for_each_remote() that are
>   now short enough after the switch from the_repository to repo, as
>   Christian suggested. Patch 2 is unchanged.

This v4 looks good to me too.

Thanks!
