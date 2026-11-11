Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402959;
	b=aM6Ie1e00Q0cMf6aGI9TTkGY12LDg/JuZzJwaGWZM3kQwzhkqG0KSQTiylxKT3zQ3ZAd
	 Uv+UWZIEQuPllxb+J1YumyoXnjVcfa2IYS6BbAS9dX2SzwNIM59HAIDbdhapUyYJaz62B
	 Y5XclWfWF04MHDksBoq0Iq7HUsBWAdjUPtS2DRU0qhRL+/k5JeUaD1TVBad3Fr3bc9v/F
	 3VqHpR5nGmB5UQWfxHI/TyAClgikS8fn1ysKSQzST84OUBFCUgkFSdlZLkfWfXI/NSHWe
	 E4LAjqajS8UivSRNDFQeMBJ4NCMOxJjCcjVBtMv0pnSC4XhbtsS3unEQ7iusuc1wIrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402959;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LYZegmTuzOzU/+TW8EtPKOacliLZYiwZmsBNQ0ZkqRM=;
	b=izuJuPjPZy6vShGI1+NppoQW26luxN6VWeiAsq3MLP34eaNMM3HxyF1Vcl0eptmwKfTb
	 LtkSnAeraPHl1XhENDit6d85lzmIssSLM/GswLimk6kfJ+e5CNICH2dA5NlX8odqvzBvz
	 C9UxlrQOHxoyNw7RjlYMaBJbOkMXMDVv9hxtzfIr7jS3WzjemAwmaIJWnVve2zigS6uPi
	 6Hif6VlyBRH08k2q4wQg1kFbdFdEpc7UIuf0MkSCuI7y8XeIuvtDhVoFgKfaLFdOmUVFc
	 emyi9KNdrzPBVqoIMKl8qSvev7epP+AT55Oe6S5FZ97oZ0I0GGXSmfWtFp8/I6noLpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="rnP0/da2";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cBdeHmXY;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0A606A32E
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 13:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAF0A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=rnP0/da2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cBdeHmXY
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3A6727A02C4
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 08:15:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 08:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794402957; x=1794489357; bh=LYZegmTuzO
	zU/+TW8EtPKOacliLZYiwZmsBNQ0ZkqRM=; b=rnP0/da2/2DO4ULM2y/NC4vNjO
	cdxwhV7tS3FGWRpsIpN8sCa5AU1n+bt0rcUoC5ptHaWcNis9FEzRNliDshhjuMV+
	y1hJr/CetcySF+7npi5uvz+PZDPVRoBDL4a8OG/9rIs9Inf1+KnfuiJyMK0IkOOz
	eLqs1xO1ulAidjxvZD36hAQgxW+7UKKj4CTBD5TJf83QYjIQVCrzjLXqKr1F167s
	fk13wkAhY4sAh3pCkqbCvzhb5z+oBid1zmNo37f013BjgFzmDXdrHlWOf3n5SX/H
	FKeOXbLLDYKUhpX59orQSnLO9ZHy4e3JU2+DLoIpBmwz/dbGnnWJmHJQNkKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794402957; x=1794489357; bh=LYZegmTuzOzU/+TW8EtPKOacliLZYiwZmsB
	NQ0ZkqRM=; b=cBdeHmXYqvRkQYfTUu9kfMRYtugVy/E4muqN+zfW0dS2YhhSNVd
	m9cC1AwXKqq8OZn7K9Q+hS2Y7cKAdXHN4AyViMq9BWeUyCu6HqcRuEyEIXFVaXLi
	RqUAcW3hb/RUyi98abnogm+nRQHccclTKNSpayAUCcjXuuFmGPj7r2TPtGiGqWij
	QMqxfQZafSwKpFh+QCuW2PWeWh5gr6MYweBhs1ANNw622sWcwYlWUl4Rn4RTaEqH
	e9RZcdDCStvKsRRglHLPVvatvLaPO/0N0aq378ENrBtsXFjhN940tEfg4cj8AKrf
	dirU0v1M6q2/9cZnJTYGlTJRZAWz+F7mrzA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794402957; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:cF8OOE3rwXkfOv/jQVg0YU4TXPxFBeJZlY721kSjOU2buIq
	lqtf8tnb7NRXBlYh0RIlrErqReW2oLuJ9HCNGttCFaSlr7p9zLp4yAK3h/GIK9He
	OKkLcfoYPRQG1WkuTWFpQYBHIZWcPYLkdj9IIxQ786tt85wJEhdNT7Ans0s1Guoc
	Pg3LWVquy4/t8RsEnf9eSeadpuCcaASeA68of2+B29UgwnCQUjHcO2qKLFMj4TrC
	I3bFdJR0KqK6k2fkGr2Ea/qN2sZLiBkBzomqVK7x51NnmXyUIJIrMgk1n3atmZj0
	B77H+KA+JysaGKEYJN9Sgq2Vewj5vNBpDwM8wvQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:cJyyrkbjQWyBkQ5FpgwUzpAEwX/Az8YtmfxAnzDeSzg=:EMV60gjeQHYvm6t3qk58197v3uGLJFC3Yk+mCS1YYyw=;
