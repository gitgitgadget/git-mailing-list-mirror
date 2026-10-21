Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604569;
	b=1IhmetK0yaWxr3owCJdGLig8J7mnLTFSY1amR5IDpD4lrsqT63CNzuQPD0j5M+MnoBvE
	 U/E4+G/eZJ1wNTN3ZK86Eya1Hf8aJjng4/dcAoKKyd+wzrzK4AQfphY49mKZAKES6iF3L
	 J6tjpyc4wT7w/zw0+2fJ+xPUbwlq3X5bew89aq3IBqwkiw8sKpufzpanomWZkdv3q2tcJ
	 N863DbLtmq4HNEZ9DgGUiVodpdQBjeKMkuWPpce1/dGrqIHNEwzyZ+MvugnrxJDpyYf3b
	 cDwIc3iJyyTL/nW6rhcLVpGOwsoGD6P06D8vJp0Y59Howc0efl2PGHy7BNM1J3/ypLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604569;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=uCPreG6RXa135HhoR8MnmhXUv26w/nzfsn0C00H2IVU=;
	b=wdrUFHMBK1OsNFYoJ37Y40uB5K4pkIg3BXVi5ISOr9u9a5cnL6BYleMSO+Z2rMQDda3G
	 666P+aMvhUfwzZupmDz0AFc3iJGqLct3p7b5IDAnZ1DBU6JzPKnNbbU73fXZeWhf63u35
	 XiSK4IiajRe9J3Bm8WxP/wFjjHb3VvgqNCZbVAwI8dAMltxvy5n7MHjzI/HlpOfJdR7bB
	 LiBxvPgNHCulsNq2Z4PSkG9zjJkZ0zo+iK+0LdJHvrnR3E7pCmTF8eJ4LWMLCVok0KwPG
	 1q138aVgItaw+Tt6wEWTzsqxO8RwfdeagFHuEVs09R4+6Gsroib64X8aJqqXBB0xwmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="A6P6H/TK";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mD02qFCE;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F217606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 17:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F217606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=A6P6H/TK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mD02qFCE
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B6FE97A00E5
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 13:42:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 21 Oct 2026 13:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792604568; x=1792690968; bh=uCPreG6RXa
	135HhoR8MnmhXUv26w/nzfsn0C00H2IVU=; b=A6P6H/TKft4wJTUZZcZBji1N7q
	Nx7NcsvfND8pEBe/p1rvZhp5eVq0lwPC7mBCHkFcJo0PC+JMWvSxnag+aR3aPNtV
	Y4ZWCwcmK49dhRKpW959LrylGXsmPsAyy6zM/4m+wEJZWbGDNKdzXiL0bQn0WWwh
	ttF5dbc55ypYegXKjbaxmxPDYMkNDssVV4tjl5cTf/2XKZgQ9Wj7R8AEnNsLwO2Z
	Qz4UxjitcMc67i8aGKjK6EwYHsWazB9CbsZowwrEpIQ7r3HIJGijAqSQNZRuJDOE
	dGd04p1rt5bi4V9JV60RWccivufw/y09g+pxHGFh9w0KC1b1+dhpv4oNQjNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792604568; x=1792690968; bh=uCPreG6RXa135HhoR8MnmhXUv26w/nzfsn0
	C00H2IVU=; b=mD02qFCEsM95qXTWEp4p4YCbIOT8EwkeZY6vmizGhPgk3JIUieg
	XYrMJuAKSs/9i8z6HZobFg/8ul6+2rQZ2PgNhX30xUF+2QsPnxy/OVDWaCRdFj32
	l+pLYUIe+3IhiMsg0WrnbYzIXHVPrelAX+t/JArQ/htjTbWpug26SizaNr4spvDL
	8ZkZZMtPHGwYzRZ9cIxMQHRg06S64cM72gx4vTVHAf9jmesd+HT++CAXEB5OQxuN
	bVDS/CKLFxgu0oHEyE3Ma02iGtCcoB0hD+SVWNbys/a3oy4PjVlGnDCyG5jYdsci
	15VA1tG4zLhTS3NHhmCR4R7kbbz4DfslGgA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792604568; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:eAcaFMPLSSuNdGTl3wtFYiqy8gCqsUz7eJKwqWsJlezLJ+J
	e6gQbBOPKh4UVV/i2I++qZNVKV5BRSYfkWM8XplmB7DwhX7X+VEeJsUz4rSERBTe
	6aBRumj09HYzJqdz6XS0QrKqocCB33giP37Sbc/wZNWw9S8FnO4juMWnmsXaUKEk
	QgLkUjgd4xYFbJouPdAfbu2X427DyyUiWcTcqrRQi5aVj729HKfJHxETQJ8z8Av7
	DPUm4RpfmcTx4fKxAjOAKbTd772ENtRgrfIgEwZIkDWzo5y8D2MjD7EN+ES48pqb
	w400QOlLJWHjZJs63fcMn6upsgeB/AoPO2ASxfw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:/4rTctxAA92FLccydlasUhTOA8nD6YVjGv9mRMGX2ps=:YiAnyHSE/UYNJ17KQnb3tyZxgu4LEq5Sh0CRIIf1t8M=;
X-ME-Sender: <xms:mPnYaj6JV3BynbKYf-E_U4-U5iit0fvXe5xCvOXZmo8bKxQ-lrVCGQ>
    <xme:mPnYarInicI5ohdT_QVTZQlFMWGUORRwHG9AxqkiLzwIRHArAL94AKhx0tXbpor1Q
    gp3OjVHhsfekfRLhWRmRbUxR71y2t_Kx5zU76kjJcjGIyGYyUemEJU>
