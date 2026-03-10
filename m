Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23D1314D13
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140686; cv=pass; b=acwSz+IFCymyhqGYPdz2RuY1xSZzG7yBouv+PSBcLNA24s2mEMmiICcFymb0PYkkWEnylbKjkdYvayqvzzg3DS/3+Pm655VEZpJpJrN1GUrqIv3uunKi0QQyeQuNGo7ZQ3KtinqvAxVoVfVv75cZuk1xiTSMscJFLPYuEaxDPKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140686; c=relaxed/simple;
	bh=gPL4Tz6yX9EnpeAJfxAVij/qn7C2FYblnquMV277Ve4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxbcECcTAtStpgCl7Bbti+Qg1prWiRpYJZRAsFwVR6habieuwfrJ92yEklcEDQ1oarsBLuEdaMs84vyFRzaIiZuK15zJZahPhWQnChDirXcO/5PjtiWzlTjnvP4qYjETcmAlZGqA9MKinMsr4mbq5nScO1eaAGQxaU4o9sGeED0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pv6RHcCj; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pv6RHcCj"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56ae58f3fc6so5580617e0c.3
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 04:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773140684; cv=none;
        d=google.com; s=arc-20240605;
        b=IyF+o5GAh4Ka2cFUyWOvBjub+vuzrgS18ncvH2k97FCZkqt9+8Doxkpz4MOoeHTJn3
         6a3gx/byjyiXcGL8Js7XX2sFbkk0SxQ44Jp/lM1Ar8kvJLD8jLiFcIWOpNJxCmaYhc6Q
         JRG1bhUDIgp3ZaYapc4TaB6gyJHuDVzA/RuZtan3ehJ51mPShcjrDR8DttydkIIjxxh9
         OKtA+OYlN+PqUmOkkzqLzhbkcnWRZrrEN/9J0RuwoHi1hlPdZb8g+94xRtPnKCNyfxvH
         m+ElliZ3PoS2socq3zgSCgOYd1fXErevel3rR5Ijer9eQgeUoDnIKdPiO4J3hvHs7MC7
         ywpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E0Kl7VFn9tJLcVa9RDWZWw9gDzwsA8iqvQT2OnP0C2M=;
        fh=XVVFyFZMJjkbD6fnpvMqEm5YgTspAOmhENsu3xpjjIY=;
        b=TyCCMRn0hdCya32IUcy9V8xReFqZ4m9UN1CFjx2j1TDPzMpy7peYaJ9UuKLT11MJc1
         BYt1Ii/5AKE2SN6tHSLv9I3s3FTQ4qxJ1yiwL4/iNyQnFb40jQEiB817YzeUUZO3zlmi
         Z66ISEiVhZL/hKfC9kZVkI5ZrYq/po/5yqj1IJ/yD+gh/U5tJrmo2johp/zUQZcHk6uI
         2MInLTwtjRpftW2L1fMcacMHzpV+0fExokBfW7An9PqAeyNiyQDVDDiC7pl2Aqi90gny
         SCAaxdNtOCWSkPxgXdBMfzKXkfLHhoPccPcfzOfPoYbPwSIQptM7d2YLokmxbY8hCdXj
         oWTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773140684; x=1773745484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0Kl7VFn9tJLcVa9RDWZWw9gDzwsA8iqvQT2OnP0C2M=;
        b=Pv6RHcCjGIjs9pwGQ23eTlkmfEg0LG8o5WUJZwfXWyeQVP65Wr4NHkHdjE3vB1zBN5
         JM5iKYcuY0HG8aAlCBh+OSFTKVGrsVtKqVMutlMjgklZ9jEOGbVdHWjsb5349o5u1VT7
         JcVd8Xw6tLoUscZ2U+leS5BDIAuhlZc9nb3F3/zxcueIlIOliZkuKV4Ogq24OdF4bRfR
         UFhFd3iXgLnH94wdpE8T5o8Df2MTuPY2Su/ydhaum1fw1ZK0H9WNKXEDCJ2r/Jy063bG
         07bHZEjFPQvAVTf86jJhJ8cV4GQMGO0MIKqkMD9t3aMU9tl6azM4EYy2Q7vU4oi3y3dC
         AIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773140684; x=1773745484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E0Kl7VFn9tJLcVa9RDWZWw9gDzwsA8iqvQT2OnP0C2M=;
        b=VZRSVTt2ceD5CZsH7wiF77rkXtH+mPZh8L61MjAdQ9ux6oHYM1OPAWXjiS/68pJkCx
         MtOSyv2ROu7wElt4BrBf/PFRnkTpS9t9nZ776PDConThlfkDcpj/R6z1ImhZHzAS3d96
         WR3d3YoXTd1F3a3RIEY47Rea8OIHOeiAo8fGmvjb9JFm326q3H3ntKOyi9Zw9Q1qfbcd
         HPj58AOmV5LkZfisGPQVVGgIX2UxRA107bsVcfd9L0N/LR/sJU0hlBflj+K9RWoaoQzU
         CxyZzUe4g7htU+y3YoVX0rEZ9weJPEjgPlncm6oAWis0PPZTbGfyo8pywxOGLs7zMY5i
         cepg==
