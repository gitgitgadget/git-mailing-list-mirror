Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A68340D82
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094500; cv=pass; b=IiPrR5aTKxFeo7oLCWIQZ1WGxv/c1RKeeuzcl53uGtiYrz2Cn/LRKXj6GO1kHyHz7PMfOVeGXAKjQAbaCi1jF6Z7MWJ7ZTnURuWBDXoZ77OWMz0FSDySuT3tW8BOLTuQwb9IMcb2rykakMu9YkAOfZP6ydwEOgJ7xgG3mDeJqBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094500; c=relaxed/simple;
	bh=wNka6JYy/npVkIhs/X7mR3mOiT7P0VaH+p6Zt1ch6Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFdybcEZy0GhlTSZExHZ/15dgnLDTzvLJRRPr952BP69Ee5C7AcsY8CeXwFCDfNRVfyenTNDMswEfOM6b3G61Wmk8fCKKRXt2lvzr8CTStRjipgYpioMl0AogxzYWoZKLkezuy9zBqXMkstqPLazOplCyA8KR/xBssLImpmd7nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOmNkLHV; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOmNkLHV"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-121bf277922so1866790c88.0
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 07:08:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769094497; cv=none;
        d=google.com; s=arc-20240605;
        b=LwtYhbLZylOu4+6yG8qk/nyt4g7Y8USn2HvKFh32S3/hMh+ISMDF2/oKkS/DMi654c
         DdnhRRLuB4u+Z6dFLT9qlA2mHn/+v0fYUdFUIXsJTK34wwSYZnezQ4JbNLvSl0+vQHcX
         sKhPOGFJPdUILhQP5gzkpkHFdBwQIpr5SEfnv5kHSbX08pRNF03PXLSejSGKr8X9aYBR
         RkC5rX0mS8kTcTMqdHntuMckMpwKhWDr7t1kdo1ztwCWJy0XCWcCoI7htNRr2wHN6jRu
         91iUr21Ou/2PO0S1tM0zxXmmqeZQ8poVN/M3LdzNOi4KO44a+n5cENeDFNGQ1teoppCH
         JUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jFAW8yiXnILKEhCCh3uMZl5oWilYsbLfWKqmS+Qct6g=;
        fh=Oomd9UZxwatfJrvTLtxnKYh6qyfPcZbkPkPBNqnBf4Y=;
        b=k3izkxl4YKtb0spUJIrgIhSrnKPt0s7LQFLiOyarB7aZ8GpRr8e2BEavoNE5Y2ZRA8
         Ktbdq4jTm+gIOfYw/eZscyOpn8aG7bJqq3NyIUWVs6TMs96TChEnYIFsz71bmqoiy7Zb
         /oa2PiH5L2M8pvv1vqWy9JHR9IwSNojoP2wnvF9inerv3bJ5ro2iu8ZcXN0bjuk/InpT
         dwlfMcFvo4fCJQEykXet+aQkTEYwJmpsPj4o3kohFuzWNvK+7s5MRk44kgEnIEqhaX5b
         yBdQbK4Q4yevMO08zo3dZ/JfzJF5o7QmyKmMfLbhcTnugJmB7zfih3fijwv6ytgAVUv6
         X0YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769094497; x=1769699297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jFAW8yiXnILKEhCCh3uMZl5oWilYsbLfWKqmS+Qct6g=;
        b=ZOmNkLHVALHYAaeyakhx45872iNbwfrDnhcweUD70m1Yq8ZuKgJJ8w6YXDwc667SlJ
         Z3k+X4P9CdOxOoXNp92fuTR0gTy4u631crhAyIno6uYm8iRtdWUxA0Ri27fK9S3kYQkv
         A+K5nY/ZE/4PvFgXREHur5M1+IMdFhZCuq2kHFyu5CXRAoecTf2+B5o8toE58OTZx2fL
         3J8wNACU7FcxOhCwkU9iay4LVbqCMeot3eBBAt0sm8HYS9Bvto+MpjJ+GDEdQ+yuWE0H
         5VGWE341Ik3Zsx0aYUYWaANnssihwhNyuh2p8sXYuFsUbGlSotWzgtnGH23+sbC28zbR
         12+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769094497; x=1769699297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFAW8yiXnILKEhCCh3uMZl5oWilYsbLfWKqmS+Qct6g=;
        b=HgqxZhF8vbAfK3+SppeGG7qp6EMUtBVmielsbVjD7YlQi2gZv24JPFStmhnVrjrJto
         BJ/B4Pn4flQyWuPlR/J3uVvtOeTKLU4xpI0MUgXfoXsIsSK+KnHjYtIeu5UPVuyqNBZ9
         xS/U7i3azxUwVXY87WRP2Q+szdzmhanGArsZ4E0z3A6UOHKZtxJw4YZnKEc079i/54oV
         VX/FS0/Ww/pTiwUHv54vt7P70nB7skCpmFFmlnz7zMulY+EppgMnp9LPFSVuRJz1JAcz
         9iLLeE0dDGIG+2DcjymsjK3/b5vn3xeLrtoxOd+OHILn6fG0yCN91g464wYGSomc9XSY
         ELXA==
