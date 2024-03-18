Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54D957866
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710791995; cv=none; b=G01AjhDYeqeEHfi0psGVRBD8lfn2dzOO3/JtvG83ydwG6bTmOKC+t05UUvNZouBwJpLWfl9e38/v180I9gBXQ2wK5s1yHCUDTtyO0F9qLbiUiEXZfKNQWJb2/JtqdarZ26trpuZ8aHPnpjmiKE+QxD3oVh6Rp/KhkHKDrImOcXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710791995; c=relaxed/simple;
	bh=B/r4uhgcAD1aTXxMGqJmmYvC2ND089aWswrFxchdm70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=By4nfn5q5U/X/uBJz9p6UCJp7VFsYky5HWrBkCspRdRL/gtJWGK9GHxycgNxP9VjIL5WymU6kzpoleSXGZXIYpAoUVLmhgUm4kfXR9eL9WZpB+o+XUNel0cUEjuu41p9sQf2C7MD2uvuB1vkkeB8O5zzw7YLfNSFRMsQftOj+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-430ad286ab8so20118511cf.1
        for <git@vger.kernel.org>; Mon, 18 Mar 2024 12:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710791993; x=1711396793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cZNe8fcfqzsw1k0oCRdO40mTQfeBaroh0jEABEDnwo=;
        b=CT0DiFOT3DBNM8AX2oMiWeGbeaR9j69oububvND0HbFCJlEguHzI0o86+fq4iNsBj9
         LAmFvm0iAX0ULr16ZIZ1mSHJITDPkWhGzdVqQnC7IxoICPBYd2hQM80gJqtb1/KY6lXo
         VD3qbW/sBRZT9U31DUCasNzBE2iId+8DpMO/u3MYOin9aThC//A2TKuV1aeHURliDxhr
         fG5vbjKuyVijatgqgKWOHQK/LOH6y0lpXk4pmje+XqcXn3i9HnkOM0Cy4BQ/yDmCYpvN
         P6xfYuxYb7Ihj80Zl4OpR6/acW4pOjwRBQChhk6KCeJSML1oHSXkGsgxthKEfI6lAA9q
         khyQ==
X-Gm-Message-State: AOJu0YwYQj0kvgRbJ31pcl726Mjh4oi0ZQ2Tc08R5LuBvqUvB6Aymd1X
	fCT92xI2mSF+LHTY7N/cb/SNIVS490SMaETeX7PsJxP4mtZ+oph2vr0C3TDSROFgCONECcigD1Q
	3jdZQC6C1nnhtXUwQ/RnJj5wjnNs=
X-Google-Smtp-Source: AGHT+IFycxoaDqn46l+PzFDlCO27kRI4NoOSRWQAVcw9Iv/28/j5nDK0LjTzt4X/AO2YD4+BDfuWDubbXdkiy1Aipfo=
X-Received: by 2002:a05:6214:708:b0:696:294c:d6a6 with SMTP id
 c8-20020a056214070800b00696294cd6a6mr1910212qvz.42.1710791992762; Mon, 18 Mar
 2024 12:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710781235.git.dsimic@manjaro.org> <96b81f3573d3f29bb97e77d623be0d53cf8085b0.1710781235.git.dsimic@manjaro.org>
In-Reply-To: <96b81f3573d3f29bb97e77d623be0d53cf8085b0.1710781235.git.dsimic@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 18 Mar 2024 15:59:41 -0400
Message-ID: <CAPig+cQ6Y2oOaPkKFsD41beXLHjhD++nmf59xrcswpb6_Q-sdA@mail.gmail.com>
Subject: Re: [PATCH 1/5] grep: perform some minor code and comment cleanups
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 1:04=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
> Move some variable definitions around, and reflow one comment block, to
> make the code a bit neater after spotting those slightly unpolished areas=
.
> There are no functional changes to the source code.
>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
> diff --git a/builtin/grep.c b/builtin/grep.c
> @@ -623,13 +623,13 @@ static int grep_tree(struct grep_opt *opt, const st=
ruct pathspec *pathspec,
> -       struct repository *repo =3D opt->repo;
> -       int hit =3D 0;
> +       int hit =3D 0, name_base_len =3D 0;
> +       int old_baselen =3D base->len;
>         enum interesting match =3D entry_not_interesting;
> +       struct repository *repo =3D opt->repo;
>         struct name_entry entry;
> -       int old_baselen =3D base->len;
>         struct strbuf name =3D STRBUF_INIT;
> -       int name_base_len =3D 0;
> @@ -890,19 +890,15 @@ static int pattern_callback(const struct option *op=
t, const char *arg,
> -       int hit =3D 0;
> +       int hit =3D 0, seen_dashdash =3D 0, use_index =3D 1;
>         int cached =3D 0, untracked =3D 0, opt_exclude =3D -1;
> -       int seen_dashdash =3D 0;
>         int external_grep_allowed__ignored;
> +       int i, dummy, allow_revs;
>         const char *show_in_pager =3D NULL, *default_pager =3D "dummy";
>         struct grep_opt opt;
>         struct object_array list =3D OBJECT_ARRAY_INIT;
>         struct pathspec pathspec;
>         struct string_list path_list =3D STRING_LIST_INIT_DUP;
> -       int i;
> -       int dummy;
> -       int use_index =3D 1;
> -       int allow_revs;

It's entirely subjective, of course, so no right-or-wrong answer, but
I personally do not find that this change improves code quality or
readability.

With my reviewer hat on, I spent an inordinate amount of time staring
at this change trying to locate each variable's new location to verify
that no initializers were dropped and that the declared type hadn't
changed. Taking into consideration that reviewers are a limited
resource on this project, I'd probably have skipped this patch
altogether if I were doing this series unless these changes concretely
help a subsequent patch.
