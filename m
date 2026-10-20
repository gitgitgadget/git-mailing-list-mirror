Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521948;
	b=CpaNvq6uibSbk00UsxB1xsRCyYD2PwsM7GqyX3euIwxtyx0rEv/9f5LJs00+tsjW3CZj
	 GpUfX1DmQvKa+duR46QdNWPG+468lMwEtQKskyPffmpX/kQ82FpXDh2FfRxibSJWQukHu
	 idLDSCcEV3mUBEM61mwtU94AYGLQ9kAdO3mVe88DSMNvKInDyg9Rn0iZEFsgPAEHRwSNE
	 bcy0Vozh6l39dBD0mhm9Ok4kGw82n5ATZUMukeTIxn54Fq3WsxOB21JyapX1yTJycEqhn
	 w7yoY3Qyjhu9XjCjxHFAaI9TvRuKB0Qs46d4dEO6varpFRAf123lNjk58WqMrMa3d5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521948;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=v2seyrZ2SB+rsP+hkHLLFtS0o+LYHPoO8rZg0sjrR6Q=;
	b=KGk3xFe6NBRX/rqAaW89IFxtutwJFSRgFVeAA08fbzFYcTveiXtSXZj7RO+7kiIeIKiq
	 Y1oUwsJl7y6iXrdwfq5ibFk3WLod4Lj2Wn0S/o+rQVbVne/wd9siu5uJpt94QOm5Ek+fB
	 Om2i6EI3Kg57vHYF6ZyUNc2SkLUc+6JtYLKmMEVyRX0eFo/KlTtjW3+aHH6yudzyb9os6
	 nNeAvkVAJKAfiPA7z5CABHbDiS8cFk2DwXSmFKPYzdrqohzf9xpl77VyCYMZ8Hfd4c1Np
	 rSf4d6ELyvQpIhYgN/EDIrDestyXwu0El3GyxHNiIoPsTGIA8ZQFZGgqH4kA99PaCiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="gjv2ED/M";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lAVRJl8j;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF77B606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 18:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF77B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=gjv2ED/M;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lAVRJl8j
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2CA401400133
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 14:45:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 20 Oct 2026 14:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792521947; x=1792608347; bh=v2seyrZ2SB
	+rsP+hkHLLFtS0o+LYHPoO8rZg0sjrR6Q=; b=gjv2ED/M5PY+6C22B2FcIeNhOf
	kiPBnRDGHLLJdXOzwjqfQvqkIhPvc1LpTQDFmYf7qSDoE7ejM1HFfpd0ss+P1gAJ
	wk1aYmMtVY0pMsCDHApVWefhpo2zuPmB8KPF8XFhyYGVzVpHJe1OFaloyLqNIUPe
	J/aOMw/ddpbmaYAO70qtDCfy1ilqcsDnio/8SGxB9SYo6UMxboISOSnmd+SfAwhg
	2Jk2u1qjsPp7j2IGiz6ayjDNDdP/0pV+cbmTrDJCOrv4IcrsA+CbZpxgscGGYmQW
	uo7TuVddMsLZnSEfwr/kyB9QoNWewy9jLRo9YnIvJAk47fNqGD5UpBKqg6mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792521947; x=1792608347; bh=v2seyrZ2SB+rsP+hkHLLFtS0o+LYHPoO8rZ
	g0sjrR6Q=; b=lAVRJl8j38DSXswM7cbSx7wNRTSiwX/wQA0/NcZ6/uipwyc4+m0
	+EwIcU4Ho+56N8Ci/roSYeKHvoFFdBuMrkg8gVmbFooPgfG7oeikLEUzX04jUwxu
	MzRlX6heahGosOwOImAtgzFy2AEErsyScfXsYrtxm3GAsgh0blXW3Cc3Ne0ytIQe
	tICcxYocRO3/D9Gf3WPqm2GOO0YuH7LdMMtyjsmKOlUywmZkgEujZ8DIXkSArdgw
	iEZaJcWSvk1Q+kxEyqbYudQy86MuCOF//UX7kmfpuCavoaRiZvQrLeO8BHT739yt
	f7zqzetDRU9B+VPLpRfknumq5eA9Ek59ayw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792521947; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:oOdMreygN/ZFl9LvXUZS2kSR7LUC1Z9Kt9U2dMnt1zrC0vZ
	EyY4t8tNDNx/fQRmtCo4y3nnc/w1/mb9+tbcVI1kQKLI32pvKERIW5KAcwJSNHB+
	aFszz9D9tkH6fjikhNEoVgCBk/bvTDlNezOu26/nRBP3ClVaavsq28G3uErwUKA8
	cLwbOJUnHtC1C0ZPYbW7bahth77ei1tTvYAhkf6RWpXuh3XqJQam0FlpfYBIAMmH
	U2+JIqVZ/eKVAmbxRqV6ToZqC5P2Yy7cD+eDszUWQ4U79gmhUP2Ag/XO44cqhjTP
	e4M0qMf0Ld/UlE4RAhKjqK6tqXlgM4oQWjvwqiw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Zi9D5zaDJecX6P4VMVZGB20AOyRxe1kesyErYS7fwEA=:fDqn9cJtL7za92GJ6Zt/Bi4MXJMAGFNC5K0eLCXMNQg=;
