Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4E012B82
	for <git@vger.kernel.org>; Sun, 14 Apr 2024 01:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713058134; cv=none; b=nza2jF7CRzmFGglohxU6Oce8XeX5q3e9VLag9SrBDs0y93I4CFjjJzX3UZ7U2ZaVMelWMBe7C2B/eweuKo/Oa2XXyO5TnP3ws2jahBSGOzOSbo+lVfp0G/Gy6e+BpXXuSjXFnwVUvQdS9C320xbEjGuZwwXKMqhspkFa8Xji53s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713058134; c=relaxed/simple;
	bh=2XiTZOpZZkvbSd/UYXacV2TxtPs2kzE2MyqBp5N4ytE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrHQeBZ0QJ0K3jowfth4QwSsF7LY4c1BXDLaZf14L5TRRhangJXhJgdWDXlfGEJ8LNGAo6HTmTNFAu17Rv2dpEQZq9+FOJy7bkB35xafbvxmdj5K5WnUuSlQh8NqE4zJ7TcFq3dR11qo/uS270qZBKylfrCOVnmY3mbzUd+KgjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-69b0f08a877so11751206d6.0
        for <git@vger.kernel.org>; Sat, 13 Apr 2024 18:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713058131; x=1713662931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6npP+TwQRCPkF4Pid21BOry1a32iqB61Q0+bjHwXMDw=;
        b=PyYBmU7/JNKsTeHMvcvXByFCplCjg9J1pHvIA37zzFglLE3mud9W5Y4qSxUfwONqe0
         estydjZpCsDZnsYVYp3gwy10VUgGYcgAjRapnQn2O9dz0YxYZBMzlnT3od8kYmUl+MHX
         WdSzMrDpXld1vLbdjHikVw8JENScqU+7At74Hm2wvPaT2NVb3bBmfYeVKvLpoucfvveE
         nH2A2pkvo/SxqDOO6cdMSjm58ApQUB66c1VaAzB+Ng4cwYmPK6OwBmfJXjbgteyGNEEm
         +u+Th3mzcy05OKEWL2AJ7J7CiAwZRhS2yod2b8hyRr9DyLEW49W7Vkn4iCSTpLOgUKW3
         zmfQ==
X-Gm-Message-State: AOJu0YwX2MgJG88tOplwrg9aEoukPHij5SyG4VWwOK+KiHLdj+kt8JOw
	d35lnhAHNN33W9vaN4a/kvbgnIGdHjItpr4fPgyAMKoxnDxhseMrWxYLAFpqL7HBBdIX5tUzdeU
	xjRQ9uEoEKWjpJqlteatFaN7q5Ri62A==
X-Google-Smtp-Source: AGHT+IH7fx6+QL7JtJe7VWD/iJlEnuJtiFOiFN9Ax49dH1ziY9WSVDPJNv8lkGd/kCoaQM77GSM03J0Gb3ATNQpI8uk=
X-Received: by 2002:a05:6214:3211:b0:69b:54b0:2d0c with SMTP id
 qj17-20020a056214321100b0069b54b02d0cmr9873603qvb.2.1713058131214; Sat, 13
 Apr 2024 18:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <965ae345-fd58-c46c-5a7a-de181e901f21@softwolves.pp.se>
In-Reply-To: <965ae345-fd58-c46c-5a7a-de181e901f21@softwolves.pp.se>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 13 Apr 2024 21:28:40 -0400
Message-ID: <CAPig+cQu15HzZkeT3+oG3U7iFax5_GYUB=uqwuJxshw-PD=VHQ@mail.gmail.com>
Subject: Re: [PATCH v3] bisect: report the found commit with "show"
To: Peter Krefting <peter@softwolves.pp.se>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	Christian Couder <christian.couder@gmail.com>, Michael Osipov <michael.osipov@innomotics.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 5:21=E2=80=AFPM Peter Krefting <peter@softwolves.pp=
.se> wrote:
> When "git bisect" finds the first bad commit and shows it to the user,
> it calls "git diff-tree" to do so, whose output is meant to be stable
> and deliberately ignores end-user customizations.
>
> As the output is supposed to be consumed by humans, replace this with
> a call to "git show". This command honors configuration options (such
> as "log.date" and "log.mailmap") and other UI improvements (renames
> are detected).
>
> Pass some hard-coded options to "git show" to make the output similar
> to the one we are replacing, such as showing a patch summary only.
>
> Signed-off-By: Peter Krefting <peter@softwolves.pp.se>
> ---
> diff --git a/bisect.c b/bisect.c
> @@ -959,23 +959,30 @@ static enum bisect_error check_good_are_ancestors_o=
f_bad(struct repository *r,
> +static void show_commit(struct commit *commit)
>   {
> +       /* Call git show with --no-pager, as it would otherwise
> +        * paginate the "git show" output only, not the output
> +        * from bisect_next_all(); this can be fixed by moving
> +        * it into a --format parameter, but that would override
> +        * the user's default options for "git show", which we
> +        * are trying to honour. */
> +       strvec_pushl(&show.args,
> +                    "--no-pager",
> +                    "show",
> +                    "--stat",
> +                    "--summary",
> +                    "--no-abbrev-commit",
> +                    "--diff-merges=3Dfirst-parent",
> +                    oid_to_hex(&commit->object.oid), NULL);

Style nit: On this project, multi-line comments are formatted like this:

    /*
     * This is a multi-line
     * comment.
    */

It also feels slightly odd to place each option on its own line in the
call to strvec_pushl() but then place the terminating NULL on the same
line as the oid_to_hex() call. But that's a minor and subjective point
hardly worth mentioning.
