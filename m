Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814478;
	b=tsOd5WsqY0COdWa8z537HUyk1wASeeMvGqtReu1WhGyLkUatNz60tLKPvB/5LTLZMs4Y
	 xWviWKO/AZKc72SBIn39BuwXs0IVXH+gnFyWAVTh+Up4koK6MT3fSUl2IcH1KJmg6g1pk
	 biOs1YYKSHSNIxj0yLVAClesVtQiDP9GhZ2i8KvHJGWVYk2PUydeuOnCvwTtnI9qebmMW
	 XXEfhq+NqXZ2Xm1kMxj/cHaBj8hGCrJL0yPIpCHNt2MlKqXiOWxrsb3X7MohEUSW/ZOrK
	 TNXdRqX+u6DjUE/Qt08a+KFVCmGkHdORUoda+iN3sgeh+l1A3S911fzOOZXQT3Kp1Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814478;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=2jyUyyWI3woQoPrOaS9Ox5pRyBlCVD6Nc7iSG0+QlDY=;
	b=1RYiGim8Z+w3NVzLHvKj4IlHJN1+BrNTCPtefiQ5TbGWxnqwfZM1oe4e+9H0LtsulXIX
	 8GABzyIE4+UFGr2//HbH3hmkfJu0VLsm48xdBnykwc92wsqhki42wfy3eFy0FCtvI6TcV
	 070N0l0yPh2CAtnCnl7fJuynosyIODHWCY2pXyCN77T5PyxSJsNArRcMVqA4J77N1LgKZ
	 MAK+OBQRnMhU2Yfek8uyKmC1hj5ryKypiMnXVX5sMIhvbItICnPQ+uINJru5TkIHljkLs
	 hvXnilpYEP9QbvfPXW0atiMwFsbjpMt/MPHcYy64TjMsintXEQp6EFeWqTwpSlEx11w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=temperror header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=OmBlPwoR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FQmWv10e;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6BF606A328
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 17:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D6BF606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=OmBlPwoR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FQmWv10e
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C50961D00100
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 12:47:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 04 Nov 2026 12:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793814471; x=1793900871; bh=2jyUyyWI3w
	oQoPrOaS9Ox5pRyBlCVD6Nc7iSG0+QlDY=; b=OmBlPwoRrxyexK3M46px3o04Y2
	fsiFHK/Mq9Hjm/hboedWnv+KrvT3aAJEBOQdHmobQ6O/9bKh54noSfr2o7bKRI7l
	SH/H8zfW9VYqso9IQatWAAN+NjGRY5em+x1xa3bQk/eqxTAgQUkKAlaoLAxeFMf1
	g4/ofGOlaJWY/+a0HekGDw9GF18Co54vOpQCcLXzcmAQUz3gGAB7peBL4AH9fQsO
	owtxOnrwKHFiFU1XknbQ99vq79pEVPYp5vSoYnbtsGMb0JuxVW3UPk5PM5kztU8I
	zQcCj6zNEXzdMLyMnFEzyFFD0zC0hHfXe0hPTJVTjdtbB8q7Vf9e/K4Oltlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793814471; x=1793900871; bh=2jyUyyWI3woQoPrOaS9Ox5pRyBlCVD6Nc7i
	SG0+QlDY=; b=FQmWv10egSABT8/0/tRcHOY74LJF8GO5whgy8S7tbZOW6PKdM14
	m50s5jzMY6/K0/x6yK0cY9XzmH2IjWsXcapHc/TrQ2aHEasc8HxxpZ/RU0GinZoG
	JKQmMqj4gB4tHfbW/Hz8iFba9PzpQNi4iNiAISp+OdJBLP/8xxWYJ304h0guAzV/
	+XSefIgJNh3hURzfQrhAyth3E+WWt9TITRXAoPbH4TUTUDEQ6TyTMJdCmMaWAzFr
	yH2yjbSgyUPPjOidwZhhLzHs8PTj8YG4OsgWfOFXam0Pl/E9WztepW+lKLdiiQk8
	X3B1pqWiS+Scyddkb9l7hhDL5g8A5O+qfcQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793814471; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fWYl8LwXWQb1bgrgm0B4GV4hhoULJvwBAIIlTq1VHR2w7nm
	5U0Zy7/cE7OgdFqvkE1z/nbZSnNCpP6A4lAPd4gaSo1gNYFk2gg4QUNPsZ6P2to0
	51LS2m5MiwFtdPDCCE7WQgQowOjc2G8/xH8U0Z8aWcU0ouqTuv1oyZsF5Ft0vSzX
	dChev0Yjp+lU/nLJL9koYXzB8pKKKYpoWyeSWQJQla8lJTXCDa2s9V0UvVgmWi1h
	vrqEAhW0td31hB7kv8t6g6bm6JMgtXa+Hz5vJFUOIyhDAsw86GuQEit/YJwO/Kev
	yJGzGFCMcXKFeG9PzZeiIw2kFh1jM/xJk/gRdCg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:u1Ra7QNTfMBr71TX3T/L6OzwxUi6k66MKOmPgaI8qk8=:Ylr1Mio2/ZBbFwiUEh5lx1MCksqjG6IeqNlS+31raLY=;
