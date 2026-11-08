Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164589;
	b=2XT6CvGMUglo07Zp/V3cWpM6F6ermHMP2MZ5myGmurj/pmYG4rDzwjZT80PR9e0RY+fT
	 0tQeI1ttaCR8SXIf5RJ3Mi5mWp1OABEPb88WZ3ubItHn12RS9J93hhfNH/ydKW5fWjrVI
	 rVkjZAaTHw3Yj50KMEwO3If2IRaJCbdMAkUU1IbWOvhKNUYKiq98UfZhSNYOQtnu9kaP7
	 IUMRJAAZ7RMFt4QjNPFd3mXgQnGQKaYFZMyXsrZnn8JDCQJt7WHWzP4CNU3/0FcCN4sCo
	 n6O9iQhfmZ7kTh9o7UYfrOAbMIQHGTRgoJXLwcArj/Vok1IQ4aG5/6Wn3pQEqhbVfZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164589;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=gdgOGy8duCNofw0QbQ5ZAJymDH1ZiTvqqOco5bTFgG0=;
	b=ysW3wR1a8NIdO30pYWZFTSHZsT1BGGTozA578MJkCzP81DVBMH9q4LkDfesXRUBymqRO
	 GcwO+5mJCf9VfXfGNtv8I7TgVwGc93A7T3BwOdT6Bwe+cSTJ4enHXVHP/bToLmV213k6H
	 LzDGyNBMgewU7+7qFn90xPdtWwyCANvKbBCBhVtHWkhdqwGVPJLyc9g4BcRFoHrnnsPlL
	 zCqe8NKlfs50vHx/Q6WfQL/u66brqQbv4RnNbMVg0Fcz9JJeOIcWb6QYurX/xCtq20uH7
	 AKHvlyWLR6/8C8L+10qiIuxL/X85RPWoxvaX8SJU+msruA/v8wsYh6nPK8RbQ3anx9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="gvzm/hV+";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=BRTlBY+s;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFFE606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 19:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DFFE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=gvzm/hV+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=BRTlBY+s
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8CBDAEC0108
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 14:03:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 08 Nov 2026 14:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794164588; x=1794250988; bh=gdgOGy8duC
	Nofw0QbQ5ZAJymDH1ZiTvqqOco5bTFgG0=; b=gvzm/hV+rAPjkmMK9b7sHcwnXn
	8r3Yd3ZMAwfs7H+tb+2cBwA7PNjLRaMYkHFQ8NgUBaJLKisqOm9OUv0/21uGsFKJ
	tN+IYtmewXqO9vspU7aRAWGSbW8FbGIwT7nnq+s7HJZa7sh+wY6pPt04w1qVCZSw
	AT/MFAIqfqe2KFsGAoIZ9ttRZmniHNzfruwo+0UN6X3KMZc9PPwzMrdbXRcV1ew/
	A+/5LzpzfLZXSJHrAu4qQOpJPbTegSTLqgLTgK2kAoi15QE+SJOrqIcQ5unU2dWt
	IocMyevxu09dIjii7qOZtd6lyo7Zo1geLOEdpYcmv165mNmauUTC8SK1Uhtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794164588; x=1794250988; bh=gdgOGy8duCNofw0QbQ5ZAJymDH1ZiTvqqOc
	o5bTFgG0=; b=BRTlBY+sL5UPWVfmCHja7uOaARgaqN+Bt5kvMrn8v2fSrsEj1qk
	7dYJ23F/kehSS0vKysenBKFCeHiCB8FjxjhNkcGHiowTSWZRCVD0JFvoe9q4RTVU
	/i1YfwFPcn72nJFDdM7uoztbr9yO2RZNa4YW+d46DFk012OBNAP00+U44xlrKH2m
	JDI9xQd0cs+rapCGV8g87Df5MwYslVPuwtQMZXNZ1IovpFm7nK9oc/8m53T9ipL7
	0p5Ij2VpwK+XLezlvWPwQnQf2NTSGdIzXdOo6Unn4RRPNf0UhlCXBouT9JvnTYKa
	UhOufqM++wTa1sefAeDd7dO3nt4UJgBt27g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794164588; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:AVwAfkYsEnB3EXqmwLGdobYzdyXT0e0cRnF6HlTq/UeUlwo
	CNtGkzAZBtiREzNJJQ3TNiMf0LczgvM3rSCc0xy8cdXsVyErdpy8mXyvKHGOXmet
	mghy+dBnhLVigYGpFYhFN45KiBtbLmiQ9usnVoxql9JTgyIOg03GIeiMR4tk1ACN
	E6Gy3rrM+bENTpOuM/v8BNUcp2GNAP44uzIVUBRxzduBYD8Jr2j4KN5MUhlsZMaS
	iRn1WHRauTeK/6IVIGBofMOXU/6Ldrws/OOHWWKdzk+OwSJXLt5AkMGv5RXRVnUi
	civPxTiVGsp2Zp8h2yKqrfzLaChq2mKs6eW/m6Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:6SROYrGIXra8fYZANIr1XeA1J7Y1sL8alHtExTuItQ0=:XfBfzIKCcbC887pFlO9ohrI67K6HpiVuTbQgW+TmqgA=;
