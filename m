Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523564CDA0A
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405517; cv=none; b=lsZaGuyUQKmuwnf5R+zWh/G5Bc9WUimvV+LFVu2dkds5X1brh34ISPTiIDpTnXO3ofZK4v/jzl4dkCrBxuZRc22YutHZqlpmIoySCYeAkz55PZiXR6Mi/AS/wViWdkkpba+J5+x7au2oCH7/5UuR7ZD8E9jg0fCcvRsm9LaMSxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405517; c=relaxed/simple;
	bh=6v0aH5Q2fas75kXz93N/rCJwJBECx4eGjtiEP95BcMk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZJklFCVXAraFys/mYkYGGv7aLyo5Z0V2ch5GNz0dClwbicw8yO8Zkp2kLDnLYaz0QhLtVmJkpztNuHObM4V4D9dmvOZl+Q3PcixH72w7ZJqJLjujDQ8dLvec8tm1LbKuoZXbz9uCy/7RN2hhEXMiIM1Un4dnBU+cRJosmsEtKO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCV4vXMY; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCV4vXMY"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5be41a7aba4so116834e87.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 03:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792405514; x=1793010314; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HSOlnhRR739tGHruQiSq9vDXhN1boQ6Ah7q2ae209V8=;
        b=jCV4vXMYDUSnf1VfdpeR2Ok4TNOfOeEhxUKZD0fri73EMr89ZVuUujwsLnuoQWmMPD
         qm0Ert5qZlkMIpLgtXRIMp7+1MxdxUY9aESjG1WD731xAcW95hi2Mz3Ms21DBd/w97Sy
         NL0bwDTIEGrvUm0b+ACJARyKBqE9V9jKpsKgAtLhPI+Dgq0FzO2Z/fGSOLwS+rjMpmMK
         N+Vbl0uxrPRUNz6PWMds8sRDHfqR5fOzF6grUr2MwYdQzJhXE1c4TumIe4xHllEfsqBe
         881NQqTzW36Age1uHupSIG6zm7Fyjne4JT7fZCe1XHtUxwkaMFEz+nMk5O+vYIzzxsCj
         aN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792405514; x=1793010314;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HSOlnhRR739tGHruQiSq9vDXhN1boQ6Ah7q2ae209V8=;
        b=wXboCt9/B3N6gVNU/BlzIeY5rbrxWs2mLtXtD7/nPk5Pu6g0GWfV0oQL+pRmrPqt3q
         ncmdXDlDvvh8ANAXaufiiqkwCW0VpWDvsWuWrFqryDBmhALvlleFSrYwZ4BmKyaDDh39
         ojr6Ue4tJf5cRC+xiwhAZCoaej/qpb6vZyALTo+LN7f2pMrBJ2LJh5P/XVMf3P+sE6Za
         IQNHozq/8hQ7swDG+CetDL36pnl0AFPp6BdmC0MVftpQ8JtTqcKGQSUEoujzVPwhKA7M
         VHHIsjE8GBmFUq2eG8AG8JFxNhqAeNeoU2drn5UFfaVg6dynZHsyYwFrpo/66GySf/7v
         WB5A==
X-Forwarded-Encrypted: i=1; AKwUvBwPFzVPk4UCISzY5F56qXwdlBAC07cvxe0XJyq+syExV4OGvZVPTvLQklF23hEYtTXbK/s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYYbo/WEYUltLnBXei+p3TYu3j4XB6IfI4DJWqfrorJKlbORdG
	yxP3cGZT18FQ51dLU1QFKJmcCNKjNOImafy8gp6lpOd0rDTrECCI4EKN
X-Gm-Gg: AYBFou3xKbaArrAj4mB3aHM72lif8hClLK2hxVRkdu/8Kn5y8kmfJMLJMej9jyhN6Cw
	NNYJCgyg4k5lp87YdHtobmCKBHL84+9WmoRyiIUgEMRi8Sb8y8ir3pzFG6rpGtUBC7ofOJMQhRF
	fgE7QRSIkf9be7A1CeGl5ISSiSbfwgPdoTtqgqLwfl2QdtYQHBqsZMQXnxJ/M369rkeAZscpBOV
	sgK6WCbuoRORrb6LUgQu3qMCRBWyq/a8nI2y++9GZqrY1YLdPvWp6mS53sUWEFGDlb5HZHa5RIc
	gGdiLeAevVNzLHxyUmhOB3rxAUY/5KtRO1tbSMoL5fjq/AI43LNCQkRVGWacZGGJc+2f/s7F9jV
	4s92L5VHpq95Z1e/KDW3vJJNfHanXi3D9xsqXsGCXuoT0zAd/LtKQ/PsVoUFySF+2sdc1+SB9vg
	0aDtu2mieIf6yXjq1V3aKzo/4HeL2vLa00HYWCE9Md6GuA/0jBIs/M7pVs7+EN0/5Hw5ARyuwle
	k71l88hu8nWabE9THNesZlVUSixlQC/IES/oNm6/lw=
X-Received: by 2002:a05:6512:b8a:b0:5b8:ec96:3bdb with SMTP id 2adb3069b0e04-5be50a75265mr2292030e87.3.1792405514055;
        Mon, 19 Oct 2026 03:25:14 -0700 (PDT)
Received: from Iris-HRQ6HW3 (78-71-217-218-no600.tbcn.telia.com. [78.71.217.218])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ab31aef84csm16502611fa.33.2026.10.19.03.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:25:13 -0700 (PDT)
Date: Mon, 19 Oct 2026 12:25:12 +0200 (CEST)
From: Olof Fairbrook <olof.fairbrook@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
cc: Olof Fairbrook <olof.fairbrook@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] bundle: do not free uninitialized memory on bad
 arguments
In-Reply-To: <atW95CyeiQCGtIMX@pks.im>
Message-ID: <c9d2099e-4eab-6be2-10a3-c30f33c88b8b@gmail.com>
References: <20261018142130.2701449-1-olof.fairbrook@gmail.com> <atW95CyeiQCGtIMX@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Mon, 19 Oct 2026, Patrick Steinhardt wrote:

>> in object_array_clear() and in free(); whether the command crashes
>> depends on what happens to be on the stack.
>
> Nit: that last sentence is a bit on the verbose side, as it doesn't
> really give any more useful information. I'd just drop it.

Yes, agreed. Just me over explaining. Will keep that in mind for future
messages on the list.


>>  	test_commit -C foo x &&
>
> I think overall this looks good enough already, and the nits I have
> raised do not really need to be addressed.
>
> Thanks!
>
> Patrick
>
Thank you!
Olof
