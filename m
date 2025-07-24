Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447FBA36
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 06:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339655; cv=none; b=VlrT+rfIy2j/4aEDvJluwf8HzsW66+g+cybAEai8yAzKaQN2ck/V0+1jRLhhfM8GxpJBr194TH1bUwat3e9VB165fYJjmFVaoDypY8nTP2qdO7K0K7Tf+A4Kq6nGW/Ei+1JKTDHG57fWiNe6SAauZ0/PYP59nPIwNpkAl8C2edQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339655; c=relaxed/simple;
	bh=VaqeT7LuO9bmsRPpjU+mKDjklZbATcoBI7O0RCZRPqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPgK7okZvX3/iPUFOcrFxSol+ZEHwucXgjBDwKGnTJOMTux23TyV5ZcsVBgh8NskQ2Bj9vXvzGacBzpbrjszermJDpSZEQMi9e2ZbEq73vJRmj8OJasdlVHF+UgZPJNw1RyIQSfeu/ZwaLK9WPzXLG92pKjqKTIxyp5GnyGQ4ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jW5pa88i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ktUzZh85; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jW5pa88i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ktUzZh85"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AAC2B7A03AA;
	Thu, 24 Jul 2025 02:47:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 24 Jul 2025 02:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753339652; x=1753426052; bh=WKX/ePpZhL
	whPy4mH+Po8lYXlAGHLP/z5lF9kFf8xrI=; b=jW5pa88iQAC1xF/WpeuJSzSwwn
	syIwHWWK5pHdm3mIiDiMC5RUIn+LL0B4BuoiifSw2PJ9yOnjeCedpOllwabKLJWG
	JJMKNtTfSwBoh+W1sl3AH2v9ESGDXaireHdL6I7+CQCaCiZEq53RIeEiD3tId2zT
	Bv/Xr25flA8m4deAHJwQ8eyQI333fiOJg+lZDmMNnN9AYO7pzRtRT6pAUouc3xGq
	EbBuzQPPMkDgfKupDpkj3LsoTq7GKWudPa1z0y3peIxcXJAh12okhg69BgziY4VU
	Tn3DEmSJHQaivcKp4SiC9mhlrJp2srtVu5r73HJrG2lRuj7qRibSnYWkR5bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753339652; x=1753426052; bh=WKX/ePpZhLwhPy4mH+Po8lYXlAGHLP/z5lF
	9kFf8xrI=; b=ktUzZh85BEW0BXG1moJlHc8J9pd7f0botqluLYvWqfowJtLboTl
	jQ3r05l0Fzf/8esprM4izYYPDq+D5D6A2D2plzTrTtqa2JER4a3ODA6t8xXfpE62
	cv55EfHfX/Bn0oC9KBgZFvUOUWW7F558M5gQcwTMvE4pohUfFBUYPT1gp9D5f54w
	l4VIJ3+gU87cZW+kKkp9sWxtAjeMDREEqyzrgdbSHc0fDlBV9WFqiB4098GR0cil
	oaEjIW84VHu4sYRjMf5ROwaNSjTig0wECRKFeL/EOuZRKr0vBnBLepKiHNCXKI27
	eY4b9NAXSiMwdSc1EyN5b0Agq+Vx83Vf6eA==
X-ME-Sender: <xms:BNeBaHIFAkNKD_trbofN4vTF9Io5y4W89pf1WaQ7l7FmSwj-6xYLnQ>
    <xme:BNeBaLQ-akSOMwFboxuwrClN4nJStrlVv2L1Cx_F5etXSuysj37C5LaHaPHbyLyig
    2DO1aSua1833y2kIg>
X-ME-Received: <xmr:BNeBaHp0VekWwYWMyCWcbU0m1muszeeq5znMOY-qJg2uZWVmy4A-MHot0TlBzfrPmtd6_cw7wpLRuDqT8LIjmw4cvxZ0ZML9_Apq-xhA4Sk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejleeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkuhhfohhrihhjihelkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohgusegu
    uhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:BNeBaIr0rq8KHWrh4cQqxbyrpbpYEXzl6BQTMBx_GipleENR5VlKWg>
    <xmx:BNeBaJMoVIZp81Ny5B3HzlNrCgSRCuLYpPjd_KgrJOdaamzSHJW1Lg>
    <xmx:BNeBaJxm7Yg5WeGmfMcqCQZlDxi6Mda5MWLq-9FPQsPPvy7VWyL4vw>
    <xmx:BNeBaCsOViRWXW7QCiU-9GQkmYVRKOX8MUScp9rzoeIv70AHZHc4uw>
    <xmx:BNeBaDMgVPoq3NZqEidaNBKBVyafSrsgCxhB9DV5Llt1oQ_xqQUQZtRf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 02:47:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 750a2309 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Jul 2025 06:47:31 +0000 (UTC)
Date: Thu, 24 Jul 2025 08:47:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 09/10] t/unit-tests: convert reftable stack test to
 use clar
Message-ID: <aIHXAA7DmZ2JDKN1@pks.im>
References: <20250605140644.239199-1-kuforiji98@gmail.com>
 <20250605140644.239199-10-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605140644.239199-10-kuforiji98@gmail.com>

On Thu, Jun 05, 2025 at 03:06:43PM +0100, Seyi Kuforiji wrote:
> diff --git a/t/meson.build b/t/meson.build
> index 297937f307..fcbb659263 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -13,6 +13,8 @@ clar_test_suites = [
>    'unit-tests/u-reftable-merged.c',
>    'unit-tests/u-reftable-pq.c',
>    'unit-tests/u-reftable-readwrite.c',
> +  'unit-tests/u-reftable-record.c',

This change belongs into the previous commit.

> +  'unit-tests/u-reftable-stack.c',
>    'unit-tests/u-reftable-table.c',
>    'unit-tests/u-reftable-tree.c',
>    'unit-tests/u-strbuf.c',

Patrick
