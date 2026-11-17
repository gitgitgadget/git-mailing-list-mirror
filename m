Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956149;
	b=HAWQOwihgL2a9eSkBhS3pO2fOiGDQMMm+vlSgYPzzmI1gqxdgToaIVyzmPOJv6ITCLGw
	 7kXrDNAUoAZqC72Ls9yKp/npikwUroy7nY3HvzocaxtbejTrapyMgvTIFaCGxyDKUjfs+
	 pSm/lJM6cRtr3nQqHLxbbd/uBGcCAfrFGsUTWTKkkindeHKqlcvgUkMtRdn5yzn0Muj04
	 EnQGvZUjB2bQoyetd25A2wy79Xil/tAr8//Sk7K81yISuh5SFnCylglCmkXbyHU8Xgp5u
	 JY/dW/MRUXoNXHH/9EDB3B0eBctPb2b9H9KUC/kc6hqn5O91npVWv3aPDT/uAUtXawQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956149;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=XlBDZOH3ZziSTWXGTPimorXumJWq+Ah0yusqtaVorXE=;
	b=csZTPa2oPi6TLe4MeKyn52FTmhcPZnmmCpqGFsIdjFM7P0CDHCCUNyIlBzE/r13/oU9Y
	 ukN+KzjM068KSDk3UjFLL/ytehRjRzn+JlqgHrWluGOaKqj+UmnbtfYFI4UzP4UROQ1lX
	 d3showv1hBg1AAv17c2DxggG2c7cAzTdP2HpqPa1rdTdRBmfHYneUCqze1nwhteHglmHJ
	 6vb/WAOFrMH4b6wRukwRKaXhRtzHiOb7Ho60dPq8IkUU+Rpb1DeBSNT4h19362gdCEtNO
	 dGe9LN1DMFBr4AEd0H8WFn0xTsKF/k1lGP+fyxAv5UKTlXp6oXSDKJihMoSF9BLQeFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=cP+r+BK0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="a/RToj3l";
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F8B606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 22:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38F8B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=cP+r+BK0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=a/RToj3l
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 779AF1D00053
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 17:55:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 17 Nov 2026 17:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794956148; x=1795042548; bh=XlBDZOH3Zz
	iSTWXGTPimorXumJWq+Ah0yusqtaVorXE=; b=cP+r+BK0gIU/4setS5N+cV1NhH
	rH3V2yK8fmB/auqY1k1y3UZIeg6nhPW58hlr1yZWBGWW2k0wx3F7GIWxkX1cWsod
	kLNsc4TeVWeeG9d8B2dfvyJhei8EcQe6dPOSpBVBkgZOFMnTLsFdn63CGrS+ThUT
	u6xO/wSx9TAu541yeFeIqfMUvLQs3cemXGkBBuaWKLU7s6kPVBnxislMAxe23g6f
	4PD4+AY+YVHznL1g5ucB4DUmrsGwUb6z826pAyXW4hSfeihDIhQK/2e7e9nkOSPJ
	uXX1R1+zoJW6UZhBVHhqH0D9CqpNXaOx2LwZXq7crr5J50qiF5XtXfRTBtBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794956148; x=1795042548; bh=XlBDZOH3ZziSTWXGTPimorXumJWq+Ah0yus
	qtaVorXE=; b=a/RToj3lgT5T5OEslQlaGEBM0M2Z27eRlvvpmGJ7/Q+2Ev5Xmy8
	GO4/bWdimzf2jlZJ1xSTbGqvi813SZuDL7ezvwyZsfK5iKiwR87lM9Ivl7Gnx9o8
	nyP3H5WOErLWxmUdkkApl5uwB/neI7qJK26sMppwM01k6qTZ15dvgug3TAnRtaB1
	mPlmiy01ywoW4EnSc3sJTtXLfe7/HXeEOmDJRPVY1nUqUt2ikSnTtRw7pkPTRDjH
	VUJ7B25KZTAFhbzFPQbr+YuBAUgkwbBdjfQDL9fQ+tnlHI6BbzTtyLOhUQPqpx6p
	QjQ8VrIpeHFFQhKuKKV6VjUWtiQauQ8B75A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794956148; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:GNLPvUbmjSvC90EmF/Uy+qEg2hPDJ0zjKZh6SKB0wrD/6aL
	eVZjrPJxg82XSxNdBBwTA/1k1/GKL68sbpdCoaD5yLKz9x5fhOBOQsqOnUOHrIaF
	0oyW5o1YXjBCVpItDpAn9VK2eZjLT4U8IAh+5+8xRvgrHH1FhkUwc6/tPgW4Zvsw
	oSQ/viavKYKdCi9FcKRVyMjdmZOfY0DvYinx8Y4gWaZtLQsZhLVySFzlIw0WRO5J
	L6c3UI5KlPCd221S+LTZtkbqIJqQOIpyowZZju62dZcGXx3H5MyGdFAfenzgbDzi
	veTQiC0gCjfgCF7dnTpHVazHMw7KU977mmYsioA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:mkEWzZN7IGRkebQ1VIxzXXD1dgmJ2G+G3PdmRnl5B4o=:UI76sCzrDglEHszo/X5fhxqAIKBd9rgjKMt75ZfKziI=;
