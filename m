Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516968;
	b=zp3+1AFenGcnGL4vtLqL81YLx6svCkrzwe3ptwNSa9N1yEaQagZkpNSYXCkAbJ6gEcaO
	 UKfmflmffjKo1KGnns0blY4hVpiO+K6BwU4I53/o1dzEGktAPemTXPHsLYc2G5sCgfb0L
	 Hiq3mbWAM4GKAvs3IcXRXiN2+KgZKNlzs4MOyGnaBTaHiC1WAl8J8uN2BZIi/xdchly98
	 idt9kTM+/9Br9ywmgmWsQHfLxmVSrKP7eJxjG6CtfD/FSBrVQ/okQnKeO//7JsTNDRJrs
	 aMu4iqQXBN8Uxz70uVFUD+K2qeWIifV67PYhHXjwpxmFK0GH5kCpZI0IUpLOaZ5cZoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516968;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EGClsCVLvELCmLEb4ZvdtV4NlKryj8TV4Ho5KXeegTU=;
	b=p5dHwlP5KacXy10l02nqtUZnBQmgd+ogFSmo0UFlHmn3xfAR7O+PcjgX84O0vVzWaHhz
	 bia/K4SyiubjN3qNgG8F4wsyMy/IQoALCdCqJJ156nnQ33IotYqfWrs7tPg0aKmTYWoEr
	 SqfRW5BNty/EZiULCwaul1P7buskNxIhhz0T33KsxN14AuqNdP6cNgGpQWB2lLF1Rt+/i
	 rFId53tKgSIhs0OqiByLnzzLBkpYPKNUk8sL6+m9Hn5pukYkpBbCcZtS+Y1OEbxBFAJf3
	 +8jn8iiGmy72uq1s5TWZKSd1QWAWRtzJI8SKB8giZdP1+1azrI9IX6dwYwQAcuH+7Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hfQj3Ip0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=aLOPE52m;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48BE606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 20:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A48BE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hfQj3Ip0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=aLOPE52m
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 04B631D00648
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 15:56:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 12 Nov 2026 15:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794516966;
	 x=1794603366; bh=EGClsCVLvELCmLEb4ZvdtV4NlKryj8TV4Ho5KXeegTU=; b=
	hfQj3Ip0qEzJnxehriIlUa2DcGPD2UQVkCnyASL2vBsiSysCjbpCoetfjkZm+/IN
	Un/iC0OfMpxbOAmspM1DcaQ5li+VPtFvdIx8TwtVYYHH7JA3HjRjcoPB/U59zAIY
	PZsE9u96CUbaEozHpxGkXHD8Em6U539i+u0ERCGgSdo/62kVUT1sJJmhCSlcaskB
	jvbaQ3DluWdtI8ONJphqmAdZ7ea8VI4GwxCQ418iIwZas7rGWzK0/YeDsWcIJlJH
	m+qLRnzzmFHSCvChgdhO3yoUC4FUkd/22axCPBejszk3XKqUOHewp0QuymtKAGgp
	rET/4CtrxMfiOQ3RmCvTdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794516966; x=
	1794603366; bh=EGClsCVLvELCmLEb4ZvdtV4NlKryj8TV4Ho5KXeegTU=; b=a
	LOPE52mELSaklKwLrxcPOMlENzw1TgAW+EBckb1PWlyuJlj8j7lUmajTcqmYi7BL
	YnmVjk5HjerE+ASY130ZXQNYiGi+XyyJjLgt5hBjjeLK5bTmnWPbF3p760S4+1Is
	Ixwp2vKdbehK0xv5STSx9tKxccScLcAHTbcIKUsuZMHLiv4py6Qg37pBlrzrEdrn
	CDYg8fwbe1lbbZDOMPGLSopWtnlLQdrj6Cuvrs3ON6aEVKXs8P1QW4d+pzWeLuSD
	Ro2QJ29zKv7mSVK7li87D7SnOg38FJ8VD9cQXGl/TjE3L2AD+fsA2KNxI4eHXGdL
	d2QZxv9xtTI0vgfszF+ZQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794516966; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lLMAgYnw9nvzvEIf+NTGFEo7VZ23mrW2s3+/RgV1ATCiGQn
	eVt+6KrbVxnWWtFkHHFMN6qziNUBeA9ikkDOX6opyAj4PwXb2nkoKzK/uH3LMVCd
	jEK8hTj8FcdZa0WMRgB3yAHfC7ikJEck8V3MdcmUgVd17l0olg8+tngFX6xcFm96
	yscM+/skSt+G4MZuxhGJWAOsK2e8gwhmodiaCPnnKos1NCxuSWcJ8H27HlbCja9C
	E6bgvm9L5htJzK2QlSBgM/P7PzT4deHixy0xGrjR75dFK+B5qPnyajPtetHLQc/d
	qLqgvUVo4foQZ0q2Hv7N1uDb1BjTLDOB4+jGozQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:s9DC0q2wzDmnTNlPW72QOV05sRC2O5H/zyVps+8kuSc=:0jYE4YNB1/wJ33S3xTtAX0ZNE6VPCpCjZIn60OMukIs=;
