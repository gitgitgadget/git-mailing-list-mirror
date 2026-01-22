Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585638BF78
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095745; cv=pass; b=kgo32zvb97EbJES9116sMdefRQtveYMhdBE8clwe0beKkhOnbvtJYGX91cIUP7DCI1J36aMcaSwiI8ryBHhINxVv44D63Lfc76gEt/JIGbq1NCjKUTdn1jvCkC4OeshB6d0rQMTNolrYpSTjd+jSjMuNhf+8VEIAyraulLgYfhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095745; c=relaxed/simple;
	bh=XwsiYd/LJoJvrNRLNqFcADC/dTBsk1pDpwlDJbDmvYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7mwqDgZkcauGtsTUEP7ZUkjluz8ndDtp5ac6heeDylHri3YJA4yYzdl2Ive6T9WS5B7HRPFnKned8AQ9w4vtEMXAsQ5I0EWjPr0PVqq63btd1KXLMmAuKRd0LZCeCSMctPCdyRz1TN+D2IBLlNdOOtfg4VpXQ0h6hxBRfDASw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNxbJl30; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNxbJl30"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12331482b8fso349532c88.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 07:29:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769095740; cv=none;
        d=google.com; s=arc-20240605;
        b=ArnKnLBW21DtDfzf/NZSYXuffSspc+9qwrNzZtakg8VtH+phuKdSW9EKtHDu95sr7F
         3uid4f3Nzdwa6VghuyuUfkdJ526eSGm07bUo2XY+Ds5AGY3qFT8pi9caZTlrZBGHOrLE
         SWgxUx5Fy54K2iZzb3UEGSb+JSQCFs5Kc7EhJ3kaYnFUToPJ4gQ9+BQXjPLM/Ks++JVM
         PoQXQh3ZO8xR5R9hzEfiWooA+xl1pa6lECvypzFt3UvfYr9VnFO/esXCjIZRLtJAlLFt
         an1UunBlulmVZUMWPDk26rjUxqzLtlrcITiOTU4TXl1X5EuF8+rhGZon9TDPvEjlsJzd
         LPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cjLgZf5P2/uHRakG/1BJN/Bmlk/QbTiRy9n3wd6jSfM=;
        fh=SUtS5Uxcs1MaW7qAkYHaLrxMI/luGLAfuRKahcKGaig=;
        b=VUWuPb/LKrIRc4h2RrezbiquVC2CjXNbfXK3JvQUh4MPsPOcHeE3P6XS4zgnkzBu5s
         CQBgWI5nbz3Pz8FVCzjv41YGGoOQnCgzjg9MfYGSIHPMzFlkW/aV+yCGaFJsQJRVRykg
         QGAKFuM5TEbY9yPBzPkoDRVzwYkwHJs80irZEA42zENewaI2gJ1eMpxznyAgm/AqlzUu
         l34eTLW4nFc1kakSRbfmkpLMjxbKAevGmTT+2dSSmTGC7SfbhHe9kMxVYEY8CB2d2zgN
         gXbavT4AcqtHkdDT64V0ARDd9pU447uGNWs3Khqymr5X4y7gqYPyKbT2A/XMOJ4WG70U
         EYtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769095740; x=1769700540; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cjLgZf5P2/uHRakG/1BJN/Bmlk/QbTiRy9n3wd6jSfM=;
        b=RNxbJl30IufFHvV1KKrbPmZtnysNiiUnvaxvo/1vZupIZvkq6ojH+GF8ft+Y+bUmi5
         WpnF/ryqmbe74SQfQfeMcX5n0Ysa+IIKKkFFOyPLYfqq3JkmSwv5/8Y4E2ZU1TR43erp
         j2f2ZQM4Ke1bsmcNEuaQFY0i0CRw6wZmjqDdbM0a752W7tTWqedseHaaQwhbuWnz0LSq
         qMflsUJ87TXt5s9V9+cp1Hu+k+Wd7VLVHfQLaKdpDfN/+rfabU2IU6lF+pBe7DQx14T8
         wDaZCuplFCt5leVr9mcBbt7mX18/XRkt9P0BBG6BNU9uOqK4iaukYs3JUUWiwEv63jS5
         Fj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769095740; x=1769700540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjLgZf5P2/uHRakG/1BJN/Bmlk/QbTiRy9n3wd6jSfM=;
        b=cFYFkEpMJ1AlKnpwYJH/7/GXpNSBSfSTHMK3d/bCtOVeWD8EKnieNmMyAp06rMaM2h
         Hv6Dgs8FwusVSPn5NYzHTmhO3mxlv5kNTQU03HiM/DipZuTbr/bj99DZd6vEg7lwpOPx
         LAjv1vOVDEP5E4+Uq1GG8nU+EhTnRj1BA32cARwg4ZAKIZRIXpo1rhO5rdh4GwZcXqp3
         aAjikSlaZLO5eBO/GctbHBRjInKsC8XYOkoz49NMhRGz7eyBqQ7uzfVM0sgYGRmG4PS1
         4nW2S17fc36xdQNubnwxPMyLJeRv2KMZr4WMWaG1372XSGk/ht0Uj2T2WkAZ07SIP3cK
         LA1g==
