Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276639;
	b=w5VZoDMYRI8G1VHNxFmc/bTVkG0G/Tky3W6Nlj7Omq7j9zoFfKI5ok1TKb86tenKzW7D
	 USgEKyqrZuDG7uXULVG5ySJEOTa5BeN54xg22psGprILFs+QdPx8AtrPN4zVDsSDSPqBX
	 jUz5FPI2JptLFH8f2Z0bTwOxZCRqIA0Kl5KE40aNFYnYg/yAYxal4NQfE2PInE7zRDV95
	 3GWaTs8zPJy8dEGe8aCsI3a6yVitKTPjBB+/z/2q36DvR5Qd4+w533gTQ0PY019v5hgPR
	 YqJyAUUowaw7Q9WbpWkJLrEQcoB4T2L+TIl9GZiOA4JAiUbVf4khWocpYhItJnY4Gmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276639;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3araOx81CE6jHTT0oKx8ED6Q2m9hHdrkT5FPmwR8JEw=;
	b=K7gVHMG5OEqTW2ivsGN6qRUQXonuGYfGMgqHV2sd4Xj/4u4kZocwygLWCctz8VBIxWUu
	 dOc2oN1hSrXvsyIpLO0YET2z1RxLQZFliX4iKWlZf/xC0KwGcU8FjiS17zlDiE2/VLidp
	 0qLvvQDmz5HxK6v2h5GqkEt+lprgkyhPfY/pC4gCz+/9icrtVLQ2pWxTZfLWfByRhRL8H
	 Kly5N8GmY12TSa0m+4TmUwgSkrnqbi2epsCFa6hUP3EhtMhYWqC3YR0bncwAAFKyegdPK
	 ro/ZBtqK5l4erlvYdiMdpptKbNKQfSsa3Vm1UsZK4hZXNAPyaBpcCRdYzn7rxQdp/wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=qlgQ5gBd;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=CKdQiFSB;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C5606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 12:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 462C5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=qlgQ5gBd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=CKdQiFSB
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 98A351D000E3
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 08:23:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 29 Oct 2026 08:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793276638; x=1793363038; bh=3araOx81CE
	6jHTT0oKx8ED6Q2m9hHdrkT5FPmwR8JEw=; b=qlgQ5gBdcl/QIUPY0E7DmbPAnD
	EDSUeM1XZft3v7j0qHWiwFxMCmDzNn/0kOlV3FzsV5zsi1+jIKQvPL049sa60u21
	0R83CTtWVpCD+TIqU+oQmlNhThDU1XWp25qKFXZ4sxze7C3ucTQvHuiEg8eeg346
	LLIa0OD7D0IPApZFvTOoOHrfSsJe4ARnMRrSZpLT5Zlm/piZw4QE2domawbvnXcs
	iqCmlNpNjVusMcKgwhwARzcUUJsFouIO+1BaoTsjz4jcLWy3a5HkumU0DpPUGEGv
	2nOLVYglwZZkZb/hr6W7NnRVYbMslT4NsaQIhpUR1bwjociKMDUNXjPe4v5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793276638; x=1793363038; bh=3araOx81CE6jHTT0oKx8ED6Q2m9hHdrkT5F
	PmwR8JEw=; b=CKdQiFSBMiCsC/6dCrel4DBl04gH0Ly/1Lf3yDofZKJeZ4joEMA
	qghM2TdH08Wx7sVpShSP3q/glaNQwbZ/pMzJOtPMTPcDPOeX8KBYzfPTH1rCAgWC
	hUs2ugl4tqvh3eL409HvYVMz99dsAGXlprGhdBU/dVi5iyzPUqwy9hkXirxcwxbo
	HylFQiv8SE3NJr1EaKJnH/X5LcuuZflSEAkNwVJSe9EOGr+T8jtkcWxyLrcBdNV0
	eAz+zWoQnuFxBfHsOYGTaEeBDvINRfbTnaBcaQkdxVEOa7HUViTqnns38M6wMg3l
	xigVsql0Hx+R2AL8hK1SdXtT8axCpEz2IqA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793276638; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:O1KoFIH5dZa3J5PrWOIWK8Ch3ij3M5507AU8YfahM34pA9X
	IjS6qu3x18/L32sL33Y/47DibEkst1yVC8ZgT9EN/mMB9/jIy2gltxM9maeqXPEV
	VjiwRxMfPq/x8Cwzk77wmY4cr1VpS9VYrg12xFfVI0n6BRcADoE3nhXkCWXEKUar
	4Y9BHhOc6w9dA69wo/qgu4ffA9y97UTWkI1TpAL/3KKXrQTFhl97zII03Kbnaa9L
	RHzKG6rYxK2boPaPivRQmEnlI0sM8G4alhYwdcQmXlj4kKcW3yqi9235E9cWUGpE
	QCtCf7DISM0iIZKAIoXEZ4vRUxuna5kfEotAtNA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:erbc+Kz/wUMyOHOj5aCLUs0N4JKcMms5s7R0BadKpsg=:s4+fGf7ZvKsG6Dw8kWcw3TncZOG1cJb+2p6zzEhIhdU=;
