Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB3D45D915
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038051; cv=pass; b=MAa6+WgGw39iWcSwpKBdIa91LV02GqC1iFoqaKplaiCUxm5SvIkPcuRYkep2Xv3zHWJRgdoC8Rtfm/qL1ESYZSNHGTmkhRrMMHIZA36PJPF66gdWvRhnxuzNLYdNszFXFAH/ynkFNdZlmU2Rwi5v/xcItvqORE2BdJDGatUW3Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038051; c=relaxed/simple;
	bh=kt5xUjjMUaG0OOxa894dUTokmFlHQvMJOTGxRgGiH8o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERonsSDjdyyWMSepyhFsaF2uhRwZ4DhRrUw8k9fkSqwC0Ny8aZIJTml+ybHLP8pGdQsHw3MoGUNHt6Iy8vY3vnb/ZHz5BnBo63OsQAuIF0Efd0RS0bHGo5wWgT317FLKyA9CrAAKnSFtaxJvOcFg0f0KpoGROakHXHeNrMh/UB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+O658wY; arc=pass smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+O658wY"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e80579b7dso566276241.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 04:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789038049; cv=none;
        d=google.com; s=arc-20260327;
        b=MZXTTvmoTB+dZGNfnhgUJQABl2rbd8ciRRMc+kiqUM7BOKIrEPFP+OPwrbgbdT2Qlm
         AlNZBWrLYs0A3z0kJj9q+Ause2KxavqoNvDAOZ8X2ylQrr6HIuVxFxUI48Ps8AW5fOkX
         9V0CfMCoVz3u5BgJ6UiTvAykHrQlqQ2RQGneOuQAp7ljc0ksOX7xR7+dLvin2FxiBccM
         UUIPnlvFVCihPw1GW2nbGx8KFg5cHMKfSCLae8XgWV0PM0+3mQlfZtsMSxJGBt6wYUUW
         gCDnHW34ECy0RJ0ddBqc78+U0dGGM91tnHpURSQg5wmCpgFzDV8kVLHE5DenrGNzNmeB
         v1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=9ZOfQs2Xgx5cY6CXMv0yC7AQlKRNZoaVncLT2X5RFQg=;
        fh=cvNq4y25/IdSSGjzFvhhEEDLvTO5bWPKELLJElpGZ/Y=;
        b=IbG1EtcmE1845srd3frB1gYpHvwxOnj6AyONq1JhHdhz416sOa/SDFFvktVOEwGWeV
         yekaC5X3b799Jq8DbIyksdY5RCiASdEMHoha7SJswBOHCNWF2BxG2BfjEuAYJFR5rtaj
         P43w7qGDjR0PmIl3agxSOIdnwU7lrg6Tp+eKxaPmPWXsFFyxhszzj1kmFrw+fwOrCFdd
         9Y/j9Ri5YuMAJAto5dNwu+XZNJ+zCRS3yMZC/e0ScE9p4hj+GPcR7L3FgglguhVGD3Bx
         Cxe+Qi98OYdwW7xb5KeZIJgWwll7b78qyfOy3ROTfgujDw67a4QnJ90w7jl1WyK2c0Mg
         Fx5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789038049; x=1789642849; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ZOfQs2Xgx5cY6CXMv0yC7AQlKRNZoaVncLT2X5RFQg=;
        b=B+O658wYHKqg+m58yLjOnS9ozZplyllxucQ970Y60M09YtMHwFfCUpqGIscTgtim4P
         6N+dhF2yfef+zBgQOIbXsDmSeR3hGfDvYM39dOneSpmfWEM66MJSgaDdu/tZ45XCb0gP
         HtrfXoASRKXoaDoNz7r8oqEqzaEEP5Bgl/hMNlOFPnF3Oy7tlvrdBWvABGQ5UbLWLrJS
         oYqL8LgR8AVnn6dwYcTcN4Eg4C7hN6jQHvx0yrCUdreupM4Feujjrqn4wlbWht97QWu1
         Wn1ap+/ISyI+3oUhA9lMH36jSNLdh1ZMbheurBZaceSgl9pmTr6z+enrxCTtSGN5SelO
         femg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789038049; x=1789642849;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ZOfQs2Xgx5cY6CXMv0yC7AQlKRNZoaVncLT2X5RFQg=;
        b=jHYY7r33vxfiF8gt0k7jlsm5CVwz1tBkEcMyi+TTS/zz6rGiGDievDveBTPTDbrVKC
         DgKaA1QAoD0cBCUBEL12lFeFwIqAdrd45JOMzgoIb/Et2e7C4aicKna+GVDGoVBPALJd
         alVd8tKZ5GbENeYtQG8iINzARLeO975L4HJmzvaQsSz/nTeuw4JrCOvB9EXnP+p0jn+n
         otCa5YPgWwgo5LI2j6RvLH8UMiC8BL7BR6LEws5aLi7EQI9X622LPtVUUte+ot85VjiG
         SA9nsXU7YzrYJ3GF3wK6xg6OHNI93VQTKNEcqP4MLmt8E7tYpM4xE2ieQG265CJIeSbp
         R43g==
