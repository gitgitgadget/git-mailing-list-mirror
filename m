Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ACF3A5448
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791657431; cv=pass; b=W+OvZc9iVvsSMZWL/O7nOt/4cXD6V7yfDJHAV2rMoX3Jiqpj/6dPg/VxhsBDFKM1EcJyTGdEKNCYsB83/WGZJoUqwqXJrPnD8YTd49dKwLpU6EzlOyP6TAwBDosHNi5eVvduCxXDg/Q/Vz0BXyNVk4MwajSdU1jATfLAbSLAfng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791657431; c=relaxed/simple;
	bh=LT3O7zpOPX5TbdJFcSGUYH+S6ZJVWiy3hXn+Tdogw4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUkNHg9lSvYzjCrYu/J5gQs23kYzmintjIRFEKCKFT2W5QipE9XVApho0mFfPo3QjZ0Ti+YnlbYX/SKH0dZVa/h52AwloN9fB46wrjLsJ5GgIckNAtX+vpbRs4+fxkunf7CkpNi57KieT+EkAk5bD4B28HpVlL7gRuMqclmkHcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3+h0gDJ; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3+h0gDJ"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1aa29e06bso146332a12.2
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 11:37:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791657425; cv=none;
        d=google.com; s=arc-20260327;
        b=AG/DI96lkYiSlrtDypPze7SJ0blL273oPtg8as/rDZT0mSPtITZL50V7q5QyO9Pjlm
         SDApLScaFjUdUrTQHmq5ulkmmIPu/Ax0XmRMLZ5IF+qrZZn2j5UjduzP0zu1IcPPJtyq
         bAKssmdiIzepEdYvRLIJwxpT/6iE1Ku94EJeW5AuZj2/b2kzZKEbj79DCjnbOhjMQBiX
         WnJg6NnqdTQK3QsA1SbOFz1a2oM30F49N6NN2nUBboB+VQqG59V92ncnxWmbgoCI7it+
         rO/Sdm2Ni11qEIKc9Sh0Wwe8W6wSyQLOYejKoAU2D7fzP5bGNr0PgVMD0eTSq8wjbFJb
         5WiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Reh/xQnBBV5DeUmf+JA7OogHjmBMXIPwv2mxPOOJNRU=;
        fh=RMp5wytCHyOXDOnJXLEozqdl9TQsEZ64Vxt7Hbn/ZnY=;
        b=EWsHdNhsSQAZrdtO60/8Ql6rhFqXN3/VDHA9tAWuI6QKHTjn0OfnISITiRb/LORqAg
         Sy6RDcpjeDUefC1xjA/AaM58B7tRJfvpVsQnKL8SGlzVkZz9cGwreZcEkOoLQn22yabv
         4tuNKPVjGxloXjfgZh7eQdww03sDMkogjd9DJobBvOL/GxRxX+HbleMS+Ibyt7nK+S9Q
         Ar3pPnLJfzdzllLjr3CsKyqGSP63e4ABcS2rXUePZGB8a1vZunA3zl9AoisJm/tQWic1
         55aejMccS8TUGUKvw4DPZLAo8VBd6znsY5AAJZqqKc3Sa+XQuK1rF8PV9EunmtLmylDK
         AZ4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791657424; x=1792262224; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Reh/xQnBBV5DeUmf+JA7OogHjmBMXIPwv2mxPOOJNRU=;
        b=h3+h0gDJZ70OmVgyJbY4U1e/4+Qfy0nCH6dwCWChhn10rcxVCNvsZ1ow5C0ZlMLGYy
         mehazLyb02psozaxDiEuN1hPc70KOaWZ5iGX0Tibrfvqv1fuHYyeiUNtDE1lHxg3rZVt
         Zn/8wURbRBc6HFvdZEmy89uHTaHLJFz/G7J4eMot50/ofmElrnsUy5/sjj5n4VwMQ27H
         9ig17Jp4xcAp3q82nE1g/GaRjzJWj0mMHGBVcQ1rPOFEGmsic8HYhPL0gBNj4sGeOCG4
         NWHXIeZ96xLg6ajgdwHMaWT7Ls8kl3xwNaEWyhTik10CW2ptv0jiZ56OU3+R6oPKXISN
         BI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791657425; x=1792262225;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Reh/xQnBBV5DeUmf+JA7OogHjmBMXIPwv2mxPOOJNRU=;
        b=ZRPVwAQAeAMmor9CCMx05BirL6dbvYZADSiyeJTNIoa+Fp/tcfqZaqNTPp4jnw/U6O
         /lboNlypHy04XaKBye5C58k7Jq9v7iaRrg3uc7on4bFC8piUdv8HukM36ogc3o4nV9Gt
         ueRmNqzIGcC7kGp54gSGMd5r99hpcOevktrAK+2n4s06WGLJ1HryBAzSf24tPlID+RsG
         oPomSC0L6eO7gCZLMI+avzn26rRciJ6W5Qb978S+ZsaDiGAAXsaPQwMG/e86QiCry8sC
         bGjrh+xT3snBxhepxz2jT6/CdgbVw/v0j/icIBP6jGVwV2CkTg3GtKTBD2jo5e2C8Ocy
         nXJg==
