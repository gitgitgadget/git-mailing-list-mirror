Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775100;
	b=RLpEk/9fZ8M1v0nSI8bZJkx0qGkTBkbSQ2L/0Dwmr9873hFCYKzaiKWfPUXOid11dNvj
	 iDuYVXGdTme6Z51ANxVd8/ZPICMRCTZTvCi9LLlMh3X5gcDcK2I6yOtuZA14rzcTa3Ihk
	 gqTjAiwbIQmAjKk1TTpsSTX1Q8PKjmXxsTWjNNspGuLqqhB69Gltlvo3nsG6NRLMqtjna
	 CUr7gl9Znb1DHnJ4r2RifxfqBD2x4EMUGCTUY684dfApjiwc1QVw/I9Qky3YB/ZbCJfcO
	 k3SIyaulBvGP//AINYIB4BtqVXxf6jrUbRznfRo86scbC8I5UXNGUD28kaqZxIwLumg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775100;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=oYTdhDkdo1WfgmIRjqKNDSgqz7zEJONmLyfzt3c8qCw=;
	b=mX9pwimJDqV4hfuVV4prFgngL+YF/6i/Nn3hulXaBAYfp5xEs1IoJ1XjaQTmoQr1bS5b
	 8HspvOs0KA67ytyjgxtvK0wPEOqiGWj7dj0erT6QAre6MvDB+tJKPdyb7qkHv57JgIn+C
	 5XCIXa6L6ToFNsxrRFr4K18BPU6D15nJdnqcKb6+MCcp6N5vl0VjG0n7rqjx5C5t2DQOY
	 WM7l6FoQhlCnXCD/i0HvS2Hslc4r6xJtP5p5GIv656EI3CzmiMw7wemhvv96v5gdfALt5
	 AoyetCeWwflie8yZvlJpZdfr7OL3tIEvzhA12fko9To10nBcqtnpuGN04kbEopDqIlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=KEosb037;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Ja025MSq;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EA1606A31B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 17:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80EA1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=KEosb037;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Ja025MSq
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B5900EC0297
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:04:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 23 Oct 2026 13:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792775098; x=1792861498; bh=oYTdhDkdo1
	WfgmIRjqKNDSgqz7zEJONmLyfzt3c8qCw=; b=KEosb037Ur/9HdaajXj/bi2fRO
	ThijsvYo6Sat9xGE8fT1/O47r8pyaN6sL9hOyj8jBdGE69gaDOM4TNjOfdsoK5kw
	JuA2hGRp4fE+/0NM0worMxI8MEqlXAsy44Y2+ICU/g/yMPD2bA/SsOoh3iPFvo6E
	wWiOJ6oDn/yjROVPhuS+9HOfrodTxvOroxUXWF4tyLkH/Eh/DBGHu/iNsSMSks39
	ZHiN8Rdft3FXkunDcg7tOHNQb95RQBAOmyNGEmZaQ29TqRB2eibuL3R91Y6I340k
	yjwjeezuaklfY79u8+ru530VDopYSZcFGC3pBGck++4JfOczFsUlSPa1+lnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792775098; x=1792861498; bh=oYTdhDkdo1WfgmIRjqKNDSgqz7zEJONmLyf
	zt3c8qCw=; b=Ja025MSqPS19zm9el43xgWL06N9Y8yO4PAaEuPf8dE9WiPnjvHx
	XzkaQ0OXApmzjzd8QtiKcfXi6TxxtGtE0qT7dak4FnJh9UbAwqSTN4dumlDbCy+G
	oQJI8DOZMq5jOiSlA9WM3WDPAYfSqv49bUJsV3s42oNM4Ed0ZnOFO9UEEEhJvpMb
	e3htrvMiK0El2oemo/2qdD/9KE5m79hZE2pvR5hFKITnqHwTKP6YvWAnsf7Tduzc
	CKHWOf4UaPc77aLvxwV2S2TYkpMEG8pZhWrNYi94/CHDvfBFmD/0QsXC2+1p9It4
	HH3ZJHFPvxrNq//dpIRHTezvDxg3+pvTONA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792775098; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:OxZu9JMaHaD3b1b3iXoGpH27COvkh46SNvgNUpzhqD3tydg
	u27EE18XYU83g64NBX+GaTYb6wjEKe6o6naDvOp/qYrrov+0Rjm/f57GGVsztz5F
	bS7iIV4hvImEr4yNua22oAya/yhYYmMlvUDl6nFItLgv3eKVmKQbyeq5jMZJiRvN
	Xvgzeb1pUCW7Caw4uN+oXbSUQpxzopAPRi6ze3XbLPI+vkR9r7JpcVTXvSSYF1tS
	b2OrcVAWa+14A5HXb7K336DB9UW71kWX1JQCiTsOBEWaCJDyOdqLdFbPyNkhhAU0
	h5DRTwnWYN5qlCWVCkBGBUY++54ftP7Yg6mxhRw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:J5+pAomMRdiQ82ffgYkBUBANC1pkzdvU+9zzhP9wWqA=:myJKI8g8huh3GvwBS4kGmNiXY8ju5ojtbNZncnU01Co=;
