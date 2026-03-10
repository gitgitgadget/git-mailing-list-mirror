Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E004296BD3
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153106; cv=pass; b=lN9tvYfJbwuP59yrM/qO8IrkMJ0fU+lbJ8HnJaqMn9e475ielrBzJ6eKOH/gGGb8J/Hc1c5gw8ifpE0yRPsEgysUDZDFm13l6GXnFNQ6mkGuPC8mL4CW5iOQkoVxJJl86pFp4UsUmG/KInTqMJk1WR81wvH80calNsDaAjz4GAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153106; c=relaxed/simple;
	bh=jkjSvTxEGSihRR7PlD8ATeX2q9ilObORGDkv2R5Q/1I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fViUWjBLlI/i9TcdcMpHnCq/72koVrr7g/qMaGoMk4t4HzsYB1z4sN1vUEFmWoIwCU3ieNmK20BC67U6Xs7lGDR7HWE72nth58yAuNMfZHdIqJn5LfXj97x3/b04GcvV7XHL2+vDKn9F2CteIAVNxMaOaxPcoVfsE9w9uwirD9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P26jwab+; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P26jwab+"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-94ac8cbf3feso7375256241.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 07:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773153104; cv=none;
        d=google.com; s=arc-20240605;
        b=IkUw3VwyMjyVVN+wamyrQkd9iMYZvn2CvYeE2w5NlPtot3dG+Ke25RNk1xrFi90UJt
         my6OTHyUYh961Bvj+figsRWhzmeyzFx5Qbd46uUSnTi9CBFcnKV5ucukBCh7x4xQzw+o
         DUMqFTtLd6gPkeg9geq8o1YrKkKpx3UoMUB47JyJh189xquU3kABUKRvZQCbW8gMEg4e
         C8egM0qWk/zBpxKQd+FEoqCuHYsB4imqSfGXFhDd60gqHOpZ4TKkvZPohA66QdogF8VR
         vWROpHSwtpnjIKoEZKaz0AQvlUH2oFdobTBrQZ9LHjBFad3wAuhgPokP2mpx9TL9JSLE
         Wj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=/e5k5xYautRCVzBSBNSBd1tucczPa9s/trDgT+CVrr8=;
        fh=EL0A9RkZRkspFMAxYgYUeoAkyRBh3aFYgVJ2ztkrXCk=;
        b=c3ALkF/TJjjzqPcZTXf6W+L9/C9bopLT6cydI1kGY53NF+7j/yyi6gDgaCsHejyIYX
         entGjy1MR0HD/FXTXz8MNttl+y5FElDYWlyYieC5GWlYuCJLK66S8mceK44naYMvwJmg
         kQWwPbOwxU5JYuFjClGdt7t10au2vUbkbM6iWG+dnrRhfaSEYKEHc2FeNzg23QvjiQYO
         7gz7gLSnYE4fcCFxB4Wg1q613gqLg1C4Cp5VN1/H995ZY+l/S1F1VdsWeSCd/0uIYrJg
         4CZ3RppQfM1s0O4U3DmZr/XlSjNi9NXmqcTfSzHLvR6+wq8tjYSsgyzIkoMI/wZtDBke
         qn9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773153104; x=1773757904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/e5k5xYautRCVzBSBNSBd1tucczPa9s/trDgT+CVrr8=;
        b=P26jwab+Uvj0OZZzqQwBJb+wk566ME1CcSBUyD58ASu0pcDg36vXBvNxg2cnAvoGMo
         Ld1szfGOk8oZnatXvebiHp7ncGtbd8eYloKKk2kydWGOpZZWgeCNYvqtW6ZTt/BRlDr6
         HEOQM3So7NWZ5ag8br9Yc00HeTcpa2eeBafkBSURQiwZwKZvBfJc1eRnpm/77CwlDA1p
         qJEs243PD6VPy6X9m93ezX1+hG9Tu+0TSGMo/zK3Sxz624GMs6FruB4Anv/dNrK4xzqP
         K3Ibyc78wdkdwFn10uGVD4wpR2hA7VeOAaKqIMI8Xb85RRAqe11GgWYroDN9AMamxSMs
         7GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153104; x=1773757904;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/e5k5xYautRCVzBSBNSBd1tucczPa9s/trDgT+CVrr8=;
        b=s0m+ma0x2Wh3HxfxjtweH/KG9p8p32rURq2+Md8ZjHTqCio2e4wxu3NcMJIt4VqOk7
         vfZLZw1WfIG/PoJaRsP+TaACdsrYzXJkfCu0sTZmMFe6K1ki8r4ySJo58smkNHp0/HmO
         R4O21A79IcttFAjNL7jw9Ry7SCp3AcoYx/Mp1PyODyRJHecbss79KVcxI+jEzDUVvMgs
         033W63v+94cjeTyfiK0wrErG0Xggd7ypmPOVX9fSXjv2Ggtft/aHhoIHDgLcY8Ob9a/z
         WdrJQrFd5y7CN3G8jwr54JBCGHxhCfUwkb/ciw/clDvxRjqTIdQbsgsnxZybBkZpvm2X
         K+EA==
