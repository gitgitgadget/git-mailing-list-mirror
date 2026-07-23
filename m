Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0393D1ABD
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 19:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784835700; cv=none; b=ItL3rYAiqVltWpNiYodiRabp4Go+pkEGkA7AYLBgWAyAqQH1kytmckZMW5uogdGpM4Rj3SpuL8Vo/rLYiqqD7UQe7EePVWANVS6R/FB1bs1Et1kXMGhc5cIW8RzAJiCk0oeuNgsTCNGFnRQa9V2CKfx4wDpKW39Df0M3lbZWLZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784835700; c=relaxed/simple;
	bh=+LmJgrVi7nIsU5Yeb6SfAUZ3bdIsJDtGOYIL4Owj8a4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYaMtSbqM0tYttov67z2gW/Z883zc0vOKaeuHTAQSId4/4/dg8XK0rIFs+HL47VQPIvr678nyZOzBUTt7QD7rFmQVkux62zfbyMBcbWhNbLNQGMw+/SY5OiF6IaGTQkcFyEvWaXmuK/rrCB82OMlYlNKdVwh0pENwR+QIGeRKGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjwufVLO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjwufVLO"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso11757915ad.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 12:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784835690; x=1785440490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qu/OWXMKe3aWOjos5v3eM6rnKwRJfaD0goxb6hxuyIY=;
        b=SjwufVLOJY9hBmLiWHyEyKwb2LFY5ncZ8l8bv+6I1DgGmbqpRA7qJL4XwTCe2Tu/o+
         IGy573gUNoY73lIzqRyXOEB34H2+uYLG5tUPehdj+3yj6SojhP4ptdzHgn42iXVhMLMz
         wbO9nZCBORiSJFfyD5giJZ6k2arHYHdUjfZZvEoa4ktlwV8a3x7rXFJU+6MhEuSVbcYm
         QQS8nUExFN+hIpqerL7nhV9ZZ5R3cYtcpsPtmvWVkhSFy6GaToyTys1l960BPB8Lb01i
         FiH1F6JEPLXnP7S+UbBqSMrqIVsy4lVDlcQA0Cr2+V0LD5f/ZHfmanlEj/A61gne94Xs
         tFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784835690; x=1785440490;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qu/OWXMKe3aWOjos5v3eM6rnKwRJfaD0goxb6hxuyIY=;
        b=siPjuE5lgP0bB0D/ZutmJBs+lVhun56bjVMPTw2cInplzX0AMWKVcOlpemGwAs0y4z
         CMDSnQ2fNzf1SuPAtXVHBv7jfCOSWBZMUlEkHCdjrr7/3M9w5R//2TZWQd6Nvrud6oMj
         9Ofw6kVtnn0CMU1cNx1xYyj6NeYb9VS63fzHdMtEpSF6z7eC1R1t80Uwi76HpIp6g2nS
         ukwWT2qVlb8U7v2oKG+Z4M8reYM7JHZousJML4H5iXY86GFfbyq25bVJh12htN4oj55n
         YIXN34yiwbxhhIUOE6be29Li8QcZabW1vGjlphkpP8+PJJVDEd/KTsGsMg2Or85z0Lf7
         KElg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/g7Gbi7BHmRLms80iR+QXjL6K0aPQzuPL5ijOGm+P6sHdDHgo1mFLFmrukaNvBc9EyWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3YV1ulTAvt3WjIfJKnyzYd4iXSggaSHovFGwYFC7wedOlRLLx
	+wXL8UINFXJS5wMZcyvnMNm1eo7ij7u8jBVJdiHlDaTyK0T9+STQytyH
