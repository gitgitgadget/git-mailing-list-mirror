Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A744C8E6
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494171; cv=pass; b=N7OMP7gGV8LN2HRyarOriQF8CwfmfgTh5yGS33B5tKV5fIBrYfCfR49/XBciL8RRWC/N0c2P9cIUopIl3tWYUfdH/8OSSsOT1YPc6gISEbRG0NeY+CLFMP4PaLF1VoeeUD72A3JfU+iAEZSrm8RMdms5hOfw1uAjetPRWJfpqFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494171; c=relaxed/simple;
	bh=hegt1Adc7qNcDEwsS1vLJyqL2mgyrEVWSzCMaBgP0I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrqLnomv8JCUB2MQn/J47YcKwY2fqEs8SS1DoCcvnMSuYXzASmEciPzI+iLbOoxJAp5ZE1uDm/ZPgH3AL/3kh6naxdyy1svYt4dO37wyVvEWWTQf+PNa7dvW6hx3XnavzrZoYkA3KcF8cIs7nd7DJjZ8sxdD+QiXQmhARJLe0z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BN9hiFj4; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BN9hiFj4"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3870df2331aso16803161fa.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 01:42:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771494168; cv=none;
        d=google.com; s=arc-20240605;
        b=OsVFBoyylIaQjoWIF87AYUEvHLNu0ktQtEY6+gnCPtjk+I65yVpgb3tLHaH92UwC9X
         RVQYBLDhqc40Otm39tZ7FJY23Zs8Vd9AUCXJ1qGL2Ihzexb2i8O/+WC2uzdYfDrLH1fp
         bwdEsDN1DIOClAo+i9jz0fHwi484NA7AOnRmOrd0yMnyoEPhBHaYFy7+6Vu7MZogBNcn
         67Yi9UJqzp8tDlh5it/jtmVkop3bFN+CZW8dYI7VrMa5XmwyDr9P+I/57/521JrLpmK7
         k8NlSm7IAadT2BhZJMno/yjR98pYWjdDhmq1ey0IuKcYNdFFuSrZLkjjua+JEfUAsv+o
         YMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kBBbv2sCEN8gO4uU3pmGWld38srmhuDXTgCy6QmkEec=;
        fh=m/rHgqQaRW9AtscS8/+NFzZHS/ORGFIgfvPAhTT6apo=;
        b=lup58GuqHQTDPy37A7d4SYbdgrLxGbzkhy7u354BCdOI5vThLznPDvmlYfjDC+3xyj
         QVC5MdbyDexCFyem4iUsw7K0gZcsPhq48mwOL/XgxqOf60Ni+9D9j1GqSQPtl2UMWIK+
         QlmV+C5W7kW4sGiiR5JLq7xibhgOnyBDV+PV7fWfZzh0i/wPABtRAtd8ya1NdSXtJttw
         UbxRgvOy7UeP/mDmI/c9MayDa8jg3ephpFFDDt9lRgw5mYtFNhptADTV3UqasNUBPFji
         0vFehrsFkYDdyF5uBJ5olL61M1sHa5UC0Qt/0qPh+TmogL/hN/dmubYN2GjzF5moY5ct
         ONHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771494168; x=1772098968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBBbv2sCEN8gO4uU3pmGWld38srmhuDXTgCy6QmkEec=;
        b=BN9hiFj4Got6z3etNdSFLmYEA7T4syckru+nExWRGJIN92imNBP3RO8jbsBS1DqqQB
         IJXzK9/LPCsN70+WCw6c/qHZ5AqIgJ/Foqx/rAygqVF8yiv5dlBuaElMTuSsI/kO+RVH
         ttNK+EEqIMnRDk3uoVFAMEEAfn0KvOpdxhRJYq5RisS/ZKdTFSI2uy5B8XmwEnM4yrT+
         b5ifYzwJJGm7WM/lRReIBhUs/+2PA1JAzG+oL63ADc2dpYy1Ps7n3Zy+lj6Eh0NvfFO1
         3bn+RUxacrDjU/3nZthuGAr4zpF7+FcWDxl0Gaifvf2jlX4dXngM7eHK4KTsL7/ufsiD
         vgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771494168; x=1772098968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kBBbv2sCEN8gO4uU3pmGWld38srmhuDXTgCy6QmkEec=;
        b=X6d8DRs2iid3XNgU3/THCcSThV/Zcm1WTrAEVbJP6h3AClVJS7w+xz/i6SZdFcjuiv
         EuCS2hNfwEYxtjP3kxrnDsu79mbS3cLzJP31un8OxUxw8aFTehdl1BmtTVwNlmSA7Wtc
         T4M0qtHpeI7o5U+APQqLWE1U72Bz8+iIbprI+pFGgRyKBYfa6eBk1xyX714zDBKCgFQO
         7PGWcY2PLE+yo+oIVo3WYrto9MsObxxS1xblBbl2x9iQXi2/k1CIgk7JHtzDRlPyhpDX
         PMn/W0TAU39/8DqXB/OiSAW+mD3VJ48bBmgHe5bai6IgD7xrpDQZCdoZwqqx8GAeyMV1
         pe/Q==
