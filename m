Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767648;
	b=DTNkr+NMmFLd3Ygpe/8xZIpjlwPT4j+tI4axoBXgzJy2s+hk4bX56qjfG+M4yY40mxMu
	 wyWLXl1rovCXZRdFk4i81xF4RBMD27X3u6TybT8fb9Zf0+PAX7tlPNm/BTMXXdxCJWRcx
	 FZTEDwH0AQ7dJVvQ12a547Eu+5HpEBW5kMxyvvkdu4CfZmBTuEnN1CKl3S1kOlfMTlaIZ
	 9mmMJLykJif2C++apSDOF1JmGhgrmX2cqZTjqk0BV85Zq8yx6hqz1ZrB0GQB/zZxcqX7a
	 wt+Bax850fcaxZpYcY1vr4IaloxwvD6EoQylozwSqoQeJvs8t7sMZsZqgb6s2g8YfaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767648;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=S2Feip3zVBStdLAKk81iE0xHskxtbp2s3WhvjNweblk=;
	b=0HzYcy6NF/HM36UvvhFSn0q8cA8wmS93ZqGevjQhM4EmajMN1MurDEumq/LQPEC/Wtsb
	 /8e+Cr4kShToqa73hGGFv5SZ1reKiCTOz/Y1EqzTc3/aJW/D+pcME7xbaDq+Ed8IzDwUz
	 p3sWG+tjaLHnwLwAqHUnkNSiaV/iazv1kU8DyESvo4WXLEOj8PQPgb2fn7uMgoBbhaov2
	 l8cr2ForFcW0Oyf5B/ByIGNoYdxoCkSTxFVs7iyx5NkJOYg3YEnspCKDZfGMOBPkqr9gF
	 dIxFBcLzsevtd64XXU4Ay+DaddOuF6g0oJQFGY4CqPA/Kbl1aWpYnqR/f74g3A12KDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=SQOjWpoT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wrIZ7aYV;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DE1606A31E
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8DE1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=SQOjWpoT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wrIZ7aYV
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id EECA4EC0377
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 11:00:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 23 Oct 2026 11:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792767646; x=1792854046; bh=S2Feip3zVB
	StdLAKk81iE0xHskxtbp2s3WhvjNweblk=; b=SQOjWpoTc2tD7rF+HbtktsU6vD
	BLTGjkT/JB0gnNQDxCrwg1NKQjXBXbM+ma4FkNe0rg6OdvUvzYrSF5CWH5sOSIsj
	8gzwONAOs86LuK6jR/m7hd0DB7e5zEFQ0SgS8YQXilMph5CkiT1V3IEhw43SB5vt
	sUZKoM7e5CzK0PhBAsyFABxwbhRxWqK6/PA8wFI6H+TEu70/JEM1j5iA6+Dedv+B
	reMErjRE5csl4ySXSSeyz0873L2TOp+JtmpLwvnwu3F+aJpGMUZ5tjJIGxGjbxzZ
	RdF3ZMkpxjs83PcTAOVXDETawm2Rec7qv5vSNWYPBl8mMiup5DyOsKmUXJnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792767646; x=1792854046; bh=S2Feip3zVBStdLAKk81iE0xHskxtbp2s3Wh
	vjNweblk=; b=wrIZ7aYVsJHHuXu0O834i/wG6zUNPsA4CtL14uYa7ZUipg79bTT
	+6AtPPXHAAomOJGKzlLcALQDvj0lwdFLr73GDM8u0njL1ETcD5Z1p13mFgTBjMo5
	9a1U5ejCplPKlPjW6XQac4t29WJ2E5AtJjoEWdi980T3Og1WGVoemCjMKGlCR/yv
	a5JRkU+0LYl0Cah2pJJ+rvYtyk9jk3L3PebG7Z+OwV+Wsk6ESPlCYr9CiIKqt9a0
	t8ntakhK5WM1kBFYAVCrJyZ+QoHdIBaoFjKgNb7LE0sUqDh6JIK8CwLN9WxCSD6h
	bsnsoTIcONHRYy0K3Gbdt7uMaWlCXvFwwww==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792767646; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:egdMa3WFV210K1g2IfAK/z7Q4UbJRLqKDIv2ThIPdui23Wo
	OCkJvJ6fPMmyG6bi1lW0Y29NcQlhvtoqGK/yM3OcQVS3S6fYDe1EeOhLoRh1Yqcg
	EcQzA7l9WTTKKrSwIlle5e+TYVgagLM6Qc2U8Fxl6XksfhkJdhI0OvZ6Hp00PPtb
	U6Dv0i9lsr+TWAABFxI+Eb4jXd+Dngs7XHWUE4hGK/Iksr031XZ9Sw8IowCNiDFW
	dRVvhA1P2NMRjHHGo3bsTpMo+iX3wwSp4A74v3H7pE/EX1vcWNgOLeluoCfufmSO
	uMKn/MCRZGgYl0zbTvFtGZQDMaCz3iENgf1fEFg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:WFtNzQLPHqPwFqz7xKsmABV+A5VuLB6Yk1uhwh7aZfI=:oYpvDn5k3Zl2DHd7uKEEHdBs1j3WHwuIqtTcxZKCfEc=;
