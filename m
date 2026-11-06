Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962924;
	b=XclPFGnyJCWZOalCvJtArZmtHq9OOuGY87Z4qA/cYQb/T8pYwEEg9yT24LYQazgzO3ts
	 XRPs0y8Pjl4hf1skO+lHMHSGM5hbBqNvWtiwEgzlVAMMeTZaNwrm+Px5mxy8JyW1s3FRl
	 YZaNZSjP/bMecYrjztPkkqUvpZZotu53iMydh/cWUkVYbOOOCGV47o7cCF/EOmHAgcnZP
	 6DEXpGmDiGjb1Bgu9lasNl4Z6vfTMLyYKzGz+d2b9fX3OGR9ljj8+Jj2eR4Sfre7gIpLP
	 +9vaNoOJgShbJHon+ZSysY6dgKT+J3yvRdsrA5unlM2CQq9kvcPHL+bnMvcUqXbBbdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962924;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9nfLv4WSrugeFJMP6QVRXJJKlETKOvBJD7tTxpm0dWo=;
	b=TY85+IMswym+HmocaA70xSj6dsrwIlhUa/B+UOvhJMfyp/8sAAdJA74s8SakLyIaMiNE
	 Vzetc8qa4nlP/ftjMVTjwEY97nxXSaUdVjEOQy38XUUUShqqrMU+AVWWeTDi2jqIs6FqJ
	 1DyYsGRsce0lUi78XAd9OTARQ2nEambJAUCAGNt+g1R3R2HanFJjitIdU+lnntN6xXxjV
	 U8hvqonIk0m6GLuBJUqTB/rms7SeuauBuACutvu7fHlWm1maCZ6Ei0uEffmga0z/Bed8a
	 Zw80oMT2bT7thX50SpA5GTVSBOP2M0Z8uXvQypNh39cEwubyI/dzG+XmVlzPtRgHjkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=rXSlcYKN;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=VtByCUvb;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03806606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 11:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03806606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=rXSlcYKN;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=VtByCUvb
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3D97FEC01E2
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 06:02:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 06 Nov 2026 06:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793962923; x=1794049323; bh=9nfLv4WSru
	geFJMP6QVRXJJKlETKOvBJD7tTxpm0dWo=; b=rXSlcYKNRmpOuEbY4YsNYTwZzk
	O+URsd+H2tkcs+exqp57LmbnjIEpbH0jsbSyDDPTDIRUXgYkmHf3yd6ED8mCs9xu
	u75s+WaIX2wf4WUWxxH7PZN1UDPHMqA5tJpI9HWKNnLuQAhpjN2TZTwZT/91jMc6
	8qRYdq5w61pidSIf6JDevIt1LLXrinszRCB3RwTIYn4SMRBixLywAreo5MUgKPzk
	I4rT6mRvbEXak+i5ZuYA+7oLQfVWaEp2ymK/nmcd/IfjBDJmV4PMkRuVQZGfCL7U
	JsYNV/39j/qQUazdPtcj6bhtsIGNTVr4mNWnfou5fX0O2c0WD8WkAZwJUA2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793962923; x=1794049323; bh=9nfLv4WSrugeFJMP6QVRXJJKlETKOvBJD7t
	Txpm0dWo=; b=VtByCUvbYYmHRDJKtX0j46TJZmhZf0et4TJvqUGUOYcUJC3Qz73
	4dAXjQTZy/vOBzQWKjKnwDbpLZhtSUqVNmGjMZGzme06K4ofokQXz6yok+clkAsG
	L/BWuZNnGB+dSu8PBOH2HLxEZRYZfcIGweUZVfDbleuPUVfKECAxz3XMNJKGuuZG
	X5bpyI3KERS/osmXIKvmlIU3+JnmftoYk1Of5pZJhMFaTlon+e/n0douA1rMqeZ8
	DPDv9AaDmgm1jVFe8NgZ6W0tUV/YXBPKANlA2sl0/P+Y6Ki+OStK2Of4VZZwhzOj
	N8LKGd38T0nIjdHFHKyHZy5Y9sP78Saac1g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793962923; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:dlzJHBLAx63O1V0bVE77imEol5eJzWVhHkhYOlyRfjK8Jd2
	jlfK+Lg6wkSLceceXwSDW4oBg+Mqy72j3/U3dh735vRefBxTt3RnbGxuFUH4Zkmn
	Ptds6ETPGLMmf4R3eX/Xq+KlpPtkIZNK0BY1rqSveMY7w7pAm0Lm59NmuEamadAx
	OTELkKJmdsciqACJ+1X+B7mIX+Ob/leA5+BE5hMOZfJjBCSRIY3+ieOL4Jsv+FBX
	SMrVwfd9Bphp/Y+kunNcucUEVcU0Rcx9U5eSpsyuDNaZAdvVm9lLrjJK1ejB+AKb
	XzFxnu8DXRiNYEw5GWFL3XZ2GIl2TcdzZQPgiBA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Q7eIRWwpcS8YSPB2gmwnLX1K4rwW2xb7qiu5T9t3dKU=:FS2w6gXl36RPvcZCI21T7HRo66z4zneV93WbR7KqsAI=;
