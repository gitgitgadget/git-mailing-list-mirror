Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402969;
	b=xc4pXQe1OCqqH238cDfkjpOswNo33LyMvz0i192zY6yK6bEy7ft+vViOkVSBW8ZMk50l
	 CEA5btmk/QbRv6/1KsYBNnK8sFL6Vhqd2UVQhUFLKdvZvTu6p9EuyuN3hcKW6rGHVQfxA
	 7GLekHRtWBj9aHYUx5AEM2M/RaM62WETFivfMmJA9i6mo+DG/efCu7/r03V3Q8pSpNaIN
	 k3viSBGhGofYW71VcwJjhkFAwp1VVABeQfPMJskQDX+vzsZ0U9XHv6HxyTPWiBVOD6UrQ
	 sWKt/tO/1V444FSrcY+9DVGUviRk2keRnv7X7p10C5Y41yUCJzYrJs8PIOTpzzfbvKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402969;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QNug/HCiNFNIxQZvvuQai+IYukIBA/+RkYfQB8zJeQw=;
	b=3FZyzq1d9XeEeBiFT/HTT3six2ZMWz3un9HuiRWEKPRtIu8+D86Z8kjMKUuwhFrCWJRi
	 ImlJfGBJHn52ILoFmuPiwYA2CDEnt+YKdUyUTh6j+puW+L8SqMXRM+pN5X3B33eD0yFvB
	 xZIfUUanSFlaMPJ05CA685W8hEGIH/cxpKZ3lSRoJ8ORdDSgZxSo+TIWyX2+V1UCUmq5F
	 1iIKa1u2IJu+DfbEZEqp2u5+wvv8mI6U7aJgVOtZ0X0M3uzKxaujslBsKphYVDQCmblsv
	 Kpo39z9qPqnztQANR8IkwmA0dGLM4XqV+6lpnh7g0q1gXRkODZpTHeyLSiKiSJKYW/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=WosfhzDs;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=BuJYhMSw;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F384606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 13:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F384606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=WosfhzDs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=BuJYhMSw
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id BEDD61D00223
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 08:16:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 11 Nov 2026 08:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794402968; x=1794489368; bh=QNug/HCiNF
	NIxQZvvuQai+IYukIBA/+RkYfQB8zJeQw=; b=WosfhzDseEXk5G7W9aRIYAy9Lx
	d6jc3oYYeTnjlQG9LS4bTrNNgXEauRciWvSPrrndWOU+D4kEHoEbp+BZxilVgDfJ
	OYImB+HNndxlI9pvwa+cX1pxdtYS3CHFM+j5N+/rq21pfnkcjK0AFafRWSi2onoZ
	7Rzv1nK4YW9fdvd7FlfmIqovnNf6j3DtCWELLTaoqn8R68lMXThoislvEZjIK9Jd
	vf1Fs1C+yYjajAIvL02dJreEJ4BW7MDiWlQ+hsJZ+O9JyiIchjKbxckCDTuqEo4A
	PmYz9LVEV52SfzsTiObUsgpjMVj7HrzbP/G//qEGbmBeLmKst8+RJr2rm76w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794402968; x=1794489368; bh=QNug/HCiNFNIxQZvvuQai+IYukIBA/+RkYf
	QB8zJeQw=; b=BuJYhMSwsKOi8Y5SzJvlxF1GwaVSeJQwlFDDIM4YKE+hAiY5tyN
	tN2SSR7ajP9NaI+uTUVuq/YhiUwuDT2pHfv+M2FPoml8kf66YQtQOzCMsFCQLUcy
	iEpHqmexpuCLp/uP08IrpknLifNBaOa05YBmT8qBpC54SOSL3cS7sY2u/uaErJBN
	wGdQ22p1deJPP4wmFLV6oRF9Ot+UeG8KJu6dbfRCHFwIhZ/J5NKgBw0b2eXoHlXz
	MiqUhPhWa3mzw2NAM+YvuPIFHxxMLflEEWXsd331xHxyZEqjsgvdD2rnpdMFWfJG
	tweNac/XAHhRzn3McPOC1Nu2RCUm+kT4eww==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794402968; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:um3UhT3sT0PsLWXImcacEw2AE+a54yVNfudN0g9jdfOX6UK
	UkPVG8Fzdh2T7tnt+i89dPE0ojekLrkU2tQTksncaiC803oFN9L9Hh7W7z9JjFVd
	NoLJH6ooPXdVOCZF6qHHiu6MyBrnXpoi/qwyilHSIv8QaRz4vWP8dWjgG75ITnoi
	cmsSqwpYdCgrRnVvB8etLeaWINL40b6KUSqjy2aHoUCoA7EQzMqdhbyDBmJlqaSS
	6tAA9g0Jpx2piKyXqfsiJHB+pq/KEQpLX145uXxB6AJ5o+gXwUynyi3tWBMmH8BK
	zFAcT3GythoE7yvoMxookHyzNYblJTN4dhJ2bdA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:lhhDjQ6qlG7TPSORdGQSeEGqaKAa9E6XDLKi2Zic99A=:gyd9NJGhRV5bSaz3kPqb9QL7f/CjRSWzRZ1s1xbDado=;