X-ME-Sender: <xms:bMfwaoQ7J-5pS4vOv7c5RmRIvDq193Rc510sT81mYGkwIPda8F1cwQ>
    <xme:bMfwasyvC1_pv79mEdBp8NKb_8z7uGL_scX-wjjTo67hU6Qrr9l6sMSU0x1a2sFFZ
    DdS-2JMzA-GMSjjDhRF53IhWwPIUDgY9FDXhEZq-WLwWKumKRXD>
X-ME-Received: <xmr:bMfwaq0v5V10FLQBYyrwhbY2sof0HL4ZgcwXjiNIeG0oquZrzHksljWO6CSnoXjiWf8ei-8-LHC4C-5KMdtRfO_ZTT6Gvi49T0AX>
X-ME-Proxy-Cause: dmFkZTGVtXpwzAyzEda0iveckasNi/vxDYNhlx9zFcWASZyv2IGXYKN4UFJSVkqvA9tLiN
    0pr1JGSTfXKQEcouEr4RpNI6XMjoa5KAw9Mp18cwmYq/rdc7olVVIYBNHJz155GLa7znWU
    nMqIRfcGj/fIEgAgLHFAYQ3B6zM1r74oZkaYIsmCMhqvJZ7hgwElO2qoYBS4l3YhBHOkA3
    sXg/B1TMiDE5m01D4tQVPXCOvgONhmqf++LZytzwh6whrhiWbx5WQ1kta5kPRdY3FyI/Kj
    UEDqUZU1J/R3hWFM6vn+lZ0CAuRxlK0rMA5oUtAivTGNsYgx8N4weYHG9CWFrXT7jTW3Wm
    G16/RCpa6AlivXzOvNBsrMlPqfkIDXLSAioHPALArqZ0wrKmjg3eb7GLaEsvm8Dx4ijv37
    6VQjIZJc/LvkzSA4WKNomsl/R2YfF0zYkkNTfb8AuEbqsuTawQ/7ZjzxzUEI+QeUQLz+hV
    o0qnPm7h4eBar7xhjSbKrOeWqJYlrNUtpkK7upSX4K7G40P2d28XraNGoIYuOXAk50Pc7W
    CW9mYy/C0aNBmUSXn1pya23QW8YoAviBw9s7HtukpKw0XWbXfSRVV9E3LDKp82iasgiQ88
    n+wpIXGaujBQjzsKjd5NB1GEJhKrCNHyY+9qDC/AkPLquZpiwfQMY9YL91bw
X-ME-Proxy: <xmx:bMfwaq7IBrYxak5Ezsn8-zfYC0o4ZWvV5VEAAw9mqbhZB16ENgFrKw>
    <xmx:bMfwatX72Co6LOIJhm_vH1bhLrVOxiF7umjD4lgKLhv2FwlYV6UzQQ>
    <xmx:bMfwapDlll34dVeEfDSUXcdycFdZZOs9yl8HttJ66cD4t9uNQssBIg>
    <xmx:bMfwas4xKnRTNHj3qYuB0VLh9HjvROCP3NkVeRx3Qqw5TVXYV_tF_A>
    <xmx:bMfwaiXQMuNPcRm3iWAFb4na6xIEB2wbZCj58C6ofDIJJSQhF1_zEf-X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 14:03:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com
Subject: Re: [PATCH v2] doc: describe promisor remote fetch order
In-Reply-To: <20261108071933.6586-1-husainsitamuwala21@gmail.com> (Hussain
	Sitamouwala's message of "Sun, 8 Nov 2026 07:19:33 +0000")
References: <20261108071933.6586-1-husainsitamuwala21@gmail.com>
Date: Sun, 08 Nov 2026 11:03:06 -0800
Message-ID: <xmqqse1b2ljp.fsf@gitster.g>
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

Hussain Sitamouwala <husainsitamuwala21@gmail.com> writes:

> Explain that promisor remotes accepted from a server are tried
> before other promisor remotes, and that the remaining objects are
> requested from the next remote when a fetch fails. The ordering
> was introduced by 8808e61fd3 (promisor-remote: try accepted
> remotes before others in get_direct(), 2026-04-07).

Well written.  "next" sounded a bit strange thing to say in the
context, but it was understandable.

Assuming that I understood what the author wanted to say correctly,
that is ;-), so let's double-check.  Would it mean the same thing if
we replace "next remote" with "other promisor remotes"?

>  Documentation/technical/partial-clone.adoc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/technical/partial-clone.adoc b/Documentation/technical/partial-clone.adoc
> index 18718a3840..efe9acac65 100644
> --- a/Documentation/technical/partial-clone.adoc
> +++ b/Documentation/technical/partial-clone.adoc
> @@ -195,7 +195,10 @@ cache servers for fetching missing blobs while continuing to do
>  filtered `git-fetch` commands from the central server.
>  
>  When fetching objects, promisor remotes are tried one after the other
> -until all the objects have been fetched.
> +until all the objects have been fetched. Promisor remotes that the
> +client accepted from a server's advertisement are tried before the
> +other promisor remotes. If a fetch from a remote fails, the objects
> +that are still missing are requested from the next remote.

The same comment on "next" here.
