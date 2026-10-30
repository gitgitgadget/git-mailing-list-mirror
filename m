Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388341;
	b=Xy8e1DvIhQKMZ5dYtigbZ2YTCXv4XEo+/40pJcwZpqGYvMPFapaAuxLbSCuA0U3/zaih
	 u5MlAaEcZbDWfUkVfjiexRsjBkv045glVNDyfe/xhNOyNRlbn7ttPp3Q3My6ez2joBGHZ
	 JwjIG5lM7FlWgqwVlAXGmvCX78y84BNeWZC5IbviwxxHkpO33D3Q4LFjdSsk6eZGospl3
	 ENgMpOQIq1NfzgRM6aiOMknwvLFC9uJtdns0PFPqfA9dcVBQ4N5BYXEgx8QpVVisJtpnb
	 UukgROe+3ofHoMeMkd8+G3PpD95Pzx+c6WjjpOOsDF0NTQU1A0teDcG8GS/677xZVgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388341;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=GnsaVO5TshN1NOdNu40Ktf4EtP1w1KGTHtRuGnhqSeI=;
	b=gFjr3C3KiAFq4RS4+pgnramrambBTse3aj4iS6JHJi8JVmGD2gcDfIFsIaVcl/ALSVPg
	 JYq6+Q7XaKavOxN0CPFzlfEbURBRi2NqlTj+A5PSdObYPbvxgBGDn7Yt+USARVU+CJ9ef
	 Xrwl7m58W8pn5juPFl6l4cFHR2xPLaWi0x7xl41f9eftOYVc+qfioI/+QXzTJak6FvQur
	 /mCysiiHZpddVz6GOFzL8G4Ah0MECZZh6Hw5e18ncWfnRtUMyIZU8A0q+dlLXYQt2mjP8
	 vQkBAjp7PvoEBSZWe77qBGn/vzxF9BUUjmdFqclMRTSafgBzXqAhgWdH1Nn6S3Mn8sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=j2wIFdHJ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=AZxl+QZZ;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0BD606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 19:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED0BD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=j2wIFdHJ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=AZxl+QZZ
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3E58F14001E2
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 15:25:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 30 Oct 2026 15:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793388340; x=1793474740; bh=GnsaVO5Tsh
	N1NOdNu40Ktf4EtP1w1KGTHtRuGnhqSeI=; b=j2wIFdHJoURQyrXJxcOM3m/oZq
	3HQwxjqfXdYTBgZ22QB8fPc/R1n3flK+VD1DC04kgEaVT4oDlTruZS63zD/stjAa
	8uHaT+fVbt4a9BM10ImnmH2scU0caUz/zVCTNFQeH8FQi7akAHYyFZ+l4nZymvC/
	kbkiJaP9JNeXFzp2E0h3I3izZjT2BmY7u2r0Wzl2qQmqpluNtcpdu5ppQRt1rOP5
	hh8ToKJrYPd0VMzJ53n2dOnbLf3yQOMSc+uaHBSI1Hb8trl/Q4BP+eMsGgVFAn3O
	K+znukjyduDImZDVZMQHHR1wxSWHw1N7o16Z8xRF633Et0Cnv6FRtIryhGVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793388340; x=1793474740; bh=GnsaVO5TshN1NOdNu40Ktf4EtP1w1KGTHtR
	uGnhqSeI=; b=AZxl+QZZgnGdnNu9e0YIcnG0c8ZIK7cc9A8ywt5NZXS/Z8UuJDm
	GJKiqkXRrBOCKoK27oI/BZLSwLikYJfCyRoem5ovLcPIxM8HeV4TwDVWhe6oUp6g
	pDHgqdCIZ3EpZkpQoGT6PnUuarmeNvViS5iFDou0kKcE86nrwi6oRbH723ech64/
	YX8zUYUGC1W7mFjVdy+or3XED/D+lmRnWJADV91YvSI74NB5vZBAhG05KsfKBc7F
	FYOxPpyfdG07x1am6T5gl9RaoO2rpQwWeTOGL0wjCrx1/w6K8D0pj78XCpmIB9dX
	cg6Z2gAy7uY1KAERN0GqNU8q9hEZ9aUrOgQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793388340; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ABBWD2bIT74pXWCYgQqTSQyI6totqmB4mdjCwr6YwT53cKz
	azVKVNcdEh8UUPLpa6f+sSKQj89RyRIQDa/VqNwEcmuoSzD2qRaqNzlENUeOohHb
	qlASWpuecm4652IvSibHMAO3wpgqIMdaeU9ZyN+NG12jutcNieQ3kMQG++txF5q1
	A3vm/00n/jhGHKwVlMKSkmI0+kh5ji6FAFNnhr+LmINWqQZyjpoJ6I0X8ntq8hie
	LT41gKo3dzMCFtIvLBII4nEZ4PlMVQnZ3/Bl/tobhsfMavnGzUfd6D4JwQYQuYFC
	m+L3rHUb1cyRLW35hS7Ek/NiHyzQQ6u6V9xN8YA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:iZ5sF7J7v92YYxJTaM+h+CM3WjcPUrRC102nMz/gMbw=:IzcnjrNeu0o5ZxjcCIrPBydvTygmAtJJLWi9ZdCi+YE=;
