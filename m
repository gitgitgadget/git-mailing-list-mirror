Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020705;
	b=mbbF3BAkrFcP3RFuzt+XCZUg1d4IdbTW5JH1RecWdIXyL+tO+bSnsrB8QGcRnPh66O2k
	 UQZyJLPGC1izvvOwljpPPCpnTBzyZyNP9qsasSBTmqQ+ajQiQw+8PDrJiC2n3AM965PQk
	 9QDBeoXA9T0co+T2fP7uwr2vTfpFz4Iua1+I515srCOg9h9R55kdtB8MOjCbaT9czJtU3
	 oSzf/lCPEaPfCf+Oc1oY853iYrzO2SY11+agplJAa1VAQGtBCQpj+m+9C/6PnVOOW6tWI
	 6hxfvA8CyE0pz47QZ0SF4X4O/u9q3wC0bNtwyhkXc1NWQS1aIFA6W/biSlwYeK77e/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020705;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=WEdwpuOX8P9Rt+a8EEXeGpcVsLhkTfKuwl2ibQChpoc=;
	b=hIkd7IPTIIuj1qAds9yxMBQXb5HkZ1TrIsmNoUZUDjW3aloeiCYFEJeJ5LT9frxq87IK
	 CWO4e0c/TE+I2837g0J6HPZPAGQyKg0nixXB5hPomjo2oobRh6MkY9XJ8IOvC2JEvhlKm
	 NCH1Y3JMMix38HpOK2My5cu9Nckz3+jCedGWfIypKKmKaHa6Nb0X6QhjQHpsX+Rn4CUKC
	 uNsnzaI+N2RYykGWqg1uDaLYqev+ImfY8ncDxIL64ry3wY98eOgGedU/u0d9+vvkzc2cC
	 eKhAQuC7LOmA9hn8flYQFVLFILkHFUB4B68+rrKIeLLMHdOkaS5Z3Wcs1WYKZ9ig6Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=C5TfFh8d;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=a56TvTe8;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9A6606A33B
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 16:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A9A6606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=C5TfFh8d;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=a56TvTe8
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A4E5EC0193
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 11:51:43 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 18 Nov 2026 11:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795020703;
	 x=1795107103; bh=WEdwpuOX8P9Rt+a8EEXeGpcVsLhkTfKuwl2ibQChpoc=; b=
	C5TfFh8dAfQh237xWj67ICA6qpup27KvHvLvu1o39gOs3p5nkceyyJMOs1+yAfbt
	kibIfCOB/oLBBlV3AYpw8Q78maokSLE0DesrdCBmmcaY6KcPq5jC29ytXsoWoVQP
	Q34Y1wzBtKoxvVJR9AXr8ZE0P6P2vstiRyU0bKARonjVvG1sWYLJIQeGQMu1fsEN
	2fKZJB0XBxP6e9Mzr941ARDFEzRkCQUrVjGnfCNPsVhcZBaNarpM6+BloVjtpbRP
	RkUTOLpbpZpS0HYTpHji/D8GOn+bhamDZEd06ok2JpTaSdei1ZvVM2dpEFib3kIH
	7nONxD3+Cz2V47CMJgspnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795020703; x=
	1795107103; bh=WEdwpuOX8P9Rt+a8EEXeGpcVsLhkTfKuwl2ibQChpoc=; b=a
	56TvTe88i1pa5aB//x2C5dniYb/hOorGCIcMCfVimgi1b3zGe3/YnosbIet24NeG
	TWsm/ToOUKhZkBBRWDSkONAA3zw1+XrmRyvx+IqK0Yy/SfPOA8tAYxIlhPsi3QUU
	9/cRreDCh0prR0RZPAxmQFsBnTWo19EK5JbTndBqh2DMDWcLchSfpp5fZ8VG1rL6
	KmPjE2yxwrXaxGaxo9eT+FsUkegRIoiJIxGTKpmsEQ3ZNe3YfVgx+VB/B1ooHA02
	ecbZJwlS6+QSbTItEfl66oVU9eMjznhS0QG6w6tWmy0LLVrApeqHsmwcMh8o/pJe
	CWrl3j2dEi7o104+TjE0A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795020703; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:BLxcgqwvkMXkjR2mLlEG1Ufzv7MKd7nFLMueY+AoKJEFV44
	Tg0rHfLOMUS2f/tIU1hyome2pge+9FVJ/pe+I2OOT0mWKqfl8Lx4IIm3BjaEVmAZ
	sdcX2E1vO1Ebi0rQyatPOPxoCMveNp3orMUGS73yswyIer+R1n/3j/EI8BFWBZYz
	sRibP+UBXBoBaO3aBjHg5d2usBX6V1YogOH4+VzruyTUAn1/83ZG77ZU6RA+POAK
	dPgNAk4CVjNCItAuDWCebCr6vI+gk8gbjsJb70Yf0nbgIYhX1bcsMI8Drl9X6xFU
	nQNJUnx5qJ/9YuzfKAgAC0CU2yk9iQGGO9yqOOg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:9ayD2QGJ/NltUNrVZEAUTm/HIeu3N/FbMsTygk/dQlc=:tB4EgDuuxSD0O7+vl6ODdlDYIJvRIvm35wPXm8kl2nc=;
X-ME-Sender: <xms:n9f9aqh130wC4N_DIaMTb2T5tDHVIcyFSOtxcZ7TMawGGGU9YK3R6Q>
    <xme:n9f9aicAjFciAaAG4SDbiqF1PXYQDF8gtHU3Rz9HHW6uOM5KSwzUb9V2a-jH2I6Ju
    QvuZKwBRbklxjam7U-whbDBTENjlzY8tCvoHQzMxqV4twcQR5FGbVBo>