X-Gm-Message-State: AOJu0Yye8voZFq5ufTLAtV69vhmEkryR7wy7eSiZO/4g6tgwJf/pq0xJ
	t4+j9xJCDafD/Qzctxp8hh7lJVu5KzHPUbzPvAwv3XEoFmGpbK/h4ATM+O7/UQAPfUhHV35MLvH
	wdGl2Zs0ywbYOYvhBjaKcoH22QnGg/GdeCkKxXXxWJA==
X-Gm-Gg: AZuq6aK5/REg/+JXxPKHP3Z8Szm5BHjZnqJpOhPdXRV3P/oMO710ykFCYScZ+teDzzs
	SvTrfMt/QOs3WatSZd9vbAoS72MskJA9QlLmnb5zyybt0OwnXNAn+j/Vwu01J5+v1+PoZybt+fW
	Z019Ix9JN3s/0u21kK2ITAXik+D8LUBCTJBQEcQtu37A3CElyTHI5Y8O45/1IOGw8Mf//wghUpV
	yZUk8ykhhh0UyVArFvQk0dVuQ98RFu0Ddz+a3g2jQKhHS5/NYo+sRM8pLx57o8s596yWFvPUP8=
X-Received: by 2002:a05:7022:4393:b0:123:2d62:2e8d with SMTP id
 a92af1059eb24-1244a717ef4mr16271779c88.3.1769095740014; Thu, 22 Jan 2026
 07:29:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768681947.git.belkid98@gmail.com> <fd95169de42891452b430814476d78c706e4a7e2.1768681947.git.belkid98@gmail.com>
 <18b5d932-8a5a-4f33-a803-ef6f0c7d2750@gmail.com>
In-Reply-To: <18b5d932-8a5a-4f33-a803-ef6f0c7d2750@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Thu, 22 Jan 2026 16:29:01 +0100
X-Gm-Features: AZwV_QhnZ0C5bZUSPhC3Jpm0687aY6Vv7WqswaTmtzygFN-ZJEOFVfe7Le_GocY
Message-ID: <CAD=f0L9JhJq95kV7oUsaN5FqmUAH2qeSTLPLYXKAHUtNiHK_WA@mail.gmail.com>
Subject: Re: [Outreachy PATCH v3 2/3] environment: environment: stop using
 core.sparseCheckout globally
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com, 
	karthik.188@gmail.com, Toon Claes <toon@iotcl.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Jan 2026 at 15:41, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Olamide
>
> On 17/01/2026 20:59, Olamide Caleb Bello wrote:
> > The config value `core.sparseCheckout` is parsed in
> > `git_default_core_config()` and stored globally in
> > `core_appy_sparse_checkout`. This could cause unintended behaviours
> > when different Git repositories running in the same process access this
> > variable.
> >
> > Move the parsed value into `struct repo_config_values` to retains current
> > behaviours while achieving the repository scoped access.
>
> It doesn't achieve repository scoped access though because we only ever
> populate the values in "the_repository", all other instances of "struct
> repository" are initialized by config_values_init() but not the config
> settings.

Okay I understand.
Thank you for clarifying.

>
> > diff --git a/builtin/backfill.c b/builtin/backfill.c
> > index e80fc1b694..5fc8c51ed1 100644
> > --- a/builtin/backfill.c
> > +++ b/builtin/backfill.c
> > @@ -139,7 +139,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
> >       repo_config(repo, git_default_config, NULL);
> >
> >       if (ctx.sparse < 0)
> > -             ctx.sparse = core_apply_sparse_checkout;
> > +             ctx.sparse = repo->config_values.sparse_checkout;
>
> Using "repo" rather than "the_repository" here is dangerous because only
> "the_repository" contains the parsed config. This applies throughout
> this patch.

