Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757948;
	b=OREEDJ2BPWAwnUJoZf41TyaAqtdgdpoOXNgYu7CpYjRh9Fjg17kr3CaSRglWskuhB5OP
	 urjcIyyYtCv+UCwHXHtz9Rhsh5ViYjhC9jvGyPG9ieNwXMlJEFuVHNTiBA8/ECofkK3jL
	 4R6MmdweAVQ65F42a3LN+8ReAA2ZYY1JUS95D1x2SauiHRaOnyzfZk5z7q+OlUOYaKqMT
	 0IoNVH+eaP9OK0oZrnD4+ThsAjfuxc+Jmzmu9kgJpOIXnKO8ggKuNGTTNBvZbGcnnFpXA
	 23zlKfaJ59hMH/p95m2So9Cby3dM43WuNKgDerrvzYcyJlvteJwLQjcPQgSjlXJGSPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757948;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nUdzAPsTYvxQZhdPvzfqP8STMZOD5eDv9ZEipq72bh4=;
	b=X2N6mcVzGW8Y0fMF8430cOPju5SMmSHfGWclUGia8PVwBEEeiJ/6zz/5qCuw4FpMIT7/
	 QUByNTyXRNG9cm/Swk1qCh15btTHR+mP/Qbfi954Tx9IBAYDkQrCQ7bi9tBZL+eSKojRx
	 wrh4UB+wHi5tnvQ2fZ2yqfWq2Zn7y2NDw3v/Q+gvWxL1IBg79yTyId3H+gyrEKhb97+A7
	 c5GwQAjaxAVXK2OvpDVehgGb+XYXrs2p0/pei2DvxJJGa4S9Ww8SY7inVsQzWGxffwZGV
	 LG1rVXlq2YFKID2uI1/UGq5BwIsxOV7BSMeWLwkuZyc1jb3MerKa5LEULoB7VlP9cYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=u4pYzoxU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cwQY9wmO;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1BE606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E1BE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=u4pYzoxU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cwQY9wmO
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1547D1D00220
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:19:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 23 Oct 2026 08:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792757946; x=1792844346; bh=nUdzAPsTYv
	xQZhdPvzfqP8STMZOD5eDv9ZEipq72bh4=; b=u4pYzoxU1exAVLSV2b9bD0F93t
	CXXaqeqAX/wjVAzjhreXgaunsbu9bErqcF6QmLuhEsqFZI6HbGDw7mzhVW6ZY1xs
	J6s0Maq1O0ubVGT7BdKKodrVsu8QNDZD3jy1bqirwQgzIPsTbP/UWDfm41ad8Zjz
	PUoIWJW4/7guIikSw33VnMumSguFaRfdZNwRQDTLBMSBYSi/blaxUbnEu6Rw833Y
	j2Zj0nWNkVGZSdPwyqVTQ5ehZ/JU70IL6YDFfvHNTWaAoEfi3bf3r5QDJUIHZFf7
	G6T7GtdQ3nr8eWLGkiZyaVnthbwwFxDPBugDNlxyD2fx0fUpG8qLgFmmyw3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792757946; x=1792844346; bh=nUdzAPsTYvxQZhdPvzfqP8STMZOD5eDv9ZE
	ipq72bh4=; b=cwQY9wmOuY55ycTH6gy1ZjbTufdpGL2v6Z6tVR1AJvMGOaPYs5f
	oJRbNJgspspUgxGDwX7yF8uM2tyBGzFg6SNeZC9j1t1LRGrkuMclh6uW0SF2S1tQ
	ux9VADjvFaGiZX7hhZy9O/8DlY9TaKtF0Vm4Xqbc3sMJhuMfwfZpyOizUlaxwgrZ
	pygZhLEUz5t1pyea63RpZDoYxviSl2YDI1awHoXVG78E+ggJfRadtqgmuDwH7a2e
	iyjb91chWnEeD7uYxtHC7AFiZDHFUu52fZbwpT8bVh17+uZ1yB/NsWT39D8Xyzzn
	QONqbcfGcNIozWWbgTg4R8ssgQ1YEtAQacQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792757946; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:EF7fV3XebxZKeHK5i1zeBSYz1r/yUldPjkfEX/P6hw1XMGc
	EcPKOdrK/0n45Z0KgWE5Mw8H5LeYbFigH7gwf1E/IIJ6gvvBU8GMvWVj/0pRI5M/
	KMfeeMEQMEop63FqFAZ/QYY8x+vCkTqHD0/reGmtgRdSPbabUfSj5BxvbH6kmHcE
	9DYDMPFOyXMKbic453ryBBHPGC/whK0AQpCw613MA+pTkum9+pT7OEmjCsOaOzPl
	dd9VneAUznCrmE2epuDBIpewrLwNDH66SUWaicD7T+SMN7teeDYxREBC1YLiELLZ
	IxNAXguMz8zBK6jhQxCtyKIrU2UCn0w9QwYn0Yg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:wLNP5JkzG1l7KHcSFaqGcWr8kyUpsiYACrO3QtPAHC4=:uhJ95VDqDKJMNwb9I3wwYSiAy9eke/gMFiS3IEvpSDU=;
