Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58871F418F
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773150200; cv=pass; b=nTzHqXGEU+NCTNKXc/9Yz/om1/jfAZEHXorh4nEHN016IBHBzbS4TdwhzjeNFnHas/w/dG+IFlxoBDerB1JDuaiJSR17AY20oxDNug7PQxspvtG1sotI/+ybF+nZSX7kjYR9k4S0p0Itt/uQx/rK3+beu6Ky+UnxObo8s7/Zalk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773150200; c=relaxed/simple;
	bh=gsLolCXZ8XxsHoXr1NTomZ4Wchn/QPOCPRZrTd3ecm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yh1tvI9VinMaGDm4rfGUIxC2grnLciQQrJyz9ckJ0/Ew8ysWVfXLncEAbXxekGpUVY8uKcYD9vENRF6ECT1VesMlCDPhBzMnfxQ/dEGIZgBJ9nINM7RYYJxkGMrxhFwPPH3iiUxWUeJSOuuzDkRnMg+R2chhZpD8kQt+CmX1nOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5RsF1Dx; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5RsF1Dx"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5ffe6887e29so2181319137.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 06:43:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773150198; cv=none;
        d=google.com; s=arc-20240605;
        b=ZPheEGmaP0TpXANwtvbs7XuflZ+ldAJY27gvu7DO+0WETepVZx7V/fG0BSnfjQwSc3
         wB6EiP3tde+AxwQLapF6oWqw8BxsV4M5DmJOSKbOieOJArqk4Ai8/O1GtDumeoJXQGWg
         BEZWlzke0gTvUqUW4+ivTGX9IA57V3z7ukn8IEH/l32YpJHY1ruZV0TBiAe+FBJhXBRu
         C4bDnhVFKolA5mL0xrRwUp0VgzW8zF9sGABSeBrfeZygy8HzFj820BF4f2PzimVoeVDG
         1uT6oCev/Cvc/xzhZZKs3uIzHnVf1+Gc+doi0Fooq7sSxctw92tsZnOGj6Divp2w6nHr
         3RFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wG7t8aQHVVbjmSRr78OlKEv0Dift1CkWhtMuURm0Z90=;
        fh=XVVFyFZMJjkbD6fnpvMqEm5YgTspAOmhENsu3xpjjIY=;
        b=S6yFrffcgpgJvSb2s0mB0DTCzaqB6yQcsO4zM3ggu3iv6hXbp9NxGGIE+DAiUG5xd5
         v918/PA2pyV8vwFuSYBdYvn4OIWN8G7N5fWfsa/u49Lju092e5bD1LCdievew7XFbfby
         LHao59p7608QKed1cWSLZvYPNCcIbIjS0mMBxYrznQD5n/kBoDoiKL2LDkPWoza3+V4U
         1/Koikr3mFZuatleYqVUuwdguafe8q/XfeR5Rr3nqYYJbGjI5z45lcYTpeelaAP2n7RD
         0/ZMds7w1MmtFnH6QyUWZEziZPftlLZYoUsR8we8bLssnng6YmhqB/pGWFv3s4Klp4Ab
         8m1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773150198; x=1773754998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wG7t8aQHVVbjmSRr78OlKEv0Dift1CkWhtMuURm0Z90=;
        b=g5RsF1Dx5j/jtGj+nSiXRNaZ84Qtv7vSF3Vwjja+r77iuKA6DnnTcGj3xetBPX4Xgm
         MrBDirp0lK8RYZsQRdl/Np/YVp26ZKW6YrUXSnUO/CKKH4sSDdFMghhU9hVcdraFiB7f
         6Y6X4Tpmcied+Lhc947CnyZj7HSWtLfh1y/DDDtAWNI8qn5kmaRLuoAGqHql6qGj4cVl
         Ird2qosdlrljfFOw+Rm67ymSLhBgfcD1w2k2uPksNbT0zpRVwW/af2y8O/zIfknB6P5k
         hwPb3fBhIAUZDwAjt+dO/5s0YzaaTVt4mrYl6B57cDm3CgxEbRA1sI0lS0QlSSzlnarB
         M27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773150198; x=1773754998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wG7t8aQHVVbjmSRr78OlKEv0Dift1CkWhtMuURm0Z90=;
        b=i+TkR3/FB6A7hVyt4niPD1Y1/qDLAG3cvHt+oDtjjb9vVAMdXRl2+8+tw43n9t2l/9
         zKYeogOxMjD3WErC+CTsuZ8SeMmlqqM68eEvdoyjf7E/d3BBJWaTTmISnk6ZXqQBwpDi
         LrpemF63tJOPW4lXBfM3L24Wuu2TFs23fDtk+ArIQbGTmqkhXToiMnDkumNwOx8NkLkN
         FmW9WJSHqgb6Ptf5b2b15RUonc+YRVHGRUJ+k0Sr7dij8Yu9jdHkZmoi7lXvhvRClI4s
         /QmeLOlzCKsitUL5R9A1dDKwzMS8FjbKgx3oeKE1GlynJX/NHdmh023ITP4N9IPSlnS2
         5HLg==
