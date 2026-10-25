Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792951855;
	b=QHo1RKN7scDGnZA5ZZChEBMbJ6bu+wPKW0x2WzdCVoHVA0pJWXtyMN2zpv1VdV5ZeCAs
	 83T7ezacHZVpsCto0fwMLcdbq81h9D7SbZP20R5+yq12rqvcOL00cgF8jLnArHbYxz7tW
	 Z2fhU8pZTu/DtyyUYkKBpFxZPLlD3xK/O1V6mXrFxyHxHjQiVFE6BqpKLd8cYjDYUPkJO
	 YG4eR+IGFdMXX51yOxO4m+02nZCorqajivqGXfZTamSl5LE7dWb681VveHEFcRkZUV2+q
	 EahMJHzDyqbecfbtIzG++hho6srrtjFl9TBDlwxDpvGxUq+pvSrXybilZF/UNdcU4ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951855;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=1OgDTCEGQufX74FA/fFVzZIVPqGAbJwuvUtARLfAXyc=;
	b=ityxUTESR5ARN1kwOIvcSMbJuxEUrDavZC14Rhv1ms1MjOvpH3m+/60jqSM+9vsJ7KHk
	 a89fczHvJe+JjAAoZFsw/9HKeC/vENB6Ym1hpRZbR2CpQf7aiPbDIFlHuuH0UHSq810xQ
	 bjyKhrjwNOoESsrrTkwW23eQbEnW1FnKfzmIISzrIBznnNLgjqTY5LE6lesaXSmRAsCwY
	 moD0AfD+NvLDOjaCY9KyinF5pqaMUQVy1F0/4aXXatosc+IsHOI8QP1YvGJEafzjiQbUu
	 WdKaRbX1AmZk/ptM4C5Ps/ZyCw8Hy6oaeArx7B7mvXvyP+zii49SJQ+SjD75el1nwGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=G5k16WeA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UFvtVVsZ;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09D7606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 18:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A09D7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=G5k16WeA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UFvtVVsZ
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DFA9AEC0191
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 14:10:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 25 Oct 2026 14:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792951853; x=1793038253; bh=1OgDTCEGQu
	fX74FA/fFVzZIVPqGAbJwuvUtARLfAXyc=; b=G5k16WeAej/+hHAC8xYwx7ykMP
	zuqEJoZWw9SUC09UiFbr1HDeQX2rQyyu45rdFrI6d2LvlQ5ZYCJ990sYEv27LxlQ
	6lIfvMxXXRwuPjN8g+hyXDEiwLrzZXrDASircjbHW32HDEY09JKzY2qWTDTP9ysA
	AY/Yg2LZ2LNU8MoJ3ijW4FmCpH1bc7TtUSNFHVB7+HSra0+GHDCoHq0EvWtYwJHu
	N5JjjCkf75LUfsuJ+HJ9pbXI4vLt8u+WSIjXD8WkJhDg8VpsPbCwzTUCgbkfEDFC
	SSzXYFU7TjYUgZ8dpcJmcT+ob3FQeZDaeQAhPiV1Lvks5xzwRrfsEhnePh+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792951853; x=1793038253; bh=1OgDTCEGQufX74FA/fFVzZIVPqGAbJwuvUt
	ARLfAXyc=; b=UFvtVVsZ4yD5N5ooG7554rsxck+n5Ha2b5/Jv2e2YTBy6LoTg3I
	3xpSxH9w9lKlEqzY7O/Z1MzSYdmZqpKbM6DSaAJThxFn5BG6Z2dO+c9hOc+0R35S
	wcrJmeIt9Ik+mDJyjfVvCBdKmC0z+RKSdCR6YEx6e7HwL/U9XUoUIGU41G8bu0I7
	k3aIbY2WS/AIy+3Q8+y/zCLvuSTpHXAbXA8UGTuxe1ftJwlp7cczPKc6b6157wju
	3+xc3CvgF8uCYpo8/glz5NQG52rKzuy+uWtJ484C+VdqpXn6bhWqIj05xy6KTtWR
	XZ4v6vt3pzYNBlH+Y8vtE17DEuGQVTqIstw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792951853; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Bh6VPwVLQWjgF4GwK2vKgfsgGAn/uQhW6qrB9UCNxIdQ33d
	drgJqa/EyOPxHxRAhuJlbGudrV2/NkenyDwh2h5E0srRP2lD0B003TZcFBwcc84G
	papBwppXeNCYUn1hjTOcKp7lYLadmZEjK75Qgr6yLB4BBDa7sEJt8lU49QBexefp
	IwN1HU7YmIoYJMJ92QX9CwtRbkEWEf8/zdpd+66fuBYgUeVJUO5eUTcfc8QzCU9u
	hTy+KFfR4lo3w/Btgl4D8HKNNu9BqsJLg4oMCuhvirkZmpPKtgwA5ONzFXR+9NhM
	5jSZUp++Or+vbLwhLeaSysB9/PODEBPW5o59Y6Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:yw/iKrCW3PY+koxTyi8haqT28NJnJHrFrl4fztTk75Y=:1YThL4Mh4npSGhKjQIJJxjHn+yF9dXts7Yk+rYgQFPI=;