X-Gm-Message-State: AOJu0YxcshBpMGqzlfjuUAdUI6qBpdi/V0685BG0DX2O3/getgT9cFhi
	8HhfNDpv5t5nXvyJXKBxBjjCMCg4zqvCRqkCFuOb2RFw41ytGAq+i9tGKAUFxeMjJ+KsE9Sy4CB
	0BAarDg2GP3AZspcG7X+oqqxtyD+QvpA=
X-Gm-Gg: AZuq6aLL20+7w/Vk3L/g36xnJIx9AJoWvLFQ/zvlzBBxh9HYe3FywRA2/ExFswJQ0V/
	7OVQ2tMJRodMOlHv6ByjN8k25mEHpLNaL+waXWGzhASk02No4Vz4mgJjyxx0mB9f8yjHAelZxUv
	vdPGlTgItr5vSgl0n+/22f4dnrhqCY4MHEDutau81F7KoX0qzckcm4zBUxyX7MPebKUNma2DI2y
	GgIwHiX47G4X5b3YRDqx8hDHP/ZaccEo2mtQ2Oh9Hmo9uABELjraBpTw9vbHa4dgkDBYVPBuf0=
X-Received: by 2002:a05:7022:1e01:b0:11b:9386:8265 with SMTP id
 a92af1059eb24-1244b36db71mr14887060c88.42.1769094497126; Thu, 22 Jan 2026
 07:08:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768681947.git.belkid98@gmail.com> <1aa41da8334296e4c1063b81fc40ec3b1dcdcb7b.1768681947.git.belkid98@gmail.com>
 <871pjhkfq7.fsf@iotcl.com>
In-Reply-To: <871pjhkfq7.fsf@iotcl.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Thu, 22 Jan 2026 16:08:18 +0100
X-Gm-Features: AZwV_QjC2cQFt1fN7S8wd2afvfQPS27yl7SmFAPStqG0ZudwFOU34zYm-_JCHIg
Message-ID: <CAD=f0L9nYtuiUEDVC9UcKSCThqQspR8TDzoegAte3jBepxdE_A@mail.gmail.com>
Subject: Re: [Outreachy PATCH v3 1/3] environment: stop storing
 `core.attributesFile` globally
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, gitster@pobox.com, 
	christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	kaartic.sivaraam@gmail.com, me@ttaylorr.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Jan 2026 at 13:13, Toon Claes <toon@iotcl.com> wrote:
>
> Olamide Caleb Bello <belkid98@gmail.com> writes:
>
> > The config value is parsed in git_default_core_config(), loaded
>
> I assume you mean 'core.attributesFile' because it's in the title. But
> personnally I don't mind seeing the name repeated in the body to make it
> more clear.
Hello Toon,

