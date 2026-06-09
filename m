Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770083FB072
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002481; cv=pass; b=GKS5C/ZvVvixgPC/mnOxBAcW32DxAEy/jmloOUIq1sMlYxdobgqD9KeuooenQsRRJu7w11xC3PDYI8PXfory5GUE0WY359MAowaaZfWkkvdN2MLMNahugQoLhHDabHczhJ+rt1rzf2VEkTqnI6DKm34oijBgaVyoQfdLFPnr8Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002481; c=relaxed/simple;
	bh=jyM9rRI6b6uvz7sUcsE2j+Gr1eyf9ZIVs3uk3vJSTfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HfX7L+23Uqcz6yTF4zx6Kd7WdhVOjoUAsOk+VkVUIdWz76hQQiUvbY69rONLpscYZzROjbu7w0m/2fAeEDr+0eAv++1n7XqUCP4FpKMXttk6nLoFj2Q6LqJUVdLM68c2uNttY3kLSlL3rSZbaFHC1GXhHjjs0yNkxpcom1H5jvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ryw40xhZ; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryw40xhZ"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-441080fd7b9so3366159fac.3
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 03:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781002478; cv=none;
        d=google.com; s=arc-20240605;
        b=cGCf+J/BVm37CmLdM7P5kHkw4EJ+H0gXkUM9HuYZkUfxJ2YjkpTNSUA5FvIpv311MB
         XU5imTA1EKdnINZY14KEAfMZhxKroRIEuQRPzyRuAzMG3kM8rrql3XxYFMAiR5WsnCdp
         SXdFEPYN4+XzIRJ3pnQlALwgFRDyVL9K2pPGVakEPOtWzXfxMiWGx0OvtSB7jzTe0yDL
         5mCvgmX9mkzNl5qNJDOfWI/JS2EaUAYUCftdH0Zf3EWbR8+lV6E64ePVufiX2in6+VwY
         4JXSHsUjpzRSzAmvF/d+jX7D2Dq/0hAaZ2EzZqamM/ncoUb2Pg6kMjP2/N6THenQq5gt
         PE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7zpc8M+R6CDVSKKvKsIFCa579CYQ3QjUmhMtoeGgIak=;
        fh=rHIRI8tvNIazrMhntkidDQGrAFHYVLuXLalOS3XgdyY=;
        b=gciiKXyLM0sK+TRH/qOx7pY8nw4bpRLViTIXwEHdXS0E93GOZOvvM39uiOsKjCiytt
         /d1u5kNZ4GVaZjyy4I5ZC265dLqjHrh2qdI2T6fc3l+WPKTU73dywyghIbFW3xc1b9xG
         WoAI3ixrHXiTb0IGmVOHS/VEqMrUBjP531TxI/LbGKvSUqRhMc92VaMvOeXZU4O7bLRM
         tYrmESk6NeyfHx1u6oLtskaS9iT0+CE2CTRdZbFg90Ao5y4g/OuSV2aiBRvRAis6Q7aY
         WaCkg4s+bF+mQzGHTAqRwi/YVYRJgPAwrKzU0cI13nRwtVpzi8swej+lCy4NCor+KD5c
         PDFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781002478; x=1781607278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zpc8M+R6CDVSKKvKsIFCa579CYQ3QjUmhMtoeGgIak=;
        b=ryw40xhZHNQrgAnQ+gfy07EGiVNr8l6NVRX/VhslOpFMJWDG6SJpQAx7dGUsEYWm72
         xwNDc+2Vbg0QPp5yREdZuLT+3A9a5d0ORyj4kusa7a5hpZ59KClfmQYdcFJpTcVs/iOw
         mEWOgxGPjyJLhsQxSxXWf4UyXAgqYOQs+SjYkForJAV12CMX+Tz45wf8//tb379IQO9g
         tUrsu2Z9Oe6k9xTSzjS0HCyZhn5VSBYUvR0YwqcvvUAdzALKAGfo5hcFX5FzRPS2suz9
         M2WW9e/v1nCbAfRzWBAoN9/kIUzMAITWmEZFU9iGPpVV1vKEis8rXA/eMiP3IBZAHORf
         nTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002478; x=1781607278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7zpc8M+R6CDVSKKvKsIFCa579CYQ3QjUmhMtoeGgIak=;
        b=D+OBSG4VvKPqmuCNxzwT1PGOXTni+4b3FAS/qzWH8n8w/4gDdXgBuEwSq7Tj/YY9ox
         Ca0Mlm+m9bY9chEFbUsLL/lVpNzyVSTxHXj6VWNk9vMpzujWOf1r/xTcAKDoCuv9eIIM
         0TOK2jznLeOeeSQbmArSYcS9YGR9SNAaCy0MbEHApcz5QUePyQM6/lfoxLmc+N+q+TJG
         +NtksLISLu7vby9HMXIkZj8U1M9mIg9SSVqGpNyl5OlOkBljxJxAhNcy6KwyaY+1Od0a
         yd9PW6kXfpnBeOumTrY3R2uS0OMlYISJyZs8IxtPZqO1RuXWPd2fpzzOZ2MDo4AAHebk
         yfjA==
