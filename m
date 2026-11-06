Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997370;
	b=UlpFqS42g2DGVRpI7u5YsJmVR+3HLcZ0d3RUHdCQ3+/N+D0w2n6Z7y1DVmdWIuXalUvY
	 XKDhXafiBe2swOl1R/VVv1u/sxAX7jBWvdXkfC61RCJlgvt13G0Q+16b7+7jmprjVrtf5
	 vsPhB8BBh3Xt/SB3JjWn208q2EQQCJYFmTyKGIjQkimSct71B6Oxfc6BmiujMJp9eL9ZR
	 D7FjpFrxfKSJJVFnaKrOjsG7Ijok2LDhDl7EaHuHMsNaWhGuG3zLW2aKMYWaQxpDqlqoP
	 UaOfDHUG4xDCe0H7OxO+edjnLC8xq6jkyPb1ezB1ljyhuXrXbNijDJJJj1CoHGMOBPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997370;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=yyfdRtCGqpvJwRIejYf5LhZgkiNOfOt6J/v2TkgCV7Q=;
	b=v1Cw0p5pzITNX/Is/3AQVaeVgE7ix9g/WL38EbJ1M6BbA/qHSRKvEFtN+GpMwuQ+QjdW
	 rgPhSXfa81a9f3j60BN8RH+BOmc2Yn2YKn35/w4QLuuCZT/cvvFXJ2OhH/Z6I0YmTYK+O
	 Ty6jq672OkufgiXD6dOvemcgFJBFz9tBAQUDm8XZHvgiCHPsUH44khYKGNC9UZYGL2e0U
	 wxWqAJrOheWTCUYwDzFcbmfb5wPPZCfGWfs7E9IvxYBq4F3qw94PaMKTIw9SM8LjzA3Xv
	 Sc3jk8E5ABOtViOVOvrk5K+h9kTQ2lMxqPVclaZ1yOCYaKuN8zPK+kOtUK2gEUNVXTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WPXY61GW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tuVXHJCV;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18012606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 20:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18012606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WPXY61GW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tuVXHJCV
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 53FB914000C1
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 15:36:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 06 Nov 2026 15:36:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793997369; x=1794083769; bh=yyfdRtCGqp
	vJwRIejYf5LhZgkiNOfOt6J/v2TkgCV7Q=; b=WPXY61GWtvvrlLI+j3evqUGptC
	elZx+Z4O1tKMLHLN7I+QhaWgtJU/+wItwlDIWTXCjrf2Bs7DSJQbv+acKB+CRX8J
	K9WFLMmDUHj6/q+y1S8WwfuKK0F5USpO453z7ZYgvjfk3zyK3hRt0tF7liIIeRdM
	kN1lQv5f6ir0ad+DO00h+Ml2HodVngaLTNlgl4A9C4QcaWVxaU6oLWV1Wl+iSrJ9
	ck+knzTRej79eNXYat0GmfVrLV2AlGdVy1oIqWuItYbdw4RsuxYOi3aOSCl1q43U
	+XxLiEI06hklexv7KLTd7hel523e9mQJ94Tv4kpM6l24OFuvbTCJCZ7HACeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793997369; x=1794083769; bh=yyfdRtCGqpvJwRIejYf5LhZgkiNOfOt6J/v
	2TkgCV7Q=; b=tuVXHJCVI6rw0W1GTSHLtZtZTFrESJjrgL3iMDwP8KEXO5zLcHY
	efXw4yOgrZzVxCLkmOKYJEn2p4Qpe8BwpsnvHetoLRmpu5xoT7m6p+0EYo78Ywe6
	s1w+2uH+Ijks+0tu2zC7uWMbv8v7iaPPE7ODdEIG7sQZ7jT9SnQ5AZfBXxAFuA4U
	kdXG1Scl0SpAG+3DrrZgfe1WBwnffdS2GCBeKhRxtLu3Kpt8RHr1yLk0AtsBHhTY
	Ufy0SBuC+UWSCCNfxJBx6gRiLs3MtCNPbpnAI2DiRehtzvs/fctLWxWjiHPwtffV
	gHTW11kmvkK5vgVygrKAtGMcfgCZP8wyzwQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793997369; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jBP1+64rN4/odgQ6yub87eS5y3KBm29KpU0nNq6+tPYpKXi
	jbfN2+MRmHgzaxzLW0/GetpDsHIO/4+jmyWbnzxR74r1mtJTxyI2f1OS5XYagEfp
	DZLMeZay1Wu+CdA/A4IEeh7MpApkVdQKB6mNHJWPSHGHZaeG+/buhcR8rGX/Diaf
	C6T3qg8fGJ+4hi5pnqNmSr446hug3E0pCkWR7+ujgxOs9VGozb79clBsthvkVRqN
	izR+fSfRUSS7eUhviKnEDz89jNbU2BtvEE6kYwk3EMornk2TN6ntZiA6YrDcrZyI
	SmxnYPopAFOY2mDqgIUFq+lM10eIPRAUk6R+t9g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:mLevowv7cZ2qEC7fVyvCw/ybd+dD/r3J3h8OBaidsSs=:s6GD2v0JSyNZmMA8hh+ak9E2HzkBUL6f4Sr/Jr3DqDc=;
