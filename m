Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606274;
	b=iRp6FAix/fB8J7XpBN9QbzHH8nFECNPzZzIhaXHvkGjWT8asIm43brJkVZfpF6I2L2cS
	 AH/nL35PS8e3FhwW06HJm/wXyiTcGSIC+IaYP7gV4LNFk8ug7+03c43Cdc4hsTVy1id/V
	 PzVPLr0oKgGkAjz/hTL8UCHJ+EShaQnCBTvVyx5low435JfdKNwWwOfgCiXPaiJpCH8td
	 yNGzdQOrTnDvFZ9ITqSDM6hIVFFvMlkKUzSOzKRpj+k2OE2mgG8MpvrIDvMhNq0IVhuby
	 UiOvdOqaoJzrVn5qCUlmYHGIgZ/DE+Mlcpt1/yGXTnLpJFzGQnog1LvmVOvkrO7KmUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606274;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=FFTeSAnKH5XTzO5CFqVcx4SCa9sRwvEQTJY0E4PWnn0=;
	b=4P2tB1GBBTUsG+UwfWD/ayvDnOyZ8fIQM5Y7gZcJ0PuLi93YyrzFVG0fciGvNG1PfEae
	 vUIc6sW4CSGhEzGeGzBDm0XJbO4t9w3HR3wjyMLKgOZKxOVC3ZQVErEbLAbUbAqoQE1MP
	 Pdf+Nvxg1huVzzJbiDkN517+iH9N8dY/3KPTChcuF5NoppjhDCmKpBlVzlgZNlNb187u8
	 gj8w4tMkHgxMEWr35WRYIzUSuDxQtTYfsTwU3yMun8s0r/Q276MWe9FIqX6kFbvs4PzMp
	 R3j3jq9bNSBDqbQEXuvCGuBUhUaerPUeeZE2TVrPOPtRbDruYtq6dWknI/hUS4LOLZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=IQdNiZq+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fc8moxvH;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C13606A323
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 21:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95C13606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=IQdNiZq+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fc8moxvH
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8D5331D0014F
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 16:44:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 13 Nov 2026 16:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794606271; x=1794692671; bh=FFTeSAnKH5
	XTzO5CFqVcx4SCa9sRwvEQTJY0E4PWnn0=; b=IQdNiZq+ePDoc9m382aRQU3/rU
	ZKJ3AscWOpBv2mgBe6l8AWrh0CvBV0fxNNTg0Kg6bqz+2dmkIxCD5lyJ2VFuxzxo
	6F/kz3U1Mf1RbaZyk5ggDFZBHgZwp2bU1dt+aZ8EA6dk3u2YNFgxKEV/V+4uufdf
	IxcLcZQnA4vf6aXDujObPIOqfEZYxW0OZYK1oPfpoe9E9FcmOqgV+pleg5mnt0S1
	4AWgDL3HclxKfvu3+X6tEIxzvQ6IkKP8WsUJc6MQ1gCOFUQttMAF4QFrJ4oXg3q0
	NnddQB0vQYGb2v2wHFkUHwShe9eOmWIMTPrpT1ULjjmpMZewG1hd4vamvXdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794606271; x=1794692671; bh=FFTeSAnKH5XTzO5CFqVcx4SCa9sRwvEQTJY
	0E4PWnn0=; b=fc8moxvH8gdNXcIF8ExQXlZ5bY+ObX9w3W/2X5GMGK4nZi32XvZ
	CNn76E+NFUGr28km+WEXbYLIVWxp4rmThBq65wLt9bVYrSnehfWcQ9S6yRohupdJ
	zkUbeIT6MgxJmjTz338JOWcpySJ4NdccTrFxspqO1KoF9NoEixPLln6WCl3DWuz8
	x7MIF2N/FayU8ccTvcrjn7Ys2RGEZw0pr8sSkaMqM2qC+TuXBYBGl+Br3dZsl5Kt
	tC6tPKJfAbOEk+nEwm4sf6raayrrFBJKd13IMXYtb/B87+KNev/Gbj939/51yJvB
	MQmr+uDIiyp/bkXsSPVyJOMY2sV5rmbRvtA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794606271; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RQbMHk9RP0nrUta1YWRcSEpE0elRhulwS7Bwx/1dTGpfYiU
	5A8bFBrimXIGFs3BPBhoDmlL4RwUjsdUqAZ3H6Afz8zRkfWccx8mv5SHGmWAoOsY
	ENkoeLkqajur6aA/0MYeTaULLlSguXen5ZVrHuUlwehm2UNEDFRZ0dJ5nKJvYmb1
	FYpMwLvRw8igl1/it0VjbM1HTo7y+G1JQRjsSfLNOuY4ygXQCMQOqIVZQjzsabmh
	FNmQUnDqRgoCum9srkmnV/jAUM2qTgxhhzllGM8I0qSIAoZYlQc8cHg6R6Mz+TN+
	04TDnI3SFDJskk5zcpx+76+FjnDrfA+sqZr7YTw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:DI1zLOr2nJopOALTitS5v8jBsQsFKDShTGoRh5L4Nrc=:IESqjPzldkR4wd0zjsxg95RUU024+JXc+FC9rJro5Hw=;
