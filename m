Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3917B368294
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881581; cv=pass; b=vFdv/MX3jN73ZCWG+a50bEOAhlz79BcUrM47C+hmzrIvP1MyxDvPSjmtibqS7NGJnsX+ajd/Md8EEoXnazI24xEt+HUrU8Vni1P/C/SpIBX+xDBKzXsglR6Vpx/83v8Xvgavo1gyucvD1ajorRYAbSgQ/6ReOq8SHk6UsZuloDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881581; c=relaxed/simple;
	bh=hSapytmVbzdzDsMcO1My2mdn4kSi+Shfl0JPq6LU7bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bU/LzzlQCKWo+AUfhIogaknnpt0S/RwvSo9UbuGklPZmjJv+vYRzjlXCnTxG1UsdrF9YdGLIPXeJADUSrdD28VZ5hyOw3pbzp/Xcce7gQJICdQfPRWhoYdhS01I6xFtUOInudqCfMESJLBlJcmZoqPznkdz3oY7fl8Y1oa6y16k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYrE2SoD; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYrE2SoD"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7e86d46b02dso26940457b3.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 08:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781881579; cv=none;
        d=google.com; s=arc-20240605;
        b=ikgeotCD2DtAVMSg6QiqdRin88ylr5GWptPeccLVetMSbtU7VKp4e3bt0YOF6JNcmF
         vFaFduO04iLRD1K5VRZeZB0NLMjIpohDZ+4NeZ2PFo+mkkFf7ulkFcmX/wJxzXM7inNa
         mbw5Ok4SUKgT0nCuOquoEEseF+6Tv5hVr3+hHY+o6VelDw2s4LxsjLHtOnbbJECm9y21
         ihWOu2XtDGfVWMOBxQw/KRrWsZdSUOMuWmYzTz6f4HaDwgyB3OEtqqq4TPzQtQMGy8g2
         RtkPADAqWvqCICoprP6C37nefY8bDkWB40Q+a+JWZjGvj99vcLAKZty2jiBAw4EM8T+r
         qf0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hSapytmVbzdzDsMcO1My2mdn4kSi+Shfl0JPq6LU7bo=;
        fh=mBHmkCGVfx5nQk4gXJhIT8t9aZ6h8QovoqCNbv5NNrk=;
        b=ehrZ6w+PyFbAORu3IzpAnbxApdl3mZxln2nhbzKMXUetITyrPAkK2c/gjCyBKwhl+j
         thsWiW91Y9PsyiALfuJuBZOq1n24IHsTKGqIqMfiv95/NhQdGMks2ItFfxTmS5hnwR4j
         ox61/pNhvkc8OG8ZqHvS4hWR7TnEqjbAqr4wLJmuyyaC5+4nlwwkEGcCrcJ0aripGgs9
         feCbei5U22+KVvI1GbpsPkPf5uN2SJoanfeLqzPqYGIdOUIdKKU2mvl7Kla4iZ6Hf5Xb
         wk4z+SNyjX9aO04JO17xOIXEOVnQZ2N0jauiDB0Y6RE3iy2QyNCtvkhv0ybqAJ/0sqzf
         oEwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881579; x=1782486379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSapytmVbzdzDsMcO1My2mdn4kSi+Shfl0JPq6LU7bo=;
        b=aYrE2SoD/HVqAGfLiRLPLh4cDyiFBvpz2q5Djqcn8agDBl/wdWPsQ0tmXsajKX/l4P
         wbjMCM1lFHQuL5U8P9rUQyg4SRZuhqX14r8HSgBuW5SVDU7SdFw1wyXUocMBdaHarb35
         0MUo2lmWgVP/DQgBtsCD6DFm6vbj7mEPbl3vJW1rM8WVJmLa8xcBs6JHGmhDqSDXrfAn
         Ail8bNWFFYqfqt8fQqezpvolhuyICcTinV+VLao1V4WUczyuwGO/QbUHqPTyDiW/9Ec2
         9qQCRIZ9Q3s23goG7TJ+YuwPGcMqJrewwh+0xOOKGHtak7WSCFfE4AiIdcwi6R3py8e4
         cH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881579; x=1782486379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hSapytmVbzdzDsMcO1My2mdn4kSi+Shfl0JPq6LU7bo=;
        b=EUzbSVWqnDyaPccDBo0ljOYLDcwYLZAtO8fHvgUy2N79hjB6/Ky11hIwC+g+R19bJU
         ohS7c4NCiV8V7I5g20HzW/LtBAiQh2ymO7cTIfHb0K9573UalYkXqovxFf612I6pLBzq
         NkzkZO2x7OdEEgRMvGdvFZ44mgBU71DI/MOAz3RXFqNx36jpd7G68rBd+54KTdC0P984
         uSgiEzQvFtwjilR5GlIfcSxKKoOYU+KcHgfGLL7DHWHFw5Y4O2PWEq+ayzfi869+b7Mb
         mzpPG0evVY6mmrzJFxcz7O6Os3ewLrDWyMuMjzCLsqUElG6b/zVzOyEY+mdDAf3c4lG9
         rLtA==