X-ME-Received: <xmr:mPnYasuua-05vp0yqvf8IaGYzEdrb9Tn_IcabxSltlZVTK3VQ-CIPK3LCu6paRViNRRPVUjDHj7zPd0IZ6HZ42pNYsZPflagbHOB>
X-ME-Proxy-Cause: dmFkZTE7t/4Zsget9VKVoqQo6RUw4wlZbtWfaxNJrk3fsGwIcDP0WXKl/igPtx91uNPxxh
    WbQG8GeCdExcItcnaObEj1AYuTooqWTtJN+q/2RvIGwYHUD9aBtZnHxj5MrVdLimbTiDVP
    oGdPDjas1npO4cvSvyIWXXJzFrWTA5kp6s5OifWw0OLAVW9B8t2HZvZ72dF65Yu3KUlUCA
    +h3Vj62CIjFE/m4Ru5yz+6sHyGVLaXBtDbypVBoeWO14EhYFr2LV88mvresiGWfDgiHM+i
    yaKBRaaxuz6Qnb4f0sgj0UK3uoNkA2ZmegSgAgdUulg7n1Im2wLRi9WuyYjReXKWMeD7n4
    2FokunUpRi3ZUMlJlvYSkdHJWBCJ0ZuxGW5MII2zrrfYtqLlDGT92rM3+A5XUMd+mn/7Hh
    x4eweslNef54PzDUD49hE8rT7t6UQQsK1fEkb6afsS8KIjlEgmT+LrHG/tlWj176FsCy38
    LGXMuafsnFKpfrYMIiyhQsNJrt0luHGM6a50NnBWTtFKh7FUTNhtu+aHFUXFORfCYDUdVo
    cgMWOeQlRPgxS1xwfDBWjgp+za/7QvoNHRfMXEscjKvvrl9ehmJxVUkzi0TKSjD7Hh8JoZ
    h7NyMUaNWtWaTaxHHTFwx4jHo4VZbrh2YIPIEHINJY5sIYcJYItw1MgXw13A
X-ME-Proxy: <xmx:mPnYaqI8t5EToK6KdZeujRiwLEmEG9WigSSJ92OZgMxJRrs8mqEdjg>
    <xmx:mPnYal8xi1SBVWBaselIRIO3KnLwQDl_zJdJVRQV-cGb-kQ10EONtQ>
    <xmx:mPnYajy_gEV7wayotm2E1HMtRvH7k-ziLr-JkNfDcz4wkPKNDNHPFQ>
    <xmx:mPnYai6wywpi5_6fahfBgyCIuM2oa_IvrLlg0bzu2ZkaSG2tMkZEhw>
    <xmx:mPnYalY3iWq0br64kqe8hiPfEovWZV8MqJfxrzu9D9jo07f4NoHcdTgU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 13:42:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Emily Shaffer
 <nasamuffin@google.com>,  Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH 1/2] hook: honor hook.<event>.enabled for the hookdir hook
In-Reply-To: <877bjc2im5.fsf@collabora.com> (Adrian Ratiu's message of "Tue,
	20 Oct 2026 23:59:46 +0300")
References: <pull.2272.git.1792520353.gitgitgadget@gmail.com>
	<1a7d060fae0decbe7dda63ec4ab57e32e0205df0.1792520353.git.gitgitgadget@gmail.com>
	<xmqqzew8us4s.fsf@gitster.g> <877bjc2im5.fsf@collabora.com>
Date: Wed, 21 Oct 2026 10:42:46 -0700
Message-ID: <xmqqbj8nosq1.fsf@gitster.g>
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

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> The suspicion is correct: I did not intend to disable the hookdir hooks
> via configs when I wrote that initially.
>
> My reasoning was something like "configs affect just the config-defined
> hooks, the traditional hookdir hooks behave the same as before". 
>
> So currently the doc is indeed just too loose.

Thanks for confirming my suspicion.  After re-reading the document,
I am not sure if it was overly loose (see below).

> However, having said that, I don't have a strong opinion and am ok
> either way, so if others think it's a good idea, we could accept this
> patch instead of fixing the doc. :)

I am undecided if we should treat it as a backward incompatible
change or if we should just label this change as a "bugfix".

The additional documentation in question said

    hook.<event>.enabled::
       Switch to enable or disable all hooks for the `<event>` hook event.
       When set to `false`, no hooks fire for that event, regardless of any
       per-hook `hook.<friendly-name>.enabled` settings. Defaults to `true`.
       See linkgit:git-hook[1].

which talks about "hook.<friendly-name>.enabled" setting, hinting
that this is also about the hooks that can be controlled by that
other setting, which was added by 1ecce722cd (hook: allow disabling
config hooks, 2026-02-19), which added "diable" specifically for
"config hooks", and the documentation from that addition says:

    hook.<friendly-name>.enabled::
	Whether the hook `hook.<name>` is enabled. Defaults to `true`.
	Set to `false` to disable the hook without removing its
	configuration. This is particularly useful when a hook is defined
	in a system or global config file and needs to be disabled for a
	specific repository. See linkgit:git-hook[1].

mentioning "removing its configuration", and "defined in ... config
file", to me, it is very clear that this configuration variable is
only about the hooks defined in the configuration system.

Which tempts me to say that the change being discussed is a backward
incompatible breakage, rather than a bugfix.

But casual end-users would of course do not know how the feature
evolved, and may not read the documentation of the feature they use
carefully enough.  So I dunno.  Perhaps changing the behaviour at
the same time updating the documentation to make it clear these
cover all kinds of hooks, not just the configuration-defined ones,
may be sufficient.

Thanks.