X-ME-Sender: <xms:upPbaoSz1hsWPfk7t2dBNNsSoeNO6R44NwRpex0Z0kq9mJjjpRDxCw>
    <xme:upPbatP-NGc9QaMPU41XTPuTsUu28n1P3yUO19PWqnVixUVNEhkoYbxMJHpUPmJPj
    8yiKEh462K51NOss3LIQ4NCgMmYumjhamp2xOp2KmzYZrQKnHnj6A>
X-ME-Received: <xmr:upPbajMahKeo-_grYq5Ak9d2uItfwyTkMBksrrBYfp1nJww3NwkQxNGWljXp63jM9-2JOkUyAOXPm3P9NSb-9K_dWImPH-i0DmSH>
X-ME-Proxy-Cause: dmFkZTGg+KJ09hFrgtjBhgfFVmE0M63MnL1CZKzBlmFfuecn/IIZNDLrOjcEqcOUkw1HcO
    5pcQppf0M0EBrMdrmVKAKRhOJbE07qD6Wqo1F58lqQMYSgMv9G3fjYalUJX3HbTOVqGPCx
    guLkBCaU5/O0miEMlQi96u2rZXOoxxJyC3oAe1OeZLml0abb2xxhQfkUNEUzhLMfjJ8eKX
    BLai/6fLSUQdGjLhzPrO6U3JuiebCml6qFd5pSAiuEXrYAmFjAo6cGWl+92s8R0+4JrBIn
    lFQ6b231L12XM9j433eSLVPOmiDN+mrEqY2lNIiej1gRapdD2wdvayPTOpKUYmOn8y8+J+
    4BJ/EUhZh0OLcnEM1Soakz5aj478BkFFzXgBwKdLrNJiRE0jFv4rutG4hdSS4xA24tKeuZ
    IDxmfFVAwDgKSAsja58NBHJ0BaA2h4wF3nIAtk2aGekd3R3FmRSGb2XxsUID4dvoDPNDh2
    EMSmDC3fm/UKW6WDdGWzf+5czWhURCkY0FEn4HoYaCX/vReSRFc8GtOVdvnCTML4MdVTue
    d71XCIzMe+s2BIObM3peAig0ISOHPHt+WzN4761FCLNOL+P1vcINjqg0DPt68ssqN9QfvP
    RnAD6cX7MHB35CbxDHRhbakc/m5cb9IfgUXKbPh9JaG55RCpVC/rCM41eytg
X-ME-Proxy: <xmx:upPbalt9l0xgQGKjoCXDBx8xXtcCpYtLsb2mg8oQsDK-rmVom-cz7w>
    <xmx:upPbalWdZZtUwnLXyj5bYvMiQF0GCpn1OE7KTS8Jr4kTyIx6YblGLw>
    <xmx:upPbalvci0CHz2T9442rZCsjNRw8oFGVcoBOlWis8dibqxZQqbcNJw>
    <xmx:upPbapWePZ_GS5pCpGE7f2plBpiRFW1kLIj7RJZ_zFJ2_eV2K1lxQg>
    <xmx:upPbalVSLzGeemaios543A-rF-wSHemns0omKNjaMNdurkpgIVp7whmC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 13:04:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/7] rerere: get rid of global rerere cache state
In-Reply-To: <20261023-pks-rerere-wo-the-repository-v1-7-b6ac0c2e4b81@pks.im>
	(Patrick Steinhardt's message of "Fri, 23 Oct 2026 14:50:24 +0200")
References: <20261023-pks-rerere-wo-the-repository-v1-0-b6ac0c2e4b81@pks.im>
	<20261023-pks-rerere-wo-the-repository-v1-7-b6ac0c2e4b81@pks.im>
Date: Fri, 23 Oct 2026 10:04:57 -0700
Message-ID: <xmqqv76s8i12.fsf@gitster.g>
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

> The rerere cache state is tracked via a global variable. On the one hand
> this ties it to one specific repository. On the other hand it has the
> consequence that the cache may be leaking state across multiple calls
> into the rerere subsystem.
>
> Refactor the subsystem to instead pass around the rerere cache state
> explicitly and make callers responsible for setting it up and then
> clearing it again.

This step is a logical conclusion of what was done in the previous
step.  I very much like it.

I was somehow hoping to see that an earlier addition of "enabled"
bit to the "struct repository" would be undone and replaced with
this structure, but that may not be feasible, I guess.

Queued.
