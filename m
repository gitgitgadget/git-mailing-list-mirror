Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793046896;
	b=r35fxisW/vq7VtMiUmNiY/Q2SYlD+C8GLNVhfQ/H5bo59WwFjTRzfw9PmafWIaS03blU
	 +0mW2AemkhP9Rz1pxNc89ozI/a3wo2of0AqhZZGz/4ktLnVsMt66PrvOOMpGebfVoj4x+
	 1iyL47J5cZikOS0YKXWdYv1wkdJ5TtCKmk9DLVBSg9Wt3/ZdvYzRT/mpsZpMdXk1NJN0I
	 MPt5+S5UdXJGVdTFLRaIZ4siYTTH7hkpfNYJ41zcuSNLAQBvpaNwWuYwMoETW7jU1digZ
	 MzMhW+oGQbq3oNJwZtWtkPaSSJXJgY3g8N1b8yilYSkJDVviCuuVwQSmISVdWGANTqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=bWDKPNE4BWktrbUb0j6mMIpXlnjVNASB8fCietwc/AA=;
	b=m+0qaGiz1XfnekePNP+H/499/gBBLRjDxc8Cr0meRcBC2UTlQFTXCqrpXOncwu5Qvygl
	 hpt0gKZDl8o8TJ5rWvXVEoZO+xLUnu/yDAlUnR7v/USLQvQzLKrSWh7MBLEnxLYhQ0Ihw
	 xMM+/eLDo8HjgNYcS6ludf+kKavsUXRk6EIIKRU27UulPK13sHuq9B8c5AX9W6EXkfBeD
	 7qPaP4P8xnHwunGN7g9+QFh3g+NCPz86cAfKWbNSbaFAlEMrSX0cdKVub2YaCHggZy+HF
	 BkIjw1+uMCV4bgDZYrIW4FUbYeGPd29FFK9ltHFpoqC6F4msnCgsimPeZVacOOCChuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YLkd9xcG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA54C606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 20:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA54C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YLkd9xcG
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c445c95d553so451213466b.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:34:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793046894; cv=none;
        d=google.com; s=arc-20260327;
        b=MMbbRUZztZKrCckkH/Mc3O1389liWwxPFFImQChbfZaOtCSEW5V/YC43dKOnuh5Fys
         LA9ixAhvxP5IE/sKvTfrOaUCF1vFmdOJaLoKg3f47udmo/k39WnS1m3dmMGFUt9LBJur
         XkEkXaiUjpVLtW2l0ChhSQQlu3IUQdSY7pSMf80+ITRgfSwuOog50VF+JHOEGqp+YLeG
         7IquxPt537kuUrs9x3BamoIUecLMtvpscHSV634n1lLyRTAYs7O5PlQoq5RGoTgmrfQY
         N+anbyPGwZRphZ+3FC0Nt5wii4QTvXLJv8Zb8DNZVNOCrSdNKhHG9BHG3BmDbcdDK29V
         uZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bWDKPNE4BWktrbUb0j6mMIpXlnjVNASB8fCietwc/AA=;
        fh=hv86tS9KzE8Kz4f8u4dZlokELkq6PSd3zKnHihZN1As=;
        b=DVg89VhdxpYx+aLj89Lagz8ezv3LA6xjWD6ow5XUVxhyuMFclMHwPAdtcL/MRglfUb
         kmvczyyIE+5lygN/U5YgPcfb5jKqfRDyGlP7WQOj4uxVERrGj99BXglt5HG6QuKkaBAn
         QkvQ2n296ci+Hk8g3O7ZxsEv5a8xvwkGK1/NYJIlk6Q8tKMi5nHV0hsgeoEtOhEaJo8Q
         adGJ90v9BBRUKXpkWpkSHlzRGPmszV5lk4GynzDn4MvfEM6+jA3QecZnWAjA98KElnjm
         aPbZtJGD7VzLT/qQBgDX1RfAISbO3G4D4GOuVthUlV4Uaw/1wi2vln5XIcsdUbFMAr2s
         Cqng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793046894; x=1793651694; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bWDKPNE4BWktrbUb0j6mMIpXlnjVNASB8fCietwc/AA=;
        b=YLkd9xcGIvmdBVwVVOp3fhmin2n1A8u/xDKPcL2GZkIIgYcisZ5dN8VGPOmq/nOgrx
         H47dTt5qbAg0wcpFh+wzIAdWNZQ35Lp2+aJOZDHyi9RjVs+Xsjqa2Ydt05Q9dZ7CE/jn
         lWkgQxwRId6Y1KF0GiQmpI5x8/d8TBFbUDJ1TQPX81hW6WMS4bYIdMf+Lme1zDz9pUsg
         nu0VmP+Q4iztK1QqjL+qgSW1ps+KXfYG8fRsv8NjDZXSojA29uM9Mtr1qiwgIOcefsnK
         /VuOhrj3zeR57Jos7CVYOiDvoEJUsZ2gbiBkRdbblB/dO3OeW6Ycxp4b6B3ThQuFgeqx
         MiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793046894; x=1793651694;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bWDKPNE4BWktrbUb0j6mMIpXlnjVNASB8fCietwc/AA=;
        b=iR1pn+SCLopwNw0Qm7XDqz3K379tLXnOSCpviyJZMUVF46MKIWTWS2sQz5Um/9MHwf
         tnkJe3VCk/l86hbO90AImffATFCEwHOktUMYz0nStHHd3YqtmdmXui2R9AhQiQZQWFNk
         aDP9eQ2q4SD6gyqXDlvSV+aq7Oo21F7DODmdC5VUAx3zENN1OHDbHwzZZQnChgP7+6tl
         8bVsrON/u0+HgJMddv2JoYS03wc1XGiGUrTVSr1mD6SgKR1t8/CaesY3iVFXWYGeqY5f
         9TuLj69s57VzOBRnhQXrqSaLMwMHwisPPeDKVFyJ2O5fcQ8YsbG8LUiOcopjKoPPxj73
         HPVw==
