Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815220;
	b=E1w4Uew7y+g5BcWYF7GSdBLAYQ3MyjiW2Pn32siZHOw6zpp8VxB7S9WpJG+Q5Pa6JWzp
	 u1nXLbEig1kRYflrQjyeOwnbA/phzO/5NZEjeE88QLakzZRvaJdlVctmIZtr0edc7jXXN
	 FIrmb7SxizJTHWNSDnJPgEslNOw1b5JprtKXX8RsyZ0iCAt6C5aHxag2ALsZ2BIHyY42K
	 XpgGMMz9zG1LAO6mGAZKw23vkqKUIpnwG1kTg3acd751FenK3OL9fAYxlUQPDciM+JPVi
	 2llFXnymij8D4ubRtgieA6tRxcSmKFCs0IUKrKtS+lARDnQX5NHfsnkPNxfbLSwcdlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815220;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=6xjKO0r2E5/GRC0U4NLp/fsgI7nPxr+EK9Soc4VdYJQ=;
	b=qpTaVVAGrWCG+ukevq0Zv8mpR/mrdPSsLowA+fCNOLpK/obeCbP7eaW848qtKx5EfrUM
	 hV3CPd+ZwE/58PDA4dhgjLw/pLIObeLcLBVEG4Gm1GW9NeTYc5v14964905JHc1PPNoGC
	 Evnt2ko2ZQlzkmKm760DUDp4A/AZ8Bd1Ysdf2LSQ+Hb53+A2tkOA+zAE6i6hz81dAU7qm
	 VkUPVk5oI5pPrvGEZGZefz1KWKxZZXv7PgGGQjdDLGyjqlTSJI0gVrc36SJ4A9tAHUcQh
	 BLfKX3rnGRxko3jKFC3Xuebe7UPzaIZT6EjNNT+LeFZF+5ExW3tHGJ3F86wOBO3fhqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hAcLlBWc;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mY0h2lV1;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB2D606B207
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 18:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEB2D606B207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hAcLlBWc;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mY0h2lV1
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 283DEEC181E
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 13:00:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 04 Nov 2026 13:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793815219; x=1793901619; bh=6xjKO0r2E5
	/GRC0U4NLp/fsgI7nPxr+EK9Soc4VdYJQ=; b=hAcLlBWcBU+R+cCK/xldwzllHy
	VDrAt1E2lgAWDcLGsWGsKqB0y2PiqHWBvoD09ILM5c/Bv7+WON5H91ybkYF8hu5Q
	uQxp1qwN60/mpFROBdfyKrR5yz7IumDEBGUYoYQpj41AXMS9gITOXtV7KmaNf9rU
	5cwXC/PzurA9LibG8V7x+bn/FxrZ6i4qeXO8NsuKd+XfCALSYIqzL677Nl9U3u/F
	XOC86vTC9smct8tSTe0y0fF2jdjxyNjkPqK5FVi+utdktzeQwyL06UVMxbhd+iyu
	on3aIsiX8BwYjLNmSmqr+Hwci0jRugf2SevAVybe3kDQBBv7zxFurj3Yz2mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793815219; x=1793901619; bh=6xjKO0r2E5/GRC0U4NLp/fsgI7nPxr+EK9S
	oc4VdYJQ=; b=mY0h2lV1RKsYY5nJZZZpOmSK/8QFwKtnN2inRF4zDDFY4fHuFry
	DlaBELDV6Yv5lhKDkX5gAj7qpo9al3xEdxnCDIJ7O4V+8bHtlbUov/zJXNWg9uRA
	c6fTgIP0e/NpvLvR058D62s3TVTc5ZvkhwXMJYGnuXvtDy7bmrEGu3GKKBx306qX
	WaLY95MQctR6YtyKOokK5txM1rOXvY2TssdDCKqiHTG5EP+Ygcw5InGT7W/rX38F
	rza4c3pyqLf8p68O+xOmjhgkYdd+rILkRmn/E3SJxaxbW6hcT7bl0bB0o4lgGh1+
	+l+7l5gZRfSpwRLfgQZCr827txeRAdwJ5yg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793815219; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:LaXEsc3gM5MivCE/5LpKVXjDZOgKzIVNyDZPjaLurpbXn23
	gcRQMCSIpmxs08SRiV8AyTa2HOR73SwGbXNxO5nBFlXx2Uyv+WcYgl8FEZjKIk9E
	sUtq5QJ/13C4NwJr5q1xnj/YRidJscuDQcw1/8YKbBKp0S62VbyVxPWja4a9SMR2
	NhDPpB3N1M9ZDYQ+yAvs6NqkUf9vE+bpxIlbnEToQeeSuAAwMcy57fTGvb7f6Z0N
	UsvePERIE/QwgvzoixGS6hS2LWGXU2vlw/Afq9dp6pZC8N0sft3gqzI5H8LEpIc8
	ZB7RD/KuXNOoEVQ9QrRDyCPYZ3RSmNs4eB4YNFA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:WG+6s9O91nUXBdeKFRHnYkNiG7StOOXHL23/aTCFNn4=:d2N7g8YaI4QbFzofgx1LdprH5UTxPG43fr+u5AU9Jkw=;