X-Gm-Message-State: AOJu0Yy/wjRPSrv65Ih5ENh3mca3JjFFTIgR+hJtWXW8QcdVPwFOSpkb
	r+/UOMye0tmzcoAVHL/3qWytixYABh4g43XUR75XqxKL0b+F1++jkW4GmhUohjOQFwIUnDUxSNQ
	duOscMO3WDUlqZKah4jKUXRLvSfK6AAE=
X-Gm-Gg: ATEYQzxm1cx2LfquQW4LZIHGXxhv3EG/SBh5lA68f26JzAyCkJhE1H7/9UkXnbE3K/K
	Orkhh77cFb/wzB9Uu5HXU/p3oLi9AW7s1jQoNiCaYkznn7oMTA0stwX0Xu33G+t7r+cYvFsjFYm
	42VuBO0uuv63iTWE/EKRzNPzoI51P9mjX03v282aRWQg2PLrGyOHorHqrNjldQW9VYbFtADMbFs
	itfr8xg6ijhZ0S8SBd7uQLtO7Y47Y4syGA5z4s2+uMx1E3YdlhBvfexJd+R8v4vgWrj8K7G+JG0
	B3iZ3gYhBjgM2Q5g9hfphpOo+XTguc/ylI3aROou8MdBXMHCCvEcCcle+jRC8Xri9eDsfBfXa9S
	amSm4PHD45BfZG7R31YU=
X-Received: by 2002:a05:6102:3584:b0:5df:aff3:c42d with SMTP id
 ada2fe7eead31-5ffe61e1502mr7182277137.32.1773140683569; Tue, 10 Mar 2026
 04:04:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
 <pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com> <CAOAgETOebObfZNWA5LWMDxYv8YXYpbrb9L3_ASs_AbQjiQZYZw@mail.gmail.com>
In-Reply-To: <CAOAgETOebObfZNWA5LWMDxYv8YXYpbrb9L3_ASs_AbQjiQZYZw@mail.gmail.com>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Tue, 10 Mar 2026 16:34:31 +0530
X-Gm-Features: AaiRm52uYUEVAwmMWRAR2rwS1X4bRKZGy0CU2J9-Y0Ka8LSA5o9FZ1aulo9XZTU
Message-ID: <CAOAgETOQzQceHbevFa_uTQ6rm=9NzsruPqDOJhnj_E_vUp0Bfg@mail.gmail.com>
Subject: Re: [PATCH v2] advice: add stashBeforeCheckout advice for dirty
 branch switches
To: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have as you mentioned changed
> Rebased my files pointer
> Changed advice to git checkout -m
Thank you

Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>