X-ME-Sender: <xms:jWr0anTcgoOe3bAdF2-yk0EJebRE1eQb8QOyrWtHsETEzjdACX4tyQ>
    <xme:jWr0auy0SzxSz_lV_51_C5gHVUOtkYFJCA_z7zpWqLAH_1P7R1EWW44QEc7PBJepW
    gEG8Ho2Ad46XxpWsuayrhC3xSIdMz1fAc8LosSbUhIQcHu69yXQZfo>
X-ME-Received: <xmr:jWr0aqcGoVYdI6wdHqS5WklXpZxQ4QQQ1jM8rW8iSQlI_RROkLeAzYvxgaZME42LtScCIQ>
X-ME-Proxy-Cause: dmFkZTE9VPfVqbQJk4YiCrEUuBKDs/mDudou8T7HU65Znmyra+7UVc/gUQ24I5pHodR3hd
    lno8Zf+iA/il2/8rOFHN6B0qn0asKQ2jtw/lyd14+ZORFlmh2i0yt8ISJqXKygvN8CBYdW
    DwbRdXeRRbq941jJyDVBIOuUYmOLnlc63BmtuJBmEir6Lw3bUgdhojwuhj+bbPOB8DnU/G
    IxpNoZgMfYVnq1rnGyiEotajRlh1PpWULmpWumRZOOflPhP14pHwCnP6+pevUn4DemnCbg
    OK9D8Tf9ypYuvCAkppcj7PHBGMeRW7b/4E4sNilgLw4gpycltnSY/LI4NuzVFyki4N+FCS
    ysT5fWVeq4KAASVmNbjtgqvAQUnOlDu3rdPa+OnRRMEFh+NO0Yrww0x4wrsndWqRkN6yQq
    N+CkxyiDpenNHofPBPum82HNkT2aFnyNhLtOaqcEDymQw5a7YpBi+RfeST9yqEDDX/6spL
    rbE0nTZuS5WlSAfuP8XRi1LLwWSzD3htxxP3yFxgDKedSxmioWCFmutaKtxPFNO0RKNDKs
    iQAAKY6aw5RqupGpUBPeIwYD0Zkqgv76xC3HgxhSqcUYHARmHLqb2MTpCiML7w2764ppp3
    P1Gq/1gqGhYrxZUJ/n6PiqtPLSjybfftGxlvCvcx03fB3SavRMYmbJ+MwFxQ
X-ME-Proxy: <xmx:jWr0aiIoWKrcTvtL6j3mJuucAdix_bpiQE3jArspcvi0yi_REgot5w>
    <xmx:jWr0ajEgtiB9_e21wFFubZDdA2n5hPezsY9HVFML7W_LNN900uNGkw>
    <xmx:jWr0akqmO1cpD71F85MBeMnohGCj_NiS-MPK1gqR3qdBMvrESB48jg>
    <xmx:jWr0akT8mA_TpxojZR9af5xD9_d0KZk9czdSK8Mihvz8PauCt3WEVg>
    <xmx:jWr0arB-L-C85YS41YhbGXwwtb8GAWXOKlziDOoc-ZR5-QB_WYsPS2mP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 08:15:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f876832b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 13:15:55 +0000 (UTC)
Date: Wed, 11 Nov 2026 14:15:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] object-file: create ODB transaction temporary
 directory eagerly
Message-ID: <avRqiH9eIpJUGKMo@pks.im>
References: <20261110002251.2007617-1-jltobler@gmail.com>
 <20261110002251.2007617-5-jltobler@gmail.com>
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
In-Reply-To: <20261110002251.2007617-5-jltobler@gmail.com>

