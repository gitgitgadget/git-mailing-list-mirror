Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795782944;
	b=mpK0cAqY3X4+pUmmIiiLWoPlL324xoZnii5nBfXdxMVVEvAHPARM21ebx3dhHEVS6K7F
	 bnWjroLce9mqt9wz3vs8D02nX01xv+4+Lweyl8oAVB6Xb/lYT7z4icsDKxM+M5+lFvBCJ
	 +WwDGj/rEqWvP5288sfb2V+0bbDFNb9yLBIXC8xXXhdtZDs+STjUDzHRs6Jq9azIXZZDO
	 Uv9YfcngQsEOQu/R/WpaiiXx5iPnIALw/rJK9u0vM3jb6TgRid/d4Dwv/2AjFsQAGETe9
	 E8c5HaiQWnPqCnFm5BINyRMvAG9qJeGg3O0EsCNWpRU0WmCMlpfpnso1t9AfpAHyLiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+3VVA1O7/0++yfNpuv/EXn7CMyHcKqravBOsK69TNa8=;
	b=fAIzWtaQS2o0qvsP6VJHTJfp+E8URultC6bGBAR4zDxaZBf+d5IbONaiI52fZoCo3SpB
	 0M2GOW37m2+Zdm/k54mSU2UeFKmUjkxmHpfahw5yn10qP0ATjfvNwtL0DPaZv97thDYfE
	 la9NRJhmjJMCjOPRuHXf5k0FFax9QsAKyOZj8DGCj4LFOIV9QQJJKq8H4AoSVVGIFspBM
	 HEHuKOq108CvyZtqX4dhTNR5QWebdG1Pep9x58nKHyCw/S6OUpEb1F08UHOTfWIzsQZvk
	 1geoLaHwD6VeKqbXX+YHgkJ5btkp0d671ZZoOx+CV01zLRBhWaXVNnqRvwnMYYQadCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yhR3F07a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD8C606A31E
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 12:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABD8C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yhR3F07a
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5364042eecfso97871921cf.2
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 04:35:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795782942; cv=none;
        d=google.com; s=arc-20260327;
        b=bNvz0s1LGoV6VhxFV2Nb85o6qp+rvANZftEkmicEEN7glQbyJCgUpjWS44gLwruQEr
         Df0bOTt2otvuUwSHWMUET7D+nbghYGjJYDPYGTcxffKqndDwzvzyFdKqKQn+vatr19WO
         QjFWRWsaJcLQDexP3Z+ZinbRPJl91haVxOdxjOoTFLTHDErKnkhUI20bQem/yISregDg
         +v3zqYeTMd+NAICncYtiSxIx3ACB2q3MHv4n5yTCsyfFuE8M4SPlKEvlGFqwAe7QEmHV
         Ce9cYLcMzsx1pyXusurzH/RL3NnvxRs3qRVcp8mOtpbicZ2xmy5paLip1qC8tbcoRhMs
         4T8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+3VVA1O7/0++yfNpuv/EXn7CMyHcKqravBOsK69TNa8=;
        fh=QtxvHiHNSld0Rkhiwdh6yGzLurfOYQ1husIL3zwtV7c=;
        b=shqzlbOPMOrXVCeX+X0xCYPtJMmUb+uliXhXXyo8eF6oRnJ+4TmnjR5OrCvxB/bQMe
         arTyjE/jYKgzWL7aKpFZTuUDjz8nBzHpGZ/13kaxVD1jbRlQ4n2zQXIrpEKwZsWY+4Bf
         wHyI/EJ5LQp+TZZ/RScNBwngmoRHWXYrt/yWfkOtGcEa9esG5LS+3cgZBwvJ5qApRV5V
         KHsnioNdiLAVcRoki7HEREVn06SMTSYGrfrYZ25LmbkzsNKXK1sjssPYgeW+28OVs5qF
         3juAG/mNVKmhmQxTOuRRqcD7lk1h1LonPQvQm7/dqPNqlZwr+V0TF1u/LKd61IvqZicj
         ChbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795782942; x=1796387742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+3VVA1O7/0++yfNpuv/EXn7CMyHcKqravBOsK69TNa8=;
        b=yhR3F07auhVC3ZvebtyEz7C/ZZyuxwH1UvpTHZL/ZNeuGFTsq1sOHiPYpUx4zZvIif
         zFiR+kWlEBDFPjmbq0Lur5NrlkQUuFp3Oep2P2KvT+By6NVoAOjE5miFsfjwCIdO7mm8
         8FIxqCtSrAFlX9LsmmRgTxsmCl1/dhbXGlzmOmXrv0zs6UwIBJ+hEaJRdU7goMso4v87
         s02vv6E+Pv5Dbn2YFhGhbaWn7Np94cGAMq+ZXklZOuJ7E85CkCcGygGGjr9zlWyuQvNQ
         cu+E300IGsQH7qNS2RD4/E+kIy6YVZR83fLgt/Vik25+35aZepH6FkcB6+mMmt6m0LDB
         wK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795782942; x=1796387742;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3VVA1O7/0++yfNpuv/EXn7CMyHcKqravBOsK69TNa8=;
        b=tOu8ZVcWO8EOkHhG94ZRlTY24Vp4sxHVIJQ1MJzejXtRzJMKdZ/a0WFknhhyAL/y9w
         6xOwZhrZdVjKxQL7jpyo/mDjQeOBgHajXCOVSD+CMvdnXdQlADe6ESWJjZmH5e9O5Lz3
         0k1Ql7g3SGPL0z83vZC/ZqpnzqNb1J6/yMq/7QolUjK4nORcjkP2555NHs0LNybxd6oa
         KLLilGwpccpHaNGxQWAdsDu9lYWZgjBh12yyFswAFYQdrhyVsPUClMwZjHKaMSfYiOAT
         E/WNA2WQYEnOENCfCEC/s9RiLUJcV2GbZTzLp8mbiQd3pErF7ILPXGa4s3/7T1PgJKyg
         4bxg==
