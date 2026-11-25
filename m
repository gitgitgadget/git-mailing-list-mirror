Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646861;
	b=Qy20LjZ3D1NYlY559PzynoIYey4WZz/rO+zXNBK/1cIfJugL9omBqD9o2sFHJLhFTrsm
	 X+10sdqCv7EgHQvk4gI8mT/vpcbihUcO8CYedeMmqjjDyECaocffSxkBZw5PihZN/KyHU
	 jT2BD2Ysxqu5uOd4IIdaq92FgvUG9YbbDX1urqn+dGbHyRLISLCqmgoHa4XCk4JL57ZUb
	 iIjUIp8UQcIbkpx59brcOCIBeaYGCLy/ZZH5xR4bSlgMph/IjCOUXDo+lPNjPhk0+BlXu
	 g885B65sFTA96WEuShNbYdewR32103Mr3WnoQvQtpucE5Y+B9jGQED7x+6gghwy7I1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646861;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=q9/54hZF+tRwEnCQ+o9qfoM/FtfXRIzO5Hegd/erdW8=;
	b=rrVu7aRArpbFzSqe70fEJJ/T+bdpl8Dmkfni+ESfQR77JdYMC7MGucXcRY7ukt44N8GC
	 IURDleY5zEZy0kSDGF+C9tmsjxfRK5dj0q3HLyz+j4PVHj+2m70kCEOOmbPoF2zlmdDyh
	 HKqxFhcM+TOlFJXzA7FnHRvfvAgGmqxDLvI48Rxmd9jaKhtFyX8vi9NhIGCdVOzfmm9oe
	 DlQ2YDdF5cTmZnv3tWipPZFaZ6M6oVjhDOz+fTC4nG810CBSsBDrLKQWfmicvTgCmV2g0
	 U6VN4eRHKzkKnlNNcynyX90S5ys3Ym1cnpnYM4l2qetvmF4GPorVKJKXOiJ+QaU18hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=AG7WJIJY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=M8p1V4Ya;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77E2606A321
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 22:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D77E2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=AG7WJIJY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=M8p1V4Ya
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D1798140038A
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 17:47:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 25 Nov 2026 17:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795646859; x=1795733259; bh=q9/54hZF+t
	RwEnCQ+o9qfoM/FtfXRIzO5Hegd/erdW8=; b=AG7WJIJYiNWicXW5xaN1JRe1uX
	vMjBdwxpExZkfZjC1m8Wfm9Fx9tL5ZY5hixjWYrlGLwGwf+ECPPMsfbhOVSRUH7M
	ICbLLjt2oc2aZFjOgx4pjkvzwSiF8TSCXO573ZjdYoYzx4/lzMBEGS5/ePWt0KXO
	vlAwTee0Ko6ICobJi204lre7eQQjLkLuKJFAL7nh6fbRKmXI1jvvIP0j7tkvshHV
	5MuGiJYaD0k3830Rr+hIAetvxWwEuZOmU2iITjXSxVd1cHCSM4Lj95AJDR3SssHz
	hf7MmmAgOSI0n9fo6DMLukGL7gcf5QwlsgzoDM1nD8B+C5JwjejZCBHdNKag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795646859; x=1795733259; bh=q9/54hZF+tRwEnCQ+o9qfoM/FtfXRIzO5He
	gd/erdW8=; b=M8p1V4YaygISgFkBkjFmKO31idWmEBuj5cs1vHztSYw9rZ2sGn+
	e2wsE5bZlJ7Gvqg8dTrn80nOtLLK2jN8+CfzFzVYsF0NaMI1TTZBmaXk3zgszHiH
	Y18dzvKVbJh/8bSDaICpaMXXK/gGhaFC8DSigxhXFxUWKHG8uM//Iw+TKsqJP4zl
	G2rZXGFjLyoss7zO2EPKOo8ih4oJWnXw9m7rNEhxxnwqkQDQ5/MM9YNYlnrIK65Z
	8YYzpy9SlgznA0jUpUW9QwlYcI2oW0OAFN59Zc60el7q0aUklBrWwRVUvi9eW57H
	KSE4qXdl+gTCd9OzNDU3azyM8cVcC5s+OKw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795646859; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:XxTfPGhiLXkl2+Ws9SjBVZ8BItCHFTHGRgaQ275HR/1lZjw
	DyQkCFPhiYF0K4Yb6MExSK7bQh1zkV/BhUwftL3GoArd/cScwI0X2P2EY0AUl7bc
	jv6RDy6nuB8k8774LWYyBXKqid2ikcwoKnHW2fWeN5mgjd2FPl+yQdZcSWRQpKmN
	1dwP6GuftmXLPRktRQCFlFTanDgF5cJeDXGv9Xy5vJ4UQn4GB/ziqBYWjSvldh8e
	cD6ZYAHwD9EVbqvT+WR2A1+tIxflbBZT7eBMW2wP12yy7mGtJcMqF3Gbul11tyWA
	kMQ3D/oHgDd+PnfWK4vRGRMExbfrfb4fwLmJn8Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:h2DXgoxSOFFRG+elqQEOuoSSIN/o/oEUG9hbmTO3ldQ=:CWpHx1pfWj/PPENN/ytDFsxwO/6iR5LIZeng5XXBrcg=;
X-ME-Sender: <xms:i2UHa-BxYCvXLSqoSMvlMIhZ7uZtMGqPWdYqrATzqIzjjBvVGdINmA>
    <xme:i2UHa_h8Drza9L7UIJU3ffUBnl0BtPHXsCD7cTSfCWbb3kNG-lE9TJEOXJcfJiOXp
    y3-SYFfwD7eChi9E1T3_Zws-nxckdViGLT6FNfTM9_6VuRE7grxXg>
