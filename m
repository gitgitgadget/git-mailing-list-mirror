Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794190906;
	b=FuuJiLAcfb2ON6dJ35olgLfpLpKFDx/J4opUvNi8F8LRx+cc1bQ73zyLdECb27ZXP22p
	 scQrQpAh2xUs1wgay1XnxwH4ovmJYR0W7opJE9WKxMt2CM/Op7FBBNNf+uCY4d0jRcJmA
	 DjOk3nfqiUI6/E8F5+5QMTfaLM9F7kQJriOkgyptAORgXr/u1QoJ+K9ofELpsYKJURKrz
	 KExgmdh1Z9pC36kYUwjcLS3c8rvVmWgGyoAyBs3+ePyZhfprgkKa5bk4dqYsZeMGTTawZ
	 axO4PI1HJFtumpUTI+0RohWq8zi4i0a932x97Xrcr1p47n0likTEl+E/cGrfhTj55zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794190906;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=aSm3Axrz8BW2PY8fhAd1CVzKLcMIUuxrD+oShNmmHbY=;
	b=4YfhX+EPsNSovCgfMXt/xn+8SfsvHaEFflPYCNEIBITAxA1IM7SiQmR9Cq0s42losy9X
	 503pix/m1djZDYeA3ZL70goQhHR3iFufMBFvzD2nqBoJLqOjhlGTb9G/+xMD01MTtUeng
	 2t+HcYpDil/LyaA2MOdfjJKoXNlxVSsdsx586MSrc5wzQUGiv98fH95lNVOeeYFlwbrCO
	 n/vFP40zgyfZa7s+wfLqncr+o6QxHL9JEC5MFL0R3qESqbDc9jCwX5kJQJf9c9eBhrfRX
	 8D8zkJWQDSJ0QvG/O+jA9BSwUvMymFzXIN1rqHktjSsMDSXsNAKaMs5YCZMXVIxnOrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=cpsNsO4C;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="aSBzz/Cq";
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6515B606A320
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 02:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6515B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=cpsNsO4C;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=aSBzz/Cq
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 87F80EC0074
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 21:21:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 08 Nov 2026 21:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794190905; x=1794277305; bh=aSm3Axrz8B
	W2PY8fhAd1CVzKLcMIUuxrD+oShNmmHbY=; b=cpsNsO4CP1+zvMlna/8jtMhUd3
	+vKJ2c6PmLS+FhkkTHsxomtVlpRyfhE/0nai4Zu4+8u5YL1YZWgk1oDZ0ggmLhw2
	g2ZuTg1WWuqbrDKUO1AXZth9hFZlaBXn7PCWRw2DnxlkhicLO4jyXHiAT8ACEASA
	3HrFHPvkCXEg740Vtucc1PvpEEtsQ40I2GcG3mvh0D1I9/yxHvpRQKeMqLKBrBBc
	ZumS+RC8F8hyCj3+JZQAaIsIu9eS781ZKS0EWOcFsrcPBygjf38y0EBa6Yvs1m6v
	348Q71+IKenJx/pOozDz3DsIwHNOEt4S8Fl/T68JL793mOmVQQ3rspIEKi7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794190905; x=1794277305; bh=aSm3Axrz8BW2PY8fhAd1CVzKLcMIUuxrD+o
	ShNmmHbY=; b=aSBzz/CqkVKGdUYFqfo+uakt/gl+sJScvSFmGEmJg2+r9/u7muN
	yRjZPgZk6/Ri7dSHGWfOoyGOSr/8oyP6pM6k7Dt6sNbfLEBBORhGaZhGGpMMJQt0
	WL5C/6ig+0jwSazqPAoiEuuVTBBGB35AQsEZXKk3puL8zaj23G3qI+sWDMuziR3G
	/hH514j767uOjaAxlksd4OAM6AFFrrWmho6bdHFcYR0Uf1b/erDDa3AarWh6e1v3
	Ifo6MKqE4yW5PcFBQGelcw6PTm878JySl3r2xvMv8ppPlXNDq4taaXWlDRyjiWoh
	72eAN57mN8oR5wfEoLcfiYLjjWbIRzchfzg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794190905; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Xk7WuOTQcWI/zI35cCGvha+2BgyP5O97/cf/BhyXassWb9z
	5GOv+9tzaM8Bq8Oc4kjBaD+nDO9ymUYs0Dp8Zyk5I2WEu6vlML3JMCiVtRszFjuR
	IG705Epoz+AeQ9QPtac4QKam5TO9ZhJd/rp9WOSUpgPxD/EqKRxuJAwl0KuRB6sL
	yHuyttBlnYhvGS4GbEHcjDNjdimEhmEsSBmPbKqRWjpllSOXD3r2lTuwjjdpHIQI
	o0xI2aF9KUSg0zsLohaT5P2bgXPbgTGsesN/3u5TbyS/UChZX+HqgtF4UkRL1tYa
	0yR4dOS++F4bHMrXPyeOv5O/XTfV6wO151O5Ayw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:w1PbuSEU4ST/PGIQ/QtKb2Y1ZGzw/1wJ2e73Qse1/NA=:iKOJFZiF+xi1UOGev0U9SwGG+mEchcWUI0Uf/w3SuDc=;
