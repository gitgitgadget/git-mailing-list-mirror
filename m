Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E4533F58E
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775740419; cv=pass; b=CLd8hNhuJNez3QotWiJCkcSyEjo/pPccLJ5nCee+G0I+JkROGeo10z52zOSEx485O4neR2okKxsJ6GOVDQ7arpG1tq6Cg7BqmHbYcVChs9BYlfH1shMEvHMlJ4NXxZ6zKeuB6MBUysNpp6BxRBz7ogEqVmFapTNmiuKhnYvay3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775740419; c=relaxed/simple;
	bh=thX5SXaE3mD+a0diLvIMvEAshYt0m0xPTALXqGgynRk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfrC20+0xYMsVhag8Qd2RPrfvMOi4TwUggEiFLn7jQIMgH777r90s2M2teXjbA68I6eZfBTsNrSMTsW88pDKTGm4K9auOcE9yCtNS5s6PZrQtRWPUTSwK+zzDmqJoi2WL/2Si0EDMVqVH57VYmM+kLcT+AHWTZPqry6MrIu0+28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alq9ypBU; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alq9ypBU"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-605a3cff8d0so521009137.3
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 06:13:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775740417; cv=none;
        d=google.com; s=arc-20240605;
        b=eHpD2Wiz2+/BfpKLgfIy0AEiJs/srmhPLKdc2lpUWGfhBF6zyvCn1fuhbkWxTaQ5Rt
         usdmabPXBaa8egHfYieOpBvo67zebBAavZEFhskIPxtPuL59CxfY2+oSGjHPwM+h/681
         ezzNhQFkjqUv4Ykk1QYIIAoXam618H7uurK2gpgRnPFnTbMPacyzF3WYNUlNJwR8yWeE
         lt4DZplaTlUVhBgUZsBn86F12mwsZVWE6kpoHTGcF7weA6wzXFhLDYmpvjesrguGULRt
         ixSXiYWrKvd4e5XSZtSkDUnOzAb+qSPNmYV2WhJ5vRT9+5pG6BkSShoDYwDVGLYu3cV+
         xrIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=thX5SXaE3mD+a0diLvIMvEAshYt0m0xPTALXqGgynRk=;
        fh=ONaWtvEHOEKUQqglOZUk6A/zSpt0vZW1+2aeFuOtydg=;
        b=N9NE8RzrgM5bBFDeiTuL8VakrChFnXxqcQMIAT3Lv97eKGVGqbnXaMoFaO3biuxVBO
         YTYzH7Nj9jYrm9qPJnHBF2TnmuNIizEwrkFMqzIDtCPlYadqkPpM5Oj2Hz9549wZ8sKo
         0zqKqchLbd5Z3aYfjxWABsep9mcKgkALyINtEPJ7KA+LiEPgDSbZ+6EuUgR6gT4qu8MB
         ESub5aaNSWlN83savCuboaCrZ9L9pRwffEmKGwBiOs787EiNOvR6zqDG3auo2paXBkc+
         GxayibshdmiVeg0MPgedVYtoEwdCskV4s2Vxx2tZ7DH38ch4QSD6toeandT2J9EeGNN6
         nxzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775740417; x=1776345217; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=thX5SXaE3mD+a0diLvIMvEAshYt0m0xPTALXqGgynRk=;
        b=alq9ypBUmXMzzHp+dlEl5akiffP3So4m31HOOxli3oOpec/HJrSNJUd98wedIgi3w7
         F6dNCWh52XKnE7opwywmujYhRlaRoWl8MQZfFZootXzCZIeuzXjWNtZ7+jFECRv5HR2u
         NCck/yuFe+zb2hJiYrP/fVu4MWxdH3HPf8BTDp6O/Uwu2cq7zrIUV6Ap1+zpF7qu6pAE
         ffDjC3li9AQm710NaxxHgtbdLPdKkssQ4+MS2P01bypennhIoU9fFsf5Baad0W6Xfe+E
         5729C8ix2L2zgtDU8PaQbhFJiCMuvUVT1RSwtpgyhJjPpZGD/OPV24joagymF4QerPFK
         5btQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775740417; x=1776345217;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thX5SXaE3mD+a0diLvIMvEAshYt0m0xPTALXqGgynRk=;
        b=kymsYvGXreth/i8u2IonoRCgEfL4wsoAUFCjetaDUVhL6twLGy8A0dbMomNTXXfTBa
         rHBGUFxDqQylBYX6UcXXC0XvkIR9Day3NNTwakohr8SQ4S7wpiDm/uMvbsWPSzRobgxt
         FztbQ9XQXbIflhT/YAUAL7FVi2UynJjb05m/UnPmWwEISVydH4BNQq9NH/lR70UgBBi4
         UNGgFjaBcbFvbgXBNOAMR1i+vaKTE5PlnkjhUI9UppnG1+dapEga9l/saWrI+5zKBvHg
         mcHClf1eztMpLrLtgAWZh1taKB7NzCpzros/u0pIokrrNRrJz8H1YBMqT/WAAwbmVjWZ
         LkPw==
