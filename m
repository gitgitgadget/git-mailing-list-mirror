Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535276F06B
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820384; cv=none; b=P/Dasb85Ey8qMi1CpAEGscZMTfqJVP2DP1GiMNFrr0Q98BzuUWa2IyVwmwYnllUOJIo+a8fDU3qjhsBs8THSND8b9cIS8IB8bfn+6eFfEyS3OkcbDcisQ7cPpkZEhR+HielPPx7tXt7npyv0KGSo38snEebhwyWakb/BYwGU+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820384; c=relaxed/simple;
	bh=izQg3xgqe0Y2yeUdNEXvp3zgIhVIMu2twKUY8Dt3dng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i61NqL6t7hAP2XGqQehxLTSGm7buSenRwJkOVOyZg0M9m9xY12Y/hIUKgGoSxflS6ypsU8W+t9vN5wAJ5iRfsSj1PN4Z4p1ILUdQjtPqjKolNRfhoIhzcFiqtDsJIrmfOca4lMtyhvAO65nJdysCFjN+BIIhsKiyVre7GqLemtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YkuTSfcz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WESgC+VQ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YkuTSfcz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WESgC+VQ"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3631825401E5;
	Mon, 24 Mar 2025 08:46:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 24 Mar 2025 08:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742820381;
	 x=1742906781; bh=rNK3tQAcxOsmJsFU62/dcy3bFh3vwyFYgfo5qiWfR0M=; b=
	YkuTSfczVWR9w49SE7aRzuwymSzWNx7IhQL6aPwo+KYv9rrC6idsQlGj9qVSNk65
	VmtpmmDkf/oUm/VaN7mQcKmHLAChSz5/zpQlTV/IiFLOt6aq9fWnpJqXcGHPU6Wd
	rS91dpl+xU5QurMwfWdZd5UFGMmeB6+7k+GZAuEjexrC21gLHgOmlEsMJ1BewrO4
	GWX7Coy417Ybf8NkHekyKe3qf9ow/29ZfTf9j4gmnFnqQtxHb5tHQDn5NT5N0yKL
	PAMHWG/YbPgM7MiC7JRlKW/Bj522dlZedEPpbCt89sb7NgQss4bFOs6cGzQeOmlF
	JHZBl84mLI0k9k/wX9gNpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742820381; x=
	1742906781; bh=rNK3tQAcxOsmJsFU62/dcy3bFh3vwyFYgfo5qiWfR0M=; b=W
	ESgC+VQLlhkZmbj0FGWzR99aXteyzWo46rHJwF5q+xkG08oQGq7Ha+Kfs7VnQtvN
	Gq1zUVmT4aRwHEQN6w+RMkug9qqE3geCImLdZxg0L9kTSTSd4P0hXPwJDuX2zlJn
	KJL/+wS6mGGufQeopsS2rCTJ8uwJLhITfXUABQtxZ+V8qMhBFhj9UNA8rb7c7Xfq
	L+87LdSX5T5efrSOina/TUmRRsb6m55X6fnyQ1C/EOnVP1vL8MBovgKrvS50WXKz
	t11kLBum24kb2tLxbthklbsaVR2yK5lY52VnGRne1eKr46Ct245E7KjhiQGYhjf2
	TInGv1z7lvW2vWZcjCkEw==
X-ME-Sender: <xms:HFThZ4KfaJ6lp3ewK8iYSDnkp9bqfr0-_z97kB6NbRPo2BD4sKUdAA>
    <xme:HFThZ4LSqIFdFR60wMsANZkX6Ffd_k-jGYWRyPWcX30dGURP0p0aZ-dvhA4PLABtr
    fLdl6dOOwaWts5zIA>
X-ME-Received: <xmr:HFThZ4vFOqU0FzGhGZnn4_azEJQAh51RuxiNhv8e1ept2rq91HdpuTbXGA6qYZbIleOf0FA4E7d4FbeMAtvJ-cKV78qaDw7aV-EpQ1aEKEz14Wk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:HFThZ1ZqiBIp4-2PgCqTVhnHM4NyL16T6IqcqZ6opcnh_HiPq6v-zw>
    <xmx:HFThZ_ZOKksVAuI9RCekru0lpjkrgRO0haSTQWMAab-zGbybinIWvg>
    <xmx:HFThZxA_o6PIlOFnl9HIGGpZWAGMqzEKeWKUUSJ2QqBlK1AYKwMoGg>
    <xmx:HFThZ1bLh8yecNNVJIqAjPnju48EWBeYpFaNcvIUpL8W6meDkRZI3w>
    <xmx:HVThZ7F2Lm-PDIObGMBTmMwqmOF89sqFz-rc2mmQ8xMrv9pH-GO_kRGJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 08:46:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bf245c01 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Mar 2025 12:46:19 +0000 (UTC)
Date: Mon, 24 Mar 2025 13:46:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 06/20] t: introduce PERL_TEST_HELPERS prerequisite
Message-ID: <Z-FUGuLAiAq87pHx@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
 <20250320-b4-pks-t-perlless-v1-6-b1eefe27ac55@pks.im>
 <CAPig+cSPi0CV14o92FNFB0p2Z+nVTZ0mF67vd2ywsV6gGn7YSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSPi0CV14o92FNFB0p2Z+nVTZ0mF67vd2ywsV6gGn7YSQ@mail.gmail.com>

On Thu, Mar 20, 2025 at 02:55:34PM -0400, Eric Sunshine wrote:
> On Thu, Mar 20, 2025 at 5:36 AM Patrick Steinhardt <ps@pks.im> wrote:
> > [...]
> > Introduce a new PERL_TEST_HELPERS prerequisite that guards all tests
> > that require Perl. This prerequisite is explicitly different than the
> > preexisting PERL prerequisite:
> > [...]
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> > @@ -5,6 +5,12 @@ test_description=check-ignore
> > +if ! test_have_prereq PERL_TEST_HELPERS
> > +then
> > +       skip_all='skipping ignores tests; Perl not available'
> > +       test_done
> > +fi
> > diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
> > @@ -11,6 +11,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> > +if ! test_have_prereq PERL_TEST_HELPERS
> > +then
> > +       skip_all='skipping ignores tests; Perl not available'
> > +       test_done
> > +fi
> 
> This message seems to have been copy/pasted. Should it be instead
> "skipping apply-binary tests; Perl not available"?

Yup, good catch!

Patrick