X-ME-Sender: <xms:OS7xapKI-AHTawE8dkDiqUVb-YCmggW_7Vhi9L04pxkCqw2F3jTz4A>
    <xme:OS7xasA4Sr8OYJ-jB4M6hK6GgH8Db36z6DAwec2O98pitJP6pH3LXP7b3VX2CmeJP
    5aDa7fEpv6KgZ2vklptTscRZM8eElADZd5AYNlKVtmAEw18faC9Zg>
X-ME-Received: <xmr:OS7xaqA8qZWc8xvBuYcz-bIF-qrbxtctgg8bYP5lJ9dg5-miYfCOC-5fxU4seAb27cI5PAkPpkArkp3GB6-rHQJ-CLLzGGgo6bsp>
X-ME-Proxy-Cause: dmFkZTEu++D2LKCJZEEEQGCl1IXRpd179INPeANACK4ECvBfQOucb9UboUua+WWjzwV000
    xSTeqKbm26c82FBVoOmfB/98yx2K4HYqjA66fG8BMd/bnJ56Gi30ywOxO25qkOk1movHDf
    cCM39+oKdJhTHd+ffoxLd6T/z3l/UIr2NSmnVN/dh+iAP0RFNy+CJFGxm8tl1pYMZp9lXS
    ROH8nutLMB7iK/0q4lSO73n4KdbwQKw+eOnTcVtjEre6S/I3WzAjuJRQef6M+cedu7Yq7W
    l2KV/n2LbgkseVGY1C2R7lEhOPfzMWZ2VHhWRNuFDLlo4xaq5cn5uRglDMvOxnKVTHhAFn
    EG4K62GiVnZIH1J7nI7HgqWKRQ+h3/oQuo/r50a77xea0OAQs5jnudvhWgB5ASmS7UU1UK
    vaamdukKuK2mK0B4UfYco8Um+f2EYFT6a6I0IhqCGfsuqdlPxO4OcrvLNEietFUmoR30tC
    6mfcMnEE1I7y8cqTL0uhUuTB3trTL/+5aiGQa7ET+pQq8iNXkd2Jjiq5VMSvKvhC2CQQZt
    bZPg5IaO65s/Ni2mw7L53iyf9Gwddo4zbFtZco6unhz4CBWSRxLKkvDrV3mPtD3zwKh33A
    Vjus8agLOGw+V9x3V0T9dypDXcX2mRhA24pPMFRTQxo1NEa9EslP9b7b22xQ
X-ME-Proxy: <xmx:OS7xamC6p-7FWCnSGz2WfY79Zx5RAn9SRjKXW66L3AIUXCIaQLQ9Uw>
    <xmx:OS7xatpXcpT0_FVdn9EYKCrGxLTXuB4ln6HDxtK6uoba-fiYVf4Mrw>
    <xmx:OS7xaomdkfzF3yro4Oa5hR8pDta8JOLlojRUz108O7W2RSGWFvHyag>
    <xmx:OS7xalxxDry_CuUaUSOrWk5H1YsIMD2jwHQXGWT2gdG-bsDhe7CAbQ>
    <xmx:OS7xanW3hAQrzO9S8jZIqofQFHMUu9_W60VGyoNsi3RpJRTCQPmgtsl4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 21:21:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Adam Dinwoodie <adam@dinwoodie.org>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH] setup: default hash algo to GIT_HASH_DEFAULT
In-Reply-To: <xmqqik274201.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	08 Nov 2026 10:22:22 -0800")
References: <CA+kUOampvjU3=VK3VGhYw2L5-E+LBsk=Q0UrAxhhR7hC5SUdJg@mail.gmail.com>
	<20261108011633.1772000-1-sandals@crustytoothpaste.net>
	<xmqqik274201.fsf@gitster.g>
Date: Sun, 08 Nov 2026 18:21:43 -0800
Message-ID: <xmqqzevi218o.fsf@gitster.g>
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

> I wonder what the "git init" command does wrt the reference storage
> format (Patrick CC'ed for this)?  I am sure we do not convert from
> reffiles to reftable on the fly at "git init" time.

I looked at setup.c:repository_format_configure() and found why
your patch regresses, as well as a latent bug in the existing code.

First, REPOSITORY_FORMAT_INIT sets .hash_algo = GIT_HASH_DEFAULT,
but read_repository_format() forces it to GIT_HASH_SHA1_LEGACY
when version == -1 (no config yet), which is why new repositories
kept getting SHA-1.

Second, unlike the ref-storage block right below it, which checks
"else if (repo_fmt->version >= 0)" once between the explicit
overrides and all default sources, the hash-algo block guards only
the GIT_DEFAULT_HASH branch (repo_fmt->version < 0), leaving "else
if (cfg.hash != GIT_HASH_UNKNOWN)" unguarded.

So init.defaultObjectFormat in ~/.gitconfig already corrupts an
existing repository on re-init, and an unguarded "else" for
GIT_HASH_DEFAULT falls into the same trap even without config.

Instead of starting the if/else if cascade like this:

	if (repo_fmt->version >= 0 &&
	    hash != GIT_HASH_UNKNOWN &&
	    hash != repo_fmt->hash_algo)
		die(_("attempt to reinitialize repository with different hash"));

we should have started it like so:

	if (repo_fmt->version >= 0) {
		if (hash != GIT_HASH_UNKNOWN && hash != repo_fmt->hash_algo)
			die(_("attempt to reinitialize repository with different hash"));
		/* otherwise happy */
	} else if ...

so that all the "set a new value from different sources like command
line, environment, ~/.gitconfig, or the built-in default" would
happen only when (repo_fmt->version < 0), probably?