X-ME-Sender: <xms:ulDbalEuPGofxi_bDJVCUgualoniUhYdepSQ9aL1b1Ww5p93DFUTBg>
    <xme:ulDbagUefBaIOnPq_lsZcwawmuR9Wx6odl5HPd9oAd27h-iTgcHIebJ-yVMDk2e30
    _0pJ9OOfPbDZuDmo3jOnlMtjOmvsQufXff5BhvG9KyiTsNvZoeG3Q>
X-ME-Received: <xmr:ulDbakw8tkyiLMBhWPWyNojgTSzcupo6f7qL52euydE7bfMFjJOyYpELfV_F150IE1Ck-w>
X-ME-Proxy-Cause: dmFkZTEjg6VmdMvEiAdInY9ekPhuEQCLs2p+pucce+RWyfqyLNHGHo5SQduUsccKhihQTj
    qHLb0LabhxWE40bZdUvEACkYcB/N8IZF7pqxk8yL9i/T219UNq+8k0UDq2bv4mqtHW/lxt
    0v6V3UULoyFSdc1XtR5YaOz1lheVW4ETKPBSGS+OnAGBT8RyuCXY4MQcHLeuOHnKWAlQjm
    ykgIXRTB5vhDrBK1nY8uiYTrRedJoBJw4YURpAWHZQTMui2H9n6gLFMBsF6aauCo4VcNlp
    /yYomxQezp6NlvFc1ICYi5GYmf/FX1jYGcGWnjgnhOsHgblKS50FPC82Wyr/cU8jJpX5Nz
    BG9a4Qy9tnsoy8QYI33GCUtKoX1V4qLvRdW2Io5I7DH7oXFT3rCs3O3h1TG8VjHK92mhPu
    +BddI/u4AgnHiFBbBPQYgZluexCU298lFZ7mlyyqzcUxYKY/83m2rmyHVxpnpsFs2oOCk4
    Mm1j0YPoFpN/IJlic2gvClFHArQlqppNxj67ZJofnE5l6ntQmzQvJv4ECtilnV02NqDZO6
    HmreJzPi/14PZkx1vF3XwdJEQa1AvEgFwOsWVz0K4FqsYSyoUNKUwMDUvQX0Y8XpD93jzk
    fY04T9JLwTj2dtmdziznEokOW0WOXsM1ADrhbY4B6MRXLxIojMtD1dgmWgYA
X-ME-Proxy: <xmx:ulDbamM9rgmKlhaYgkqcODFzxdlaBVJMhBHgsBq__PVMP5Sb2z26IA>
    <xmx:ulDbat6SYQWMMJMbfMkiz9yPf--IWFa5nwIwweX2HCOEOCkL2uEYmw>
    <xmx:ulDbavPnvnqybIRsBQk1aC20Z8Gz7vtRvpafEA8O3cyi0ietLFXg2g>
    <xmx:ulDbajnHRTHhFhsCBxYOHt6_FQ9nZbaUWPAnSHGTvisrjTB2g58-PA>
    <xmx:ulDbal3mCSSBiZteQNEBQi65mtk6baoP9onDQdCFK23BmOPJ9O5uQm31>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 08:19:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c6fbad20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 12:19:04 +0000 (UTC)
Date: Fri, 23 Oct 2026 14:19:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] tmp-objdir: merge loose object index when migrating
 tmpdir
Message-ID: <attQtZ1dVoAnQznP@pks.im>
References: <20261022234007.3081825-1-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022234007.3081825-1-jltobler@gmail.com>

On Thu, Oct 22, 2026 at 06:40:07PM -0500, Justin Tobler wrote:
> When a repository is configured with a compatibility hash, each loose
> object write also records a mapping between the object and its
> compatibility hash in a "loose-object-idx" file. This index is located
> in the same object database the object is written to. If batch fsync of

You probably mean "object directory", not "database"?

> loose objects is also enabled, the loose objects and index file are
> instead written to a temporary object directory and expected to be
> migrated to the primary object directory when the batch transaction
> commits.
> 
> While migrating the loose objects works, the "loose-object-idx" file is
> unable to be migrated if an index already exists in the primary object

The naming really throws me off, "index" to me is our staging area. What
this is is a map. But oh, well, cannot change that now.

> directory. This occurs because `finalize_object_file_flags()` expects an
> already existing file to have the same contents. Otherwise, the
> following error is returned:
> 
>   error: files '.git/objects/tmp_objdir-bulk-fsync-XXXXXX/loose-object-idx' and '.git/objects/loose-object-idx' differ in contents
>   error: unable to migrate temporary objects
> 
> Furthermore, it is not sufficient to just replace the preexisting index
> with the new one as the new index only contains mapping entries for the
> newly written objects.
> 
> Update the temporary directory migration logic to handle
> "loose-object-idx" files explicitly by appending new mapping entries to
> the primary index.

