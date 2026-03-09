Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF39937BE8F
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069456; cv=pass; b=Qh8XwoPAGgu+P031Df61m3S7SPSXOAWVmzM3G4Hk05O5/rhwodDnNtHw0bOjOJPy6zNYnVuumo/puTu8XnOoWsmSV5QMDhHFqWNuZOT+4TxOg6Ru7RkDeBqOT6yFmtuDOrYhCf8WYMUuZ/nx2eGISKaYc1NZx0TfUVYeFpMQ7ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069456; c=relaxed/simple;
	bh=WPuFw9a0qwA8QUDwiVqjWX0ecpyhsoz3ElnK46NVAKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svMlcDrqN5WPrNHPgED0iyokCuvjQlnI9CRzyI1UiduwE5R9w15AJCh3CBY+Yw1Ym2z7fDcEMWGBtYjfJeVNV8Inf/9+80afh73E077W/MYcPevxM6G27cHvaMYtFyFUIvpt5C9Utnjo6LOxhkQPPDnI3Csy+DekF1rZSJ+nzQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQJUYm4X; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQJUYm4X"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-414ffb4c0a0so5627636fac.2
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 08:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773069454; cv=none;
        d=google.com; s=arc-20240605;
        b=h3kl18w+E+6FupBwtgwU10smaSZAAdZYj/NKS1rhogDzSkVBtpMZvWRjY0fzVSPsmi
         9I1kq/iKNWmLSaIXdezt3fcrzW3wiIsd+LDRe6xAeJY8Cw2m+W2nLr4WgNjrmQA8alMM
         WnXdLPSuaqEAaXcEsViZ4VLa9qfujmfYJkR8tNdjimQq+bBoiuFOsp5ieMLqYShIb4hc
         G1lokZZj3Sgd+QDsNTxfFP6WL6Cy5V5PUR/8/zvhPER6QMsWqv31aipnONDu53YDAyDO
         CqhcDp1cqxmaXIPlRq8HdfpZW/QEnSg8DKAZiw4+bdFctUmmih7Jrx4yL88tnVqG7XMe
         bFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0L4MvuwYoIlJhkJseW+gUNYI/yrRvglK5MOF88JYS58=;
        fh=uuxq4n9GZ4x6inlwcR7LViBjER9uyDaf1EAY7V2/dH8=;
        b=GeXsWkg7leLrPAsaYPfY7a4DufcKI4+jhECsWgiZkTJ096nz8eHIqbJFYwHhJOFc9O
         EmfzJvV8L+oJcek1XgN1rM0Jx2SyCiEbVRqJoVXEKOfa24S8uEFBpHO12/j9oYkscdN5
         RpGIRq7eEwpLQg4znUm2hT1zaYN2e1VSsKnpDC5Kv5ILbFFTNCeswgIKzPV2AxWh3tnX
         3oMhyRgYlXu6+T08Oa5nNO/EhasOaIAKxvtr37BMhtf4e/rcfWU8EgLlUwcbRiNxIPrc
         Pt0iXWocDgbdiw5yCE3kNWn3hpapjfnd9m1yem7zxBIyJ3Nl4QJFbSqsIz59iUL2a4FO
         OR3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773069454; x=1773674254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0L4MvuwYoIlJhkJseW+gUNYI/yrRvglK5MOF88JYS58=;
        b=cQJUYm4Xx/d9uIfpUYGl9dEwX9BSeSY5wgAR27Rfh45HXSy3bqL5qMjG5IDdO8lbfS
         4pJnu23VOPxnBabBgk13iuXcmsN4ABOnGk/AVWP0jLsPGrDqPv3X1ubdXAy5f05E7oMs
         AvJNctVQPcxIMWpGAKPbIG9C8GNK4DFiSG7LNRUKXaudlXbUAGQjLj+8H+r8hUdGMy7T
         6XB9InhR9FePlpaffm+MXY45vSS7WV1AFms4eaevPPR/NOkHYL7zEgvnaJUUKrRKrI6I
         xGK5RYbyNKpXok84PKTYRQz02Q4Pbk0KBo3FNlhcukGYzfnS8FC9PLbKWsn0U8XULrvr
         PMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773069454; x=1773674254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0L4MvuwYoIlJhkJseW+gUNYI/yrRvglK5MOF88JYS58=;
        b=PEeDfQNbF+vl2jFRIaZMV90AFlcZUdMN0gZly03ybV7SmO9tY0OFAwLT1MSL8ZKLor
         ofJMa0BqSeVf240TJkMaP8f37OamucgjnSUVxfH4R9qFfrcvoY1PiAK8K+O6kk4dCHur
         C49fqfphJhLi6dcAPwET0ioUF8ngpqSId6yaSMh+UF/aZXDRGZm5bRcFNBDhbADWia/M
         B39srowL5om152s0D0rRhfOTenC369aQKohzuxDP/ds+5hYp/eFqwN0m7Gww+HqpU5n8
         0V8KCLE43adzZmJg95I9c3jGRRAohLBhZ3ESJYrFXOlWlIQ1TpR3G4DzsHhKU+tXfeCV
         R+Tg==
