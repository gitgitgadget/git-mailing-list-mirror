Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027254;
	b=ZIQ8E7ceNpFlzXJ6h7vNzY06GWMMsrJKvVNYecYDMvFGYWVPNwrkLzzTaq2Ws3Eimun9
	 4Ke6Q6MMm1r1Jc7g3mxf45ssAQw7dFidcfh9uazg8DMc+Yi4Y/TG/aCspNZr4Kwz+ZSvU
	 LItlIjnsghVknrdqZwvAwaxVURc0CHtqaK161d4LVxQEA2m0KsdjYqhsUQ7ivD5rnBesa
	 zUpldzRL7zDOXeGml1eHHil9Z9cWMuXC16/Q1JcqP/K5Tf4gGoz7gL2EzMLXKy30w6Jvs
	 Bj9EFPfrE13F92abOzfStGTPs/pBOljE5S3h3YUircTPyoM3GDRojspGCDi8ejw+JVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027254;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Pg7joJJcXZVH9IsP5TRafo255Tm+Q2zO2lOfVSrm8K8=;
	b=FAbqS0/Ihd95MLLKBUXh6lSR1By3PpmagcvnTo36CGGeYkH2I35Tu0nvzcsi6gLUr1Il
	 +4tACPkHUHfKnBlca/4B+Zkx4INMyJI4rfZe2NsBKwdVO9vv3s3Ib++tNtAUDp375Y8Wz
	 4pJQiGvM4WZinS2T88s3B57xs9EUlfchVljCwMuDOZdOkDGfIIvvXX46ZDmGmbq/IjR34
	 UkR5mB8AXiHpNMdLiNwnhIPWEUMbNRatVwtHgLcWm6bjeBL9h2Hbe8rkBAI09AJ3dUaXM
	 0lSKKyNxrSiOuA7E/EoYO0Cv6BOnV6T/4uGWXoS6Ff/6nrard1xW7arsdumxg+QywPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Iscpod4C;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PXlUzUBP;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCE6606A323
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 15:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBCE6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Iscpod4C;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PXlUzUBP
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 083D87A03E8
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:07:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 26 Oct 2026 11:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793027252; x=1793113652; bh=Pg7joJJcXZ
	VH9IsP5TRafo255Tm+Q2zO2lOfVSrm8K8=; b=Iscpod4CBSt66LYTYHUWIdWGCT
	aInugoE3lQHvYNr6H73nBkz4j5JvRNp2lDfYT0xR0/RgrFxl+4gJ0GSlk5pQFBDB
	hnWKSp63xkSH1j6C8wjwLXZOnRGb78iqNFlcu8XThJlJKF9arM1Odom5EvhSR28v
	rEMMwVH1+S4rjm248OsMHhmf+Fc5EGR/bpxbb/ohwlJFWh9ztHOTKC5/2+TpdZvI
	TPIDZ4AYDSWA2Q2zQrH9HGDHvCAfLvh6ZHzCLZJCzYgGYEV/n8Ake2tjbB9PgWLM
	Io+56iOMgA6drcu4aZSHUqUYfiD9fBLLmC4uyk1g226lOc9fUs07YJRDEDVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793027252; x=1793113652; bh=Pg7joJJcXZVH9IsP5TRafo255Tm+Q2zO2lO
	fVSrm8K8=; b=PXlUzUBPCM7g9qO41t7zpyW36e/tmQ6uAljBiFDE2mdEyM8zRfP
	gwdafqsmA+WMV+65yj8ThpX6p+FY0aZccxEGBuAgtHBsY8NFLVvqlY1FQBq3p47U
	H3Xa0/zLUlDlT0cnrwyktbbJas/GSyw1bheOEhJRjapJrazC736VU1tlhpHNSUVa
	WrqT3zEQUn2cuAOyP5Sjl6y3uT5eJ65e7/3FL7BwMw2oNHa5kkB/W11jLuNh+dT5
	TWZzB+qluaJT3aTwCNeSUf2EZRNv1JcJZ8KQ33n+apolTResbv68Ov/6qCXq0tIv
	YDmQFJQpZVFOvRAb6CfrofFh75uLkYNPT1Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793027252; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Vi1ykwoFEZlSdfjRZg9ygouGq5wvqolof0UMI98NsuLgkMo
	43WBAeC5XJ71nUdUw8yWC5zn+YIVF7bvbM/mj6GikEv7IPY+XrjjXLv+tAuI32nR
	Cn3M/WHgftzc1u1FchoDLxZK0SL+BIMAxH29Ydww3sKxRSjYiZkEFYJWs3FyXMxm
	mfxddOfL33fOy8rwI7jzh6px2y2JMHXhk9aGUxODPwRw7+8V/P6J6rBMAX1LUYFr
	YXflC7IkGe9JS9AirOPguE9j5WW+Lk0y8aP+BBKEeVA7vj1E22qBsgagKOrCSbu2
	zJjOMAUp/TgSqYckxWz3RuW/FW6aB1w4+EIIMng==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:sgN8mKGAhgh5vbdySugYIlPfCIATxr1We2J5UX09qoE=:Pg7joJJcXZVH9IsP5TRafo255Tm+Q2zO2lOfVSrm8K8=;