X-ME-Sender: <xms:nnbbatHTfQUwW8rSUs5xNhTeaioqq104hD5th3BShyw0jx7q_adoJQ>
    <xme:nnbbahbx9XO_xVHO0H3LSOsnlz3iH9683GhpjBVqXDpO27xgMMhMZP7Dfm9yp0w7X
    h_qzWhrDIWbBkG0aFcfnaz6SB3km3fck59YlIzn7XMt8W2NqFBioQ>
X-ME-Received: <xmr:nnbbalUoJj5VoCX9pTGp-IAkpF09rSADh68nTb1kk712H3st4z3KfJ1GXmQhYEw8czmwg1JxYd2YdWFPCYrPYgQKIfiY6jC2gGCK>
X-ME-Proxy-Cause: dmFkZTGUQvUUqpFsat+WQhJfdnFXypPK3AWKzL9Kg05b1rXtDZwc75S/oHIpc0osbAShKZ
    +XcCn1XmcQqAisNPezQl6Fi7cf2TOxUNdnxldzVtwnkQ4A8HXD8lrgBMd6rW/mpWg2z5nM
    mp2BQgbZ4tdVUZ1fjP+J6NY9YKLTazcOY0x9/mvv8+UKyhoyqYedLeP6fP8EyZY5LlM3s6
    sE7V+8cHPOZXeNCQERfWL2c6aQ1BHOR6s/5WBB6b0aT0xdjTcxF50j74uy2mynFdIzd3fc
    jp5wBWOX+a0z8isWyULOWIhjM1/2oy5vNOglhxljW2y4VniiOYFh56zWclUx2CogXwqjcP
    m/2QstbnsdylVc1R7QYSHvNHhMoT/mn0wYR/quuRGAK21+uAGKaFRySrL5AubyiHrdZinq
    YS2u900ZLLINK6J0uaG+Zl6e/fwkVweXsBHVFZg0JNwf/NLIE7JtjwRBlfzwTKo1vX9onx
    O6jKECm/Q2p1c2buG5iCvK3/jzChUIOBz8HySyHT60NWApdMEPYLKSmNcH0KxbaoxuxFbi
    v9ZtmqZPhWUUuyfdfOXdpU2NGesZPjEjetTv92VZzGy4M0cQIg9Vn7xZQhyK3TQoKOsS38
    sgFNSQ1/GlEma6nhhJoFM7CmPa95aaDA2racgbGr+NMhQ6IStqaa7kkZqyZQ
X-ME-Proxy: <xmx:nnbbavmnwBdcjjAgQENVS9QmtWice9suxmCVWwgeMoPSeJnsVJjAZw>
    <xmx:nnbbaoDJuyOiX_5AfmeIIZIW_B6SuoVW_-a-M1tUwbCQpUHufl_LWw>
    <xmx:nnbbamjJtZDSBhKIkULs--jYeHksojijXzwhb6cRijb9DTGnwQm5jQ>
    <xmx:nnbbatyB_U6EbBcYOu9zFabZAw3Io0qMDox8H4xP6st_IKgb0V4EFw>
    <xmx:nnbbatRcVVkG94lW-Nbv8ngbfS_gMqcTpJTc3WaicDe7en3fa5smD_yC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 11:00:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Elijah
 Newren <newren@gmail.com>,  Jeff King <peff@peff.net>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/13] SHA-1/SHA-256 interoperability, part 3: pack
 index v3
In-Reply-To: <20261023072559.3204273-1-christian.couder@gmail.com> (Christian
	Couder's message of "Fri, 23 Oct 2026 09:25:45 +0200")
References: <20261023072559.3204273-1-christian.couder@gmail.com>
Date: Fri, 23 Oct 2026 08:00:44 -0700
Message-ID: <xmqq1p9gbgwz.fsf@gitster.g>
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

Christian Couder <christian.couder@gmail.com> writes:

> This series is the next part of brian m. carlson's SHA-1/SHA-256
> interoperability work.
>
> It adds support for reading and writing pack index v3, which stores
> object IDs in both the main and the compatibility hash
> algorithms. Interoperability needs it so that packed objects can be
> mapped between algorithms, the same way the loose object map already
> does for loose objects.
> ...
> My `Signed-off-by: ...` was added to all the patches. AI assistance
> (mostly Claude Opus 5.5) was used.
> ...
> Except that I added my `Signed-off-by: ...` to them, patches 2, 3 and
> 5 are unchanged.
> ## Changes compared to v1
>
> Thanks to Junio for his comments on this series.
>
> The only change compared to v1 is that I added my `Signed-off-by: ...`
> to patches 2, 3 and 5 (that are otherwise unchanged compared to
> brian's original patches).

Will replace.

Next time please make sure that the cover letter for a new
round is a reply to the cover letter of either immediate previous
iteration or the first iteration (and all patches replies to the
cover letter of the new round).  When you send a new round as a
new thread unrelated that is unrelated to the previous round's
patches, automation will not quite work well.

Thanks.
