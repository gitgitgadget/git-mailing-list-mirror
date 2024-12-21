Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BCA191F88
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734777798; cv=none; b=cahmHQaC/DTH9UZMPR9cWd28CeKlPChIzaUCMbRWrB1Vgo1GTwtS29OdHXqWFyq9JL9OhLIGg8jDXmMDxVA2OzwJxNzGlAugq6GuK3jrIlHTaw2NccLDt8b+RT6AGeX0NOfpHy+/I+5Rs9WkrGKpFAmELZmWu3+emJpwxHyfxNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734777798; c=relaxed/simple;
	bh=x0OwdtHzBIW19AELb/BeapRGrhTLjqcmRY/dq6kjU0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mrg37XdBXg4SSxvJcfqvQCyBHXu2J9Fq+PnOimoXJ/6OvS4Dtk84WS3J9mpBYUH9Udp/fHsZlOIIZwwTmD0P46MyLlJ2C17WuWUvO9AvFv6JmcjvFjNNtRSPO4wHWe8x26OFmNma2hQgJrG7vSfr4UbHV3Tt4C4sqIZi35a43PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aqAoxVld; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=odWZX68W; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aqAoxVld";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="odWZX68W"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8A32B1140120;
	Sat, 21 Dec 2024 05:43:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 21 Dec 2024 05:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734777794;
	 x=1734864194; bh=+wOAd/li5rweePFcPkXYZ8nFN6tVC5NCuRICWb9ZXUY=; b=
	aqAoxVldyVGqX9ihP7azLqUCOYeWhu9d/nfUDKBzn6DkYYCuHiMbGN76+RS84vxQ
	vJipH9xyIWAl+eEH9FoUEsIIsL5DvXBLf01M62JdhioIPizJKXs/z1gO/3yCH69D
	261MaWsrFPDvRgHfxX/tMqZKFVjJKV7jzXgDWFbOav4t+c4hBHe6nr9GfXWSQEX9
	VHvA1GM2Xyf5XftMXqFgSOK5qsxAsAFfsH/2dssj5jkcPGZ0mvZ9h+ugOm89WK1X
	1usCgKKKSifpBgfdqCnmMcSMUMIItFjBWqyCxzdyZ5PKLmEnCdrCB3tAf99EPrfQ
	DbYaSsJ6mN8Yqk2ph2bzgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734777794; x=
	1734864194; bh=+wOAd/li5rweePFcPkXYZ8nFN6tVC5NCuRICWb9ZXUY=; b=o
	dWZX68Wmb6r8VD6+LPJ9G4lh3RjmX5kARXzFjC9DvWQaSagMvp5b1nPrAqZ7XGc8
	+yOXkv8Zj5Z6P++ZFEUiMJMXW+yXLbBs+U8FX2kKYtQzNfqpegQ+ZyBIEH56/YqR
	b0w81Xf8TrMvd69MCEvZP4A4Ra5CMTMG0ORvR/UMOOEXkTuajk2Exva3iJBdkDRO
	/6G122TqtrU/9957y8Qd9qABeq3CUD/Qxebj/ER0xjVEQPD7Kwvx4G52PLwJFkIu
	7NSgILjuRX1ceRh2OXZTMxN+gP4nHkkTLfCV/sz0pIpoNbWtt0Ijw21UE4gKWWfy
	MFRKWcsQN/oXUN0nc8t4w==
X-ME-Sender: <xms:wptmZ0tDXZTEyUxu3v6ou6wQSqRzaYt8IlhhHFlNeSnrnab0BM-xHg>
    <xme:wptmZxclRVFbZ_yRuXCpg-YlXZQRgAQux-Tbl8X0FUMkVDt0mENmmaXqd5hXOQN6n
    rZvmNzlD713bIR-iA>
