Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14BB2C1788
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 02:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070567; cv=none; b=XC4H+bI86BRolP1kTQaQai18x0S1p+0W27nzm+BV1A52y4q7YdQ2KWePM6V5fewxHBF9MCmhYJM4SOM4Il0WpaY7y41OEOohMuLylYLEn0YZFJ66Mnqn6wsJIFYQmFVsuuz1s4ut/VXrOvMLFRJOiOAfXfO4Or2XgZt7PieI6Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070567; c=relaxed/simple;
	bh=Hcg680jZ/x4Tw+r06FINxmfgtNfskG94ndjo0p/jO2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bD4EOD2icXCT/1066cp++niobW8vnODIohS/8sVtA7HY0yv4XWc+y7MWw0pTsWeViFxoIC3napmpilpHH8Jby7Ja9SAKu8oJ/fRhAud0W7HxkfXlwz2S6VX9ch1Xeo+Elvjm9dO/V9TIKw4CUYLqIq4l3HxCGpPJTBVMbOddMsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WgsjnYjz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ecF1WFzX; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WgsjnYjz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ecF1WFzX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2C0007A00B0;
	Thu,  6 Aug 2026 22:42:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 06 Aug 2026 22:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786070565; x=1786156965; bh=4mtXr9PFHs
	KkZAWyqU4P6pSQGq80mEutwyRYAxWfCnk=; b=WgsjnYjzYiLj/+6pavrYQM8JCm
	OuNSQVpv4yOYlgQxTBRT0llicGXWCgzzn5eWfkSc8ZRIxa++LRZ+RAwHKmMuGEEs
	sOgbk5ESNVueHMPoQRrIuoKoXm4wNhSUt05elu4tRxzJpaR3xW178fFJsacKQyna
	ueUwbhMKauUqAuP9MQdz2+Wd6seGHVHnPNt00QLB7rgYpjIIKN3FPUho1RYXsioE
	PWW6TXNyOk/2/gLGpbZDJdm/6RBOIe5DlQT3AruEyT+VaO/3UiDTNPmire7QcdxD
	SIYO36ozk68FYQVa8OM/7+q1rBelgWA68q/mGlcK5qsagyPjUSp0UPRaWUPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786070565; x=1786156965; bh=4mtXr9PFHsKkZAWyqU4P6pSQGq80mEutwyR
	YAxWfCnk=; b=ecF1WFzXqQG6bVykzZQUAHf5UvRpfmxvY080DIrf/jCOhnAeWhP
	I0GcI0QyEE53HHwAQNOvVsgG4scdKDZm3XpETUCi5i+SU9E+FQXmxcNxE0aE5TdX
	1Pz/CEpzxnxtX7zNV5H8InGgQzUE9mrfWONbd47B2KU7tYBp/MhZomwcRdGzLh8e
	Ayd4n1il5KhvKEcsfteY8boQgx6uJwre1pY3Y/ieDNcTo8RL69y7hTrwpUHSt0uU
	9AhgoLXfCE7Pq5dfirmKYkjWRlY9P+Zry67u3IIdNxLgsiVmkuPXm7MzRcpn/PIU
	lEcgTZkEYMBdDsQfOgjSHmSpDer5L1WFTPA==
X-ME-Sender: <xms:JEZ1agd2wjmVZmV-Rc3oIDam0A8YQ5ml-8mXiwQVyU_5ibBx5Stl-Q>
    <xme:JEZ1apqCHOA8dhGcoLGU5lAkdTc_XuBIhYW3PVSb8WjSM5pyZYlbCIRXDzbAwqB54
    zwxfoCa5Mpoi_Y6F1PunGFHndp1Ragwc2mwz3PUlgzI68IBCRFAF6w>
