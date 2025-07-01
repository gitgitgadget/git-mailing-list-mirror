Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BC725B2FA
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356907; cv=none; b=hahP9UYwAtslmrp+hNeAA/HA2yLLKFNQe1z15Tf5eTGYR/mknyxKFYwrB3x93jjGi+reT8jtNKNOFh43ZrjcZVuU3XLDPFj6ygzXmrPoipznDDuysmBvn92R7DkeOIIk+NW7rvKwuxxBoA6lpa+FSoiyAzkAKXWPZd0bRlqumjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356907; c=relaxed/simple;
	bh=l8H50iJgCnCfohxea+aYrYEhA1d0it4zmW8JexJy6RE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FSrHI8fpNKUXC1T7TeAlfCJ49V2twmWtUocq3zTezER6ZKrr+YbaxVZPOai1Vq4ciLLKyOvGng5OO3J1ON/A0r469AEnJR/VpGPt0bwF3JoIxF1mMNEa/2sC2b2GYBBmhh342hN5PUu/wSC3t6ZrYYHoYKytnBzGlCFrUHRd4Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=szaB6L79; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LPBjmPDH; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="szaB6L79";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LPBjmPDH"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 22DA51D00045;
	Tue,  1 Jul 2025 04:01:43 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 01 Jul 2025 04:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1751356902; x=1751443302; bh=96O+ujJRNX0a7G64tux0uDAUXrgkLkrD
	LbiO+O4UpNY=; b=szaB6L79Gh7gy4PBAQfKhMs5MMVfKZNtmnfl1+i+yxMqqOoZ
	ZDXmim5kAWc+t/wv9Px6k3VI93oT2SXex0OippKsfJNyFJ3JcE/mpKxNBIZSnrOk
	eSBz2yeZSh7SJWb9gEFuo1QOkBW9qvs472T8BV67PHzMZ4Sik5JP5oGhVNkwUNgq
	Ptp2awrCRC7a/7hG9Ff3P9olWBGPi8WgjEvQTlZS2U9lBDptZouj6EiQ0TuTv0Rj
	iENEZW9sA0AWcp+uCZ0yJTlDvu54WCCuqpq7f8ZunQFjUFEkJid7hXS+Zm+syT9L
	dadSCDoWbzmrflVNTN44JVaSrpNkdnP2dTZXfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751356902; x=
	1751443302; bh=96O+ujJRNX0a7G64tux0uDAUXrgkLkrDLbiO+O4UpNY=; b=L
	PBjmPDHPHvw+ifVb/CGj01i7L4zTG9czpYIXOxmokqPqRcHsbV1N4JR3q9VXMpjh
	F6DiLGnlZdjk89z+2m7rAFzlvL5vzNypGt6ZPpXs5EcdM2F8yqtP8f6AIU5pKvhH
	4wZw4NlA5sDShsHY+RnuvPxfMP5HiG1XcIcEl9VdC2PTRM5fFoXp/2oy56GfBQwX
	uos3jDCPPS8EiKP4C6aupKg0lbJR/CTUnsl6S3yefKbJFrGvcqc9rKGdjY2qwBHT
	STYcH3TC8sZItVWNFm42qwK6dPnDcYT/atigUps7p1IccPg2Dj19ljFDTPOuYUy0
	7HDmsPNUyB86sUMdzU12w==
X-ME-Sender: <xms:5pVjaGxor6GHIk51cX4E8c37vAgEGCL5nkNhi8taXERMa1z4UpTBlQw>
    <xme:5pVjaCSaBqM30wZBx47bSE9sh-n0p1xhzBvdBFdjicXR-IhBfpHfq1Ccc7whwk_4u
    -RUdQpG6BniveKKsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeevleeguddvkeetheeiveffudej
    lefgudffffejleffffeludekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhn
    rdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5pVjaIVR3KCmiJsld-5tJb4n1AbvBhhwegeXZdDgz8kzvwX5WqaYKA>
    <xmx:5pVjaMifizCUgYOlhdOEs_QPSbyILpMO8tiU8G-TcZ1M7jtFLbXrFQ>
    <xmx:5pVjaIB8pBXXkmFnHPagljI6l1bZFuNPdkYeEtbw_8gcJcPt3qgVyQ>
    <xmx:5pVjaNKeykUdFBQcVOdUc06VTNToOsoShVWuV6xsCX9GHQnokd6_mw>
    <xmx:5pVjaGmwdVI5QfyRU2i0GaXcWkqqTRpDPXrwjvVFF-Mx-ppGH7X7mRB3>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8E1C21EA0066; Tue,  1 Jul 2025 04:01:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tb0b14b73cc505ac3
Date: Tue, 01 Jul 2025 10:00:09 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <f636050c-fb27-4798-8d1e-f9fee21625ad@app.fastmail.com>
In-Reply-To: 
 <a52322528dac34827abd5100a2d3ee49e376e2ed.1751310455.git.code@khaugsbakk.name>
References: <cover.1751310455.git.code@khaugsbakk.name>
 <a52322528dac34827abd5100a2d3ee49e376e2ed.1751310455.git.code@khaugsbakk.name>
Subject: Re: [PATCH 2/5] doc: config: use --value=<pattern> consistently
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025, at 21:10, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> This option was introduced in a series of commits from fe3ccc7aab (Mer=
ge
> branch 'ps/config-subcommands', 2024-05-15).  But two styles were used
> for the value provided to the option:
>
> 1. Synopsis: `--value=3D<value>`
> 2. Deprecated Modes: `--value=3D<pattern>`
>
> (2) is also used in the synopsis on the command.
>
> Use (2) consistently throughout since it=E2=80=99s a pattern in the ge=
neral
> case (`value` sounds more generic).
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

This also breaks t/t0450-txt-doc-vs-help.sh
