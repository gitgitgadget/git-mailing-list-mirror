Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794886151;
	b=G9qigOBZQKEpN5GlQOi6I5JoR/A82tRLwaC37I4nwv8Yr1TRkZhuQBpy7gvUGrE56yht
	 S9YTkHQGcdtmQsWMGtPXgJWUe1hZpz6Plz1VNdknxWS7WjEYCKcMC1bouhvLJxwddXC7L
	 39pyGyS4QdfUkoGYKXypxBu04av/wQVbi/nck0+9liKQP8+Vz3OH4ra0ocfOGqBqJmvNa
	 g5Him0rh3gNVS5x3O9KO+S9BPiahgUgyihM4Yr3739axQl2Z/Ruop3uxQFzuDG55ZGztm
	 olAwDVvrY2UlmqZafw1tVMP7OO0tOgpTgQ4Rnmd0D7a+12ztTwEbcQcYAiB0oYqeESw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794886151;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3p6AgG5OmvNUdmXAAgSVyKIhrOzBW4xc6J5wkOUyceI=;
	b=2kSDaRJ/gmkat71MPMdRnKaTOeuOXBZC6ONl2AHmRe/0OCgq/j5y5RvQNWnnr5YIGlTC
	 erlU9zwzq6DwWiEnFgsCdgnYy5Gd/4Lo4whIprGhXH0aYXp+yAgaJsxzDlRocscQBoPeR
	 SD5Lw8LYwb1zvNBDR1m3tzbuvS+VVbA5EJxVdP+Mou6YZB1gF0QhMlAPdWqGwI3xqm1sr
	 y8Bekf0L9d1tn2b8NrhAEbI72kb0pxz0TvRyYJYp/gszn1//yKZY1mwyAdfzOFqQb9mmc
	 XHHrgFmy5vXEBiDs7Qm0jLndR6n/awSK500ioO+A+oimRVkXcByjWaK2MUTblvJbh5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=DBcDc6nA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="D+6yO/0a";
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87B3606A88E
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 03:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D87B3606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=DBcDc6nA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=D+6yO/0a
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 02B511D001A3
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 22:29:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 16 Nov 2026 22:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794886149;
	 x=1794972549; bh=3p6AgG5OmvNUdmXAAgSVyKIhrOzBW4xc6J5wkOUyceI=; b=
	DBcDc6nAPFpEfojGRzjK1JkKmWnuxcnajtfPC/+JLHsQqw+BnStUz3M6Hs8Ovxap
	gm0KM3RPVHy1YzwT0l6ag0zUdAgNxg09ZmptOCzcUnw0JV1ScItiO1r1gxupnKOr
	hLel+EgvM2pjbp+BrTCvB+85jbtgIYl9Ws/D0EN6ARqtijLscpZr2s+hgNkSG3eS
	xZUhQUT3Kfo3rbeSjLuq9Nc1u6tnJtNf39s+KhMi1lHe894Ms7p2jM9qgCMkPuZF
	X6eGutQKSFlj+r19LCTlxseeSSZVHtYYAu8JkQvejgTlTCPKbBrZX760LPPBKVs1
	xvV9Q0Pl9G5ahzOBYMHn0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794886149; x=
	1794972549; bh=3p6AgG5OmvNUdmXAAgSVyKIhrOzBW4xc6J5wkOUyceI=; b=D
	+6yO/0av3ZTp76WdxsuQrjMGA6OmFmltfrU9sBxlKexgLmbe980vC32o3xfu7aRP
	/3c12tCFgOQ1W5BaWpzJKaq/E7r5ybtofGluLQfWsm3Rpmzw8/VfR2X6CKZ0Nrjj
	QlX7IoC0oPMUgcb4GmNDb9ma25PcciKdxFkFoHO2wOk9yEezH+cauwliELnYMufy
	9znW1jA+AykkLE3tJ5Ggx1BKXfg+v+gNI1yN1xfgjgkaU8nxlKMG2FNxzerAUt3h
	RSYDt5ca8liqnujcYGk+Ng6FHXsZ2oaplPNC+J8TWvGROk9nDrQ1k9ODY56syBOV
	5GHn9tabsXiU9KS/mGEWg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794886149; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:X4O+Uj69O8fzWegp3EhAdsOB5hvz9VLj7J3zWlT5ox+2puz
	oI7j/1kLUB5MZnQyllur1f+0taa4rAw1dvTwGS1lWyWYqo1Sov2XE1DkMV58xleW
	I0o2YAD1wV5xJ2E5OW23VimpbrzSOsKmMSabF+zGdiDN3VRDvYY7RQ1cLOCeOccI
	amf9HqE9d24rioXTzJGX6j86hxbWIathIzbjWOIUl4AgCWCOfCXFcOmxfnKi7Cs2
	MvU3OwOeAGZDKlxKi0vWLfm3qOoVpVk7ruGEPujzQ1pw9+IHoDJGMJ9E4kHaXrFm
	0eo1/aGHmaC2SXJQCRIvTU1LjmIwFpAnAdOs7gA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:2Wwu10rs06mFGe8HAnwxCGxipOI6X7YzkrteR1Ybzow=:S173rMpNk2eFOhqIc5gbmVwuPk0FBxEZ2uRxBkVt070=;
