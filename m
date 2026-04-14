Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548E3168EE
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157817; cv=pass; b=QLawEOxo/ZAFsdll5aX5SW/fldsFZeUZVzx6TF/8cIiL9idpauiyU9kIA6GpcUj9XUmFYWvtsh7Gbvz/9i/iZ1hUwoX4M7XKuPgLSqw+ORV4730CVqWVw6r0yW0gYwjUsxILqAXmkE6EKQd7cuMAhzHp5KRKZiX1OciMARjAPCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157817; c=relaxed/simple;
	bh=9LO6k5TtIobAqycwRbAym4DQF8d58/dtfi4/y9D+UGY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOPeNlGmgNLw5QqV0KpNmlWyJJRcxt6XkU4jq1nAcgz2qBOYdBHxsw5w/eOByZVXApD+p3YKdjtcRs5WaHgqbAftbI+p1SvOVKCOz8dON7L9cMp/xxu1zzvN/8GFne6WfsyikwP/x2bTR90ATft2u0EjeMnIyUtOvDfGo+ZWcl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=om/WtLtD; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="om/WtLtD"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56d89f35940so1771464e0c.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 02:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776157815; cv=none;
        d=google.com; s=arc-20240605;
        b=ObKEbhPjcnzY+i/hEThihr4u87ESWl8WUn8n26XnYe+UGdbOe0cVTm3FKrdwYkwjvT
         XOGDU0hnZBsu8Px96NAv8N1quKUYoy/uk8KE1JxS3d45CgEXKcUHeA7sZHhN7sDUAR68
         CMCo1Kbdir793DVxqz/txmp/2BMhm20rpXEaJFiCnqq9QpZA8S46ldmIy+NeFIsq1b9U
         ZEVS8GqRzWmZH7tS/vOmMfKDskZXKwNNXx1x32V6KSa38zPc+b/b2TQz9+HdTW+Iqccq
         VZ51rIdeINns1tNWxO3uT+GgR2oQFi9Lix6VW3AK8+0VtbXWSCeucy7i144CfaUXiwB3
         eDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=afR8Uxva+hsdTFONhIbEI50pUQP3aGWS1eb3VjmZXtE=;
        fh=iPctw6p2HvVvSSP41/hOLzo4A6Yl4F9QJmhBBNbeJRc=;
        b=Vb4QCx8mH20A99gVWLifFMFndKbxwALAdZ3yhB+ntv9yVQ/S+YXCmxNziV3lx/FfnN
         i0t3qKZc0rpEneuKbMzx8Dw0Ngwz67GiDDzU8WJZ/ceTtm8CLS4E3FpTdNkShWI/+3H/
         Z6DgktlnTmvXAEwjNM2C1WJflsWc+k0LkRdZ9PiQ31jLNGN2mL9HmWZb89rxlPy9umi6
         rCmWXBbJq951m8GMjgx5pdcmn6Yn1HX7VJTwRLz8oZ68n646FDdL67O3EakSysGgb1FF
         sc22/cDdRp5tD92J2zYWe8jW0Fv4RV/QC5Oct4ySEjX6ksUYIc18+ve1bN+nroIWycqk
         Aw4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776157815; x=1776762615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=afR8Uxva+hsdTFONhIbEI50pUQP3aGWS1eb3VjmZXtE=;
        b=om/WtLtDMxw9jEu8zQpv5ECiHF8BcMDVOHodsVX9zL6oABD6ObULdS1mp7XRVf/ITB
         xR0SmjEydop6Dw2Tya10Ym89RLE+D5vXzZtHEFGAUSjIhaHp1Preg1/UXkJvzJS/lIVg
         FtXhhKsjBC8X6r5md2DdxcxKcjQ6HrQ/jXGydbjNCqDwggOGuo5xkoIqw35oH3hUkcXN
         /d73OrdvyYyIxSaG8C5pErP4lRb2QjHwtvL0TyM3PHKzFWDbmS5oglHLGFESRkNYdoSQ
         m5kbFD0w96oTgUJg4dlHaAbq5CwucVxIdTdU7N8J6NilJkgrXkN6aoh4a0K0Lgt8t0Ba
         n8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776157815; x=1776762615;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afR8Uxva+hsdTFONhIbEI50pUQP3aGWS1eb3VjmZXtE=;
        b=E9/4we9ywbxTsBGmxXTAniKsfd17kY1OU3S9E7h68d6j/W9bEstt27xpYFQb+BV+g2
         /IoXZoScoy48qCMcFcAdvBp/iOgDfMfyUot/RCIIlziRJwTrXdBC583Z4OHK/xKqH4HA
         wL9TK1cv8lGH2mWyZtSQPpSohwWwaanOxVqf/2lnNV+9gTeq/AaXz/AXVG5yvC2olVhG
         FMU8ldFqhRgu8+sleM0YmPkXxEG+w31CLnT7DMZas6opGOhtNb7ivdNqFfZGjCfhHAGC
         ayo7IGkeN9TqQSounwEdw0hkm9SxH1BoIWQwck7ud7qLwKi4GBq6bOKcci8AHTuWXArG
         8n0w==