X-Forwarded-Encrypted: i=1; AJvYcCVhhSZBJYxYh8xIuqU/xdCSU4QIayEe2HN3v2RRn8+3KWFsBEXHWY89xXqz3k/r5vG/jrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF9DtZiI9HrN+MFZaK5Tw8DlRywo92q7n5JRN4quE73tRItC1G
	lHISO/PP+tCD6w3sdQ3dtgAzSbQGDdZ2fycxNo46V/NH1Tw9lpRJ1CvwH2XtL11LKTCpIfhDLNM
	olURfEZ8suWMJgk8SzoZYMXdDFVMMb0U=
X-Gm-Gg: ATEYQzyKnLeV6uyOu0gAQCKKwLIpGWY1tRt6Na5k7QDch3Evej487hgCbYUobOHFo8G
	UAZdw31fzIk2Ag7lNOJG08IqSvKQa14Xz321r9dfukH5x+2joxj5PsWjtgZaybJYpg7Sp4A8gR3
	+bp4yialC3FmTSMW/RKWQDspEZ+1+a+8HwEDR0TrVrB6UVVQ5eFwJq16HZ2L1B17lo5I2zjf7hL
	ojTm8FXW7u9zHHT86y7lbk0HHSNZBNkyyGwJcG6iJq510ucRMqtvlNoyflIXbzLofh87qAxbGmi
	0cApJvnmbfECsGbk8VWs2euX9MauSvqjYlB03NhK
X-Received: by 2002:a05:6102:3581:b0:5f7:2655:f2c1 with SMTP id
 ada2fe7eead31-5ffe5f72ce7mr5961702137.13.1773153103866; Tue, 10 Mar 2026
 07:31:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 07:31:43 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 07:31:43 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com>
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com> <pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Mar 2026 07:31:43 -0700
X-Gm-Features: AaiRm53qxvYjjiSQ8ceZ2DbpuOnqC33p2SzfANmRE8PD_1zwLGon-ionLdveqEg
Message-ID: <CAOLa=ZRfaSR2CisUrW0gLf_45KQj1wQZ70F4PZ5XcwWZ--+HhQ@mail.gmail.com>
Subject: Re: [PATCH v2] advice: add stashBeforeCheckout advice for dirty
 branch switches
To: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, Arsh Srivastava <arshsrivastava00@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000e38e0b064cac607e"

--000000000000e38e0b064cac607e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Arsh Srivastava <arshsrivastava00@gmail.com>
>
> Add a new advice type ADVICE_STASH_BEFORE_CHECKOUT to guide users
> when they attempt to switch branches with local modifications that
> would be overwritten by the operation.
>
> This includes:
>> New ADVICE_STASH_BEFORE_CHECKOUT enum value in advice.h
>> Corresponding "stashBeforeCheckout" entry in advice_setting[]
>> New advise_on_checkout_dirty_files() function that lists the
>   affected files and suggests using git stash push/pop
>> Documentation entry in Documentation/config/advice.txt
>

Nit: Did you mean to add bullet point here? '>' is generally used to
quote text. Perhaps use '-' or '*'.

[snip]

>
>  Documentation/config/advice.adoc |  5 +++++
>  advice.c                         | 27 +++++++++++++++++++++++++++
>  advice.h                         |  2 ++
>  3 files changed, 34 insertions(+)
>

Hmm. Shouldn't there be changes which actually call the newly introduced
function? Also shouldn't there be tests added?

> diff --git a/Documentation/config/advice.adoc b/Documentation/config/advi=
ce.adoc
> index 257db58918..8752e05636 100644
> --- a/Documentation/config/advice.adoc
> +++ b/Documentation/config/advice.adoc
> @@ -126,6 +126,11 @@ all advice messages.
>  		Shown when a sparse index is expanded to a full index, which is likely
>  		due to an unexpected set of files existing outside of the
>  		sparse-checkout.
> +	stashBeforeCheckout::
> +		Shown when the user attempts to switch branches but has
> +		local modifications that would be overwritten by the
> +		operation, to suggest using linkgit:git-stash[1] to
> +		save changes before switching.

Doesn't 'ADVICE_COMMIT_BEFORE_MERGE' already do this?