X-ME-Received: <xmr:i2UHa2kT_MhtOeVFxS_q1M5-EKxOpTyVHB8RBq1Ur4ZwIyBA3Af2b0SXSzJtvjYwptsLe5iOUaDwV_FMsBRVCfKKVbqmqOkoTXW1o18>
X-ME-Proxy-Cause: dmFkZTGRT3Em1vPKV5Px/13NdYbwmB/9JT3zlKYd9Gk7w5q2VePwutbxiG6GGiaolsHxV0
    Rs7TOWMH9Xrsshh0mW9MQx2MR5xLa1cnJlGssOy0Ujz4+uKz5K5yNj65j5/wZcB5N4+Chl
    vonQ2p1U/5UQSILGuuPx9Mdbd8uYSVmq78HmUt5Avi50HWo0FAhH5W52vI5A77Lkvg6hbl
    8td6x+PxxmztcGK3/FCFkzDuQicD3dTQdjj6EEyODhpGEV/6KHLYbgS2qTSbUwtInxxucp
    B9VPv2bxx78LwY/qBSmwn8XHK2F9TIJWq5H7wXd4igl5N39KFBpjE++SKDQ5JWscAD7Ksr
    Y7meHQxA9hmIVat0Ay+GkvluwRdn35mtoT89fBbbf3bLZke/Bs15toD5pg8mZFuOSu9R++
    jlkArTlHSc+aJwtXFOvEZ41NaG8pBSsC9STOikV22aqDBSC1zViImiFlwsd4sUBfwEZ7ak
    CXMtGPcuuKi8utACFnRunuCGBIHqrZumaVGT8VGC/p4JLl62DrkXxPxzH0tRLPsxSAZKNU
    4E57NENwRCZP8KIyMEb2bwjuRVo73bhL6WAgaPQBqNeCP6WcMhIlT9PN+fLMIssocOZWKI
    xhRyeIylMgQcnNOOeCVflrYEqWNN0PaM2WY+DQM6f1OTiuDtA0TAjxdtMyzA
X-ME-Proxy: <xmx:i2UHa7qnsNhnzFZpYmAoOuWQYznLMVqzuJANrkgxsb0RAoEmFTg57A>
    <xmx:i2UHa_G7oZK0_0dcZaGleUKRapc941h393CLnvIpS5ojGmc6P-xhiQ>
    <xmx:i2UHa3zZeUwBSd_XP5GBma0olTmStMlhzFuzamUgd-Kc0oPCaSJrAQ>
    <xmx:i2UHa0oVgpe_cJQ9se4566vvCS7xxYJ3_l3P88W17hE17GkFvyqp5w>
    <xmx:i2UHaxknAv8Hse7gNu_rdyleapPNnSPM87pCclw92XdCd2VAkIwBE8-a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 17:47:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Alessio Attilio <attilio.alessio@protonmail.com>
Subject: Re: [PATCH v2] pack-objects: handle missing promisor objects
In-Reply-To: <pull.2333.v2.git.1795636170423.gitgitgadget@gmail.com> (Alessio
	Attilio via GitGitGadget's message of "Wed, 25 Nov 2026 19:49:30
	+0000")
References: <pull.2333.git.1795635624820.gitgitgadget@gmail.com>
	<pull.2333.v2.git.1795636170423.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 14:47:38 -0800
Message-ID: <xmqqzeuwwmt1.fsf@gitster.g>
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

"Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Alessio Attilio <attilio.alessio@protonmail.com>
>
> Objects missing from a partial clone are expected to be absent.
> When checking whether an object is in a promisor pack, do not BUG()
> if its object info cannot be read. Such an object cannot be included
> in the pack, so skip it.
>
> Pass OBJECT_INFO_SKIP_FETCH_OBJECT explicitly so the lookup does not
> trigger a lazy fetch.
>
> Test filtered --unshallow and --deepen fetches, as well as a subsequent
> fetch that repacks links to promisor commits with missing trees.

What is missing from the above is when this loose assumption is
activated and why it is safe to "assume it is a promisor object" without
actually validating.  To help that, I would imagine that starting the
description by stepping back further and describe what the end user
would does to trigger the code path and what the effects visible to the
end user is that comes from the affected code paths.  Such a descriptoin
may start like this, perhaps (I do not claim what you are trying to fix,
so it may be way off---take it as a way to explain why a good commit log
message is important by demonstrating what kind of misunderstanding can
result if the message is not written clearly ;-):

    If you try "git repack" in a partial clone, it may try to fetch
    objects from the promisor remote when it tries see if they are
    not packed (and needs packing), and ...

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 65c2ad9a86..0b40b23b33 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -5091,8 +5091,11 @@ static int is_not_in_promisor_pack_obj(struct object *obj, void *data UNUSED)
>  		.source_infop = &source_info,
>  	};
>  
> -	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info, 0))
> -		BUG("should_include_obj should only be called on existing objects");
> +	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info,
> +					  OBJECT_INFO_SKIP_FETCH_OBJECT)) {
> +		/* Missing; assume it is a promisor object. */
> +		return 0;
> +	}
>  	return source_info.source->type != ODB_SOURCE_PACKED || !source_info.u.packed.pack->pack_promisor;
>  }

This function is called only when pack-objects is run with the
(undocumented) "--exclude-promisor-objects-best-effort" option that was
introduced by c08589efdc (index-pack: repack local links into promisor
packs, 2024-11-01), and it is given only when index-pack is running with
the "--promisor" option.  In a repository that is not a lazy clone, such
a loose assumption will not get in the picture, which may be what makes
this change less risky.

It is also something worth documenting in the commit log message.

Whenever you write "assume X" in an in-code comment, you should be
careful to say why making such an assumption is safe, and what the
implications are when the assumption turns out to be incorrect.

Thanks.