X-Forwarded-Encrypted: i=1; AFNElJ9oj960o+gadP/1IzH3Or0+ar8a0Wk3AWB9rfuz6wkjq73k8rgRWYetaTiUAa3fzUx0cMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoQiG89ibvCR748USqekeacI+CQUGBFTYZ5AiTAqc/jQMg1yew
	zh2H6ExpHYa7xTX3hvVf06wCPmcR70D6avHZ9x1UQQa81yblja9pj/SViFbVN8uhfXEFI6It61C
	+Chm6thzj2HhJhnZSf+IBJ9EDJQfG5dLRyA==
X-Gm-Gg: AeBDies92AL9yBFAc/QM9tuI/1Ne79J5aFKZoLCaf86WV5UuN0H3va0frWGE92xyn1U
	8vLdSVfVUjbGHn4GNBekqpcH87cC/Mo9UVAbocn3CUyC1n9yDv/SI3RhGeMb49N3q5dAaelMqMm
	jpy413B9gECL+j07Dwb7qevcUCB546mnOYdb9rwCzdkiRhn6uIaKakHh8Qk/VkjYtQdkzr2mpCw
	zbjnq2FYuaO45smlqmD1onRybiGgkU12mONijNcCDpgkRAUEKtYGpWS5F5/vGxLMaU6uT/CH+NT
	U0w8rn4MZXRMron6xyF5SPfqen7RVlpo0Q9RFPAI+g==
X-Received: by 2002:a05:6122:45a6:b0:56e:d2dc:9bc7 with SMTP id
 71dfb90a1353d-56f3bb8e3e4mr7718844e0c.5.1776157815347; Tue, 14 Apr 2026
 02:10:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Apr 2026 02:10:14 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Apr 2026 02:10:14 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260324123750.157143-1-belkid98@gmail.com>
References: <20260324123750.157143-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Apr 2026 02:10:14 -0700
X-Gm-Features: AQROBzDngYoaRSfLqf5pn-AwAq2XJuZCv2Op6mCKJph6mGddgxFXRlaBSz3_e9c
Message-ID: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] repo_config_values: migrate more globals
To: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: phillip.wood123@gmail.com, gitster@pobox.com, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com
Content-Type: multipart/mixed; boundary="000000000000a63985064f67f725"

--000000000000a63985064f67f725
Content-Type: text/plain; charset="UTF-8"

Olamide Caleb Bello <belkid98@gmail.com> writes:

> Overview
> ========
> This series continues the effort to migrate repository-specific global
> variables into struct repo_config_values, further reducing global
> state and improving repository isolation.
>
> The previous series introduced the infrastructure for storing
> repository-dependent configuration in repo_config_values. This series
> extends that work by moving additional environment-related globals into
> that struct and updating their call sites accordingly.
>
> This helps avoid cross-repository interference when multiple
> repositories are used within the same process, and continues preparing
> Git for improved library usage and better encapsulation of repository
> state.
>
> Changes since v1:
> - Dropped "Base series" section as the dependency has been merged.
> - Fixed handling of pack_compression_level: removed use of a local copy and
>   updated code to operate directly on cfg->pack_compression_level to avoid
>   inconsistencies with option parsing.
>

I had a look at the series, the changes look good. I do think this is a
nice opportunity to set some of the variables to be of type bool as
needed. Apart from that, I'd like to see some more comments about each
of the variables and improved commit messages talking about why this
change is done this way.

Thanks,
Karthik

--000000000000a63985064f67f725
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b8587fedfeba13ae_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uZUJIUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUd1Qy8wWVJ0clozV3pPdWl0N3NoQ081blE1V01vdgorbTVTZ0ltVlRu
amNsQklQbG5uYUVoVUpBSEpycElicGFlYkJtcGlsWHV0czBPZWU3N3VjTHVnWlpvMHM0NW5XCklv
bTZ4cit0WVhMOGViRGVKdlc1MFpIWWNOTjRmazR5SmdOcldiVEFETU4zZHpadEs3STZqL0dwR1F4
bHA2QVMKOWxRb2FMWmNGNzlkcE1EMWozRmZicmxKcjhUbFRNSFhJcFc3aEFieUIwRWI5T2NNL2Mz
bjBTcVBrOHRCQjh1MgpxeHlnOWcySHlSVDI4RWExRE80R3BLWFladEFGSG1lbnFxMEFmVE9OamNI
Z0lMeWtDb29JZ1lTYVZEaUc5NWdsClgyOVFCYy81M3BtQncvYis1a2dLUE4yYjN3RFJ5cTRIdXU2
WkR3ZHZ6cVlueGRoc09uTmRwb2h2djRvUG9tV24KYnZMM012ZmJ1amwyNVd6dWxQL2xjcCt2dGZy
VlNscTUrNzB3NlFZR0YzOGM0dXh0SnJzZEJtbE1VVnZRUnVGQwpSRlFRR1JRbnpQS0JjMkdEeEtl
bkhVVnFjeW5ETWx4aGFzMUsxeVFaS3IxY0VWZGM0c2hrdUtTektoYmZoQ3JsClUyd2g0bEFwOU5Q
N2FqSFFnaGcvRFdZWVRvOXdaUkc2VVRiSlEzUT0KPWpGT0MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a63985064f67f725--
