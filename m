Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E45236B1C
	for <git@vger.kernel.org>; Fri,  3 May 2024 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714762137; cv=none; b=Qt3FGIiEWZ6irZAQ2RT5mSnpT1pvLMDwlpQVuSj4DrdnT3zhauLq9mCC9Oq65RXijMBRiVM41BsZw5WPTFeWI49lB9EKvGDgVPMiVCtoaoAUxipLNWf1RdbiT0DaC/LuRBidB8PEvfJB8QgYBpGa7wSuinQDOkGfUPp3ycZFRTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714762137; c=relaxed/simple;
	bh=Dd5NBNPZ6rW7r0cDv4MuDzvN6UK+gdtXAgmOca7+PTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAofVnlbnjWHZ5FTS8UX6H/7uWJpYKKDmMfL9zmNmcUplIYQ97qyG5Ui1fsTJjlWQpd+TMfjLHNMF3Yvkz+PBqfHq0Ts5Nfhp7e5tsaMxlxECrdqBOfxPyxsb/ZsxSsso82Y8Kc0ANkvKMG3TXxTVtBIKfWlhMI0kPJ+18gmegU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=aem8b+sH; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="aem8b+sH"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6a0c8fb3540so2276d6.1
        for <git@vger.kernel.org>; Fri, 03 May 2024 11:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714762134; x=1715366934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5u14DDpmlw5pu01N5WU8BG7mSv/R4rN7bjmv0J1roBk=;
        b=aem8b+sHMF4HOCSn53W90qFIZRqRWPU1NA7HJbdBIzMMjTziYcPz4VI+flLMZ8Q9Gg
         f4tiO7sjLaIqfdCUItuP5Za1Q792HWbDvHvzmUytS88mIY3NDmLNEkiHRA9iR9fpp+Xs
         EgWdoBp977zkP+l5D/XxkRX1Wl7xKneyNTfRUzvbAXNmrHqaxgiT2yDmJ6m9aLO7QOLX
         tEg5s/+xpjQbsHtf3eiN8SAAF6AHgetC6cUjHgsp2AOMf+/kcMOy0qLLlzshkwTWfAIn
         A7plZpI/91FMQA87MOYbJRJukybq3lm54uPJEbAVl/2ImniyGFQNsKI1qLbe/1ZxgQ4P
         O38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714762134; x=1715366934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5u14DDpmlw5pu01N5WU8BG7mSv/R4rN7bjmv0J1roBk=;
        b=fiU7NO5oUt/Gc8l9ApwMOnKnAZX0gqeDtPMODDMq+IFrVqoXxP64OU605uNEzuErBt
         CYK+iUVUhA2UQuF4ndmH5RY0KusrninKVnx8uuT2HegVpSwp1Wb54DX2e2kNWn4ivwme
         qmTA/38k4Un/ET1oHyCAK2HBYNUlWI8mEfn0EwmPyYr+ds0/0Pl2thiPfPC6NvpvK1ny
         y6i0PbvuCWLq5bJqD0urA0sXNpKDbn+XVvY4/kIMtHpMEOEGaqFa9osXVGHf+ns4Emf6
         gUtBbY9+lB4+OpWDTrk0yg47eqp/5YUPmIPYEDyhVUD/gjnLTTsZHcsQ4m/kLvBRX/Qs
         jjkw==
X-Gm-Message-State: AOJu0Yxb+fXRRA4AZUwiK4NdFxNccFq73rAEuHRtjy/1kpapgvou1I9P
	Do/ph+SaWcRIUsCxbE1i40JltSFh7zFRRqCFnBQqAt4cuN1ydjaAoe2ukEHLqNE=
X-Google-Smtp-Source: AGHT+IGPceV7/rHUWRFMJYSZQp8JnMOOtYTYKW9QXJqdKoRUzaQfUgrhSyezcffiI0+/JcvCjRZCvg==
X-Received: by 2002:a05:6214:14e4:b0:6a0:bf82:aaa5 with SMTP id k4-20020a05621414e400b006a0bf82aaa5mr10950068qvw.7.1714762134355;
        Fri, 03 May 2024 11:48:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k9-20020a056214102900b006a0e6ffd710sm1432648qvr.97.2024.05.03.11.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:48:53 -0700 (PDT)
Date: Fri, 3 May 2024 14:48:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] cocci: apply rules to rewrite callers of "refs"
 interfaces
Message-ID: <ZjUxlLyyvmHNifDp@nand.local>
References: <cover.1714717057.git.ps@pks.im>
 <5109468b356637b8b4521a3e96ba228622804ca0.1714717057.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5109468b356637b8b4521a3e96ba228622804ca0.1714717057.git.ps@pks.im>

