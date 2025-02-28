Received: from evolvis.org (evolvis.org [217.144.135.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A800C23DE
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 06:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.135.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740724456; cv=none; b=lbRgMHL7LqAbdlvdj3AAvVVD9O9CNz20BtEmTVUZbZB8sQ0YXq0fICUKxEM8NzQTzUGUbSnmvu7MUbb9I6dT4VIiBg3enYaFa5oqqviLRct6CUWNMbgVy8V7bZAiGGBknbM82uAzzU9TreUqDN98LSm8/INKBlNjt3Iuvt3UbcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740724456; c=relaxed/simple;
	bh=GRu8QvTrAPdCKFnS6eaIZE9Menfkx59aRrZU6Hi9fvM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CGOxUAnSY4iDuU11r+WPr7RBwZed8bl9GWmOxytV0Gup2NNZZ2F1iE2dVYzPySDR5UUSNC/2NUJkeb6xt55GdoAXTlxbjFYv2CbH3tNep39Vb4RTLEH+gb7aOfMAngeUJG/omsLK9wCifyPRQoM8+qJrs3p6nO7cuYJYISGFTvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=217.144.135.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from x61p.mirbsd.org (2001-4dd7-25b2-0-21d-e0ff-fe77-c17b.ipv6dyn.netcologne.de [IPv6:2001:4dd7:25b2:0:21d:e0ff:fe77:c17b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X448 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	(Authenticated sender: x61p@relay.evolvis.org)
	by evolvis.org (Postfix) with ESMTPSA id DC165100119;
	Fri, 28 Feb 2025 06:34:12 +0000 (UTC)
Received: by x61p.mirbsd.org (Postfix, from userid 1000)
	id 9F71E147132; Fri, 28 Feb 2025 07:34:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by x61p.mirbsd.org (Postfix) with ESMTP id 9A7DA147131;
	Fri, 28 Feb 2025 07:34:12 +0100 (CET)
Date: Fri, 28 Feb 2025 07:34:12 +0100 (CET)
From: Thorsten Glaser <tg@debian.org>
To: Simon Richter <Simon.Richter@hogyros.de>
cc: git@vger.kernel.org
Subject: Re: gitweb.js build mistake
In-Reply-To: <fc549e53-c3b1-4aaa-b027-19d8dae2f3a6@hogyros.de>
Message-ID: <175d9d3d-6e75-3348-6037-f1c774fc0d0c@debian.org>
References: <070641d0-730c-7d92-af4a-9157dc1edd3d@debian.org> <fc549e53-c3b1-4aaa-b027-19d8dae2f3a6@hogyros.de>
Content-Language: de-Zsym-DE-1901-u-em-text-rg-denw-tz-utc, en-Zsym-GB-u-cu-eur-em-text-fw-mon-hc-h23-ms-metric-mu-celsius-rg-denw-tz-utc-va-posix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 28 Feb 2025, Simon Richter wrote:

> Would an order-only dependency also work?
>
>    $(MAK_DIR_GITWEB)static/gitweb.js: | $(MAK_DIR_GITWEB)generate-gitweb-=
js.sh

Erk, that=E2=80=99s a gmake-ism. I have no idea, possibly. As a BSD make
person I consider use of $^ in n=C5=8Dn-suffix rules generally often
problematic=E2=80=A6

Perhaps test if it indeed works; if it does, choose by whatever
is the project-desired style.

Thanks,
//mirabilos
--=20
11:56=E2=8E=9C=C2=ABliwakura:#!/bin/mksh=C2=BB also, i wanted to add mksh t=
o my own distro =E2=94=82
i was disappointed that there is no makefile =E2=94=82 but somehow the Buil=
d.sh is
the least painful built system i've ever seen =E2=94=82 honours CC, {CPP,C,=
LD}FLAGS
properly =E2=94=82 looks cleary like done by someone who knows what they ar=
e doing
