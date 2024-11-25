Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822492500AC
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 03:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732505773; cv=none; b=V1vgG6XIjqzFffBJw6b8YpX+ccoEvIjOUJtaF6fCy6+vpKGiU6nRab+LrX2Vr11XwK1pmcF10ulIN2FdNIljwRsmzbBKH7BOO9e9QLLG9I3j7L1KekNmAU+c2XMQkwQM/AGGJ3V1SSFIrrtNp/4Qom2esvUoJAupJBT6IrjWMiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732505773; c=relaxed/simple;
	bh=KQkeYQLtSEu7ITz2/caj7rDlR0aEyAJa7tgKccoVcFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mE9iqta8psHgO/tycYGfDfTTO39/gql1uPRg5JQsoLw93rZI2eXyHIPYFN2cYydUUuCrbzlJE0fuyOl8i2gUQcgdXthjdVng0EUD6KlF7YXjSGn6Wxhfn/SVs87JhU8MXKKOKvPHnkhW4VuqA0nGndikkiReLZvhbVKQ1Ye1GjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d413eb73e5so7426476d6.3
        for <git@vger.kernel.org>; Sun, 24 Nov 2024 19:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732505770; x=1733110570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KUZV9XQVvuG+2mAdKPGel6rC51nT8ro2gbzZDISkNc=;
        b=oZ2DNEGI6dro1sgpLnJIrOh37+yfqHx6ZWxxxONN3HSvez7jgZJn+rmaSCbeZ8n6v+
         /bBtQ00mZkp/YLaYlnfrS2O274r89BGTUXoFE/1Id2nY4huEAHV+Qx05xtJb1T6fU5ft
         bl9btVQMcJSWFVIichaTHRiyRWh9Mv3jqxqwTz4PB06nvOlazILJylD3gGvZCqlE+Jwf
         JXxDcTlefjJHdZ+zrSHnGAJbt5uEZFgGFjx2qAPAtwZmifcexhvjIVuFiKn5AkzyqpTW
         4IF9LBjq7st2l8FI8qC52HFR4HhvYW6OqJu/5kmR80bSzOH3kqfe581utNucm4EO4Lnf
         sLZA==
X-Gm-Message-State: AOJu0YzTzfWgTi0TVtkBqo/9Hz3TCOe0j42fX/jQdurmv8bAd5EBrXVJ
	BEzNE1XoUKwTaVEi+TQvgBtj6GNWKyfvWQgnyUWQ4w21IwTsUMWM3NuFno27qI8D0+Jyv/o8K3t
	VlE24QoUawhT32gLRruBbX6jL2EpNtA==
X-Gm-Gg: ASbGncv0attiVUuR/3syDDQZeon9ofDVxM9/OOx4Yp/HAkmfUYBF6kyfH2be7vfQ6sH
	oJkomk63j+062t4bdCYIg/0L5/JZyIw==
X-Google-Smtp-Source: AGHT+IG2lzSHl8PHCU/mHeNLh53cqPlJx/8EH1RB90R6SjFYbk1rRAvhh3jkEcLhzF6N9jGFrJMwASg/XPR/57K6xyI=
X-Received: by 2002:a05:6214:20e2:b0:6c5:258f:26c1 with SMTP id
 6a1803df08f44-6d45134f119mr70872716d6.7.1732505770419; Sun, 24 Nov 2024
 19:36:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqjzct9db8.fsf@gitster.g> <xmqqh67w6m4m.fsf@gitster.g>
In-Reply-To: <xmqqh67w6m4m.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 24 Nov 2024 22:35:59 -0500
Message-ID: <CAPig+cTCiyc-8GnEEKZvDTAvmrXNrfJ-Uq4=7TCv21UgoiKAZw@mail.gmail.com>
Subject: Re: [PATCH v2] doc: option value may be separate for valid reasons
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 10:14=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
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

v2 looks good to me.