In one of my repos:

=E2=9D=AF git status
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean

=E2=9D=AF echo "aldjf" >> LICENSE

=E2=9D=AF git status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   LICENSE

no changes added to commit (use "git add" and/or "git commit -a")

=E2=9D=AF git checkout  0-1-stable
error: Your local changes to the following files would be overwritten
by checkout:
	LICENSE
Please commit your changes or stash them before you switch branches.
Aborting

So won't this simply be duplicating the same message?

>  	statusAheadBehind::
>  		Shown when linkgit:git-status[1] computes the ahead/behind
>  		counts for a local ref compared to its remote tracking ref,
> diff --git a/advice.c b/advice.c
> index 0018501b7b..e1264f525c 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -81,6 +81,7 @@ static struct {
>  	[ADVICE_SET_UPSTREAM_FAILURE]			=3D { "setUpstreamFailure" },
>  	[ADVICE_SKIPPED_CHERRY_PICKS]			=3D { "skippedCherryPicks" },
>  	[ADVICE_SPARSE_INDEX_EXPANDED]			=3D { "sparseIndexExpanded" },
> +	[ADVICE_STASH_BEFORE_CHECKOUT] =3D { "stashBeforeCheckout" },
>  	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		=3D { "statusAheadBehindWarning" =
},
>  	[ADVICE_STATUS_HINTS]				=3D { "statusHints" },
>  	[ADVICE_STATUS_U_OPTION]			=3D { "statusUoption" },
> @@ -312,3 +313,29 @@ void advise_on_moving_dirty_path(struct string_list =
*pathspec_list)
>  			    "* Use \"git add --sparse <paths>\" to update the index\n"
>  			    "* Use \"git sparse-checkout reapply\" to apply the sparsity rule=
s"));
>  }
> +
> +void advise_on_checkout_dirty_files(struct string_list *file_list)
> +{
> +    struct string_list_item *item;
> +
> +    if (!file_list->nr)
> +	return;
> +
> +    fprintf(stderr, _("The following files have local modifications that=
 would\n"
> +		      "be overwritten by switching branches:\n"));
> +    for_each_string_list_item(item, file_list)
> +	fprintf(stderr, "\t%s\n", item->string);
> +
> +    advise_if_enabled(ADVICE_STASH_BEFORE_CHECKOUT,
> +		      _("You can save your local changes before switching by running:\=
n"
> +			"\n"
> +			"\tgit stash push\n"
> +			"\n"
> +			"Then restore them after switching with:\n"
> +			"\n"
> +			"\tgit stash pop\n"
> +			"\n"
> +			"Or to discard your local changes, use:\n"
> +			"\n"
> +			"\tgit checkout -- <file>"));
> +}

This doesn't seem to be formatted with tabs.

--000000000000e38e0b064cac607e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 78a7a42b7fb9a942_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1td0swMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0srQy8wZGRNb2V6cmlpWTh0ZFo1NiszeENxSVlETwpaUzRaTEU3RWdz
TWllbndEWm82NHFqaTMxL3BkNXoyS05vTksvTWxuZm1uRDEyUVRCSC9yNUR2MGhiQnlPNlpjCnZs
Z21NL29UQ1lJaitNOXVDbmFBMWlOWitNWCt0MW9Ya3haaGx2SFlLMTlWZ2JNK0pYWUhPYjBuKzJF
NDAwTysKRUpUY1doQjhpZ0NuNVM3bndOWVhDcjcwb0l1K043ZFNNa0lnaWlqY2c0a1lBMVJOTDJ0
cFBvTGNFeVVWSEJ1TQoxYlpVZVpGWkVTK0N5anhMa1MyTWRtbEhZRmI1ZkxaTHd6RCtsbmFKQkJV
T0kxV2pLMlZlNUpoQTJGY3pXVWk4CkRsQUVycFNYOXhyRmE3YjI5SnZQb0tmd2dLSWJ5dkVtR1ZN
OXkwZDZrYS8xa1d0VnJZenk5ZWwzZUM0a0tiM2IKQWdVZFJMZlJnMFQ3MHFkcXFiMG5iZEtlcDNt
Tkd3QmhVSGloUjJ4MjNBd3VMSk15S1ZFb29TclRWdWFyRVZVYgppTlQwQkZrb084QzVraVNsZll3
b1k2TFRMc2xwTUZwRkptaHNMVklUKy96azNmb3NzTEV0a25tNHg5SS9UMDc2CmZLblVvNk8xcW10
OFVXNXdqNVFCcGRHTDQxYkp1OEtLRkNOWUcrST0KPUR0WkMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e38e0b064cac607e--
