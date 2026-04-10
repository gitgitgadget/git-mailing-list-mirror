Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4A63876DB
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 06:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802714; cv=none; b=E4Sjsa7OIQiYgtq5pSdSWJlhXos1dV1GOJggr1THyU6qS8x5+EbYr8dhd9ISUZ4C6kaH2+bNybxpbbJqig+LIFw73jKViRO+x/wfvW2n9nuqO11qCe1xk7A6Fw5TqQ/NWhXr4sKtD3oqCdb6hFO0dDl+sUoqUnVPVi9X3iQ0YjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802714; c=relaxed/simple;
	bh=T/F/WVhc7wlMSoJva2nqbs5i0WB/g3+0pNZXcL+rsbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2OEIc65bFrbhqeIlE+dP0CZ5CFwwR07OV5eTwPFaBWMZgU9qSGRfc5vLlQDqJbwWTQUk4Yl7/Y6dLnUaS4DQq2bmsKzDf/IL3OUI0WmSxFUUfaF4gHLL12mjtQ9z92YM+KzMH2Q7PIvGKOGDAypRf8qyu8JSolGbFWxbzdf9ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ob/dRR1H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=beXVboXJ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ob/dRR1H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="beXVboXJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C0A617A0053;
	Fri, 10 Apr 2026 02:31:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 10 Apr 2026 02:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775802711; x=1775889111; bh=odJqttXeNT
	Tj4S0U1bFS5oQPxUW+rmFjijbdlJPTwMs=; b=ob/dRR1HNkaZPXkDXgSN6OzYEs
	JBPTDudVkj5RCyp6xPwEsszcKreYSeeslhVVbPPiSvTRT+Ow9F/acTPvz8g1kHOM
	Wsvg5UdfdlZB6cjdORQC/RYkJFlFPEP5PFtOqwJK2D4Y6zHShsPZ5vsIup9JwWZW
	luXs97Z5257Q+zh6NwvxKduyCaG/YBYF4D2Ok8Q+S57PeKmgT3/7/aAW/bpSS794
	L2/Jw4AgWGzOsIn2HHRZYMwSpYc4x8MDQ4J/lFfGjnzMbG69do4FOdwdBABPsaY0
	HMz0WVqgtcsOaks9L+utkzHoEC3i+wKiYq6nSFPjFtREvOliofK6+E0o734g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775802711; x=1775889111; bh=odJqttXeNTTj4S0U1bFS5oQPxUW+rmFjijb
	dlJPTwMs=; b=beXVboXJu0KdonmDMILf93ZfqjSzNgWncrfFjRaUEekYNKGGi3e
	H02pie+lIK6FOMSMRRSUbnLhpinQjEjnqVXWPATrqdaq8scB4U9DZruIvBzOQMvQ
	Z7kIKwq+PE6dqAhomelERsetRqULEy0neVVmQEQl7wTZl/eS8PtzZa7JkWmu1mmP
	uXD0qh5OVXpVmwfnJNAByXBkRe/vXf3GibqAcjv9eM505qGbApDxoTZProUnP+ky
	LFhT0dYmFAZ7ulcnoIfaeTz7+qdYg3+R2sKiOSxxHZZOYhNpPU5JUNV0BEpSq6Ph
	0GHfytT1LK1AruNCZs2SURuRF/W9FCIo1cw==
X-ME-Sender: <xms:V5nYaRw4J9z5d0Rxb4GMJCz3JPjVtkFpJUfnwPXikPc8QkkSGkTzSA>
    <xme:V5nYaYsDvqxcBCQXHahTdyxQpZx5kRZ9NY_JeKSWilSiZ2xxAZpoBidoqjumoY1KL
    3YL33BftRyQvyhbZbK_GokHVdNUtRf4xkHkQ41ueRsLnWr0r5jwtQ>
X-ME-Received: <xmr:V5nYaYtsuEb8iTcNgpM3SIGs1autsJQ0N-PqpGr-5KzdjsxSy-P7ZuCowhVTn1JoHHqaTVgVw4DLHu6K7tM-_eoClvWODQAXfdBK0ay7_Z2VmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvkeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehioh
    httghlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:V5nYadOc-VDq6ZBN0Zs70ghOu0v1vPy_eG8fq0eJKMmNsI2_2m2Aqw>
    <xmx:V5nYaW3TErQvYov_9qvenW2MkrP8UwsG93ls8VUbjg0RysIAZGaJYQ>
    <xmx:V5nYaZN0BQ-dJVcSGO9E8367oV71WOZNJSCTQ_rT3Ppals-UA92meg>
    <xmx:V5nYaW2-ZatcKa29UXfpz1pYEdVM2eJDQcAByPa0Yb_XomaxMm8Eeg>
    <xmx:V5nYaYtp1CbeG8VsmgShWyp2VIbLlYE25U0mavU-VocSN3xfHmvC3eL8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 02:31:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e3650f51 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 06:31:48 +0000 (UTC)
Date: Fri, 10 Apr 2026 08:31:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: [PATCH] bundle-uri: drain remaining response on invalid
 bundle-uri lines
Message-ID: <adiZTBH_70nrpiHe@pks.im>
References: <20260408-toon-bundle-uri-no-uri-v1-1-d4a0e3937eba@iotcl.com>
 <adZ6yyGsoyjm7t0Q@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adZ6yyGsoyjm7t0Q@denethor>

On Wed, Apr 08, 2026 at 12:49:48PM -0500, Justin Tobler wrote:
> On 26/04/08 10:58AM, Toon Claes wrote:
> > Because bundle-URIs are optional by design, I believe the changes in
> > this series are sufficient. Also, the series [2] takes a similar
> > approach: have the client gracefully continue in case of misconfigured
> > bundles.
> 
> I'm still largely of the opinion that a server-side fix should be
> implemented first. Unless we really don't care that a server may
> advertise invalid bundle-uri info to a client, making the client ignore
> the error doesn't address the root of the problem. I don't see a good
> reason why we would want servers to keep doing this anyways.
> 
> To be clear, I'm not against also making the client more resilient since
> a "fixed" client may still try to talk to an older server that still
> misbehaves though.

I think that addressing the client-side is a good first step, as we need
to also be mindful that Git is not the only implementation used on the
server side. So even if we fixed Git itself to not report garbage bundle
URIs, other servers still very much might. So ensuring that clients can
handle these gracefully is a good thing to do.

That being said, I also think that we should fix the server side.
Whether that needs to be part of this patch series though is a different
question. Based on the proposed patch you posted it seems to be trivial
enough though, so maybe it's worth it to just add that in as a second
patch.

Patrick
