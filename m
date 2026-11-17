Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794957913;
	b=Egn+b/P0/7gH7oYGJoVs9z8tf8YFJsbUIEMoh2VBSbYGyT+vIN0mD/wC9gbXvkNCevzK
	 2dPvaRxEqxCkUby05eech7Nda+U6wzmsG25dAA+w2EeSl45YyxuKLMtwZq90cNZuqJt/8
	 4wSxXD8G4DQhhewejcYPnv/hwn3cAqmKqxVSJu7mrptQjsDSZYVjd/2MYy4/e3c1mi/fB
	 LgIw5gWUUZ1egn8KWrW6HcTEEuMfDTXXvwnGx6I6yQQ9yw8UXXIhtzsqRk9uzP/bxfPKd
	 Q+/jgRdmV1ONmXwbsZoMJDOrQEiF2jfy/SOsbi4+55uKyJCJs+PYqPq691b7W2jdbiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794957913;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=GkKadOJmidSxbXDRLiQvfD5+c+/3E8TIOjYdSPc3wnQ=;
	b=nT7RcgZ4VK2x9AkonfNM3/48pfwYVBwjBnbUnhMLrhf1a7wqCoCgk46pUfX4sBe5zFvX
	 ZzvZxmyWgDTf0hskzoAXsnnfUqicjwcPgMpBC7AVS9hTFMZAnbTqNzFI1kFO/pXWjemh7
	 0PXXBWLSJWlXYh6DK/ih3VN07af6OfTIx4grXkd2+kAaVWT4g+ca/UsRZ30+SQaHWeMBY
	 SvJBMTagNuMuILjlkT9olF+IpGDTRNZxfrUtnltI8J0ksYqh4OioNnqYU7Og2oh+iSbFI
	 BigkkHr3upc9bhUcuiqNVZDBqL9v7BJN69XYUOWFbZBH5ggu0iUpMlbb7fIHfUz+XhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="fv/rhSwm";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cFqHrIQR;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D94606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 23:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0D94606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fv/rhSwm;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cFqHrIQR
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id E3CB01D0014F
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 18:25:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 17 Nov 2026 18:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794957911; x=1795044311; bh=GkKadOJmid
	SxbXDRLiQvfD5+c+/3E8TIOjYdSPc3wnQ=; b=fv/rhSwmlJClM9Zkmn5wFukumT
	dhEnaGEfYvdrkcqiiRXbE2fRJ19+UblZOxEd1RhPslafVZtvRyWt7jEREV8UL5yG
	UeYWnKzyho4KDqy1YlmpHmQpdNkUwFhpVMOvag0+AJxe91ALeI80f90DePlWL9oN
	DtAj9L43hBkrdGFEmIKCsHOVm847y7MNMbJH4+SQUGmC2JnYrocwRfx+JAIoBPCF
	p+JT4ThC89LsvxZyHSg1f9mOJqQ1IKfmhYWf9/ti+JJb9N1WXqZyB0Aa41P5ZACn
	CwQhak1abACYgKTNvP0FTOwNPZFiOf0HmtQDJ2TQ74svJICmn2/d9xWZ+TQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794957911; x=1795044311; bh=GkKadOJmidSxbXDRLiQvfD5+c+/3E8TIOjY
	dSPc3wnQ=; b=cFqHrIQRgCqovf3cKTuVpoPEDycgsO2Gf1WH2m/esUMvN02fL5h
	1ePzbTSKheZViI6ZSUzpAUQLA9UvOPi7MARQh6gqHKduUmV4ghPzhlFn83x2wI27
	uTiN6Hq46g7l6fJYVIZ+nmcZdyS/gO/28vOjZ+aMCHips6ztLDlZ2CD+Dfj9hbu7
	sMh4QjQxdPabE3NM2fgSOyt4WINb12OYN1jrhcOjPKLuErZzYmzmJhTrlk10nTsa
	49Z1q5RuWWcY3tgaMXj3KWhYSSym/XUs8zcjbPv0Psx/WIdP58xmyG1ZuHS+IADS
	W7IDDVQ/Fjln5Fv4p8ntdWNjCLtFZjLX1Kg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794957911; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:HDNfLVM9sHOK0r4LPZ/0XJWAb3EWtZ4HTwOMXf8971jXJ4B
	F34ThR6C8xLlqn8FNhDiEwPl58oCrDyvXb1VP6j+T3rGmXyB41+xC9uQvVa8pQ4A
	vE0doDtiEvKQiHWekoWurbZAx5if1FjbFoYrC89Ygr5UjhWuPYGXumNpz8trUXAT
	V/OULL9cwh4OkN2Eg6xkDIBNYqxzX3fpKOsIqvBy2s7hLuUBc7IkDsskStUdxUJo
	CnOvSZ4VV6BEvCEsdV8TnL6VvH7KJcBBgtQrMe6zNWMyRGgZXxKL5ByTNrWpgjX2
	SkBjaiWX27FmTnYtxuTwYZW9/SE3el+smqaNH6g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Jra/F7U23qVCg1nONU0HHMJrSF90XZhUsdUvkC7nOBE=:3VB00IxV9kZx1D8oiwjxbHtz38WIKrf54wJZ3wpP5y0=;
