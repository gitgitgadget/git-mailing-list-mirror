Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974457;
	b=cLe0k2bTBNG5v96c5rF9Wg69BZUkeKnST80ZEeg/uUqjRG7injiHPNeE5THbjucoSZE5
	 FbeH0kaWog6ka9Y6Jibv4bugE6ZDNWSv6TucOsH/tCk9QB4E/SNo/D/lEhPQF0Da8jIOu
	 W4AHsf+9rpIP3aArqqpIWSZ1YxuSTTkW64sPUUuQGoa9XbptrLNb3ABTkd3PT4y3zRsRj
	 Teh1W7egISEPoJsUZl/RyGf8V6f4qQN5eQkcWqJJnWH0QuZhHTdstil6upuGHVd7p5j4m
	 jsQNa/fodVUv8ICd5c98/pBSZuug1F7Yg+AxLH3OzySeR6oxN2NGgMuxUCqy8W03tWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974457;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=s5UY6gy0HpczeBl58UpepURsH2YLvavRMqktRyrL3EM=;
	b=g99P9fRreRLIuB0YB0bcgz1DdGtwuW3j3wLPaiiManwkw1I9NLxo2FTnkBjuTKhBDGBi
	 NJNBEVnonlpzDZKakIo+qLo4ULX7HLnbYv+NMiyrU7SrKUYwugXgB6zIuk4OdomMu9d6s
	 PkDMESIN1T1P7haW2+6yQ76+ilk/laQHk563z4rkb0ChUWVs0VSIObUQzAPFVglCf5dAt
	 QdOeU4pcln8pTd0LStko5Saeji/f3a1SKf5Lrh33g4leuH4Q3720qyV6nvZWT2X9uDlsv
	 OMO8Fh0pprpAiHVo2SG+geX+3VYQZxOyXWzafL+bJMgZ9185ioS/cvxKY5NLi3vFUjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="KKTH/aLI";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vCwlX1kY;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6C9606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 14:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E6C9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=KKTH/aLI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vCwlX1kY
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 63CB47A0185
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 09:14:16 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 06 Nov 2026 09:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793974456; x=1794060856; bh=s5UY6gy0Hp
	czeBl58UpepURsH2YLvavRMqktRyrL3EM=; b=KKTH/aLIfbBQvjdu5uGEF3dBnA
	SXgu0jgiC6OWVTevKG4IxPjEq9tmKCFOpKodIRwJkuN0+6259vgWdw+OTVgZBkyQ
	ZJ+3DTzDiqKtaq5YGXOboPT3Q5Ls01qEe7fPM7+MYxrLesAsXIV0f5Ea3c0O/if/
	4p2zD4DCsxOWmRH4iaA6lOePWStg3iUKmpXfr/wDse3IKS6veksmZn3+S3s1omAe
	Lfz261qJ4+FgqncEwE6qFKDfXE+WX0lpRAqHXwjbl0xlix0i8wHSM7FaTfcItk4/
	iYu875ey5vGdniA4s4IqXaA4OeDnT6hvvCcbxCV1vTfAl2HwYEGOKEaLJU8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793974456; x=1794060856; bh=s5UY6gy0HpczeBl58UpepURsH2YLvavRMqk
	tRyrL3EM=; b=vCwlX1kYk8VCBmFnRhnYZnaiSmpQzXbepAD0TZ7BSDpQfYNAsvY
	PixcCpc3AsBEJVxDzih1XaW9U7XOFF1bXzwEK9/bOwMQwryTC0b3ZyRFT3ty39T1
	gDAiz9wWOgaHJKwOJRwPBgQ8cvu2PtBiWXrk22TYxnwJ/tsMWm/Lldh1dVIY3ROj
	/65FuFyc3XeAJkiTviabIrgAcdKGT7w5MVu2NBE26ZqW7s0aOC3+j8xlH66zcJfD
	RV8nb+INnIpiW/IgBTMpvcB7HNotgmQhhwryUDVc7GPlRUm9pUR6EK1rSFjobngO
	wS4jU49XgWXWroOYstoHmD7bszRZZqPB3vg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793974456; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ath/ndpxAPI1HPfC0N6ShB3F+Qe/f0BB46VPUiXDxAIsccs
	V1k6g9caiJJbe2L/TTd8+ti5x6k1ilOwR8I6KMdX3ELOrmA1h0mGTVCsxrzwzP0B
	2lBXtwfzF0DlAhQL0szWy3La9+ghVrSvTM9KslkD6UexLt70QK937SeOUCGfnDyZ
	jmks44SwQmg6F+mlvM6grQk49TGJexB7cNZ7+M6rmNot4tbfknenK195MQ49/2hU
	GOfH34fKzrnuTt20xt12ZuDq1YsTZBI3dR/A+meu2WITugGnc7HFUOCafS6iajAu
	hG45IXvF/TF9qtB2akScoAj3GozN88UMcDnHcTw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:NoU88poDMvf/HPRZ0LzdQ0/LJtELI8aUZgMR83H7MRg=:picxJjBZwLbpM1lcsUK68BWsjgJRgDvXppAlzs+BAuU=;
