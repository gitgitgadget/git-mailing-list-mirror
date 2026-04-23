Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399D1222565
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776927325; cv=none; b=A10Hiwg8Abc20Y77PNSxHD8LqgN9sZqN3uMxNAT2DyLfpu45Ekb641vvJwqVbKFZ5lI1D45YKdR7LJ4+C2mKkspXIZ5qDnSxk1ScVrxJih7gxqE07HisQzPK1Cnsd0crxl0AFOR/AT8hAI18WWjz+2Mui8fPMOy4XrWpk7EPn+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776927325; c=relaxed/simple;
	bh=YeC71m4SWgl9kL6hOqNPfiz2qsnlauALyUjvrv6jY0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTUsmDTo6nVcmaHYmQlBabxBe87lWlfl3wz0S6dYH/InF/Lrv0BmIAiWRqc3UupV4ar3TJcWC/eQMtGauo3avdKVFdYXli9NZMiizikTRX/uOf920GRnF5VQJ1nGGMvXQTuJ7RcBcIw5lY2PAaAWr9Wen/e1YP/Yqn0pq98KsWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NnHX21r5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aaZv+kl6; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NnHX21r5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aaZv+kl6"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 859A8140009E;
	Thu, 23 Apr 2026 02:55:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 23 Apr 2026 02:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776927323; x=1777013723; bh=foAuA6rQNd
	05q4o+O6k1RzQQz+0Hm/0QmMTep+vlPNA=; b=NnHX21r5tPhRqfZ6LkP4bsoart
	QOfh3UKmF7Ai00iptHT5JsQRfgPblOEcV6sxU2GWihr6sqsRG/IYZgPCimUHgntz
	5323//aCfqeiitMu9gOQzhy3n8gPFDn+mo0yq4ANeHecNVpvKinAU4YohJAn5mGE
	TYqpJorbqPY9r5Sb6VV0xHyQ20vIsNmiYYuuoumM7yMgyP8jUxCzmthUSHRNoLrF
	8+SzqOTz59iLAdTIMu//hHUVlg3dOmi8l9B0PTiZBY7JfrzMnrqQjLeS36ONkD0Z
	qS3uQxkURVCTIBvn0fWbQ81UC/SvyaciB+uqWwAz78neb0447J3eKVAlsa9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776927323; x=1777013723; bh=foAuA6rQNd05q4o+O6k1RzQQz+0Hm/0QmMT
	ep+vlPNA=; b=aaZv+kl6gLhx1RtiuEjahCLzC3dg9gLUTJY9qzSp780al7rJ0zJ
	SCCF6I2w7wazBxkk9oxWlMSgnIFyaNXL+AhcvMiC4pKYIWw+6fHn/6Z8sDP2/Wj/
	7Nejf41ejQ/Iuhqa0G4fq0MNx2g1CMEt/Dl1xHEPRfQW+v21pqp276oX+n2MnHph
	gJzwB2b79g0hsdTthvxmkVh25bxdlrM9QVbztLWltvNI/gGnMXCeORN//Xp7BafB
	Ze7V+0OsdxNURmKeVGEe8h5Ws5Nz8HvIJKfcU9uIHpiN1cymcWtiXVwyy0xGM4WU
	00b5X6ujK8Ih+L4DjKXh9H8ZSN5SaStORdA==
X-ME-Sender: <xms:W8LpaZf6ToCrWcPkQi6j1Iy1ZXmSEtILxgWhW90evMnDwnFsqAZ7Kw>
    <xme:W8LpaepTyj2QMdjiY4ZDoerC2xGDrX2zcrQIjcdIR5u7asl9RucQOJLicHl3eV2uw
    YiC0q4iBKUd81YfAPwVoxc_cfYHWKQ4tzGFiwq-Vtkvj5AwVdZzjw>
X-ME-Received: <xmr:W8Lpaf7-v5I3wflEikpnRmgw8pHm9-kNrQlVVBCCQNQi-CEdE-jrJMziwce9W0ytKw2TFcXI7wuBUz0_Xw-uzTIXTBj1cdCl_dCmI7zt6iZp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiieegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegtrghtsehmrghlohhnrd
    guvghvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:W8LpacpJyjkYr2D3D6dJtJ51SmtiH9SZCI2nQgdI_6k-6lQFPzKqxQ>
    <xmx:W8LpaZhiBvYimnx7ObWyOKc3WF4pZ3BFQ0S_0Nmi3E4YrHmCABK4Ug>
    <xmx:W8LpaeIL_jvtMGzX0bcg3eqIrdH3e1TC9K-E-TSEVhpVSSUxtUN3_A>
    <xmx:W8LpaRAlAyi44R9cLsmgHckcL6WT9Eihs7ht4MIWB4lHP-5t4v0iDQ>
    <xmx:W8LpaX0v6jkGTD0-EhWZjqBn0wQDKJQG1tLNd_U6Rf7Rr1KnJ1n757L9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 02:55:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8805726a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 23 Apr 2026 06:55:21 +0000 (UTC)
Date: Thu, 23 Apr 2026 08:55:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/2] builtin/history: introduce "fixup" subcommand
Message-ID: <aenCV2w4qzGj5t-8@pks.im>
References: <20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im>
 <d2b19306-71e9-4e17-a0c0-83309a00bd45@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2b19306-71e9-4e17-a0c0-83309a00bd45@malon.dev>

On Thu, Apr 23, 2026 at 02:18:16AM +0800, Tian Yuchen wrote:
> Hi Patrick,
> 
> On 4/22/26 18:28, Patrick Steinhardt wrote:
> 
> > Hi,
> > 
> > this short patch series introduces a new "fixup" subcommand. This
> > command is the first one that I felt is missing in my day to day work,
> > as I end up doing fixup commits quite often.
> > 
> > The flow is rather simple: the user stages some changes, and then they
> > execute `git history fixup <commit>` to amend those changes to the given
> > commit. As with the other subcommands, dependent branches will then be
> > rebased automatically.
> > 
> > This is the first command that may result in merge conflicts. For now we
> > simply abort in such cases, but there are plans to introduce first-class
> > conflicts into Git. So once we have them, we'll also be able to handle
> > such cases more gracefully. I still think that the command is useful
> > even without that conflict handling.
> 
> Thank you for developing this feature. Godsend for lazy people like me ;)
> 
> Nevertheless, I seem to have come across what appears to be a bug. I carried
> out the following steps:
> 
> 	create a.txt -> git add -> git commit -m "base" ->
> 
> 	create b.txt -> git add -> git commit -m "feature" ->
> 
> 	create c.txt -> git add -> git commit -m "tip" ->
> 
> 	rm b.txt -> git add ->
> 
> 	git history fixup HEAD~ ->
> 
> 	git log --oneline --stat...
> 
> And the output looks like:
> 
> 	3096a65 (HEAD -> master) tip
> 	 c.txt | 1 +
> 	 1 file changed, 1 insertion(+)
> 	699f610 feature
> 	0be07e6 base
> 	 a.txt | 1 +
>  	1 file changed, 1 insertion(+)
> 
> More specifically, the output of
> 
> 	git show HEAD~
> 
> is:
> 
> 	Author: Tian Yuchen <cat@malon.dev>
> 	Date:   Thu Apr 23 01:57:17 2026 +0800
> 
>  	   feature
> 
> which is an empty commit. Is it what we expect to see? Sorry that I don't
> have enough time to look at the code in detail :P

I guess the answer is "maybe". I think it would most sense if we had the
equivalent of `--empty=(drop|keep|stop)` that we also have in
git-rebase(1).

Thanks!

Patrick
