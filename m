Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D001239C648
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940437; cv=pass; b=gNY/ozkmL67HMXP5+BmJGkd7b/c2pFNW3vrE5dfMGFbuWNvEAUDfAIg4FfUZoZfaCTQIEaEDb5NzZq5hfI9z//tXta6nnmwOnEwCtLj+GoRkhDYEEzcnqTkVH4HKOocoBX/37e18o+3LKm85w4uSvK5XD/q9unKCks6dvlsf2YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940437; c=relaxed/simple;
	bh=ZgIKxfnkGbV3YKDIYgG0KnnTG7Ok+7j3TmNWnwr7ShM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qs6fFOXYqD0YIVi+sep8li7uc+dJ4p+KVsFZBI2kYok+2PzgYgn2y8eoS1oLnUaNRwpxN9zznevWpcuSgPFONYZxCmG8DldJPN+3fLe1VUuVHpEnZfYz5yNpfo6a00ZXPu5BqpVlnyTHKnf2y2QYrI26cTjfQxIlV8SlVLKuzHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOLTWAt8; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOLTWAt8"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5fdec2df71fso1263228137.2
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 05:40:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771940435; cv=none;
        d=google.com; s=arc-20240605;
        b=VIqW9OUVzu9crK9ug7P2q5ykOjJqI3nqW9XdDoQjp+X1MbMvYrn6LVJcOtDT6ufe9t
         8u5hRXK/tiNhS0fFEIu96WTMpHazMO26Yvb4zc50RzCBGvZSuhfFH/7wBNZnYYMoNjAr
         Rrg030UJJGCnl5HGnvPDcXJ79/sF1TgTmKTX+zkWehc1P85pYRb+HCVmm9b/ggXbuisx
         cwolk3MVtj0Ra12u5uko7GysqDvWWi+ESCRQufPs8fQlKrwsicWYL/B+ZZEe1ZUpSS2o
         /4Xw6hNuA1GeqPxbnqKs2IsQriPjN7zJJdmM5K3ZQ+9revQLvllDae8BMK1kHJ2jNLaZ
         bzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=xl5E7mIvZqKeZ1nXMWAygVftduYClgp8WVnfdVrq7IQ=;
        fh=XmdgZFhAZ47//cKz9C7nomoxr2GznzRJFzXN2fJ1Ncc=;
        b=aYBxcLyh/bdfct9AAUpJcWEXFuLMwfb/irN9PRPOf2qPkP4wY4wIcaKQtQuiRTCAZO
         QhHq3coWhyeP0Xvk361M6mDbSyWCc3UmyURMjhYhU8GyEyprHaUeWVt3w/DoXuq16Hj5
         Z0ZBARo01alFrE7JcqpDjqR12gob+VoigqlPFo3JDAJkyZORt3Ldlr24/1fK7VDVMZox
         jYn3tTgPTLjVtii7E/hkOMleC8TrEtU9g8nMwqxtLi7d6q5ED7hve8ulIQ0YNqCYn2m4
         R/q5tc7w0Br7jiImEItnpMzEs3QbGNqVVtrFebF2opl1V1mMZQTi8TXEzpxMM0wc57Q0
         51hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771940435; x=1772545235; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xl5E7mIvZqKeZ1nXMWAygVftduYClgp8WVnfdVrq7IQ=;
        b=mOLTWAt8w1q2sGssc3OXWKEc4r7HMX4cWBJ/YbzQp02gRfNMIvvZBc3BJAIU7ck2B9
         AemDqoM+lpD4wEDmZjTt0bT2y/Qnc0gGjxS+cez+4Y1KjlcepGBn86sjsUH9ODZHNE0o
         jsHQvLRXKn9Evyr22Wsuv0r6ZdBjnl8NGTxCR08L91vfiQnJGnbmjWpGSGNLM3dDoZnh
         lfriTZZBCY2KEmEfRzGXx4QNsp8nENP93wgyYYBvl054hALpdykMGibwwIPd+OEa2lTr
         hib4BmrQiVfKYIZGu/k/33ZsQ3Emfy92BQoSzaMhas9Hxln5VZDlmJN+6Gfw1ovLg6Qh
         5eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771940435; x=1772545235;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xl5E7mIvZqKeZ1nXMWAygVftduYClgp8WVnfdVrq7IQ=;
        b=X+Ui58a9dppGmOKYzK/9R4JAglcIXGEtDGVqCLbC2d6dzNrugRWp1KijZuA3NE9IFf
         7265xIWYk5r7FWKAXI8I5Gtd92q/80+Gpdi+KQ3HDfbsQpDon5EtYDbLT0FKfM48l+wz
         C7dliTjvorBQ2QfblhDsltptIyD4aKEo/KyA7INC81JyLuxFBjo3chVom5IEluu/oy3n
         KmBGC0lD1hO11LF1g6GnHMsVlgeR38ip2l8mmWTukMUdZPykaU2374E13OZ8gMPONLQJ
         keKwNdQchQOMQArYISXDuXHGDnAIHQG7Wv8tGytIYcIOgQS1p61fFIAVEIuK4VpJiFYt
         hapw==