X-ME-Sender: <xms:uODtasKx-BUvPS-JLFh5XVPWq_4_Cu321-ufgPt-dHbhJUCiVlUm9Q>
    <xme:uODtajK8nkh3d_8QAJjmT25StgJNaxCzqMMg5LHLXMhpDeujtDzWXILUWn9cocN11
    6T8DufvZNx7T7FKsMN5RtPNSX32iNDgEwbzApyAKFVb6nEYovRBuHw>
X-ME-Received: <xmr:uODtahsbrdD6Y4P3RfrnsxI8kw6_k3htUZ5yndT4ea-aw90mIWmXG5FVTMeYUZ7iNfsGfQ>
X-ME-Proxy-Cause: dmFkZTFNpN21uJ5p+TIp4b9bDpxbbA22sBaS8Xpv7GMhhf6pVTPkph57rg8wJD5f1tiBN3
    M6DSob+6o0Co5fVwdDSM9ECcg82gUHgEm6KhNZ7oGlZsaLKMvgWxNvpNEmwmDetSaf04c+
    Oe4/5FIE/2cTF/yhNnHx+0NZmcBzBJHmpI76xH4eJJuRtYzfrEMOWvQzothS8Tfjn82PtA
    ejLT0eNG2tA2ZbnHK9zB8ISLqFh7PJX/U9kt6a355stT+GcfkPL2PKmA86s+BOYyLuYuPo
    ylkXf1rlikiPitn9qtbtV5hS12ZHSO4fwKzpV2QPedWR93Q4auyvljSPWVal+zoDRzNugS
    8HG1IC9g4HidTtZ4BHepvixU6+G+MCFbZbBwH7xSjwuvKoVzvIiQIMeq5EfjT/ZmLIx6kV
    WlocrTXzZvKxHiJ6pRLjU2XR4Ml8dtj+bu0+srCUwlXa3lEMBt1TZ3igwtoyAO/JZFLY8A
    d492syRVgWxS1RKo8MvKA4X1fDqtVllzt14W+vACfA6KlEpvzkmv6XrknU1qk6tHxJPjhU
    Jn6jCGxf/Ge3+BSLG77JX4Hv3Veu3xHwPBSAtq2MWHgy9Ahf261Rf2VYEiWVOjZ2ienTMR
    ga4xXacbjvZUD3rY83vbqN6BGvykrdLccadcAW/pIx995AFBydJQwj8o/JFQ
X-ME-Proxy: <xmx:uODtaoTaEqC_2ASz9k7lTJm5ztATo438QPhsrLj9usZVWbBIk3tHMg>
    <xmx:uODtavPXSq9KVzR1KSBwK3CsDrglo4lqmjL55i0S48jCFd_bpCJG9w>
    <xmx:uODtalaSfP3xstvoJsiwRXjP7xX4PrIM2XTyUlKDhdcuNczZavkRvQ>
    <xmx:uODtahymtty0qTR2m7OsE2IVDqJ4fF7di30CKR58JeCDXYQ00iXYgQ>
    <xmx:uODtar-edvtPm7VzRndKcbnGH_MmR4Bs3rVt621oEzeDr895l0XFVZhw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 09:14:15 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 95cd1108 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 14:14:14 +0000 (UTC)
Date: Fri, 6 Nov 2026 15:14:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: gitster@pobox.com, szeder.dev@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v4 5/6] log: speed up --follow following renames for
 non-linear history
Message-ID: <au3gswJZzhutGlpR@pks.im>
References: <cover.1793298331.git.vmiklos@collabora.com>
 <072d90b865c9c046f7c0dd00a265eb11bc9b48a2.1793298331.git.vmiklos@collabora.com>
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
In-Reply-To: <072d90b865c9c046f7c0dd00a265eb11bc9b48a2.1793298331.git.vmiklos@collabora.com>

On Fri, Oct 30, 2026 at 09:09:11PM +0100, Miklos Vajna wrote:
> diff --git a/log-tree.c b/log-tree.c
> index 0aa27fb210..0dc71be61e 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -1153,6 +1169,29 @@ void release_follow_pathspec_slab(struct rev_info *opt)
>  	FREE_AND_NULL(opt->follow_pathspec_slab);
>  }
>  
> +/*
> + * When the path in a merge is the same as in 'same', does the path still need
> + * renames to be followed in 'parent'? Only if the merge has the path, 'parent'
> + * doesn't have it, but its fork point with 'same' had it, e.g. 'parent'
> + * renamed the path.
> + */
> +static int follow_needs_renames(struct rev_info *opt, struct commit *parent,
> +				struct commit *same, const char *path)
> +{
> +	struct commit_list *bases = NULL, *base;
> +	int ret = 0;
> +
> +	if (commit_has_path(opt, parent, path) ||
> +	    !commit_has_path(opt, same, path))
> +		return 0;
> +	if (repo_get_merge_bases(opt->diffopt.repo, parent, same, &bases) < 0)
> +		exit(128);
> +	for (base = bases; base && !ret; base = base->next)
> +		ret = commit_has_path(opt, base->item, path);
> +	commit_list_free(bases);
> +	return ret;
> +}

With unrelated histories this would return no bases at all, and hence
we'd always return 0 in such a case. But 304812ed33d (log: improve
--follow following renames for non-linear history, 2026-06-22)
explicitly mentioned the use case of sub-tree merges of unrelated
histories, so isn't this a regression?

Patrick
