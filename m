Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF7C363C57
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780974663; cv=pass; b=YCtPRcriMzvHAZsCpSWIHoHiDK7gd/78g353j4msVSeKvW9patoEJPsAxDGaV7Lt+kdg/fmSKYmgdcFxlfvklmCQqxmmN5fF/90tX7Pv+MeUSQotoO/Oegla1+qpIFvAOtS2F4IqvK+8bgwWhgQLssA2e9xuP7CKdCO1HHfKHmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780974663; c=relaxed/simple;
	bh=XZs9StWG34AkHXqqnP7meu0YixbfhbjE9QlrkXcDuvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uHUoETHc4iIGJbx3oxWe9CBWr6HV/QOjGw5lyiw24wS0HLYqBt7n7qkoPrFkDjMH+DhWFxh8/6Ti8rByeO/i/2PV03Z1lbZJjYKU+aSF+3dAd4G0DzRAa6ApgYCRfJBPOS9g7f3a0DI9Mkti1pDE3dvkZiJRBk71yqOnxAYPDO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrSyP+0t; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrSyP+0t"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aa69131836so4384790e87.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 20:11:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780974660; cv=none;
        d=google.com; s=arc-20240605;
        b=Q79/zlKQVTr7N4R98csz2ckswvNC3QZG3iVtD6v/CcRtGaZh+KGvUYbckCnuD6a9Nz
         +u5CcjwZ/rtBOj1fa9FwtlfO3WN9R4Ht+vMudRVKfVKKcR6cyIgq/QZyT0mmd8UzYDLb
         FLHDQo0kF+3gN7TJ1y6hTLFmVcM8AkjEsK/w72GuKXSOxpmZs6PLLhqalwg/ycrkQnxn
         wV54hcklL6V0uGGTZM5C6IuRztdU/Ml+pdFUrxV6k8tj1oO6Mx/J2GkIXXombrhryhkH
         uwVtO+GYNT3FKHz9tquyG3HsfirCKmiV0h0O+Hbfo0odWLLVrUwtrTOfLR9a4E2SrRid
         u6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=XZs9StWG34AkHXqqnP7meu0YixbfhbjE9QlrkXcDuvo=;
        fh=DJHZ7itWveYVdfezJsKgr6XLEjDMbfeXEew73fqN9oM=;
        b=GpB3GF1vF2YU1lzbSfROBoDMcfQJ+0Rad1h3pdc4NNG1+yvMnQ+TyHHJQpzvWCD/mg
         RvNRCrszvotbls+WrPauoHCmZeBhxosdWAl/TpI+KD7OBWGGZ/ITlzyxxE/V+rmzK2FC
         xTAZxzU8T7GSuUNwUX0f8eqO5MqfIRhFThP/0GK2/ztqiLKEosUM8rjPZJsSy1c+ZxCM
         QHqDn8CH0cf0ulVKGprWHbzFT7dZ2hpS6PD31XZ06JG5brQQX1qSPFPJw0yz/Tx+7jMA
         ADRBElUGSStrnoapcy/8VpNXyGTH02VVqcE+OaIj+2yosi3rXUULE0LUI6/TaeBZKNAE
         ofmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780974660; x=1781579460; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZs9StWG34AkHXqqnP7meu0YixbfhbjE9QlrkXcDuvo=;
        b=CrSyP+0tdFuiaKbmAG6L2MUBOFgH1vlWnDyXh3SHaq7zzci1iTh/NyDsVAYbDd2iWa
         94FSRKPjtyINqRGBvKhEL0JStpOd54iyjMp32WK3wHABM9XpCIFGd7OTheT0dUx1mzXl
         bYawiCQ5NVkI6LnkeOd14ul7zv6gq2baU9snj+q7teMxfnxT9ZB2Hoy+5fingg3+mrAU
         um/nT5B1+Eufpn55ZT9KOIBRz/sYniMJBimUxipUiZZycgxu1fchMz6FCg6RDGRCe44N
         z2y6bUknzpNHRIL/YmvwMLnqfKQM7KxTfe1dVFct9dhLMRBnbt7j4H5aYPZzD2wt5PCJ
         gH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780974660; x=1781579460;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZs9StWG34AkHXqqnP7meu0YixbfhbjE9QlrkXcDuvo=;
        b=DPV5rJG4//ZZ9m6Q+twDhz1QczsDNzjWBaeSt2Q/JjeXcPI/Xz/q2D+WKqElGGnQWL
         hJyInmB7bKp9fQMeukPoopBqHbr6+SGvMQuFg+CKA05UPxGfCcgdDGHDu9wen2AStyA1
         /ClFMDwR9ZLujJ1zM4nCeQ7s3c6F8aRwzzHTiaVFMNqHY3h8ORYuTrrw7mIdyUogD/Wf
         Yy3A6CiL4ThwhhlXLnn5X2Lwtq7UBv6UdkhR4ORQmAFUZgzncS/g9CSxLNLdqSxJ7TWd
         sS3Fs+8xlXd92LXHa/niwdWBBD/2YQsn+bUZ9ZgmBgkYUtz3vNLdrNSLGDEgsE7582KM
         9T4A==