X-Forwarded-Encrypted: i=1; AL+hErHfuguGFZduGw7MGTgTdRQiyuJwHSHlxlS0cdvnLqXbvGdlBsKLgHTnDXtR0WAEEjMCYYI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8d9GsHLIJWD8HktJq7dddUmAYY8o0tn8L/NUvL7Ponobr1MxW+
	+KMdeG6s3dF6aRsclQUaFtB3v8w/9gEjLEcBmDyOtHur4uW27SFzSjatOnb8j5MjT6lcdH8Zq/8
	7RJrxI6+rHhZxFhm8C2KnyQ80POIJqS8=
X-Gm-Gg: AZFdTZdYSCoQE203H0kb+MOtWjv5IU/4Rith81x8g8paUXIOwc0DpaGagcAk7kSyaUU
	KEV9uBhNMuX73OUfZ6ItG0NE8PXkBwpsmqYJyAd3lqXuoaX22xxkLm6saSuLJz4Xt9mST1CFUT3
	KAdzxjvkHz21dqNNQz1KUWkYGyaMZil1q0T2MnCfwoeQdOW9zpNECQ25fsdyfM1SCl/gErHz5Wf
	kYjGCuhmkUskA74j1DF21XWNcA5Kdn0YV9GvqivXLnlAFNyBBHMCXW/lFWaH25+GRaP1DD0rgNJ
	esJwXXXSj5x+bimIgH+8y5bDtZGJaBtvoRaEn7GO6ITXfmZsnO0j66fbBRJeWP5Zm8itIOIDOKU
	4wNWCKx37Uz6Ao2W2Or/9bX5j9iNxAqstMNtaQbKzrdK4AEqKe6GWkSWZqSVivMWvK3r2nA==
X-Received: by 2002:ac8:5a0a:0:b0:55b:fd16:a2b0 with SMTP id
 d75a77b69052e-55d76aa0eefmr422123221cf.70.1795782942526; Fri, 27 Nov 2026
 04:35:42 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
 <pull.2306.v2.git.1795273853.gitgitgadget@gmail.com> <e816484923b0adb741aec4a36eb5b126ba02a31f.1795273853.git.gitgitgadget@gmail.com>
 <xmqqmrqyoulx.fsf@gitster.g>
