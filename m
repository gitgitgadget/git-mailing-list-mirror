Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFDD1791ED
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 23:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492488; cv=none; b=RX9FgnNZ5BeEs1KsH3HgEsFZryCzK+J/9vM+0KLHG8tjsQ4lS/a5yJ/60ED5e9xpO/wtjZY8nnZERETzjVeAguVctyz7TjQKmxKLy6PA5lr+7K45ofFh+Qk6vWGLgff9k9LKuRzwfUO++aFBDYkYkpQ+ELGzXjhTH935Q8gNHyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492488; c=relaxed/simple;
	bh=KGW/vw1zXdxOGKPT/ImFmrwZHnkxtZl3auPAbBnTuRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYY4AEYg+GuqB5UVeVYPjdbFU7OYsgXVYRDr7rNGxLjtHGWVP6+7g1MHuWtNlM7/IMcIYbeV203vW/p37oCs1sbjJydiOLPKYBk2fQlBo4GeOy6n6rvj/sndg6RocJsQkSmpGhs3yahuXbMZJWr5f1Xq4NeHwNqRAp3T4srKTgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d41ae05df2so8046646d6.3
        for <git@vger.kernel.org>; Sun, 24 Nov 2024 15:54:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732492485; x=1733097285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71TIZRL0FLZhS+2naeNI0cwQWKVdt1APB8zYHsJkd6A=;
        b=OJMG2Fp7Xo/40qCYRGtXEA4q9Zwdqi+QqoTq1j+nGEJXYvuaCty3fgdpAB/ATFegO6
         ECJ4nEYlEOmrDCisb9G78K2c90MqQLKR3Phy1pjRUHJxXwwtUA7XnQQb1yHB43FKoZm3
         uibwWdz7gtJPaTWeOKQpqeJ/vSP6VYhtcT3m6vGsxNCqc2EaulesVvdwcf0Z97pIWE53
         trPlFY4wCiD+TPglgcGE1CCA7MPijgu7T/DL715HlCU0Y+ZNiW4xbxpJ3tP0Bi9XqMG0
         EZpqYXQamFu3OaW5X1YlGQ4/jbNg3cJxziI+2nDjk5ladcvCYS69tgNNAn9DiitBnVOA
         PU0Q==
X-Gm-Message-State: AOJu0YzWnNStpBZeouFS6c6Vd5/oEDmqor/1RTI3D8e8OJkGBwhjYlwH
	gxNaTkQ6I6MJ7NS/JZ50FHn7tdEnAoh1aYSZR/isiEO8DGQVCDTacsvEdn30rui6mGN1j/cHN/H
	+3uXiKvd32VnAR4TIDEhP7HcrrZI=
X-Gm-Gg: ASbGncs4njb0rKb/oZiNrM3N0G7i9I+r8VN4JKF61mR6aaFcV+6OkwFZIJgXKm6u6YW
	PSEc8NkCnunCTXBOBrzRpUxN/X5riWQ==
X-Google-Smtp-Source: AGHT+IHdRDEcBaVV1SIURtWBIxUT1YDWPjDW++Gld8R5Tc5gPKffdLGyufZ4eWcZc7xcnNYwGU+Mny7LC9xsTkVFVOQ=
X-Received: by 2002:a05:6214:528d:b0:6d4:36c9:ccca with SMTP id
 6a1803df08f44-6d450e7b324mr68347886d6.5.1732492485535; Sun, 24 Nov 2024
 15:54:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqjzct9db8.fsf@gitster.g>
In-Reply-To: <xmqqjzct9db8.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 24 Nov 2024 18:54:34 -0500
Message-ID: <CAPig+cT_uB-mBwRh_A-HvpO8QCjv_Rw3-6s4gV=BCwYmSGcctg@mail.gmail.com>
Subject: Re: [PATCH] doc: option value may be separate for valid reasons
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 4:44=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> Even though `git help cli` recommends users to prefer using
> "--option=3Dvalue" over "--option value", there can be reasons why
> giving them separately is a good idea.  One reason is that shells do
> not perform tilde expansion for `--option=3D~/path/name` but they
> expand `--options ~/path/name` just fine.
>
> This is not a problem for many options whose option parsing is
> properly written using OPT_FILENAME(), because the value given to
> OPT_FILENAME() is tilde-expanded internally by us, but some commands
> take a pathname as a mere string, which needs this trick to have the
> shell help us.
>
> I think the reason we originally decided to recommend the stuck form
> was because an option that takes an optional value requires you to
> use it in the stuck form, and it is one less thing for users to
> worry about if they get into the habit to always use the stuck form.
> But we should be discouraging ourselves from adding an option with
> an optional value in the first place, and we might want to weaken
> the current recommendation.
>
> In any case, let's describe this one case where it is necessary to
> use the separate form, with an example.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git c/Documentation/gitcli.txt w/Documentation/gitcli.txt
> @@ -88,10 +88,20 @@ scripting Git:
> + * Despite the above suggestion, when Arg is a path relative to the
> +   home directory of a user, e.g. ~/directory/file or ~u/d/f, you
> +   may want to use the separate form, e.g. `git credential-store
> +   --file ~/sec/rit`, not `git credential-store --file=3D~/sec/rit`.
> +   The shell will expand `~/` in the former to your home directory,
> +   but most shells keep the tilde in the latter.  Some of our
> +   commands know how to tilde-expand the option value internally,
> +   but not all.  The `--file` option of `credential-store` is an
> +   example that it needs shell's help to tilde-expand its value.

I'm not sure the final sentence adds any value considering that
credential-store was already mentioned in the example earlier in the
paragraph, though I suppose it doesn't hurt to keep the sentence.

> diff --git c/Documentation/gitcredentials.txt w/Documentation/gitcredenti=
als.txt
> @@ -240,10 +240,15 @@ Here are some example specifications:
>  # the arguments are parsed by the shell, so use shell
>  # quoting if necessary
>  [credential]
>         helper =3D "foo --bar=3D'whitespace arg'"
>
> +# store helper (discouraged) with custom location for the db file;
> +# tilde expansion often requires the filename as a separate argument.
> +[credential]
> +       helper =3D "store --file ~/.git-secret.txt"

In the context of the commit message, I understand why you added the
comment above this example, but as a mere user without having that
context, I think the part starting "tilde expansion..." would confuse
me more than help. Perhaps being a bit more explicit might help:

    # use `--file ~/path` rather than `--file=3D~/path` to allow the
    # shell to expand tilde to the home directory