X-Gm-Gg: AR+sD12kI9mcjozGY9kNlsEgjF2ciIsZxY4IWUk7Le3HbgPymOZI5cVBmiY4K8vfpJh
	zfofQ9pOJ+jK5QzqHIo9E/KSMyyKreP7nDRSCf1w3vn+RnQLtA3qjXDihhTp6T/AW100ldWtLca
	2eN0ZYen3IjDxuERR5IWghTd1MNiR8usb3H65Q53ayMoVySkBkfMD53Bqg26J65d/flcKY7Y+bX
	QZJfyeYnuZiCX5kfhIxQ2pqkhfpivfBF0MivXuUvk6dYFyW6bQyLTXmD5sdLEwDD77SpLony074
	SFF+LjpxZXJfAB30P5qgDCRjm0ZcYjXxoSqRX/rZM+Z9r5ne0sMO7B4PNthoBcP3UcZXIQ7GnJr
	UR4z9Fgf/IqaXJ5YJUo/4vEJ2qbejMPTd18UNd1vS6l8pFFbVQXqDYq0adqITxVrG4y8nfYjoT2
	FwNOr0qupRagmf6dMPO4MjoimQCfkX/T1PfbbnY6XJ+J5paziaFgUbis0nlh3ufBCi5oIKXCN0w
	VxSqaa41kB2GRw97c0BkNSTh8IffI4dtToTSB++VgN5GV0suoUmcY5v3FW5XTsKUJZxvP3zOsbz
	Of1Wj2R5n4kvM+F1CnIVY7uBuQ==
X-Received: by 2002:a17:90b:3e85:b0:38e:a74:dfe4 with SMTP id 98e67ed59e1d1-38ec65ed89fmr4842561a91.25.1784835690434;
        Thu, 23 Jul 2026 12:41:30 -0700 (PDT)
Received: from ?IPV6:2409:40e3:40f2:e504:b8c9:6fa8:29d4:f006? ([2409:40e3:40f2:e504:b8c9:6fa8:29d4:f006])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13014d27sm19113812c88.4.2026.07.23.12.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 12:41:29 -0700 (PDT)
Message-ID: <e8d63121-fedc-49da-ad1a-0cbcf1a35a0b@gmail.com>
Date: Fri, 24 Jul 2026 01:11:24 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/7] repack-promisor: record dropped objects in a drop
 log
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com, me@ttaylorr.com,
 ps@pks.im, johannes.schindelin@gmx.de, l.s.r@web.de
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
 <20260716132848.95982-8-r.siddharth.shrimali@gmail.com>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <20260716132848.95982-8-r.siddharth.shrimali@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/07/26 18:58, Siddharth Shrimali wrote:
> After --drop-filtered removes promisor blobs, append a record of each
> dropped object to $GIT_DIR/objects/info/promisor-dropped. Each line
> records the object ID, a reflog-style timestamp (Unix seconds and
> timezone), the filter spec, and the promisor remote it was attested
> recoverable from like the following:
> 
>    <oid> <time> <tz> filter=<spec> remote=<name>
> 
> If a dropped object later becomes unrecoverable (for example, the
> branch holding it is deleted on the promisor remote), a lazy fetch
> fails with a generic error. This persistent record lets a later change
> explain that the object was dropped deliberately, when, under which
> filter, and from which remote it was expected to be recoverable.


I like the idea of better errors when a later lazy fetch fails.

An alternative would be to wait until we actually have that error-path
change in the same series, so we do not grow an on-disk format that
nothing reads yet. I think keeping the log in the RFC is fine though
if you find it useful while developing; I would not treat it as
required for the first mergeable version.



