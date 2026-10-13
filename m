Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D600553F6A9
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922428; cv=pass; b=W9Ql4MDFaVqn0b7svpUTY5vPeWJ+iLoWy+G3CpZChbSLDo1a/PPNZBIagXMyG0xlcvJnY+wSCHlYEN4Y7mOZuW54KmSMtfgGtsxXBRtfL3GMPzy3OBN/Xmnb8NJjRQtmkPIB+YzU8GxnErsbWGMPL7Q+4Xa0TjV+qHmxmVWvYzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922428; c=relaxed/simple;
	bh=IEPCFueGcHzZQdl3B7wmBO/Q2KTGVKUD7TI3vzByXIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxGNGh5td2as4nF6pdnf+A4pK3qgP81htDRxTGbXBfgaqG3ihoKINgYKxXZVfja+fYcJN8p5ypVqW91xz08VB8fXuIBkkeygXpMV8UjCYUjele93D/sjbcTxQeN5aDu2SlPE+sRlSrXI1JV4VoR/Ts5v2Jw41EUrUIcx5KX6bTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnurtjEz; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnurtjEz"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2e4df2e26fso454809766b.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:13:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791922425; cv=none;
        d=google.com; s=arc-20260327;
        b=ECf+G7TUoBkaV0aqApkr4ZNmnxLHuD0i/HyPfdWjOucBuE8QwEdzRYnCM+XFlodCFA
         MSChUzC5BDwGv7KGvjnfbol/6ScOt/XH8yS8lImC3ElKGFa+yI2935uBJ40eAPPe9Rpd
         KmCD8vcnX3NrcxnmcCpCDZptKfDFiVX1c7dL5RfAcW4q+0afyIV/f7Ah92xAj1XFW/Y0
         MvM9nDqF3COtkwyAMYy4EzzYXtpX0wj9IIRpKmGOAT/yLUAvanvxdcvUjQ/HIHNkN2Yq
         aP5G6mFSFfRMmmcSGUhGL5zSu5g3ybdwZ9FXAUkQXk4sm5KhyQLfuCQfVfoTN4ZOvRP5
         k1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IEPCFueGcHzZQdl3B7wmBO/Q2KTGVKUD7TI3vzByXIk=;
        fh=cFmPBCRkUlbdViCibjE6uk5A9Ac092edx/tETJJ9PM4=;
        b=H1a4SMxGFe04dcwq5dtlcMlLOmKRXrJ++YWSehZPEgVCmdx3ArZXKuMKi3VB3O3AtR
         HUJAn2oazPeKIKvP9d8o2rM41R7d5ji6QEm1Ieq/KRl01svS/Tons/xa0JBAiwU5IJpH
         VU8lHzss7EAfIdpeHAImOuIJllywlfyJ+8DjXXNrlnyGcHDPOl67d44Lcgls/PIGAgIm
         C0OPVsv4gFAzEAr9L8Hwrxx9Ho0bXw0zHr/augwmbX18A7kuOi5KPePrNQUMX0gTGo2e
         qO1LCvF+BEs+tFrigq6cYilzJVUQXzQwRRzYgRrAEGMvi7H98QL6XFf42CtJuJ2y7Pbr
         5VCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791922425; x=1792527225; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IEPCFueGcHzZQdl3B7wmBO/Q2KTGVKUD7TI3vzByXIk=;
        b=NnurtjEz5tRllfY2rd/xbNRFVPtmhATLzCTc++z3hK/jSWTsNy58CxX61yiT0mfKWB
         HzIDbKLsW4qi8jOXDyXSrtMIvf+XbitKjDghvYg3RECbzn7LTEf2gpgCI7uvx5WjkJ/M
         vJynmGYGj1U8LTy3HTfVkDiighNVnrPtoS6N/0LzAqJmT0k20z+UeqKEwdDp7WDrRTOa
         uyrHg3ZyrByPlcKCjxiJBqykab0KGUX1/1a/8+PhEZdYekN+eRukI0DoAiEDKYNlkN5l
         M9KaJXJpUThj+qKP2O1Y9TBZ1blZvIQxW9TdjrwFp7G0mKlh7gmuzOP2OTFXYVkpNSpH
         A4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922425; x=1792527225;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IEPCFueGcHzZQdl3B7wmBO/Q2KTGVKUD7TI3vzByXIk=;
        b=ojePxGb4L9lxzKBB09kKqAEXlxH7QuU2AraqTy8xFCDZNJiTaRUWo5UGJorHd2a+vm
         VTp1rhf5vqaecMfT20A8pIatqQB/2NJxaX1HEJdFzas7cZjNc6lFJUP0eDb+p052KCc+
         S7g5ytDvghk8C9eHCmaOugnLSMAaxhTKWSABApkK5m9YPmL7a8NB4kW4EE7SjIs8ELq8
         88I6s54J8J+Kg4MQuLLZvF5BI2ukqRkfIL0lcZ5FbsJhrpX3rHcUsc+f7Ay81aXiwFJU
         gsKZHfV6erexuFQm92sPnnk0B8uf97a6SBwdtoAV7fX/E2gnyS14khew6g3r1z9NZAFk
         iVcw==