In-Reply-To: <xmqqmrqyoulx.fsf@gitster.g>
From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Date: Fri, 27 Nov 2026 21:35:31 +0900
X-Gm-Features: Aa3M54rXAz2FPYXAcIuVckQIZ1_lomoqJOmXqXRx7hjrCGogrlMxWY6SgwR2O90
Message-ID: <CAF5D8-uNTuWQmFvaGwOz9Ft7u1c8SSwBunAx4H9P6zkUhyaxmg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] submodule: store settings in worktree config when enabled
To: Junio C Hamano <gitster@pobox.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 5:14=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +     /* Set active flag for the submodule being initialized */
> >       if (!is_submodule_active(the_repository, path)) {
> >               strbuf_addf(&sb, "submodule.%s.active", sub->name);
> > -             repo_config_set_gently(the_repository, sb.buf, "true");
> > +             repo_config_set_worktree_gently(the_repository, sb.buf, "=
true");
> >               strbuf_reset(&sb);
> >       }
>
> Mental note.  The is_submodule_active() function is designed to take
> the path of the submodule, and not the name of the submodule.  That
> is why we use path and not 'sub->name' here.
>
> A submodule's name may not necessarily match its path (e.g., you may
> add a submodule 'sub' when it was at the path 'sub' and its name and
> path may be identical, but then you can move 'sub' to 'mod/sub' and
> now its path is 'mod/sub' while the name is still 'sub' to preserve
> its identity across such a rename in the superproject).  We need to
> be careful which one is used by which API functions.
>
> > @@ -1673,17 +1668,31 @@ static void deinit_submodule(const char *path, =
const char *prefix,
> > ...
> > +             if (the_repository->repository_format_worktree_config) {
> > +                     char *key =3D xstrfmt("submodule.%s.active", sub-=
>name);
> > +
> > +                     repo_config_clear(the_repository);
> > +                     if (is_submodule_active(the_repository, sub->name=
))
> > +                             repo_config_set_worktree_gently(the_repos=
itory,
> > +                                                             key, "fal=
se");
>
> This call to is_submodule_active() using 'sub->name' would break when
> the name and path of the submodule are different.
>
> It would also be worth covering a submodule whose name differs from its
> path in t/t2405-worktree-submodule.sh.

I've confirmed the problem. I'll fix it and add a test in
t/t2405-worktree-submodule.sh.

> > @@ -386,6 +389,26 @@ static void copy_filtered_worktree_config(const ch=
ar *worktree_git_dir)
> >                       error(_("failed to unset '%s' in '%s'"),
> >                               "core.worktree", to_file);
> >
> > +             /* unset "submodule.*.gitdir" */
> > +             for (i =3D 0; i < cs.list.nr; i++) {
> > +                     const char *var =3D cs.list.items[i].e->key;
> > +                     const char *subsection, *key;
> > +                     size_t subsection_len;
> > +
> > +                     if (!parse_config_key(var, "submodule",
> > +                                           &subsection, &subsection_le=
n, &key) &&
> > +                         subsection && !strcmp(key, "gitdir"))
> > +                             string_list_insert(&keys, var);
> > +             }
> > +             for_each_string_list_item(item, &keys) {
> > +                     if (repo_config_set_in_file_gently(the_repository=
,
> > +                                                        to_file, item-=
>string,
> > +                                                        NULL, NULL))
> > +                             error(_("failed to unset '%s' in '%s'"),
> > +                                   item->string, to_file);
> > +             }
>
> This code is trying to copy the worktree config, but this removal would
> not work if the file happens to have duplicate 'submodule.<name>.gitdir'
> entries.  Perhaps use repo_config_set_multivar_in_file_gently() with
> CONFIG_FLAGS_MULTI_REPLACE as you want to unset all of these?

I've confirmed that duplicate 'submodule.<name>.gitdir' causes
  warning: submodule.sub.gitdir has multiple values
  error: failed to unset 'submodule.sub.gitdir' in
'.git/worktrees/foo/config.worktree'
and it is fixed by using repo_config_set_multivar_in_file_gently().

> Do we need to say something about how various 'submodule.<name>.*'
> entries this patch touches interact with 'extensions.worktreeConfig' in
> the documentation, perhaps in Documentation/config/submodule.adoc or
> somewhere around there?

I will update `Documentation/config/submodule.adoc` to note that
`submodule.<name>.{url,update,active,gitdir}` settings are written
to the worktree config when running `git submodule {init,sync}`.
I intend to omit a detailed explanation regarding the behavior in cases
where these items already exist in the repository settings.
However, regarding the inheritance of `submodule.<name>.gitdir`,
I will consider adding further explanation in a subsequent commit.

Thanks,
--=20
Yoichi NAKAYAMA
