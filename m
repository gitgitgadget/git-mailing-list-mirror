Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82143314AC
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154906; cv=pass; b=KGlVB43YX7aqVP6yeovGQp9YiXTOvKWjWqzHai1RrELana+GiLS3Zqgv3jEvLkct3MoQJ0QABVrk5GRihuAtNhuewbdFhWKE+AM7JbNHe935Dh9GgU7x8wfvY8T2zF42QHxIUW3IuqwjUwzj1fC+l6iWIUU5RIz3g53+BnmjyUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154906; c=relaxed/simple;
	bh=gAdcuxGgqgb32USPrBW9m8OzuqzP4+OgEAdrLpHt/7M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikR411yBKJ6X5oGsvbmWNP0dnRFLoS0shLvWmNt7NDVweftOz8v3zFDaKpmqCvh1Dt0Zm05H3gSGMMWPzJELti+7rL0Uo9xEaRDfPctIvyB9KwtSERZ4WpP1MvZRWJ0eFr1LG13XGHKoTknWli94LNoHjF/WCSd8xcYkV5qxurE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pkbEBS2H; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkbEBS2H"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7387ac7d28cso757980137.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784154904; cv=none;
        d=google.com; s=arc-20260327;
        b=pkKBhyU184K0MkcCzFRfZcKEwwT0NSyXNuiYUbLLGjxKeLL3lBb39dqpPxGu6SPQTl
         ublhzq/7tKpsILgG3kHJV078kGP/J0Y9Yd2syWRb+RUFQOoge2BmQJwh5Ru20Bg6uIFZ
         JN24T4NnDAlVio0XZHXgPaoD3N+oVp8vt2aXzUXixkx+4F9rC/ZqUj7AHBC4BV+SnDfp
         ry9Yp1x5nMPQXCeDhIck8CdwQFgDFFVnnABIRrcou2d7tV6a0ZDxa878MGo0gsr6ugoo
         f6Axi2ltYA9CJb4wHirLYXv9HjViXwRbKbwQurR/O+1N4GOWyd2RM0NATzEJ+N3XLIqI
         FIZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=8MdQeSrO4ll6BZeHOOeOR4SP4zzYVQ/Lj16pozCFx1U=;
        fh=lLoXjCJojwsix744p+NHGfDKtsr4p6Zk3TYkGgrPzEY=;
        b=I0UV2WjEubqo7HW3fOZj8rdFIV9VUn94K8HBKPczHQ2Yis+OxqaugGXJ9R62jWOf6k
         Kt/JBtIhTUQ4SpTbP4ywdo12yr9ocB3/rJ6fCHcAR/GiSfIJ7YJdLqWnjcBv1YjCZ4lm
         7zdgNZDB9wKTVe+SH+y3I8ykJmShhefnWF2MNFlayXDj6ZHB+vNDgQ0u8MRXGM65ZYIq
         Pumi8GrJPKEntFx1sSKI1AsonW+pmhbeEYPbZDpxgGOVMYMNosn5jqGmdvzhXtffTVex
         FVPjxdXIadY1KBLiTVAOgxMddnwzGq+wF7oO1uWwA/NKlWciV+vZfAB0x9N63w5Z8MFp
         n0uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154904; x=1784759704; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8MdQeSrO4ll6BZeHOOeOR4SP4zzYVQ/Lj16pozCFx1U=;
        b=pkbEBS2HbLBCfZUwjHZTmcOCepWS3WLB+qKB+mMwulNY6X8z2ybfhnx37yFS+eV+fT
         pExTsbcJ+Dwmko1OTC83BVb5mjbylcDyltL73DK3e/jA6VU/69hzJi9mfZu7HZnW1eVZ
         B7//tKNfbNdcw0s6vaNwdug52isBH45fn+ABMxcQe45DltRaMXROlYP5fdED4iWG4kDv
         LAd1/tV35rNo7HNg4g0hiyWtsQ9WTAYKovTjgNDc/TM1DDfiOz7rM3npgk+x3nPGod+e
         QWMTjx/AD/mfSydIyy5oxDrdSXGf8k8lrLwcYR4bA9Pe672EYb1K8kubtYsO1qN0sGDa
         TJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154904; x=1784759704;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8MdQeSrO4ll6BZeHOOeOR4SP4zzYVQ/Lj16pozCFx1U=;
        b=CnS199E9hI3G6/o+Y27CbZJyXhVWQO0aVdDmTptjQnXZ4289iZD4lnHJEztJDj431X
         fiAdA4v1asdu/MMOdwvmdkNqb0K4J6URSe4P/bnmGZ+5MMP3MISVywfWeaS72ga1MzpP
         k6oaiW2ETZa1j07Ku5WBGo1Le4quyirb2IlerYc1vpLl7mU6AVgzSgKqQYAbM0mueLtr
         rskqXJJRjDAt2q6bOczz/UFtkGMUNjQIUAGjOBQ9sdA3or3fjbVo5m3CbQs83CgH+cvH
         vTa3N1OaUW+7NVaoXemQJnjoXEWJbtOCKqQjxj1qjRelvpDaKJtU9Wzqg7Mr6CJq4bAJ
         VeSQ==