X-ME-Sender: <xms:mGr0apTygAUNWujpYPoZzmhJLqHyk7kY2pI8P9ElIrT2w5sIHmvMGA>
    <xme:mGr0aozg2wJvwkUqalil5t-AjD3xw6N7VVF3-6oz24E66R0Q-H-7Ypxr_ss1jNnQC
    TfkNIuee4375hHpvjbJ8NxvFpLN0jrmI3XLK7ddZ0XPtQB3p8M64g>
X-ME-Received: <xmr:mGr0asdZtWCi_wTK5UL-44KT3kJnq93xF_hpKktl1JXyTNBMlVThwXbvepLUzoShS-7doQ>
X-ME-Proxy-Cause: dmFkZTE9VPfVqbQJk4YiCrEUuBKDs/mDudou8T7HU65Znmyra+7UVc/gUQ24I5pHodR3hd
    lno8Zf+iA/il2/8rOFHN6B0qn0asKQ2jtw/lyd14+ZORFlmh2i0yt8ISJqXKygvN8CBYdW
    DwbRdXeRRbq941jJyDVBIOuUYmOLnlc63BmtuJBmEir6Lw3bUgdhojwuhj+bbPOB8DnU/G
    IxpNoZgMfYVnq1rnGyiEotajRlh1PpWULmpWumRZOOflPhP14pHwCnP6+pevUn4DemnCbg
    OK9D8Tf9ypYuvCAkppcj7PHBGMeRW7b/4E4sNilgLw4gpycltnSY/LI4NuzVFyki4N+FhW
    FwrNPXqWlu/MYQmh6NmmTkAfZN1RlIarcZaQqtG0/qLyc7KnHL+mcs3gxG4gLwXp3+2Ugq
    sEdEKwwzLgiisNzX1DeLVqcESvEUyHTprpeyi9GW6Ymcf8lp5y1ZSgSwVm3j183I4NegXx
    9ZLKcnjmE5jl41WMKFnu4zDGNtMtxyK7dqv0nXO1jafhWMM7AAxChngwAYZOMQw62MS3bx
    NHVw9AbnRGytVA7JQnqQsORsSBTwnjoibMttYDIC1+nMn6fZ7u89EWxPuRGEw2GSgX1S+n
    7U9va/OPWfbMwhDf4MTiwFEXm6T7kBUQmRHl+R+LoSdx3WdmJOU+raq4R9Sg
X-ME-Proxy: <xmx:mGr0asJMLplduKIqHdmlkppU66mEU_S_bxvE2Rf14G2rB3aJoo2uuA>
    <xmx:mGr0alF4S7rjdZg_MGGhD1RknB20ZgFmbf42LvTgYVe2u07F9NeYLA>
    <xmx:mGr0aurrfuZ20_iaeLcKy2KbQiQPkLU3cpMvJQ915m-5GOQEvBl-gA>
    <xmx:mGr0amRhS29XFomhwi6oiyETiVFIVvfyn_HP4i4TJsXqeKNL5s8ZSA>
    <xmx:mGr0atD2qZqcSPoSpEwB19j82Lmc64uTD0wRYGUwgBaysf8q7cDSg28J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 08:16:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 16dfed67 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 13:16:07 +0000 (UTC)