X-ME-Received: <xmr:n9f9avciMTkORyRntFQDZ8Kgu3W-0-EoEMbMgK_FARgWs2aOH-ffc3udVDSgl7siKscp8efyAJWWC3fq36iFzXCikx99IM0DdY6p>
X-ME-Proxy-Cause: dmFkZTFeeghWplIEcVem8sswIyYTlHjWhaOAjOJCfLubKbEDbmqGOTL3t7xoGmUvO0JiBM
    eq1H4fKqIEitFuQZGEtgaxWlp8fGDW3ttSb6JoLLz9t/Ly6jHBTqNcC9sJtH04aFozu5Zl
    j26Y638e5qGSMvQP7yiLng+1xS2yNDM1Hh43X0vbqbzr0ll1+NoEHJCZI3fNJJe1R0Sv22
    BmrxJTaAStqDyXAKL7TXOL+S+cdhjWhKCcHe67+fSpiJS+4PQsD0l//LqjptJ/tQGZUdON
    NKv3Sgkm7U/BbQXE2j5u1NdyM53ABhz4BEaGvb+I/giwMzQQGrvOF6ToziJ2jUwQKFVdfT
    MylA8yUD047NB7oghihKc7DN9QBmlVDVSp34S0z6f5tum05uMMea1J1bbAbp1GTVw+PfL3
    ER9Q04UNBQ73jk1wjAFwNMDGw0YFgqLDuBWIZ+j7gsss1SCcEaWdFP+tCv+nSUdLoPjof3
    N3p7qD2md2MOdd+zDLH3S2/F2dTID/YNcjin0POIutdDzWfZiFzrVi7PnC6PJ1wLKbgodr
    GWo45MbuEtIBkxxg1UCV/Dz6/T5dpBadvgMpV2dd79Qyl6ekBqHtcTLobatP6eT0UNRrTA
    /puOSwBuHZByHeDx+8Y80XAzROBLBDHeqyEyTKx2CuC0lxP6SmJi0MIFhQjg
X-ME-Proxy: <xmx:n9f9as9Q1NXD9A9RI6C4w7dDhgnA7-OnbaqxWGUlbtCdK1qxsiLCbg>
    <xmx:n9f9arndNTcvJpMFNhB80qVOdtNNey2h6GT5qqW0YO-usRbHfjxgNw>
    <xmx:n9f9au8eQcZ14Vub5NZxs21G5D300bBCsQFDzk00LYDT-haNKznAQQ>
    <xmx:n9f9apnvqx8YLKsj2hLkk9S3AJqj-Edszer0Vf0f0Qane6TNHfwwiw>
    <xmx:n9f9aqmN5Zu9P0iCA3LGi0UM5R6mldJtVxMgr46qT6v6O_DajopR6fPR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 11:51:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] refs/reftable: don't write new table on dry-run expire
In-Reply-To: <20261118-pks-reflog-expire-performance-v1-1-10b9263566a8@pks.im>
	(Patrick Steinhardt's message of "Wed, 18 Nov 2026 10:31:00 +0100")
References: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
	<20261118-pks-reflog-expire-performance-v1-1-10b9263566a8@pks.im>
Date: Wed, 18 Nov 2026 08:51:41 -0800
Message-ID: <xmqq1p8i84ma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> The `git reflog expire` subcommand supports a dry-run flag. When set, we
> print what would be pruned without actually pruning anything on disk.
>
> But even though the expectation is that the on-disk state won't change,
> the reftable backend still ends up writing a new reftable to disk that
> contains the changes. This is of course rather pointless, as we would
> have already printed the entries that we're about to prune at that point
> in time.

I hope I am right in assuming that the current code already has
provisions to discard (or "not to use") this data written to the
disk.  If so, that means --dry-run is working correctly, and this
change is a performance-only improvement.  Is that the untold piece
of information here?

> Skip writing the data, which provides a small speedup:
>
>   Benchmark 1: git reflog expire --all --dry-run (commit = HEAD~) (10 runs)
>                   mean     ±       σ          min     …     max
>     Wall Time    414.2 ms  ±     2.2 ms     411.8 ms  …   418.0 ms
>     Memory       116.9 MiB ±     0.1 MiB    116.6 MiB …   117.0 MiB
>
>   Benchmark 2: git reflog expire --all --dry-run (commit = HEAD) (10 runs)
>                   mean     ±       σ          min     …     max
>     Wall Time    369.1 ms  ±     3.2 ms     361.9 ms  …   371.9 ms           -10.9%
>     Memory       116.8 MiB ±     0.1 MiB    116.7 MiB …   117.0 MiB           -0.1%
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/reftable-backend.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 3ba6a9ac0db..4216a18684d 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -2706,6 +2706,11 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
>  	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash && !is_null_oid(&oid))
>  		oidread(&arg.update_oid, last_hash, ref_store->repo->hash_algo);
>  
> +	if ((flags & EXPIRE_REFLOGS_DRY_RUN)) {
> +		ret = 0;
> +		goto done;
> +	}
> +
>  	arg.refs = refs;
>  	arg.records = rewritten;
>  	arg.len = logs_nr;
> @@ -2720,8 +2725,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
>  	 * Future improvement: we could skip writing records that were
>  	 * not changed.
>  	 */
> -	if (!(flags & EXPIRE_REFLOGS_DRY_RUN))
> -		ret = reftable_addition_commit(add);
> +	ret = reftable_addition_commit(add);
>  
>  done:
>  	if (add)
