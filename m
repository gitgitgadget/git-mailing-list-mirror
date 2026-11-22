Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795309947;
	b=B8HI/YPUEfwizsa7571/H8lGu6NN57VGZWQIvvOHHzNQkVlP/Lk7Pufzj0XqL91bQmlz
	 SFCtIiSO7S8fa5+7jGL9n41yIJMyYece9x491LA4fCQVFIBsTQhjEiwUs/E0jvsK2F/Nd
	 TPjBARgKJXdLxGPZ/NnCiy0cLLB8SnfjCujIC3xVxqMVFacz8gIqW2fXTqlxu2FvTzDV3
	 c7mu8M8saHN81xyceQp7a4A4/iWR1AnrSDLkFgcFl1n7EVccxsq4Il/m2UaDTng29Wo0p
	 kBQ7dJnedD03aUxIvtqJh8Fb0fh6R0AmFF4W9vEyIsXc/SaXXxKi5BaoMev6Osrz4eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795309947;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=hzlY5iHyTeIumJByzEpNxu41HRQGUju87sreKDYV10I=;
	b=xJ6C6zX5Hy7slZt6xLmc6AdfSXCL/lYOkmmn53Cmc/rlFpVMw4Ck5Znt3og+3HboWkRX
	 4vVuMkK/QCHa8CxT8D/Y8eWBOhcJuPV2hjil6o8fYjwpnDO/7AldvusRqlz0yUnIjjZ2/
	 IK4m2QqoldEbq6YKyDyy9HmROvCjnsWyk9KryxM2ZOkBIhQ8BYfJiVcPsT5Z2jkvklY9W
	 BFQNd6+pC8KuPi0wOpdoXstRI9KbRuGIUUHZOxnauKgzWYjpubKwRWiQklxLpEz5BcdI6
	 7yBG0J4i3C8tIVENMf/DZGfzBSKweCpYCvziU5+VrwrXG/ZHe2w8++CEiXCZLERJorA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=RjBy1ZP9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YiuSaqjL;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363EC606A320
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 01:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 363EC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=RjBy1ZP9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YiuSaqjL
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 40422EC0A04
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 20:12:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sat, 21 Nov 2026 20:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795309946; x=1795396346; bh=hzlY5iHyTe
	IumJByzEpNxu41HRQGUju87sreKDYV10I=; b=RjBy1ZP9B/mXFRbqs++srSTK3B
	GGmYWPt+dUOx36b+Wm1eWiZa0vDTFk8YtocTiQPXC7CZHQnerru37D3YzWnDMyCE
	dKNNiY6D1N8IDzCf8dqcBYPUl7xbCx+p67Y/DNlzzl9WXF5CdbkE3qqrixtPvrmd
	CsJ18yTkbF7xJPY9iArRTVGirNCQl4li6P3kKebaPof/h7sreY6dnfsuvrtWu7zR
	Uxg/TbUjfkT/YIxVfY9st8aqKZhmTSzb1X1dXMjmmLtpow1zbQlnb3Q48N9SwLOb
	7qWffOvc9HH1hrurI1I4vAgAY5QAQ9LpiEgBXklTlMw9LyVGRLKihK2M5zvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795309946; x=1795396346; bh=hzlY5iHyTeIumJByzEpNxu41HRQGUju87sr
	eKDYV10I=; b=YiuSaqjLj0gaBCoNseEQ2WQYzOMF4XFwqK+8qB2hv5VejQGiHR5
	+UtLtTw1V0teXYnYUWnvKS2Qb3l81FKZqUDSpdSKodTYgKCqMJt/3VeXxKTSzzsY
	vuKmQmoaTiX8nXA8xO5mZTZwFBEFkEMg5To7oPSfhUpkCm57H3uiWbJzQKv3SExO
	BrrztXf2aZdS2Jjw1ryyUa5fbCtVW7l1pniFCTAig8nCSZmIg03HnoAEwGtcVqHC
	Lmz3AJ5i5idQfMDVsJ6FHlnDWEoYaJMEKy942CajL4ZOS1Usb3KGORpcsb0i+K+i
	ebTWHeu5t7VYSFapLqwUZzQuHqo1hKAfhBw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795309946; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UC4zuBfw95HnIAA3dJpqpEfGS9VD1XLHBmlL15BYE277Nia
	rwiyDZYef1x69SOV0393wjRcOohDYO/rRWAfZ9U7z+9J4HP12bIc6XxkjWmmkyme
	VgYiIZ67RStIkNL8ZCCb03yzC3Kcg85fqJNdKB5C/VXTmCAoazt5CHIQeuRY6ack
	dmYifGFop8h8UFCRgVthMvcQnXfOky01ENxcs5OJQJxLIm8vhT4A1rCEs7Qq0YcW
	w0nnhUcaTDoeWUac5QEd3dZNcLXESeoRB9qAuLSBw5q3OsGn21CkiPar1vyeij4p
	+DmiXt6R280hPLx9vyxHqAksQe8WdQfGruc+TkQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:+5ZeMdQib+jWF1GBPRivQodBW8/DAo9QRlmIoQxKO/k=:Z4QWKZuLeZN/i3h4ftRqCMAr6x0AMbtyyynyNlHPQWw=;