X-Forwarded-Encrypted: i=1; AKwUvBzuQBM8j45rXDB3QsmB1ggwCP8pybqxSzEargHcFyPxv9XLh9Ne4/s358Y+olKxghw1suQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkhs46vGCdDhiuEeTyvyS5/JdQtU7FFlH50wSqXm/otEbcNjAh
	nfUhcmMSXfhM3EqRKy+Psgx/SeOs6/+Em72jDk7ygJrdr397F0ZwlUB5KCBRx2Lh/IXu42zzBeh
	K5boBPx/+CAv/n0iDgoXFioFvFXR5o/E=
X-Gm-Gg: AYBFou3tRSJDXJIiyK84FQn6HBAw7FM/TF6SbqmDN35aY1Njg8alQIh4vdG6B+s0oXb
	eIorFT25dTR9iq1P35vdbqHkzXcBdm92P+64CAv+SUc6kDHejp8CQFZvB2h0uP/WTnrzIDyQsRg
	uTeTcSCEm8gn9GyigDr06KJ8eaZdIwRFznNzs3z9Oy5t7X+4h8I/Cc3ixW7XUjzq5BAodHEBejJ
	vaZe5Y2pHqHloYvWslOM5Lm85DEX81lEMF+6DMZibJEaJrMhPFniwsGBmnW3wG+eJFHQOMRmox3
	n+ZxQ+HjwyjvHAsviKEgW4kkY6JHGya3gX5LOiq5ra02lBf9O60IfrE=
X-Received: by 2002:a05:6402:518b:b0:6af:7ad4:8b26 with SMTP id
 4fb4d7f45d1cf-6b17c27665emr4823717a12.33.1791657424355; Sat, 10 Oct 2026
 11:37:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v8.git.git.1791619334.gitgitgadget@gmail.com> <08fea07a8be8a91ac54db44f9c035ecb49c86c9f.1791619334.git.gitgitgadget@gmail.com>
 <xmqqik39iipg.fsf@gitster.g>
In-Reply-To: <xmqqik39iipg.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 10 Oct 2026 20:36:26 +0200
X-Gm-Features: AclHuK8Ngt-yY8v8Fa6Q7ozY0epI8dS17REyP7AwOrEerLqu4OewbfaAzdWoSjI
Message-ID: <CAHwyqnW2FqKBUK=s9ZL_kwwZDf2WE87qT9YN-syLs2O5FXpMtA@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] fetch: extract collect_upstream_from_remote() helper
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> IOW I would have expected to see
>
>         } else {
>                 if (transport->remote->fetch.nr) {
>                         struct string_list tracked = STRING_LIST_INIT_DUP;
>                         struct string_list_item *item;
>
>                         refspec_ref_prefixes(&transport->remote->fetch,
>                                              &transport_ls_refs_options.ref_prefixes);
>                         if (follow_remote_head != FOLLOW_REMOTE_NEVER)
>                                 do_set_head = 1;
>                 }
>
>                 /*
>                  * The configured refspec may not cover the current
>                  * branch's upstream (e.g. a narrowed -t refspec), so
>                  * make sure we can still fetch it regardless.
>                  */
>                 collect_upstream_from_remote(the_repository, &tracked,
>                                               transport->remote, NULL);
>                 for_each_string_list_item(item, &tracked)
>                         strvec_push(&transport_ls_refs_options.ref_prefixes,
>                                     item->string);
>                 string_list_clear(&tracked, 0);
>         }
>
> that touches "help the current branch when rs->nr == 0" part and
> nothing else.
>
> Of course, because the next step [3/5] wants to split the above
> else{} block to do different things between the case where
> remote.*.fetch is and is not empty, at that point the extra
> code may be introduced there, ending up with the shape of if/else if
> cascade as we see in your patch.

This is a good point about how commits tell their story, and I'll look into it.

Thanks for the snippet!

> > diff --git a/remote.c b/remote.c
> > index 99a086ea5a..5e980625b8 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -1884,6 +1884,21 @@ int branch_merge_matches(struct branch *branch,
> >       return refname_match(branch->merge[i]->src, refname);
> >  }
> >
> > +void collect_upstream_from_remote(struct repository *repo,
> > +                                struct string_list *tracked,
> > +                                struct remote *remote,
> > +                                const char *refname)
> > +{
> > +     struct branch *branch = repo_branch_get(repo, refname);
> > +
> > +     if (!branch_has_merge_config(branch) ||
> > +         strcmp(branch->remote_name, remote->name))
> > +             return;
> > +     for (int i = 0; i < branch->merge_nr; i++)
> > +             string_list_insert(tracked, branch->merge[i]->src);
> > +}
>
> The original tries to avoid branch == NULL causing a segfault, but
> the above does not.  Intended or overlooked?

Overlooked, but I don't think the segfault would actually happen (in a
way that could be reproduced by a test)?


Harald
