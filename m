Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329635;
	b=S4NO4yblRjONqUAAV5Zdk1BPGB65U0SU+QGU9DYaU6galG/DrQBvdZxhHcLGymtkQyH2
	 emMqF2rWJiSCEi5dB59X4vKx9Kz2wBmyK0dMuCPfbBxtRAwQ1CvkOEaQmDDldCA9HvLoH
	 S6eL7rIjv3in82cpPax93sjOnazFRBcnu8ZzFQS7QHiTJajy+9JahC1JBpXAK81GKP9Qq
	 X1yX2tiQH3bw9wLdGlUGjN/js3uKy2bG+WOm5ryfXKAA6Q1FXZYLfXq9vnMzHD/QOH8St
	 X/qpk+H/O2/b/e29lEBiy0oa4Bv5Fvs9P9IKgyt0xZbmTZc+cWZaJiDXtx90XX3Hr9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329635;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=T5qAmq8Noam5OqI+c/Pdpir1ltjhA30/puT50fjhlWw=;
	b=Z7p3pokvMQRRNAVO+7z/afoZbFGXQWgFpqMCvOXwZEquvTe4vrMzGKeUeg9aLBAccm4/
	 pMws0a5QKhHnC3s2ESpFalWnKG2DpU7ygkDT0a4SlBZKFrDrQ9UH4P7zAKIcw8NzficYC
	 UCJIGwhCkQOWiZIwlMFQNtDyDmIJSVae2ZzRtQxV3NtdfDkZL6kqIN1uYY7bctWFYYxhP
	 ZTiSWOjnxJX8xdZz3VMswkv+wtwh4uVQUDJ+GqnIMnekSmkkMUBi7rR9qkwfKL/4P+vfd
	 CHP9YiP0PRmLF576zkn6kwyO209qnf7r3NI9Yo98UOS0kfEeVw2IMjmcEBsCJ40G6Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=JT6qHchB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FvjnLQzI;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648C9606A33F
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 16:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 648C9606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=JT6qHchB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FvjnLQzI
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C2D277A028F
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:53:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 10 Nov 2026 11:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794329634; x=1794416034; bh=T5qAmq8Noa
	m5OqI+c/Pdpir1ltjhA30/puT50fjhlWw=; b=JT6qHchBKhqD27N8P69EYBNboE
	DbrpG7PB7C1O8M+nlTjd3O9P/ldW2NZTrgW6ZvYmvLqMo9cYKw7NO+Mpl5y+HzC9
	S6Wbr/0m5hiYLTr8/El9d/gcQPk5sXO50g7OCzCZcO/LNjsoCsLhHXRcaoLiaH4Y
	SgGZEfP1rvZfg3VknbEKXVSzfkhbRgAwVqdYsQGoSvL1+HKOPnuX5WfAGDdxbGCp
	bB6gr3DBmGqjNqdVAw76p8ZIwe7/4C/6vSxaQZ9LJ6W4DvwzbaEQ1WnhjWoE3Jru
	0MeGR7vsfOGjygMnUJNz504af9YJPczvAwN1zQ0FVa1/SdoPI1uaMUmVNL5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794329634; x=1794416034; bh=T5qAmq8Noam5OqI+c/Pdpir1ltjhA30/puT
	50fjhlWw=; b=FvjnLQzIi0XQoY+V0XJYumFx6VDSjdqRoQJetRBdYo1Wb82rAvY
	iEY9fxWU3CoGokk60McFi7q2dM05JOjeIohw6pTd78jkLWxXMC83D4mkp2GP62ty
	giuQOkpv5DCuFegoRXV0lhuirSqV6nrsBWLYPXqBCNl534gyK3JaeN3JUdP+Yh+6
	OaazjxKPLgzZ5ULrxsWAZLzc9ZVtKKPYA627Upbjw5wjvtzDCyXY4JLtjrCQ6SiO
	/TE858brOnwOC2MoyxFG7UpYUhF71D9hdd3xDRv04SEo3Xb2WDqPb2s0N0QIxd90
	tSI4fpkx49WvFP2Ephp8rJxswWfAfmPA9/A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794329634; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ZbPv8rfCU57TW+oHhly0Vi12dYaTyOLNk3+MPdgPSUGLdCi
	zDH58ELq7vMeFL2P2yLYT7QDmKmZ0iXRiltOHw2ZULxMOioaUSjapuRFnkibuuBN
	DRjmAzaw8NCjKuXAXaya6Deu+4IySjdS3LDq9T+kW8Zi9Q/yovurSCAeruxqCgWP
	lhSXCCct9lglg6Je12g8yk/K7ZHHUEg1fghyKj/ZJcSRpoXWFJh+VuVYB1eO5YTE
	N/rPRs9Cl/ZI7sIjh55l9YWvToClghe09CEm4zcG4J3Oj8AGPpZ63ZoKl2jwY+Wk
	vLgqmDL5HS7Vw2sludovrbsNZEv3XRVrrpWNe7g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:vr7D82mv0ifaPQlTgZR6W7E8Pf2VMl4/h/ZvxLoMjK0=:GCGkGekE9qeWbmOjieX1flpvuZDZJfHySGrbGM0mVsw=;
