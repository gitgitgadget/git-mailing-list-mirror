Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB82D41D203
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224824; cv=pass; b=DgkPwJwNKL2DhD0jcvtqkftcFLjcgs61fStpxN0RW5p6kEW5MVpu7qZuFbHaO5+jHOuQWGCfbHsjN406bfEvIxOjG49D4f5x1/KyQa1FKEQUOVHu1RwFN0Omjy2Mgf/HhUPHCsUwrSVK2/jawZh4b4rLZryRczcuA1W/xG+kjg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224824; c=relaxed/simple;
	bh=A86r1wS/xiSErEmvpXHxnHcHIgOk/PI24gbdzx1Z7Y4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DflfkcYzk3lpNP/i2v0aZGnW/tbHKWzgyKbXJ8C2H+GStjz1pJ/ubPNyfkH4hO9FBXCDS73iESaNSE+AINqkLRj5/VyYAZnLXLEf6V9WEiZR0avdvjgNjFexJqdqmMyl+9P7QiMZ39jxtGgwyemlDFN8Jnb6o8+P+71f/6rhhJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyayEbgI; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyayEbgI"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5c2c0df0b45so884948e0c.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 04:20:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787224819; cv=none;
        d=google.com; s=arc-20260327;
        b=e/Mlw9pXKyrxLQw5uxNqgw6MWLtTLwU5EqpELB5VuZwMuZ0/KeRmUfVmU+arbqm9tD
         ameb4NZtHupQhFWlEmDTdvrAkLoIXQ5T35E9tipRcKTVu7j0m3vXibSC7jf82RSbT/KO
         PRjs99Fxi7PoqzwgpUfXkxxsVqWfVuo3dG+S5sTKail1G1DWJPkKexH0iCE4/ZGoHDWu
         1M8OjfvsgWLl1AL4rBnSYY6d2SCbKtMH1mOH5WWOz4ef3l6O4GJoODdXuplnacArakC0
         NqRMSOlvntbU8ooexfG1n5eTc8snHwg4gFYP8iq0mZ5pzRpKbxKbJ0SQaPOV4rhOEJSk
         yeWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=MIJVGsuXnflQtECW+dd3SNVAlbLET5qWoB23tPKnnTI=;
        fh=k7LuPU/4FaqxP75DL/BJKl2jig/C4AbM9pdsP2N25UA=;
        b=afVT8EcDVA/9fsWkbuc2b/pZlOGfyfzr6pWVhD9cq/lY+4JpgqCqD1THgCCR5BfBZ1
         x6+fAuby32CRDXW+IT1g97l8g/1WjSCehCpam+MOZ6Gdj2mrMdvx1jEvpOa8FXzXp6Y7
         1I8ha/For6jj7RAIjXDgMuSHpSvAtveridZSYqj0BVZIVtAkK5WjqIBHIqoyHMZ6DHJq
         B9RE4B6SwKwO7jbmDP9GqqnCs1WVQZmiOOgSNOvRQ8UJnL9WQbsuUU5qX+ewqfa7W/Cc
         MnfXToI8/oO8ddOs/AjZKMzOq17/02quBPmTHAeFUCqsD1ZgLHbq/4p34d/6yFRWTWka
         XoTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787224819; x=1787829619; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MIJVGsuXnflQtECW+dd3SNVAlbLET5qWoB23tPKnnTI=;
        b=iyayEbgIY/FFtaKPh2Nyr4VXtLPegonIXejtsVSW30d+BfYS3KvM27hfw+XYADkwUw
         56xT9Dwo7lp3u7z1ZozIWFT0UbcOhdXm+TdnaH23e1paXezI/WuLaEbdrHRpVytFgyt2
         1jx87fg4cdL7DYU8/an/0R+Vussr3Nco0QbrfHsFEUqO9iN7EuuW+PVUYKapaXxKeVid
         KdVqr11SDrsP9QCIusDnPUKYJMlLMXQVNepn6sjL6cpnSPXokJbCWJF4RlChwg6S0Rmk
         GxYEfR92UB82G/ThDITINEQtsp86hl+cc+rbD2aNiwu2bCWNZcRd/PxFOxqM+iQmUJch
         bi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224819; x=1787829619;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MIJVGsuXnflQtECW+dd3SNVAlbLET5qWoB23tPKnnTI=;
        b=f80OHK98KJHY+qqiCQHU7m3g0irMO/K8/E8kPlO87q+2OuP7LAEo+lyCAeXETQ808H
         yInd+smHQVdd5yEZ/6AY09/fx5dWwxsdkXAthBQKXYnjOSF/UeNzwbq6Vy8Qkhx/KIy+
         lsRvNRxEaKzFPtzj8CZiWonOIEQHWkQb4biPlJcpoFtwxoPWYZoUss51cpEUt+KnUC0Z
         D9h+rP8cTCYDcVOgwxmu6NpaU6nKHLO+ZHGVk2HOvFjdxUP5TGrWoMfOHYx+nwLRvPXH
         s8uTvVc8yQReFtw0pvfsI2sUR//vIjq1kVNMY2EXNF27ER0P3eT8RUxw/4dk45lwM8MS
         2RYg==
