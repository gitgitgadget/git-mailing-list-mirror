Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793416330;
	b=a3Wcl+rdFIUfwkdXI6FqJYT0fz2wuLsl+MKM9FhKHUU66ALtZrleiuT1qRyZVHGWp1A/
	 vWF17H4nXjWZjNUloTKJv6HoV8TF5onG5FKUm2sMtHsApKYXiNWbUcchLj+yJjbksAcaZ
	 tob3eT00yykS7Nx6f62viBjzPMxAb5/CA4QafCqPsWS5hxxXbg3m2uUae1g+n+FH6/nRr
	 jBMXnJitFw4FlGfXAzHTeH0ae8Q/8vsoYHPM+x3U2ls29DiQtyZoZH4QzJZP8b9fwrE83
	 BgOTTeU3p1ybnzU3wtxnODVlMn1PaMnYY4SD+07kEZZMgcRwFVMn16oqiJx4egMlHpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793416330;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=SHH+rCVufOEit+EqtL5xcbWTZGitg/69OAOC6Pfx4cw=;
	b=Qb+vBuBvmIco6cKpCw7Qpd15UDSmtyeG3kM1BseSaAjRmx2txxPV5+u9l7Ijgb0aNJ4a
	 Wb1+pCQFozY3aozYYS8pG/wvahrMZu7i9xXFwy+7N7y3Fuyfqk/Mn774qv3+9YW3zNVMi
	 kd5POlewwCAnthg/5KxgpvaB+Q0fANyNE1dw0vkjGopTTDomwaK34hgJgTyQailxLkLXT
	 vGyD2iS4QBGU69A72aX11nXfeKV9Ehp+3dgcPUh97c2LK075Bi8Mgnkj8C7Tbmsao4QY8
	 +IP6cbxp+qJKimddyuNYZ4nHpQJKP7AzeusUi/pJCT7oIzSK0tK2l4BJguS5skNyNBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=DJzOwlhL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FGt8ZcIZ;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5A4606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 03:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F5A4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=DJzOwlhL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FGt8ZcIZ
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id BFB6E1D000B1
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 23:12:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 30 Oct 2026 23:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793416328; x=1793502728; bh=SHH+rCVufO
	Eit+EqtL5xcbWTZGitg/69OAOC6Pfx4cw=; b=DJzOwlhLQa1iBcznvPKnl24lQj
	2AR31opyqXL20I8OIFqgazmSXbNLehoahA466indGJc3JR9EQVRZ6SC4JRiSRpF1
	WkS0SX+ekJDM44eMHKKNik0w88/a6L/8ygALVolUHcrJs9waUQwGPmgOvwUkY4yZ
	Dh/9Rb0uEVVmvAoHRpK1DZd63bvPx0nTKoK2y4LCoF+aVWEV/Zk3ZeX3NxCVv9V1
	nohRwPtm5DA1AnNmGwg5yG7OgKSVLk/dTWlI6hRQ0wwAqzvO8CCq1nDHs7GmhGFv
	XqAPxxJQ7Euis7tu/hiZ1s+7uEXLDoiv8Z15CxEHfvyXfc6O9uqVduV1FSgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793416328; x=1793502728; bh=SHH+rCVufOEit+EqtL5xcbWTZGitg/69OAO
	C6Pfx4cw=; b=FGt8ZcIZVEQadb+QgJJju/oyYLPE/PVrfJpi93Bo6Gif9YwJ+vx
	hw8dvls6IIUhxPh5xZdG8ofuKKz2qo84mAtBClIdNaq/rL6qx3gpILGRBMvgqpbM
	v+Jd3+a2d+9IsBZoln5Fb7w+LPZLaJYuicTk2mM5XwlkcMCnUe8v5ojygcX6xU+Z
	YlW7Bip6k106CxBI9IyFfPQpG0LMCOrAqSUZ4JQMqlfMJUHLK7h4XHyE2I7HTsmE
	jHXP2aMHYudQtin/HomO+LihU0R1g6lMCrsshWw/E3v9KHfWrpkZHPfaoRvIgyHy
	ffHtC++SASScoa/9n9ZfYZjnsa7pnldG3lg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793416328; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:j+tq58fKn+hOg0KuMbufwD/HLDD8of/9q0Sqj7ARoUOhZmW
	l2uDSiTZYertagfDT0j/R9MZwucUivqHGZrn1u1HkxFbdQJjWwYA1WMhRHcLE+yW
	HshNCsSHasKdELlWBFopWD0GcHrITZMjVuof2GmTtN2Ll+4dgFDeElrf1nk8QztS
	2GoOkyi2+JJKgvpCe3v+B/QSXE8IPz24raMd+fZb+sJU2oppaxrCzOc8Rw5qckJT
	uF3WzqCp9LKpnsd1VwiqT5Nm0jCwB8CL+OMCS2fEppczMcDP4/us7+7ZNhqSlvNe
	9kUg575xuuege/qtZFky51C5UFVUw+3DJxS50jA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:dHgByGv1EtCbw87olofxO3ONwrN66cNTaBDJ1UVGUD0=:r38B6KoUYmh2Xx0sJ13l0xG/Bkuc4HEiGZuMLgN87Gc=;
