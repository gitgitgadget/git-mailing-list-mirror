Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D6C2C21F4
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 06:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762409086; cv=none; b=HWpFoMwxjdwBsXLuI7mG4tWv9JLe/fqaPQ1aDB8rdlxWDZ06Pdre17oEsvXk1Y5XTG8PIQ2bFJoBR16+VNzMJHyRSVBwW7rNenU+N34vuR1cxDg4VSKJ9qa3UdsCSVxH/d3EjeN5oAlSiYguEuokCGxTN/+SIDBfzu+dewr4P88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762409086; c=relaxed/simple;
	bh=w+vTbGGmm2D3xtvm6Mf3sX7+9jt7ijDg6gzCjVopFKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unWpt0WpMunp8OGMrJWfgbETHPAyyScDvhZIFmTJQZflmEbP0xZlBnTLxhK7vuFdSV0FC3brIUwIz0w4u0aXmfems0OfkHi3WHOLcpGAoWyhxN2FUp4XopYs/M1s9JlS3h/z/Nlqy31bNKLtrIX2lIbjmnIIKvpqliPHIjcg/RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MBU29ZkN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CHeTLKu6; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MBU29ZkN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CHeTLKu6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8B2CFEC0265;
	Thu,  6 Nov 2025 01:04:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 06 Nov 2025 01:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762409082;
	 x=1762495482; bh=57SVLqq7YOhFNPMgleV8i5PhljKqYZp2NcWO7mHsw+A=; b=
	MBU29ZkNpDVIujhMsO4uD/O9wh8wuipcTKpcHX2erOoCt3fZUSKAJdcPTcf0VeLG
	0Wxkpv/0hMiA1AEZ1vrQDFX10ZWO1CAiWhaQDciTg0UHdCRHNTwEYi/E+lIUNgF8
	qqpnJOht+PCVvGwNV1TExr6MJ8kP5scTGxwruPOSxIBcCEwb8ic9RLFD16kympEW
	YMUYzUNUSzGzVB/udJpUZVPfK8AfZSTOTH3svdFYl/WfVsYx1Ua+ovQXTCVy8hGF
	v9w8W0NXUZCaCE/WYq+U1N179C6JAyRBZeHvN2lxIMQeFpbDee2HPrFimGmC92li
	KCYJ1AlwkhL887aR87zhEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762409082; x=
	1762495482; bh=57SVLqq7YOhFNPMgleV8i5PhljKqYZp2NcWO7mHsw+A=; b=C
	HeTLKu65f2x1aZep4+8bkYfH8IUPBIE78JszWLL+ppvVD/wyJjsPwt984da30Px0
	bFTbezdX0mMS7OvyQQ1+21LMADvUlV3R358i4oP+MGJhq7fnDoMV3sF21gAO33De
	9XgrUcE7UfEnG0PgdVckdBivGtB4pOFdwPpe9kzfjKd66BfqGnCLjxGJpRA45YmK
	DA4Z9LlEfgaQBE+AjDfbb9Tnp07Joo59HdSvYDF40P42Ugt4R1hHy7NVXmj/75Zc
	ZBtbku3LgX9lcQb1wBgELNAdv2fLXklkmzZXdl6TA4O1gi85wDns7AGciskY83Zj
	57Nd4lHeRYHlcP6tG1F/w==
X-ME-Sender: <xms:ejoMaXV9K7Xq70mSUlZ_JMZu1jf5OFknbbDP437DqejjTUJw3sJK3w>
    <xme:ejoMaXCA6QWAeyfBDfwKqQcuvnMBmbbC21PGtNDUjsL-tLOnlrH4U3mdz_1-TVVFE
    tSUIhVgUk2Al8tLWVSdffhwre-6TMS1a8vu2Wiu9yq1kvLWa3h8snE>