> 
> The remote field lists all configured promisor remotes rather than the
> specific one each dropped object is recoverable from. Determining the
> exact remote would require asking the remote whether it has the object.
> A "remote-object-info" command is being added to the "git cat-file
> --batch" protocol for this kind of query, but it is not available yet.
> A NEEDSWORK marks this for a follow-up.
> 
> The log is written only on a real run, i.e. --dry-run changes nothing.
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
>   builtin/repack.c  |  4 +++
>   repack-promisor.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
>   repack.h          |  4 +++
>   3 files changed, 99 insertions(+)
> 
> diff --git a/builtin/repack.c b/builtin/repack.c
> index aa3257a98a..49dcbbc567 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -702,6 +702,10 @@ int cmd_repack(int argc,
>   		write_midx_file(files->packed, NULL, NULL, flags);
>   	}
>   
> +	if (drop_filtered && !dry_run)
> +		append_drop_log(repo, &drop_oids,
> +			expand_list_objects_filter_spec(&po_args.filter_options));
> +
>   cleanup:
>   	string_list_clear(&keep_pack_list, 0);
>   	string_list_clear(&names, 1);
> diff --git a/repack-promisor.c b/repack-promisor.c
> index fabfdc168a..60913a5150 100644
> --- a/repack-promisor.c
> +++ b/repack-promisor.c
> @@ -7,6 +7,97 @@
>   #include "repository.h"
>   #include "run-command.h"
>   #include "oidset.h"
> +#include "date.h"
> +#include "promisor-remote.h"
> +#include "strbuf.h"
> +
> +/*
> + * Append the drop-log entries to the already-computed path.
> + * Returns -1 on any I/O failure so the caller can warn once.
> + * Keeping this in a separate helper avoids goto-based cleanup
> + * in append_drop_log();
> + */
> +static int write_to_drop_log(struct repository *repo,
> +			     const char *path,
> +			     const struct oidset *dropped,
> +			     const char *stamp,
> +			     const char *filter_spec,
> +			     const char *remotes)
> +{
> +	struct oidset_iter iter;
> +	const struct object_id *oid;
> +	FILE *fp;
> +
> +	if (safe_create_leading_directories(repo, (char *)path)) {
> +		warning(_("could not create leading directories for '%s'"), path);
> +		return -1;
> +	}
> +
> +	fp = fopen(path, "a");
> +	if (!fp) {
> +		warning_errno(_("could not open '%s'"), path);
> +		return -1;
> +	}
> +
> +	oidset_iter_init(dropped, &iter);
> +	while ((oid = oidset_iter_next(&iter))) {
> +		if (fprintf(fp, "%s %s filter=%s remote=%s\n",
> +				oid_to_hex(oid), stamp,
> +				filter_spec ? filter_spec : "",
> +				remotes) < 0) {
> +			warning(_("could not write to '%s'"), path);
> +			fclose(fp);
> +			return -1;
> +		}
> +	}
> +
> +	if (fclose(fp)) {
> +		warning_errno(_("could not close '%s'"), path);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +void append_drop_log(struct repository *repo,
> +		     const struct oidset *dropped,
> +		     const char *filter_spec)
> +{
> +	char *path;
> +	struct strbuf stamp = STRBUF_INIT;
> +	struct strbuf remotes = STRBUF_INIT;
> +	struct promisor_remote *pr;
> +
> +	if (!oidset_size(dropped))
> +		return;
> +
> +	datestamp(&stamp);
> +
> +	/*
> +	 * NEEDSWORK: we temporarily record all configured promisor remotes rather
> +	 * than the specific one a given object is recoverable from because there


Recording all promisor remotes for now looks OK to me with that
NEEDSWORK. I would not block this on remote-object-info.


> +	 * is currently no way to determine that locally. it would require
> +	 * asking the remote whether it has the object. A "remote-object-info"
> +	 * command is being added to the "git cat-file --batch" protocol for
> +	 * this kind of query. Once it is merged in the codebase, this should
> +	 * record the exact promisor remote that has each dropped object.
> +	 */
> +	for (pr = repo_promisor_remote_find(repo, NULL); pr; pr = pr->next) {
> +		if (remotes.len)
> +			strbuf_addch(&remotes, ',');
> +		strbuf_addstr(&remotes, pr->name);
> +	}
> +
> +	path = repo_git_path(repo, "objects/info/promisor-dropped");


If we keep it, it would be nice to document this path (for example in
gitrepository-layout) and to have a small test that a real drop appends
a line.


Thanks
Siddharth


> +
> +	if (write_to_drop_log(repo, path, dropped, stamp.buf,
> +			filter_spec, remotes.buf))
> +		warning(_("could not record all dropped objects in the drop log"));
> +
> +	strbuf_release(&stamp);
> +	strbuf_release(&remotes);
> +	free(path);
> +}
>   
>   struct write_oid_context {
>   	struct child_process *cmd;
> diff --git a/repack.h b/repack.h
> index 61e554e4ed..33309548ce 100644
> --- a/repack.h
> +++ b/repack.h
> @@ -171,6 +171,10 @@ int enumerate_promisor_blobs(struct repository *repo,
>   			     const struct list_objects_filter_options *filter,
>   			     struct oidset *to_drop);
>   
> +void append_drop_log(struct repository *repo,
> +		     const struct oidset *dropped,
> +		     const char *filter_spec);
> +
>   int write_cruft_pack(const struct write_pack_opts *opts,
>   		     const char *cruft_expiration,
>   		     unsigned long combine_cruft_below_size,

