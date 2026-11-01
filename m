Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793568462;
	b=wrIGDu/ZFjjtoKuy2iOMeOoH91UrKUg6Mvx5zc+ONwme4nGzu8WR8Sd7EgyMFQkDHA6v
	 Qmj+kb6HojpRNZl4VNuP+d4B2LN7/6tlG9xHuxxhBBlo2LEnEftF6me9JMDZ/Ss8I40u4
	 rPtPQahL+ubjPGlsUzdOaDqVZIHYS74yIp9rW6k9JJwlemr1+PtdL/gtbt8fEyGTG2Wxa
	 +ZWX0BKqJLXxoE05qbaPJQyohy2UBV7U2aDC4ZXxoR7kqYgL0D7I2C3SoRFLnuO1es+am
	 Gwxgee1xfX2bE/z0nrIv/EZ48NFL7tzt448JZqc9coiDPE12696zn+LQuPSX1hjH5DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793568462;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=dRuyPEBcD2fyBhJlZ6Op9XNejSOBC+DLNxSB5VyoUNY=;
	b=mi3KXs4BH+iERpWkSq77Hw9Bu5eEVObZxZQQAxBciWYxBAqn9rA8OtTHchNaKILjht4M
	 FYjWkm1jBXgkkTHRMB7pZwn+lezr7Ye+sVtloRoThOp5ckaY4jvHUaMHBxFWrFoIpBh2H
	 dmSrJ7/qnAQ3RNZHnvAwbkIKcQxCJXaEXc3wlDEWIq/W2k8bL9P/snz6L1OtOova9HaH6
	 ZSlIf1Zn12pPJHiYO5g+nTT+dJotTLyVm12WhU4Td25S0KakrglYqitfs4HR/3I8DSs7Y
	 nJumCl+gjhMr/6griybQ+zboJVSlvbVw40GBrOfT4CwZdKOyC3HUXT+FlnAKgbuA9ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Y47cMcER;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wrHRstKV;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F176606A325
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 21:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F176606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Y47cMcER;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wrHRstKV
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C1513EC01C3
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 16:27:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sun, 01 Nov 2026 16:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793568460; x=1793654860; bh=dRuyPEBcD2
	fyBhJlZ6Op9XNejSOBC+DLNxSB5VyoUNY=; b=Y47cMcERcYabv6B3sZjVeLOjXv
	HrE3JMQsNIGKFF8IDUXCP9fVyxWqa2jRyU0/qFZmm/8crGEESsnjsmolihn4+THp
	NuziJXA0fyar04pdPCNuEg7NV0sjKw0p17oq2j94zo9P0uNUpnneWXPxaK/UccRw
	s+5AxNi+2f5mYgDEFTBAKyApgx1Vm1Le1PT1VCO51Gs15CBo3gWyMLUAY9SLur0m
	/17y9xBU3JOvKD4a73wGUfuLw9lYIcacJoP80boZLLG10OGzrerUyhLMvuwBZm5T
	2JN4fsa4DbT7fT0Qd/xlyxXLcCwOUOPl/n8v7c8QSI3lDMOiPyiu0oJUKUSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793568460; x=1793654860; bh=dRuyPEBcD2fyBhJlZ6Op9XNejSOBC+DLNxS
	B5VyoUNY=; b=wrHRstKVhsZDOzPHRecvMo8nSSiL7VeeydvHvu0CNK+ZPOMnO4Z
	to5r2xAmaEbRwWkBf/E6xDEgRgN1IJZMQ4aKd3O8xBcEKvk+22OIM9IJ1yjSznXa
	v3u1Fe66RMkH8ypyjM8Uxul0VQugW+pkMCxT0Iu9aAJAZmP0spyxRDKpss2E/IWn
	FKpTjThDB1eA+OHHK74xSJ0nV802eJWpj7tCy6UzxMNTiJ8Fwk2R4qX7uopyQXqC
	+3/l7uEM1FVlOvbXTU+fnwYXVacESraZ8tMiGIs33d9Iqd5lUxU8Kw1F9xRNpH0R
	7HhASrlCQii7Y/uJuTbU3LFRc4VpAP+Anxg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793568460; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Y4eyxA3ai0ixfxycEap36y2J+YS40a/+b+5t0dwo6oldnoW
	/r6+EBwIBoD4mc5LwiRQebkE11f2EtcjmnrHW5r0djCpDDWPeYaph7wjwfqXJYWt
	V88azeEpdISPyykWY9j1zJTus1/vleFFb5qWg6nMac1FzDkARJZE571Z4ZHJHuCs
	gSv76QYVkRfgfrnnE6M+VDEdR3lzKbqQnQDZPxYU4TM/7onh1gi82AKb/k/2rK+1
	UtwygQEE1+lHcVVv+9e892t1UyR9NWHvuF6zojxJqgb7+rKV7sX23M/Uwd13KBpw
	lc+HnOPLED41LTpiFe2tnKFD6Kc19KxNpx44Rgw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:0qdeDxGdFBya5Bcrlx+J/YiKtranERTzxlgGjScj7JY=:dRuyPEBcD2fyBhJlZ6Op9XNejSOBC+DLNxSB5VyoUNY=;