X-ME-Sender: <xms:3jrjan4KOxxnBxm2inKZwJ1-4Ru4TJq5daVltUrEeJkbIqwDCOInFw>
    <xme:3jrjai5LTNnD0EuyID6KfnWCMgtlgho8Alml9neYBcm3I1IMSqa7S_DX9agbAvVT5
    o-v10_z5hjP2CvEzlAHcXCFmLkiS9BpfazhRk5nrXcO4rJTmqlhZjI>
X-ME-Received: <xmr:3jrjasFMuHeAuo_Oo8PBo0ivbLZICIQrZIu0cqdXmKyeEHtgPIpSdA>
X-ME-Proxy-Cause: dmFkZTEMAy0uuL/2aLJLtrF7tUCsqK4JYIAvoEcemK+8fGOd23dxubuER8xAE8FUfaLRi9
    4Z/KjTVqrCNwvJ6Q5JOLcpuA/ZJKdFMhWpz6W/PnRHFORH6s3MI7TdJvOtd7MWHtJWKLNp
    opy4qQmZDsJKXjL3GwY8ut7nNsGQEubHBlqbp0PXjlrmi2y4xyWT1vswBk20AfnjsCEwD0
    md8HQOd2/HLySm47pwD900ddr9eeNDDWanXSNjJ4bHonvRCMDVtd88LSSADzV9YClYo++o
    2Xf7N+m3pPl8BQGkg7IlmFfp1W2DtFMGB81J37qlYGRDFpRionWv0wPEplVY0VR4depoY6
    Dntt7qykbRvZjOr1hBwQOMOHIwAcD4PF8gjThi2CMnDIEBDRfktO1fIdHaAdHJYhBMKzfS
    Oulu0sdlaav6oaHEXut9iw5ymnml2Olr6txEaNHd6snJDukQOEcIhX2dmQD/kFon0Ge5Ow
    c1191Z19RI+jzc6s3acQToK2FBtlFm+gB8FhmXpbMn2lZ0pmez8/Chk+RB/n19W+AOcXzI
    q23ELlNIyU0LvpbHWckI2Rh9uTYgLlLwWOTZCiIddnefw+Mu/EPppJ4RXR5E3E7sJXfJwC
    /QBWiMpPWnVW+DjONkUMCFxyGFw5IRqDTRV0hcp/+cIrU1yOmWHKQBLyt26w
X-ME-Proxy: <xmx:3jrjajRdNNYkuISEliiUbtgrprUvo2JZvwQlKf5qF0Gk0VkGRkZLnQ>
    <xmx:3jrjatvkvi11-rlmRNxJupFxydfb2Qpk79stNCgxiIzeOaAEZ6Z_Fg>
    <xmx:3jrjaqweYH3c232q1OoWCBjYJ9jRlxlLMrvC54nbRUfeXt56xZsK-A>
    <xmx:3jrjav5JoAf-dYp8r1n1ZvJ-IvYjubeS3N_S18Z8yD3ZIJ0QOaEneQ>
    <xmx:3jrjalr9jUmtwbD6RvXdonRZmjmw5bBH48ROIiLb5oCVmGUDO0gjUFIF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 08:23:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 12161e79 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 12:23:56 +0000 (UTC)
Date: Thu, 29 Oct 2026 13:23:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Sami Jawhar <sami@theorem.dev>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] oss-fuzz: set a gitdir in the commit-graph fuzzer
Message-ID: <auM62Vqs56Gv5qjM@pks.im>
References: <CAOJ8FdeyJp4ZOfp99DBSp4brWzngdqzrkSY36ByEh=4UPw28Mg@mail.gmail.com>
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
In-Reply-To: <CAOJ8FdeyJp4ZOfp99DBSp4brWzngdqzrkSY36ByEh=4UPw28Mg@mail.gmail.com>

On Sat, Oct 24, 2026 at 11:50:42AM -0700, Sami Jawhar wrote:
> Since f1141b4391 (commit-graph: refactor `parse_commit_graph()` to take
> a repository, 2025-08-15), parse_commit_graph() calls
> prepare_repo_settings().
> 
> The fuzzer sets settings.initialized, so that git reads no
> configuration. But prepare_repo_settings() checks for a gitdir before
> it reads that flag, and the repository of the fuzzer has no gitdir.
> Thus each input that passes the header and the three required chunks
> stops at
> 
>     BUG: repo-settings.c:40: Cannot add settings for uninitialized repository
> 
> The fuzzer never reaches the code that reads the optional chunks:
> generation data and changed-path Bloom filters.

Oh, indeed. I thought that at one point in time we did a smoke test of
our fuzzers that would have detected issues like this. But seemingly we
don't, or otherwise our CI would have failed.

It would be great to restore that so that fuzzers don't silently break
anymore, but that's certainly outside the scope of this patch series.

> diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
> index 59bbb84..9a226eb 100644
> --- a/oss-fuzz/fuzz-commit-graph.c
> +++ b/oss-fuzz/fuzz-commit-graph.c
> @@ -20,6 +20,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
>  	 * possible.
>  	 */
>  	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +	the_repository->gitdir = xstrdup(".git");
>  	the_repository->settings.initialized = 1;
>  	the_repository->settings.commit_graph_generation_version = 2;
>  	the_repository->settings.commit_graph_changed_paths_version = 1;

We already call `repo_clear()`, so we don't have to manually free this,
either.

So this looks good to me, thanks for the fix!

Patrick
