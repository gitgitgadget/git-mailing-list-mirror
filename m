Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049071;
	b=FVZsmhGwpJ4yKOMl3ykd91QP7u9DCXUwTT6zNK3igYrjchtr1R5KsXbPTp7jpD5Ra9Gu
	 UbJ6jO7tf7qhe7pXhKfcExL5GQLD+ms2EdqxHgSKAH16paWY0dumNdzKVRawluvmtMSda
	 1m3pEI29RwMf923Uykafr1vl4w9bRoXlRDzEJ+sJ+Ao0MV54//Y4xH3nUqBetMEseQTh7
	 w8DrjB9PLciMx+2KniG0fqbvkxfGXvgrHh/pEsnHlk3uCRa+sbsONTKqehJjZJLQc/7wC
	 xX32X9NilzLPyKsDxjqW2WBccIiT1s3P6gQ8lPit/7HVKvi9L1skB/VtEU+cs+Vcq6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049071;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=r3pheWcbeDbe6w486LSPMyv8loLmLZTorZTqrXTN3Y4=;
	b=K0AP6mk8/OoWTXv6dWMsDY0Hbuc7DvnMdUm9mMHXHF34EpUqAM02mAM2DtPJiZ1Kpg9m
	 dVhMObQtkejDiAD+LwNY0FQbQk+vElOFGgGjBeuCv0nX3irrKfSbdz6RQDjZvUA58/O3I
	 NEfO37krMGk2w+T3S7dzXL3uFdzO7YW8BHJjmyJ9OPjOH+ET6c3IQYXKNVu00HNTqeE9R
	 iXfQMg5V/9l/8vcqahBkUqHLLeXMO2kpSRg5h9WZTe25lxCYhhgc47I6Z+G+W30ONgeWz
	 G5Fi9ngd9NYVRmM7xUUuBNzJOhY74UPTCfWeOGnSDo9vRCLeOaeVh1unrqj9kTNgr7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=f7jhxby8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xIgH1ggK;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD37606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 21:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FD37606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=f7jhxby8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xIgH1ggK
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E54A9EC0A58
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 17:11:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 26 Oct 2026 17:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793049069; x=1793135469; bh=r3pheWcbeD
	be6w486LSPMyv8loLmLZTorZTqrXTN3Y4=; b=f7jhxby8Gaqv3ghJWInUb66SqI
	ElTlcJr6XsFw+zRmWKeR/YdSc+WUb30ENe6VR/gQsA7/vopEv/ifSbDLHob/fBcB
	A+oQBLV9sd8CqnMajBRDFweEEDAsWIRfSt5tWY270e0LM6P6SE+pOtny3UHrByzn
	dvG4mVk8ahWie6V6xcoaaDpkb4mPSh4k45h5I/m5ZJ48MCTrEOELkrUYAuCKAmJh
	I7K3DB0C+dxKywkpFBB61GPpxR6nLtCysOelBaDpA944e4p98AYj2lwnh6Y6e7h7
	yh54meElHX1evnw6ypdD84B/nd5I6eahjt38+ziJ7j2rsXeQFY7+4kEEnf2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793049069; x=1793135469; bh=r3pheWcbeDbe6w486LSPMyv8loLmLZTorZT
	qrXTN3Y4=; b=xIgH1ggKAZyYes2ExHB4dYfIIN+nu4n8HRFhMOdsDR1aZG8+Mk7
	4vVJX7nLz76EdAM+eFG1WcL4M/3B3eq9ofdIgXq+UcobWKA6uQHtng+WtIEuJR2q
	2417Xq7Q+fwPQduN3TGLLjr2wlQlOV/m1aB84JwYxl9oi2+T8cL33axKDTunV6ht
	pa2Tkd67s7xyA+T/atKgD3K8MVyf7dsKZ+FshOqXX2wBIdtt6u8Op0GQNPuwLgnx
	CnY4PngwbAtOsi4365u9OVy25yQY/m0q99Cy3PQDlzEQpADnNIUCBappVjFPxA3j
	FeqYBEWaRjtvUnLvJz+gjOK8mtG5MBuGCBA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793049069; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:HbIwdn5Ojbwjj5KdWk0RRbui6C1W8h5fnnUPaNc9nb1fX/8
	+gwdAxOevoU50zXc24iTO+4rEmt0D0GQ0O5XHUx54/5mUPmF6wbiMTKWvOR0eQGx
	wlrj2ISHayyrKuaN2F7MdJc1Vv0fU4suQNM62qw8bBtvu9C+h59PhNnqkzgsQFe0
	zp9d4AR8i/uEwntNiHz3jpukACuNMaD4/v9nXInzJu4w6jUGXIxyvyh8WqgGp2X4
	JGNXaIE7UQhkdV9IQ6wgmqIe98ISkQO/ROYCSM/qu2FzdQ/7VV+6ONHUuycVJO67
	UF/oUUfyxVvNmvbpy5fZy8fpbeeINMxfdnB6BOg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:58fRkXXhLyQlc9zbiyS1xIE8HkjO5xlc0XO5MtxMrvY=:cBw7zhrIogGcNsT8e+uiRmEypyXGK24tiTFfvaX447k=;
