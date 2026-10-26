Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793046769;
	b=upqC6NWGH26b4mZVryyHu41v8iarpLsbNQLXQKyfHNliqY+M2q1ayyx+dkpj4Mrrp4DA
	 ouHjfnEWtrD6VuWEGGfTsXqVGUyCnJhfJnUTspYcVqX0wqC0Mgdfve2vP3i43N3ZnfnDb
	 +gXwZ+OTnzU8oUPplvsZ4JYUuXHKbbAl0cf3+3XRrV6Y4vYFlAV84/Se2kkwYubtA1jO+
	 bYcuit3SroxxSfaHNcupZbJIizWwwHU7DnFruB6tOIgzv7RHkERQlkFob9jvBeCr+tsPT
	 18nuFaOlPCljhCTiDm6/3AVJmrQsagW9yNL+whNl1De5pE/9GPkwxkEikv/LqHZRa7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046769;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=2v3OPo5rs/IM57xx6XcdAmRu6rqFLWUj4v8iOyiGo28=;
	b=5JIItTCqludJwcLMdP9o4sS5IWZcVSPaYOqNj2c3mlhhm/sbd7y5snL01WYEBwwaJETX
	 vSjJspgOXqLf6lBA8wqmklum6MoTnv3XEaga/w9SVIrIrWpY3jOgQPa+plCfk1dSoBsHJ
	 w4NZivAonhYf5oDx0t6zZ7GMwRIVpxGxPGZk3DCVmpaXIOZXjxK8qVw3DhsNWACF+pLco
	 N2mtUrmYZnz0duQc3ro0Z7YMHnV1OmG3PDMQcHwG/LzWbY3zN6aoaDidowqv9G97CCnS5
	 prHtom34HL7RbgozDMvXn0F3rdQSYATCBY4IRsb77Dd6wsPmml9RY0HOufC/p2XrVzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=LWWtKhTx;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=KnF2UglY;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E863606A31D
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 20:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E863606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=LWWtKhTx;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=KnF2UglY
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 6784FEC0A27
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 16:32:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 26 Oct 2026 16:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793046767; x=1793133167; bh=2v3OPo5rs/
	IM57xx6XcdAmRu6rqFLWUj4v8iOyiGo28=; b=LWWtKhTxZiiU08QIsxHVipWA8i
	cWFHrAoa3JfpBe2dFdAozsvd7HI1Ir+8CwroXajIsXbXedaVVC5W8RMDS56wSi7x
	G85wHgvlVDBimBAPVembaZrUS5kHoqXLuhZEWGlVA14tLeiEwstPLDqnteTjEUUk
	b8er9uYCordA+mhfJvbE8fu+TcyiicY30ZB9aq6Dn22G8q+z9OoexSXpeWFz2Eo9
	ehQRL4oul7ail9HDS+4aQIkcnGRWR6KRljUfBHroYPdhgUIWk93PQVQ5uOaRDmqA
	5FmwLARGhaGCzEvQv1eHkG2eCBGq0CpJ2Sr2XGCOjmm9aguRL05yVUgOCIZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793046767; x=1793133167; bh=2v3OPo5rs/IM57xx6XcdAmRu6rqFLWUj4v8
	iOyiGo28=; b=KnF2UglYq1CRyLv5lXo1NBdUBwdmQorLEx9IUqjQrfVnLmlywJs
	UfyAbFrG+A/GH1+CEPcAjfobc0CjETaLwHVgJQmJwIi1FIqZPHhoLDyReRrRKXXi
	VrytARhlIcBKv8FBq8E5CiuQ3yzNntIbc32YlLF1Gz47SREmbXqqCQqGXtZEgGtW
	OKCEDzKT6zq4aqbsO0tS1k+TIkIlRY6daGyAdU4l5UuyEJ2glndQx/mduRq4tf2x
	+pp0aaoSmmLn8GICUb8BxwQEmJmN2qFlEm2Ma0OK+mWG90fpEjxyRyQsMNLqsffY
	pEAhy/tS83awuFKipsP9qY+CijrakrSFTYg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793046767; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:FASlsKelkrOJ8IQ6dyvNtjl1vQQl7oD4UpfYMakyDzMDMVG
	aHTEZr38Ckagpbao22DnX+Fo5U8tr2YUjMgojg7hQkQCPJ3MIbdaG4CYjvNljUGB
	v5wW4mKzQJMK6KcNyCMnUAGkaUm7UCb7PYv5AGLa7fmnQDvVq6v+z4jm6F+9kV9f
	4RJ9K2tDEkoWZNVJRMNDRuAeb2z1XAb3urkLUYQZu7PoDvVcOkkmx609PHPLssSI
	3yNGsKGjso1VSvDoNAWJf5mk3Oxd1gXilP5FDy0SC1CNAc3Gt3pCKeEM6nkB5vYh
	qDPxJz7zasw6b7B8U/ZKKWGbPlHndlEfi1j83WA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:oQTm4W0Q1TUr3WzsMgNUOEfstptTxfcc4gA8ahmaJm0=:27YlPrCllJrbn2NaQZzGOu1wplFlSaemMC35QvzbNA8=;
X-ME-Sender: <xms:77jfaoeULlkK_5RQzr_D1LIPOmgaefj6cxZIThyYjvTQzbNRWXI9Gg>
    <xme:77jfat7IK8imh8tvxy9oVX5jayjb2W2rxOk7ykb705jFuHAswIQUBgcWOiJ4vijfi
    R_o2eOXTxORzoCDqO0nP7YEDIYH60a3XqlMBdyvB3rB4XkH5AgoIw>