X-Gm-Message-State: AOJu0YzbZCAOtShDQZEAAzdela2475/scGeo4Iu8GTzMUVVR5vbJuq0s
	k6fF+7j3V8OuDWRhhgaDqVjbpJIYJcwaefhLVywFNEZsDV2cImBRrYeHJju7JLK8HhK78OgeFdU
	TpR87MXieHvS9zWLxPDtPWLPURdXIqbT+91hDDz7XKA==
X-Gm-Gg: ATEYQzzZ8rPqz0qyEZFZUrPCCgJJOhrrsPCm2vEy6AQLB7JDe26etQmIYw2/G1O58Ll
	rFmMQGPsYp6UAJOjMrfKoOfqTyI2PCqMzdoB4velNtPVJEv/bAzb1WlMFODkSC0F3z7AR4XoDRA
	i2E2CKgFosJdZOQdcrEiY43g6r2OKwevfFgXii2RS5TL0WYOE1LhH34XveP2a+ey6mwqguHg2Ez
	fJXe9y7OezP+jCIXK9SV5NoJ2pIHMUlTXPDealsAalPiHSfz8dNfOt0YtG4TS/BbeevA++m5DO1
	ALt5ea6y5Hc562QGRBy8qHQWTy1rTI2RY5zdcf736ZnCeyJMH7wUeKoaP9K2R250xHWZd2LjuE7
	KjJBZu9wEhwDMEjqRbRc=
X-Received: by 2002:a05:6102:548d:b0:5ff:d1c8:a854 with SMTP id
 ada2fe7eead31-5ffe61e76a0mr6267366137.30.1773150197798; Tue, 10 Mar 2026
 06:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com>
 <pull.2233.v3.git.git.1773149337.gitgitgadget@gmail.com> <eb5639dbc3571fde15f2d93cf2d137b8df775d2f.1773149337.git.gitgitgadget@gmail.com>
In-Reply-To: <eb5639dbc3571fde15f2d93cf2d137b8df775d2f.1773149337.git.gitgitgadget@gmail.com>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Tue, 10 Mar 2026 19:13:05 +0530
X-Gm-Features: AaiRm51lw-KeqXvbWg7IktO6ZQOQbwsxDbgHKyBS3N_OmT-52vmri3ZqPd-Rfa8
Message-ID: <CAOAgETOQ8eEKYc9qwShKOgO+50RzOMQdqTv0G3fOUznmw5Xzzg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] advice: add stashBeforeCheckout advice for dirty
 branch switches
To: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Thank you so much for looking into my PR and i believe
> advice.h is used in the add.c file.
> And advice really helps young developers
   understand what's wrong in their files because navigating git and
   trying to find solutions is very difficult,
> causing them to go to ai models making them copy pasting machines.