X-ME-Sender: <xms:q7Ptao14eGEMI5rO0NJ1T-uXi7mkApWvpPP8WWaWG6i_uTBcfGtHPw>
    <xme:q7PtapGhKf28a2OH2fo5Z9wtj6BnEkta0YZScX2X8GWzh94hdNAmE7cX5PqJ-_Otr
    LauRfge-lBbXUEBVS8oUoxxS-dqloFLxPqlEadjIhOJe8CPcDgZCfc>
X-ME-Received: <xmr:q7PtaugG1xWGccUBZ_e-4TtvyO12pz_RRjIiOkjn9BK2HyoNvtUSjXjTU1EWgdK_WL6Jcw>
X-ME-Proxy-Cause: dmFkZTFzP3lotl4Mnh5pWvdya6/jJvrKniWq0mIzgjkieV55e38rSCWaUq8Beq3zhCbtkk
    umsZ707PF8b1kDhgi39pqY/VKb4TKtWgZWwYLEIBiawxUSX9foUdTnMOhnisP9MHQl1DUQ
    jJee4CztgQb3GnpqQBp+TX49qYKFrlE+s82VBYNDPINCtVAc1Y38ED0PSCor2DlzxgvJLe
    1sXvWlF1rfpn0lIcpOPd6MGuv2RBlpoxtlGdMrYyoJzfdS4guSJ+aEjatrkYEHbO28HklH
    FnWPnVrE8zH1vJcxgTVanOQIPPSqGrAXId3OB4y7egpDCrArvyhJTjokpjmaMP+fISSgI7
    Pq77mnGWdbZM1zpMdgSWEf4srXAvlo1PJSEAYbNj7gC/EHFzFlRyiHvtLC+7YGFA4rXiqi
    RI95D/Aboo4Y1MRamZJJBnjH/ID2qHuGEWxigARrGadTkqTjatnc9hwwvtVRXBZ71KFU9v
    qsLFxt5I9aZflIJ9yJOiU8iVgnR3DgIysDiBeffGEithUZpnThvWQxgVETJmbfRIF9ZUlE
    heaTvDMQAWdgTGhRBG08qrMm63nc/qw7MEWBw0mh9WDPhdvNyuLDr+vbHS2NvIFKZ5adUc
    +TPDYuV6ZQV80/zB8lTScLzVTYW854VjYEWDhT0hCIYP0o4QeIq4lBNfQfGg