X-ME-Received: <xmr:JEZ1au7_7y-owpYXpOhGoK3VOh9T_vx_s0lJvwFmAgufvYnD5Vxbz3vzk81qajSOKABLCWnDliSqXAtTQsWwA6_ra8-M2wGoUg>
X-ME-Proxy-Cause: dmFkZTEFgNko7OurW3HfyK5aiy75knYl99dldqAXWl6+TMBS/JGeJ+dsr8dyoEH3/Mk4O9
    RTr6hpjMFwzcYFdEJQKABBDU1QUm5/pRYawWBscmZTH0QH5i7M0J6HoDGS2xQhiOqLNo4h
    rStMwxTSLdg+q7NTy9T1T9AHUpoOZ2KQOtykWZ+ZeLzYu1rTbCv9PmWN4BzetcLFrbGbsQ
    RF02LXky2mut2AxAJPd8ZsMo/7HnSKRtf9jxmBFUq/KAXZ6sRJF07WBUlnnnSQcJYsraVW
    qyJXc7rkDAzrUHkZlwxiy7kyhlTldlSIrBjahchadtxW4D7aqOzg6yltSSr1/YrrGGW8sU
    wkCG/eHvWeD+0bNvNtmp5HtOwMpaUro3H9B/keM3g/IekznUrCfImmRgOUD9eSuC1sT85M
    qltt457AvYiVr3ONEXhJgDQXvtGtbf4Za8U9rCnEbY1vACZ6uHhdPu0QdCA5ye1XA9lfVD
    1L4zOkFzU/F2eeEEFnPhmDTBnOxiCeM+sj1IAhG60B/LfUopXpCgNFvGeepsMoBEYBZGbf
    Z7bNWB61KBEQ3mHuAwCnAJP3t9gALe410HLcXJyIf4HhcJxo9XGLZTvjYyynJtg8kCnuco
    0U2zZI0xkngJ3ykyrBMNN+ey6PpMnFNwNYs7SDrs4OqhugrALz5hGCNUQSRg
X-ME-Proxy: <xmx:JEZ1avpPUkUvmx1I-f4-jEA_-m8jeuwvmgV5m_pPCesnZ_C1COoTGA>
    <xmx:JEZ1agglwGgZWFWDcwuzPmkUM2KyB65-hI-VBjKyrBpmZorbDheFCQ>
    <xmx:JEZ1apJ1BlkTIWCjmw8HRzqJ2rkYZ8ms4RlR5IDjudcO-KcB26tO9g>
    <xmx:JEZ1agBFzCEbsKrCpCEOvSic4QaClErrzHZTCMPUCC7LO1ecY-VCBQ>
    <xmx:JUZ1au7PrrGGbgzBqKoHgOwuk5nBJTBw8Zj2xgKV-PqW54gtfJtVGVsp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 22:42:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Douglas Puchalski (dpuchals)" <dpuchals@cisco.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Feature request] Separate explicit fetch mapping from default
 fetch selection
In-Reply-To: <C47215A6-B86F-4AB2-B20D-54D048B9B2BA@cisco.com> (Douglas
	Puchalski's message of "Thu, 6 Aug 2026 22:26:05 +0000")
References: <C47215A6-B86F-4AB2-B20D-54D048B9B2BA@cisco.com>
Date: Thu, 06 Aug 2026 19:42:43 -0700
Message-ID: <xmqqcxvuhcrg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Douglas Puchalski (dpuchals)" <dpuchals@cisco.com> writes:

> Git version: 2.55.0
> Environment: macOS 26.6
>
> I configure a remote to fetch only a small default set of branches:
>
>     [remote "origin"]
>         fetch = +refs/heads/main:refs/remotes/origin/main
>         fetch = +refs/heads/team/*:refs/remotes/origin/team/*
>
> This prevents `git fetch origin` from fetching and updating a very large
> number of remote branches.
>
> When I explicitly request another branch:
>
>     git fetch origin topic/example
>
> Git fetches the branch into FETCH_HEAD but does not create or update:
>
>     refs/remotes/origin/topic/example

I haven't thought things through, but I suspect that what you want
might be an opposite of explicitly listing what is tracked on
remote.*.fetch configuration, but having remotes/origin/* hierarchy
of refs as the source of the tracking information.

It was a long ago this was invented, and I haven't used it for
almost forever, but shouldn't this

    $ git fetch \
            --refmap="refs/heads/*:refs/remotes/origin/*" \
            origin topic/example

do what you want to do?  If so, perhaps it would make a good
starting point to make it easier to use (e.g., perhaps a
configuration variable can specify the refmap to be used, or
something).


