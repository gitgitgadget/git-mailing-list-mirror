Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892812;
	b=BG5x30hdo4lopultnUyuSbMVtEjbLNOjDugZnjR4x9O2/hEJkwXJKb1RUTWPcf9wTsHu
	 AZqmQGHnOl3jFj0HFYiCXeuMp1+No+nDbWYPP+Z83jfZ2EnLDsX1BNZRb5AVtDQHmxpcP
	 vx+9/QWDT1e5DK6Mqr7AgbxIAkpakBIOqtyedopF71FLlgL4Jl7VWrpoc3pQ1vQfj6Ryd
	 E0Ngfefu/0uAN8uo/1FzoqUo1lNJ3Jm3vu14Gnz11g1OjaQhOULzf5aMJQQQHB2DVDPPw
	 cIR+x0UlfGacl5csIBvRjw+g14hB2B60/xZcYP3kUUTTA2fjM3dIFGqPHfYgwCs+e7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892812;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YLCa05qhjBDa0BiW0/mUCwGmDyAmTq7vX1IW1ZlofKQ=;
	b=CNSIDR+bMuaO0AaVaNqL2/Zq7R6M1o4aTA/XF50nOlDCGRzhFvm+mf1tyH4X9xtCU2Ge
	 YeTFH69c9sgjoO0fArYi+SLbVwv58oJZBWSaSrnhEVvJ6BMWwvVqS+qGv9qTbRIY4Eiy4
	 X/9AlbFmvaYCd1gqxHRUgTQp00go15rd5XdtIlm9EnJW1+/KX6ydML17EPwsdo3QjN4sE
	 4KZCvqQKK2F+Dt9sXtD3z/RUwKqHTnUVlq797a3EuhZRRVx62mEsy7EIhtYf27veXdJ62
	 lB6Cd3q837xA0ycXgiGGGL8a+g2k++0WHEvfCH2GZ88RafSIxO8bKj3IOR+13tIG0RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=woTojZ0Q;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=H2UOuky+;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB252606D815
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB252606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=woTojZ0Q;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=H2UOuky+
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 04A26EC0081
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 10:33:31 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 05 Nov 2026 10:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793892810; x=1793979210; bh=YLCa05qhjB
	Da0BiW0/mUCwGmDyAmTq7vX1IW1ZlofKQ=; b=woTojZ0QlD92B23Ajsq2URWQc9
	JKdjl6lTntVOHJ0fJ0vaM8W7/yiJQvBGCXhFpHiEzZF1uuCvRl69ATOTPU3uZTUT
	lY67d4E7PEoZOJDPAVHMb5mXBUUwGS/XrfS5lQ7phk77NY+63KDnuezYRzb+uWzp
	Ehic48Xk4IK7WxJ2UYP3+Cd2SBDBoDP75VekrI1W582RGP5juTCQjKSmPPCwKyQj
	bTbFvhVDl4Zdto7/yo8Zn8svQbHZUo92AJKU3/BZ+jSHRU/kO1FSV+G2nHmAYiMp
	EUmQS3MEDuLsS6O3n6/fWw8xsb6JvypJddzFqVQpztmgedEJ36yM3XJxvO/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793892810; x=1793979210; bh=YLCa05qhjBDa0BiW0/mUCwGmDyAmTq7vX1I
	W1ZlofKQ=; b=H2UOuky+kWArhigTrPedaEDy8uvfp9nqdtfn/sHz1luCJ7+CAgq
	sBWY+qBK1eYjFlLxk3HjxlRYfw5nKXpbLGnQBTW+mZ/Yc+i/UBVo2JQUxrQ+73WX
	m5qDrWhkeh12vUQQ8YLYD1idEkv2u8L2O29KncMFXHyShab+zNb0jhDzIDqjrEkI
	CO4KRRhGl8HI1DM4xm5+cHaiaTtVf37oDzLJCTY5qU9iSAlItNTireLVWMERpF5I
	cdoR8ZaWfaHFFHWQW5bGuw1GUXMS+Ajpwfpnn/Oi5gYt0IbRQpTy+3PIMJ75PPiH
	14R4EJNrQzCvSItbxhHQq+ZNbEcg4FiyB+g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793892810; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:BqUSTETYXScUCd4+PDYMYWumk62+/3BDsWyAxFnKrT75+mS
	7t+JFdSAnIvS8p3o/u9vwuUDmZKhi6jQknEYr/IhnGsPggijdXEqNjQFbZ5aqmba
	T5NpIDldtYO+en8I+7BDUdaWNwh4gg46F2Ubf0P+LaZPTRZbNc1W6KPAVbFJTXsN
	t6BvHotg3iMdxfYrJM5IfZRiImzJTEO/LCxIMG3Z/rGbEKcyzA1NWkOVnz3lCl6G
	bld8ss0HmFpub4XKpsdkm9iLX4QmT1hZdEAFsmdGRtl04FSyQ3fLWwagqekXrQJW
	9ZJuJ5+Z8MHBEmEK3DexgpZkcHQNj9/VD2mimhA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:TB8ToUw7kolLYvyu49e2xc6pA2hLYaYSrsS53OUD/sc=:u8ftRuhRqGInNPHl8VwHt4z6iDV0mkUBXeNv/HBdVwA=;