X-ME-Sender: <xms:LUbeaqdjVxfzPRvbSmoD5UnZJ8Oo67LjWDu7mR9S_zbUkpACbwdxZA>
    <xme:LUbean65IhvHbU8wVg7lIlOtpxKSUw6UKTQ9QEerNEdd0CyFMe0O7fMBXls9d6x3x
    yrjaKJj5IHBj1u_Vpq94-pGfEVxIeD0NlGo9LLuSkIgoJNpMP776_o>
X-ME-Received: <xmr:LUbealWJW02YGELPka8i4vjYo56kTaRe9F36wORjiJqpHQtsx-4XRgAcNL1PwZKbG_dY0CW9Ia26cUgzvuV_DFzvvCwIcULtyUm_>
X-ME-Proxy-Cause: dmFkZTGsZ7UfKJDhSbNlsknYQtGwajDd5WOc3GYsD2YRo2FRW1UKu1diKD5COqTlDOUU1j
    qlU91Obt3nVqEinm8GknQliIOS5VlCm1Nj+B375NAPpkMb/2HKrtaJV4Oy1u9GLOb6e4QY
    HYk5P3nn0zxxeOfh1PN6l6xlqWWBPizbzHOJ0LKLUb+kKZ/W84uKQoyFEpiY7RJhAxQEpo
    So2Y6vhbcv770icDZSYlSVBTGqli6hD/c1pn/mIdl/DYT+E6dFMdINr0F/GKfEhklboJKY
    1adiLC+ddUzxFkkHK5xhzT/pUZHot4RHxGZiKW/DcWQ7vJ+kjGjPRednboydzqo1NLhbWj
    AJfNQdcDuhrJd+ZNBxGT4kd/TJsXBd9HP/zF/MvwFQ9SG1d3QM53WQkhnfmEWVTIYvnxDN
    zCeW24wr4u2MZpV+ZWzwREsCGaj2ljp8iOMx+vZddisPOdSiEvMa2qTBS7EjAeTTdT0uQ5
    oHXYHIUsc14oAhbhaP7G9L/RbQIBVfZ68QXEKTbN5UsRdJo+IzpNWs8yTsDES6GzH9QKje
    qCtmJTcXyBiLZydihlk3XRiUBfC29quno0w5hrE/Hbm3IreJOJaVt2MjMRXPIL32fHSKg7
    /tNU5TGgyd/8e5NmUslWMUGFV0CjW3mvX+xaP2whhH52YnXdTehFZpT/6cRw
X-ME-Proxy: <xmx:LUbeau5GpWEH_pl_6w-5eXR0bg77216c0vT5opHk_IPh6JlvamvwQg>
    <xmx:LUbeaorW9j7mfyoom_OX599Tbph9P5X82k1X23i1WiSVpCPoDoD8Qw>
    <xmx:LUbeaplzQZZnBDADsj8Y4mGilWmEEgfbxwxJ3trF84EkhMoBHBA6LA>
    <xmx:LUbeasMkzhTjBHG4_wk9UWbdZTsQJMqjet9AB6NC_LlCPoTOwIAyvQ>
    <xmx:LUbeajBLcPsBIYJTcI7yh_PRnES5cCX9LfYMTAjZQzY5tff1CxMVFpvV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Oct 2026 14:10:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Srujith Poojary <poojarysrujith@gmail.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Usman
 Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v3] diff-delta: use safe integer arithmetic
In-Reply-To: <CABh_KWhDcPM6rJROmVd7_oGZ7i3tmX5da-DZX=KJmvSyCxNH_A@mail.gmail.com>
	(Srujith Poojary's message of "Sat, 24 Oct 2026 22:56:08 +0530")
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
	<pull.2276.v3.git.1792813697888.gitgitgadget@gmail.com>
	<xmqqfqxv13d6.fsf@gitster.g>
	<CABh_KWhDcPM6rJROmVd7_oGZ7i3tmX5da-DZX=KJmvSyCxNH_A@mail.gmail.com>
Date: Sun, 25 Oct 2026 11:10:52 -0700
Message-ID: <xmqqmrs1y7kj.fsf@gitster.g>
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

Srujith Poojary <poojarysrujith@gmail.com> writes:

> Thank you for the detailed correction.
>
> I have expanded the commit message to include the step-by-step
> breakdown for both the unpacked and packed index allocations,
> detailing the caps on hsize (2^26) and entries (2^28) alongside struct
> padding on 32-bit systems. I also corrected the phrasing regarding
> (hsize + 1) being passed as an argument to st_add3().

It seems that the text of v4 did not "detail" anything like that;
you just parroted the conclusion, the final numbers I gave you,
without giving any hint for the readers to validate the math.  The
readers who are interested in validating are forced to figure out
how many bytes your calculation assumes each struct type involved
consume---and if they find that your conclusion is wrong, they have
no clue where in your computation things went wrong.