X-ME-Sender: <xms:7cHfal2H3wjbKvFqEvXoUDPvHLxguTK1Z_ehP2SYntv4B3ZF3HxCeA>
    <xme:7cHfajHxtG0nP49QYp7kcX0PQrgt_Z6FHi2kzlrFP_EWIAv_Vez3LugC3Z4G9z2OG
    Ar8zlihC9AZL5zvu8cU0c3qOgRG7RWKBd6sh8-AmVWjz_v1beposqU>
X-ME-Received: <xmr:7cHfaq7F0otLht30p5S_TOqn2nTj4R_Vjh1-blrn2hm6x04SERzHVyz54qD_NC963UZlb1QGs98YO2373f49dQ5rrSrncPVxVtIU>
X-ME-Proxy-Cause: dmFkZTEaVrc3uwoD3eDKBPNCe4k8HXLw0vGy0MPmvT0IPYmINy9DDYc3hTlL3UDq5LyWw2
    8mAHSR1xP9AnJ4ZjuOs82K527sOZg/S3x4cNt+ss12RlAQDzxW34h5P8duNLiaolOQ06hv
    OuR6++hBzLtbhISW1yKiOYU5q4aU8lgLYlxyPPGg23Sd177t+N+GHgzt5fosTQmLXnlJeC
    +DtItdeGlgohvJZQ40UFJWBgCXRCBQtK6bbUMTn3IVybT1bSOJdK92kakkX1ZSOEd9DtmN
    RU3cjd3YdZZEQlNwiY8TIi62y3zrhydd2kPU2T8oLDoHZzxdKLdzPPXYonHe+ZjgVc/sFD
    MXKkQCGwXU5dqr6XuiHJpaLICyUOvODi3xLtNT9culqna2NGNhNI4uXSQSshIcpBOWzItI
    52v2JomN05atlXjTa7ymaWUxioE8Zd7Ek2jbCPSwTrDn8UCnMdeUgS/i8iuIT4y2uBHYBg
    21HI6EgmmVpdDqC2pJhxnaI2de3F9jNOl9idfLI2ccjwYUZUlmRTQ736qZi+JiqUdK4JZX
    uesjqCr1Tt9ob3qN4Mdpuh9UYRgp41KOaiV5ggBMbhQUXMz4ta+D+lZXWo6SPghhoJMuWX
    zLCbDJOUJLkwZn4DsOXe/lN1h8B6JAVHJ39mYKmASBmlhDpqSUu1ayNqHlUw
X-ME-Proxy: <xmx:7cHfahuN4N8r-Yr6cl29vI64rqk4fKiRPQ_5CoekWlUZcFYOdFIVmQ>
    <xmx:7cHfaj6Mhz1SPykV5D32ngYk5LK6bXqAFTptZbavMJcKQB0cfXDvsQ>
    <xmx:7cHfakW4dFbZMyenbfQIivHWhPgxvOxh08NNCRtjFFSGy3Ki3ie3_w>
    <xmx:7cHfat-Gx-qodJgSiqh-dlwfYu0XzzufJ03ln5pAC33TVGZgoDO5sg>
    <xmx:7cHfamaRFvFcPyUFFf-cyITmAAGFxiU4pnREshGFO-te_QdFM-9Bz-mx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 17:11:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] CodingGuidelines: allow compound literals
In-Reply-To: <a4b382c0373e1b410c4c1ef74b313f86076d48aa.1793024062.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Mon, 26 Oct 2026 14:14:26 +0000")
References: <a4b382c0373e1b410c4c1ef74b313f86076d48aa.1793024062.git.phillip.wood@dunelm.org.uk>
Date: Mon, 26 Oct 2026 14:11:08 -0700
Message-ID: <xmqqbj8gp3pv.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Our coding guidelines say that we'll allow compound literals from
> mid 2026 if no problems are reported in relation to the test balloon
> added in 01e49941d6 (reftable/system: provide thin wrapper for tempfile
> subsystem, 2024-11-18). As no such reports have been received, update
> the guidelines to allow this construct.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---

Yeah, I agree that it is about time to promote this to the accepted
set.

So we do not have test balloon but we know we still cannot use two
constructs from C99 due to MinGW and older IBM xlc?  Perhaps we can
raise test balloons for them by now?

Will merge and mark the topic as ready for 'next'.  Thanks.

> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index c06f5d3071..23a4d2186a 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -311,13 +311,8 @@ For C programs:
>     . since late 2023 with 8277dbe987 we have been using the bool type
>       from <stdbool.h>.
>  
> -   C99 features we have test balloons for:
> -
> -   . since late 2024 with v2.48.0-rc0~20, we have test balloons for
> -     compound literal syntax, e.g., (struct foo){ .member = value };
> -     our hope is that no platforms we care about have trouble using
> -     them, and officially adopt its wider use in mid 2026.  Do not add
> -     more use of the syntax until that happens.
> +   . since late 2024 with v2.48.0-rc0~20, we have been using compound
> +     literals, e.g., (struct foo){ .member = value };
>  
>     New C99 features that we cannot use yet:
