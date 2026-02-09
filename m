Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FE8333727
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770641525; cv=pass; b=MZ38WP+OMmezok6n2aqRw3t35Txrv3jsVEXpZOV0+nNMmfsoSdJHJftwPIHU8X3ncaPeVfESeyr+R5P4RYvff7BQoetUxNVs3WHwF0uyEjKS/qZW0wwCsebESL6PkD6EMiqmHbgP3EmGJnejUkW42/65f8+YiX1EH5Q6TDjVGw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770641525; c=relaxed/simple;
	bh=GZLo8akAJdX6Z2iEpt5FqQER/N6fMliGbvvFFKu/LF4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URoZAjg8rvFloE5FpLddFP2CHF2fofhv+xHlqhTqKUHCXJTEIUVjG8pnv+3LnQFOQiTiPMEJ2o7f4aa/vZqVu0s/RKNNSHEywYHPW2Ti80AfNmdub/T8WuK6GzAYsh+VX6thlQiVLMEBEvcWmZRmcgsPpzGYFuoDNKKljsZBI0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bszxzi7p; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bszxzi7p"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5637886c92aso964849e0c.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 04:52:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770641524; cv=none;
        d=google.com; s=arc-20240605;
        b=hvaZ6rvlXfGZCr4d9hQ9vpuzL1HaO4j8ed/VED6zWnFh/uPN6P0izgnZmx5pHbJ9az
         p50K6/mI//BQz1FHk1e+kMGxkyyk08NMAEwgyU62JYX+6ieOtanulmOpXbHyGgEC+Gds
         UhnA7Rhce8zfS3kwa1Z0CXezGY+nZVag3CPQmvNVc4FXP90SaVtzz3hcWu3IKEXGeqY/
         IHXpEktYceOBIAmu/aGJ2Grb3nreiqvFYMzmaYRbVSGIkQ8wFxD0vHTeIfJb8t3So/dZ
         h/zTS4kak71482JpctrBhForZJe93IUBKRoEDXZL5f4XWShvYPdmhQmxXP3OmTFaBKff
         RmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=DfHzdbjsflinKg0QEdDDFNbF8J7HIqx2UubIGzTUuBA=;
        fh=FhCDfeFbmycHGzY7HbKUSS8ZI4XWOfgXn11u3NYB6YQ=;
        b=FHBrgJqQDxkMLxrRu9x5no7BTsfyd0pFeq5E2DvsDcoE4KruTfNufPKfs++yLt4Zae
         sPgd1gpPARlW85K3FREhNv7Yhsd+W73vO4H0zLN+0pjc7YTVrj56ftT+V98o5a6dg5yq
         jS1/yLX2R8nJsuFO1rfQlK227aE6C0A3wOKptLU4qyOmQriRui2OqhrOkOdlB3z/tDGV
         nzinhxeRlODRmZncaDMbXYuOywxhUXQknP8EeE3arqZ79KOvvEQvt0RRwhPpR9tXttpA
         9ZexEjikpBknLx0Pw5BmUH4YZlLD3UP2oS6TcBgWi19xRNMaD7wVt7++Tq5KB+Tx2+VS
         KFcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770641524; x=1771246324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DfHzdbjsflinKg0QEdDDFNbF8J7HIqx2UubIGzTUuBA=;
        b=Bszxzi7p0A78sDVw+h+t9U+2DUhgcikoImaJFnumJUHGCh3tnCMoM/aETPrS3/WBN0
         63WdHlFq8alxe6KOYzCvXs07F9/ycdGwPScbzyHx5Mm/MDUHi6V+YIwfLtwc2wtBdWfs
         rGcSs/hOCcLMTJoA7tXVED4/mibqV8LVzZKek5SEAe5L6F7YwAUvq5zVUeiI6lg+hM8m
         oBMdw3ps8E4klS9EAcIKluLJ6PBMkkVNQfrrsQIyR7efjhWZVSZv/yFifiopvSm5FSGK
         QrT5qcZJdd8sE6fqkYAZ7vYxZ848cWD0bsUmbjKLrFhnLnWigupRkEg0CzkiI68iVHRe
         M2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770641524; x=1771246324;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfHzdbjsflinKg0QEdDDFNbF8J7HIqx2UubIGzTUuBA=;
        b=PxAXOviL8Xjga+YEmdSzFq+f/Crpf6PwL4AOWznRWfQ9eQsu8hpSH4U+ClnHvGnjNx
         RFdwf0AAnrn+wpQwjwy6pWUg+SmaS4gvAJGBeANtug+i/0iJhUd/23qIxdts43MllKN2
         0oPTchh7de7jpOfLPWkSLFXoX0vfX7H5EC4hyKQdELvIlt3o4/UbINOT0qM0Ayi/MkEG
         +JiqQimSHzxnaUTfxoGojAxo9JNESZmnJ2la0xcwPGUQY3cbCwlRCG4Op60U5Yda1dDj
         MJaWzAUx5mVzhf2MMgvwM1WFpheitNkjTw1twKws1yJpvYWbKg7wQhdygxdzm7kYrjjJ
         tHzg==