X-Forwarded-Encrypted: i=1; AKwUvBxro4P6pv+GKYcOGR3A3e0/3yIVHL49UqlooUbQ21EHt3JdJUxAvJdknXZfZ/0ab3c6hDU=@vger.kernel.org
X-Gm-Message-State: AFuF++ndyeR+eERRaL5UFEUQLGF5BbrDVGkH28RLYLg7MzbvhwVFSYhq
	JfjLoJ7/GpOGzYz8rPsquPzauFESn50yy31zhjksFRxHoiST8omOIcNC2tcswclmbdfjQeEc1zM
	oVDV6qIAKzsW+FSWk8yNffCMjJt35dN+YJQ==
X-Gm-Gg: AYBFou0Ym3RFWn2rkXs3PoxsjY69l1TDLuOEWkq1TgHL9iwrs/oimw96t2JNDWL9cUy
	FBrTO/AFHXHZlE6CjrK7Gm2fkHG4QXZoAMdUHpJIDZHTfxPFskJPUMRjJQdWgulhzp3ipVBOokB
	YvJPE6eiTat/K1zEFBsK7f6bGo1D0gdT+5DzoEjMu7X9Hly305uS9v/ii//hgGHAO4K/KQYnmUH
	k72mXXnUH3APGDgVcRoPArDySAqEhSGbSLZUeFDj9Qo4pt+KH9h0zL/bn+TLDQ1hOHslZD3lUue
	HB2b5UJG0lWmOUvvSxM0NgsRKoZCg8AQLB/Z+97J8g8t22aWVWfKz1cb/aM+LraaCo9NaLZqY3D
	jQDLK3v2DH4zPNou/ExrmwbwNyxFt66ozZ7ZFCafdcf2u2WzJGMIR8G8=
X-Received: by 2002:a05:6102:8095:b0:783:f3bf:f9aa with SMTP id
 ada2fe7eead31-78f757d562emr4208635137.8.1789038048542; Thu, 10 Sep 2026
 04:00:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 04:00:46 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 04:00:46 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260909-pks-odb-write-alternates-at-creation-time-v4-6-d8a78ffc32e4@pks.im>
References: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
 <20260909-pks-odb-write-alternates-at-creation-time-v4-6-d8a78ffc32e4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 04:00:46 -0700
X-Gm-Features: AcwNN1ViGfI9C_leVA_k3GGNo9mgh1UpZpQ-eEAfsRyutGvBuCdE3AKf7BiGEwk
Message-ID: <CAOLa=ZSNC-w3aC_SjhhbemWryvSr7ySZGKTXs8BkYr7AmdKXOA@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] builtin/clone: move setup of alternates for
 non-shared local clones
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000005fa450065b1ee184"

--0000000000005fa450065b1ee184
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Similar as in the preceding commit, move the setup of alternates for
> local clones with "--no-shared" into `collect_alternates()`. With this
> step, the complete setup of alternates is now handled by that function.
>
> Note that besides moving stuff around, it also fixes a bug: previously,
> we did not know to resolve the referenced repository's common directory.
> Consequently, when referencing a worktree we failed to resolve
> alternates. But as `collect_alternates()` already knows to resolve the
> commondir for "--local" we can simply reuse this resolved path for our
> purpose.
>
> Add two tests, the first one of which exercises this bug to avoid future
> regressions. The second test ensures that we properly handle relative
> alternates for a referenced worktree.

[snip]

>  static void collect_alternates(struct strvec *alternates,
> @@ -242,6 +254,8 @@ static void collect_alternates(struct strvec *alternates,
>  		get_common_dir(&commondir, src_repo);
>  		if (option_shared)
>  			strvec_pushf(alternates, "%s/objects", commondir.buf);
> +		else
> +			read_alternates(alternates, commondir.buf);
>

Okay so this is why we did what we did in the prev patch. Makes sense.

>  		strbuf_release(&commondir);
>  	}
[snip]

--0000000000005fa450065b1ee184
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c22107a79ffbfdaa_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xaWpkMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOTBtQy80dkViZ1E4SUh2d0g1QkNUa1BOdGlkcjY3eQpOVUo4Wmdremc2
RVdLd1ZVY09HMkdYOWp3RjRKdW43czFmZThNMFBaMCs3OEZqbHoxdDNYU0kzdzZXZm13c1hxCk55
d0dvN2NibDFFYW5yWld2ZzRBakpieHdhUmxHMGJRTmVSbGIvdkVKcTFIUkp5WXVjeXJzYTRWcWcx
eVMwN24KOVJaS2VLYVowNkV2TnJIM25SYUVIa3JnNUR0QTl3OG9wK2VEOTQzQm5zQ2tZMk1nSVMy
b05UL1REUDZnUFFLaAppOUNjRzdaSm0zeUZKMk95MWdndkRHaU11cTV3cFhSbUhleG5NengzaDZw
ZUpiNjZ5c3NuVE90NzlkNzBjcUVzCm1KUUs3WTViZEdNeThtWVJUckZLYzNreUdYR0puYVBTSE5S
SFVFV3BJRnEyMEpwek5HbGFpblB2aDJYeWh0Wi8KUW45ZTgvY280N2JVaXF5UXBvd3ZDdTI0Znoy
N2JJSE1CQXB6V3MxWTVnVWN0SnNFbHhzRS9sd2ZqZjlrSFhzYwovL3lLeG05ek9tSmpEWC9FMm1r
ZENSTElLUjB4cUZ5blNTVjVZWjdsVks5cDVBQzkzYU56bzhRZUNwWU5LWTAxCkVLN1J4Q3pJbytG
Mmd3L0w3Y0dyUlJYZHc3b2pCWmRIVG1IbDdSUT0KPUxGZXEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005fa450065b1ee184--