On Tue, 10 Mar 2026 at 16:33, Arsh Srivastava
<arshsrivastava00@gmail.com> wrote:
>
> I have as you mentioned changed
> > Rebased my files pointer
> > Changed advice to git checkout -m
> Thank you
>
> Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
>
> On Tue, 10 Mar 2026 at 4:29=E2=80=AFPM, Arsh Srivastava via GitGitGadget =
<gitgitgadget@gmail.com> wrote:
>>
>> From: Arsh Srivastava <arshsrivastava00@gmail.com>
>>
>> Add a new advice type ADVICE_STASH_BEFORE_CHECKOUT to guide users
>> when they attempt to switch branches with local modifications that
>> would be overwritten by the operation.
>>
>> This includes:
>> > New ADVICE_STASH_BEFORE_CHECKOUT enum value in advice.h
>> > Corresponding "stashBeforeCheckout" entry in advice_setting[]
>> > New advise_on_checkout_dirty_files() function that lists the
>>   affected files and suggests using git stash push/pop
>> > Documentation entry in Documentation/config/advice.txt
>>
>> The advice follows existing patterns established by
>> advise_on_updating_sparse_paths() and can be silenced with:
>>
>>   git config set advice.stashBeforeCheckout false
>>
>> Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
>> ---
>>     Advice on checkout dirty files
>>
>>     This is my submission for microproject [GSOC]
>>
>>     This patch adds a new advice type ADVICE_STASH_BEFORE_CHECKOUT to he=
lp
>>     users when they attempt to switch branches with local modifications =
that
>>     would be overwritten by the operation.
>>
>>     The new advice follows the same patterns established by existing adv=
ice
>>     functions such as advise_on_updating_sparse_paths(). When triggered,=
 it