X-Gm-Message-State: AFq9FYLDPdeS1oig3VvFcz5KMo0K3MpxIt/1v1Rh6TDckasPO+1RDirU
	zD2wvvLNfWLEK3FAITNnp3M39MGb7FrAQTxgIQjrVVfyYboGfAnUNYVAD7aaNDsU/zyuAOzRZIa
	rkT4eUAHh7CzC1X3PaXQheo+GGMh9NpxBeX0E7o0=
X-Gm-Gg: AYBFou1itOK0A/+9j132Wa4/XOBcUg258ciyJ6waaKbYHJGKbHMkpfQyphze2lhnAmW
	wmzy/ICEiVCAyWnhLYo9yZAunSwvp+YJFCurw8029OH2eixb6LWWH4lf9eQGmFbPdJzP2YeA3Ao
	0gXIxL75Gh/QJTr+0kZS66S8Xp54H807vM8OrnjHzDvJlBu/9J8TAwNX1TnP9jwdrbYmLaUKeM8
	C+Qx8sv09yS2zzxYStQktH2ZXNIHhj10NWfSjPr3G/TS9Dxt+TQIjeXD3U/PU51aHO/JPL6SaDG
	Iglnnz8lPl78SDZMjaq8n8wBUBPAdU7MIolFPFlgwHgKAikBk85cVV5mY/BkcvdOVOWHJ5QcszP
	sHRpVt2iKihT0ah/bAhAyPZtbO7RQoJDhy1Mu3UZyUgy4evT1WtYa9nq/tUId3YPAc625MjY=
X-Received: by 2002:a17:907:3e86:b0:c29:7953:6c06 with SMTP id
 a640c23a62f3a-c46bdeceea6mr933245366b.49.1793046894016; Mon, 26 Oct 2026
 13:34:54 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAOcE0wJ88hbd9n-A2C0RxksKVtnt76u4vGxvhQ4rdNDEdGTmOw@mail.gmail.com>
 <CAPSxiM-dxHUE5tHf830=zHnLfg1U5jyb211-ZODS7bu8OjqEnw@mail.gmail.com>
 <CAOcE0w+EciSBZDTTNzbi8hEzZAZjB6gut=Pc9qB5yEgs-w1f2g@mail.gmail.com>
 <CAPSxiM8Nv5mnWoFVjWE284yhYG0rdLmfXN2xbZpm4H-wO7oAng@mail.gmail.com> <CAOcE0wL5_+m-=qSrGV8JcunTgpBKGaustYc6xgKhKuCrSzP8kg@mail.gmail.com>
In-Reply-To: <CAOcE0wL5_+m-=qSrGV8JcunTgpBKGaustYc6xgKhKuCrSzP8kg@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 26 Oct 2026 21:34:42 +0100
X-Gm-Features: AclHuK-RLjNejyHsAvoVq1ohjMZVDQcuMq8KusWoX0RbcknemFZ9g_U8mfZ4IwE
Message-ID: <CAPSxiM9Wuikgx7VHVhAycYNAxgztyGH-urCY-oe+hRNBmFkmBQ@mail.gmail.com>
Subject: Re: [Outreachy] Applicant Introduction
To: Priestess <herroyalpriestess@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"

> https://lore.kernel.org/git/20261021033723.5265-1-herroyalpriestess@gmail.com/
>
> If you have time, I would appreciate it if you could take a look
> at it as well.
Since Patrick already took a look at it already, it is more than ok.

And there is not need for me to take a look at it again.
>
> Thanks,
> Cynthia
