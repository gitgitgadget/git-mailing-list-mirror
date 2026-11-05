Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901169;
	b=TqKzL2pyj6pupS6MKBiSAvZoGg0UPal+0uzyM6yPlqtrG7VjsAdZ+eC2iCqceW/vn2+8
	 BOXnarLy8CHn8a7g09Wt/GrRIQW1VPT7wC4dNOdKdpmjtGJSby7qWf2HsXKIL+HXDVYr3
	 2gvWnGZr6lKSKtblB5I8isBBPvn2Aa4bxQMGr2lVxnOBTpTG+BTkHJGmXYn/UIQMVfu+l
	 kPMgM786K59KWVvMSjDmFqIwckFk3yVYuxtUrzSN8yz1sL7+SYVAghIH9Wc+STlIE8Uku
	 D0sUK5lGL6X+RF7oSFheI408Znz2D2SoTOsrUE88c+O2p8a5kESCHwykHeDxwmwY2RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901169;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=w4Akf+BN3NwXQZiVEYaQOmE/VQiqQ4Yx7ya+y+TyQwk=;
	b=X8/FC0qx5dWxpvgB/z/jAJUvlP8UcvxGUACwa6aRlsMT0bevDfAsL05GwxRUG67Bsfdn
	 coRagI0461n95e0uD0AcsBcII15seyY0Nvyw7v1Qtjz5G2rZ2ml2dp8qN/1e6TsOiwUEN
	 8a4DkN4EHsHr+MbVCL7p1DOWhgufVSR1bhZOGXTGexDTcjXJi94oqZV33ldvkAtUvEwO/
	 t68jDNtKoZkIrWDVb840WUHMs8pmKc/5RDFwnfevmpMis+zQEUvSReLHQnnBRyA08Vhdk
	 bPuWfYwZEuEjq6XajAQWf8TqVE4gknZTZrfoSgbK2KFl7svJjMtdof5qF1v9tw0jbgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=VTIOQ6S6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=s13HXjFc;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A11606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 17:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62A11606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=VTIOQ6S6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=s13HXjFc
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 81E0414000BB
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 12:52:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 05 Nov 2026 12:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793901168; x=1793987568; bh=w4Akf+BN3N
	wXQZiVEYaQOmE/VQiqQ4Yx7ya+y+TyQwk=; b=VTIOQ6S6pmC7LP+BuPVmgZzI+l
	rxl4YvPXccv2B/B753VbSd1cAzlpEgOYjiZP4NnC4Me7dyWTls6s2aSmOUSmVCSt
	gLpHyTfmF+B+IERpLAKNOkUqAyx9qlhB44EhQluU+AfLdw0qN6/ZxmUYodKtcxnU
	GqbcBShGyesVo8OXX1cQ+uHIoZKKHgmBAwK5duXoGgBvsRQbPslW6fg3pzHoM6rH
	0ZCyGhby34kucdviaUODM5F+rA5HoR4wZZwu0bzkmKYCkB6KaZuCe3NTgjIbVSGe
	vknLcxfbMHd1EmWVnQoVm7jMjc7Vc+/WXRAOxz7/FIv1WDlEqpdpYY8R5RUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793901168; x=1793987568; bh=w4Akf+BN3NwXQZiVEYaQOmE/VQiqQ4Yx7ya
	+y+TyQwk=; b=s13HXjFch/yxWha7oFeZkQ5ROpX7kqIAPKXj8LfMjR7041xAymE
	SEx7pAmm+r9cHmX1Eb36b4zroqXCXEN3h/8AKrTlRPNPX+5gwnoNVpiYg2QsmGh2
	u4GfquMgr9zZRe3CyrxJOlI1UuvLbCv03SAYmAc7cvxsisJcU0uGid3/RMRgzHMp
	ozwuKaHFt0AfmuKhLreKkvl217cvHurEcv5rRmSM1FliDAIsTCUKu2Ei0RQB3UYx
	f60JWOUPOP8N1U4ePuafgMtTYTnLpq7Xt3nROgnmcSWvAldU3iZoHW8HsXsL7jFQ
	CHmnbbclQ/cpOJ/GlY8bvok/x1452uTPWBA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793901168; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:naYu/q/SpEoaPt2bLzKcpR8DUAauLK0I81LV+zFwbwXcrtj
	QpAsSmWBBWJnT16rPMSiMnJDhRuWNkTMDJmgqlHBdxGYfW2w/KR8SR/45FCEhpfb
	QCSKjGUbEQFiCMCNRENS9G3KvmsWerbMbP69tr2PRl67DtSeNBVb0M3c8n8UkvUh
	EvFSabIWW6a41auTcPmWJvFd9K65jxE+79xe14OerUk/x/05kRbTR6Nfhd0gOCUI
	lzKAlujGDY0rVduatzfRAVZcwu/o3SWcVmYmya1ofrOuOGvunu1dlN/YHoPqIy4N
	QYN6rlFVtKE29Z5Hqx3Bn7etpqFrGzgd4jX8KZw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:dOOyPk1LjsdRoN1mzHiHv8cDW4xmDFzL1QMkn5aSCR0=:Eqdn/aLd9+Jw/lQxAV6OaT9pVkkocTsYyc7lS+Tj26s=;
