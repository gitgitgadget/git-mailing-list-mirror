Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC961B424F
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772273749; cv=pass; b=qycMekKx7u6up1JnD2sEQyOa1SY7IVpNvkk7Faa/Tt3xTA9ed4oAaWjsSexEZKDTX5nuesSoSKhCo9Ykk1PjIS4J39qlN7E/FmE2WPxz2ZIsFIzAoiJme7+vT8RusUpdk216TXWEjfO6dPiRjIZtl3oaajP8+KqkK3Sqk8iGh/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772273749; c=relaxed/simple;
	bh=rpk2KEvvaEyfbeVITE86sPre+gSdZ8L4AjevQGxyYBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEJ2SXVoZ85Zl5V7Bfp1THZGLEbaDTS2jhshrqCpqy2Pgq9cOTe30K8MZ3Z4siAecXUPrPe3WjVTfIbX2vO/xMiQ4hvSQnX5JtYXJgCz1d0f16hazF3VZYwQa39236Q24deuM+X4YOUUF21y94+shlLRRjmpVh/l7PZqELP0Yq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OixB3gB5; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OixB3gB5"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3597fea200dso133714a91.3
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 02:15:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772273748; cv=none;
        d=google.com; s=arc-20240605;
        b=WIRp9aXYI2e0NFvvwOEuKbNlYzsfrREs0Rqy0bMz2GG1bSFBW3tedmqIXqd87G8a9r
         jyBFPZJO4sp+UAsFOHgUOME8qlhavUJqCodQVycYTWXyf6aHSA/ZGu33zUsHDRf+DJis
         xzFv/NwXkTJAQfldLhvjx2sK+WdZ2M9as7Ku4KbxMvLeSvHj157nnFGfHvHMj18KvPk/
         0dn8G1iySTYVWl5PvGxiO1ReHBwXftpguZL7olJiAyyAMPXk9RpAas+E/s8UlSIK1mNA
         bKRk8o9VsgdGfEfD2Kfec5fij5STbDu2ntvYMQ/s5vdSAhfHZXGzLKEB24uqLS6GUtS2
         fJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=t7uI/Np07/itLqeAFWns+GC3zpjlIfbj/Tae01cAjyc=;
        fh=NGe3tGy7X2esKtPCxH/+uKNpmsqrg2NXtJvwKMVF8To=;
        b=PJE0/8L/7C2xoeJiyA0z37HK96uYeaF9tF2Sk5tOXVQYcoGUeWxVYevPBm5YugsWBE
         LLjB4Ke//nH1X7UWSJ4VaCZDC7DyvuYDnSjla0fpVZs7lTdOBL5bkDiXqzC84pea2NTZ
         dcQ+/lbJ+bSQKCOyG06/4QIACsEX8zYla2xt8gF8Acgh8yMAIrp484lBkUQC0b3IrqCc
         i4gyG7JSkKBJ89EYOtyD5LLWDE4oqyV9OELDhKkC0D6iOvj/jyVWIN4un8KwveG8BCsL
         FzwjCzyMYIypFRMYJiToQLskW37YWvPmxsqpTTFnZcmsfzpmylHLmCSUANehNDk3eeUa
         RAZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772273748; x=1772878548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t7uI/Np07/itLqeAFWns+GC3zpjlIfbj/Tae01cAjyc=;
        b=OixB3gB5ml5ihYxUDq+DQQ9Ws2o9a7yuZ+tFAo7xMZ0GiLAo8uJtqPF9kDtvZsR2cE
         gTbitEOQf+wAmpp5M9vYJRTK54ERBPsLZg3b1rNRL0Cj/TeatERSwZXqSpuKFAOrUdd8
         uHWfKh/2CJul5EyRr0zXecSY5WviHxZ2cCS0zZJPP+Qjc9fb9d2PfQonS23h2t4Cl0IZ
         +c1d86gEe570+Eg3h3KXoX2tRVVgPDYv6pkVnv5rEhhDrYbJHsJgK8kPzP8Fb3s3yYdr
         Fp/X+9noBb0IT4kybGdsZFvgRYul/sRXibuLwwsBHqfa9A/YIjLX9H+gaEt/LwUPVQMR
         bMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772273748; x=1772878548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7uI/Np07/itLqeAFWns+GC3zpjlIfbj/Tae01cAjyc=;
        b=wri5S769dplFAY6ruVlpm2DERBACvw+jEYPkzQfu1TV9/nyuB2AWD0zmg2pIYKNvGA
         zzvBgxW1xQzdT3ysZMaKkj+kzmh0x0HTcVPWk1p9DQgk1edf4lUTDkMuJViYYuXl8dEk
         Ka8QjFPJwPjUyc/GC5f3XyhvlZv5C4BF5ga2vsj+R5vY3U7yOj9Eq18bSzwr0vMz6GML
         S7HGSY1VYE+yahoksrYJmDkO5S00luhRO8Y0jZ6A4S7o/yMvBrzeVV0sAb1gt3KcKRjV
         RCFk5SlZqePN0OGcVR0qsw2QHM2xOh3Po21ZZW0RnTn/K+LnlPTuGiCxrAZ5fA2lsiMg
         z3Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWx/z8DK+P+YemVnWlzhFTq60dd2kp14gaarZgWQ6pWqYWxR/OS2MjpY1D6acwfMXYpnTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySXB9veSYnLaD/BieaBG9Fpr9uTg/Cf/pAu/17OyyoUFIk/wt8
	Ae5d8wucXEfCU54km2RYAifRqj395GofNr2DffHOy0hk3Q3KHarFEHJw4gzwp8FZt/JIueS7X2E
	jN6ZzfghodXLRCWODpQR8ivHO0HWK5WU=
