Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513780;
	b=Zl+LZcQOnZ3at/5thNUX4uYlEHe0AdJ3xKrZVbJY8Hr+IROsT2P0mDMbJfJlShkBI0eL
	 cwZMAozTPvw1Y608TEfyZP2bXjrcmkuAWjr0FCeCCteTB+VIviRU+2Mv8gaTfnfp/7Unx
	 7B4zacFhQGXAcGEM3s5ve27GagZNW/AVjZemMjri0a+dhVmvJeGQ+pNc6pUIsYyJiMuIo
	 j3jj76T3dIj9PLH34JSMmmQS8J8srdZebDfT1d+6UieZn+X6QWkv2KltgUXSVdf3uSn7P
	 kXFo1eyyZFn6cCv/B53f9DcsBbxRqnwNzaZwo2PLP1UjHDUzhlBb4xM//WDThCqbR0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513780;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=tk1ams3MoLCLskvCNlJJpMtH+0qv2u89zoyPbonAdT4=;
	b=Pvbpdwh3ndXfBwen8iqdnGBMe7Gig/EPrtJOkfPbWIn3gzd3zCEKergdRWJU/rWPDniQ
	 4BgdEiriRj2f40OJkWl0HdSQyoQf3QuKBGrv+JwuNmF/sZF3NuahzS9Y/mWWN+8uujdbv
	 xWOZG7w6t4qkLgDXo51EkZGb3GefmCbrz3afz2hg4yhBjP2B/+K8wBa8k71TqEhlGI+SS
	 aHFtQQSAs0yGQfoPI5n4f2CoQ2Rjtfsf6T649r8OnFCriFHWXCzKOOGe/Y3hOwQ1oXXlj
	 MSvFZoUmzn07nAL1yoLsgp1w6jPoHhbSYQGHv/M2i127Iuboy6aA5lgBLI0Jeww4F+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=MAcusDwG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="n/W9P07e";
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5553606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 16:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5553606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=MAcusDwG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=n/W9P07e
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0CFCDEC0202
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 12:29:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 20 Oct 2026 12:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792513778; x=1792600178; bh=tk1ams3MoL
	CLskvCNlJJpMtH+0qv2u89zoyPbonAdT4=; b=MAcusDwGKM8OcioIp8wEIv3lE/
	S3My3Ae/s5hymT9CKQyMrZ96CF2lGRZ5Qj/HvkgYw/dUxFOvz0Pc8ywilBWzEkfF
	OyHed0gaO+Sj10846s9Pt95hSdV4zu8I5UbBxVXYlzxBSD2YSS4+9RxpRs7sk6qm
	vJQShHb30OCqZQU45qbrrZ4f7vAsv7bgc71CpYHEH4hksd5H/s4SEHnHCULbLrcc
	5s6T9OqhPs9SF0LFwuvstIq9bIpFUjPNMU9MBtGu8n+d3aovHL2hvOHHE2h/BkhM
	yz9CpNA3uNu9zfZUC0ZyMwO5Mj6IvizrYKXMxxOo4zDAZrgB+wuWfsCD4Hdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792513778; x=1792600178; bh=tk1ams3MoLCLskvCNlJJpMtH+0qv2u89zoy
	PbonAdT4=; b=n/W9P07eMVasgBwYdgDcJ8gkPddWp20dPFFkyBXeEA1z9BcBTys
	0L7/5k5/6y1oDcAgeVjsonoRjc42NJA1hoRE9FVC6UtM5lCNh2JAo3bDX7WBxPrk
	AfGSb2b/sa7o6VjCv3rzEuDN6CI1viwmX4V6ClfrFGRw61UWyUWMaIsVgSIRiOOt
	01LkCXcCKlXW9VLeuaVWuKT75OQsqMwWbOtD+kNMYW9nzWuuFlwn1dTTcxwJGi7t
	jTIKJV8SSE3tRY8Y+4uROXjdEqJmTZyfZQ3gFuWBjDQtK5PPwzCuwWbP5D0j38AJ
	jUuH9qQ9hGvYalefJy4goS4FlFeIk1NG34w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792513778; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:bO4Px1+HVzVcXOED+wClQPkk3L/9WiJRypYpvHevHrPLukp
	juQwXQfX6x6YycnTMg6u1sy8t9t/gdBnZDBGDvsqwliJuheAGFIcsGRiaStlcwxf
	Uwx6WZF7SmKzJL+gXHkkb5h0Or6d5naCymFo+BhXzZEmFObh65k+Jg3pKFA9hmti
	EsfONXbdqLbpHdyr233I0YYLlyeLQTMiN/9xqpGiBMlLNosBmJNb1tPmotnaOUpo
	4wEgjtIlP1HSECwOIZWmKFsUlExIpnT9+SoUjPft111rboD/8Z/LKnUjVCH9A18p
	nHafs/aqlaZG6sTuI/TTL5W86wiyBYbO1QW2l8Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:IkQDoMkwWg1ObQLCS7AY94vetD9dclJmEhi6QCtpRqo=:Jdxf+MAovmexbaO4JMl0p94mKsRHf9qLiDAE+sao6dY=;