X-ME-Received: <xmr:wptmZ_zMV9TIF0eTAOGM_oGam6PvHtiEWhtTzUS8Gk1hg48nzMa-rxkfGo-f-Hytg0ErgOyiUEaj86edYRGrQcANZHBZkXEZdKEPLAev1GZUcUIkBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtgedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeegiedvgeeujedtiedvuddvffegtdelkedvleevteeh
    heejgeejheeljeffjedtueenucffohhmrghinheprhgsrdhinhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggp
    rhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdgrghhrvghnsehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:wptmZ3MbwBDtj--7fCyWSKSNcS6yWV5jDHscJ1vRQ5YyH_ilMuoicA>
    <xmx:wptmZ0_GvP7h1Yo4q7h3Sila51TlA5Bsv7XYbPe-pIkNXiJON3DG3Q>
    <xmx:wptmZ_UFRuQmSkupZOT70Z_x7JCiR_1nUAWOQdpj4TNCMlliHd8MPg>
    <xmx:wptmZ9c4pIG9dpqiX70r535KRs2FaFTVkMaHwtVtme6m8Mgpyt_tGQ>
    <xmx:wptmZ2Kutoz1Lwq2EUHxwQQisYexoJHHJypk6jBs6lU41EVgW53ljiQ5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 05:43:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 50ea945d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 21 Dec 2024 10:41:16 +0000 (UTC)
Date: Sat, 21 Dec 2024 11:42:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] asciidoctor-extensions.rb.in: delete existing
 <refmiscinfo/>
Message-ID: <Z2abqCTOHjIlRcxx@pks.im>
References: <cover.1734734612.git.martin.agren@gmail.com>
 <8bdc26c1ae74b59f2c3cd3408111336ce3af1447.1734734612.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bdc26c1ae74b59f2c3cd3408111336ce3af1447.1734734612.git.martin.agren@gmail.com>

On Sat, Dec 21, 2024 at 12:18:16AM +0100, Martin Ågren wrote:
> After the recent a38edab7c8 (Makefile: generate doc versions via
> GIT-VERSION-GEN, 2024-12-06), building with Asciidoctor results in
> manpages where the headers no longer contain "Git Manual" and the
> footers no longer identify the built Git version.
> 
> Before a38edab7c8, we used to just provide a few attributes to
> Asciidoctor (and asciidoc). Commit 7a30134358 (asciidoctor-extensions:
> provide `<refmiscinfo/>`, 2019-09-16) noted that older versions of
> Asciidoctor didn't propagate those attributes into the built XML files,
> so we started injecting them ourselves from this script. With newer
> versions of Asciidoctor, we'd end up with some harmless duplication
> among the tags in the final XML.

Okay. So if I understand correctly, we used to have the exact same
values for those tags twice with newer versions of Asciidoctor, but
starting with the change we have one "empty" set of tags and one set of
tags that contain the replaced values. And because Asciidoctor ignores
the latter the end result is that we have empty ref info.

> Post-a38edab7c8, we don't provide these attributes and Asciidoctor
> inserts empty-ish values. After our additions from 7a30134358, we get
> 
>   <refmiscinfo class="source">&#160;</refmiscinfo>
>   <refmiscinfo class="manual">&#160;</refmiscinfo>
>   <refmiscinfo class="source">2.47.1.[...]</refmiscinfo>
>   <refmiscinfo class="manual">Git Manual</refmiscinfo>
> 
> When these are handled, it appears to be first come first served,
> meaning that our additions have no effect and we regress as described in
> the first paragraph.
> 
> Remove existing "source" or "manual" <refmiscinfo/> tags before adding
> ours. I considered removing all <refmiscinfo/> to get a nice clean
> slate, instead of just those two that we want to replace to be a bit
> more precise. I opted for the latter. Maybe one day, Asciidoctor learns
> to insert something useful there which `xmlto` can pick up and make good
> use of -- let's not interfere.

Okay, makes sense.

> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  Documentation/asciidoctor-extensions.rb.in | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/asciidoctor-extensions.rb.in b/Documentation/asciidoctor-extensions.rb.in
> index c4c200dace..d8d06f9a57 100644
> --- a/Documentation/asciidoctor-extensions.rb.in
> +++ b/Documentation/asciidoctor-extensions.rb.in
> @@ -29,6 +29,8 @@ module Git
>      class DocumentPostProcessor < Asciidoctor::Extensions::Postprocessor
>        def process document, output
>          if document.basebackend? 'docbook'
> +          output = output.sub(/<refmiscinfo class="source">.*?<\/refmiscinfo>/, "")
> +          output = output.sub(/<refmiscinfo class="manual">.*?<\/refmiscinfo>/, "")
>            new_tags = "" \
>              "<refmiscinfo class=\"source\">@GIT_VERSION@</refmiscinfo>\n" \
>              "<refmiscinfo class=\"manual\">Git Manual</refmiscinfo>\n"

And this looks as expected.

Patrick