X-ME-Proxy: <xmx:q7Ptas-pfDJcpqa93oRaaRg4wwbNDqZdizH_y2732B3Bx6as-LZ3dw>
    <xmx:q7PtatrEPnb-MdYZUG1JxXwbHOg5s9DgAy24oA6az-ajc26C1fwpig>
    <xmx:q7Ptaj-YJeC5ABKbBQKPmPq476tc-7PybGz1tUB_4VLRPh-egL1P4A>
    <xmx:q7PtapUfcw5hv1cvxTdiBMsg75f7e8mGYBzyPvWfK8XbvXp2fN7Y-A>
    <xmx:q7Ptall0b7h9xoQYF0QAFbA9tD6fpCjn3COAzxDR5gDvtLi3utfDBZs_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 06:02:02 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 013ba268 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 11:02:01 +0000 (UTC)
Date: Fri, 6 Nov 2026 12:01:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] refs: create leading directories
Message-ID: <au2zpr5qla3VG04h@pks.im>
References: <20261105-pks-storage-format-improvements-v1-0-870bb4212518@pks.im>
 <20261105-pks-storage-format-improvements-v1-1-870bb4212518@pks.im>
 <CAOLa=ZR3jxonz2o+JKe=pyzSACwJH=uu3an141PEG1Ssq0pBWg@mail.gmail.com>
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
In-Reply-To: <CAOLa=ZR3jxonz2o+JKe=pyzSACwJH=uu3an141PEG1Ssq0pBWg@mail.gmail.com>

On Fri, Nov 06, 2026 at 02:37:23AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
> > index ee2bb66b99c..85d1e876b82 100755
> > --- a/t/t1423-ref-backend.sh
> > +++ b/t/t1423-ref-backend.sh
> > @@ -284,6 +284,30 @@ test_expect_success 'initializing repository with --ref-storage-format and paylo
> >  	test_cmp expect actual
> >  '
> >
> > +for format in files reftable
> > +do
> 
> This would run the loop for both the files and reftable CI jobs.
> 
> > +	test_expect_success "default ref storage format with $format backend and payload" '
> > +		test_when_finished "rm -rf repo refdir" &&
> > +		BACKEND="$format://$(pwd)/refdir" &&
> > +		echo "$BACKEND" >expect &&
> > +		git init --ref-storage-format="$BACKEND" repo &&
> > +		test_path_is_dir refdir &&
> > +		case "$format" in
> > +		files)
> > +			test_path_is_file refdir/HEAD &&
> > +			test_path_is_dir refdir/refs
> > +			;;
> > +		reftable)
> > +			test_path_is_dir refdir/reftable &&
> > +			test_path_is_file refdir/reftable/tables.list
> > +			;;
> > +		*)
> > +			BUG "unknown ref storage format: $format"
> > +			;;
> > +		esac
> > +	'
> > +done
> > +
> 
> Should we instead do (untested):
> 
> test_expect_success "default ref storage format with $format backend
> and payload" '
> 	test_when_finished "rm -rf repo refdir" &&
>     format="$(test_detect_ref_format)" &&
> 	BACKEND="$format://$(pwd)/refdir" &&
> 	echo "$BACKEND" >expect &&
> 	git init --ref-storage-format="$BACKEND" repo &&
> 	test_path_is_dir refdir &&
> 	case "$format" in
> 	files)
> 		test_path_is_file refdir/HEAD &&
> 		test_path_is_dir refdir/refs
> 		;;
> 	reftable)
> 		test_path_is_dir refdir/reftable &&
> 		test_path_is_file refdir/reftable/tables.list
> 		;;
> 	*)
> 		BUG "unknown ref storage format: $format"
> 		;;
> 	esac
> '
> 
> This eliminates the loop, while still testing both backends on their
> respective CI jobs.

Well, in this case the system under test is explicitly the ref storage
format itself and how it behaves together with the extension. The
GIT_TEST_DEFAULT_REF_STORAGE format on the other hand is design to
explicitly test that everything else works as-is with an alternate ref
store.

So I think it makes sense to keep this explicit test.

Patrick
