Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418641;
	b=OsHMWyMprG3aPj50W4Ym0PkSoMQVeMBUiUC5xKyUeP3qbejuCqpkzNnQY/y9SXUS6xUY
	 wWAc3pNOY2IZ92E17kIzbJMxZiJ/7A/M6G46xzrYiUunVDW3KH4cdhmexdZp0CA394lpo
	 5uadX5wcMviumVQzlsDHbuT3jmEPRCM+zs6AwPdlbwXRIEpVbYuWXyZRpK6TC2lu/J1yA
	 MkBPYnAcHUD8ki0am8UjHQdgkc+4ffw0JQJGf2F9PHNPqtULbSEMGqzjUSGV5pZVN/RDK
	 bcLrxAf7OczjF1CSe6icq/aUzpTK+7tI/REtKLxqS8nPHgnP5/QAMrw94wwWgjJh07w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418641;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=QPmvDObCx+B+mQB2V6D60foEST3qZ9c9Nw6LG01YZUQ=;
	b=2K8EwcJ6KpCXoNG31snCl3PCXQpi/vpV5+iowe/+Q/amL2pW5PtxOauyGstLYDZ3DBbJ
	 80vUSMntEotDGli46gxR1JKvfbQIXlvY6lSkZ9k0emtVwRd9KVi/DgmIACQo5zhfQbP7V
	 yoAzwG3U4HTJ++skoRjy4uHE3DjKaIalLb36iSg96PLTDqitI9YvnzBOUCWriBl0l5031
	 cO4Z6oYiWXqfa2iScG0/iGxDVmtO7xxLJ5lOmYP8TNgRi6Jk2lyhXytoB6m4ESVojeJMM
	 tNpj5Xc7j91X0rXALcVqF7oM5L9/y8oGcuelTdZjqvVGLoKiK289MQqp/cprLOyCJmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=A3GBd7In;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QBOvG7K7;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E1606A31C
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 17:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 938E1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=A3GBd7In;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QBOvG7K7
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ABB241400177
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:37:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 11 Nov 2026 12:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794418639; x=1794505039; bh=QPmvDObCx+
	B+mQB2V6D60foEST3qZ9c9Nw6LG01YZUQ=; b=A3GBd7InGqk40z5qllPyXh8MlR
	R3TeNw12Q3sZQ1W32+h4g6awkLtYeaLD60fC8p8nZqWhdywKv6ixwJgpg8Pxs3cr
	d8zaEJDqKclH01qeTxpgo17OcN84Qv/V0UtzbL03X2scCz2Qm7B9bx7axFzdJTVd
	8fBOsVttGW4+DwNOUqZ7oBMCyV8QIbmnR5bBkL4QgmraVlDHc70ByG/SV5gJAXl+
	gsgpzjEL1JEjzLHMgQo95tbpYZ2q5Xe/YuqyNceqfs/Fjxrp5Myt09uKXUyIolwy
	DY+WsszIadV39SQ7Nal4oBuTGQbZssiABlqpoAYUlhf/J4PZ8Cfq2r5ZWSGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794418639; x=1794505039; bh=QPmvDObCx+B+mQB2V6D60foEST3qZ9c9Nw6
	LG01YZUQ=; b=QBOvG7K760tfRZkPQNh27D9Q5tjB6r8lJFySvXHwCXqAM7o8Epc
	CgnlKtz7DxXM116cYNZtLzQd/f5AxQwEc6lw2eCi6UEMPr9JUxSE8g3LMI55nYTc
	Gdxc7pYZgWCmf1vGcTZSdffdznKNgtbLnOuYQY8j3aMGbVyOV0cbvAG/Y2Kh005I
	gy0qVV0iY1Ui3jTlGy349fzjxZYlNF3ZAE0haglpvaxWA7zhDUVZbT6nMzOVCsuL
	mpk71nVt+3iu6CK4oe0ZXQClsiiTaB5fUk3at0k7/FdDH/YBxcsO5AB5wndF+NgX
	AYU1FJ/mFIg97zAxxF2IsUx2tV+X7nAkZCQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794418639; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Eg+N0tPGDcDtQW1qKcgQcFyetFMuzydg72f90Tcn+20x35I
	SE0zBhefxmH/Ym5Q9PsAqtvBhjocidVUhiv8ix2ikN6QO0LGT1GBxdMoCxyy716q
	WQaIO5wen23p1l/Zz0XqMHdiunOreQhinbPXkGyggwmImnaUOELrS9k0CrVnPNPO
	ptBUE2Y71nx/y8nuTdzlLwbJQpGwQar4hjpGXek1I4uzbcRhv0xDcOwCeSkahMyy
	VXM+7Z1M1tuwEiHZkv/3fAlWPLWhHVE3hxVCIZn1w46uNUtjiiCNnSQ6V4Orwvf4
	B8b5Ynj1tcITzPQEAEzJ1HBP6c984vGgo7p2i+A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:0qwtRImczgCguV7go8mKRw2NvJjxhz1P3tAFmSYB7RQ=:T2pocOKA+CTIYmEL45l12sJa/hYoqigDDbxy+TiIavY=;
X-ME-Sender: <xms:z6f0apVphjblt_nnap5fcLRPKRgqBERckWeHLxB1XQnMLcuZJYxpkw>
    <xme:z6f0atQT5Hy-kPwSq4yYQwntOn2_eXKDvmlLVwwsqCpm92RY3yteVKcA_EEZ4C6m3
    sCSBafPMPYSAM_dkJkutKDIzvBSUH_2UUAaHpQ9NHHuebArQfnvcBI>