On Fri, May 03, 2024 at 08:28:14AM +0200, Patrick Steinhardt wrote:
> Apply the rules that rewrite callers of "refs" interfaces to explicitly
> pass `struct ref_store`. The resulting patch has been applied with the
> `--whitespace=fix` option.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  add-interactive.c           | 17 +++++++----
>  bisect.c                    | 25 ++++++++++-----
>  blame.c                     |  4 +--
>  branch.c                    |  5 +--
>  builtin/am.c                | 38 ++++++++++++++---------
>  builtin/bisect.c            | 44 +++++++++++++++-----------
>  builtin/blame.c             |  4 +--
>  builtin/branch.c            | 49 ++++++++++++++++-------------
>  builtin/checkout.c          | 35 +++++++++++++--------
>  builtin/clone.c             | 36 +++++++++++++---------
>  builtin/describe.c          |  3 +-
>  builtin/fast-import.c       | 11 ++++---
>  builtin/fetch.c             | 20 ++++++++----
>  builtin/fsck.c              | 11 +++++--
>  builtin/gc.c                |  3 +-
>  builtin/log.c               |  6 ++--
>  builtin/merge.c             | 34 +++++++++++++--------
>  builtin/name-rev.c          |  5 +--
>  builtin/notes.c             | 26 +++++++++-------
>  builtin/pack-objects.c      | 10 ++++--
>  builtin/pull.c              |  2 +-
>  builtin/rebase.c            | 18 ++++++-----
>  builtin/receive-pack.c      | 15 ++++++---
>  builtin/reflog.c            | 25 ++++++++-------
>  builtin/remote.c            | 37 +++++++++++++---------
>  builtin/repack.c            |  7 +++--
>  builtin/replace.c           |  9 +++---
>  builtin/reset.c             | 13 +++++---
>  builtin/rev-parse.c         | 25 ++++++++++-----
>  builtin/show-branch.c       | 22 ++++++++-----
>  builtin/show-ref.c          | 19 ++++++++----
>  builtin/stash.c             | 23 ++++++++------
>  builtin/submodule--helper.c |  7 +++--
>  builtin/symbolic-ref.c      | 13 +++++---
>  builtin/tag.c               | 11 ++++---
>  builtin/update-index.c      |  2 +-
>  builtin/update-ref.c        | 21 ++++++++-----
>  builtin/worktree.c          | 19 +++++++-----
>  bundle-uri.c                | 12 +++++---
>  bundle.c                    |  2 +-
>  commit-graph.c              |  3 +-
>  commit.c                    |  3 +-
>  config.c                    |  3 +-
>  delta-islands.c             |  3 +-
>  fetch-pack.c                |  6 ++--
>  fmt-merge-msg.c             |  4 ++-
>  help.c                      |  5 +--
>  http-backend.c              | 13 +++++---
>  log-tree.c                  |  9 ++++--
>  ls-refs.c                   | 10 +++---
>  midx-write.c                |  3 +-
>  negotiator/default.c        |  3 +-
>  negotiator/skipping.c       |  3 +-
>  notes-cache.c               |  6 ++--
>  notes-merge.c               |  2 +-
>  notes-utils.c               |  7 +++--
>  notes.c                     |  5 +--
>  reachable.c                 |  5 +--
>  ref-filter.c                | 35 +++++++++++++++------
>  reflog-walk.c               | 27 +++++++++++-----
>  reflog.c                    | 20 +++++++-----
>  refs.c                      |  9 ++++--
>  remote.c                    | 38 ++++++++++++++---------
>  reset.c                     | 29 ++++++++++--------
>  revision.c                  | 27 ++++++++++------
>  sequencer.c                 | 61 ++++++++++++++++++++-----------------
>  server-info.c               |  3 +-
>  setup.c                     |  2 +-
>  shallow.c                   | 16 ++++++----
>  submodule.c                 |  6 ++--
>  transport-helper.c          | 29 ++++++++++--------
>  transport.c                 | 16 ++++++----
>  upload-pack.c               | 20 +++++++-----
>  walker.c                    |  6 ++--
>  wt-status.c                 | 22 +++++++------
>  75 files changed, 711 insertions(+), 436 deletions(-)
>
> diff --git a/add-interactive.c b/add-interactive.c
> index e17602b5e4..b5d6cd689a 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -532,8 +532,9 @@ static int get_modified_files(struct repository *r,
>  			      size_t *binary_count)
>  {
>  	struct object_id head_oid;
> -	int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
> -					     &head_oid, NULL);
> +	int is_initial = !refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> +						  "HEAD", RESOLVE_REF_READING,
> +						  &head_oid, NULL);
>  	struct collection_status s = { 0 };
>  	int i;

OK, so this is the patch that applies the Coccinelle script from the
previous step.

This all makes sense, but I wonder if we should be more careful than
blindly replacing these functions with the same set of arguments
following a new

    get_main_ref_store(the_repository)

For instance, in this hunk, we have a 'struct repository *' in scope via
the 'r' parameter in add-interactive.c::get_modified_files().

I don't think it's wrong per-se to use the_repository here, but it does
create something to clean up in the future.

I haven't looked at other spots throughout this patch, just noticed
this in the first hunk and thought that I'd say something about it.
Otherwise the transformation seems obviously correct.

Thanks,
Taylor