Date: Wed, 11 Nov 2026 14:16:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] object-file: only flush batched fsync writes when
 enabled
Message-ID: <avRqlHdN83O67HB1@pks.im>
References: <20261110002251.2007617-1-jltobler@gmail.com>
 <20261110002251.2007617-3-jltobler@gmail.com>
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
In-Reply-To: <20261110002251.2007617-3-jltobler@gmail.com>

On Mon, Nov 09, 2026 at 06:22:49PM -0600, Justin Tobler wrote:
> When committing an ODB transaction for the "files" backend, a full
> hardware flush is issued against a temporary file before the staged
> objects are migrated into the main object database. This flush acts as a
> barrier for objects that have been written with batched fsync, where
> `odb_transaction_files_fsync()` only issues a writeout request for each
> object instead of fully syncing it.

Hmm, okay. The difference here is bascially that we don't issue a
hardware flush. So we know that the data is not in the page cache
anymore, but it may still only be cached by the disk.

> The flush is issued whenever the transaction has a temporary object
> directory though, regardless of whether batched fsync is actually
> enabled. For transactions configured for git-receive-pack(1), the
> temporary object directory is always created, so the flush is also
> performed when objects are synced individually or not synced at all. In
> those cases there are no pending writeout requests and the flush is
> unnecessary. Only issue the flush when batched fsync is enabled
> accordingly.

So this is essentially a performance optimization?

> diff --git a/object-file.c b/object-file.c
> index 201d9d6490..da189111bd 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1330,6 +1330,29 @@ static int write_pack_lockfiles(struct odb_transaction_files *transaction)
>  	return ret;
>  }
>  
> +static void flush_batched_fsync(struct repository *repo)

Okay. Instead of adding more nesting you extract the code into a
function that gets called conditionally. Fair.

> +{
> +	struct strbuf temp_path = STRBUF_INIT;
> +	struct tempfile *temp;
> +
> +	/*
> +	 * Issue a full hardware flush against a temporary file to ensure
> +	 * that all objects are durable before any renames occur. The code in
> +	 * odb_transaction_files_fsync has already issued a writeout
> +	 * request, but it has not flushed any writeback cache in the storage
> +	 * hardware or any filesystem logs. This fsync call acts as a barrier
> +	 * to ensure that the data in each new object file is durable before
> +	 * the final name is visible.
> +	 */
> +	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
> +		    repo_get_object_directory(repo));
> +	temp = xmks_tempfile(temp_path.buf);
> +	fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
> +
> +	strbuf_release(&temp_path);
> +	delete_tempfile(&temp);
> +}
> +
>  static int odb_transaction_files_commit(struct odb_transaction *base)
>  {
>  	struct odb_transaction_files *transaction =
> @@ -1339,24 +1362,8 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
>  	flush_packfile_transaction(transaction);
>  
>  	if (transaction->objdir) {
> -		struct strbuf temp_path = STRBUF_INIT;
> -		struct tempfile *temp;
> -
> -		/*
> -		 * Issue a full hardware flush against a temporary file to ensure
> -		 * that all objects are durable before any renames occur. The code in
> -		 * odb_transaction_files_fsync has already issued a writeout
> -		 * request, but it has not flushed any writeback cache in the storage
> -		 * hardware or any filesystem logs. This fsync call acts as a barrier
> -		 * to ensure that the data in each new object file is durable before
> -		 * the final name is visible.
> -		 */
> -		strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
> -			    repo_get_object_directory(transaction->base.source->odb->repo));
> -		temp = xmks_tempfile(temp_path.buf);
> -		fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
> -		delete_tempfile(&temp);
> -		strbuf_release(&temp_path);
> +		if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
> +			flush_batched_fsync(transaction->base.source->odb->repo);

I assume that we only support batched fsyncs for loose objects in the
first place? In other words, if a transaction were to write a bunch of
packfiles, it would not be possible to batch-fsync those right now?

If so this new condition correct to me. But I think this should be
documented as part of the commit message, because it's an implicit
assumption.

Patrick