X-ME-Sender: <xms:x2_rapv-5haw6isrKRmXquJOS69fP2KLJssR8oupFzTXWPB8Sz16Xw>
    <xme:x2_rapdqLM188XjqvY4KcYTrfS7weD77UVTxMIDQ5nlvbaDQFM4f-Atuuk7MYBqVC
    HPfOaqcArT-nGDX8i3NnB2KS4Ph01ePQ-8J98DKDsLCbTo-6D_7jGM>
X-ME-Received: <xmr:x2_rahway-bi7w-DdKkfGxr4BunaOxT5oiphPUFWpj_ngeLdnTImjI0e4ThHKJgEzSyNelgix8jkgjwnnhYOzlQtV6CwkeCkfVtj>
X-ME-Proxy-Cause: dmFkZTGz4Y7VGY+GN4Ysnq9xXYtijMlJO/Q0hIcS6ECMVvXsCv3cQ9j5jSldOdM6sDUZaK
    7QNOx/YIb96yvUVX7YBDkXS+m7YlCKjFDjPGJlstuK7wtSlQp2kV48ltmaslX7xYSv4OrQ
    EMrkTT21lhgaHeRksMHC41Zi7d41Ka8M2svr4igVC0FdCZirGSeWti0kxzfF2O7Y5pci5C
    0IywSr3z02lk5oKQobgbp2QZopDAYi1pK4CrBKaBuH2jLnGMCozwiRG+oIbBTU9FXbKYnz
    VfPDckEgfEDelolvlU/iNSH1QMK9Cz+7Ye7AHS9mw/6CSkjsCio1RK/ZfShNDESIPgbsOb
    GmtTNeuLcfH60s9TnsJewOz+dq+IdgyFXdkjNQ9a9pADOK4IUHnKBoLiHX9PjKxKT0QdHa
    sxmhZkonMIavXPqTcfnBXVOF5/rzswxlLYS+su17fnXdWdxFabGLov+kIQSrblSp7eRQGr
    X6ZvMncFUyNvZXbzsyNdwBoxFR5Vh7mpSHTLvm3ZGzklhZU/bpy6htKvD8d4ebzZaS4aPU
    y1lFzDFnZTe4ixevTckzIxuMTFM9xmpOWrUEbFWi+P/lbE2rWAhMj5MsbBCjI8Om3yInpu
    pjr2RISBTDYH2SbpvNCYf+6A1v/NkNYvvs1UAmHRRyfttEkkiuxIGXWMXlxg
X-ME-Proxy: <xmx:x2_ravFT3_Bk9k-Tk3eW1xMYaeLDEQp7rrNQuY1ezPq6VWp7CJ_OLg>
    <xmx:x2_ralx57kGYc_tbHma0WUtDhWdsina8DSpqaoqC3_XG_QIVyTk-Rw>
    <xmx:x2_ragui-EoQ_VtuOtmqr4k2Xd--0u9v13KWBrVQ0NS1IC5P7tG87g>
    <xmx:x2_rai30gcHn-TtVfIVxOCj13i1-g1ptMEwUPxERjs8jAaDfyf8f2g>
    <xmx:x2_rauuhuTFaODExgshmWJQxXdo6dhdQk3J5Hoc4VVTz3Tgx-X9mh8pv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 12:47:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Patrick Ohly <patrick.ohly@intel.com>
Subject: Re: [PATCH 2/2] odb/source-loose: fix existence checks for newly
 written objects
In-Reply-To: <20261104-pks-odb-loose-stale-cache-v1-2-a00d5cdb5e7d@pks.im>
	(Patrick Steinhardt's message of "Wed, 04 Nov 2026 13:16:35 +0100")
References: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
	<20261104-pks-odb-loose-stale-cache-v1-2-a00d5cdb5e7d@pks.im>
Date: Wed, 04 Nov 2026 09:47:49 -0800
Message-ID: <xmqqfqxg32uy.fsf@gitster.g>
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

> @@ -824,8 +837,13 @@ static int write_loose_object(struct odb_source_loose *loose,
>  			warning_errno(_("failed utime() on %s"), tmp_file.buf);
>  	}
>  
> -	return finalize_object_file_flags(loose->base.odb->repo, tmp_file.buf, filename.buf,
> -					  FOF_SKIP_COLLISION_CHECK);
> +	ret = finalize_object_file_flags(loose->base.odb->repo, tmp_file.buf, filename.buf,
> +					 FOF_SKIP_COLLISION_CHECK);
> +	if (ret < 0)
> +		return ret;
> +
> +	loose_cache_mark_seen(loose, oid);
> +	return 0;
>  }
>  
>  static int odb_source_loose_write_object(struct odb_source *source,
> @@ -967,8 +985,14 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
>  
>  	err = finalize_object_file_flags(loose->base.odb->repo, tmp_file.buf, filename.buf,
>  					 FOF_SKIP_COLLISION_CHECK);
> -	if (!err && compat)
> +	if (err < 0)
> +		goto cleanup;
> +
> +	loose_cache_mark_seen(loose, oid);
> +
> +	if (compat)
>  		err = repo_add_loose_object_map(loose, oid, &compat_oid);
> +
>  cleanup:
>  	strbuf_release(&tmp_file);
>  	strbuf_release(&filename);

Not about this change but the lack of "if (compat)" stuff in the
previous hunk puzzled me.  It turns out that the logic to write a
single loose object is so big that write_loose_object(), which is
the subject of the previous hunk, helps another function,
odb_source_loose_write_object(), by being its helper function, and
this caller has the corresponding "if (compat)" logic to produce
the hash interoperability data.

Looking very good.