X-ME-Sender: <xms:IUzzavmiP4ZpkZSnjWK6vU0shPXu4fldCzBqphKTz4fnH3m9BHriWA>
    <xme:IUzzatMuRQi2scttTQ3Q4_K66r9IZMuSYYjECo9NAx6hKCRFTW03fW9S2VzKTsivu
    _COY2Svca-KgFvitB72aV9uQW_g6l7rEBxPrJPNR6yQkAm_spGGP6I>
X-ME-Received: <xmr:IUzzarwh0X5cS386rAZjJhcyBZUhd45c8Rq0nUUmq-yAuAQXuymTJEfryFO-1b-cPhuzVh0dGE6S-4KfXgaKbT3tPS5gKhoYR93J>
X-ME-Proxy-Cause: dmFkZTEBRGit1nDNL/Kos4FKnu9soiDLg4cj7f7Std3ok2iPJkEkq4y/AWT53H/13Iuja1
    CV7/5X0ayr+v2CFTo8Tnwr4tltSua/xN5FEa/cLwMkhPZjbPNNS+sZ2wVwUCY83oS7dITl
    oNpQYQpz9mEgXozmcmrPiUUc+DRiWiZfO0KKlz4ydyRUbPVt8IqZpT+5WS3sHerCNfFxv8
    69rVfyGKfB3+xuV1EXwWcWDssBmvPZeIBe6oyHkIxCFZY9rP3zrd98Afg7D7kBaRSarkQP
    /G8mSkEaehMgTm8y6ZlHLfRdvhejJWI9G2DfAAmk6XPeO/5IdG0r0oRSlTD2hBNvwo1WQ4
    NfI8F885BYL0oF9lRqBnkmw08IjxJZOGr43pZwriRAGSb7pVF4rHtn9+l5EZcggIQg/6Sa
    1ItWzgwQp2eLwVIZ+mjf25+XQyNe/PYbHHhG7SM4J+BlfUb4zjdUwx3JORpqghT/QtY9Js
    +9uxMYCAblWygPcYOWEMkDV2IlZ3Ltjn6CZPdMq2GNhUWeLhKo4L0BxbCRZhkRS0fsk1O/
    S6+QEIJtNPGfss4WJSHgN86iv/w0C9KtW8jOfzhn9LpwJoGsYTthOcCRwW0GM0Y1qtZr0U
    I3xAfdHBLD/AhhHnMP+ScGzhFKwBIq0/PO5FUoHGm/OFaOXSxXzHzcZQNqkg
X-ME-Proxy: <xmx:IUzzaitpESBmhROQ1YKNxp7lTScRxu8-bBuACKkwQLIJ8p-BcPLk0w>
    <xmx:IUzzamZutR3otuYIYnuO7kkXDcWrnbCQv5lJcqX_7OntaUi-4_4w1g>
    <xmx:IUzzap0YIhUC6nk3-KrQXcN1VFws4673nZUcohRUzQhf7LwLtjvGRw>
    <xmx:IUzzagv5QNmkl2-p2kBNwQIcS8VdPp3ECT6W7UyzeQMx8NQBiTGbhQ>
    <xmx:IkzzarPc-EPDfggsEWY3l_I8tivA8FNbGEMYzj3zoOh54QHImPAAqJxr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 11:53:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Jeff
 King <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>,  Derrick Stolee
 <stolee@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Colin Hinton
 <colinlewishinton@gmail.com>,  Matt Hunter <m@lfurio.us>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Usman Akinyemi
 <usmanakinyemi202@gmail.com>,  Miklos Vajna <vmiklos@collabora.com>,
  Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH 08/15] merge: handle NULL value for
 branch.<name>.mergeOptions
In-Reply-To: <12def237-2d01-404f-b7aa-b4f19e033cdc@gmail.com> (Phillip Wood's
	message of "Tue, 10 Nov 2026 11:12:31 +0000")
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<e10f1fc0ba4084584e11834ea98b8d8d8e353244.1794040968.git.gitgitgadget@gmail.com>
	<12def237-2d01-404f-b7aa-b4f19e033cdc@gmail.com>
Date: Tue, 10 Nov 2026 08:53:51 -0800
Message-ID: <xmqqcxsctyow.fsf@gitster.g>
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

> Hi Thomas
>
> On 07/11/2026 08:42, Thomas Bachem via GitGitGadget wrote:
>> diff --git a/builtin/merge.c b/builtin/merge.c
>> index 5b4eb23a83..fbabda97f8 100644
>> --- a/builtin/merge.c
>> +++ b/builtin/merge.c
>> @@ -668,6 +668,8 @@ static int git_merge_config(const char *k, const char *v,
>>   	    skip_prefix(k, "branch.", &str) &&
>>   	    skip_prefix(str, branch, &str) &&
>>   	    !strcmp(str, ".mergeoptions")) {
>> +		if (!v)
>> +			return config_error_nonbool(k);
>>   		free(branch_mergeoptions);
>>   		branch_mergeoptions = xstrdup(v);
>>   		return 0;
>
> We treat an empty value differently to a missing value, I'm not sure if 
> that makes sense or not.

Sorry but I do not understand this comment.

	[branch "main"] mergeOptions =

is an explicit "there is no extra options when we make a merge".

	[branch "main"] mergeOptions

is an attempt to set a configuration variable to boolean "true".
I am not sure if it helps users to pretend as if the latter were

	[branch "main"] mergeOptions =

if that is what you are hinting.  It would confuse them when they
see a true boolean variable

	[branch "main"] rebase

and wonder why

	[branch "main"] rebase =

does not behave the same way, no?