X-ME-Sender: <xms:eUECawLQk8uCpeMrRKch2NtedCWIZfa6YekKMQ3Nnoa6l6i1JOncDQ>
    <xme:eUECa3lUe6oOPlnfSjLeF702WXmNhoWCRSOm26qMAI3rVUsGzadcHqiQ6q4vmaUmc
    4ZwWowWfBPwyeGBPlOqExK81m8ZfnMxaGdtEww5dtjKndo3dXZeeQ>
X-ME-Received: <xmr:eUECa-G1cWZDfrmKWwjy2RBQoJ8o4hDPKM2kegxhwQLvN_fIBHkglxE2F28xCQTTpLPhUmKTiHIHX4NgYDFptXLfJ3fhlqQ8WNY3>
X-ME-Proxy-Cause: dmFkZTFT9Tj7YBgSDqlaygk1tEzCBw81jRZkVx1lkRYVqnZ/El5mw/2SjliNph65Re2GzO
    vak/w00oOVPuV3tiJBJDzRwCv4HLxLbrq65f9GPLpaf35u0foIQYDHeb7htM2kwDn4LX8N
    3p+YqRTG86xdiVsfPXEWk9JLofyqC8/A7Ihw5WK5c9ksZSmK/83n+mdH6DwM577JAMWr9O
    UX0aaJVEThN41btovv1pZwXym/IQrkGlP6shHv1786qd2BGpSUOS4PdP0Kqi5XrGK6nL1I
    yoXx9xkDdLyvaoFnY0gz9fgbVUfs7JvNbZiaYHwaSvJ0dtkBabTozRVxLOx+8m9IZOh5Ng
    ODEIwqaIBLBVzGjErn06wmH9PxNxa550k1YS9qOgKuUDvVqRAokvgNZv0mWbaN4v+mGhkN
    klicLg8OoLF7TZ2TttYygWGJMxjQAo8zFwYAw0+nTUg13QxXU0+9H9iQQXbOO0HxYp/at2
    lV6pRRCBQUU/zKT5DhGzbEP6DX48APPyJKg0W+WneYMgt/kqLq9bbEkV2+JiNkgZZK4cYF
    +txhO1iQIWmXEfvq5h3aSh2rCNNu/OdtmEf87qmmu4NiEyfQFAOWnTNWepduAt6N20bjWZ
    OsjYHBif1USsUTVQBVdEfJi6mSSoeGMCwbvm66af7bxjecaWru6GPtlkSFMQ
X-ME-Proxy: <xmx:eUECa3EaCXrrPK6NQLe93eJVpLsYu0_6vM-dKSqc344MFxxDTInaLA>
    <xmx:ekECa7NDL-wAbqSyDOThyJhsaOZeeLmeYNiMzXMuz1yaVDfon1cLCw>
    <xmx:ekECa2EmiLReU9G7YPiO5O5DIdL8wc-ARMBdSVkON3csSjOza5OHhA>
    <xmx:ekECayOHsh22Clg_wcyJsLFRgWczHx2Z9i_0KNuhGRfb83jsdBky5w>
    <xmx:ekECa-yUnH8Z5RLSVNflubXzwRpG7n5dtsbzHqCJ1xLNq7MF3_D4KFxM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Nov 2026 20:12:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] docs: indicate clearly that http.extraheader is not for
 creds
In-Reply-To: <20261121222723.23714-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Sat, 21 Nov 2026 22:27:23 +0000")
References: <20261121222723.23714-1-sandals@crustytoothpaste.net>
Date: Sat, 21 Nov 2026 17:12:24 -0800
Message-ID: <xmqqzev1k6tj.fsf@gitster.g>
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

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> @@ -111,6 +111,14 @@ http.extraHeader::
>  	more than one such entry exists, all of them are added as extra
>  	headers.  To allow overriding the settings inherited from the system
>  	config, an empty value will reset the extra headers to the empty list.
> ++
> +Note that this option should not be to pass credentials and using it for that

"used" is missing in "should not be used to pass ..."?

> +purpose may cause security issues.  Using this option for the Authorization