X-ME-Sender: <xms:OTruanjSZzIExvtBLkONJog0OLJct8K2cPNeB8hFrdjVvKQhuoTVvQ>
    <xme:OTruarAtGzcvCyPmdSE-chA2vpYB6R_G2nSE0ivGAbhdz2EWH_FPHIE20KifdWw77
    F-uYq_cWVvbLhjWK8-HZHZoSEYi-IoJHcdDrZX-OMvn7bNE8OYBnH8>
X-ME-Received: <xmr:OTruasGhyA0LMwXEp3QiW_F46dSgXhsV2uhKAVWAUNqi78Gor1URr--3f2DjgtgwPdTlPspQ9tLYyMKxAmZ5axiFsZkRGeN6dwJ9>
X-ME-Proxy-Cause: dmFkZTFiTAGG5Jc+6v9dsnksxJGvvFHjd2OAxUdTCewWI31/asch+FmCjGL4jLxSQXQTOb
    CbDUIP0PY8CB+VULHqQys0igNwoK6cobxSWD/EZ63++Yvxfyc0vTRHCPP009wkri8PUyTr
    ZtXpfEog0WyW99/+3XWgZ/TNbJ+Is/IrKpMki7F06HGJy1h3LZHY510EIT03Mw8cBAe9eu
    Od801QdggRkGkVAC/84vFmI280L4CnsP9v2rPCFouB3ipBi8CDWC+pUKww6bc6a464t94/
    ax3pnN6Pl32XBvLJT/mlGU7xzRyXYnTyh+ygDDUNyOOoyLcLeEfWet4gUmyBff3tt72NtG
    63DvNbVHrJEtr9UVGLx9n91L2+PBq81SeIp38Qpnfgp2Dj/OmmIg90slNJa5jVLfv62SWz
    mTYL4Y46dxJ+BfQ51Ikw56FEaBvqELhJxufIgpNceqJrr7vb2ZmP8Vy4pfF+TNjOlezhSJ
    /iuVfGL94IziDlmBHSiedOqWfGprWLK3m3CL8NsmHiHIiZbBbfVDL2t+ecZoMe2ujX8Ndr
    GW+EKbAJPYT5nanm6ZA22SP1a+6I+EnuK2VIyj1Qbr68dj3wSr/m6TKL4BkcQPsET81ERd
    s/PL3f52ck65lx0NU6zoHqewE6kxjHCnjS8C/bBnTvNN3nBryLljArJ8uPMA
X-ME-Proxy: <xmx:OTruajJTzHRnBiYftjm4Yr5IgJRFsJLZg_F55KdEerSxVS6iQn45Yg>
    <xmx:OTruagmOFwl21JAtAL4NNzIB1l-xxEhAlOqVvc5wDXDa2alXR64Hxw>
    <xmx:OTruarTdhRXz7qtyE1Iqcdyv6MM66RmTdfqQq9C0u7e2o2PYllpsEw>
    <xmx:OTruaiIxCnEyEO10xNq_cEUM2kv9ceNKK-g2kjdtnvY4RqYYf2et9Q>
    <xmx:OTruajkjfqCvJ3fz_brTNjHN3v-Ua6vg0LDn2JHT9jF_gFqliQzLUOYs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 15:36:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: Hannes =?utf-8?Q?Brandst=C3=A4tter-M=C3=BCller?=
 <hannes.mueller@gmail.com>,  git@vger.kernel.org
Subject: Re: [BUG] git apply: pure rename followed by edit fails with
 core.fileMode=false
In-Reply-To: <20261106181145.1070831-1-aniketgupta3001@gmail.com> (Aniket
	Gupta's message of "Fri, 6 Nov 2026 18:11:45 +0000")
References: <CANuH12niCO_tU+=dikanZ9Wf30NFsz4jpnZBXW6OyeQfD26jtg@mail.gmail.com>
	<20261106181145.1070831-1-aniketgupta3001@gmail.com>
Date: Fri, 06 Nov 2026 12:36:07 -0800
Message-ID: <xmqqwlqpg0js.fsf@gitster.g>
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

Aniket Gupta <aniketgupta3001@gmail.com> writes:

> I was able to repro this. One thing I noticed: taking the whole mode
> from patch->old_mode also takes the file type, so the "wrong type"
> check can no longer fail. With a pure rename of a regular file followed
> by a hand-made patch that says it is a symlink, core.fileMode=true
> rejects it but =false applies it and turns the file into a symlink.

Why does the input patch talk about exactly the same path twice in
the first place, though?  Are we talking about a valid patch input,
or are we bending the tool to cope better with corrupt input?

> Would S_IFREG | (patch->old_mode & 07777) be better? That passed your
> test and the other apply tests for me.

Would it work equally well when applying the patch in reverse?
