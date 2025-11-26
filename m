Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250DB219A81
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764178576; cv=none; b=b2pggEDsGDgpVtB/SGeQoXS+GsuZ8Nyc8QSx6/RumpeILeVwzOpXkqv57IZ0w7TU+D/nsSarCRcDOpPUooiXLj3fzkFKFPtc0ZV1hJsTNbKXMXrBruJ7MzXFQ73j5KnV0vyM1nCThv50XqCw6H19EFkGgaBzlCfLhUZwtk/T4M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764178576; c=relaxed/simple;
	bh=tUwlkLju5NGdm98w0sRjEAdQxfgzHHq3DZzHNMZegew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k923IQtlzg/JQOFBPARJEtSnVNHh5wK9dDT6hDj/7/zMrPl98A9JbYBaTfwWvib3MjoSLizkXjsrVOlaWtOYVOwD9AxCDxma0G5lQmpxS0p2SFmb2COdmlshKIB4Ui1pyY3LkNAliaDiuf59rboT7SHL+gZlROlykrihr1z/b+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxHeeCa8; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxHeeCa8"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-94895f6b144so1126639f.0
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 09:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764178574; x=1764783374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQrNkcbAEmDY1uE4ZrxVfiwVflcU4f9/o+sI0GPmsMA=;
        b=cxHeeCa8ny1194ygfraFwRvVxUYkCZkAR/tpI6i1ug1W89OLSUk6qLzarByzbbnrhD
         sseT9iPqh23sug10ga6AhzKWWWIE5Xtue43M0GqxLoofnbICcXUk7OdGxxlQTdrgSYVG
         Fv2Nyr3i5aPq6kfxSdjj5wsSP0rU4BWEXfHHXv7Ik0qRM/g0R3bTi8P4oiPFQBmFHVuK
         TJeer8k4vR1vy2EKE6hd3nDFF0JTs+Llxk2JValSiR0LAyXgXM+gLXjAhSI8Sct2t44D
         JaiqHON/uy3bnNf8IZUeIrmcv3EOH3tFhfjv76SHpD49q1gwAKpWD5FeRGkl/tNvwduW
         qU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764178574; x=1764783374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lQrNkcbAEmDY1uE4ZrxVfiwVflcU4f9/o+sI0GPmsMA=;
        b=EKQmNsiH0rM/rIBgpEABQZ6hYxeH2AAfuESwx/WpC+0mZAkKeGoEsJQ47a2pYnw9nL
         anlQ/sGqXw7boMVz06N2wgO2a4nMGJujSz8tyzucnADtAxnzfgujnlpbtd+IMQmnBVfR
         iVw55DbhFtY7r1QySCmQylmL44cAxWxjqqPRz3WuUhE1+9nIuQd4iV/hfD7O6SrXoKGV
         jiEWSnSjC16kcqnM4BhWJUw/0r3D1vCx8hahPFmnxApFEhMrbgbc4XG7aiUNlGO1LJIy
         UtwnFtePdGrmMJRoxDwicxsXxJLptpJRFYlBFq4iLjXQRNWJABpFP87G0X+YuLI8CsUi
         WYqg==
X-Gm-Message-State: AOJu0YzPFZY0GqV3YnIceta1A/B1PDcKhW6wpfK9hXC8a7lp6UZmifn1
	TCiZ430Whimu+mbAOubT+wcnrkAqhK1lnPFyv0SX5KM5Uzwy3gq4tBBdLy5v0aZ8wXfVudMPj02
	SkNL+mH+LmKrJgomFVr7vZIE9FiIoVek=
X-Gm-Gg: ASbGncsykANTGHrYf0GX3ZUq04dsr3PJvTc5df78c0ZJKEfPgUOjcQb6pxRhQhIdQBS
	/yRfpYfJBIatldE7fB5ddEJCo6s6b52Nmb8l58EqUZ6ux5O6lK4GoJVcsiaHud/1+4qYnEzd9T+
	prJwGhyXzao1eTtTGGFc8XgaTwEuFUCeBxa/CDplz4D0PnFViPHejhsWKkKIFmFcj6UNUJlS0Hg
	hYZ4z5n2A8N1UjTQayBILz5Bvsm14d2DvbcRpj4HGH3t8GuFjhVD9VpJG3cazaM3McyWVz173Y0
	XtWrivpbytUJ8yq/xY7MrPyYbz0O
X-Google-Smtp-Source: AGHT+IHybm6lfVkAGHIRIBWQRgoFUQifcqfYRjrb2ECGjL+ue3RWTwuLe20dljGdIV3dElSpyUR2Karjv6h8o/Angak=
X-Received: by 2002:a05:6638:c46:b0:5ab:77fa:f19a with SMTP id
 8926c6da1cb9f-5b999632a14mr5157314173.8.1764178574126; Wed, 26 Nov 2025
 09:36:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4f04af5790353b074cf122c450c1cd3f8d1cecf3.1764167611.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <4f04af5790353b074cf122c450c1cd3f8d1cecf3.1764167611.git.phillip.wood@dunelm.org.uk>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 26 Nov 2025 09:36:03 -0800
X-Gm-Features: AWmQ_bmF5n2hKRpuLDvB_-5ZoddwfIVY_ewkcD7Iux9xqS1dFpX9RMU17qbN2eI
Message-ID: <CABPp-BHLYBAkhJpmEkxWj+ujHkdb-h-8qAoWMFAe19FNSA+KfA@mail.gmail.com>
Subject: Re: [PATCH] replay: do not copy "gpgsign-sha256" header
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 6:33=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When "git replay" replays a commit it copies the extended headers
> across from the original commit. However, if the original commit
> was signed, we do not want to copy the header associated with the
> signature is it wont be valid for the new commit. The code already
> knows to avoid coping the "gpgsig" header but does not know to avoid
> copying the "gpgsig-sha256" header.  Add that header to the list of
> exclusions to match what "git commit --amend" does.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> We should perhaps think about how we can centralize this list of
> exclusions as we now have three copies of it in builtin/commit.c,
> builtin/replay.c and sequencer.c.
>
> This patch is based on maint to make it easier to backport.
> Unfortunately that means it conflicts with ps/history which moves the
> code that's changed here to a new file. I'm happy to rebase on on top
> of that branch if we decide it is not worth backporting this.
>
> Base-Commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
> Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Freplay=
-do-not-copy-gpgsig-sha256-header%2Fv1
> View-Changes-At: https://github.com/phillipwood/git/compare/9a2fb147f...4=
f04af579
> Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/replay-do-n=
ot-copy-gpgsig-sha256-header/v1
>
>  builtin/replay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/replay.c b/builtin/replay.c
> index 6172c8aacc9..d12e4d54872 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -67,7 +67,7 @@ static struct commit *create_commit(struct repository *=
repo,
>         const char *message =3D repo_logmsg_reencode(repo, based_on,
>                                                    NULL, out_enc);
>         const char *orig_message =3D NULL;
> -       const char *exclude_gpgsig[] =3D { "gpgsig", NULL };
> +       const char *exclude_gpgsig[] =3D { "gpgsig", "gpgsig-sha256", NUL=
L };
>
>         commit_list_insert(parent, &parents);
>         extra =3D read_commit_extra_headers(based_on, exclude_gpgsig);
> --
> 2.52.0.362.g884e03848a9

Good catch, thanks.