X-Forwarded-Encrypted: i=1; AJvYcCWQt8fcDyap0VZPTdgDypNjUTlnQVmNCegp/10tx2qtTc9bNz1mj49nrmwU9DmtxR8oFP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8sIDioKjjio4cTsHwGnnLpDXBxw0MWgJRMXbNQ5oz4+fdNR0J
	QYUHhzZ0jizddCbmZHfxC8EYv4Z+NB5fgH1QrQqtrDCiA+xh9VEL0R5dTuI9gxO/3QdtEOnaef4
	QcYm+hcRcb6CV5bdkGQLiiD/XyU9F22Q=
X-Gm-Gg: AeBDiesY9AKJtEiONotOgIhx05vD76ep3eWHR7s1atnAlEewNVGsAeqwR07WlqjZft1
	U5aH55mlpQtFWWj7Z04ltBZBzyhY6KDyxrV+7GWLJS9dqWEJarW9Z6+ULkv196TlcroOVpyv31P
	PKovsJz/CX7ay7RczXeiWhDqGn/WEVb0Hglu+zLjkqaJKRSA/T3QPIuDrFU0WgfYnQsRohMA3q9
	xF7z54X5Le6dwYxTBXxjqiudtVDsgDTbscT7IXrlg7A5TQWgO1m+jhl/RNpsVdzJINsWuUViejv
	xLQVWniYc0krDxe6c+zf4tpPkB9wpfqmo70pOihtJQ==
X-Received: by 2002:a05:6102:c52:b0:602:ba51:5235 with SMTP id
 ada2fe7eead31-6085e8af2e8mr1993710137.29.1775740417036; Thu, 09 Apr 2026
 06:13:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 09:13:35 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 09:13:35 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <pull.2264.v3.git.git.1775714492944.gitgitgadget@gmail.com>
References: <pull.2264.v2.git.git.1775668134796.gitgitgadget@gmail.com> <pull.2264.v3.git.git.1775714492944.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Apr 2026 09:13:35 -0400
X-Gm-Features: AQROBzA76qhPmgWvpzBmWW0r7Tps8DwwLa0OmFeDCHp-h8ppRJEZbnA3XP8S5MQ
Message-ID: <CAOLa=ZRo2qWES4XW3UuDxe1Wjew_z7PDy48qQdsjQzD=G8E2ew@mail.gmail.com>
Subject: Re: [PATCH v3] repo: add paths.toplevel to repo info
To: Jayesh Daga via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Jayesh Daga <jayeshdaga99@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000c579b6064f06c879"

--000000000000c579b6064f06c879
Content-Type: text/plain; charset="UTF-8"

"Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jayesh Daga <jayeshdaga99@gmail.com>
>
> repo info currently does not expose the repository's
> working tree root, even though this information is
> available via `repo_get_work_tree()` and
> `git rev-parse --show-toplevel`.
>
> Add a new field `paths.toplevel` to expose this value.
>
> While doing so, document the correspondence between
> `git rev-parse` options and `repo info` fields to make
> it easier to identify missing or future additions.
>
> For bare repositories, this value is empty, consistent
> with other non-applicable fields.
>

Don't we still have to decide how we want to support relative vs
absolute paths? [1]

Also seeing that you're a GSoC candidate and this is part of the project
that you've (and other potential contributors) applied for, our
recommendation is to not start working on a project before the selection
process.

[snip]

[1]: https://lore.kernel.org/git/CA+rGoLfbzXqP1Tw+94jMmWcSGPoefMv5E_fvwriad-O5CUeKHQ@mail.gmail.com/T/#m1e2b69b6b097c42b06088349947e43831cf5988f

--000000000000c579b6064f06c879
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a37ca238e801ab98_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uWHBmMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meW96Qy8wV1RwR3g0LzRXeG1GODVsZFQ2Z2p6V3ZoRApGeTlMWUZaa0E0
NktRUEY3N01uYTJFankzRmhJeUl5bTlGYVNJUTNiMm1JdFNWd0lNRTBvRlIvaTRseHh0ZW5BCnQw
NzlmRTJKZFFNU2QvQiszRkRBdHRuZEJrZHZxelFhaGc3Zkxqb29wM1J1YnpHdzVlTlZ4UEZWMXhx
WkNoWEMKR1R2NTk0dHlhK1hFSVEwT2Zub1JUSXQ4SG5RVXhzbkk0Q0FCbW5ZVWFibFRUb3FDdjl6
YUhVNnZteWtPdkJUcQowTXFqM2VMNXkxTUdDbjV0NXp0eXlxTTZQRTJqa3dVV1Blcjl1VG1NSWgy
T2VKcU5pY1BVVURBc1l4cHR0U2o4ClBZLzFzcFJickRMZmlYQXlWV0lTVDl3TjB3dDYyZkxna1hM
SlNZQnNRNGgvVjcyWEl6dngySHNIWkxmYkhTWXQKTkJJNUNvNmVvZlVhN3hmRWRld2ZHMmw0ZkZR
S014a0puVTZTUC8yVDdGcjkwUnIxcE1KTzExMzZKRHF6bFdnQQpqTWVyb2FaWWxVY3puQndEWnVw
VEdNUU15YWFTTnUyeWFtT1pHeUFRYlF3cUg3SlFmeENJak9hWVBDLytlblVECnRNbTVhOU5za3Bl
RzBpMmVPcm1US1NRcnR2RmFwbDhyYXI2SjB3RT0KPU92cC8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c579b6064f06c879--
