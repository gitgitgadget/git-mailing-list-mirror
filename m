Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA23F3B8D41
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765022584; cv=none; b=QtnGbozpZnzmadhu0HIZhYhzsz9AZIZabYXD/Za616mf8wgjESX3Qp6zrvusrhdEdwcxpuMsknsU6P2unbjz62k9H9aXpe07hhoouO1bLuL2Ng8oOU0eV6m8Aa/Q+S0k1XgngVDnjI0FXyV47W7ATAy4IsNmOYtVK94wWmPBUmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765022584; c=relaxed/simple;
	bh=BG0aGWX2uY2JGgVEQ1OXDwddpZr03hiXcGiXtgdqrek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOcRJkjYkOOnUaluZVmtQMjb1XJ/R2+bjMxTQiH2vxO3q8nU+F/nCKArh/c5nhq8bmMKX0YJijJC7WWsTxpo1wfmDM0cVD3HEkjjDKPgVUKolZE33NlGeIRYWGiL8w+DrBYC85o7h0aGe+fT4R6hNG4L9WbCu1P4gt/1NBi9hpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V3WCrHRh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=shX2thO8; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V3WCrHRh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="shX2thO8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id F0DB21D00166;
	Sat,  6 Dec 2025 07:03:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 06 Dec 2025 07:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765022581; x=1765108981; bh=pvQ/qxCJ1e
	HdF8zmd7u1TBCvF2PAFzmNKyYE2zLLyq0=; b=V3WCrHRh8FaoObACTEsUdyhk8O
	NzahVA1JJ8Oxf/8M+q1p5tEG2ITSd0jfbCcMXycvAPPwZGBzlOhcocUuRUE++T3K
	kmsHQcwwjo6hGCIp4757g0QvVEUJh/qZvu49t0lZB7OOPoGpELPkc9ggldDNfy0d
	JRHUDDItAN6OYDFzRu/H6Yxmzdfv0/LHPT7lM5YfZ3ERHyN1qGNepGGBhkNAvPiL
	TnqNIqf7oTL95nTCZdaLbIo3f2ZwYxSwVHpRO1x30GK8H0zhN+mpB50HQczAcLOe
	MaalkvQsN4M4CpVTfglbZPUperCXczUdoioSv86jlp83cPexjpugVv9DtHag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765022581; x=1765108981; bh=pvQ/qxCJ1eHdF8zmd7u1TBCvF2PAFzmNKyY
	E2zLLyq0=; b=shX2thO8Zzzo0CRgtj0/yzUh3jcL/O9kDNTD8L2HPrz1FFOMkSe
	4/A98cI5163Q7TGeGifA6x8E3dkye7I5nwEuzOUqcSViha4p5enQcr9bU+E/o5IN
	KCXX+dH5HXhkkpiITDuuCwI58XgUKP3XwmLbnqdPsAR/pGy2qWsT7avuS7V/eODX
	hbhcEUbq9S6PQQJkgw7bRKZqXrXpk3fJZ/euj+kvTDHulte/DF0ajJnKAF1YvznQ
	OruQqfhDJQ1hqzFRKYQmmBs0mQpihffeHtoOIxITmIkwOR3aksRcyHLTFQ/wLtO+
	MqEqf4kV7F1jXNwVT8r/UjpYpRVweOMivXw==
X-ME-Sender: <xms:dRs0aTFhUItltfyUmtlGWNFggogt0OtNWEdJabTkPuW-sPCT3c8jIA>
    <xme:dRs0aYh4KWKyy8Cm3fDTg79JNLTM2WzWlGdaIpEBew8MIwzKrDsAowZaEQ7ufBOf_
    dLzgy1nfbkJsSXsb8D8NzkOv6bn4vu8iqGRwqJsdZWmLXdh41PrpM4>
X-ME-Received: <xmr:dRs0aQtEzaTPn9RZtNWDwAPZdMPY9flhNgyIecmhQIwVwt9XVN2Edoubo1nM931PgQK8iIuIscluwkE7CfwSEAW4aqqWFAWL44ihyj8c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopegrughrihgrnh
    drrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtph
    htthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhtvggrughmohhnsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:dRs0abtgJD0kF-i4VFyoRO5LdU8G9jl19Sgd_B_ft02w4_uqt7rB9w>
    <xmx:dRs0aVF1FwXEjLHrX3wUEPth6fRI_fy6rFsKOAD6eQA8dNS2nvJIug>
    <xmx:dRs0aWOM9JmiS4fWrP93VgPAJzndhE2bJjQcVK5s7NetfPqTPzY-Rg>
    <xmx:dRs0aULTT1iUGaBxwfpk5eBBi_3R3Mkq9ZwXN1c-HFLmyu3xbHvjsg>
    <xmx:dRs0aWkYf7TWUgW2IIRsRpMETOnj7n3Hcl9OHUfD0mdjp0G3jfmFmQ7J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 07:02:59 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 71420ea4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 6 Dec 2025 12:02:58 +0000 (UTC)
Date: Sat, 6 Dec 2025 13:02:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org,
	Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 7/7] meson/Makefile: allow setting submodule encoding
 at build time
Message-ID: <aTQbbFisaCG8N_Z_@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-8-adrian.ratiu@collabora.com>
 <aTLNxlKh02T_1PYB@pks.im>
 <87sedoemvr.fsf@collabora.com>
 <xmqqms3w7d9e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqms3w7d9e.fsf@gitster.g>

On Sat, Dec 06, 2025 at 07:52:13AM +0900, Junio C Hamano wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
> 
> > On Fri, 05 Dec 2025, Patrick Steinhardt <ps@pks.im> wrote:
> >> On Wed, Nov 19, 2025 at 11:10:30PM +0200, Adrian Ratiu wrote:
> >>> Some users find it difficult to distribute repo config changes for
> >>> enabling extensions.submoduleEncoding, or to enable it by passing
> >>> the config via cmdline, so we add a build-time option which can
> >>> enable the extension for convenience.
> >>
> >> Wouldn't it be more sensible to make this a runtime configuration key
> >> that users can configure in their gitconfig?
> >
> > The request I got from a combination of feedback from Junio, Aaron and
> > Josh is to avoid any kind of required user intervention or manual
> > migration, to find ways to automate the transition as much as possible.
> 
> How would that lead to build-time behaviour change, though?
> 
> Users in managed environments like $CORP can rely on /etc/gitconfig
> or equivalents managed by their corp-eng, so I am having a hard time
> imagining why we need anything more than an configuration variable
> looked at runtime.

I guess you could kind of have both: make it a runtime configuration
key, but have its default depend on a build configuration. You could for
example auto-enable it in case `WITH_BREAKING_CHANGES` is enabled. But I
myself am not sure whether the latter would really be all that important
in the first place.

Patrick
