Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793033688;
	b=fNWd/8ihOWjIIwQU9Zcdj0CplJUIG75RS3BgXV2BRUp0UlOoko9QEc7w41WF3OjXaMTf
	 OjHeI0lwLZ3WW/ptinDq5r31hnU+SO8YE68TPy7m8m/ZtwMZHX42YjEncolKWk1cZQkHN
	 t3iLsisFmVccYZwKh/XTdjbvJFFg0WQnjHVlYZPUk2Edb0wTxPL4Uu2Mrza7ph0V393Xt
	 uAXEdavXrlU/9ByqwWX+uXlWO6rzM64PA+uAmSn49rHpB+yjTsWXzABrPTGx9jWOENULg
	 nLTn5OMDHrZeSzm/IspNv9I+PvY8kop0bTRcgw946JS3l1Ekbsz5KdqRo5bUW+Q7XxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033688;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=uTtT+bFQSeblv7330SoLs4v2Snen1jx+I2Yr4Khz/ZI=;
	b=uTEbB3B8+SESaPqqv+1aMnrtziC1QvPUyluOrRIXfcxszdfospDrmJULmgoO/FbW2vtU
	 cWOAoCp7lL8pmSgxYhTN7DZ6zrqPGUWKdqHflsN94qFi0w3u3Bq5xht+JaZYCig7xwo6N
	 dbvoIVF6eXgVdFgV88WoAQVKsKVSroEl0jg8onv62+zDjErMYoywhhQGgqW/PumUitHfp
	 41XlbBkuI2DZD2i1aWe1wUWWwduRegKwzwK1K3EZvcalgaisC09z+2pkwCmJETJh+FlHb
	 Q9OAori/Ioh9b9Wt+8YJx0FyyQSqWF97vsX5uuAA//xabcNxbZiJLx441H09b2a8l9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=lxAOkHSd;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UanNWM7J;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD7D606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 16:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CD7D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=lxAOkHSd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UanNWM7J
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A902B7A03EC
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 12:54:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 26 Oct 2026 12:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793033686; x=1793120086; bh=uTtT+bFQSe
	blv7330SoLs4v2Snen1jx+I2Yr4Khz/ZI=; b=lxAOkHSdr95BKtVxnRSqXO+vyF
	NDui3DDNexFxOpJFSuR3MPI7ZTE3Laz+DgleP0R9e1r7qsjUjpfJDaQbFict2xvj
	VGUzsOur7GNPXZDoRkeK0l86QR4cgcNkdJ2SQC3ygRGmIweNwLuBQOZuoC1xh9K9
	jRLLxG2jI7uxXjT/XCwl196yjpLsZHkDU9IQ1d3f4myjoYN8BAvuWWmAzmpLPCcg
	m1/eUlFbX/u6W9G1bDKWcJf1Lfq91BCu7mhVwVrLfh95X9sm+oyizc5OB8VjRaBt
	V/8uHjoK/tDzP0OcKg44C/XcP6nDDIlRvRpHXAHb7i0k4FdtO3b9o0f28QMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793033686; x=1793120086; bh=uTtT+bFQSeblv7330SoLs4v2Snen1jx+I2Y
	r4Khz/ZI=; b=UanNWM7J7CACJ+xwSDxHSzhz9osrqWFVXay9Do+kyvkLkRz8/9X
	tElGTog5blVdX4R2IIhKTJixWxZgApSfhWO4BklmxvB2eiopH2ino3MKn4p41l+7
	LwJwYCdubrx5WkYYhrqVO2pBPNYNeSX5f+Wvee6DeKDY4zbyPoPZU+P4J3j/3XNM
	YX5Qrl+S60irgKJvE9C7g1KPooSdwDsM7+d65b+wOCVGpdsOyfAJ69SLPjC13BbL
	U2FE4nvK1/B2LTWlHGNhLJEewEjyzNC/vk4DI6OAJXdyK4cGUaNxZgSgI/xp/dpB
	Yr2nXGEsW+yimC5nsz1b7YFmTFDR50bn35A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793033686; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Ag1fOnW+lOAmocDJRlowKi+b8aQ12A87gd+UDxAGCmR9W9t
	vWCSwcMQyTLT3d6fYmaAMgcdfNXjQyVB3Web6C1IBGRTrngZraPf3t/n/wbLH1Hc
	cvarDcD8FloG7czTCoybfBH8fOjzW7OvWEirH4LJUEn58/FPLm4ArVjbzIHHWkiG
	ZfseGe8QkbmoPIiAE9oqDHv+WnN0K94M2uCKqzxq3swb+3f35Uhk8blEcWnEFoLd
	cgPC9Fox0+6TzYXXrhExjVPI9ZV48jT70/OWQnb7S9po7TXnBDHcWMF8CPA2Jjpb
	Z543bUeHs8Lk9I83psgEozLQj6qEPxOg6qsAzTw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ex/oJwZCUHJP36bY8TglROW+0Fo3wbnILGlEM7x7wpc=:gQe4phg0GFjISMVqWChIn3QGut7QOKJzSHqZvzhYIrE=;