X-Gm-Message-State: AOJu0YwjbCK65PKFFD70JdPxORSGTes7GTYVESwuAjOGfxF5WCtIfZU1
	rbiaHs2NQ8I8KB8O5PwZBYMdyCge4SbsrHJDt0naxrCiNBrP5nK0WTPINg4PWCs9BdsUcK0Lwhh
	xMN1Yo/O6ISkZO1SKC2a+W5/kH6Q8iPE=
X-Gm-Gg: Acq92OGM1MQYsEYIGNyZ0m3rQEUw02LT3wVJl/v1Vw+V/bB0bpZPsLvMe4ytM2aIvkX
	LSPOB9DkFcO+KWLB8A+V2HHbH9X38p2sad2SRWVQ/9FuDoztsr1/zTotI3BEIbL5xpFCBHkbeMf
	maOgBKfLqufOCiFPCVSki+16R19qOj3S26wRRrvXoeY9zNC0mNhKxXy7ai2AkoqO4teR7UuSDvZ
	4GJNMUkFAM+ivqYIcT7vwWovg+SwjiapzcW+L9ediHxvqVUlgKjFdQF1AOAIKlZZ6v1gTbRO2J0
	q82RzhzHIcWPiCMP+tja0556b8iGWwayqriL+ndUt+YuzgiQyvWAa+ucqcVTv7jBzsepJrrDbz5
	rPxw=
X-Received: by 2002:a05:6870:8326:b0:43c:4740:54aa with SMTP id
 586e51a60fabf-4413da3029bmr10354101fac.9.1781002478203; Tue, 09 Jun 2026
 03:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606143412.15443-1-cat@malon.dev> <20260606143412.15443-2-cat@malon.dev>
In-Reply-To: <20260606143412.15443-2-cat@malon.dev>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 9 Jun 2026 12:54:26 +0200
X-Gm-Features: AVVi8CdyrtYXLCwfnTDK_DOmEgq8KPgGSp851bzarLb2gA-V8D_3_D05UkJmpJ4
Message-ID: <CAP8UFD35Tiy1_fqpjq8P-z=ZhzR3MTiThqfCs977652umRoSEQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] environment: move protect_hfs and protect_ntfs
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, christian@gitlab.com, phillip.wood123@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Olamide Caleb Bello <belkid98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 6, 2026 at 4:35=E2=80=AFPM Tian Yuchen <cat@malon.dev> wrote:
>
> Hi everyone,
>
> This series continues the ongoing libification effort by moving the
> global **filesystem** variables, protect_hfs and protect_ntfs, into
> struct repo_config_values.
>
> Place them within the **per-repository** configuration structure
> aligns with our goal of removing global states.
>
> RFC Questions:
>
> 1. Should we keep PROTECT_HFS_DEFAULT and PROTECT_NTFS_DEFAULT
> in repo_config_values_init()?
>
>         void repo_config_values_init(struct repo_config_values *cfg)
>                 {
>                         cfg->attributes_file =3D NULL;
>                         cfg->apply_sparse_checkout =3D 0;
>                         cfg->protect_hfs =3D PROTECT_HFS_DEFAULT;
>                         cfg->protect_ntfs =3D PROTECT_NTFS_DEFAULT;
>                         cfg->branch_track =3D BRANCH_TRACK_REMOTE;
>                 }
>
> Or is it better if they are used anywhere other than in environment.c?

I think it's better to keep them in "environment.c". The
repo_protect_ntfs() and repo_protect_hfs() function I suggest adding
to "environment.c" in my reply to the patch should help with keeping
the macros in "environment.c".

> If so...
> 2. Is it worth introducing a Macro or Getter for safe access?
>
>         ((the_repository->gitdir ? repo_config_values(the_repository)->pr=
otect_hfs : 0))

Yes, it seems to me that a getter is enough.

> The current approach looks verbose and lacks readability, and
> hard-coded 0 and 1 are used as fallback values. I wonder if a macro or a
> getter could be introduced, for example...
>
>         #define SAFE_PROTECT_HFS(repo) \
>                 (((repo) && (repo)->gitdir && (repo) =3D=3D the_repositor=
y) ? \
>                 repo_config_values(repo)->protect_hfs : PROTECT_HFS_DEFAU=
LT)
>
> ...to improve the coding style a bit. Although I am aware that introducin=
g
> new macros is generally frowned upon, I would still like to know which
> parts this might make difficult to maintain.

Unless there are features that we really want which a function can't
provide, a function is better as it provides type safety and is
usually easier to maintain.

> 3. Note that Derrick attempted to use get_int_config_global to wrap
> this kind of Filesystem Level global variables. This approach bypassed
> struct repository, did not actually eliminate global state, and the
> reviewer politely rejected it. Nevertheless, I am still curious as
> to whether this approach might still be inspiring today.
>
> https://lore.kernel.org/git/a42dd9397d07b2dc4a0d7e75bfe1af2e46cad262.1685=
716420.git.gitgitgadget@gmail.com/

To help your reviewers, it might be interesting if you could already
tell why this was rejected by Glen Choo (who reviewed Derrick Stolee's
work then). It seems to me that Glen said that using plain fields in a
struct should be better as long as the fields are always initialized
during the setup process.

And it seems to me that our patch follows the direction that Glen suggested=
.

Thanks.
