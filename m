Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482BE1A2C04
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 06:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791183583; cv=none; b=JY8C+QhJEV4kW4dylGNw0KYk1ogmLnEtLcSDaxsYQn7VD2/VcGR8RDoMwik3GNZdoFE/b6X8UCXr2O5ZWQLHg4a5rBtIn49lkUIEYXCeUK221vEd7u2NZcB3i68HNrFGXuVhPfXy0rMPjuFl+jL6hzU6K84fEVNRaHt+LoRZpJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791183583; c=relaxed/simple;
	bh=en/GSAqp3MQxoH1g74zZS8QqqL35GE8R87tK+UKBh+I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UwwN4tvvAR2o1iboYW0Z7JNRH7rqHC72bsqjWBCTLoV+wsUEwT9fUOIBXLGWRrfji0rePKORePwp+NxyOdypTRckJFEuZrOFEhVsA+36fxhpBry6Dkn34FyPbIRfr2/6RbNMo90JrZq9G21nq2VT+/w+RjvQdm6Jg+fKMuQuxMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me; spf=pass smtp.mailfrom=5ouma.me; dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b=hYFhuvzh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NalibLGe; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=5ouma.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b="hYFhuvzh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NalibLGe"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3CAC4EC09C7
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 02:59:41 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-06.internal (MEProxy); Mon, 05 Oct 2026 02:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=5ouma.me; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791183581;
	 x=1791269981; bh=en/GSAqp3MQxoH1g74zZS8QqqL35GE8R87tK+UKBh+I=; b=
	hYFhuvzhDDUhPECqIyF/C5y/MenqDC7bCSKeSABrstQQwSCs5B/3sXIp7kS76pR+
	5uVHeCFQLZdy4pQCBH3ChPBO3ojh2PPM/mm3aKN4ktiOCDkKjO3LkfxiumLjAKKd
	Cz9IUEZazBbhUPPu3+nN34dz31+nUYYm++iPHtNnIMS9pDcHdSOSP0A5hB8lCv58
	LrxcwcTvz2O4xHQ//dzRYVBrAAuWbZiXCJ0eUhgroKY+Orr7sQCNd9j7pc8u8yEq
	fF9jOfp6DkmwKwPoZjsMHvsbMblD33p5aDxYLsORByaO7dIo3FonCwQKqU6Z6YYX
	mVIqd2GvjfRrWlHwT9eWWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791183581; x=
	1791269981; bh=en/GSAqp3MQxoH1g74zZS8QqqL35GE8R87tK+UKBh+I=; b=N
	alibLGeNM3LVrnvnw44g6/sgrCLfiQhzYZZGhB4vGLFaliEZsfgyZSwVpZy96G2o
	EaHnUz2IWuwVCizxi+q16XilgPOLy43zmlQiTfTsOcXPgNsdaorHWEP69FOjcqE9
	QMGX1dxKJPUAZ/tachDoBz6oJSyY2YKLZbTLEWFlA4zH6Yz6G3oS3jP+dt68H39B
	Rt/sgtBcSzetzGP7QYe5fuLL8escBiJk0Af4WAnweohwwvaGjrpT8J+gRrUe3EFJ
	rIDUeZ3XGLyDtG64LzeBfDkhacPlWhllm3TruKy68u7bIdJGzyEglHq9wJBn2Hbr
	pvHjCOuJCgEhvvWqxl1dQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=5ouma.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791183581; d=5ouma.me;
	mf=PGdpdEA1b3VtYS5tZT4=; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Ki5TCktqOmLvS+PGQxfJ403+zXzsnCm9vN4TFSnITNkKiUV
	x5RSoXj8eOIoTifsv3w3HR/0DNawTRVPa1TxUxIBh79W7Zbk4T2U1LytGVssH2sP
	8fpWPQ90JkInNyPZm8/jRUxXuE60mRitpEl2xwpcTp0GPEfqmH3OxkWOJfenfKK8
	v3t25oBnlEYc2+9VYwGiPC29EEmxHsVdqxvUiJwjKkvLVrUCVonFjhPAB8trc/7Q
	RIIZd4QoMhvx+8cARBz5J+nwrUd1XCRuk59D8SpNkRtcMgzJqV2E3lX39sy63qVm
	b4/fCD02+sLlrle5DxTLk3WoGoclVjShcEP05mg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:w6KYa0uAU+NqAgdBAARvjdhxaDwc2bh4mj8ngcs4hsY=:en/GSAqp3MQxoH1g74zZS8QqqL35GE8R87tK+UKBh+I=;
