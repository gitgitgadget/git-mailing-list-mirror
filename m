Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1FD3DB319
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781784847; cv=none; b=VZ8YQ4S1j4EfiTmkmAm76nXuExQHncglVGNhFx3x4aZEFz32dd+z5/sRcNvIvBXHc4piCDvy9/idKKwOe5pj7T8ZDdUAGF4sPV7y2jyDotPn30PaK3OaFVPPOwqK+Gem64/aYK4DlwZGu40MuSamBAjy2EAAGEqY+amnbCl6GKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781784847; c=relaxed/simple;
	bh=1Vn5Tysj+ImOEfc3jpRjHqtB4FGa6EPYAKNeUX1/Bsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pw/1YVsqtmAaKwLN9Dw7l6KXSp41sMqOrsWLCnCCbkCXPGZ8WqtG1Qe7RJFafQRomHT9ItdbwLkYrskeBe/7oU+z8bqt0GukV10ezdH5w+vZw7a1Vx5zuuO2cCUNZu+wOc1YurVQ3Unr24hXyg2uDDZjvjaadSu1BMPq7b1W1iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IxhrEbH/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NbZe3wou; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IxhrEbH/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NbZe3wou"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E46E97A0034;
	Thu, 18 Jun 2026 08:14:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 18 Jun 2026 08:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781784844; x=1781871244; bh=24fmHy67TZ
	l4lErEPBObbQqAk5KnW0VeAb+JN82BQrg=; b=IxhrEbH/dr37OtQmHhXwmA+4+o
	bj/dvkpI7sxElO6qZ453Uni3RmX8V55WFWk66HJyqYyXmHAKbDzVzSf/t3Hc1OeS
	XP+vyINqWJzRT0y2CUrDfQVKUe+WibfujMJinSo9XKy9GQcUozOVn/J1JpZiBnpQ
	zVuyzeY1lrYGGOmxKflz4EV3BRU2kuG3QBp9fWaF39Co5xxdfT4PNt0V442vQwT0
	dBUQGu2HMFkKUjZZ8trSlZgIrbBULDL64qIpdaI4XKSRYjQLTnoVMdIV6y6QF52l
	T0/pfrCMgAh9+pYB4fK7/WFV2QY6rURblXGuECaPxYrJ65+dLgnOhYG38Baw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781784844; x=1781871244; bh=24fmHy67TZl4lErEPBObbQqAk5KnW0VeAb+
	JN82BQrg=; b=NbZe3wou+E/GWmJO1+NDcBWwxi858cs8gx0yBj7Va3ZXIGSK835
	vCjXk4yvNhnS4qzG6Ce1KVEnXQvyLli3XRYLxFmBr8HJ5ZLUU1RWYd8cPOXQgrtr
	fMAr0PHC4jS7jjuYnwLLn3nPqetL31OsIDeEN5C/hBjfue//kvLxdbhXid0p9uVc
	GjbHbeznOzjEZmsCc+1E0jgaEfnRL5AOLmSuEQr2mThRp21MIY8sLZJS2YCoJ7aC
	qJxSBxXECqiVet5deGhqEmsCXbbwoJTolKwHk8hqdT0VztHvgV6UUG+GTceHf+Zu
	ynqFN0pqMQm4GCxIaZ7ltPxwwNmX5bGdzkg==
X-ME-Sender: <xms:DOEzaiBR8MnYrMyEQhfxoAI6BrZWjci-P45LYLdLqeEmGK4JO9YumA>
    <xme:DOEzajgL5NB0jqmNhlOzvJ9O39pX6rTBJvWKu-1wbKpqXz3ZTfRB12rvfQffUmijl
    -6A0uGI3hhilRQeUMBL4JdFOz2u7odg8wbbrjErqSfWtC7gUUeyeQ>
X-ME-Received: <xmr:DOEzaqkktyiB8fs0BdopgRBXwvzf-FYXFaA6UXALYch7LxXbD5Tro_L0REE4WFP-frI8SAezxbzHrizEQ7PAqhPMJFW9TWt72RgqJ2FNzQ>
X-ME-Proxy-Cause: dmFkZTGOz3BKUnSAhAvsagihXM+HdSQ3eqVfojZWxQ8QD6nmjhtER7sZBZgOSMQW43zABn
    k6cfbhnat62Gg8RYmyYw7LE4WZ6YSaFI9i/rPnQK2TLG88Hi3MCVnG5itmhrMasZMf32oW
    tT7n38RHCVrg2pWmzTeMuivGSOf5lbaDeMnYSOhZtmXOuaEZAOpdWJJmt12dXb2BTj3xQD
    /JTm1kzf6nmdKesONSqtWQj7v3OeWOoCz+uihMUv7ruq/py7+xTvfsGgbLSumvcWK4wJZc
    gFe6jBeiIJwcfiQ4rY//DEQ9GpwbCWzdSJeeA53W688v/zNkwe/y4UyyCyOjQO1UrGelTb
    WGcvef6Ycj+V5jGiBKWZkJ7s+7+Y7KEt3VChZRRK0y0hiC6M+L5TLn3Q8k3v0UhLDwDjFE
    2oYe/BCqNPnzIjhZ2wjscrwKoP/aAMy3mquIlzWQXjZ78MR09u1YGIpSi160DKJs/bHZXP
    Pcaq92/cqe0WDX6fAeBOkNgAXyIyNPS+td/K6nreNX3JRNbR/wxEd5mY3gAPXBI4nOsorb
    Fwb19YV0ZwQdYjAMfsj1wjuKlKreRuv9cDCej6qgMqRAQp7mlBIVwhTbWUSZKDZedWDo14
    AEgYzXQqRgc0qb5GmmJ5lucXcoFAgFW36JnldNlGeDOUHhiJWFRXGtZRly5g
X-ME-Proxy: <xmx:DOEzavp_1hOsj-tr1Lr7j5W0YooYLx0vzYdxzwZxEql-w1siYhCfzg>
    <xmx:DOEzajFPCJ0_XRTDMF5m9JOvM4zxKq0zJMIhX7N78XIAQt8nxaanwA>
    <xmx:DOEzarwLciEQezDkbZzuVu6gjFFX_VzEpLFp1xuH1aehRbXJ1scAUg>
    <xmx:DOEzaor6VBUm0SG_vs2McKkAtVorkQmBPX57A8_aPkFjNH_Vznngrw>
    <xmx:DOEzaoX3DT0UlRwVB51zRO7d8-gh5lUO_9-pYXr7MeIjxC_Z9a4huD6c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 08:14:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 49e595c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jun 2026 12:14:00 +0000 (UTC)
Date: Thu, 18 Jun 2026 14:13:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/7] More work supporting objects larger than 4GB on
 Windows
Message-ID: <ajPhBn7n1wR-sii4@pks.im>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
 <pull.2137.v2.git.1781524349.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2137.v2.git.1781524349.gitgitgadget@gmail.com>

On Mon, Jun 15, 2026 at 11:52:22AM +0000, Johannes Schindelin via GitGitGadget wrote:
> This patch series tries to address the problems pointed out by the expensive
> tests that now run in CI: t5608 and t7508 verify various aspects about
> objects larger than 4GB, which Git does not currently handle correctly when
> run on a platform where size_t is 64-bit and unsigned long is 32-bit.
> 
> Changes vs v1:
> 
>  * Rebased onto master, which merged ps/odb-source-loose (with which these
>    patches previously conflicted rather badly).
>  * Removed superfluous size_t s variables (thanks, Patrick!).

I skimmed those parts that I was previously commenting on and am
happy with those changes. Thanks!

Patrick