X-Gm-Message-State: AOJu0YzLq9V+dIJEKubhv91Mxl1+g54Xj8JsLqPQuu2pOELnIV1X7XSf
	yag/hCqG/SLqN6Wm9rz+WJe/8pVrFnCp+auUDTGArsisypvG9YKyQ5wL6eMylGyDyNIt7O6j2Ox
	tS+hZEgPleEKi3fDaArycxLG0VY2HrERok0OuF6JQbw==
X-Gm-Gg: AZuq6aLgPPOf9F1nRFu9jMPGfEmepjJjSEAS3YATF3zmgxrD8CKqnXHupV4FAiiE0Kz
	zGxQHR1bQGSfNfOx0Q2C2lK6xA4oJvU9U8JIHz5rc0oSnGfX5a2iF4nT4BzgetjcHMo9KUwAwDz
	UdNf7iviZ02FpwYiRg6ifjUtI0H1J30JKc0b+v2mRSMeHQ8BDK+IalBI1Ui3OCJHbilpohcoj8q
	Yr8liPtEt5hc32zuuUUMVkDynHPZS8NoauFlfCGxOeP5fU2nMF+gisVq35RbGlKmb8pccKlXAha
	56406d7e33ZcZGWhh4TkSUEGWOAw+eNEZTrQ4w8=
X-Received: by 2002:a05:6512:4023:b0:59e:656d:2974 with SMTP id
 2adb3069b0e04-59f8b53aee0mr416977e87.21.1771494167530; Thu, 19 Feb 2026
 01:42:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208062949.596-1-kumarayushjha123@gmail.com>
In-Reply-To: <20260208062949.596-1-kumarayushjha123@gmail.com>
From: Ayush Jha <kumarayushjha123@gmail.com>
Date: Thu, 19 Feb 2026 15:12:35 +0530
X-Gm-Features: AaiRm53KkX6XdbMxd1LMhGy1lqtPZdYMiVGGx4GIRHQttz3VobnW1nCwT6U5GOk
Message-ID: <CAFNBzOeUcSYBfQwDSV7ZVrAdDNqNohmVG=JuYzxQC0DgM2snUQ@mail.gmail.com>
Subject: Re: [RFC GSoC PATCH v3 0/2] Make read_attr() repository-aware by
 introducing a lazy bare state
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I wanted to gently follow up on this RFC series in case it may have
been missed in the thread. I would really appreciate any feedback
whenever you have time.

If there are concerns, suggestions, or areas that need clarification,
I=E2=80=99d be happy to revise the series accordingly.

Thank you for your time and review.

Best regards,
Ayush

On Sun, Feb 8, 2026 at 12:00=E2=80=AFPM Ayush Jha <kumarayushjha123@gmail.c=
om> wrote:
>
> This patch series is v3 of an earlier RFC that aimed to remove the
> dependency on the global `the_repository` from read_attr().
>
> Based on feedback from Lucas Seiki Oshiro and Junio C Hamano, this
> iteration introduces a repository-scoped, lazily initialized "bare"
> state in struct repo_settings, exposed via repo_settings_get_is_bare().
> The read_attr() function is then updated to use this helper instead of
> is_bare_repository().
>
> The series is split as follows:
>   1/2 repo-settings: add repo_settings_get_is_bare
>   2/2 attr: use local repository state in read_attr
>
> Comments and suggestions are welcome.
>
> Ayush Jha (2):
>   repo-settings: add repo_settings_get_is_bare
>   attr: use local repository state in read_attr
>
>  attr.c          |  3 ++-
>  repo-settings.c | 12 ++++++++++++
>  repo-settings.h |  5 +++++
>  3 files changed, 19 insertions(+), 1 deletion(-)
>
> --
> 2.53.0.windows.1
>
