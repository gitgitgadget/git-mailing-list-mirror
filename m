Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794081006;
	b=PFAXgGkr+pTgdWQZdO/4QtgU3CJ8Ax884cjA/Atq+JakRzhHnR26EFspwvwIgV37WDrJ
	 ESc5nVt3WJAIAshgZu3upfqiad0d71JABj8Z9aErAPzmhGNPD1Wit36sXaJrT6oJfM7gT
	 pF99BUAAEvrca7GOnLvt9xNzZU+bWHn80D8B0phS6fxK342DcnVwlyWY0RSf/SF/J42iC
	 khzYXGFHqEMe6HqhkLh58ECmNbFfY8Z/Rnd9uiH5GCOjZfCuFJfvVrJ8Xac0OHFVcOvfb
	 Uo0fM9vmOyZwcV5HbivCe4gY6oSyEnhYTFsP6axdOxGm9Zo+Oq62Ez+XM9L8CuWklEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=dnqaBg439xQkqBIhixZxiCxQLvaIgNVYj9hFd5oriMg=;
	b=km8jHh49VPeLyotEU7kk1qP3uR8Eh4M3ZfFcpXXvdGcbG/dY4B55W/2f5uRTsrPE1BF/
	 ngkGm2+My7071ZWrcixzjwqpPsl4sN6qS7TP3S6pGDnZmDTEoQaPqGhQYpRBJZrBcUHV4
	 5tSGw4Z31mg8+zKI5i+lR9Kl5fKsS4auZg3b2kUOf1J7/gGuoHpAqM7w7h+e4w3UuznsF
	 BcgNBJvbYSoaYrj1FyfGxtifbOgqZV/1wPMpNltmA6Vk9q3oJwO8aAdcNMGvuNMxcNGEN
	 Uxt2HTfoLoka+phXHr2g4m1L6257UN1V/fFbn+qFpQAgqfnlee0Z184GR3iSDLtWvEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ozw3qbbi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B764606A330
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 19:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B764606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ozw3qbbi
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-89d6bd67045so7350b3a.0
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 11:50:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794081005; cv=none;
        d=google.com; s=arc-20260327;
        b=BYF6cX6meUX8T14ErN6mYiTyO1xOWuU2yhMnD6+dy31iFV3FdmpmKp6+dR9MuQLmuy
         wU5598Z7TfivFmoFz0m1iBnTYbPb0eP0QypE6Httx7LruyRu5dsoLJdjalk9p9/Fa5MX
         lNbRNmmrHRnCVmQyCZEhIwnJfF7lilrah3Z5raG4eF3amxB6sKthbsv4kLFOrMzad3tW
         LDgpH+5PkII7lsS0aSVgM988RTcTSDknfzKG0FxZ1GvwavSmknmCo0W9KLkcnTtLIuO4
         CyFiOcXGozv2wHUfCaEhum3/IYNg9ldKHX9n2Cghb2ZUFlJ1vRjiGT5uPTv9fch2X4xj
         biew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dnqaBg439xQkqBIhixZxiCxQLvaIgNVYj9hFd5oriMg=;
        fh=6z2icEuc8DnLHVXZGIB7QEf1Q5MKJD83p6ZP0Ja2amI=;
        b=I8qY/jTLo8C9Xxq6qzG826vXgtLIwQUmWtn6JqWLOXQxB1eUhsXM4xhy3U16SYYEIu
         PKXWDL0vAh1QjLO8orlzccfo8g8WMYSNdLYZBTKbM5VgOvgwKpNsGE0UlSmlpMOTycYb
         lIF3Dk/vcAxJolh/cdpMGdu0Z08/i+TFnej5JtNjNxIVTgu3PUtDghHJJZZOdoFGpVFl
         ZxQoEif2gbz8X0IMycUN7SwGfLVn4xFXPZ1dov9MTNWbiMEb+QDYbwc1lFpNiBoM1BzR
         WakPyeYeceBADJ6KKL5OKSCCOr5z6uu25N+fa8bKC40gs68qcwqaEqXLvRw0O9+XoLwz
         hqFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794081005; x=1794685805; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dnqaBg439xQkqBIhixZxiCxQLvaIgNVYj9hFd5oriMg=;
        b=ozw3qbbiPQlsmJPZ9ZOem2R/J7G8SUwYJdJwTVR4TAOTEJerO8X8R99yCDyBSxFzHh
         gY8AvokwRRIdAGln8MTEpRW6y75zogeh+wvzAPRlVqfLTvZO4o1FYdTBEq867l3tGo79
         5L2mZHXtGN1nxfFEVvNQ5bTffDsgD0/cUiJ+azp9tcJ9wPDCp2wlWWBS9MryXhdroXaF
         zWzfLIxx8cxweT/Bzm7xAZ0n20lC/EHxjziEcHh1/j8Cj3tsI+lo1eghdOcHRBv0NfJu
         hUVZtbIFpHEFICkyq7ZXTkM+3QCijdYP4XE3uTUgy2ZGEGy65YhKPi9LD8H48LaV+wBu
         vG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794081005; x=1794685805;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dnqaBg439xQkqBIhixZxiCxQLvaIgNVYj9hFd5oriMg=;
        b=euR9y+JuEMgWOO9OGCCjFsLlbC2VoBmF7adRWS7xBn+ZvEFocBJBC9Mw1nskxnc71S
         /UeGyxYMTS0b5glcbzybQOjN7yh+0nRWp7k2y6osSxwgoh64xkRlznxHeqS+SkZatnhD
         6amQaeQT3XlvYQ5bZO6w67BBlXhKCYRhgX5+SsCydFnRCKtyiPmt2ZufWRmEqAkCD9f3
         UGZy2ngDnvP/IPoRGa+4ZEsbY12Ine6+9D4hg0Bvcza+MWeBWwRZjSbyUX1bKGq4T8hY
         bWkUcJ/CmXrKK5QYQ49OX1Wb60v34ER/8T3NQylVmcJtrFsDaxruCXWi+CvuUazyon7h
         Rkkg==