On Tue, 10 Mar 2026 at 18:59, Arsh Srivastava via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Arsh Srivastava <arshsrivastava00@gmail.com>
>
> Add a new advice type ADVICE_STASH_BEFORE_CHECKOUT to guide users
> when they attempt to switch branches with local modifications that
> would be overwritten by the operation.
>
> This includes:
> > New ADVICE_STASH_BEFORE_CHECKOUT enum value in advice.h
> > Corresponding "stashBeforeCheckout" entry in advice_setting[]
> > New advise_on_checkout_dirty_files() function that lists the
>   affected files and suggests using git stash push/pop
> > Documentation entry in Documentation/config/advice.txt
>
> The advice follows existing patterns established by
> advise_on_updating_sparse_paths() and can be silenced with:
>
>   git config set advice.stashBeforeCheckout false
>
> Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
> ---
>  Documentation/config/advice.adoc |  5 +++++
>  advice.c                         | 27 +++++++++++++++++++++++++++
>  advice.h                         |  2 ++
>  3 files changed, 34 insertions(+)
>
> diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
> index 257db58918..8752e05636 100644
> --- a/Documentation/config/advice.adoc
> +++ b/Documentation/config/advice.adoc
> @@ -126,6 +126,11 @@ all advice messages.
>                 Shown when a sparse index is expanded to a full index, which is likely
>                 due to an unexpected set of files existing outside of the
>                 sparse-checkout.
> +       stashBeforeCheckout::
> +               Shown when the user attempts to switch branches but has
> +               local modifications that would be overwritten by the
> +               operation, to suggest using linkgit:git-stash[1] to
> +               save changes before switching.
>         statusAheadBehind::
>                 Shown when linkgit:git-status[1] computes the ahead/behind
>                 counts for a local ref compared to its remote tracking ref,
> diff --git a/advice.c b/advice.c
> index 0018501b7b..e1264f525c 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -81,6 +81,7 @@ static struct {
>         [ADVICE_SET_UPSTREAM_FAILURE]                   = { "setUpstreamFailure" },
>         [ADVICE_SKIPPED_CHERRY_PICKS]                   = { "skippedCherryPicks" },
>         [ADVICE_SPARSE_INDEX_EXPANDED]                  = { "sparseIndexExpanded" },
> +       [ADVICE_STASH_BEFORE_CHECKOUT] = { "stashBeforeCheckout" },
>         [ADVICE_STATUS_AHEAD_BEHIND_WARNING]            = { "statusAheadBehindWarning" },
>         [ADVICE_STATUS_HINTS]                           = { "statusHints" },
>         [ADVICE_STATUS_U_OPTION]                        = { "statusUoption" },
> @@ -312,3 +313,29 @@ void advise_on_moving_dirty_path(struct string_list *pathspec_list)
>                             "* Use \"git add --sparse <paths>\" to update the index\n"
>                             "* Use \"git sparse-checkout reapply\" to apply the sparsity rules"));
>  }
> +
> +void advise_on_checkout_dirty_files(struct string_list *file_list)
> +{
> +    struct string_list_item *item;
> +
> +    if (!file_list->nr)
> +       return;
> +
> +    fprintf(stderr, _("The following files have local modifications that would\n"
> +                     "be overwritten by switching branches:\n"));
> +    for_each_string_list_item(item, file_list)
> +       fprintf(stderr, "\t%s\n", item->string);
> +
> +    advise_if_enabled(ADVICE_STASH_BEFORE_CHECKOUT,
> +                     _("You can save your local changes before switching by running:\n"
> +                       "\n"
> +                       "\tgit stash push\n"
> +                       "\n"
> +                       "Then restore them after switching with:\n"
> +                       "\n"
> +                       "\tgit stash pop\n"
> +                       "\n"
> +                       "Or to discard your local changes, use:\n"
> +                       "\n"
> +                       "\tgit checkout -- <file>"));
> +}
> diff --git a/advice.h b/advice.h
> index 8def280688..c035b5d8e3 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -48,6 +48,7 @@ enum advice_type {
>         ADVICE_SET_UPSTREAM_FAILURE,
>         ADVICE_SKIPPED_CHERRY_PICKS,
>         ADVICE_SPARSE_INDEX_EXPANDED,
> +       ADVICE_STASH_BEFORE_CHECKOUT,
>         ADVICE_STATUS_AHEAD_BEHIND_WARNING,
>         ADVICE_STATUS_HINTS,
>         ADVICE_STATUS_U_OPTION,
> @@ -83,5 +84,6 @@ void NORETURN die_ff_impossible(void);
>  void advise_on_updating_sparse_paths(struct string_list *pathspec_list);
>  void detach_advice(const char *new_name);
>  void advise_on_moving_dirty_path(struct string_list *pathspec_list);
> +void advise_on_checkout_dirty_files(struct string_list *file_list);
>
>  #endif /* ADVICE_H */
> --
> gitgitgadget
>