X-ME-Received: <xmr:z6f0avNDIH_ZshGtcrWqNsniK_fxPs7S91kg8Ci7G_c42dUq4aQQWmQ9VgBoDnO8IZHxxMo5hcZFEZDVjza6UjtF0SaI6836SIoh>
X-ME-Proxy-Cause: dmFkZTFZ6abt2WTXQREyNHFSJhUKKfB+Tg+wy3CcvdRw5bryjvzacp8okSsCT0OY6F1PqD
    oNehPqT462OiAtYjpeRJRj51yQRZq8xPVCesR5u6SfkehrxlBdFrkpvRLcNnqpO/Occdxl
    k+hLhmuF1vzXFbYWIoVpUFAYH+bHkMtjFcgGFpB9v790dohizwfMraHK+6wRsrK2+sx1qz
    kgziE0ZGkU+XJCTUUDHFipEfgpx6RVKCziQp+ueJokheZKBkNp0zhmKZH4V6z0bA3JcwHK
    zzc7+LFM77JnGPjJitX/gqE6wU98gsRCavu3GIdWiS9s2r1/JIH6yYEYCU5L2OS5OqmhhV
    2qHK1SbTsu0pIaiR3aPLdSV+R34nZItsnqdyHHsfB4tYtqIldnmnDBXxl11AZ3UCGCDapd
    47DL+ZNU+BbdAZr5XtYsjHh4L/ruCHvudtXfD2kYoK6vTTXG9xViekBrRPio+bhiGdv3N3
    OddIQAtLl9AqGPmONHOfkmQkLFo8zkn/RL2k0+MShtApVo5EYHfxFNvzeJqm3W08TFUpXN
    kHrzSBihaSla7vEibtGffWPzANta6ZQ1+tpn6/hfg3FmeE+J5kw+tZJyZH3H8gxLR7xxq+
    VxZoFiUgvY25cHHWTL2jvnge2pwYxTwV5MzLXotaS+jh+ex31XvmKMQaNl2Q
X-ME-Proxy: <xmx:z6f0ajSwul_d_wCFCLLAlE4jPBS3RD9CfFBEJjZKVPXffo35T3oH_g>
    <xmx:z6f0aliNMWs4IZdaFQM8kGkNJlRFpKfAg6qW7Sq8qH92hjpiOpVmdQ>
    <xmx:z6f0ak9dZlUSWwsaCFjo00QUaEiHSJdDMXsbe4AG_-97kZObOLreQw>
    <xmx:z6f0akErR-mbda_b87TuAsJ7P2hYh10b-LCowSlMPkRXlsMz3ezOJA>
    <xmx:z6f0an5PGORcfNyseFkPGhVu5q4k4oJ2hiJj50eFUdTxi1RqSjaziNyl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 12:37:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  Harald Nordgren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben
 Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v13 0/6] fetch: avoid fetching every branch of a new
 remote in a shallow repo
In-Reply-To: <b64387b3-294e-49da-b40a-0e757956bafd@gmail.com> (Phillip Wood's
	message of "Wed, 11 Nov 2026 14:12:50 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
	<CAHwyqnVJ3eUQ9tkQE3rhQ8jFZjaD0tFUv41unE-NQ1WRiyfjBA@mail.gmail.com>
	<b64387b3-294e-49da-b40a-0e757956bafd@gmail.com>
Date: Wed, 11 Nov 2026 09:37:18 -0800
Message-ID: <xmqqcxsbnub5.fsf@gitster.g>
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

> Hi Harald
>
> On 11/11/2026 08:31, Harald Nordgren wrote:
>> Hi, could I get some (hopefully final) reviews here?
>
> The diffstat for this series is
>
> 12 files changed, 593 insertions(+), 33 deletions(-)
>
> which will take a considerable amount of time to review properly. Yet 
> the cover letter which should explain the problem being solved, how it 
> is solved (i.e. the design and any trade-offs that entails, alternatives 
> that were discarded etc.) and anything notable in the implementation is just
>
> Avoid fetching every branch of a new remote in a shallow repo.
>
> I've no idea from that how these patches relate to the discussion on 
> separating "which refs to fetch" from "where to store those refs" or 
> anything else. If you want people to volunteer their time to review your 
> patches you need to make a effort to explain what those patches do.

I would say that it is a fair comment.

I understand what the first three wants to do.

 1. We have had for a long time "git fetch --refmap=from:to remote refs..."
    given on the command line to decide how refs fetched are stored
    separately from what refs are fetched.  This allows a configuration
    to allow you to pretend that you give it all the time.

 2. Preliminary refactoring of a helper that will gain second
    callsite in the next step.

 3. This allows "git fetch --refmap=from:to remote" that does not
    specify what to fetch (contrast it with 1. above) to default to
    fetch refs that our local branches build on.  The net effect
    with configured remote.<remote>.fetchRefmap is that "git fetch
    remote" would only fetch and store selected refs from them, only
    the ones that we "care about" (aka "build on").
    
I do not have strong opinion on the other 3 patches.  4. and 5. may
help ergonomics by allowing to set up refmap from the command line
option, but from my point of view it looks more like icing on the
cake.

When we are working with only a subset of their branches, the first
thing that comes to my mind is a "matching push" that does not need
any fancy @{push} support.  Because of that, I am not interested in
6. very much.

In any case, this topic one is keeping a topic by another author
waiting to settle, so we have stronger incentive to see it move past
the finish line.

Thanks.