X-ME-Sender: <xms:v4T3akQn3g2UXN6_ogKeuyOlWv11s8UVrNYRqZ3NoaaunU0lnIGuQg>
    <xme:v4T3alcR_6DuyfqT50alzZOeSvL-gUwBgxq131ZC8Tf1yqoxCh1mX1lMTGd-Wbi1H
    a4MVQQB-78GQwoTjYmZrk_gDLBgB33-d9k25LiV_Y7jQYRwzD_iWNdv>
X-ME-Received: <xmr:v4T3arrmJW34BShW8zRiKD0idzd6eQyVrxwe3udMZPr355YGxfx86hDGBy6ZHxd-t15rDyiAZEb3pP3vKIEkJ5F1XbRxsdo4p0S->
X-ME-Proxy-Cause: dmFkZTECskmhw7PQPqi5yZBBzEOxnBKnTobK42voeRFCTmfj8mqWNOhKmlN0nCpW6cYv+H
    e5O0EZJ/XqTVg5pYm6sG4V0XjDH9Hxx+Tg7usS/dXP1l4BhOl6DnzOlB2AygqDtICmKIcH
    eoov3vQ5KCNqxJ9QSlMy+Y2DdyKVkJCS4wmd+HWYrXTqnv8u3cpC1magfxHqS9Hvno/MUh
    oia1klNqYAdj3KQxuG/san0SLdZPB7Unr5znaBnHO1hiDfyUivrxBWant/LbrXlCPPha60
    bnc4V4tnxfyeAqdDoI4y6I/d+SfDb3nPWimKvnTSwk0RdIfQbIMxtnf0bz2u07IAkxaXX+
    dH4NKrvnw7n8QMyj1UdMwl3Sc3Nh8XPXYCEqqgPQ0ekdSUlQgfUHqasCzI2cvPn9OLJTC6
    7Iwj9RYPy0KksPRKM7urJOR3yR9nEaYc+eTJnDIABIJrTd+CWDIS7jbaRPwPrw0cVpzi5F
    cM6Te5N+UXjLCrjcRk3ZCm5dp/yj21JD5HVuK6R8dIGSrKkkLhYrKKmov1IQGii1YhSIzx
    Lk0NwPwMpuurLrZJmxzFPl58JixzJ+NbDgtTFkGiCqMs0q6H4X9cyYXizS6wkzATHFXUKr
    c1c/1XAlQcf6T4wclIp8CgH0L3wSwfnscxDQMTQ0ICNK0VxAQpXphPOoF4+A
X-ME-Proxy: <xmx:v4T3au_I02kA2VwYMpI89sv2ExMI048Wn1r6fGWvEBqNNKgDL1slOg>
    <xmx:v4T3avcWfToqJmpfi3guFuV3KHkbhOIpzyVREfqUpb9xoRwW9WPISA>
    <xmx:v4T3agLQyDYMUdL51lk7Q2GeLgJjt4r6NNYkuCXW9EOeUZjs6P1rvg>
    <xmx:v4T3anjTQkrk5O6kgVyXWIFwbry-uN_4r2kMhdYcliiMqK_LiQhr-A>
    <xmx:v4T3at11lQb-42z4pCfClFpdUpEaliD9wurcnPmS-xiqLB6draGmxUfH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 16:44:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Karthik Nayak <karthik.188@gmail.com>,
  git@vger.kernel.org,  "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: Re: [PATCH v4 00/12] builtin/rerere: convert to use subcommands
In-Reply-To: <1ebac86a-6674-4c6c-bcff-a71c05b26d3f@gmail.com> (Phillip Wood's
	message of "Fri, 13 Nov 2026 19:44:31 +0000")
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
	<20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
	<CAOLa=ZTAYtq0K4YfcSBocf-fxadTiaJp+AV5-_6_pbNMBwYQXA@mail.gmail.com>
	<ava6Q1u65ASVeth5@pks.im> <xmqq33t4eh84.fsf@gitster.g>
	<1ebac86a-6674-4c6c-bcff-a71c05b26d3f@gmail.com>
Date: Fri, 13 Nov 2026 13:44:29 -0800
Message-ID: <xmqqtslk9zk2.fsf@gitster.g>
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

> On 13/11/2026 18:09, Junio C Hamano wrote:
>> 
>>      $ git checkout ps/rerere-subcommands
>>      $ edit rerere.h
>>      $ git log --oneline --first-parent master..
>>      $ git commit -a --fixup HEAD~10
>>      $ git rebase --autosquash HEAD~11
>> 
>> By the way, I wonder if we can simplify the last three steps in any
>> way?
>> 
>>   * We can use 'HEAD^{/^rerere: convert flags}' instead of counting.
>> 
>>   * The last "rebase" does not have to be on HEAD~11; as long as it
>>     covers HEAD~10 it is OK, but we cannot use 'master' as I am *not*
>>     interested in taking any new development from there, and I do not
>>     want to worry about what the command would do on the merges the
>>     topic has as synthetic base.
>
> So long as you've set an upstream branch, you can use "--keep-base" and 
> omit the upstream commit.

I do not think I want to set upstream for ~600 topic branches (among
~100 are still in flight) I keep around.  I was hoping that after
making fixup changes in my editor and adding them to the index

    $ edit rerere.h
    $ git add -u

A single command that names the target of the added change

    $ git fixup HEAD~10

would automatically do the two "commit && rebase" commands.



