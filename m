Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C117288A4
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932954; cv=none; b=NcdOeKmwwtiteJifRUia7/oSnJ4bjzVb/MwBbgziKb1EU255lUhaD1hfVikV5KzNoow8q9e2u4rchvMWsiccE7zYHBYbhfdg64K8c/LYhiWNZdFkVSESCfZ7Tb7zHjLtVYWR3iczqPUYZTfJVfv87IaRzAy3bd3iAGHltwjbdvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932954; c=relaxed/simple;
	bh=L7UgW0ZEBvUBb23W3VuWuwzqcgvOiV8DkGPSJkwdrNc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qj8fTtshAGdfmnU9PtwexLy7d/hnM1+Hj5qTTy9/6CnBlDQsX7YceHZfWc0riNij3Whv36GmylG+NKku34G8o87VC78594t2/nO2u3fS2mc7PuhUC/7sOdhtf3HjuFlHwZcS/dvUqM39vab6vJeZfwnK52ycAk7+VZvSJdKP67M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfWqsxl4; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfWqsxl4"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b283d2b1b4so692196eaf.0
        for <git@vger.kernel.org>; Fri, 17 May 2024 01:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715932950; x=1716537750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=L7UgW0ZEBvUBb23W3VuWuwzqcgvOiV8DkGPSJkwdrNc=;
        b=hfWqsxl4BSCWowoxcHpzhr/Ruz5YkcZiurNvoEGRR5XOArtDY6+qIZ7tjnEnMBKJyH
         TovQSeutJjgFHunn6Zqe4hm11NImToYxhtvrx+B4ZveLD8ai2oS27ptpifTZQY9H1RPu
         1JRSaGwEoPk0A0gTy/Zvt0FvmLTqiaHKZIJhJ4iV0/NZ/gkk89avnIc5AzVlIreEaBS+
         HiQWGUB/pR9CU3Px9MeThJVJe0Wk+krF+Sz1upc7gj7+7gCi4oZ1ald0EtWVe8LxTNLW
         UcYfCJDYRTI0fUfVrZyBGcbFfVQICJRvmO70SoIK6Fs8r84pTn3I0cfXLFar15FTj3RQ
         ioww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715932950; x=1716537750;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7UgW0ZEBvUBb23W3VuWuwzqcgvOiV8DkGPSJkwdrNc=;
        b=psmPuI7x4XFtt/9MWhGlxHGE7kajrJcKlbq6Vj7FIr6Hz43x0W7QGRutNL+hX/t4Uv
         jceChwWQzf30zRuVILXjEa4izV2ddyaUq2viCUIQldbZ/NdATa+BckL0szMFfNNEOB2L
         rK5Ue1RupctI7VmwoF/we8FzV1DM13agcwuzl3x5dJHqAxbBLp8PrAU6UL2FR7n1d25t
         LL/a043rxvi+VKxJfPI6hcy/JknFzlYiwZ6JdcJlH5tMBlhoIc0v+PK+kmePEeUzr6GE
         P4pTHCeOaJqcg7UO2M0Vm3AgAi+/6ayapTunMoYvaeesbQtU+37ZmMH2Xs80ewBvyopL
         Z5sg==
X-Forwarded-Encrypted: i=1; AJvYcCVLbfUAcP5ctqW5BTciimnx5uoLjFyvLdQDjTUYl4Xd28AzihUJWY95DHMMvqXraRY3ypcr5dCkF3JxKSiIhaRZgaFD
X-Gm-Message-State: AOJu0YytDxv7FO59ic1UNV42il1kFRMThWAFA7BjdGJXs9dRZgSRTWm7
	ClNA6isErdij4em/R2thpoF7gPYbyOKoKbmA7NPMcD925wbUUeLe3597quJSzrQtLiYsVR+tqxT
	nq9xPnjuC9ygw9eWpRMkejJK7fdg=
X-Google-Smtp-Source: AGHT+IGppVn+FGRXCFaU9QoFWxAYJRNTl+KwzRHlGkjOavr1M/z+J/WGmL8L+xPUtKp4cZTyzIUeafiSqXMxahl+BU8=
X-Received: by 2002:a05:6871:a0c6:b0:245:3678:16d2 with SMTP id
 586e51a60fabf-24536782df0mr7429304fac.22.1715932949957; Fri, 17 May 2024
 01:02:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 May 2024 08:02:28 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <f1c9914a77ab9bfe27a62e324cc3eb388f4118d9.1715587849.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im> <cover.1715587849.git.ps@pks.im> <f1c9914a77ab9bfe27a62e324cc3eb388f4118d9.1715587849.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 17 May 2024 08:02:28 +0000
Message-ID: <CAOLa=ZTGdM8u7PyBGis7XZvrrWLLpQXMuTdAQjYGy+0JdR7CRQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] reftable: pass opts as constant pointer
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000f0e9ac0618a1c552"

--000000000000f0e9ac0618a1c552
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> We sometimes pass the refatble write options as value and sometimes as a
> pointer. This is quite confusing and makes the reader wonder whether the
> options get modified sometimes.
>
> In fact, `reftable_new_writer()` does cause the caller-provided options
> to get updated when some values aren't set up. This is quite unexpected,
> but didn't cause any harm until now.
>
> Adapt the code so that we do not modify the caller-provided values
> anymore. While at it, refactor the code to code to consistently pass the
> options as a constant pointer to clarify that the caller-provided opts
> will not ever get modified.
>

So from v2, we changed this from passing the value to passing the
address. Mostly, we're trying to stay consistent and have to pick
either, so this makes more sense since we're passing around big structs.

--000000000000f0e9ac0618a1c552
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1956b6cc4d28bed7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aSER4SVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meDBkQy80NzRuNkZDUTlzcnJHNXZkNnF0OGtCcENwQQpVQWRGdmhvQmNF
b015ekJUMndIRURHVnlseHF3ZEFweVpjYVRGQStJWDQyWTJNTW9wZHhBaGdYYnJJcno5SE1vClk0
YUV1bkw2V3NwS1IxZEcrQ1VxYzBZQmg0SUJZRzRRK1JCYnRRekEvdDN3bUhmc3JVYmtvRkZLUEdx
RGM0UkcKY1NVS0RSMTFRdlljdStOVjlzL2ZNMFAwVXRLMllETjhmVEYrWmVSQlJ4SnpNWEhyWTNE
NzhpU01aV2d5dFJUYwo5bVFDQkVYRnRacGxuUElKd3BGb3lJaWlaQjR4bkhsTjI5ZGRDVjRkRTBa
MHlDSVZJRGkvaW1YS2F3UkFJTzBkCnFzRjFqalBDcXR5MFp1YUhod3pReVZJejVTY0FsRlhUWU1E
cmlkemhsNDNWN1FEUCtWbWI3d1dNU1EwM1JFdGsKMnhZdXhGRTVqWlcyY3pkM0VMc2JRd2oyaUp0
b09SM0tsTlpGSW9ab2praWVnRXhpcU05SHI1T29CTEZuTm1SaQo0S0NRRWQrTmMvU1dKSDlINktE
anFxR0hEblY2NGNaSDRHMkdHRGdqRnNRRU1ybXJxaXh2OC9hWHR2MWFSa3VGCk5pNUpBemRSb3V0
eGV4MVBWaWRLNVJ3SGhROWd5VDJrc2JvV3hudz0KPUNKM1QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f0e9ac0618a1c552--