X-Forwarded-Encrypted: i=1; AFNElJ8znxu87thHzw1v8m4LnfvRFKoOjWC1/dL008m7MlCY4aGx61f0vMPODhJoWIQqY6Tllbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaegZYnM7z7Y0LTy1RA15mfajlBpEswMsGtX7LFlFuos66uxiY
	0bbOddpsTCeAaQIgtU7k0XPhFDf/KvAUcPeGZLtCuQ1PbFzzp9CsyfjwAYfWYaPJm0r9K5unLaf
	sRLKDZg/qxZ+vgOdIfMAaGhTIjM3HQN4=
X-Gm-Gg: AfdE7cmUMKydc+h4sY17pkYlb2cqEzOBda0pQlYpDHAO4gMyRvt7IKH4D8q1a57szkE
	e9sgBs1B3qmBL/WeDLpmCdHntoQsTmJV/SnsS/dSGIDCPsBlhkbNR6IL4tu3eKvePjwxY9c37FP
	MXJFCt5w0HuK6UKBk1chhO78nI3IpX07nYcrarRpL+Xj0rZkHBM1dSUXQwix0NRUOUUIti4G/iL
	nSl0G4UyFQM0QbY0uM8O6mkT/uatqegJ10EEW5KhP8PJhktBVhSMg8e/15cgnwyPUBUEd4042mt
	WTAR9iZu50It704ZT3VW/ywX5TkKlxPvjSLKoBlBxnJSUXREvwtYZLvHNb8tC5gybyEBoFnRgR6
	XWSXd+ocu8k+RLo4sgoC8wEoCnxpYlmZ9SDOofYf6J6jpwsfUwfzAil0G6KmYnzel8YLYYKyapW
	ZHn0s=
X-Received: by 2002:a05:690c:3603:b0:7dd:73e7:84d7 with SMTP id
 00721157ae682-8013573b779mr39034057b3.41.1781881579007; Fri, 19 Jun 2026
 08:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com> <20260619-ps-eric-work-rebase-v13-2-3d4c7315d2f8@gmail.com>
In-Reply-To: <20260619-ps-eric-work-rebase-v13-2-3d4c7315d2f8@gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Fri, 19 Jun 2026 17:06:07 +0200
X-Gm-Features: AVVi8CddMO79qFAxto9JMjL8iAcNe9rlb1TuHufjYjeB-wFBOMWhbV-E6H9HvJ8
Message-ID: <CAN5EUNQy_sZx5-iVjr7YB_4kBPnEcDyVr_o_OhVD1Kff_Gjurw@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v13 02/12] git-compat-util: add strtoul_ul() with
 error handling
To: gitster@pobox.com
Cc: peff@peff.net, eric.peijian@gmail.com, chriscool@tuxfamily.org, 
	git@vger.kernel.org, jltobler@gmail.com, karthik.188@gmail.com, 
	toon@iotcl.com, chandrapratap3519@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 19 jun 2026 a las 16:56, Pablo Sabater
(<pabloosabaterr@gmail.com>) escribi=C3=B3:
>
> From: Eric Ju <eric.peijian@gmail.com>
>
> We already have strtoul_ui() and similar functions that provide proper
> error handling using strtoul from the standard library. However,
> there isn't currently a variant that returns an unsigned long.
>
> This variant is needed in a subsequent commit.
>
> This variant is needed in a subsequent commit to enable returning an
> unsigned long with proper error handling.
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>

I should have removed the second paragraph which is duplicated, I
quickly fixed the last paragraph but didn't realize it contained the
same as above, sorry.