X-Forwarded-Encrypted: i=1; AHgh+RroPf/T7HPgo10kxpc0yDZw6NJz2d7QQX8eVtGySppHUf8qVXmFuBetCUVzZEjJiiwveOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbPUUCI0GSatVQ1aA3BejUd777k2XQEoqWizHz9tGjaUkfmAE9
	JLqrYMmWAlZ6UolmvmbAFNCZQhK1m57sHaxNYCLKs71OovFJE8WwHaPTMt5qq168TcD0ma38azR
	R3pW2JgMB96ZvkOIRjyXnMLaIl+kb02Y=
X-Gm-Gg: AfdE7clX2h0Haeebp0olW+QfhA6fL80DPS61v19a04FBj4HrCXAHYauc75jvwcvDX44
	UGGMcNHFk/6ZuwyHstqNVYjHV6njeWEIUZbGk+nOtOdJ3s9romAlzBP+JWonFc/Bd8FReRxEOh+
	4lwjxwYQwJMwvrRqZ8uM7JazSr/uBLSsPE3n6g9sySRzYXuP4RVy98b0R9yQ71NDW1vVrMCshyb
	BmhvZ9YBF8bt8Pqw0aDMyYscX+Yw8JDZExh3rEJ3oNh522wte8fg1ly3GTxDF/+HYnGxBMjUe2u
	Lmy/WYOGf/atpMUebcC2zu07VT2tkPV+RyHn3DwsGtU0sjIm0ObY
X-Received: by 2002:a05:6102:548b:b0:73a:322d:1bb4 with SMTP id
 ada2fe7eead31-74533dffae6mr11322862137.22.1784154903723; Wed, 15 Jul 2026
 15:35:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 18:35:03 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 18:35:03 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com> <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Jul 2026 18:35:03 -0400
X-Gm-Features: AUfX_mxS7J-0XWgckv-45LU2pOxc5scaNpOkVDZQgClvA6wirvMFBdindymi_5I
Message-ID: <CAOLa=ZSoAPCG5R3+By4N1z5AdoJwsKnv1s96rYeMheo-H310DQ@mail.gmail.com>
Subject: Re: [PATCH GSoC v18 00/13] cat-file: add remote-object-info to batch-command
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, gitster@pobox.com, jltobler@gmail.com, peff@peff.net, 
	toon@iotcl.com
Content-Type: multipart/mixed; boundary="00000000000042e0d40656adeff1"