X-Forwarded-Encrypted: i=1; AJvYcCV5Mhr6bVaWOaPquuUmPtLwXzIVCSz/43zCSc9zSD8ND4SrBwlnMft0nSLmCIaCTZlvfJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu2INApq/XzRqHOQp9pcwaNtEN3VHAIpGKczXVOIhZM2A8ekLk
	664fhj+PXke8tNG/DmuBB6SJdi8OcEKIXjZp36FoOzoLYmKDmMZr9SHhndXGFhRHGzYq3pPGDWU
	MRFdfIRdDf/MjhXri9dlwchlQEMGoVvo=
X-Gm-Gg: ATEYQzzqJr3BLjF5P6hswPUxUutInz0Leiq4rBBPP/dl0ATp3/nUPZLxrHT4SiS4+YI
	gry3fXOdoNe6z/7ap4FQcFflBvZLcFZqipnOT87E/wWatVZreUyBlRqaSXAs7ba7Izen0G5c0em
	2isrXFBxXy6My02F/TtfEpo/vxlgUUn09BlrwwGfWpKToZsN5wSZJQrkVun5t/ZCAz5Im0XV327
	l3YeoIfLVteLwy+QUjhjwr3iAmnxOwxGhVxrD0Yhvwgou7kKv3iRihM/Jxh3OFQagYBB+nElGmU
	Ka0h9alt2Fcz1N7ZWJjt+77+3io0WC0cIwE6Stpc1VDW6MLde5oP
X-Received: by 2002:a05:6102:32d1:b0:5ef:2457:8015 with SMTP id
 ada2fe7eead31-5feb308617cmr4611561137.29.1771940434726; Tue, 24 Feb 2026
 05:40:34 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 08:40:33 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 08:40:33 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260219181154.66814-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260219181154.66814-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 24 Feb 2026 08:40:33 -0500
X-Gm-Features: AaiRm53SI8jW8E3Rp_-QEw2fCF1eM1h_OPrdQEkx9eueSAEGipDFTiWl0tDun6A
Message-ID: <CAOLa=ZSxkgGbWjYCu4DP269LtOdtn7Tcbz+DJH1ASyrGVXvb2A@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSOC=5D_Discuss=3A_Refactoring_in_order_to_reduce_G?=
	=?UTF-8?Q?it=E2=80=99s_global_state?=
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, 
	lucasseikioshiro@gmail.com
Content-Type: multipart/mixed; boundary="0000000000002d1375064b9208a8"

--0000000000002d1375064b9208a8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> Hi everyone,
>
> I have been around Git for some time and am interested in the =E2=80=9CRe=
factoring
> in order to reduce Git=E2=80=99s global state=E2=80=9D project for GSoC 2=
026.
>
> So far I have built Git from source, completed a microproject, and explor=
ed
> some related areas in worktree and wt-status. I have also gone through th=
e
> blog posts by Ayush and Bello Olamide, which were very helpful in getting
> to know about the ongoing/previous related to this. From what I gathered,
>
> - In Outreachy, recent work has focused on moving core.attributesfile and
>   core.sparseCheckout into local structs and also to handle the issue of
>   lazy loading, but it is still a work in progress.
>
> - In last year=E2=80=99s GSoC work, the focus included removing uses of
>   the_repository and other globals across areas such as
>   preload-index:(core_preload_index), builtin/prune:
>   (repository_format_precious_objects), builtin/fmt-merge-msg:
>   (merge_log_config).
>
> Though I still have a few questions regarding the project for better clar=
ity,
>
> - Should the primary focus be on core library code rather than builtin?
>   (ref. [1])
>

