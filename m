Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562647;
	b=UeODAsI/jg2B+EenJ0R39bilIpJfKkwRZOG4RZDmIWgcrUZEsWdqDdEmSPYQ8/PzIG6g
	 Jp4H58g7w1oRrkFk6I05TN5qKyUTE/0Ku5kJev0Xu2eqyQrvxb+GkIspamEULSUFYBc07
	 aJrc3YQDKeHPuAdc0E6RmNanclmKJeRv+d5so+QifKeoS9BgqgtndEkWPTrjWPfWXOhXO
	 iVPvohIn6WEjgTwdq6S3O0eq9BPSxzN/+vAZlb5H6WTwwqnyChzyzlctsFUdskr/AG90/
	 aruGYfqR/6ECxLyDox4U496H9Gr6q/MNmRYUm/yiU+A6PWmp1vRgIgziOVEmbk/nP7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562647;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=UiGpe3zNaLguQNbAs9r0cvE65mwzLFee36+8dUs3mog=;
	b=2ecrp9Jro21Wd5HcbcVFq2dPOpiS576+NJauIRHFxsNDgBk4gsSL8ErMY8asGxdWxD+z
	 kLlNm9uGFVHTLoLmR72H26d4y5gzqcvN/HNaxHsviikPDcurMuR2itxBbe+kcf7STi9SH
	 U13JUVlo42c4c3Nj6OpkN2GoOAeqFGAw1uN3qRmGcGsSo1Dz1dulNq54CTF352plOgM7h
	 g34je7IThSl6exwFJbzJo7igjLyOT4ifx0OXXPFmViLvcj9x+Ff9b4HxFA6eMKLE/2LwS
	 QojzFylGybLggkhuz6nzwBddgO0rEZ1xuX31UHaFG6DSmAfIhxJTURZVu7SsC6mom5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=k3Y5HE03;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=46NE1adM;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62ED606A69E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 23:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B62ED606A69E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=k3Y5HE03;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=46NE1adM
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB0081400327
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 18:24:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 24 Nov 2026 18:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795562644; x=1795649044; bh=UiGpe3zNaL
	guQNbAs9r0cvE65mwzLFee36+8dUs3mog=; b=k3Y5HE03AOZcHGrkRHIbqFg8p+
	K7oxyvuKvwLsOQaEaTJOb9sOJ8/Ns8x71xoaMRikpJeBdH0rljYNspd9vytuqfq4
	nda03UPfzyQtOKqBDlpcHqjz2RRzY494jGX1Q6buQNQt/nVMyaK9i1z/H1t5nCGG
	+pYysitOpdJxZOPkoBUJmxoZclwSofZcC9ECB+sCrco/CL6srsSQFkZValPRmAOm
	D4muSzWKD9pbqV6A07AFaDA3TaqWSuzLW3f6vFrF6PqLcUXrJ5R8JwqYyWHBg6/H
	KJXysOA0iOVTPo1IdfhE5mAht1DpRW5PA8pWaDfsHat01sFgLi2KmZhvCUcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795562644; x=1795649044; bh=UiGpe3zNaLguQNbAs9r0cvE65mwzLFee36+
	8dUs3mog=; b=46NE1adM1AKGpvJ/dKjTdGsiykxODprV/a5iUAaDdIvV2OlIEQ2
	YZ4CfRb0nYwHazhfLqpJdhlURzRLIlICmJzzgxA1vdL43MfVZyKnYDs5aK+kyrcV
	jG8Q6rCk4b89NhqTkS1e9lWCtdaAiV6Y1psH53cX4Z/OaDDTD23HAqzHswbpxTHS
	JMdJjAWeDH5v5DTLyxRoxhlnAvavdY1vQ9SMUD4CHWAaueIC6AllLHppDx/W50OZ
	K0dK0fkOV51Kq1isYmERv1WZCcxsneADG/oK5aZjVU4EC6Kuqp446AZLtNRNR69m
	DIpK0ARfhKlg0oDLdB3i9jf2qdnachYaCoQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795562644; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CmoL9NZd+exAUWDpmgZnkVHOIyuhQaC3wqriNkYwkXv0dmD
	WF3peJUrwYJ/dgWSHKxUcu2pm0Qn3NJAeu4vu9camFMiKVA8I80zN5Io9l/tq9++
	zimjjH1WkR5byia/Ul0cfmFZtOYaa0QMOHaU8EOAe9b5SoLh8277CCrqoA3sFFey
	Pstc+BZ7byUbNYVtiep7f1W/q41U323DTT21W3rUGI872pbIU5lh6qL5NUxm0zdQ
	SL086JB7oUEqiAD7/tfv7YaofN6WUEHMJa8ZckY9gpXO+t8bkuDd2ieTYA/+AjHU
	ijdBtLkWK1+Ne1POdZ0RQ7zpO5lctZ3C+8L9A9w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:HDJoULeJW4DK7m29t3+cegZf4YFOpnOvOS4/N0cfdpg=:zGnMSnvaIX/EsE6lkipCic8sOdb3LfRC36BpVmGq704=;