X-ME-Sender: <xms:c9v8al6fn2JKuNN5TKYBz8tjBRiq-USyTTWU9cVmbDbx9sMpx6iUKw>
    <xme:c9v8apw1-vDVMzTZSES9P1OOR1Fqi1OMTCiAyhjjZ9ClSrorOxM6mmn6NvKx-KL9d
    cHhf3FbHMO1Hh5-XVE-Jxsv7J17C21go0sUoQdVfCG2YmOV8H-4gXY>
X-ME-Received: <xmr:c9v8akyOlb0eRkKrp1yCdz3_iU7GMc_sXgZ0Ft6khpIPS1upX5nJzFEpz--fHXoq2ylxOT_sW7XES64sA06VVdAGL6G1AFFu6gfq>
X-ME-Proxy-Cause: dmFkZTE+W3rpePwhMDshh8SbBHIEx6omiy+Of3u0N+99J0ehkVOXo2vNSsUIc/OHEtKDJ4
    GOG09G6UD8+kYjF5FKTp22YCoMwKWNZQUInmDmDynzHla0joBJ3PVK/uV2Vxr/zFa030nn
    hCJX/6NVYtGWJJcNKn7i1Cdsls2KOr6RVNlzri/IuVoJGAAizlJNGlkGCrvYOcPepiPycz
    QQGZZJsNo1CooteTTwCKP7kZVO1+6cHzmGz6YOKYkgBX90+46BPGTJ3YZyzypNGv8izPKH
    Wha+Vtx4lMROYv4K6I+dOUyQGE2p8ha4vi6NyI9En0ka5E8b7yna2EAWRSv1nzEpiVI/P0
    RKBoy/Fb/kyHO6d6ES/X4w4TocyxFEEsr2Q7Jb+vHw8qNt54C12uo2Vh/S1ahcMCQURFiJ
    JBSUlka+f577gno8UTC7K7bEbePsfMtmpbh2eILC0jBdwp1G/uecg8tZQOcGD4p00ZmyS7
    vkSdFEsid3qz0rcKxIIthYKD2WC+pylgTuQxc7W8xNgt1GEmSuXAKGhV5/DtsRQujj/j3O
    kNCaKGPM61f1+TlHYZiyRilpcbTFL2PwKFSKbYLNJUcmFi3Um9aN1r/CUtDAmhzo77eRyY
    RyGPAMEtwQeNMQU4J7ba/EvpnOkcBq2hWoZ4Qt2vJBRIaSKeTeaOf0BEiF8g