X-ME-Sender: <xms:BMr7apUnFD1FQNRjsg0sgkHCuWo4uhkktAHt04dA2BMSl2Kym4DpZA>
    <xme:BMr7asq59QDMKddKgCcGRqFq_LwPzcDeGHwNTLLckr8PQsPPYFkOrWO7S3bPWlb7D
    HNJtgeC8_CMRJVm1Dr9vOJkp8rZlSAcKIgjRz0h1Zu_S7unVvdO8jc>
X-ME-Received: <xmr:BMr7agBv4ftXUi1ctlCG0hv9N-Vo6GXXze4GfV0UUHfQKo7XBDnxJTZ6jzoEW5LYtI-DT-9YWmN2B2px2kS9HtwiyEHgb6FiGpSB>
X-ME-Proxy-Cause: dmFkZTEzTTnLDfiCTxOg47IChh1ylt+oUwyOaQ0kS5jBht8Ob7idnLxIJ52BbXPMgxtUqa
    clLyrpC04ySLLIYBGGTAvP14OCB0+LOD1TY9iLqY+AsNz7ODaik5cp3l3MZCJUDKdiCRg4
    bbthh9ADPT3f3x5yns1eG4tGtOapvWiKIpEpajHWZPNEp4HsAeCE+oMyJ7NnXEdlU5I2kP
    KxJ7glKnlis/6EtUhoqJ+EuItkIF/8tTL+oPamvmddMKZoYUxpdnkq5wZfZ8HGG7utywyM
    LMe59gi+J/OVPg0bsHDJIMY04BdI70pNRYSHVGjojKiTS0MdhySYpgHgDhI1oQqKBMDAVx
    e5QMYp488jpc5yuQxWwENDhopO7PvjY7re9QMO66T13rAK39t2n9lX1WGSw/WkwqcbeNGH
    e8mw+AiXn3QsBy/48IHgWctgS9uPDArMWFD0DPQPi9N1/9rI1/8YQzblErv6nZXwVgiKBA
    oYX7s+UPKQdZnRWPwCUSPsGMQAdX2aSVOws1FsUCa7xjlsVsR616PuTqcpwXv2TqPNBblR
    cY5/bsF37BSYhnWfQBsNMbpf5Dt9EXCcJYXS3BQVAI3kYv2tTXR+/VyqxS7aTZ2d4YYM5X
    OPFYG3hC1Jf9NQIYJZOclI9oGS4GFLfqU6Ih+WkH5nJ3P6btXpiquDI+shDw
X-ME-Proxy: <xmx:BMr7aoi6uPViTHzgBWoBRufiZRVMCsQW0rvzIAC7QGp6trAIu0r_DA>
    <xmx:BMr7auYEXhAmCgX8sgtqnrqs54LbD9eY_7J9TBI9U-37xhAt5EQGHQ>
    <xmx:BMr7apnK6Crr9sCr5DqM9M_8rJYNAA6F_SolNlE3OaQ9JgIGD6YAig>
    <xmx:BMr7akh7qmeZLqFRFaDAOdmzes8ZdkAIEjs0f3hgpVOeAfG3agyDlQ>
    <xmx:Bcr7aifUMPS6zhcwQ_ahIux4Tb_PByQzyb7-R7CQMpZf-yYdJ1jFVjQm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 22:29:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Jelle van der Waa <jelle@vdwaa.nl>,  Karthik Nayak
 <karthik.188@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Harald Nordgren <haraldnordgren@gmail.com>,
  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [RFC PATCH 0/2] Support --verbose in git history
In-Reply-To: <AC0A5AE7-B385-444B-B341-2738992D8C77@gmail.com> (Ben Knoble's
	message of "Mon, 16 Nov 2026 21:33:30 -0500")
References: <734e2ca8-e01a-4204-9cd3-a09a8d097f64@vdwaa.nl>
	<AC0A5AE7-B385-444B-B341-2738992D8C77@gmail.com>
Date: Mon, 16 Nov 2026 19:29:07 -0800
Message-ID: <xmqqik1wgmpo.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> Le 16 nov. 2026 à 14:23, Jelle van der Waa <jelle@vdwaa.nl> a écrit :
>
>
>> I'll spin up a new patch which will drop the --verbose option and make "verbose" follow commit.verbose and make it the default for git history.
>
> Even with a config setting, we’d still want a CLI option to behave
> deterministically for interactive use (or for scripts), no?

Absolutely.  Also, isn't the opposite of '--verbose' '--quiet'?

Or OPT__VERBOSITY()?