X-ME-Sender: <xms:V-L8akl5m1CLwwYyQfqNU_5iRiezYBx1YA8YtvcfPZTO9_9N3y7NDA>
    <xme:V-L8aq36pIFxWYDIEIVbauZYhOBDC3PKYgqclku6_ZRoEOdUfrbbYEnlxX2Yd5BJt
    cjzN3lTBCHcG-ix1irMZijyEPkkAIlkvlG1EvlyPj5pdOSyotrEe0w>
X-ME-Received: <xmr:V-L8ano33PdsHhrISTERm2Ci4YsfE_SkOPmdcaANYcJw1Z5L0UDmyBNzLn1wjwgWQyJZA0wK0wJcgirYLQ2llBRnQGwan3HsrYCj>
X-ME-Proxy-Cause: dmFkZTGYfvPjABwIyaVxhO+IOHeQRELzZozgG/JMcarO80xbjsxoXECxg6SnJso39y5hdy
    Vw50WsPZW0IjLkqQg5Bb7LNaNStWXmsNgsu/vXq/MPAFmg3AvyV1vhQoKGUxdoAprFXVVL
    9E00bvcEXvgaXuQNBj35ASxvNKlDuHxdrRygYSYOmDtubkCPXF2a7wE8Bm5D27KvJDaGg4
    nNwO3GIzNIBWLQwv2ywunCMunOF1rTboUyi4NUaQHaRBCGDowuIt3XGGmY6PTgchGIfD1k
    g8e3n7iSggWL/eqeuzqXAzcif19FpPgDn/6kwrW5hawEzSpEL/l0zqI9oKzOROh1DWaZbb
    1C0+O9hqDvU8gk9jNMEZmg66XT6FQb0yvm/smXlNV7iCTnvBNXKqlrb+jTz76TYmoPZk+/
    OukraIuLxKT2XhHS5Dxg80tsoaAQsJNAuTUOEwRWp+tKEXt0zTPgx8Bf2KxaRtIhnyPLBy
    xDRVDkjKlPxKAXpOotpglyo5L3C2DYNH/LRAYLjP/0aOf+RBuF1b8oitNqPRl63pH99l1V
    Gqi2XfNDnuow7PNt33Z1kJko13dScZaAIekGFo1Sa/dSa9RlIp6YAVTYiA0bz6dRtd2yJO
    ELIwsUKznEOdudnUX5UTePY1Qo7U84KKuOGwniQiy19/eOY6TWqkmnRd/cAA
X-ME-Proxy: <xmx:V-L8avdIMyy_bs1GZW8XIYedezfisKqx-hBQuHGABOwfIorGUypi9g>
    <xmx:V-L8auowWQiVvzOk05iIh3dkN_VEKfqObw_HmKmfxF9GaHEN_53mTQ>
    <xmx:V-L8aoFdOgI_uodCSf4vfMIfBkah2aJOtiZAGJld_EyviCE90IeDxw>
    <xmx:V-L8amvJsvuKqvXsSXghZ7oPXUvQ12_GE4qAKn_vDqFZe1bShls0Bg>
    <xmx:V-L8apoZY3FqELWIdeqGucNveiUYQve3DIjelSar08-UAD4UoRgFHJ4M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 18:25:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,  Dirk Gouders <dirk@gouders.net>
Subject: Re: [PATCH v2] utf8: add display_mode_esc_sequence_len_counted()
In-Reply-To: <CAHWeT-Zt=1MjD=fbOiAiQtb28Q4DAR_wF12iymXmeXzGyyLgbQ@mail.gmail.com>
	(Andy Koppe's message of "Tue, 17 Nov 2026 23:08:20 +0000")
References: <xmqqmrr7fllq.fsf@gitster.g> <xmqqqzgjcjes.fsf@gitster.g>
	<CAHWeT-Zt=1MjD=fbOiAiQtb28Q4DAR_wF12iymXmeXzGyyLgbQ@mail.gmail.com>
Date: Tue, 17 Nov 2026 15:25:09 -0800
Message-ID: <xmqq33szavmy.fsf@gitster.g>
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

Andy Koppe <andy.koppe@gmail.com> writes:

> Junio C Hamano wrote:
>
>> -       while (isdigit(*p) || *p == ';')
>> +       while (p < end && (isdigit(*p) || *p == ';'))
>
> While you're there, could you add colons (':') to that?

Do we generate such a sequence that uses subseparators?

IIRC, this code is not counting the display width of end-user
supplied string.  Rather, it gets string we paint in a buffer and
then counts how much display column it occupies.