>>     lists the affected files and suggests using git stash push/pop to sa=
ve
>>     and restore local changes.
>>
>>     The advice can be silenced with:
>>
>>     git config set advice.stashBeforeCheckout false
>>
>>     Changes:
>>
>>     > advice.h: add ADVICE_STASH_BEFORE_CHECKOUT enum value advice.c: ad=
d
>>     > "stashBeforeCheckout" to advice_setting[] and implement
>>     > advise_on_checkout_dirty_files() function
>>     > Documentation/config/advice.adoc: document the new advice key
>>
>>     Signed-off-by: Arsh Srivastava arshsrivastava00@gmail.com
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-22=
33%2FArsh123344423%2Fadvice_on_checkout_dirty_files-v2
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2233/=
Arsh123344423/advice_on_checkout_dirty_files-v2
>> Pull-Request: https://github.com/git/git/pull/2233
>>
>> Range-diff vs v1:
>>
>>  1:  0ed992956e < -:  ---------- diff: handle ANSI escape codes in prefi=
x when calculating diffstat width
>>  2:  c70043a2c0 < -:  ---------- t4052: test for diffstat width when pre=
fix contains ANSI escape codes
>>  3:  185356a454 < -:  ---------- repo: remove unnecessary variable shado=
w
>>  4:  acebdd714b < -:  ---------- The 13th batch
>>  5:  9ec447e3cb =3D 1:  eb5639dbc3 advice: add stashBeforeCheckout advic=
e for dirty branch switches
>>
>>
>>  Documentation/config/advice.adoc |  5 +++++
>>  advice.c                         | 27 +++++++++++++++++++++++++++
>>  advice.h                         |  2 ++
>>  3 files changed, 34 insertions(+)
>>
>> diff --git a/Documentation/config/advice.adoc b/Documentation/config/adv=
ice.adoc
>> index 257db58918..8752e05636 100644
>> --- a/Documentation/config/advice.adoc
>> +++ b/Documentation/config/advice.adoc
>> @@ -126,6 +126,11 @@ all advice messages.
>>                 Shown when a sparse index is expanded to a full index, w=
hich is likely
>>                 due to an unexpected set of files existing outside of th=
e
>>                 sparse-checkout.
>> +       stashBeforeCheckout::
>> +               Shown when the user attempts to switch branches but has
>> +               local modifications that would be overwritten by the
>> +               operation, to suggest using linkgit:git-stash[1] to
>> +               save changes before switching.
>>         statusAheadBehind::
>>                 Shown when linkgit:git-status[1] computes the ahead/behi=
nd
>>                 counts for a local ref compared to its remote tracking r=
ef,
>> diff --git a/advice.c b/advice.c
>> index 0018501b7b..e1264f525c 100644
>> --- a/advice.c
>> +++ b/advice.c
>> @@ -81,6 +81,7 @@ static struct {
>>         [ADVICE_SET_UPSTREAM_FAILURE]                   =3D { "setUpstre=
amFailure" },
>>         [ADVICE_SKIPPED_CHERRY_PICKS]                   =3D { "skippedCh=
erryPicks" },
>>         [ADVICE_SPARSE_INDEX_EXPANDED]                  =3D { "sparseInd=
exExpanded" },
>> +       [ADVICE_STASH_BEFORE_CHECKOUT] =3D { "stashBeforeCheckout" },
>>         [ADVICE_STATUS_AHEAD_BEHIND_WARNING]            =3D { "statusAhe=
adBehindWarning" },
>>         [ADVICE_STATUS_HINTS]                           =3D { "statusHin=
ts" },
>>         [ADVICE_STATUS_U_OPTION]                        =3D { "statusUop=
tion" },
>> @@ -312,3 +313,29 @@ void advise_on_moving_dirty_path(struct string_list=
 *pathspec_list)
>>                             "* Use \"git add --sparse <paths>\" to updat=
e the index\n"
>>                             "* Use \"git sparse-checkout reapply\" to ap=
ply the sparsity rules"));
>>  }
>> +
>> +void advise_on_checkout_dirty_files(struct string_list *file_list)
>> +{
>> +    struct string_list_item *item;
>> +
>> +    if (!file_list->nr)
>> +       return;
>> +
>> +    fprintf(stderr, _("The following files have local modifications tha=
t would\n"
>> +                     "be overwritten by switching branches:\n"));
>> +    for_each_string_list_item(item, file_list)
>> +       fprintf(stderr, "\t%s\n", item->string);
>> +
>> +    advise_if_enabled(ADVICE_STASH_BEFORE_CHECKOUT,
>> +                     _("You can save your local changes before switchin=
g by running:\n"
>> +                       "\n"
>> +                       "\tgit stash push\n"
>> +                       "\n"
>> +                       "Then restore them after switching with:\n"
>> +                       "\n"
>> +                       "\tgit stash pop\n"
>> +                       "\n"
>> +                       "Or to discard your local changes, use:\n"
>> +                       "\n"
>> +                       "\tgit checkout -- <file>"));
>> +}
>> diff --git a/advice.h b/advice.h
>> index 8def280688..c035b5d8e3 100644
>> --- a/advice.h
>> +++ b/advice.h
>> @@ -48,6 +48,7 @@ enum advice_type {
>>         ADVICE_SET_UPSTREAM_FAILURE,
>>         ADVICE_SKIPPED_CHERRY_PICKS,
>>         ADVICE_SPARSE_INDEX_EXPANDED,
>> +       ADVICE_STASH_BEFORE_CHECKOUT,
>>         ADVICE_STATUS_AHEAD_BEHIND_WARNING,
>>         ADVICE_STATUS_HINTS,
>>         ADVICE_STATUS_U_OPTION,
>> @@ -83,5 +84,6 @@ void NORETURN die_ff_impossible(void);
>>  void advise_on_updating_sparse_paths(struct string_list *pathspec_list)=
;
>>  void detach_advice(const char *new_name);
>>  void advise_on_moving_dirty_path(struct string_list *pathspec_list);
>> +void advise_on_checkout_dirty_files(struct string_list *file_list);
>>
>>  #endif /* ADVICE_H */
>>
>> base-commit: d181b9354cf85b44455ce3ca9e6af0b9559e0ae2
>> --
>> gitgitgadget