X-Gm-Message-State: AOJu0YyawaGAT+bi5f+eSvp3ZnweeOGizyfhcUdOGJGId2bJoZ8/0UUy
	WuKfAel0WkfOAHgKvCveXoOM0ZtYMJ+e317cicwXL16rDlwghOiWxfErN7KNnORRjtvOIai2eUq
	LnemTDIOB4jtT86WCwKxLO9rzo+gEBN0sGQ==
X-Gm-Gg: Acq92OEASMBuFqQjA2B6ttbtCBoMo7C/emkPLgQxB7uHes8n50HxGwJ6idS4iQFtO08
	KZSUlLNUDpu3F8RUQ40sOeEAYvT275v/zUwGgFzjOB65pOjICZvfh0nccF1ON7oOSVdWC4TghQ3
	c33yMo3m4S1HCVYzHr9j46I+Own+LLmiBfC2Qn9I5evf07aIuasiv+KsUaWyW0F7Cvk9clOwV97
	S4nEZaAwfybnA4sETNwYVnP7NXhjum4dabmh4LZz/UA5D+XPANCfn63sOppfJSWZz2DmhrACcZN
	Lua4KmtC6vuLt2qoxN9S93MkgdLUtipKcEcnv3Pi/YtEgU0I/IHRAKRZheAq9f6Ev/t+p9EhiZB
	iykWZe3TBG9lkU/u2ct3+x3hRLDERdo1ZTFTg
X-Received: by 2002:a05:6512:1114:b0:5a2:c0ab:b57f with SMTP id
 2adb3069b0e04-5aa87ba43a3mr5226689e87.14.1780974659984; Mon, 08 Jun 2026
 20:10:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLee083Whzi3b9CP3Hxrq_cz58enN67ZQq5r0koczKeU1A@mail.gmail.com>
In-Reply-To: <CA+rGoLee083Whzi3b9CP3Hxrq_cz58enN67ZQq5r0koczKeU1A@mail.gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 9 Jun 2026 08:40:48 +0530
X-Gm-Features: AVVi8CdlLdZ7mn0yXTxYLSaYKGUZE5mQuILQUxj--QWcetd4BBR0jC-GESBN25k
Message-ID: <CA+rGoLeNzxaTrq50jE=at=0ecnZ5Diy+Q-0McG-R+XFTQ7oMow@mail.gmail.com>
Subject: [GSoC] [Blog] week 2: Improving the new git repo command
To: GIT Mailing-list <git@vger.kernel.org>, Justin Tobler <jltobler@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hey everyone,

My Week 2 GSoC blog is live!
https://jayatheerth.com/blogs/gsoc/week-2-feedback1

Feel free to give it a read and share any feedback ; )

Regards,
- K Jayatheerth