X-ME-Sender: <xms:cMLsajcaIecEGI81j2aKjxmeidptCbgifR3y_h_0grnrFiJGvvPY6w>
    <xme:cMLsas7UyvqYVt_1_AGmrqsOXF6k_5NVlUZzBzv5yStniLWoQhTH7DwfdPT8ka65R
    dzosVG8ftl-M6asz00zdIlUS0bCHYf_sjFsDJg8MNqdm6g1IpHSggo>
X-ME-Received: <xmr:cMLsamUKOR7qmOxmC_rPWme2k47FyBDkarb4dT3Aw5ez8BT2Y3GLE72lrG6KOYz9prUF2S6x2DSzIfZ9EE6l7KQOVpvqjt8JWypd>
X-ME-Proxy-Cause: dmFkZTFjqYcyRwhru2IES1s9bfj9nl9ul2nKKlF5GqxbBLkv5IO9XKfCMd1yGMdvBYu0ph
    B/6EFVavV601gfHnAIUQ7MX9WNy+/Z4AwzEBRRrXwhqUqxP25DFgzAUmzYCG1U77ZUflGs
    +Ixx3bM9pk/T7Yz062BsNgL4XKmwPndhb/wHRMYNu2mggYlEK0G+ShJ+pBkUuqAD/4oeqL
    t7LQFZIZcsx85tSoBCUTSE2zKZOUxrmwxBGTtgJNOb03je4wyr7cgUEd3+qFHtyWXr2MSL
    /64u7qZWWDum9w2G7RE6p4/scnSjwYYKCATXL65KMt4ecofRNZn8Xy+hV7+U39RQ3dRWWP
    lPSa83Nlc7jNR4DLMjEMa3gX/k/aRFhCq9tKLuvjRjMuMMn/cCjiPYj4tpKoR7rHrj3Ocj
    3AuuWfa+CMMjSizu38IhrbNRq21inKSj7OM2mLidoyccRA3sSx0CXKoCcF2Tyesyj1yYWW
    gQ6tiuDpAomy7/N8X5KxlQMnJ3ZTxYa912E49ClskfVeZj8ZxNPVc8wNnpfs2px/5rj4Go
    8nbWiMKGQYo56QzrmOkBsVlc7VBI8SZwTYNePrbgb8KSJzZjBXbX/yAybU8zYieVV6OYS3
    yySisK1ZHmzeRKFkBijahXExXMcUHz5e7fKE7zoQ20NuS3DSVOCuRcIuKCSA
X-ME-Proxy: <xmx:cMLsar6aqSzZLPDQhuj6UGaa0z9sTsMRaTfQbVQeaQom8aomgiMHBQ>
    <xmx:cMLsahpm2zZd8fqpyOYY2QU82Qwluz4ew2Tascv7N7zHQokCfDZ47A>
    <xmx:cMLsaunzTbQWxRXMW27gIXzP1qrkSXXZA-4CJ72AhpN5f4Qugs7QAQ>
    <xmx:cMLsatOmKMU7C4kvEEzrfNKRNoj4TKEVLLkE6GSnrYaTdutE5YGubA>
    <xmx:cMLsaoIMW_214lym0w2tWmOkPIwaQEdp8fcAaJ8X5169-mqTkhR9oa_O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 12:52:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  <git@vger.kernel.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 0/2] [doc] Remove gittutorial-2
In-Reply-To: <20261105065723.Q3ED0%taahol@utu.fi> (Tuomas Ahola's message of
	"Thu, 5 Nov 2026 08:57:23 +0200")
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
	<pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
	<20261006055002.M9X9O%taahol@utu.fi> <xmqqfqyieokd.fsf@gitster.g>
	<20261105065723.Q3ED0%taahol@utu.fi>
Date: Thu, 05 Nov 2026 09:52:47 -0800
Message-ID: <xmqq5wybw4gg.fsf@gitster.g>
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

Tuomas Ahola <taahol@utu.fi> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Tuomas Ahola <taahol@utu.fi> writes:
>> 
>> >         gittutorial(7)
>> >             A tutorial introduction to Git.
>> >  
>> > +       gittutorial-2(7)
>> > +           Obsolete tutorial.
>> > +
>> >         gitworkflows(7)
>> >             An overview of recommended workflows with Git.
>> >  
>> >
>> > And let's not worry about that exception you mentioned.  After this topic hits
>> > 'next', I can rebase mine on top on of this, and deal with all necessary
>> > integration work.
>> ...
>
> This topic has graduated to 'master', so we should be more than ready for the
> last bullet point.  Please pick up the rerolled ta/command-list-guides-sync-lint
> at <20261029184834.2273-1-taahol@utu.fi>.
>
> $ git cherry -v origin/seen ta/command-list-guides-sync-lint
> + 9a1ba61ac0e4491a4f028250be478cfcf05c9ef4 command-list.txt: add gitformat-loose(5) and gitpacking(7)
> + 5d36d7585956d17172012c8e42d77597524708e8 lint-docs: check the guide list in command-list.txt

Sorry, I have no idea what you are trying to say with that "git
cherry" output.

Earlier you said "I can rebase mine on top".  Is the patch
<20261029184834.2273-1-taahol@utu.fi> the result of such rebasing?

