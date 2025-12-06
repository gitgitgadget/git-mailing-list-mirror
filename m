Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656AD13D539
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765021586; cv=none; b=NS0abdjzAe3eIYDvs7XSoblHfP3yv7n+nyb7TzQizOb6rmJrIfYku/iULCt5lD761phZq9O9pE717CvZJUXiMU3+v3ZH+C8e2btiPXJfeXDYzB37xGUyXA4E6a22+NEgVPWMyFFq6sqwZB4cnL/Q7rpNvkz9RFDy8NOx9AHjV4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765021586; c=relaxed/simple;
	bh=dU+lF8iVkOQO3InpTHaPV8vA0IZY0IEz6+e+CuCw2Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWWRka2X4tqD9/gZlp3cXk+u73jzsFnT46WzUZutzLdZJJXOD+PI1AzLri2p2qBZ+zP3NSOd1giPG4mA1GdmpUifze1j++ap8g3iOPuLBOsX4aaFzuy2lxQTuwGgQS93ZmqzKur3i/yQssPpGwFD6LRm9g4QDAdRS8b/sxG+j6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pOl0VAa7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZSlanXDa; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pOl0VAa7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZSlanXDa"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7AA527A0083;
	Sat,  6 Dec 2025 06:46:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 06 Dec 2025 06:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765021583; x=1765107983; bh=tZjeuAY1Iy
	hOGyzakN2wvT00a9rrH9EJOYhW0PdvdYg=; b=pOl0VAa7UWIqPsjw9IipJlDk5K
	61RujwkHsAQB4kP/5RVhr8ngIS58zfcWAFImOHjvihpwUMwCUnHEaZkwDACFyai4
	Ss+ibULQ9uGLW+yL5b9vHQdUk7i+eoIZMU8oOrpV65pY+r8kc7asTZgi8JYGzdzd
	GVZygDKq4W9hJIIyxrVt/dlL7SRQndGC1rdd7vPwhVmgqiS3FVGFml6X/weZwSIg
	Xbid5XisaoOIq4thPgXG5vMgGntV5A/SVCj8Za6mGVRASZmlEokEKPib8U6+E2bT
	Zw60rtZ5oNQhL7oljHZjbv5sbVaIvT+ElDbobN1gx8NZY0bwJEzVL4pbQ6Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765021583; x=1765107983; bh=tZjeuAY1IyhOGyzakN2wvT00a9rrH9EJOYh
	W0PdvdYg=; b=ZSlanXDao/5v/Uv6c0cKrcdSEBW9li4VXyuZ7qJeuhfIs5OTlv8
	JVvg2kT135aBMcCTuODYAGF20R8PG8wzoskcw7xyCMKgaz+oTjiAeMS89CKfFq6/
	8EuU9YEc1Z3D9w0L5BxggkX1ogmKnywqfw1u5MDt17Uz89uAHbrS4VfcgdVq/SYL
	fmiDMw4Urdibkb2Wyn6soYEe2Xxcjnteuee4UEB2k8wOP5WemyDYegyz96ZwJs6K
	X0f8edkvTKX5fp8l5eUMRZffa9vKh8zDzcbsUH5UUHzu3l3m3jrksIJperExu68F
	LZJVn3Ma6nYQtOrfv0iRAUBYa5dCEuZ4aHw==
X-ME-Sender: <xms:jxc0aZzO8Rrpf0-53wyl9HHyAi747yBFUAPtD_bDzTRj8TiU3VL1Kg>
    <xme:jxc0aQThk9skvqVBk-HvuzBpHoA_XT581i1ttr22mBJehQ3pJg00QVdzyQnlD0Vjw
    8dfc_zMBK0--Q0NrJzqDWH0_y-ILt0EtFKkcBpcEPFf1U4Cvtlnqw>
X-ME-Received: <xmr:jxc0aYV0uq9Ba-ANHF9GVNkz22HpgXWGEowc8ckdeIMgRI3TuP0-fzJeWHtJSEUMBHKF-NZ8AJBhBMndJMwqsqCP698R8P7M11OoxjCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:jxc0aaYoz_Ay_oViEyJKGZfGzb7M8pyFSnn083lDQ7j2EQGcl8dw8A>
    <xmx:jxc0aW2oAsGh5AhA-BNlUS-UIZZFwgmG-Mq3oVXgsbPVWT3WlMFjkA>
    <xmx:jxc0aUjyhapn1gDOD0jlxWa9i7oQxJrA6cvikH7Ggth6Sz5fe4o6-Q>
    <xmx:jxc0aSbs_0RVSxXf9MmMQanBdBfqs6hP1RJzQNy1HOhB38UzDcSZEQ>
    <xmx:jxc0aaSHkrBy3_M-oux2k120ms9Vd8J5mO3Qw6EtirKJ9Pr5fnykCcMN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 06:46:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3f37196b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 6 Dec 2025 11:46:20 +0000 (UTC)
Date: Sat, 6 Dec 2025 12:46:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/2] t/unit-tests: update clar to 39f11fe
Message-ID: <aTQXhoIvqn7f3dzb@pks.im>
References: <20251205-b4-pks-clar-update-v1-0-fd70aac2ab90@pks.im>
 <20251205-b4-pks-clar-update-v1-1-fd70aac2ab90@pks.im>
 <xmqq7bv05gdg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7bv05gdg.fsf@gitster.g>

On Sat, Dec 06, 2025 at 02:27:55PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/t/unit-tests/clar/test/expected/quiet b/t/unit-tests/clar/test/expected/quiet
> > index 280c99d8ad..a93273b5a2 100644
> > --- a/t/unit-tests/clar/test/expected/quiet
> > +++ b/t/unit-tests/clar/test/expected/quiet
> > @@ -18,27 +18,57 @@ combined::strings_with_length [file:42]
> > ...
> > +  15) Failure:
> > +combined::compare_u_with_format [file:42]
> > +  Expected comparison to hold: two < 1
> > +  foo: bar
> > +
> > diff ...
> 
> If these files in t/unit-tests/clar/test/expected/ directory are
> expected to end in a blank line, can we teach our .gitattributes
> file that these are OK?

Yup, will do. Thanks!

Patrick