X-Gm-Message-State: AOJu0YwL1qIDhLm6/Hj7M50PgS7t9ggue6cFYDbdG5/nszHALmWpLehS
	EGOas/H90OkPDw7VrUTikRvbespdl2uTBmVHh4YAtThuSdXZygbcXepNq59H5FVi4XS9O8i37Ku
	4RGd5J7qr0tte73qsSHmpqfsmjVHvSfo=
X-Gm-Gg: ATEYQzyBdHV483WIqzDnUeIgIheIpO0PZztWXzFnMtIjBKNCR5P7Yh3nuJtlnjhFCve
	7W8qmvQYkJqHe8WrB9N7JiDypllqMx7sCoA0hibrKo0d4AunDDqZmHFMb7CvCnsnZ2eA4HaaTjr
	T+5D+pT7Q8WBb5+Pc39F0E2EpQ8cp+pnnJNKF26OvmQMYRqS6bjpjGSR8zMvKvnYJTLCxxX017c
	1FgdHYSTKvm74Gw0jwGHtIFHYmmI+KKy/d7QNH8zJE8tRgG1aoYrxnGsgZoNr4FANPidhdMlTkt
	3hqNNwHh20LPD9j3qGidRyWhiGt/8PkG4HLJmBPVgpk8C2yOOHAu6FWV6If6FLykx9TY
X-Received: by 2002:a05:6870:e18f:b0:40e:a746:1f6f with SMTP id
 586e51a60fabf-416e4084167mr6706576fac.28.1773069453752; Mon, 09 Mar 2026
 08:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa1cn0_ATfh-uRE4@gmail.com>
In-Reply-To: <aa1cn0_ATfh-uRE4@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 9 Mar 2026 16:17:20 +0100
X-Gm-Features: AaiRm51DmX5xHOj_6YpqQItOawE6AnDSnsp_eLpMA7nVisDnQAFhcenkbPIXcVU
Message-ID: <CAP8UFD391QPtk3Mtt5z17ivdVMk9EEWZuKhVtt7X9Twm7WTpRg@mail.gmail.com>
Subject: Re: [GSoC Draft Proposal] Refactoring in order to reduce Git's global state
To: =?UTF-8?Q?Burak_Kaan_Kara=C3=A7ay?= <bkkaracay@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 12:40=E2=80=AFPM Burak Kaan Kara=C3=A7ay <bkkaracay@=
gmail.com> wrote:

[...]

> My Patches:
> -----------
>
> + (Microproject) t2003: modernize path existence checks using test
> helpers
>    - Thread:
>      https://lore.kernel.org/git/20260208202809.270523-1-bkkaracay@gmail.=
com/T/
>    - Thread v2:
>      https://lore.kernel.org/git/20260209112444.1268765-1-bkkaracay@gmail=
.com/T/
>    - Status: Merged to master
>    - Commit Hash: 168d575719d944759964e004d17a3282b0f883d5

Here you gave the commit that was merged.

> + [PATCH 0/2] mailmap: reduce global state
>    - Thread:
>      https://lore.kernel.org/git/20260219125954.3539324-1-bkkaracay@gmail=
.com/T/
>    - Status: Merged to master
>    - Commit Hash: 2d843a2d3d6c2d5e7861e6aa99743d15d36746b9

Here this is the merge commit. Two commits were actually merged.

[...]

> Technical Approach:
> -------------------

Before discussing that I think you might want to summarize what has
already been done for this project, especially the recent work by
Olamide Bello.

[...]

> Availability:
> -------------
>
> I plan to dedicate 40+ hours per week to this project during my active
> coding period. However, I want to be completely transparent about my
> university's academic calendar to set realistic expectations.
>
> In Turkey, the university summer break begins in July and ends in late
> September. During May and June, my schedule will be heavily occupied by
> final exams and major group project deadlines. For this reason, my
> availability during these two months will be limited to around 10-15
> hours per week. I will use this time to stay active on the mailing list,
> participate in architectural discussions and submit smaller, preparatory
> patches.
>
> To ensure the highest quality of work, I propose utilizing GSoC's
> officially supported flexible timeline. I am completely free during
> July, August, and September (with no summer school or internships).
> During these three months, I will dedicate 40+ hours per week entirely
> to git.

Yeah, I think it could work. Thanks for suggesting this.

> Community Bonding (May 1 - May 24):
> - Analyze environment.c and create a detailed mitigation plan for each
>    variable.
> - Discuss the plan with mentors to identify potential roadblocks or edge
>    cases.
> - Submit a patch about 'enum git_error_code' to start community
>    discussion.

I didn't talk about it earlier, but I am not sure using 'enum
git_error_code' all over the codebase would be a good idea. Perhaps a
few functions would benefit from that, but then the enum could be
specific for these functions.

Thanks.
