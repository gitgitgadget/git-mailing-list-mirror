Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE003D3B8
	for <git@vger.kernel.org>; Fri, 24 May 2024 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716589946; cv=none; b=lJe1v6u8Jl9FMT2GoF/uc/Glf7mM4G1kMBpW15MBI3f0APVTCO/GN+P/hMzg4eNPe6rLLypq/2Idhokr7R57Q7jA7JO5GGQYcHeftwP6+fr6nDOgErYCA0YxYwuiIbKD+cw/dAIFFiv5r81qzD2sXmISD3AvUyM/CEqIYr7ynpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716589946; c=relaxed/simple;
	bh=GEJhudWf0Tnc/fEg+ll7ZLzo7w3X0Ji8+NwZtClTsOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUxaQPPJ6QdO7w7myXqVIXU5EInQrdGK5YLH57EtrqVwB4F/PXnO0N6cgsSucqTJitqhhLONfLAnPU68PlzgD0Ow/NnYk1hfeaDHHSQmfcsnvyiRbZ6EeQn+u33o/UYSTfH1YyUHcFTP3HuoXes6zc50nFBwSxmPpGsz9/vPStk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpznMOMk; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpznMOMk"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b2cc8c4b8aso5207910eaf.1
        for <git@vger.kernel.org>; Fri, 24 May 2024 15:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716589944; x=1717194744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QamIMIjbPsQK8IM3py/RhftRvy7cBU7bzQ4rhA2G7Fc=;
        b=mpznMOMkwtOXG+XexNyA0VyIheMfDIe8nFwy12XEkSj9U8yY/9IKEvBDxmiMPbspDi
         SchyVWUuFdXKhS7J1tIaaV+LPjd/P/WwtU9LZxnkmgcrQGlnKNeeac8qimVvchpbFWXp
         yyGjsMdSBl9FeoootJ+XAGbDCSo1ofBgJUnnpk5jG7BYMWS/bSEjJJ8pdqVWCt6Fk4+5
         /rJgNzsxxtbGrMV1n8rkQKkpYJHYKJRdU8c1vvrtvUg96RtxP+5j/1IytpPRNkEarB4U
         RQRVfxXxfhWD8ohGLODLwHM+gDAdnXZSMt/fgvHQOa+6KCJDYTWrkNIBTzfZ2YaAUevx
         n4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716589944; x=1717194744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QamIMIjbPsQK8IM3py/RhftRvy7cBU7bzQ4rhA2G7Fc=;
        b=sn+mhmauRoCVGkHBQCIKQPM8eKSZ3DvYeQQpRhf0A9dhoaa9P/pfQUelkK8KFP7Pql
         BxgNv7kCYnSo0TGp5lgcDT+gSGA1Som8KLObfzPtQ45I3QLPtG8tLAeE74mU5G6bqIkJ
         F+b4Y77Nxy1ttzh7w5IBO5G7wlJHHlJ+rcEgq1xMxZgf0ielKYUzQ2bsqUYBWS61uMLB
         kGpoKEYbvRZR2p56ZLR4lJIWnqlHbeRr3t5T865Nf5+VHLchDFFIY7j0nnRdA4f5R53y
         Bxo2jaYw/9T+qBTkNxA5Am4P3yw0qnJ1v9Ys3pmWnHQleXQ5w5XfwEz24J+amosmCUhC
         N/RQ==
X-Gm-Message-State: AOJu0YxYn1zepAXtT4HLyX/lDJAC+LOTABawp6zqeFpgkTygtJE+w3i3
	168SyPCtvEyMjr7CzZEf886hwVBV1bSBEual0CaU/0RYeGQRAz7m
X-Google-Smtp-Source: AGHT+IFB2IxOBYoMhP+lI2Jxbuvgpt77AuCh9Ma4oX030qacvN9Yin/PbnwzV6ixhmnKjuxAIikFDw==
X-Received: by 2002:a05:6820:820:b0:5aa:596c:52d0 with SMTP id 006d021491bc7-5b9624948bdmr4983596eaf.6.1716589944109;
        Fri, 24 May 2024 15:32:24 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b96c6dd626sm484824eaf.47.2024.05.24.15.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 15:32:23 -0700 (PDT)
Date: Fri, 24 May 2024 17:32:20 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 8/9] refs: implement logic to migrate between ref
 storage formats
Message-ID: <wt5hbn62kq6wvbbkkqxj2ev23cvybtcfxwygdcg5fjuhbmdwdx@azuetlk3jwgo>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716545235.git.ps@pks.im>
 <4d3eb5ea896bffffbf28ab4865b69901cc9edee7.1716545235.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d3eb5ea896bffffbf28ab4865b69901cc9edee7.1716545235.git.ps@pks.im>