X-ME-Sender: <xms:lBwGa4Eir7Iq3bZi8H9dOwn4SWaYiCd8Nm52kHW6bhqyljjSCYwwbA>
    <xme:lBwGa4yOT8y6K2sqh_vckqwmu2zmr6SwdtcIfvbAwdU7OOe_OxifJ1XFLMOS1k6V0
    WrLEHxz9MnKLzkYhX8SR6HyA2gfkG8g7UXMQX90_d94or-1J0ZGYco>
X-ME-Received: <xmr:lBwGa_iBf30mtOfz8EvuKIzOq8GhPn0FrUrpRq6QQbB51TjbVWeUSwILH8n-bRLmjnjDSSRdkUlHaY7x-cfQureb2BF0H887TbFDaxo>
X-ME-Proxy-Cause: dmFkZTGK005lPYiw+OT5OMhdia0TGEOwagd5nIl0/u4QzBX3ORUKAX4KLIRZtMPhWrzvxG
    lWY0/L6sXS8lBNeXjgMYgT6mLrfrartZ+mBfZrnWBjr5Nox8zMCZF2qsoeQw06oC4ye6AG
    CXj2NmPwAxfR4RyXiiJWobwNYXp7cRW81TstKIpU+N5icMnzqnUO74NyKS/fFUEcNpGmYH
    hDottL31HpYlmiHNi+7mk6fddI8lDRGblNqx9VpgKgkPsgFMuE3UA3LRVEtPUVI7rz0UtK
    qv0Cq6WxeaFqilKJYcARopyCWefyAOxpjpq233UPbfIFIjo/xy76I8iVNYhSEGlVFuAuBm
    l6kuAhtURbex5OlUCx2vh+CHBOBKKJOewuS/Uoenl9ULu6T97YIp/dWhP8eDxFP+fw8sWY
    PhrZD1Mu3QlzTsTaLdxF9dyo2LyH8PD69VKO9L747mR+FHc03+iY3rDhVzqUT8ANSFPAyG
    Cn8vULpDxPSBGUXBDC/jxsyiS/xXrVtSiCeJm0+1W0iB1LNwo4KAad/X+bP/hThhCuTCiH
    r7DGJdTtLyRTnc3resttSC10vlzOeFSgVTBLSFytmEZa+UG6j1VZoUzgjLbOt5ngjereo3
    l1mos7R8snq4usoGzaGgca17ey4bVj8xmfUgn1G1doZknyRC2Yy6sGLCjoZg