X-ME-Sender: <xms:snLragNNOgdISikjC6D8PUgd9qtNuX6ftXwIKeK_GNGgZ4Wn29ES7Q>
    <xme:snLrapOAlQwvsmLiYwwV-c07Owr9lXrLI5efMMjCJFYi55jlJJ2ZuwrMLNyYLbBWv
    zWLD58NkNT8ixEVi6I5A1fs3JfAOiITKlvXI7_OmZl42Tx4-QZEvw>
X-ME-Received: <xmr:snLrapis85lVEKuP_AiqWthlUfo8B4eUwH7Fg4I7Y7slYCPqKUoTmQH4lZdiCCbDvi-ma5cW8fikuGxqUAK1ljKGBxodToJvP8_c>
X-ME-Proxy-Cause: dmFkZTEU3L7JAdMGjCKxs4l4WfU4lS7BpWdEmlLQA7tf7zVxm8Cb4Xir95CgIuNYa53oKg
    TzE/RvbRf88FedblrV+oL+aUWMzY0xbAQ954Ow0ZXattjQGDYKoo74wQW8EeODkM3GsF12
    8vklfjP7T6Oln5mrxoJaXKz/uBgRH0nXR/TOcndn8ppYo9HksM4EZfidqxweYx601y+tgr
    UF7eOUdpO+iuEnP4xmHVMykxLyM2IvpKJtHxoMjLTLUQ65d2QS3HH7MwOH2VbzbwGLE//j
    b+uTFT+HAsgDFtD3AzGM6ZNdjcBMaJWT6gdyzjPjPJAr90ko2dXxjeSpjI4KvkTDmBXjkC
    Cio9ehQwd349jhTwON0+T8ewsm+u8BfmqvsXoDHhCIemWKf5WpgRNSFvMm/2sO5Z0jQG4v
    n6u4gcfDSp+cM4Pchrm6kGRJMXhH9jpO3gfI1li230nY2EVx2ITFikt6pvHBgzWQ6s6ENh
    ozfFB8lM8zT82RiV9TI3dPQgjnG6PcYl6a+SImVTw8cZi4CwSkuvLWJKrFeVOPdQtzY3jM
    7OEdwS5vstBVtMo0PTzr7e9+qAWmH1KpT8wElge5ce5oMPWkSi8UcUkP7oC76b/cre94oD
    yWz9i2nTFx3TWY4M0HFRQ4Vx9RT7G/JOuZ2g96n9qNePC6v91+gN6Cxh/2ww
X-ME-Proxy: <xmx:snLraut6oPQWuzLrDR50d2rOg8o-rcxfq8jwUjaiB7sa0Y4Dr7E0fw>
    <xmx:snLranRMHLl9r82nqfOtPa9NtAxwQAJEuc8dssczLaZstOzw2vDrWQ>
    <xmx:snLrai0l-qLyAFDFABXLzUzF4lJHD5GhhkSVIawmoj6rc3_89NJPxA>
    <xmx:snLrasudPuEK_I9EAGXND60M7DNuGBZ3g9EcRDki6dIBGzs5eDt9tQ>
    <xmx:s3Lrav8F7e7HLlEwrpq7yo39zdNm31AmhZIr_PIufIzOgD1npadidP57>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 13:00:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>
Cc: "Caspar Duregger" <caspar.duregger@gmail.com>,  <git@vger.kernel.org>,
  <krka@spotify.com>,  <karthik.188@gmail.com>,
  <chandrapratap3519@gmail.com>
Subject: Re: [PATCH] graph: do not indent visual roots with columns to their
 right
In-Reply-To: <DMLZ0DCQXG54.2FD3JQXSJCWPD@gmail.com> (Pablo Sabater's message
	of "Tue, 03 Nov 2026 23:39:22 +0000")
References: <CAFzd1+4Jx_sWvMrV10gi9400BBNJOUXW0WwsypiM7yCh5x8fow@mail.gmail.com>
	<20261103231153.289762-1-caspar.duregger@gmail.com>
	<DMLZ0DCQXG54.2FD3JQXSJCWPD@gmail.com>
Date: Wed, 04 Nov 2026 10:00:17 -0800
Message-ID: <xmqqbj8432a6.fsf@gitster.g>
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

"Pablo Sabater" <pabloosabaterr@gmail.com> writes:

> On Tue Nov 3, 2026 at 11:11 PM WET, Caspar Duregger wrote:
>> Since a34c00d96 (graph: indent visual root in graph, 2026-07-14), a
>> visual root that has a child is drawn indented, connected to its child
>> by an extra GRAPH_PRE_ROOT line.  When there are columns to the right
>> of the root, this breaks the graph:
>
> The patch looks good to me!
>
> Regards,
> Pablo

Thanks, both.  Queued.

