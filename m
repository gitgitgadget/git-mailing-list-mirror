Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD76C3CD8C3
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776856544; cv=none; b=Lh59Y6WuGY9JXAjvotdPwB2ejX9BYSf1jxJd76sc3zRt7WjqoRlHK8m08ZP6dLoJbTzUD55neUFIlA03hna2uYjwyJ48BsDlGeyW6egilCdnzMxDGYM5WMNNfCBdQfjZ6sHyx4N6uw+1nzw3qhxR2VyLTZXYKxc3njDqkwf+04w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776856544; c=relaxed/simple;
	bh=Qt3Cr5nPbcFezyAWWRdwipSIbFAoYWYKPQBZdxCTixI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJBNCwkIMOKqPWwclSr69qXPY7On1bXNZQ7rBvM8R6eg4b6lWZBCq0ZJXaJeUEU384E0Q+NyhqYzGDMDO4UKTtq9z6QZQPjOxr6IM3X+M5rH34+ekw+U6veA/TFRuLZfK5byo95P3h+fi9cCMAY3w7pKQbz2sz/X40UZX7LLb84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UO0FvgGD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DDFUWO0y; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UO0FvgGD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DDFUWO0y"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id EBF131D0016D;
	Wed, 22 Apr 2026 07:15:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 22 Apr 2026 07:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776856540; x=1776942940; bh=zfbmuqBEFr
	j4wjyGh4s7Svr44wtY5u4RhwEGnHUskZU=; b=UO0FvgGDMz9reZSZLTdEsYn03e
	81hzh12cxXnx1PY33XpxCp5Zq9xie3Uko6jVghMubAMeBOmEkJCipxkZEFPfP2cn
	IKO4f868RKGwhZLJtCiNe4+T0JSpUpJEsTjkvtWifosauhsF9dzlYj8SmOK8kVX+
	7k1MQoVqYbWV20UPU6KBc6jRupVskXT3vqgkaxRjifXXyqkOBbrnlaA9ACu8ANvU
	oNV7DpnytE4tVwbMnD5vuTDtPdUfkIqMQp29gl2K55nNSQpQogt8Dei0rPmZDMU1
	ijvXTgbcg01dO3YXXYwHujfX26B6A5Q2Ysofp4yZoypc2l1v/TAIOPhY2e+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776856540; x=1776942940; bh=zfbmuqBEFrj4wjyGh4s7Svr44wtY5u4RhwE
	GnHUskZU=; b=DDFUWO0yFWGaWcd/Xauw4qFZHJaZWPbm9CbfAwW/tgtqSFtHK3D
	+OA9lYC7FzC3f2AG8h81VSMynyOsIRBUvdSlNRB8eYW3OohSUpY44/y3tOC4sNGW
	5PVx35JjMLDrKO7n20JY5F67jIfeKN7C1kCfkbfBp9xx+HzAQLbH1uLS6aiXeo7i
	1UEW40iqtsXWECkivGaE9jsoPzphqjE3RGLuuu1WN+bSfTkuc57qzt9NlAazlRF2
	CzN+jqiJ3GulY0myuMVXXCbY6aTZR39o7frFEkkkZ4RGHmJHR0ku4CKzvRewZEXx
	KD35T7Aq0ARRpDSMg6f+fhXBnlZCrNHNjeQ==
X-ME-Sender: <xms:3K3oaaD7CCubhCvOiotenBmgfitUFHleZtkpNJ5XLn6e8DodFKMLCw>
    <xme:3K3oaaiC-PSBOSyUHzSbd1NXj_vdqIlnHAFQYjUeHJKsacNF4wExJcH9k7YksFBE2
    hMPY32w_vnC6045ymLZzQWa0_zjgNF8vh1Ch4LpE4sW9aTXWKM3>
X-ME-Received: <xmr:3K3oabOHW-oek4UrdIm3eXXSBi0iL3xa8tr62xQd4XRt4CpVTu1hl8JKBb7ZiB2b1Hdd6zI4kZZcAxfTMh9BIOwLCYoonlXR1Civ4MBcdKY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3K3oaT7iwX9_GxBamkEJoNlf6LmoHBoWgiTaO59Hg9yYUmLniOpizw>
    <xmx:3K3oaR2Gv9VBSpjaFe-k2lYTejieLIm0xNOME_wy6Gf4zhkwW-9qKQ>
    <xmx:3K3oacYTXntCiJQF3NMeK07yr_jjPjWy4JPJotC8NV2csNWRs3id5A>
    <xmx:3K3oaRAC79bYsZK4g3a03HnSmOeHGEFw61EDAULw9nXqZooGW9k6GA>
    <xmx:3K3oaZywLqrZg6DbfL8dW1_xG2UrJWMXt5SEGUowG2DdUa2Z2ycsnYbC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 07:15:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 014275f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Apr 2026 11:15:39 +0000 (UTC)
Date: Wed, 22 Apr 2026 13:15:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/8] refs: return `ref_transaction_error` from
 `ref_transaction_update()`
Message-ID: <aeit12h5l34Wkon-@pks.im>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
 <20260420-refs-move-to-generic-layer-v1-3-513e354f376b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-refs-move-to-generic-layer-v1-3-513e354f376b@gmail.com>

On Mon, Apr 20, 2026 at 12:12:01PM +0200, Karthik Nayak wrote:
> The `ref_transaction_update()` function is used to add updates to a
> given reference transactions. In the following commit, we'll add more
> validation to this function. As such, it would be more beneficial if the

s/more beneficial/beneficial/

> function returns specific error types, so callers can differentiate
> between different errors.
> 
> To facilitate this, return `enum ref_transaction_error` from the
> function and covert the existing '-1' returns to
> 'REF_TRANSACTION_ERROR_GENERIC'. Since this retains the existing
> behavior, no changes are made to any of the callers but this sets the
> necessary infrastructure for introduction of other errors.

Yup, makes sense. This doesn't buy us anything yet, but will eventually.

Patrick