X-ME-Received: <xmr:ejoMaQxYjglt9bm11bCjBcsSda4wgJPIm8Tvn0FCXo8OEpDDzSnKhJn14GCsVMf5UqD_FrtUhmbUdU9nkz15mUR3pUxJhLxoks9lBqGFa39H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeitddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvhe
    ekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ejoMacDIkHBni_myb5JiKElvs5N88R2rhIMLV_JjR8lJFP-L1N7--A>
    <xmx:ejoMaVZ1Y_0Q5VgDsRGWbXPJzYqrbVHEbO9FfmBCXomoHZ0_UxB8Kw>
    <xmx:ejoMaci6nQjre7EuGEbVFzxl0XDVsg7y8WiHi16B-fLjy6_erQslcw>
    <xmx:ejoMaf5AK2_bfmcPuPUrYPYPF2AZnCd-bLFcEYEzE8HNfY0v2vyDMg>
    <xmx:ejoMabzWpQ3DsSlZVM0AvzuX8nllnDMWlD6bM_snLrWam4umjcN8Tkno>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 01:04:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ce1bf083 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 6 Nov 2025 06:04:39 +0000 (UTC)
Date: Thu, 6 Nov 2025 07:04:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] ref-filter: fix stale parsed objects
Message-ID: <aQw6dM2O5wSoLd9E@pks.im>
References: <20251104-b4-pks-ref-filter-fixup-v1-1-2fbca52d76d9@pks.im>
 <xmqqpl9xps3x.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqpl9xps3x.fsf@gitster.g>

On Tue, Nov 04, 2025 at 10:31:14AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > In 054f5f457e (ref-filter: parse objects on demand, 2025-10-23) we have
> > started to skip parsing some objects in case we don't need to access
> > their values in the first place. This was done by introducing a new
> > member `struct expand_data::maybe_object` that gets populated on demand
> > via `get_or_parse_object()`.
> >
> > This has led to a regression though where the object now gets reused
> > because we don't reset it properly. The `oi` structure is declared in
> > global scope, and there is no single place where we reset it before
> > invoking `get_object()`. The consequence is that the `maybe_object`
> > member doesn't get reset across calls, so subsequent calls will end up
> > reusing the same object.
> >
> > This is only an issue for a subset of retrieved values, as not all of
> > the infrastructure ends up calling `get_or_parse_object()`. So the
> > effect is limited, which is probably why the issue wasn't detected
> > earlier.
> >
> > Fix the issue by resetting `maybe_object` in `get_object()`.
> >
> > Reported-by: Junio C Hamano <gitster@pobox.com>
> > Based-on-patch-by: Jeff King <peff@peff.net>
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > As reported by Junio in <xmqqo6pjt2wn.fsf@gitster.g>. This applies
> > directly on top of ps/ref-peeled-tags at 054f5f457e (ref-filter: parse
> > objects on demand, 2025-10-23)
> >
> > Thanks!
> 
> Thanks.  As we stop reusing a stale maybe_object and instead start
> parsing the right object when we need to, I wondered if the "on
> demand" commit needs a new benchmark, but the example cited in the
> message used %(raw) so it would not be affected, I guess.

I just did another benchmark, and relative numbers still look the same
as in the original one:

    Benchmark 1: for-each-ref (revision = a29e2e8fe7e3935e23d2a03dc429cc9c2e68bfbe~)
      Time (mean ± σ):     369.6 ms ±   0.5 ms    [User: 311.9 ms, System: 56.3 ms]
      Range (min … max):   368.7 ms … 370.1 ms    10 runs

    Benchmark 2: for-each-ref (revision = a29e2e8fe7e3935e23d2a03dc429cc9c2e68bfbe)
      Time (mean ± σ):     327.9 ms ±   0.5 ms    [User: 279.9 ms, System: 46.6 ms]
      Range (min … max):   327.3 ms … 328.8 ms    10 runs

    Summary
      for-each-ref (revision = a29e2e8fe7e3935e23d2a03dc429cc9c2e68bfbe) ran
        1.13 ± 0.00 times faster than for-each-ref (revision = a29e2e8fe7e3935e23d2a03dc429cc9c2e68bfbe~)

Thanks!

Patrick
