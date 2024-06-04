Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EFE446CF
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488425; cv=none; b=uwi7wmb0ZcJf3sEW3ELBXuZrYixW85RTLoxZ3k/JBDFk6r75mdY84s35VGFhir+GniI0JIQm2Kwvp4Buv1zu8QGpjyxmWIQENaRM2QWOkTrIrmYhTlQj/pqSze8isEQeF/UC0Qf9xVtRx+FhF5PWZCJRwZFdpWIpj2Yg7/H+nZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488425; c=relaxed/simple;
	bh=bRUIbR9W/fsXpG66c506hfC9YhOt7lXHKxKlhFoqiEo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=NaLxk0s7M5AjvsmgQzF8U7fFX9ZtLgyBgOOneT4GxcCQTMTxiabvQqQ6hsM53miydte4lqH6is1s7OWFCTmy3+IfB4QQiLUQwTjPWLyHPyl+VyPCOxTJvOfwDhpmGZ3BShUitTnUv6oWdtdJdq4nR+NYmaK/kQD64LVPsFbCOiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiRvg+3P; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiRvg+3P"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f8ef63714cso3469129a34.1
        for <git@vger.kernel.org>; Tue, 04 Jun 2024 01:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717488423; x=1718093223; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7zBVY0JtYnJ7EY0ovaBj/bO4yTUfmxNYom4Tc7LoZc=;
        b=iiRvg+3PW7XKwctJvM8tc8B1NWvD6y4u0ePZXhtzFF/JG4GzsZyzmK5pg6311r6Mdq
         JPY6Hx9Yr1y7m0JR2p0I5XXUhG+cllX90cQiKDyHSaWatfmoEBMAuq6ALhRXMOngfeuM
         0su7sE6eO6ATMHZSGnU784VTgVva9ntJaydiPpBAPz0j3HR49BCCH5t5loyvkH4jITPB
         nPUybWtm6uA+0ivj1h4WL/RV+S3RWr8yF2JyMn2tu6cvACvtIyAahPS/x1BlGL6EBKdM
         oofI1Jlfd1KpnPAfMehtpzbXIzv26ZfsXbk+9pVjBOYojqu8YOTLB60HjidXHQOC+WiD
         e7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717488423; x=1718093223;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7zBVY0JtYnJ7EY0ovaBj/bO4yTUfmxNYom4Tc7LoZc=;
        b=l+iq1uMlrs3MlbZKDR6MTuveHnVHMaBx6UiQH4+S1Yvc47YgkPfemxFiyYDhHYih4o
         GUSCQUbkuAIo0rCJoYdm0fK/ns4Llqb3I4N76ZqG30IaffWW9UYjgg/0pq4wHUVcO/Sz
         1XZepi7sIbRhy+N3INlO9pN2CMitpw90+KZmHypF555fiasiyg4qFsprxsXaYyAv7IFD
         oz98HTrc9nGLOxGUBIYgTbxeAWecpmLWn5EFsHsnbzFyGNBe+0tDhs/FE7F/Seu5LNjO
         a8q6fRPV+wbrftl3u2Te+9pcpjWlO7kIKhOhFsUegck3PdXTmRKAJRvTPmhKHr3jdBNT
         /Tqg==
X-Forwarded-Encrypted: i=1; AJvYcCVzPKHizfAs/G0tNdeKrvSPYjn9OxeVxcV5/zneyMpPzdCP7fXyW6xrtfZePoQCESJobHOvoeu6cddDoUB765TWfk3i
X-Gm-Message-State: AOJu0YyF/L3KEncWghMtlY0IR7ulAeQm4yUPSgU/YVZ60Kxy44RbZ82F
	8wHcOuqnTwAvgTH6vo92GQESujyq511V0olFT3H6PrTBPDlvRUBzUDJXF7Cd1bBn4b2AQDps12b
	7tnpYYnY6XLETgKzz94aQcTOuKlHLawr3
X-Google-Smtp-Source: AGHT+IEmrreRW+CkC2w4hUU5r+40VBAX9qmDgKRlLlh38VHnTb5Ihc8CnHdOzuCLwVkztNL6Pa8iW43atFKZZdb6iT0=
X-Received: by 2002:a05:6870:c112:b0:24f:c2cf:444b with SMTP id
 586e51a60fabf-2508b99d600mr14400845fac.27.1717488422431; Tue, 04 Jun 2024
 01:07:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Jun 2024 08:07:01 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqo78h1bdg.fsf@gitster.g>
References: <xmqqo78h1bdg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 4 Jun 2024 08:07:01 +0000
Message-ID: <CAOLa=ZRzR1Nfqa1KA04W2EzAq0nM5Fr1p7PEfsukidL0-RsWGQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2024, #01; Mon, 3)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000534717061a0bef8e"

--000000000000534717061a0bef8e
Content-Type: text/plain; charset="UTF-8"

Hello Junio,

Junio C Hamano <gitster@pobox.com> writes:

[snip]

> * kn/update-ref-symref (2024-05-30) 7 commits
>  - update-ref: add support for 'symref-update' command
>  - reftable: pick either 'oid' or 'target' for new updates
>  - update-ref: add support for 'symref-create' command
>  - update-ref: add support for 'symref-delete' command
>  - update-ref: add support for 'symref-verify' command
>  - refs: create and use `ref_update_expects_existing_old_ref()`
>  - Merge branch 'kn/ref-transaction-symref' into kn/update-ref-symref
>
>  "git update-ref --stdin" learned to handle transactional updates of
>  symbolic-refs.
>
>  Expecting a (hopefully minor and final) reroll.
>  source: <20240514124411.1037019-1-knayak@gitlab.com>

I did send in a v3 recently:

https://lore.kernel.org/r/20240530120940.456817-1-knayak@gitlab.com

Let me know if there is something else I could do here.

[snip]

--000000000000534717061a0bef8e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d53d48ef6dc6aad9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aZXl5TVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN0JBQy85WDRMVndRekxaMk10RTF5cVMvM3MxekVCQgo0WXRJc3l4Vk1z
bjJObVBKb2lxSzFBdSs1VlM5VjdERGQzNG92Y0dzazZVRHBsYnVDeVN6YUhpL1hnNS9JR0hmClEy
L1VmRmhjZHpqeEwxcGtYSFpLS3hsekl4L1BzRnVaY0JiWTMyTlNYYnFrZFFtRTVTdzJ5ZjdEZFFj
cHlKa20KaXN5WDZiLzFENWd6U09URG9mWnpVZWxzaXZlUEROZmNQdVl2T1dxbkpwS3NBR3ROMVRO
elErbURhMFhBcUZrVQoxYWhqVGJmL0RENXgwN1pzK1ZydDAxQXdGN3lLL051ZGFnWWtvVCtoKzNw
YjhWdEJDdTJXcWFaS0djK1lVMW1SCmpSTTh5Z1JESkl6RjhFS2g5NUlrcDJoSzFrRUlIQll5Qm4v
MW52WjhWbjB0Q0JDd1lOMTY5dk16bXlsVGFHUkEKTlRWbzc1NVprMHJWMVpORTJhN2Q5M0ZldFhN
WlJLQmJYaGxaZFlKMHl2Zi95eE16S2tLeEV2TDNudVVpK1Fncwo0K2dYVFhPc2pGUVBpdDNuYmVB
U0hNNGhVZFJ2bTFGdzJVZGliN2lKcGVkRTUyRXVtOENXM1VPdHdaMFIyang3CnoreHdWb0VYQ2Fp
dHdLR1AxNG1FcjNyOGtUOXd2czJKQlFOTnNxdz0KPTdsQkcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000534717061a0bef8e--
