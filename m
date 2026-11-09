Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239104;
	b=fUR31dw9a6JOKbf2wGmJBroi89xNOHdofb2cHFmIwzMT/5f1kZD3jPFM8HaSPlzynSKY
	 TXZ7qPP3P2C4QYFVKx79dMVWDFtJs2gh03hmpWLVvRVBcsa7RGu4TdgEgQ05qkh7XFTsU
	 Pxp4WD4vnQuqGI6LIHez0+GQvZIWHyK5hFvDklAn8Krg9m/0olm+6dpHH/xTMue8Z4LMH
	 lpz1t3XMDx4jopjFPXKk6BeZMSXwL1pvkkCOGccawCAN23q1BGdpnNkuoWcrOWvtTI2nw
	 oxSj3QaPL30grLkjssLfTpO3wGel1yexjl7+bUOvjYuIYtG1Pmu4Ku0xoqmMgfE6eSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239104;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=KdT6KLP76NdiuedBHlavzp60+jzdvM/FtwWLtT998b8=;
	b=V/s6kmtyn59busTekzxOQP0brIaqrgIg1jGZe2p6e01kGO1pW+k8BUxStDXkhkeup0tP
	 pwTNgt5RL44vyleJ+EffdQmqoTsn739Vm3bRuM8HtigmpmONXfv5qcHW4S6Z6QAcgGElv
	 lxDfaYm7EIaT8N1AHiMd5eqBdKm2kc56vlV6ffZ8hoDr4gY8qvH0fvzSc3Kn59mzALJVq
	 zUQYSKgIiUFvKXST5ZAHwhcuhE5Dw2Ka1neOieKorqoa98oFaD9P2JoS3y/9sg8u6oy4G
	 /cyWqTtPqZ5erIeFmgATMLgRk0Uer9mAdALT47FIKaZkW2n0cNbj3v4176iJHKeZZ4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=iUNW5pai;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="VB/qKI5A";
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F628606A333
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F628606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=iUNW5pai;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=VB/qKI5A
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 59B93140018A
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 10:45:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 09 Nov 2026 10:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794239103; x=1794325503; bh=KdT6KLP76N
	diuedBHlavzp60+jzdvM/FtwWLtT998b8=; b=iUNW5paitwm9HJcrGsK/2L6xIE
	SEY9WIrFBVT201h6mslzGKUgptBb4T56oKbFfpAdak/DYCR1iu4PI6GQYOe41s40
	H/mooUxbvdsM+dtb6KyEcVNU6bXNqSzMon1tELf/rRf6M/vp0GZCboJTEL+M0hNF
	+vZ/FYYiI0wpr6ZycvnCpsccS9e2gql/15qxNZjIG+kgERnatTeHWhW1uM2ZQ0WJ
	0CWW2sOZexIWpYC0yPH7aap56rhtaPeFPth/5lSX1XVC79B8GEPHYxDL5CRzDbd1
	03X+5BMiUIUO3qbE6b2oBocUTAQ3swvq3eIPhz31cto9e5nRkiUsfP1vI+rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794239103; x=1794325503; bh=KdT6KLP76NdiuedBHlavzp60+jzdvM/FtwW
	LtT998b8=; b=VB/qKI5AtJZWFdeQATWF9hxXKUjTlqV0KWYZikMm1jcWYLstZv4
	LZhCM3RIl+LVSxnqEYwU3kZE3iQGWMNXn9Kfi27jw+B4b/buQ5f4OnsRvqcYRiPi
	ptNvd4wnIEipDru05M2VZzpvorqeXLF6JoRK7WVZDlNCstLNpx/mrlGb2PEFnULs
	F7Kqacztb/Ti+eR6DzCMa44X21qUnF9W4kKuDJGTVV+isnbiLHHLeGJHU0lWJLW7
	TxLCwGcEmAYufk6LJ7HNEwtRScskZN5jVghg8OINI0RbJcIkPBBkSDzc8675SRVZ
	PlqawcbPwCCdh6ESN74CUd5ujJaaD0MyVtQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794239103; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:MIwkN/UGsJAdBbTwqSh1X0jErKTlpM+3kAYPpy7bZSNADM9
	1lzLdnMsVXkHLI4PwLryfkyEZSTmMx2TXmftdn9xqDlLN7u4cCdvDfX++p0Zv4LK
	4YyTR/5bBaJnvxiCT6qNcIE/ulc9Yg/xoYY8D1ZLRwDgAko2TDB8WOPt/BfV8Bcz
	IJyVx+9eqC5TpRigIB75ukBUxaZAC3pqkbJiIpGyYPmi9W9pA+tmITCRGXQkn6o4
	3RTEHPeRUS7Ri/lTGDURVqn54ntV/5A9UoXDoemuecpFtDIhl1GajLJNcmgNYOHY
	jAFIRDePza0QRtCvY9c1xCZ04P3yZYH+WmEruGg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:b7gZTC9PlSnzy87MmXrO3syz+r3/ddCVm1KtsoVZmdw=:KdT6KLP76NdiuedBHlavzp60+jzdvM/FtwWLtT998b8=;