X-ME-Sender: <xms:iFzlaljTHRntJFm2OowiOlyvW8gHWNDsBsJ3u9Ti7Mth0jOK4OP9Hg>
    <xme:iFzlatQUMtdmw3J2qlnXyeXIWtZuAVxIkOlbzbZfj7Hx5vnAR66LqySJfTHQ4Sjld
    _luFtZPP5r2HB6hGJZdNo_xVVx6uJOZ6IgPMO19Tk5raQS9fbmBF1MB>
X-ME-Received: <xmr:iFzlaujZQ5Nghw-LG49LpPo2Zqcsu1IFmtYJsu1AOvrfaFjKHQsJSV1LTzQ6ejwZ7auTqe_rNglvvilb7n26OB9JPjjEy6bH6HZY>
X-ME-Proxy-Cause: dmFkZTEgLnf9W5IyQHxP5fe6B+HvG2Vm8w3OPk8LgtVUjGrR+xYbIoEaCQ2dND2bFALJKQ
    0biCIEWnLTtvlX2YTx1TCArO30OdHozO//0uY9bxOb4fGjSeFMlWFgX1nyWwNeIwAXeNwn
    grdU2bveZ6bvk7uPu3PqMu+ToPLJqS3vSIE5pMHNfH6Tlpho4kOmG0LduUZqSQbyAakFDD
    uZCjVKikYcOPDolWhORUGCudUP+vaY56XpsAOe4aBNkh+MpSbgAxvd7NBdcezuvbl5D97+
    QiIKQ6sc8XSm3ZxxfkyJlVIzPSoKgT6bzu3UGO+EqHHGG1VbXDsUQrMhEIMDGqBxRAMIRH
    fdIrxj4DaK7gai9qY3Eu5n4bAgaUus8vFORpZF/y3r5PDWO0yRxUkEkdg5oFYdUsPJllqN
    DQ1I2OwShEzzHJyn3Ew4r30f5Xq+5GaJijWGEmTu3/e9bV73Dy/jqP40OhrUFkZtgYzSX8
    1QCQtiIc+KafCa3HqC2z8OQ2XG/8YqhM2v+71Rk6gFqL90x1K9jtbZv9ZNKFr1zpv//tyn
    Gd9lBCT/Ps/pvUsrOrSmsXBTEa0dCxwCyfOiU7/sMEWtad3NEM6UTz9WEoN5u+FTlddyBx
    jLaeE8baEKRay7/JXaXZpgGBcMsJ2HFg9+1o6kyUfPhPZFBD8fPAvxuT6YSQ
X-ME-Proxy: <xmx:iFzlal6z6yWQPeyuCtlnXq-V8DkowqH-mY_iPEuvYDtpv-Kjj2mBJw>
    <xmx:iFzlajBUu9FyixP9TT3M2kG_nN1MT6UUguZ975wFBYL7wme9K-_xRg>
    <xmx:iFzlakYCeUQoz3p3cyAK6JBVnMQknewRV6Wlt9H2bjkQuxJSeFNUzA>
    <xmx:iFzlamacRw-CmpbtI8PPnr76oBZ3AQpauXD_HEWq1Rch-B_KAFtSeQ>
    <xmx:iFzlahVkJkXvFA1NGjh0rPV726wDmxSSvjoenCywTLX8cF0wkTJ5gM4R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 23:12:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t5702: be more resilient to env quoting
In-Reply-To: <20261031002550.GA626623@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 30 Oct 2026 20:25:50 -0400")
References: <20261031002550.GA626623@coredump.intra.peff.net>
Date: Fri, 30 Oct 2026 20:12:06 -0700
Message-ID: <xmqqwlqytvg9.fsf@gitster.g>
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

Jeff King <peff@peff.net> writes:

> The new coreutils hit Debian unstable, so I ran into this doing my usual
> daily "make test". I wondered what idiot did the overly-complicated
> "env" invocation in the first place, but naturally it turns out it was
> me.

Namely, in eaa0fd6584 (git_connect(): fix corner cases in
downgrading v2 to v0, 2023-03-17).  The log message starts by
discussing dropping a "push" that asks for v2 to v0 because we can
only do v2 for fetches, but the three tests added by the patch
verify that fetch, push, and archive invoked via a custom path do
not request v2.

I can see that the patch correctly checks the value of '$GIT_PROTOCOL'
in the environment when these custom commands are invoked.  I would
have to read the log message for the "head-scratching notes" in
eaa0fd6584 if I wanted to remind myself why the original code wanted
to downgrade a custom upload-pack to v0 in the first place.  Luckily,
I do not have to do that to be convinced that this particular patch
is correct.