X-ME-Sender: <xms:s2zfauQE0ndMqWtAVndXPf_t_8eAYvLdaCNbR7yAZczQZDjc2hGXVQ>
    <xme:s2zfakdbsH3aC5tcPT4wUVWtLw19RBNrvHQrSTq-dwzmOUdhZ8ljOLqS5PB_ANLDz
    tVfwkjAVxbjGqQINAlwnHIJlNMlyKsywmsQzG-yFwY9oaA55UVoAdU>
X-ME-Received: <xmr:s2zfaqB7QfWfM0UXXAYALQesAR7Y9CqXP971mxmHrXl4eJ_M4FZAmXV0Iqy37-QuvancWr4uimAyerFocW4gmARUsyIgAFV3PMuc>
X-ME-Proxy-Cause: dmFkZTEshV5vdFhSYcDB/M1tmhjHFUo4lva2HxYoUr5C/6j+cgnz59wAJzEnxex92a+wEf
    MhdP9gsnX/k3JBs1EQIVGnsSU4foNUCMsc6UK2xQxF2NtBWAQeO+EADtQwVN+hsuTJqqjC
    Py363bmHfCrrwXVs8CTFMPMcbz2uZaDlBgkSqRTda+SaTABaoF27Jbra/ztTMaluFedzum
    13OdLk/9ETKtjc4z/+UEIPV3T5HxY+sp5UxgWrW/uXPIlc29FZIosMdsZtXEGC61O9EJgm
    sSmCpBhINoAUuB4SSnIvQPCm3GOOF4sMb2gLzAbHTU58leP1qP8p13X0gk/9AHFXewiCQ9
    S1pKXX6h7Z2j8cg8WCUfSU517IsdKpKaM74ojgqr7XIsLCZS+cHUZuBExMlEx66rfbpWO5
    /FgGdVABn5YDWz2bhnkVyz91eSInnP3G+Q5kqf79OI5GS2ishbMDyboxgG0J+sLZrthoVs
    vIpvQxfZFRl/9s9ZnPlrnOENLP56dEtRlvxiGQ7SACRDkZVowKSvcxbmUnLJbm5ObL2zW8
    CgcHbp/CmPwXxzVoBZRZ9nJoV/AgpXBAOi0YaaQ0LJQQNN0FXrwrXw+AOvkTIrs3sV7xpG
    YOKl7aWVmqy8Eet6pWvr3vgE+wKfe3e7FUNk+zl53vKc8qh8+MyyfmDBsrKQ
X-ME-Proxy: <xmx:s2zfaunCwEsaIzgm91_MGeC3NAbBu7ghc54rLGYucyDEpZ2x0aLf5w>
    <xmx:s2zfateu1qAji377u4cwDLWWxJ3sbMpr2FBP4ZZJ8X1YC6SSOdTRdA>
    <xmx:s2zfaqSWGov1ssXO7OOl2sNW8EWosqrIzZ9to9bdbzavU2rJQWVf6A>
    <xmx:s2zfass5ZsjBaFKH82W1gqeG3TUb6mEurvZqdJVqxLAhcvjjdjWNNg>
    <xmx:tGzfakvypTlGg1TDjmCdacinBMmU5B71EEPqJ5t4rqKHpVy6aGfkKJNM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 11:07:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 0/3] reflog: add --operations and --historical-branch
In-Reply-To: <CAHwyqnUckb2ccoRToYwk=OVkHtWX1rRNa0z7TwMHcHQufNuNEQ@mail.gmail.com>
	(Harald Nordgren's message of "Mon, 26 Oct 2026 13:00:42 +0200")
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
	<pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com>
	<bfc2b43a-6198-47b0-8868-d92551548f22@gmail.com>
	<xmqq5wyr128q.fsf@gitster.g>
	<1bc5a05e-3d3b-4f56-8b11-2e276cef48ca@gmail.com>
	<CAHwyqnUckb2ccoRToYwk=OVkHtWX1rRNa0z7TwMHcHQufNuNEQ@mail.gmail.com>
Date: Mon, 26 Oct 2026 08:07:30 -0700
Message-ID: <xmqq1p9cv6tp.fsf@gitster.g>
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

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> It would certainly be nice to avoid creating lots of entries in the
>> branch reflog when cherry-picking. I'm not sure what users would make of
>> us switching to a detached HEAD as some people seem to find it
>> confusing; if we do decide to do that we should make sure we update "git
>> status" to explain what's happening. I'm more relaxed about changing
>> "git am", but like you I normally detach HEAD first so maybe I'm not the
>> best person to ask about that.
>
> I think that the fact that all of us have our tricks to work around
> things is indicative of a real problem.
>
> We should attack the root cause and simplify git so that even us would
> prefer vanilla git.

I do use and prefer vanilla Git as it was designed to work, though.