X-ME-Sender: <xms:zK7nao4dcsIcO9nFAaPuCWLnGT5Jes84mVjne0mxmWS39T_lbAuzxg>
    <xme:zK7nagwQOc8l60mJnZvtjc1kjazmB55KbmpBpEWAxU8DbxJsh4EATpsDVwaiO3jak
    45Gq8rY9_P7BFO55rL89rzOvv3qnD8zQkAqxYGZEcWWRWYcMKTj9SM>
X-ME-Received: <xmr:zK7navwv2VXhwuncVuTN_lD85-QSTf8-BrioW_2YnDLlMRZUpKwmwIdHGnXA3NdQOQGzSbO05RVo7q6Faq2YCLzlYGRlBCv6N5Tn>
X-ME-Proxy-Cause: dmFkZTGzxPEHp3VsCYaof2f17r7YufQ/n9+PyXtFd7CWLc8tSqEQxGVvI8WVKdTPZSdAg4
    i10p3o8ttrwsM21GuPVj12ig9v1d7jgqttGLJQFvuolYtLP+dyXvA1RMGd6EV6i9bBkIyL
    yse9uh/TPgdBSK2kQqyBu4YFK8QNx64ryrGj7iWbuXuaRVPALScZ9uQOQADe7erb/vYPGL
    eEwESQmvGHPpniQSFqn40dp1WIj5dN0S9ietjbk8GnzfDh7S5vQsBmc5+O8sL+/gKADhoR
    FKsG9wwC0RhNWmzPV7rAbIWMN2Zv6y+ThtyOvRPLETzhxTJ1kNqczK/AFwMs6zomFwvBk8
    bXR/fl0p+16HxAwDKgTqX7V4bb4LaFqVTrd/FczQwJyg/UJWyUnxrGqqSSkrKywGqQhPcG
    9KKU48N0rt74tICbyu/u5XPo/i1gveoKXMZboRnZg7gcb4c5FviOBwOt2zP5bTMcw1jXMN
    QC0jPE6axQgMW+ZqRBNGFM6ZWKt2+KQkCG6s7HbQ+eqRs3e4GccEY5sD0Y8MdhSaUG3ED1
    /qOKYvb/8jPwnsri7+IPpL6HFLEXIqq5m4DpprulhKevsuahk+/3mKMlyGTKgdaU2OrNky
    AVxBw3W5/tLY384XbTk4rrlsgafv8tPQ/sP5wvfLfa5KEBkjt5EBkEPNk3QA
X-ME-Proxy: <xmx:zK7naowAh_iVrxFYPtrJtvodecma7BQazHnDDOpFtf1A56-spAbQjw>
    <xmx:zK7napbAHjopLjY43tZvzpyXUrsKDWeeuBGTUr3AGkvmb-AG8lEilA>
    <xmx:zK7napUdYwKKLVIZ8ycIHUlHH03uIjBsn8UEsny2TEYNK7cn5WPIyA>
    <xmx:zK7nani-XOKgN_6y-cJ_md_FXSRVXD5hmmSZrta47Ky4I8D6GS8A_A>
    <xmx:zK7nak9vz2Lwmf1rVmb85_NVhSLpusfIrchiy9BTVT2g7ldLH-MHbaCP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 16:27:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org,  ps@pks.im,  sandals@crustytoothpaste.net
Subject: Re: [PATCH v5] move rust gitcore crate to a different subdirectory
In-Reply-To: <xmqqtsm0z2v9.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	01 Nov 2026 12:57:30 -0800")
References: <xmqq5x0df19l.fsf@gitster.g>
	<20260917060415.2986259-1-mh@glandium.org>
	<xmqqh5i6g3b5.fsf@gitster.g>
	<4brq3bxkdq6ewviznwrg7uqgpp2j6xf2bladpmdrpaypcjp63t@lqfpwwagpbss>
	<xmqqtsm0z2v9.fsf@gitster.g>
Date: Sun, 01 Nov 2026 13:27:38 -0800
Message-ID: <xmqqld7cz1h1.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> Sorry, that does not sound a strong enough reason to keep this one,
> when I am trying hard to keep the number of topics in flight.

... down.