Okay noted...
Sorry but I have a question.
I observed that the address of "repo" is passed to builtin/backfill.c,
is gotten from git.c:handle_builtin
which passed run_builtin "the_repository" as a parameter.

Won't the address of "repo" and "the_repository be the same"?

>
> >
> >       result = do_backfill(&ctx);
> >       backfill_context_clear(&ctx);
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index b19b302b06..b6b19e83d1 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -623,7 +623,7 @@ static int git_sparse_checkout_init(const char *repo)
> >        * We must apply the setting in the current process
> >        * for the later checkout to use the sparse-checkout file.
> >        */
> > -     core_apply_sparse_checkout = 1;
> > +     the_repository->config_values.sparse_checkout = 1;
> >
> >       cmd.git_cmd = 1;
> >       if (run_command(&cmd)) {
> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index 53cccf2d25..525edb5e9c 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -482,7 +482,7 @@ static int grep_submodule(struct grep_opt *opt,
> >        *      "forget" the sparse-index feature switch. As a result, the index
> >        *      of these submodules are expanded unexpectedly.
> >        *
> > -      * 2. "core_apply_sparse_checkout"
> > +      * 2. "sparse_checkout"
>
> That should be something like config_values.sparse_checkout to make it
> clear that "sparse_checkout" is the name of a member of a struct, not
> the name of a variable.

Okay noted

>
> > diff --git a/environment.h b/environment.h
> > index aea73ff25b..3b5ff7094a 100644
> > --- a/environment.h
> > +++ b/environment.h
> > @@ -88,6 +88,7 @@ struct strvec;
> >   struct repo_config_values {
> >       /* core config values */
> >       char *attributes_file_path;
> > +     int sparse_checkout;
>
> There are several other sparse checkout variables like
> core_sparse_checkout_cone that we'll need to convert in the future so
> "apply_sparse_checkout" or "sparse_checkout_apply" would be better names.

Okay noted.

>
> Thanks
>
> Phillip
>
>
> >   };
> >
> >   /*
> > @@ -169,7 +170,6 @@ extern int precomposed_unicode;
> >   extern int protect_hfs;
> >   extern int protect_ntfs;
> >
> > -extern int core_apply_sparse_checkout;
> >   extern int core_sparse_checkout_cone;
> >   extern int sparse_expect_files_outside_of_patterns;
> >
> > diff --git a/sparse-index.c b/sparse-index.c
> > index 76f90da5f5..6dd8dd679d 100644
> > --- a/sparse-index.c
> > +++ b/sparse-index.c
> > @@ -152,7 +152,8 @@ static int index_has_unmerged_entries(struct index_state *istate)
> >
> >   int is_sparse_index_allowed(struct index_state *istate, int flags)
> >   {
> > -     if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
> > +     struct repo_config_values *cfg = &istate->repo->config_values;
> > +     if (!cfg->sparse_checkout || !core_sparse_checkout_cone)
> >               return 0;
> >
> >       if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
> > @@ -670,7 +671,8 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
> >
> >   void clear_skip_worktree_from_present_files(struct index_state *istate)
> >   {
> > -     if (!core_apply_sparse_checkout ||
> > +     struct repo_config_values *cfg = &istate->repo->config_values;
> > +     if (!cfg->sparse_checkout ||
> >           sparse_expect_files_outside_of_patterns)
> >               return;
> >
> > diff --git a/unpack-trees.c b/unpack-trees.c
> > index f38c761ab9..2bdfa1334c 100644
> > --- a/unpack-trees.c
> > +++ b/unpack-trees.c
> > @@ -1924,7 +1924,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
> >       if (o->prefix)
> >               update_sparsity_for_prefix(o->prefix, o->src_index);
> >
> > -     if (!core_apply_sparse_checkout || !o->update)
> > +     if (!repo->config_values.sparse_checkout || !o->update)
> >               o->skip_sparse_checkout = 1;
> >       if (!o->skip_sparse_checkout) {
> >               memset(&pl, 0, sizeof(pl));
> > diff --git a/wt-status.c b/wt-status.c
> > index e12adb26b9..a2e388606f 100644
> > --- a/wt-status.c
> > +++ b/wt-status.c
> > @@ -1764,7 +1764,7 @@ static void wt_status_check_sparse_checkout(struct repository *r,
> >       int skip_worktree = 0;
> >       int i;
> >
> > -     if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
> > +     if (!r->config_values.sparse_checkout || r->index->cache_nr == 0) {
> >               /*
> >                * Don't compute percentage of checked out files if we
> >                * aren't in a sparse checkout or would get division by 0.
>