X-Gm-Message-State: AFq9FYIeMEPCG8Zr1m7e05ODyFMO+EdguRu3uilEdNE+iUDJHOBgTeeW
	36KxILoHneMlZ8ooEZ4dg9HlE6aLBvnvTIXctGn1nLTma+5UUjkiSUeJ1wFtjR71iesUGwuyWCr
	cWrnozIGCA90UiPTpJy8DVTuVZFWp4i8=
X-Gm-Gg: AYBFou1WY/uvXx/LzhrnjYsv4zhxw3z7V3hoY7J8CqNPtd8BKmPJ6aPBi2zBVTa7GGh
	kGdsfJxrbv8Fm0G7U0RGvnO014G77aOLM2egsfV48yQNIUXGfLbUF8p9BiSF1s4CpchEUCelO3h
	/XchcXjQFZ9UZHxKAELSVAYqhkwLnwbOqm7YL8s+iP+rA2G4dkyh0XYwQTOqTl8ZjBuFdy0Zurp
	nJKHC+XW8K5ELcXjCKQYnO9o+vHtIb/rpwGsKpWMqv6BpQOnb93X8teQpxRHbWOZK3CGNsx2WTo
	YC8/GvrPiXkv8/wznqi1ujXQR2MsFADHIH7QPmX5AIr8JkKgyRAeFE1kNwKW1sD4AZKEMM+ircG
	8niHwg9DscQ==
X-Received: by 2002:a17:906:208f:b0:c29:4b08:79d with SMTP id
 a640c23a62f3a-c31a9d501admr838675266b.26.1791922424857; Tue, 13 Oct 2026
 13:13:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFpMFfAFsRvQ1mkmGVkRnLWf_OHN9h3PAThnVZmrbecV_ihRjA@mail.gmail.com>
In-Reply-To: <CAFpMFfAFsRvQ1mkmGVkRnLWf_OHN9h3PAThnVZmrbecV_ihRjA@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 13 Oct 2026 21:13:32 +0100
X-Gm-Features: AclHuK_E84sG59jeHP0YV2m2CRcw1l9--ZzZeo0kDj1lZwh3s8fhC6IzTZ_XCMg
Message-ID: <CAPSxiM-d7FHQVjKnyRu4GJF3hkauyr6Jw67B7W0hLSEyamBFwQ@mail.gmail.com>
Subject: Re: [Outreachy] Introduction: Okhuomon Ajayi, microproject in delta-islands.c
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> I searched the list archive for delta-islands and for ngettext/Q_
> patches and did not find anyone working on this message. Please let me
> know if I missed something.
>
> Thanks,
> Okhuomon
Hello Okhuomon,

Thanks for your interest in the Git project, I saw that you already
sent the patch.
>
Usman.