--00000000000042e0d40656adeff1
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> This patch series is a continuation of Eric Ju's
> (eric.peijian@gmail.com) and Calvin Wan's (calvinwan@google.com) patch
> series [1] and [2] respectively.
>
> Sometimes it is beneficial to retrieve information about an object
> without having to download it completely. The server logic for
> retrieving size has already been implemented and merged in a2ba162cda
> (object-info: support for retrieving object info, 2021-04-20) [3].
> This patch series implement the client option for it.
>
> Eric's series adds the remote-object-info command to cat-file
> --batch-command. This command allows the client to make an object-info
> command request to a server that supports protocol v2.
>
> If the server uses protocol v2 but does not support the object-info
> capability, cat-file --batch-command will die.
>
> If a user attempts to use remote-object-info with protocol v1, cat-file
> --batch-command will die.
>
> Currently, only the size (%(objectsize)) is supported end to end in this
> implementation. The type (%(objecttype)) is known by the client's
> allow-list and request path but is not supported on the server side
> nor the response parsing. A follow up series will add full end-to-end
> support for %(objecttype).
>
> The default format for remote-object-info is set to "%(objectname)
> %(objectsize)". Once %(objecttype) is supported, the default format will
> be unified accordingly.
>
> If the batch command format includes unsupported fields such as
> %(objecttype), %(objectsize:disk), or %(deltabase), the command will
> return empty strings for each unsupported field.
>
> This series completes Eric's work mainly with the refactor of the
> validation of the placeholder with an allow-list that filters what the
> client asks with what the server is capable of provide following Jeff
> King's idea [4].
>
> GitHub CI: https://github.com/pabloosabaterr/git/actions/runs/29404390713
>
> [1]: https://lore.kernel.org/git/20250221190451.12536-1-eric.peijian@gmail.com/
> [2]: https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@google.com/#t
> [3]: https://git.kernel.org/pub/scm/git/git.git/commit/?id=a2ba162cda2acc171c3e36acbbc854792b093cb7
> [4]: https://lore.kernel.org/git/20250313060250.GH94015@coredump.intra.peff.net/
>
> Changes since v17:
>
> At 10th commit: transport: add client support for object-info
> - style
> - enforced the server response handling, not allowing bare "<oid>" or
>   responses with a different number of attributes different from the
>   number asked.
>

Some small comments/nits from my side, mostly looks good otherwise :)

--00000000000042e0d40656adeff1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 54633bd558471af4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wWUN4VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1BPQy80bXdZdDAyc2tYWHBUcW9aajdIbS9ZL05tMwphNWxmclorWnM2
MEFOdjNlNGoyUGtYQWRKdXFKcXlUY0FSWmR4QUsrMEM5MU1UVmJvTUI4NTZVd2VGNFJqWnpnClh5
Z0EzU2dsVURCTTVqSEppTGdMMEw1c0p5bGo5L1Ruc3poL0tvM2U2QkdUeFB3NUFmRVQ2QnlTU1dX
UmhaK2YKajBrdmw2VVJuMHJsNmhXYlJ4a2NYT2s4RzIvMUZEOUUvaS9MUmVJdld4QXZ3dnpmbmt2
YVdzR1Y5b2w0a0V1UgowWGxVMlc4dU9hRFZwRmVLb0lYZzFidkZ5ZzVtdzZJU3QrbmJTQk5TMnRU
ODYrM05VWlRsdG9PbU9WTEhtMnJOCmtidng0clg5ZUlZZEt1RU9Fc0NYZTl6N24vM2NsazdBQ0Ny
MXV2KzBBdW1NQ1pWOEswVXlDTUpQamxGc2IxaDAKTFBUc2I4UWt4TG9zZzFSYVExN2N0cXNXVmZ2
ZXBEU0dxQk9sVFJCNDczOTNRQ01zRGc4WVhtTGVxcGh3VGxkZwpmSldQeVJYM1RrRnNwZU5Uc29t
Z2pjN2pVajZCU3J3c1RMQ2hWNlVPbDBPdmk1SnMrNU1ES0F2dVJlL3E0WVNzCmZkdFBjLzZsZUtR
dDAwNGlpK0srSVFMWE4rWTUzdGdvVHl4M2Z3bz0KPTRxUGIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000042e0d40656adeff1--