On Mon, Nov 09, 2026 at 06:22:51PM -0600, Justin Tobler wrote:
> By default, ODB transactions for the "files" backend create their
> temporary object directory lazily once the first loose object is about
> to be written, and only if batched fsync is enabled. Transactions
> configured for git-receive-pack(1) are the exception as the directory is
> needed to quarantine incoming objects up front. Lazily creating the
> temporary directory in this manner is awkward for a couple of reasons:
> 
>   - Writing loose objects has to know about the transaction internals to
>     trigger the lazy creation of the temporary object directory.
> 
>   - Whether objects are staged in a temporary object directory, and thus
>     whether they become visible at once on commit, depends on the
>     configured fsync method.

And three: the whole premise of creating ad-hoc transactions behind the
caller's back for the purpose of bulk-flushing writes to disk is
somewhat flawed in the first place. In a perfect world I'd think that
callers would manually manage their object transactions in all cases
where they know to write multiple objects at once.

But we don't live in that world (yet), and this step here brings us a
bit closer to it.

> diff --git a/object-file.c b/object-file.c
> index da189111bd..a9fb42705c 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1573,24 +1550,13 @@ int odb_transaction_files_begin(struct odb_source *source,
>  	transaction->flags = flags;
>  	strvec_init(&transaction->pack_names);
>  
> -	transaction->prefix = "transaction";
> -	if (flags & ODB_TRANSACTION_RECEIVE) {
> -		/*
> -		 * ODB transactions for git-receive-pack(1) eagerly create a
> -		 * temporary directory and use a different temporary directory
> -		 * prefix.
> -		 *
> -		 * NEEDSWORK: This transaction flag is only used by the "files"
> -		 * backend to special case temporary directory set up and
> -		 * handling. Ideally transaction users should not have to care
> -		 * though. To avoid this, we could eagerly create the temporary
> -		 * directory and use the same prefix name for all transactions.
> -		 */
> -		transaction->prefix = "incoming";
> -		if (odb_transaction_files_prepare(&transaction->base)) {
> -			free(transaction);
> -			return -1;
> -		}
> +	prefix = flags & ODB_TRANSACTION_RECEIVE ? "incoming" : "transaction";

Makes me wonder whether it's important to keep the "incoming" prefix
here or whether there is an argument to be made that it should simply be
called "transaction", as well.

That may be out of scope for this series though.

> +	transaction->objdir = tmp_objdir_create(source->odb->repo, prefix, 0);
> +	if (!transaction->objdir) {
> +		ret = error_errno(_("unable to create temporary object directory in %s"),
> +				  source->path);
> +		free(transaction);
> +		return ret;
>  	}
>  
>  	*out = &transaction->base;

Nice, this logic becomes quite a bit simpler.

> diff --git a/odb/source-loose.c b/odb/source-loose.c
> index 50cb388c35..9330ae94b5 100644
> --- a/odb/source-loose.c
> +++ b/odb/source-loose.c
> @@ -769,9 +769,6 @@ static int write_loose_object(struct odb_source_loose *loose,
>  	static struct strbuf tmp_file = STRBUF_INIT;
>  	static struct strbuf filename = STRBUF_INIT;
>  
> -	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
> -		odb_transaction_files_prepare(loose->base.odb->transaction);
> -
>  	odb_loose_path(loose, &filename, oid);
>  
>  	fd = start_loose_object_common(loose, &tmp_file, filename.buf, flags,
> @@ -860,9 +857,6 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
>  	char hdr[MAX_HEADER_LEN];
>  	int hdrlen;
>  
> -	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
> -		odb_transaction_files_prepare(loose->base.odb->transaction);
> -
>  	/* Since oid is not determined, save tmp file to odb path. */
>  	strbuf_addf(&filename, "%s/", loose->base.path);
>  	hdrlen = format_object_header(hdr, sizeof(hdr), in_stream->type, in_stream->size);

Nice to see that we can get rid of all of this leaking abstraction.

> diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
> index 3bdafbae0f..7292672a66 100755
> --- a/t/t0004-unwritable.sh
> +++ b/t/t0004-unwritable.sh
> @@ -24,8 +24,8 @@ test_expect_success POSIXPERM,SANITY 'write-tree should notice unwritable reposi
>  test_lazy_prereq WRITE_TREE_OUT 'test -e "$TRASH_DIRECTORY"/out.write-tree'
>  test_expect_success WRITE_TREE_OUT 'write-tree output on unwritable repository' '
>  	cat >expect <<-\EOF &&
> -	error: insufficient permission for adding an object to repository database .git/objects
> -	fatal: git-write-tree: error building trees
> +	error: unable to create temporary object directory in .git/objects: Permission denied
> +	fatal: failed to start ODB transaction

Not a new issue, but this second error message is awful. An average user
won't have any idea what an "ODB" even is. s/ODB/object/ would make a
lot more sense.

Patrick