X-ME-Sender: <xms:NO_kaqnmLdliJYNLQa_3hCEkAN2gqeOybpnoVJoAp-lsbkjB_JFuIg>
    <xme:NO_kag4H_HWNHZjDJO43IPnVFR4E3XmaplrhVj1m96UsJQSphSzo7B2cufQH1SLY4
    YwNc4AJfn8Bt6Un-UT5wT7-Vp9nbgBX--qQA1JN5E4ZTx3GOU8TtF0>
X-ME-Received: <xmr:NO_kau1SGuP3nAVCvcHCNOEohIHDYH6ASMqRjsnap5WldrRVzcWH0XpL7QnQmLM40vmj87r_NaDvofJDh_hRheyt6NT1JmYSjgUJ>
X-ME-Proxy-Cause: dmFkZTE2YOXMH+hlNd6wvSX+oePCYllnEHW1MPgSbL2FbnS6WWpm+EdYRXA8PHL6EH/CB3
    aClPvU37y0CcOLFgyLgIqcOPtoypkqd5aNiB/nKdWoLmOttY2CXasHxYqkhyzl7zHINqgO
    TwmWKPedORX98U3G4aLAixic+Z6pJYj0j42rqnp5YNfFaVbxEAKcXYMxC6gJvvoccuySOr
    l3Z5PqMkxVlxk9nFo3MeX+sCXYbCi7H0s9MwoMVRBt7iod61Nog0Y9eAGSckKFB1Ef4bxe
    WITQXmpG8xC50/Bht8yqpEzsERbsXDmHeuGsJic0hZ4KkimgMFHdYnrwNvUi9mjV74Oosk
    hKux00X6coTVU8oYJKRxaGUJQza7sfhr9BPgBGahRR1Eh34rOucdBNWYgL3+TTJScp8BtD
    sVKOQlZHi/FMRUWjNN8Q/8vR5O5wGsV2o5PY5wbvFEPOGkQfWgLK/TQ1YF7joPZCdD5wEw
    s26jJRSE4xZccL6pem48yF0NJCtC2SirlMnNXd2WBVqNjARkXwaTckePCj+JRJAMcz3ym4
    g5vOTw/kAS2VqKWtXlva6cNAeImXPjgYRF3CxbkLekY5srYQTM03tr3dn1bo0YEU/sqo4P
    Wjivx/wf96Rz2zQPs+aRc6LIm4SN/rZSKLmHz5pYSsp/QBhvCe2Sdm0L1rWg
X-ME-Proxy: <xmx:NO_karFaG8YOSqTFO6r-OAjorlT3y3h_W05cu0dTJiLGRkzXH1n20Q>
    <xmx:NO_katgxiy7h5hvj9ySD6xWCvx-DxBu63JWMy5VoaGm_OcZe75CbvQ>
    <xmx:NO_kauBG5AM5FfWtueJwPwvQ21apOXLVu2mCQOKyeMcJd4d-egUHkw>
    <xmx:NO_kavS9ItkfwMNchImfuFXkyD0PCwwFYf_mdaaQdPC1O8NYYELTWg>
    <xmx:NO_kajKGtiOBsNlCZ3OHdRBu9OczI66XUc00kf8_AmAPVi7eUU7Ww7Uu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 15:25:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,  Jasper
 Mayone <me@jaspermayone.com>,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v5 4/4] branch: let --delete-integrated find branches
 merged onto changed files
In-Reply-To: <9443055242b8968e7196530bc67614d5b43d1a45.1793357582.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 30 Oct 2026
	10:53:02 +0000")
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v5.git.git.1793357582.gitgitgadget@gmail.com>
	<9443055242b8968e7196530bc67614d5b43d1a45.1793357582.git.gitgitgadget@gmail.com>
Date: Fri, 30 Oct 2026 12:25:38 -0700
Message-ID: <xmqqwlqzuh1p.fsf@gitster.g>
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
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int merge_keeps_upstream(const struct branch_change *change)
> +{
> +	mmfile_t base, upstream, branch;
> +	mmfile_t result = { 0 };
> +	int ret;
> +
> +	read_mmblob(&base, the_repository->objects, &change->base_oid);
> +	read_mmblob(&upstream, the_repository->objects, &change->upstream_oid);
> +	read_mmblob(&branch, the_repository->objects, &change->branch_oid);
> +	ret = ll_merge(&result, change->path, &base, "base",
> +		       &upstream, "upstream", &branch, "branch",
> +		       the_repository->index, NULL) == LL_MERGE_OK &&
> +	      result.size == upstream.size &&
> +	      !memcmp(result.ptr, upstream.ptr, upstream.size);
> +
> +	free(base.ptr);
> +	free(upstream.ptr);
> +	free(branch.ptr);
> +	free(result.ptr);
> +	return ret;
> +}

The function calls ll_merge() and passes the istate associated with
the_repository global, but have we read the index before the control
reaches this point?  ll_merge() would want to consult custom low
level merge from the attribute subsystem, and with istate that is
not populated, it would fail to learn what the in-index attributes
say, no?

If there is a reason why we want to ignore the attributes, perhaps
we should explicitly say so.