X-ME-Proxy: <xmx:lBwGazyqecf8wqsrnKgdneZBgymyoi1I1L21gbyMSLx7O2t16sOw0Q>
    <xmx:lBwGayLfcJ_B9h7hsDEn0liYspghnW_OsLKeZ-z2jtfheviSGBWBog>
    <xmx:lBwGa6QOcYXUE8upchApdzQ5S5X7mGxvxh-FwXs6jTp8I1cplRtIzw>
    <xmx:lBwGa6qdTYm5GNBeC4CcQmXXVKwlWkQqMexI5dBjWnxKQbbPXtRDug>
    <xmx:lBwGa44yET_Dr8oc2ubLAKUoxeLW948Yr9E8NkTsawMfeSscbTwPxrZ->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 18:24:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] packfile: maintain process-wide limits globally
In-Reply-To: <20261120-pks-packfile-global-statistics-v1-5-19beb83b145f@pks.im>
	(Patrick Steinhardt's message of "Fri, 20 Nov 2026 13:02:32 +0100")
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
	<20261120-pks-packfile-global-statistics-v1-5-19beb83b145f@pks.im>
Date: Tue, 24 Nov 2026 15:24:02 -0800
Message-ID: <xmqqmrqxizjh.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> Our packfile subsystem has two limits that are supposed to apply
> globally across all open packfiles:
>
>   - `pack_max_fds` is the maximum number of open file descriptors for
>     packfiles. When we exceed that limit, we close least-recently-used
>     packs until we're below it again.
>
>   - "core.packedGitLimit" is the maximum number of packfile data that
>     may be mapped into memory. When we exceed that limit, we close the
>     least-recently-used windows into our packfiles.

I somehow find "maximum number of packfile data" a bit awkward, as
"data" is not something I would count "1 datum, 2 data, ...".  Are we
talking about the number of packfiles?  No.  Perhaps "maximum amount
of" (or "maximum number of bytes of", but that is a mouthful)?

> Introduce a global list of all packfiles. This list is completely
> independent of the owning repository or object database, and it is
> agnostic of the actual object database backend that's in use. Use it to
> maintain the above two limits.

Hmph.  On one hand we are talking about flexible object store that may
not even have the concept of "packfile", yet here we assume no matter
what kind of pluggable object store is in use, there is some concept of
"packfile" that occupies a large portion of the address space and may
need to be evicted to reduce address space pressure.

I smell some impedance mismatch but I cannot think of a way to rectify
it.

> diff --git a/packfile.c b/packfile.c
> index 077b0395a79..0d5647c74c8 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -35,6 +35,7 @@ char *odb_pack_name(struct repository *r, struct strbuf *buf,
>  	return buf->buf;
>  }
>  
> +static struct packfile_list all_packfiles;
>  static unsigned int pack_used_ctr;
>  static unsigned int pack_open_fds;
>  static unsigned int pack_max_fds;
> @@ -195,6 +196,7 @@ static struct packed_git *packfile_new(struct repository *r, int extra)
>  	memset(p, 0, sizeof(*p));
>  	p->pack_fd = -1;
>  	p->repo = r;
> +	packfile_list_append(&all_packfiles, p, 1);
>  	return p;
>  }
>  

Tracking all packs allocated via packfile_new() in a global list and
removing them in packfile_free() cleanly solves both the cross-repo
limit problem and the unconditional odb_source_files_downcast() calls in
unuse_one_window() and close_one_pack().

> -static int close_one_pack(struct repository *r)
> +static int close_one_pack(void)

Yay.  With this signature alone, it is crystal clear that we pick a pack
regardless of which repository it is being used in ;-).

> @@ -754,6 +750,7 @@ struct packed_git *packfile_from_idx(struct repository *r, const char *path,
>  
>  void packfile_free(struct packed_git *p)
>  {
> +	packfile_list_remove(&all_packfiles, p);
>  	packfile_close(p);
>  	free(p);
>  }


Every pack allocated via packfile_new() (through packfile_from_idx() or
parse_pack_index()) is now freed through packfile_free(), so
all_packfiles should not retain dangling pointers.

Nicely done.