X-ME-Sender: <xms:5if2aiydMCJQb361pnTh81OFkb1K-uokHfapJty4wVV_6TEMyA8OrA>
    <xme:5if2altrSvp8cM7qNwyXpK5Dj47yT4EG14ANHpqcgvt_QEJu29MGSOiUfLTn3xIqs
    20e2q3y3Z5dovsYH0efSPNmxV7kjo2zRA_Kuy_FIXnJJCIj43_zD5w>
X-ME-Received: <xmr:5if2ahuAhYQ571b6iYUIuBo5xht6sookTiykz5Xg2yj2wZqQ60LFpZWDAdJmZr4PDjvqDZgRuFMRZmH4s28swUytjycX4t48trYv>
X-ME-Proxy-Cause: dmFkZTGyweh2PyETTxo/Q4BrQPFT8Uy+mPIMHg3KUfZfFGab7YJ2jwBwRey32gcp2aLB5r
    Rcn/a/8/6zxUrvRzs+zQhqN3NvfZoJ4FvNs4mpu/7YrfJhdzUzVQ1Th8GBoetIkpGhuq92
    Olzq9JR6PCdYQbG+zE6Ot0iP4gOYclyuSvIblBbsdX0LrigEITzhQvMvYxk3OFdFEo3h52
    BCJucYfBO1ssaGM5RJKSM9oQkB4Iz5eGfrEuipdbu5sfBRyHtaabDSzdaYxqUKjXIxCLyo
    5adLRnZu7qPaU/4b6VpfXETWxZs0xLN7Nt2n8cmb7gGN20SxbM6LZH/ZqN+lhPSk47ZhsP
    NugItWD8Vkkl+XXqbMgDVTmR5OBJ0DCOmv8nYrWA3i38yxvXEbx33lLqPfNtvgMObm/pP9
    MtZw/TLA5JS5+PuGsg6AevjZVDL//cCeCAEsIA8RdJxzY1XF8kfA8rK+CMow0YWycRaFMn
    lxNnGTyDketkwj6rgH3mSlT+MGYNB+EU6sDo+s2jv7C1kLUa8aL3PVDPg9s8Ko0BReSqQn
    zeKx+HDqCxC+f1KA21W8J8bdkaGy3gIeoL+G3XmAzTihjuMzP/udx751X5dm8CckgbY9g5
    jwbN+bf9av/QZZkBAg/aYaVkWo6oQTqzECp2njIaFIJ+Z/oZmZXdoCKZCpJw
X-ME-Proxy: <xmx:5if2aiNRnsnhJoiFKt4IF3840FYJy81KEkkUpMkhcFOru8fhOERkZA>
    <xmx:5if2an1586VdxYS-BW1KQ0_DFzaMQuh9U0adlnKO3gyKZua3C0hWfA>
    <xmx:5if2amOJntenRxTifMEbs2voCQjGW7Ch24JTjAO93x3AEyRTwChFtA>
    <xmx:5if2av16Bi3g2zNnVmaMqUjREGcpHoFkceiNDXYw9xiz587ks5Pjrg>
    <xmx:5if2akRJalWgC72U4pJbZdTQuxCJw8-Q60gXZroP1GXGcGofYR3PZ7IA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 15:56:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jakub Kulik <jakub.kulik@oracle.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: several unquoted shell variables causing test failures on Solaris
In-Reply-To: <SJ0PR10MB5785807828F81EAC8CA165E78A702@SJ0PR10MB5785.namprd10.prod.outlook.com>
	(Jakub Kulik's message of "Thu, 12 Nov 2026 15:39:01 +0000")
References: <SJ0PR10MB5785807828F81EAC8CA165E78A702@SJ0PR10MB5785.namprd10.prod.outlook.com>
Date: Thu, 12 Nov 2026 12:56:05 -0800
Message-ID: <xmqqik21hiqi.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jakub Kulik <jakub.kulik@oracle.com> writes:

> Hi, when running tests on Solaris, I encountered several test failures in 't1017-cat-file-remote-object-info.sh' which look like this:
>
> ./test-lib.sh: line 1040: cd: /builds/components/git/build/amd64/t/trash directory.t1017-cat-file-remote-object-info/repo/parent/daemon_client_empty: No such file or directory
> not ok 12 - requesting only objectname echoes back
>
> The reason seems to be several unquoted variables (needed because
> of the space in path), and with the following change, the test is
> fixed again:

Strictly speaking, POSIX compliant shells do not require such
quoting for pathnames that are used as redirection target.

But some shells are buggy, and our Documentation/CodingGuidelines do
require them to be quoted.  It also does require there is no space
between redirection operator '>' and the filename, so the correct
formulation would be:

> -     echo_without_newline "$hello_content" > $daemon_parent/hello &&
> +     echo_without_newline "$hello_content" > "$daemon_parent/hello" &&

	echo_without_newline "$hello_content" >"$daemon_parent/hello" &&

Care to submit an official fix with commit log message and sign off?

Thanks.