X-ME-Sender: <xms:2rbXag71LDzcxFtPxyf820jc2U_txTwfhA5Z1WnSfEOiOj8hVowBNg>
    <xme:2rbXao6rZXORkkkQrEs6Dc49RQtYE32wg60e27fP_coL0N1mySSOCyeJfpzn_LrPT
    sFuvPzTobiR5WCNuKtyt_kCYca6L-eRx_6k465RGJuZVkXr8f6G6XM>
X-ME-Received: <xmr:2rbXaketPTNTv07H9fSOiHWZryMnQS-gBTK-j3I3FxonBUG-BhgKK-lDgaBhOsNmMb27H9l1ruODULl3hvOxRfieghIZVaQdEirn>
X-ME-Proxy-Cause: dmFkZTG1I7u0Rtcs9btKuxNz6sbfYzz/TP8Vy3F4jHYTAMiEheqXxAN/hy0J6mjfzFoVx8
    cH+vlUDU2UmnSaTMvOaJ6RfGM+cvrEgAPAwhw4FkfvtPY7SLC0dyRZL/fa1BH/X8JSRfwL
    Bst6uQA07uHNSp1L0PCmnzbBxIRBlJz2L2+jBLZqF0EVN//386909adQ5868rwWZvaBs5J
    YEmjO/7RZwU+oC7Axr9g77f0h/voAgvyBTL8n+B0CVxecqYcCRyUIizG7WvqNQrvEJ/45o
    ySTVjAy68crYtAZtAGgpR0lX8b4sWLPOKUtMkwokSb7ugeihuu+3ASzOPWx8nw8YG7GKAR
    ayn3n83PfPmzqh5OoE/ezdgBaNBZuS/yKMXg7GwPuGOkuNXwtN8WkPHVvRVoi+YQvZra/n
    eVVPBF+zytAUsuVRcqBluw5LzJsra/oljKyr6CTfP7DxeqtmDbReI6yr89DcYpAuXHKH4o
    5yNH6/BUW1YN+j3KSW+Cu8PaeTJUKXkpa2snu6/Dwi9pZyoKtj8UriZT3Ou0zxeseQdidq
    Pua9YvS7qNx6FB9zPibc2qBp3+xFqqAibJSlu2h3nLq9XpJDJpeQrwonywS5wbtL+80G/3
    /xU0YMmUo0VpZktJeWNqLQI2f5vTtdua4sbQmCphwBNo0kWy+eXLBiZUBUfg
X-ME-Proxy: <xmx:2rbXakCfhGPwNsWI8AIQntHBsU9z6-svm3DAGzLLpiLl0H9mYZQ3jw>
    <xmx:2rbXav-DzIJKWbhJfOAxN1963a7EkOI5rIH_AtUAPe7cVVUxc893uw>
    <xmx:2rbXanKbVY_4DMDDNFjaKCIIMj9nBWuZ_BCjjgK0FOhoeCKFa1fmdA>
    <xmx:2rbXagivHqI3vbBs6Ag9PB0XNCtTVNgz2Z1QMHsgMb4V4DaRl8pGJQ>
    <xmx:27bXaj-SHLtLfcDb2TD6656qF2USMeA_EYwJC6YzTMsLWNKDlov13dEi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 14:45:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Julia Evans <julia@jvns.ca>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
In-Reply-To: <xmqqh5igw7l2.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	20 Oct 2026 11:27:37 -0700")
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
	<41dca2e8e0c5fadb8ad9ed8707029356e56cc540.1791315422.git.gitgitgadget@gmail.com>
	<xmqqzew8wb3g.fsf@gitster.g>
	<CD1E58AB-4884-4433-9AB8-460FE9A882FC@jvns.ca>
	<xmqqh5igw7l2.fsf@gitster.g>
Date: Tue, 20 Oct 2026 11:45:45 -0700
Message-ID: <xmqq1p9kw6qu.fsf@gitster.g>
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

> Julia Evans <julia@jvns.ca> writes:
>
>>> The goal is well described, and overall the tutorial is well-paced
>>> and avoids common beginner traps.  Since Ben has covered the text
>>> fairly well, the remainder of this message has just some leftover
>>> nitpicks.
>
> My local build of 'seen' just saw these:
>
> gittutorial.adoc:124: section delimiter not preceded by an empty line
> gittutorial.adoc:487: section delimiter not preceded by an empty line
>
> I haven't checked what these two lines contain yet.

Now I have.  It was the underline-hyphen thing.  The earlier one is
for Step 3. I missed, and the later one is what I pointed out in the
nitpick.