X-ME-Received: <xmr:77jfajVVh4orCy6Q0ufYbDlN7p5lJMvDetb9RWWje6qqY0P6zTyjgth2o8UTVmpg3wk_mxf88mgCLimeJkqgI1U-b9HD2RjEObno>
X-ME-Proxy-Cause: dmFkZTEc2Brb69PUVgr5FnPT6J1/ZlGL1bR0L+5pf7/SQZqskYjxCQVrOvz0Q6ysrqRExk
    7fwKkvHZPvUJIbDH9771nMLGtViqjxK+r/HEITh3SYsbl2zxWIazp09XHQCYc5aKq6Ytfi
    tQastpb7pDocSuW2pvkL82pG0Vrrg+8p4JnIchQEQS6lHF2DcwCNiNdJBtXULt0jZM3Lkr
    UC3XzOfexNKq734MBi0SMzDKAlP4wYPRAhmZjz0J5uDTNf7kDefJaVGYAZ2uwuZ42OY/PT
    D6KAZIqNqfin5B5iT5Hi9j7Bs74yWxyz6oK6KudlIW1mZKvTKFbxIM20Lu75+IsjeH1uQn
    99+MHjFCQQ6BWzIMBAgzNyvv/xg+0FVYtYBsKEVdIXUuzdtNrU8Wgmmq5Nt8M00gX81fUD
    eI4EjKc/fG1jUpEpv9+faID82MAToz1ZLu4AELZ9+bCAO2rUg+Zak1v6qTwYriA4xixOLL
    L3Z9nGvIZXV5MecQA4WGDlfxdDFvjb70K2npxIRHpPDNelE30NHKz00WQKKGcrO+S2RGuA
    fjqO+LalLFX6Rd8u8a0vPgUMTfJQVXBLjkfmtqdbSSCap5/yD3+uOJlFP0l5L8CUp6VCpY
    M//xwyUc3argmOiqojruEhMw3i/lS5Y01X04cKiSVxdNFa9RnQftl2mX7MLA
X-ME-Proxy: <xmx:77jfak5V9vhdqnB4XOd-UDikSze9nPYqKhv7UtglJ-jtVFcdPcGwPQ>
    <xmx:77jfamo15P-P4AT7XpibDJ-SJ6gvE4TmFXnwt7hwVDjx1JA5XpiX4A>
    <xmx:77jfavkYELVsH4ZDx4xNtQfGngFabwFsJAAYxnmJ7Hdmkm1HnlrAgA>
    <xmx:77jfaqPO3o_EI5fgw3URQf3LaAlh-ErVNdWMAMJV-zhn_4ljp-6JYw>
    <xmx:77jfahACVby0JJUB4agFMCwB75zavk3neVw4DOdUhpzJKptKcOu7MlrG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 16:32:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kerylefondji7@gmail.com
Cc: phillip.wood123@gmail.com,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  git@vger.kernel.org
Subject: Re: [PATCH v7 1/1] archive-zip: refactor 'path too long' error
 message to use Q_()
In-Reply-To: <20261026190423.1925-2-kerylefondji7@gmail.com>
	(kerylefondji7@gmail.com's message of "Mon, 26 Oct 2026 20:04:22
	+0100")
References: <xmqotsm8qsdl.fsf@gitster.g>
	<20261026190423.1925-1-kerylefondji7@gmail.com>
	<20261026190423.1925-2-kerylefondji7@gmail.com>
Date: Mon, 26 Oct 2026 13:32:45 -0700
Message-ID: <xmqqpkwwp5hu.fsf@gitster.g>
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

kerylefondji7@gmail.com writes:

A few things.

 * Please do not send the same [v7] multiple times.

 * Please do not send your [v7] cover letter as a respopnse to a
   random other message; instead make it in resonse to previous
   rounds (either [v6] or [v1]).

These harm automation.  Also

 * Patches [1/n]..[n/n] should be sent as a response to cover letter
   [0/n].

This [v7 1/1] correctly responds to [v7 0/1], but if gotten wrong,
it would harm automation, too.

It also is more usual to send a single patch without cover letter.

> From: Keryle Fondji <kerylefondji7@gmail.com>
>
> Replace _() with Q_() in the 'path too long' error message. Although
> pathlen is always greater than 0xffff when this error is hit, Q_() is
> required to support correct translation for languages that require
> different plural forms depending on the count.

Nicely described.

> Signed-off-by: Keryle Fondji <kerylefondji7@gmail.com>
> ---
>  archive-zip.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

> diff --git a/archive-zip.c b/archive-zip.c
> index 6f73ca6d58..160efd878f 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -328,8 +328,10 @@ static int write_zip_entry(struct archiver_args *args,
>  	}
>  
>  	if (pathlen > 0xffff) {
> -		return error(_("path too long (%d chars, SHA1: %s): %s"),
> -				(int)pathlen, oid_to_hex(oid), path);
> +		return error(Q_("path too long (%d char, SHA1: %s): %s",
> +				"path too long (%d chars, SHA1: %s): %s",
> +				pathlen),
> +			     (int)pathlen, oid_to_hex(oid), path);
>  	}

This is outside the scope of this patch, but we may want to update
"SHA1" with something like "object name", so that the error message
works even in SHA-256 repository.