X-ME-Sender: <xms:f-rxak3SwRvW144hUhgq0hFz68LAViUQd-rArCrcBtLLzAPsjbjbVg>
    <xme:f-rxamF5ovwTt76boXCD41FfnZu1LM5J153ZzC-562B63RGy_EAixUCaUYx9X_PuT
    JFB4G9JXDtktOosHudsjbl2GPM3EJvUGa2ltyLMJWXp9w6jt_RKRA>
X-ME-Received: <xmr:f-rxah7ikPut_C-UF3tv6aS46DY1h4FFRoCrUZrVVy3RyR4PaW9qP_r9FAgWirZ3fQlY_FVLNDtU6OPjy3yMNE6yL381l5PH-_TD>
X-ME-Proxy-Cause: dmFkZTGCE33ZXE+SH1cKqCbhSyfY3C6jN4o1artpT2fZcHG/FjHSKePRqZGt8pGxf+GivJ
    Z22GsKag1hcw8hah1rPEBwLxnLKFluvY/yCjxsrQFzhr13YO0rgGV3J4S2qSpAjALNrn2Y
    tklOWkv69QbSJNRjCgy8FdL5WzxxOLscE475u68+3m49msQnyJOME9sR+mOPXpJp8a6bus
    LrkBIktRPUNCwzHRgomBgWSegsYcAY/WrSWIjQ9lVc0yaKE2t9XHa9JjTxXflgL6JTfP5W
    PXFgE+JvdypjMgx2A2uIbTiWeVJOBymZa0EsD1dTEa6KZWDeO+zzcdpQcdOnpKYkwIBXIn
    gJJAj5TphUL8AGJBpzc1ID/AgJp9FdcSuZ8mzeuUbqwQJEuHyCRmzohatHgwoX0T3aPIYI
    o6nLpnfp5uKoiOJOqHfIRCtpKMQDQNhBurreygbCvkc+qsxvmDmbvU8hzOdu4/lNiyQmoh
    3f8E5o1JoYJgcYA8rqDmMM9Bdbke1pRypVVqi3jWszbRLsWyB+lVvNkvU8ilVqxyGKp4gm
    4OGUdw/49aa5rhMvnhDlzqaScM4mI4u/EMlyPNIEE6bNrPZqrBNL/WTvf3xuaQnsZMZbYO
    aefP49m6gps9hHnrHLqBZ5PK9PMv0UjJmuQdcrrSmdUP7kFbqnLs3dGkm+MA
X-ME-Proxy: <xmx:f-rxastIn5g9JlpYY7vbriVo_-lESAq4DvdQgDMA0wgpDOeo5D80jA>
    <xmx:f-rxai6Wnen7qiDDwykxw4bevVo2YY7CcgKE4USw7Dz8-AWPE0WrxQ>
    <xmx:f-rxanWTBLIerzqO5JfsD6TDUW9hbyevu-A_R4TLSaea18vsCik4ow>
    <xmx:f-rxak_6NNaTiCuE0rqeIJCt4BIYlicG_qX_wysCbJV9zRJjSsw3zw>
    <xmx:f-rxataZem6U2JWY-dg_h0dlITKrRaLcHZsE6oOB-umszgJklXCn7ez1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 10:45:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com
Subject: Re: [PATCH v2] doc: describe promisor remote fetch order
In-Reply-To: <20261108192232.681-1-husainsitamuwala21@gmail.com> (Hussain
	Sitamouwala's message of "Sun, 8 Nov 2026 19:22:32 +0000")
References: <xmqqo6bz2kxd.fsf@gitster.g>
	<20261108192232.681-1-husainsitamuwala21@gmail.com>
Date: Mon, 09 Nov 2026 07:45:01 -0800
Message-ID: <xmqqcxse101u.fsf@gitster.g>
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

Hussain Sitamouwala <husainsitamuwala21@gmail.com> writes:

> Hi Junio,
>
> Thanks for the review.
>
>> I think the entire sentence after "If a fetch from a remote fails"
>> should be removed.
>
> You are right. The fallback is already implied by "tried one after
> the other", so the sentence adds nothing. I will remove it from the
> documentation and also drop the matching clause from the commit
> message.

Was that extra "not wrong per-se but totally unnecessary without
adding any new information" sentence added by LLM by any chance?
Just being curious.

Thanks.