On 24/05/24 12:15PM, Patrick Steinhardt wrote:
> With the introduction of the new "reftable" backend, users may want to
> migrate repositories between the backends without having to recreate the
> whole repository. Add the logic to do so.
> 
> The implementation is generic and works with arbitrary ref storage
> formats so that a backend does not need to implement any migration
> logic. It does have a few limitations though:
> 
>   - We do not migrate repositories with worktrees, because worktrees
>     have separate ref storages. It makes the overall affair more complex
>     if we have to migrate multiple storages at once.
> 
>   - We do not migrate reflogs, because we have no interfaces to write
>     many reflog entries.
> 
>   - We do not lock the repository for concurrent access, and thus
>     concurrent writes may make use end up with weird in-between states.

Let's drop the "make use" in this line.

>     There is no way to fully lock the "files" backend for writes due to
>     its format, and thus we punt on this topic altogether and defer to
>     the user to avoid those from happening.
> 
> In other words, this version is a minimum viable product for migrating a
> repository's ref storage format. It works alright for bare repos, which
> often have neither worktrees nor reflogs. But it will not work for many
> other repositories without some preparations. These limitations are not
> set into stone though, and ideally we will eventually address them over
> time.
> 
> The logic is not yet used by anything, and thus there are no tests for
> it. Those will be added in the next commit.
[snip]
> +int repo_migrate_ref_storage_format(struct repository *repo,
> +				    enum ref_storage_format format,
> +				    unsigned int flags,
> +				    struct strbuf *errbuf)
> +{
> +	struct ref_store *old_refs = NULL, *new_refs = NULL;
> +	struct ref_transaction *transaction = NULL;
> +	struct strbuf buf = STRBUF_INIT;
> +	struct migration_data data;
> +	size_t reflog_count = 0;
> +	char *new_gitdir;
> +	int ret;
> +
> +	old_refs = get_main_ref_store(repo);
> +
> +	/*
> +	 * The overall logic looks like this:
> +	 *
> +	 *   1. Set up a new temporary directory and initialize it with the new
> +	 *      format. This is where all refs will be migrated into.
> +	 *
> +	 *   2. Enumerate all refs and write them into the new ref storage.
> +	 *      This operation is safe as we do not yet modify the main
> +	 *      repository.
> +	 *
> +	 *   3. If we're in dry-run mode then we are done and can hand over the
> +	 *      directory to the caller for inspection. If not, we now start
> +	 *      with the destructive part.
> +	 *
> +	 *   4. Delete the old ref storage from disk. As we have a copy of refs
> +	 *      in the new ref storage it's okay(ish) if we now get interrupted
> +	 *      as there is an equivalent copy of all refs available.
> +	 *
> +	 *   5. Move the new ref storage files into place.
> +	 *
> +	 *   6. Change the repository format to the new ref format.
> +	 */
> +	strbuf_addf(&buf, "%s/%s", old_refs->gitdir, "ref_migration.XXXXXX");
> +	new_gitdir = mkdtemp(buf.buf);
> +	if (!new_gitdir) {
> +		strbuf_addf(errbuf, "cannot create migration directory: %s",
> +			    strerror(errno));
> +		ret = -1;
> +		goto done;
> +	}

If the repository contains reflogs or has worktrees the migration does
not proceed. This means that the created tempdir gets left behind with
no indication and would be left to the user clean it up.

Instead, we could move tempdir creation to after these checks so it is
not needlessly created.

> +
> +	if (refs_for_each_reflog(old_refs, count_reflogs, &reflog_count) < 0) {
> +		strbuf_addstr(errbuf, "cannot count reflogs");
> +		ret = -1;
> +		goto done;
> +	}
> +	if (reflog_count) {
> +		strbuf_addstr(errbuf, "migrating reflogs is not supported yet");
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	/*
> +	 * TODO: we should really be passing the caller-provided repository to
> +	 * `has_worktrees()`, but our worktree subsystem doesn't yet support
> +	 * that.
> +	 */
> +	if (has_worktrees()) {
> +		strbuf_addstr(errbuf, "migrating repositories with worktrees is not supported yet");
> +		ret = -1;
> +		goto done;
> +	}
[snip]
> +	/*
> +	 * Until now we were in the non-destructive phase, where we only
> +	 * populated the new ref store. From hereon though we are about
> +	 * to get hands by deleting the old ref store and then moving
> +	 * the new one into place.
> +	 *
> +	 * Assuming that there were no concurrent writes, the new ref
> +	 * store should have all information. So if we fail from hereon
> +	 * we may be in an in-between state, but it would still be able
> +	 * to recover by manually moving remaining files from the
> +	 * temporary migration directory into place.
> +	 */

If there a failure after this point, should we provide a hint to user
that the refernces exist in the tempdir?

-Justin