X-ME-Sender: <xms:3ErDavYRJ0QVdYAspApk-XkdLM2pR6YUXlt6m52lRksuyDABZhHvAg>
    <xme:3ErDapN9HN2x9b67KrzSUKO9LEphf6S5siNU-Ky4TcsX4GPhhMEbz-YEr4TB86dp7
    emtt0dX2AouRrHEzjTlI3wEUliCAF1P_TNNYg_-QcdeGOBr3-dstOYO>
X-ME-Proxy-Cause: dmFkZTFvZvDw35m0IEs+5zkEIahHudA2hGHBNHzHV8jY7tXu6+zw8f9oG79JMcpgVAIT6z
    Hi84L+7mLG6c33cWLpSgLl8YiXRZrX08rWhgJRuypHP/iUjRC+++hs3r+EDdnTXUlBSRIO
    ImZaLAqem4yyXS1Ykx1VS5nzrD5F37FWfIB0anoksxXhmWUGgmtC03xXo5eC8knebx6cPM
    b1Jmmn0gVM6oNwN3S22CydeHAxL3DhFE8vOlbzAvd26jx3LPb62jFlalGIqQc4PTEJcvJ7
    1RY0Mji9pyIy939P1Z4ZuZVhIh1G7egh4yO7ZofdpzsYgG+bkMRpKLe30BAN91NyS+C4HB
    RyibvC3mtJyEUBaMWg64ZOx08qsZF5nORCMFyHUDyLscUH1nIbHTZxRGu/+75WqEGal/Dk
    Q4GbojFQQQ1Ni7x6Dk69XwdqTWPqS38eyQsLTWBd8hTuTox+tXGpS+77QHCa+WxF+SrsuZ
    LW/uK6P8V8jS2CAg0bF8D0GueiF+RslcWR+w3YtBnpuffS2Y6pUTiaWVneOhRSU+8SjD0l
    gow7qOoaIR9udaJIypN0RLahxF/eChfzAK+gShjFGpePN3P6t/my9h9D7V2N9J6UYJXbOY
    MLGG7s9+WySXbzrZP7qwtw+fWF6Jf83xqLSV04gq6t6KVD3bFyF/U0TA0yFg
X-ME-Proxy: <xmx:3UrDah19W4S51CriDbYn3_mtMjfro9PeS62_o8AK25wT6wKYpOPkzg>
    <xmx:3UrDav3W4vK3wF0aKiUt2oDAeoY87VjEM9DrV8eyw9gzCzn8CWsKPQ>
    <xmx:3UrDak9TWjl_T-IS31J16pQm-uBgj-o0CwOVx6TmleHNqNNztS92LQ>
    <xmx:3UrDas3zs-shlSuHxMcJ97MnG6z7pFbiVPqJPreSYyS7k5FCRSFUcQ>
    <xmx:3UrDavsR-eV7OOJUtDeBxPLbOnjAn62kDeuwiXtTjQy1_jpDASPyiGRt>
Feedback-ID: i4b264863:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D7B3E700065; Mon,  5 Oct 2026 02:59:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 05 Oct 2026 15:59:20 +0900
From: Souma <git@5ouma.me>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Message-Id: <f86f6cfc-56b4-4358-a9b5-95630c6504ed@app.fastmail.com>
In-Reply-To: <xmqq5wzhv9c8.fsf@gitster.g>
References: <20260703145037.69832-1-git@5ouma.me>
 <20261003134058.23494-1-git@5ouma.me> <xmqq5wzhv9c8.fsf@gitster.g>
Subject: Re: [PATCH v5 0/2] history: sign rewritten commits
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

It=E2=80=99s a deliberate literal placeholder, not a real option. It ind=
icates that more =C2=A0--no-*=C2=A0 options are available; typing =C2=A0=
--no-=C2=A0expands them like --no-dry-run.