X-ME-Sender: <xms:1YXfarxlK04-Yvef47ED7offosfPaZcFS-n-SB2DPOkdv9tpOwUG9w>
    <xme:1YXfaqIfXjJgRWUSNcbnrH9YRhUDcBKVs_0LYbbHkDeyaljpMPqXr51m6Ea_MJcjf
    qw55Pc_fgQZa9vY55_HxajLoNv4k8SA26ikifle0PrEHeuBmpfypNY>
X-ME-Received: <xmr:1YXfatqW6UrGmOPw5prg21RShs25mXv5i8vk4v5fWUGWW_v8gKZAKWr3_vKHJfYFy12VAG8NNz1Y7NFG7JSvEGcAoDwSuOvhXgr4>
X-ME-Proxy-Cause: dmFkZTG2dQMVCtFWDmFawl8o7i3z8njturd0O6gi0/+pxeHPnZet95FndkVn3YWEgCQjRe
    hSpbaDTh3X/R94hKV3/fRfMVrG5vlZ4djuTS1cbfLCHw56bSTJl5x2Pfkwv2zgetCRbyuR
    10LWcU4kLPkjoCJm3ZO2OrJc7MVCnTLNAG7BnZNRx1WCgbjLXveCHQ4TZj5MoIXDQkgrkX
    m/uUWoVbh4iFx24IQxQV/SGYdF4R5vulOUqtds+G0akjzYO3X1trrDeoF5ARk/FghdVlD4
    B05xR+QqVWORU/hkMaOM6EKrqjJdrlDTQdAnVm7hf/AVCUVTM9qIWPmVcLhypEoZ/MC/se
    4LIykesVme12JiVGZ5Bp8BbQvqAB+mQjuC4uk6rriYAqiFkwfqrc10zchaLLpmoBuVl92Y
    uqz8/GIVqPqhS1pAg4oIg5+TDDpt9JMIStjaZPvOLx4rYEjOPQmFGETnT8JkkyD4zCNHCL
    01wnNQHHSyVDk2NaakCFPY3O0ggUU8v7e1t8dxE254ajS9EDxrfHDzrEGkNLhB63gbZF/2
    GTEEN5dsyzFxMzBSTfc3KNaXFkKtWVxzHR4H5NimVisr91APCrE7VlkE4JNIgVFRoMW7EF
    ChAtY7ASHeO1Cnds3gB5TdIBX1T5q7hDhLDv5LUSnQIi1ClFyq5FK6MRN+GQ
X-ME-Proxy: <xmx:1YXfahJBlmU-Uv1e5yyYdva9QUraSSS9uSYoTAbiLAt4_L-33oC4VA>
    <xmx:1YXfaqSdHQ14jZ1qRlB2VrUuxesGz48wwq9ti0nb3M-tO9Q9wdGe9g>
    <xmx:1YXfaovQacDto6dBAgrid8IFS6r371ysV6fpnuF_gLZdvk6Aq2h33g>
    <xmx:1YXfajb1xx5YsN05Ykxmxl5nr2gAttfh9rKwzq1-7RmhcUnLM92QTA>
    <xmx:1oXfasbtV9I1NkgND5bhzDMihjzGG1eb-CZlFCIcHZ4p2oEeHumuRtkL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 12:54:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ci: drop quarantine removal for macos perforce
 binaries
In-Reply-To: <CAHwyqnX2MdcKBLL5Z9Xb9XznKCkOLfztk5bM-OdkJuaOBF0LMQ@mail.gmail.com>
	(Harald Nordgren's message of "Mon, 26 Oct 2026 14:49:00 +0200")
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
	<pull.2403.v3.git.git.1793008465.gitgitgadget@gmail.com>
	<e85ce85d921f5c847c4a370a5c56c98f2f20cee2.1793008465.git.gitgitgadget@gmail.com>
	<at80qOfTn5_YUY_f@pks.im>
	<CAHwyqnX2MdcKBLL5Z9Xb9XznKCkOLfztk5bM-OdkJuaOBF0LMQ@mail.gmail.com>
Date: Mon, 26 Oct 2026 09:54:44 -0700
Message-ID: <xmqqse1ss8q3.fsf@gitster.g>
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

>> > A file downloaded with wget never gets com.apple.quarantine set,
>> > only Safari, Finder, and AirDrop apply that attribute through the
>> > LaunchServices quarantine API.
>>
>> This is the explanation why we can remove the flag, but we haven't even
>> talked about the observation or what we want to do.
>
> I'll take a look at that.
>
>> > 5ed9fc3fc8 (ci: prevent `perforce` from being quarantined,
>> > 2020-02-27) added this to stop p4d -V from hanging on a GUI
>>
>> Nit: you start talking about "this" without even saying what "this" is.
>
> Ok.

Will look forward to seeing this step updated.  Nevertheless, thanks
for finding why we can remove this line and making it into a
separate commit.