X-ME-Sender: <xms:yqHsauYlcXkSXvdxTL_JLIk4ti3cZC4PthS9jUfMWnG7KQFkGKjTcg>
    <xme:yqHsanZm1Znuk7EPjeTuYEm7BFtqqBkFH5Lne6hJ3Q0DY-NrE0y08lvrbo09fdn79
    71_QeSN6_658ABw0V-KnCJC4VxzLKLk-5fT9PL2s5Jf9diEfwBI6QmC>
X-ME-Received: <xmr:yqHsamma-zZPQ-TpCD_7zhbMrwDeZ2m0yUmR8c5-BMVE0AolhgLmPA>
X-ME-Proxy-Cause: dmFkZTGC4e0U3AKZwkNsyL6gpgfU7wiHJIxySTlJ51huPsK7dSTJgWs16sHVXTjDs7r+5I
    t6dmwjVlPReKMurP3LiUsw2pUxG04QMClKW1gKYU5li5lulVkdemYlg5k/TGU9ZNe7goFr
    AdT9LSHm6vKfRoP8g/AXhGYJaT9BVdYjpPJoLGaGSdDANrz1oWuo9Jsr/VLWbyt0pAZJAN
    n1C934b7TbGUcXZki48jwUTp7BFPIjJ3EhRlW7HmtM2q1uLvXhTG7n7KI6To4H8foGQBig
    3o2xULOc6+OqsGN7JH6PmhzdxO3k97kiGG0X8gV/1nvp/8Cs3GUFOIRjET60HQhXMpeAY0
    y1ijTcLpLQw8AfxhQ9dsZ7i5b5SvMqfkv/J5U+1RgvIRCc/LX/5tBwQK6E+lltP8SMyVtl
    0dsndnOv8pVP114qSZG6+YDFw/wQgYpRbeG0AIcWL3WJtluggcpp5Iy+d4nXeodxcX7ncA
    WKUHtud0QBRJrS1kDyQxKaXwIFi8vL8FFdUX6O3EFFlJN7NKi6DAI+jM5UTp1ReTSJ80YY
    S69jSAfzbnrDEOztvAUuAgkNClY1ZxWhSRosuslk2vmD69WnUD8k7Eq8+V77XxSi5fCqz+
    2D78akRA4aUbnSouC9rEatvra2f/6BRF2wP4cBhekRrg8FDi9E5NAZqLs5ZA
X-ME-Proxy: <xmx:yqHsarxdgQS4RNzJ3UtjIO0O0eK6-UCDY04qqYcLiQJumNn1nUdWbA>
    <xmx:yqHsasNOYoAXWEqOtNyq65t9xHvCzzGBYlyIGb-nPPkV36MnNA2i2Q>
    <xmx:yqHsanSm-k_yQb8knB4aUFj4VZ7WL7xOZAHeFbMZabAUEbEX5okBkQ>
    <xmx:yqHsaibKySUf_eUgxLeJkpwj8Ba1cAamiGEBQ-o1Y50nlwTAPlRlTg>
    <xmx:yqHsaqrqNEyVeTitgrBJrcHRKBpJf8qKi9lYMBqNUAedf8p5nfxZ0Dur>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 10:33:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 16d5136a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Nov 2026 15:33:29 +0000 (UTC)
Date: Thu, 5 Nov 2026 16:33:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/10] commit-graph: several refactorings for writing
 commit graphs
Message-ID: <auyhxtMFUwrDJdHT@pks.im>
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
 <0e74f6c3-2f43-4829-a071-27e96ab5e87b@gmail.com>
 <auyLRZ8TWeqdIaRm@pks.im>
 <ca5986e3-8f66-4628-9f06-eb2416378bef@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca5986e3-8f66-4628-9f06-eb2416378bef@gmail.com>

On Thu, Nov 05, 2026 at 10:18:51AM -0500, Derrick Stolee wrote:
> On 11/5/2026 8:57 AM, Patrick Steinhardt wrote:
> > On Wed, Nov 04, 2026 at 11:37:11AM -0500, Derrick Stolee wrote:
> >> On 11/4/2026 10:57 AM, Patrick Steinhardt wrote:
> >>> Hi,
> >>>
> >>> this patch series includes several small cleanups for the interfaces for
> >>> writing commit graphs. Most importantly, the series refactors options so
> >>> that they all get passed via `struct commit_graph_write_options`. These
> >>> cleanups are split out of a bigger change to make reading and writing
> >>> commit-graphs pluggable via the object database bakcend.
> >> These cleanups look great. They are carefully constructed to be as
> >> simple as possible at each step. It's good to bring some of these
> >> conventions into a more modern style and to simplify things in the
> >> process.
> > 
> > Ah, by the way, one thing I forgot: I noticed this recently already, but
> > you don't reply-to-all and thus lose the Cc's on your replies. That made
> > me miss a couple of your replies already, so I'd appreciate it if you
> > could keep them.
> Sorry about that. I learned that Thunderbird replaced the "Reply All"
> button with a "Reply List" button that led to this unintentional
> behavior. I'll figure out how to change that default.

The joy of random UI updates.

Patrick