X-Gm-Message-State: AOJu0YyVgeSOv1B0fwXYcmhLG1abQVx7R6Cra3RM3+sGcIBib4HBCAVi
	u2K8ds4eaAPF8Eylimlzy5RNzafFQqnon6AJefGWW42G94PgEJX/n3GEYLpixs0QIXifrbxoJDk
	SVFqByCD2lJT5f6hMrrTUXboooTsmz3g=
X-Gm-Gg: AZuq6aJ4JbR8jK2dijV17xCZnKKjIn41ZcAYft6w+8U+fqo4sJLnzsF3y1dnqeZwreU
	rD7NqSFL4G6R7tEvFiZQeztXjcvaA5ZtWTQCPXjLCCnZSkFyVzfKEK5X5I76q4tdSey7DkivCn4
	lg1ne6SFq+8qZsMzIyQXU5YmMLBPxw8YpcX+9FIDNaFsS9nZ9d0tLYO13GVh6PcQ5hTd6812k7q
	ZoEb68/Xozx+O9jRomywkrHeyyHvAl3CvSnA7l6gGCzvxo1M4CoDsbAnNcx9k87bl+vuvabV8nz
	AP2MAmbK+80GfZX3FZWfMMKhJDZe5T9BIpmTc3sj
X-Received: by 2002:a05:6102:3e8b:b0:5f7:34b2:fb6d with SMTP id
 ada2fe7eead31-5fae89eb2f6mr2244726137.8.1770641524171; Mon, 09 Feb 2026
 04:52:04 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 04:52:03 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 04:52:03 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aYX7w5flfNe_bUFD@pks.im>
References: <20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com>
 <20260202-kn-alternate-ref-dir-v4-3-3b30430411e3@gmail.com> <aYX7w5flfNe_bUFD@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 9 Feb 2026 04:52:03 -0800
X-Gm-Features: AZwV_QiMZL9Y0bmMseWx9GDAN91YiUV-179nrAjr9eXawnjriLRicCCZEGzdQ-s
Message-ID: <CAOLa=ZQ20=FpdXfh6y_+NLNDgf73b51MC0mOAZX-Yd_SaPF9QA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] refs: parse and use the reference storage payload
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="00000000000012c297064a639b7e"

--00000000000012c297064a639b7e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Feb 02, 2026 at 01:26:32PM +0100, Karthik Nayak wrote:
>> The previous commit extended the 'extensions.refStorage' config to add
>> support for a reference storage payload. The payload provides backend
>> specific information on where to store references for a given directory.
>>
>> Propagate this information to individual backends when initializing them
>> via the 'init()' function. Both the files and reftable backends will
>> parse the information to be filesystem paths to store references.
>>
>> To enable this, provide a 'refs_compute_filesystem_location()' function
>> which will parse the current 'gitdir' and the 'payload' to provide the
>> final reference directory and common reference directory (if working in
>> a linked worktree).
>>
>> Finally, for linked worktrees, traditionally references were stored in
>> the '$GIT_DIR/worktrees/<wt_id>' path. But when using an alternate
>> reference storage path, it doesn't make sense to store main worktree
>> references in the new path, and linked worktree references in the
>> $GIT_DIR path. So, let's store linked worktree references in
>> '$ALTERNATE_REFERENCE_DIR/worktrees/<wt_id'. To do this, create the
>
> s/wt_id/&>/
>

Thanks!

>> diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
>> index 532456644b..df86da6aa7 100644
>> --- a/Documentation/config/extensions.adoc
>> +++ b/Documentation/config/extensions.adoc
>> @@ -57,10 +57,24 @@ For historical reasons, this extension is respected regardless of the
>>  `core.repositoryFormatVersion` setting.
>>
>>  refStorage:::
>> -	Specify the ref storage format to use. The acceptable values are:
>> +	Specify the ref storage format and location to use. The value can be
>> +	either a format name or a URI:
>>  +
>>  --
>> +* A format name alone (e.g., `reftable` or `files`) uses the default
>> +  location (the repository's common directory).
>> +
>> +* A URI format `<format>://<location>` explicitly specifies both the
>
> I think I mentioned this before, but shouldn't we say payload instead of
> location here? It may not be a location for all backends.
>

Yeah, you did. I missed this entirely somehow. Will re-do this.

>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> index fbdaf2eb2e..800a376ac5 100644
>> --- a/builtin/worktree.c
>> +++ b/builtin/worktree.c
>> @@ -425,6 +425,40 @@ static int make_worktree_orphan(const char * ref, const struct add_opts *opts,
>>  	return run_command(&cp);
>>  }
>>
>> +/*
>> + * References for worktress are generally stored in '$GIT_DIR/worktrees/<wt_id>'.
>> + * But when using alternate reference directories, we want to store the worktree
>> + * references in '$ALTERNATE_REFERENCE_DIR/worktrees/<wt_id>'.
>> + *
>> + * Create the necessary folder structure to facilitate the same. But to ensure
>> + * that the former path is still considered a Git directory, add stubs (similar
>> + *  to how we do in the reftable backend).
>> + */
>
> I think the last part in the braces isn't necessary to say anymore given
> that we simply shell out to a function now.
>

Yeah, will remove.

>> diff --git a/refs.c b/refs.c
>> index 32b4edaf2d..c1d69082a9 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2224,7 +2225,11 @@ static struct ref_store *ref_store_init(struct repository *repo,
>>  	if (!be)
>>  		BUG("reference backend is unknown");
>>
>> -	refs = be->init(repo, gitdir, flags);
>> +	/*
>> +	 * TODO Send in a 'struct worktree' instead of a 'gitdir', and
>> +	 * allow the backend to handle how it wants to deal with worktrees.
>> +	 */
>
> It would be nice if the commit message mentioned why this isn't done now
> already.

Will do!

>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 240d3c3b26..160ecb53b7 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -106,19 +106,24 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
>>   * set of caches.
>>   */
>>  static struct ref_store *files_ref_store_init(struct repository *repo,
>> +					      const char *payload,
>>  					      const char *gitdir,
>>  					      unsigned int flags)
>>  {
>>  	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
>>  	struct ref_store *ref_store = (struct ref_store *)refs;
>> -	struct strbuf sb = STRBUF_INIT;
>> +	struct strbuf ref_common_dir = STRBUF_INIT;
>> +	struct strbuf refdir = STRBUF_INIT;
>> +	bool is_worktree;
>> +
>> +	refs_compute_filesystem_location(gitdir, payload, &is_worktree, &refdir,
>> +					 &ref_common_dir);
>>
>> -	base_ref_store_init(ref_store, repo, gitdir, &refs_be_files);
>> +	base_ref_store_init(ref_store, repo, refdir.buf, &refs_be_files);
>>  	refs->store_flags = flags;
>> -	get_common_dir_noenv(&sb, gitdir);
>> -	refs->gitcommondir = strbuf_detach(&sb, NULL);
>> +	refs->gitcommondir = xstrdup(ref_common_dir.buf);
>
> We can use `strbuf_detach()` instead to save an allocation and then use
> `refs->gitcommondir` below.
>

That's a good suggestion.

>>  	refs->packed_ref_store =
>> -		packed_ref_store_init(repo, refs->gitcommondir, flags);
>> +		packed_ref_store_init(repo, payload, ref_common_dir.buf, flags);
>>  	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
>>  	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
>
> Patrick

Thanks!

--00000000000012c297064a639b7e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1016035494d97cd2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tSjJIRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1memFKQy85ZlZYMGFQVkVKZkNjUXVZbzltQnN4azE1bwpUZkoya3BEenVW
VHFDRzZIeUdFYTJOdFdoYTBNZkRoaXFaNSt5YTA1S2ZhOTBUTStGVXpoekJKcWFGb3lNL1JRCjJC
S1Awa1Arejd5SURRUGVTd2xjYTN2djFGUHBRVnBveS96SnBpTWU5TU05NnhIUVNiSzJabmV3c3No
dUdpeGMKQWIwLzZ4cE5vL3NhQ2lScEl3bWZvRUhaWWxzdmcyNTZhTUlWdExEakNTVWV1SjE4TVZu
aEU3Y2lIMnZDNm9McgpkWW1HVDQ0L0s5cWFNTXYzbXpqdWdhM3ZUbXBJVWFCM3haM3IwajViTUh6
QXpaQXhZOU9RbThSRytWM0lSWm5kCkFtcjVNNXJvT0pUWTNaQ25SNFhKQlo5LzdUUFJtSS9UbWJv
dC9LbDV1WWhyaWQ0QnA5MHRYVEExN3hLSmtWUG0KWWd5TXdONUZWSVFra1BPdEE4RlBJdjU0VkNH
RU9HN2xuZFVyMkFJckFaeW8yaVRvQVlab2FERkM2MXNFQXBabwpETGtkMmNJbGd4YnZJelEyNEhj
S3ZRaE0xeVVDNy9KWmUrczEzYjN4NVEyY1dGNCtmcTBBR3lzY0daOTU1dHQvCnNSbDl1TDhPTS9Y
MTNQOWVhVk43ZG40WTFYdVMza1d6MzN6RUFEUT0KPVhCYUYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000012c297064a639b7e--