X-ME-Proxy: <xmx:dNv8apwIN7KcB8ojochL_xUlkFOKt7XEUvsxcFXRoPw3jouxIGNAdg>
    <xmx:dNv8amaPEMAtWRgM-iJDEVdq3ideWIq0Aqq7K0W8x6-6stAaIAK3zg>
    <xmx:dNv8aiUM51HkufClytJM9IDSORa-VLKrq7gHOm7Ni8mKEK9JCqB7lQ>
    <xmx:dNv8asixnhKZ8RVIcNAxbkUZdqF47rffkJRa5DDCuTfZDkjFr58Xwg>
    <xmx:dNv8at3uXgPQBkJcmeLFiBocXK2Z-Xv1II95MMPGjVGfnOdlr6TkZ_Vy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 17:55:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 3/5] odb/source-loose: check object size when
 streaming loose objects
In-Reply-To: <a8572aa836bcc17a7442ff92abd934155e7f6c74.1794914210.git.gitter.spiros@gmail.com>
	(Elia Pinto's message of "Tue, 17 Nov 2026 12:38:56 +0100")
References: <cover.1793355390.git.gitter.spiros@gmail.com>
	<cover.1794914210.git.gitter.spiros@gmail.com>
	<a8572aa836bcc17a7442ff92abd934155e7f6c74.1794914210.git.gitter.spiros@gmail.com>
Date: Tue, 17 Nov 2026 14:55:46 -0800
Message-ID: <xmqqse0zawzx.fsf@gitster.g>
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

Elia Pinto <gitter.spiros@gmail.com> writes:

>  		if (status == Z_STREAM_END) {
>  			git_inflate_end(&st->z);
> +			/*
> +			 * The object must be exactly as large as its
> +			 * header claims.
> +			 */
> +			if (st->total_read + total_read != st->base.size) {
> +				error(_("corrupt loose object '%s'"),
> +				      oid_to_hex(&st->oid));
> +				st->z_state = ODB_LOOSE_READ_STREAM_ERROR;
> +				return -1;
> +			}

Hmph, is this unconditionally noisy error() warranted?  The other,
existing failure mode in this function below this "if" block, whose
"return -1" is visible as precontext for the next hunk, is a silent
error return.  Yet, you are trying to set an appropriate error code
in st->z_state, which presumably is so that the caller can react to
it and give an appropriate error message up there, not down here,
no?

It feels very inconsistent.  Either the existing silent "return -1"
we see below should also become noisy, or we make sure that some
caller up in the callchain reacts to st->z_state to report an error,
keeping this new code just as silent.  My preference is the latter.

>  			st->z_state = ODB_LOOSE_READ_STREAM_DONE;
>  			break;
>  		}
> @@ -335,6 +347,7 @@ static ssize_t read_istream_loose(struct odb_stream *_st, char *buf, size_t sz)
>  			return -1;
>  		}
>  	}
> +	st->total_read += total_read;
>  	return total_read;
>  }
>
> @@ -388,6 +401,7 @@ static int odb_source_loose_read_object_stream(struct odb_stream **out,
>  
>  	st->mapped = mapped;
>  	st->mapsize = mapsize;
> +	oidcpy(&st->oid, oid);

And if we do choose to make the low-level helper silent (and return
error code via st->z_state), we do not need to add this oid member
to the structure or pay the overhead to memcpy here.

Thanks.

> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index f2b24dd278..622d734ad3 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -1513,4 +1513,22 @@ test_expect_success PIPE 'concurrently written alternates are loaded' '
>  	)
>  '
>  
> +test_expect_success 'setup blobs with bogus size in header' '
> +	git init bogus-size &&
> +	echo_without_newline short |
> +	loose_obj bogus-size/.git/objects blob 100 >oid-too-big &&
> +	echo_without_newline "much longer" |
> +	loose_obj bogus-size/.git/objects blob 3 >oid-too-small
> +'
> +
> +test_expect_success 'streaming blob shorter than its header fails' '
> +	test_must_fail git -C bogus-size cat-file blob $(cat oid-too-big) >out 2>err &&
> +	test_grep "corrupt loose object" err
> +'
> +
> +test_expect_success 'streaming blob longer than its header fails' '
> +	test_must_fail git -C bogus-size cat-file blob $(cat oid-too-small) >out 2>err &&
> +	test_grep "corrupt loose object" err
> +'
> +
>  test_done