Okay thank you for your review.
I will take note of this.

>
> > eagerly and stored in the global variable `git_attributes_file`.
> > Storing this value in a global variable can lead to unexpected
> > behaviours when more than one Git repository run in the same Git process.
> >
> > Create a new struct `repo_config_values` to hold this value and
> > other repository dependent values parsed by `git_default_config()` and
> > can be accessed per repository via `git_default_config()`.
>
> I'd suggest to split off the part after the second 'and' into a new
> sentence.

Okay

>
> > This will ensure the current behaviour remains the same while also
> > enabling the libification of Git.
>
> How is this true? Was that value already accessible through
> `git_default_config()`?
>
> > It is important to note that `git_default_config()` is a wrapper to other
> > `git_default_*_config()` such as `git_default_core_config()`.
>
> I'd suggest to insert 'functions' before 'such'.

Alright, noted.

>
> > Therefore to access and modify this global variable,
> > the change has to be made in the function which parses and
> > stores the value in the global variable.
>
> This doesn't clarify much for me. Do you mean 'git_attr_global_file()'
> and 'git_default_core_config()'?

Okay I meant git_default_core_config().
I will modify it.

>
> >
> > Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> > Mentored-by: Christian Couder <christian.couder@gmail.com>
> > Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> > ---
> >  attr.c        |  7 ++++---
> >  environment.c | 12 +++++++++---
> >  environment.h |  9 ++++++++-
> >  repository.c  |  1 +
> >  repository.h  |  4 ++++
> >  5 files changed, 26 insertions(+), 7 deletions(-)
> >
> > diff --git a/attr.c b/attr.c
> > index 4999b7e09d..fbb9eaffaf 100644
> > --- a/attr.c
> > +++ b/attr.c
> > @@ -881,10 +881,11 @@ const char *git_attr_system_file(void)
> >
> >  const char *git_attr_global_file(void)
> >  {
> > -     if (!git_attributes_file)
> > -             git_attributes_file = xdg_config_home("attributes");
> > +     struct repo_config_values *cfg = &the_repository->config_values;
>
> Is 'cfg' guaranteed to be != NULL?
>
> > +     if (!cfg->attributes_file_path)
> > +             cfg->attributes_file_path = xdg_config_home("attributes");
> >
> > -     return git_attributes_file;
> > +     return cfg->attributes_file_path;
> >  }
> >
> >  int git_attr_system_is_enabled(void)
> > diff --git a/environment.c b/environment.c
> > index a770b5921d..283db0a1a0 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -53,7 +53,6 @@ char *git_commit_encoding;
> >  char *git_log_output_encoding;
> >  char *apply_default_whitespace;
> >  char *apply_default_ignorewhitespace;
> > -char *git_attributes_file;
> >  int zlib_compression_level = Z_BEST_SPEED;
> >  int pack_compression_level = Z_DEFAULT_COMPRESSION;
> >  int fsync_object_files = -1;
> > @@ -327,6 +326,8 @@ static enum fsync_component parse_fsync_components(const char *var, const char *
> >  static int git_default_core_config(const char *var, const char *value,
> >                                  const struct config_context *ctx, void *cb)
> >  {
> > +     struct repo_config_values *cfg = &the_repository->config_values;
> > +
> >       /* This needs a better name */
> >       if (!strcmp(var, "core.filemode")) {
> >               trust_executable_bit = git_config_bool(var, value);
> > @@ -364,8 +365,8 @@ static int git_default_core_config(const char *var, const char *value,
> >       }
> >
> >       if (!strcmp(var, "core.attributesfile")) {
> > -             FREE_AND_NULL(git_attributes_file);
> > -             return git_config_pathname(&git_attributes_file, var, value);
> > +             FREE_AND_NULL(cfg->attributes_file_path);
> > +             return git_config_pathname(&cfg->attributes_file_path, var, value);
> >       }
> >
> >       if (!strcmp(var, "core.bare")) {
> > @@ -756,3 +757,8 @@ int git_default_config(const char *var, const char *value,
> >       /* Add other config variables here and to Documentation/config.adoc. */
> >       return 0;
> >  }
> > +
> > +void repo_config_values_init(struct repo_config_values *cfg)
> > +{
> > +     cfg->attributes_file_path = NULL;
> > +}
>
> I assume the reason for adding this function becomes clear in a later
> commit?

Yes.

>
> > diff --git a/environment.h b/environment.h
> > index 51898c99cd..aea73ff25b 100644
> > --- a/environment.h
> > +++ b/environment.h
> > @@ -84,6 +84,12 @@ extern const char * const local_repo_env[];
> >
> >  struct strvec;
> >
> > +/* Config values parsed by git_default_config() */
>
> Mentioning here they get filled from git_default_config() doesn't feel
> really correct? Although I'm sure what comment would fit better, maybe
> just drop the comment above the struct. I see you have a similar comment
> in 'struct repository', where it *does* make sense.

Okay thank you

>
> > +struct repo_config_values {
> > +     /* core config values */
>
> I prefer emphasizing it's the "section 'core'" or something like that.

Noted

>
> > +     char *attributes_file_path;
>
> Would it be overkill to append: /* `core.attributesFile` */? This can
> help when grepping through the codebase to find where some settings are
> being parsed into. What do you think?

Alright

>
> > +};
> > +
> >  /*
> >   * Wrapper of getenv() that returns a strdup value. This value is kept
> >   * in argv to be freed later.
> > @@ -107,6 +113,8 @@ const char *strip_namespace(const char *namespaced_ref);
> >  int git_default_config(const char *, const char *,
> >                      const struct config_context *, void *);
> >
> > +void repo_config_values_init(struct repo_config_values *cfg);
> > +
> >  /*
> >   * TODO: All the below state either explicitly or implicitly relies on
> >   * `the_repository`. We should eventually get rid of these and make the
> > @@ -152,7 +160,6 @@ extern int assume_unchanged;
> >  extern int warn_on_object_refname_ambiguity;
> >  extern char *apply_default_whitespace;
> >  extern char *apply_default_ignorewhitespace;
> > -extern char *git_attributes_file;
> >  extern int zlib_compression_level;
> >  extern int pack_compression_level;
> >  extern unsigned long pack_size_limit_cfg;
> > diff --git a/repository.c b/repository.c
> > index c7e75215ac..d308cd78bf 100644
> > --- a/repository.c
> > +++ b/repository.c
> > @@ -57,6 +57,7 @@ void initialize_repository(struct repository *repo)
> >       ALLOC_ARRAY(repo->index, 1);
> >       index_state_init(repo->index, repo);
> >       repo->check_deprecated_config = true;
> > +     repo_config_values_init(&repo->config_values);
> >
> >       /*
> >        * When a command runs inside a repository, it learns what
> > diff --git a/repository.h b/repository.h
> > index 6063c4b846..638a142577 100644
> > --- a/repository.h
> > +++ b/repository.h
> > @@ -3,6 +3,7 @@
> >
> >  #include "strmap.h"
> >  #include "repo-settings.h"
> > +#include "environment.h"
> >
> >  struct config_set;
> >  struct git_hash_algo;
> > @@ -148,6 +149,9 @@ struct repository {
> >       /* Repository's compatibility hash algorithm. */
> >       const struct git_hash_algo *compat_hash_algo;
> >
> > +     /* Repository's config values parsed by git_default_config() */
> > +     struct repo_config_values config_values;
> > +
> >       /* Repository's reference storage format, as serialized on disk. */
> >       enum ref_storage_format ref_storage_format;
> >
> > --
> > 2.34.1
> >
> >
>
> --
> Cheers,
> Toon