X-Gm-Message-State: APuU4Z8PY8WkckKw9z4j/TjdoVZ6kbNt3tvgFkIMiXnqgK89OEUnxaAB
	jW5h+Vw54GKLYuYzUYi5YW3YbYhNsVq6r5sAdYRXYfcmRBq0fLqaYIBpmjzpWtdBIm0N02xhNml
	sMFqlniuX3trK5uJvRZ/AZtOu4bFl1oU=
X-Gm-Gg: AYBFou0+sLy6QeT9XsWmi7imLsZ9xzEyuWQD4jxelZ48AoyZ0GxKFREKLIdmJ3BJq8b
	79g9lduHYuu37aIF2OXW697m/PA+SBj6Le4eMFc9TwSak2OWikEYzN1CRu033GzP+3PyYKmB+VT
	I+zjwCgNyzPYRItCqeU4q6Z8963Zlal/Yfde1TShqp4jQIjMNXWRfxT9FXEnfsydQxC4X+4vp7s
	pERdE+MSYIkf1gxjp+MteZhIH4xDcpv6nB0t+05x5lfkJstvCuTykniArq4MNzo8kDGqxsCPBjE
	F3V5TeE1VN37C74E+y6VSx8U3DU9dgDj/qFaSYcNVfwQODukjzWNBQbW6WHG0o+N2LgWdcqrDlJ
	mPH+KVVzN2O1qTmxFknrxUXEuf8JFWK4KUksobKXm8EGYoANCKqJI7KVkjjUqGIxMXoQmG1YsKR
	tGvIi9mdiS5ncmQ+D7gWz9dv03nLR+14tvG0wGrPkoX8cgsxMld2IXzMT84POCJLc6eqqkrwdPL
	EC2XMAAaXXkKHd7l+GGYWcWoIuXg9vyuj6y
X-Received: by 2002:a05:6a00:cb85:b0:8a0:582c:5c09 with SMTP id
 d2e1a72fcca58-8b4e72b16eemr1471660b3a.25.1794081005338; Sat, 07 Nov 2026
 11:50:05 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107193020.583215-1-jelle@vdwaa.nl>
In-Reply-To: <20261107193020.583215-1-jelle@vdwaa.nl>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 7 Nov 2026 14:49:53 -0500
X-Gm-Features: AclHuK8qaJWViey0XBMD5YGn9cZ5RPcn0GStrY7iC-g6_WhaMFOU4BRC86c5dfU
Message-ID: <CALnO6CBarutmydfmHDM=y5yfUCQY5SxKKcoCrd0NXCuNVkDuJQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Support --verbose in git history
To: Jelle van der Waa <jelle@vdwaa.nl>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Harald Nordgren <haraldnordgren@gmail.com>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 2:36=E2=80=AFPM Jelle van der Waa <jelle@vdwaa.nl> w=
rote:
>
> The new git history subcommands like reword do not support showing the
> full git diff when editing the git commit message. This RFC adds support
> for git history reword behave similiar to git commit --amend --verbose
> except I choose to leave out support the "commit.verbose" configuration
> option.

Just as a first thought, while it is nice to keep the interfaces
consistent with each other, I wonder if we want to reserve a different
meaning for "verbose" in the context of git-history? For example, I've
sometimes wished git-history would show the rewritten commits after
execution:

    commit abc =3D> def
    =E2=80=A6

Anyway, my point is, there's a lot of possible meanings for "verbose",
so maybe we could use "--commit-verbose" (blech), "--diff-in-editor",
or some other thing that smarter folks than I will come up with which
clearly signals what we're about?

> Other git history subcommands like split, squash and fixup could also
> support --verbose under some circumstances (without --no-edit for fixup
> or only with --reedit-message for fixup)
>
> I would be happy to work start with landing support for --verbose for
> git history reword, ideally with it also supporting the "commit.verbose"
> configuration option. Further patches could then add support for other
> subcommands where it makes sense.
>
> Jelle van der Waa (2):
>   history: drop redundant strbuf_stripspace()
>   history: add --verbose option for reword
>
>  Documentation/git-history.adoc | 11 +++-
>  builtin/history.c              | 61 ++++++++++++++++++---
>  t/t3451-history-reword.sh      | 97 ++++++++++++++++++++++++++++++++++
>  3 files changed, 160 insertions(+), 9 deletions(-)
>
> --
> 2.56.0

Thanks for an interesting idea.

--=20
D. Ben Knoble