X-ME-Sender: <xms:8pbXauO2rBYovXUl5_fadn-_oHiOyiwgD52gEPYBmUTyai-uTIw9yg>
    <xme:8pbXaj23SmIc3JiaSrkm--Ha8kwpBJURmzoSikGm3qj93CCUlCmdNSK0Qc1L8rniY
    eK2eQ35vFGaBi1vD5C3X4XKdzn64vx8YRHTxJlWqSyqDOSL0AR1mbgN>
X-ME-Received: <xmr:8pbXatllv2_mc8Gkdi4HV0HgxyPPctid_ElHGQEiFevDU4g5PZh7JaS3Jz-mxzGj5oIXqg8eKJrg7ahuTHuKgY2EGbRmruNeiD00>
X-ME-Proxy-Cause: dmFkZTFekSWWbd+oM94tcANOR7X3OgLiwV8H9FCGf/ha8lFnU0o49eFROCsKcHeO/zAKB3
    8aESVBmJOudDxpp2hVvDFXqqsW+xrHg7usAsGv3qDxRTNjd5/ZGLOmaSgN8Xi6FOGC9Sa3
    Kvs2h8M2S1L8i4kd2JW8kgkV5ffQcMQrRUtmNmEhLIpsXkR34eloxNtIJM/fREh7p/E5aF
    QlmpxCQNRnxxDO4AtcyNOpTdNkG3WNtdNrGrKQkCMWFney5Ef3/qlGnrZZZBY8Y5MqfGTJ
    mjSZeVji7ErdAT9VZX72DrljIVyZrvhE+pA9LqHTZOPjaI8jIul4aI6E7QMrBLJbvhKlnI
    ktWEi1e3Sh/k+nN9gCbfyZdxyFE55Ygl42letoZ8+uOZ4NFY8zCPzU61H8kIw7QEErSzTg
    vn98x51RDTHx05tp1eTsV7UR4qBYUCrbRIOVI2xxuaCQpgBreq5qv6mstM95g9LlePZi7z
    c/RV3HC8PFIitraT4Ak6YL5YHBflvrkXk4ID5SA/2n4XaiXp9z7jKpg/ng+LQnpGG7ZVXo
    6q1KBbSVPCi/V1yBJNk3nsVs8+nh4RvpXCKZbS7nOhtBmkDeugDnImJOVOze4Y6hOPgj5U
    MWSuMuYr7j2nj5ZrcslN8sBImeeyrmXYxIaqvOknmlEcnRX5nGpxHwVp8ESw
X-ME-Proxy: <xmx:8pbXaqV9rCHxTKG8K5cGjmUt_FGLot5BNBNIXjEkA7uUYgSnFNq8wg>
    <xmx:8pbXajt6hW7Sjv2nVi-nFApd2ng35LTqDS8dlO5SeeSBAUZNE8XJkA>
    <xmx:8pbXatZmBteT3Hf6AdwJM3gFLIGXVFzDlGM8sd-z8zSq2hh4fxjxfA>
    <xmx:8pbXaiVVnwU0quEPS-pXiASUCRIQf_E_8wX9n3Q8iMRI4PK7Jb1qqg>
    <xmx:8pbXag64C7bUvOJXry3y5FRkMqx7ONS4gTYgIdVKEgFB6-a0ISheFhWQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 12:29:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  Matt Hunter <m@lfurio.us>,
  git@vger.kernel.org
Subject: Re: [PATCH] init: show absolute path of (re)initialized repository
In-Reply-To: <atd8mopIi44pMBAC@pks.im> (Patrick Steinhardt's message of "Tue,
	20 Oct 2026 16:37:14 +0200")
References: <20261020053932.1274210-1-m@lfurio.us> <atcQb_V69vvKnxoF@pks.im>
	<CAHwyqnVf++okhdjUuVewkK5ZhqbKSoE3TixhpNORdWrMGUA=mw@mail.gmail.com>
	<atd8mopIi44pMBAC@pks.im>
Date: Tue, 20 Oct 2026 09:29:36 -0700
Message-ID: <xmqqfqy0xrm7.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Oct 20, 2026 at 02:37:05PM +0200, Harald Nordgren wrote:
>> > I'm a bit on the fence about whether we want to have a regression test
>> > or not. It feels like a very specific thing in the user-facing output,
>> > so it's a bit dubious whether it's really worth it. But on the other
>> > hand, folks like you seem to care enough to make the test worthwhile, so
>> > maybe we should have one?
>> 
>> It seems self-evident that we need a regression test here. Because
>> it's specifically the thing that would have prevented it, and the only
>> thing that will prevent a new regression later on :)
>
> I wouldn't necessarily say self-evident as the result isn't wrong. It's
> still correct, even though it has changed compared to the previous
> status quo.

It is correct in the sense that it is not wrong, but we cannot deny
that it is much less useful when trying to determine where the new
repository was created while reading a transcript that contains an
invocation of the 'git init' command.  One would need to go back
and see where the user in the transcript 'cd'ed to before issuing
the command.

This episode makes me wonder what other details, not captured in our
existing tests, users find useful and have grown accustomed to.

Thanks.