X-Forwarded-Encrypted: i=1; AHgh+RrC/FaHErX2QJRZoftK0IS6S9Eb7V0vCQ5RHWMnIDpWEXafyNFTmtVQFzswk8Q7rhH0JHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/A01J0w0SKTYFoJ59xoSGRi515BKX4j0AWnG52KPKSse5M+V1
	GAp366ieE4ad57Fr+gLcBypUdCrp8eVVrG1HExL2ODJ/abbWoPmNBq9ezuCMkdVdJXLjFgDEHpU
	5TRpabnEvssEidIg7abkWMQtG03ZJZhI=
X-Gm-Gg: AR+sD11nmmkd1ucJ98dF5AF1Ote4gy3/kKJOabvwlJjHbdB4OW9VSdiC//3uwxA7sdE
	3Hj4vTUuQ1tAn+cDfFU3qDj94bq/v0laqSXQlDxP++eDZwwRT10wQrCG1vNC4Bza1RiPKBIxm/1
	PEmefIYqqpfNNWzpJhyQCduaQ/pCKLbXlH4LooqnfisMKb/w7xzoLMajzDNmGVtMekSnVsEXNNm
	ugRXWHr7IIKWdr9AVeVoB0D9tdMxgyKhKlgSJaTZxObfwfOEsOZlpn1RN8X8wL1pig+TMcRfWuy
	P2fycq1TG0uum5eBsNF+niheUBWA2BXWkGyUMpbeo3VQmkr7fX2MB9bRg+oR9MAi0/Ouzy6PyLs
	0O3JpitnJAlSTN0JdKtynZgE0t1/8EzHHNr8=
X-Received: by 2002:a05:6102:5793:b0:773:756:6695 with SMTP id
 ada2fe7eead31-777f86830a0mr4172461137.2.1787224818652; Thu, 20 Aug 2026
 04:20:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 07:20:16 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 07:20:15 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
References: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im> <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 07:20:15 -0400
X-Gm-Features: AcwNN1X9CdQgIttiL7nZMZtQ8-xX9OvEHVQCyDYt9CRyx8lWw0OHm65ddVX2v4Q
Message-ID: <CAOLa=ZRsVjRrwzAf==SmevATf+OWoHdnHwUbvi1=M6foBRzLnA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] odb: make packfile generation pluggable
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000733967065978b477"

--000000000000733967065978b477
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series makes packfile generation pluggable.
>
> Note that this series only makes those parts pluggable that are required
> for the transport layer. The other parts that relate to packfile
> generation as required by our repository maintenance is kept as-is, as
> there is a bunch of options there that are way too specific to the
> "files" backend to be portable. This should ultimately not be much of a
> problem though, as maintenance itself is already pluggable in the first
> place.
>
> It's a bit of a shame though for git-pack-objects(1), which still isn't
> usable with alternate backends. I tried several times to find good
> solutions for making it fully pluggable, but due to the backend-specific
> options it's an utter mess. I want to eventually address this though:
> same as with git-refs(1), I want to introduce git-objects(1) to care
> about all things ODB. And as part of that command we can also introduce
> a command that generates packfiles in a generic fashion, without all the
> cruft that git-pack-objects(1) has. This is part of a future patch
> series though.
>
> Changes in v3:
>   - Fix a use-after-scope bug on abnormal exit when child processes are
>     cleaned up via `mark_child_for_cleanup()`, as noticed by Elijah.
>   - Link to v2: https://patch.msgid.link/20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im
>

Dropping in to review the new version, the changes look good!

[snip]

--000000000000733967065978b477
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c04ac7127650c21b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xRzR1c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mekFzREFDaHRoeUZyNWora3JLdDAxSXlzVlFBK1VqbAoxMDgrWkxYSTBC
M1FDczVBNlV3bzd4N3JWSGYxNGxucml1MWZsNzhsY0dHYWpmblJsU2hRRnltKzhJWW5jUXR6ClYy
VUZIRjNXNDgxYlA2Mzk3ZlJ0UGxOdjlUNmhKcnE4UnYyU1hTRHFKdWt1ZGdvOGtZOUR4UzhpVDNz
UVY0aXAKN1hBWDFSWjNtYWUwT3ZzeTRrL3dUeHRMTWVETDNKRGNFK21xQXZpR2thU0ttNXZCRW16
cUJIaVV1UEIvZXBDcgpSblNweHFnRGtBUTQwMW0rRXo2ZzlNV0V0WjZaMllkcVF5NnIzMVBOV1dE
Z3BSZGNUK3pteWVHVkVjSzFwVHpCCm5NTG1BVUpTUjBGb1NwSXcyblM1aWVNTFA1YlpaUnNadnlj
Vjg5M1pRdTdPOTU4UmZteEZmYWFwT0s4TzBHdnIKKy9ONGFJbHI1akRoNTlaWWNXSnBRTEJZZ2lS
aHZkRnFyQ3FYdVNrSDdYTHh1ZCtKbkxBOW81cXJDWWJHOWJldgpXS29HQ3dLZ2cvdEEwaUV4bTli
ODVrcHhaa3BnLzJ1eGp6YTE5a1JVTC9MdTNrVUQ4Y1ZlZ3JTWjFFb2xBejkvCkJoZEhxd0FCYUtp
di9NTnVKVDNPZ3BINThnREZCM09wbHl3d3ovTT0KPVFBN1gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000733967065978b477--