X-Gm-Gg: ATEYQzwhJ4M6ZU0KOBJZiyw54gQ3gc9Xe4ZVZ/rPIMHrYl1ijpheXWeg0bBHvFRHBns
	Z8fTIwUiNgCUIbbAN39XEgJiNeGGyjpYFGr5uoChLGCsx6QBO/NEs5XYntUowU8jhV6KFHPRvPy
	g0A4idlaRTjse+BaW/3lWaQp7j3GiVTfj70XzAkTohCLlDoPLNYCuod2hwFz6SaTrGhrlOHjgTY
	sBgMgiKg2tlYhMnQTLGfHDp06tgsLJJzqrth1MYqdTXUl5xcavZDrrzt/qjEpnJC/TmF/zI7pww
	DXNW5sr/vzuF6Tiz2/tH01ZSToMH8QeWNWdq51sG
X-Received: by 2002:a17:90b:5843:b0:354:bfb7:db0c with SMTP id
 98e67ed59e1d1-35965ccf015mr4878204a91.22.1772273748033; Sat, 28 Feb 2026
 02:15:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227165143.70188-1-r.siddharth.shrimali@gmail.com> <3c854150-2efc-4f5b-8a75-bb40808babd0@kdbg.org>
In-Reply-To: <3c854150-2efc-4f5b-8a75-bb40808babd0@kdbg.org>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Sat, 28 Feb 2026 15:45:11 +0530
X-Gm-Features: AaiRm51FhuR2gsJS9ktHpLMqSHp5SYPf0G4joCQ16ND7-XiVPqkcA55N8QuwRD4
Message-ID: <CAGWgyh8CnJSk53rXFcFgnM++6o1ZWTLnRzXhY4VwkNyY0-W+UQ@mail.gmail.com>
Subject: Re: [PATCH] t3700: avoid suppressing git's exit code
To: Johannes Sixt <j6t@kdbg.org>
Cc: peff@peff.net, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Hannes,

Thank you for the review!

It looks like our emails crossed paths; I sent out a v2 [1] just before
your comments arrived. In that version, I have addressed both of
your points:

1. Moved the git invocations out of the subshells and replaced
   the logic with 'test_grep !' to properly catch exit codes.
2. Restored the trailing newline at the end of the file.

[1] https://lore.kernel.org/git/20260228070020.89668-1-r.siddharth.shrimali@gmail.com/

Best regards,
Siddharth


On Sat, 28 Feb 2026 at 13:42, Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 27.02.26 um 17:51 schrieb Siddharth Shrimali:
> > @@ -536,9 +544,9 @@ test_expect_success 'all statuses changed in folder if . is given' '
> >               touch x y z sub/a sub/dir/b &&
> >               git add -A &&
> >               git add --chmod=+x . &&
> > -             test $(git ls-files --stage | grep ^100644 | wc -l) -eq 0 &&
> > +             test $(git ls-files --stage >actual && grep ^100644 actual | wc -l) -eq 0 &&
> >               git add --chmod=-x . &&
> > -             test $(git ls-files --stage | grep ^100755 | wc -l) -eq 0
> > +             test $(git ls-files --stage >actual && grep ^100755 actual | wc -l) -eq 0
>
> This doesn't help. The exit code of $( ) that is substituted into a
> command is ignored, too. You must move the git invocation out of the
> subshell.
>
> >       )
> >  '
> >
> > @@ -574,4 +582,4 @@ test_expect_success CASE_INSENSITIVE_FS 'path is case-insensitive' '
> >       git add "$downcased"
> >  '
> >
> > -test_done
> > +test_done
> > \ No newline at end of file
>
> Please keep the newline at the end of file.
>
> -- Hannes
>