Sounds sensible.

> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
> 
> Greetings,
> 
> While working on a separate patch series to convert the "files" ODB
> transaction to be eagerly created instead of lazily, I encountered this
> bug that causes an ODB transaction to fail on commit when a
> compatibility hash is also configured. This occurs because the temporary
> directory migration code does not know how to handle the loose object
> index file.
> 
> This patch addresses updating the migration logic to explicitly merge
> mapping entries in the transaction by appending them to the primary
> loose object index file.
> 
> Some other approaches I considered:
>   - Storing the uncommitted object mapping entries in the transaction
>     without writing a file and only writing on transaction commit. I
>     chose to keep writing the temp index into the transaction so that
>     child processes that write to the tempdir could still append entries.

Is that a theoretical scenario or do we actually have cases where a
child process wants to write data into the quarantine directory, too?

>   - Also writing mapping entires to the main ODB loose object index.
>     This also didn't seem like a good apprach because it write entires
>     that may not ultimately get committed.

Agreed, we shouldn't commit this before the actual objects exist. I bet
we don't properly handle this during housekeeping either -- or at least
I never stumbled over logic that prunes mappings when pruning the
corresponding objects. But that's a problem to solve another day.

> diff --git a/loose.c b/loose.c
> index d6a2bb5ba3..79d4c256e0 100644
> --- a/loose.c
> +++ b/loose.c
> @@ -265,3 +265,75 @@ void loose_object_map_clear(struct loose_object_map **map)
>  	free(m);
>  	*map = NULL;
>  }
> +
> +int loose_object_idx_merge(struct repository *repo, const char *src,
> +			   const char *dst)
> +{
> +	struct lock_file lock = LOCK_INIT;
> +	struct strbuf buf = STRBUF_INIT;
> +	struct stat st;
> +	FILE *fp;
> +	int fd = -1;
> +	int ret;
> +
> +	fp = fopen(src, "r");
> +	if (!fp) {
> +		ret = error_errno(_("unable to open %s"), src);
> +		goto out;
> +	}
> +	if (strbuf_getwholeline(&buf, fp, '\n') || strcmp(buf.buf, loose_object_header)) {
> +		ret = error(_("invalid loose object index %s"), src);
> +		goto out;
> +	}

Curious. Why do we even expect that this file may be broken?

> +	if (repo_hold_lock_file_for_update_timeout(repo, &lock, dst, 0, -1) < 0) {
> +		ret = error_errno(_("unable to lock %s"), dst);
> +		goto out;
> +	}

With a timeout of -1 we'll block indefinitely. That doesn't feel like
the best option to me, as the lockfile may be left over from a previous
process. And Git locking up indefinitely feels suboptimal to me.

> +	fd = open(dst, O_WRONLY | O_CREAT | O_APPEND, 0666);

I don't think it's a good idea to append data under the lock. It may
easily cause us to corrupt the file in case the write succeeds
partially, only.

Our usual pattern here is to create the lockfile, write all data into
the new file and then rename it into place.

I'm also a bit surprised that the file isn't sorted. Is a reader
expected to always read _all_ mappings?

> +	if (fd < 0) {
> +		ret = error_errno(_("unable to open %s"), dst);
> +		goto out;
> +	}
> +	if (fstat(fd, &st) < 0) {
> +		ret = error_errno(_("unable to stat %s"), dst);
> +		goto out;
> +	}
> +
> +	/* Create the loose-object-idx if one does not already exist. */
> +	if (!st.st_size && write_in_full(fd, loose_object_header,
> +					 strlen(loose_object_header)) < 0) {
> +		ret = error_errno(_("failed to write loose object index header"));
> +		goto out;
> +	}
> +
> +	while (!strbuf_getwholeline(&buf, fp, '\n')) {
> +		if (write_in_full(fd, buf.buf, buf.len) < 0) {
> +			ret = error_errno(_("failed to write loose object index %s"),
> +					  dst);
> +			goto out;
> +		}
> +	}

When merging, wouldn't we have to verify that the object IDs that we're
adding don't already exist?

> diff --git a/tmp-objdir.c b/tmp-objdir.c
> index 3debb60270..5307717354 100644
> --- a/tmp-objdir.c
> +++ b/tmp-objdir.c
> @@ -317,7 +323,10 @@ static int migrate_paths(struct tmp_objdir *t,
>  		if (is_loose_object_shard(name))
>  			flags_copy |= FOF_SKIP_COLLISION_CHECK;
>  
> -		ret |= migrate_one(t, src, dst, flags_copy);
> +		if (is_loose_object_idx(name))
> +			ret |= loose_object_idx_merge(t->repo, src->buf, dst->buf);
> +		else
> +			ret |= migrate_one(t, src, dst, flags_copy);

Makes sense.

Thanks!

Patrick