Phillip does make a good point, replacing global variable usage in the
library code is indeed more useful.

However cleanup of some of the global config variables, could involve
touching the builtin code.

> - Is it preferable to approach the project file-wise (eg. cleanup of one
>   file making it completely free of the_repository) or variable-wise (eg.
>   identify one global state from environment.c and eliminate across the
>   codebase)?
>

Depends, some variables (e.g. the_repository) are spread more broadly so
trying to go variable wise might not make much sense for them.

> - Are there any globals which are best not to be removed currently?
>
> For example, in editor.c there are mainly two globals,
>
> - editor_program, which appears to be only used within the file and is no=
t
>   dependant on repository. So would it be preferable to remove it from
>   environment.c and localize it within editor.c, move it into struct
>   repository_settings / repo_config_values, or keep it as is?
>

Makes sense to localize it within editor.c. What's more important is to
understand that currently `editor_program` is setup inside
`git_default_core_config()`. What would the new flow look like?
Also with a global variable, its parsed once and available till
execution ends. Will that still be the case?

> - the_repository, there is only one instance in the function
>   git_sequence_editor() which is used in editor.c which can be modified t=
o
>   pass struct repository down the callers but is also used in
>   builtin/var.c, where a local repository instance is not available. In
>   that case, would it be feasible to pass the_repository or is there any
>   other way?
>

Yes, that's how I would tackle it. Moving dependency to upper layers is
a valid way to go about this, we do want to avoid this scenario if the
upper layer is already cleared of such variables and has access to an
alternative. In your case 'builtin/var.c' already uses 'the_repository',
so this should be acceptable.

> I have also surveyed files that use #define USE_THE_REPOSITORY_VARIABLE t=
o
> roughly analyse the usage of globals, and I could make that much of the
> library code is still dependant on the_repository, so could that be taken
> on priority to reduce the usage of the_repository throughout the codebase=
.
>
> Thanks,
> Shreyansh
>
> [1]- https://lore.kernel.org/git/7b5dd0c4-0ca0-458e-89db-621a70dac9ae@gma=
il.com/

--0000000000002d1375064b9208a8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 89e406c53129fa2a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tZHFsQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meDhiQy85SFhFV3g3U2U5dnpPNWJvaDlzNDAyYzM2ZAptSzhIYUNld3dN
MGJOcU5lc0NrVm0raDV0d1NKWWlOVzJNYTJyTlNja0wvMjQ1dWJucnlBT1l4NEJ6Z1NkRVFuClRC
ZjdJZ0JSazRENFZZcG55TGhCKzJkUWJiM0lkUlNzc0pESkNDZm9jZ2NEUlc2Yko3dWppemZoTkds
VFhhOXcKMFdNbWprUGRBKzNjRXY3V3oyRGwyaTUzeDA0YTFoR0NKWHpzZ3lDdTNoSko2SFNCcGNF
Q0h4T3pHTlJtbXdVMAo0bENyWXQydi9JOWVqajgrNG4zNjhaTjMzUW1WQyt3bVZXU3pkMUJCTEVT
ejdQNXlMQ1cxSkUzZlRFS2hJb2NECnhhY3liaHNwY2J1cWx2dy9EVUNHMG5TZ0FLU2F2RHhBa1Fn
QWhIZEJ1MjFlSGgrM2dLOERiMTE2UWJveDZVd3YKOFVXV2hOcnVybVB0dm9hUGR0anZ1QTV2SFM1
RUpzeWdJdnU5Mjk0SUpRaHlJeGFFNDZqVU1idDg3NVlHT0tUaQphdlFVTFNVZWZ5MWpDNXFKcmI1
bGIyb2NVY0d3dGtjZG5YaDd6Tm1UOVRYYzhQNE5zVGhxbVlJblI3TllXdlZxCmdlSVJjTHI1WGNO
R01zblZOQmRZeWxJV1FVQXpqWEh2bHBmeFA1az0KPTFhL2sKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002d1375064b9208a8--
