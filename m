Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D6A21D3E2
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 05:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770961880; cv=none; b=i7Dih+YoUD6HCkb5piL2cx/B/XJ0wolgeDFkLY3OT77ACzpNGYkjQSaEJzVvb28JZITqohRM7iq7hRAIYflDLnRy7GN9s5vhDEUeUNLwoiwk3PgVaN/+Tt/eMaAFX93qgAJx8tz2rpcraPx8EK97HbhC27Unu1t/6wsiXBBretY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770961880; c=relaxed/simple;
	bh=scyPrOe++PuVOsz0OT6sP0nJLWsDFuSDanzWSUfjn9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hz6rJ2Ij0bCRyQTZE7ny+u+Bh1wVVXa/x5LPgw1W4FxdNhePiB2x8m/ccGlODhgPniR+hhqHbf2hCMR6OxKuIJh9dA0Xgafi4oKLCUodSSS7QB7VVeBjFFP+YK3Yog7iO9c9fHOslT7KAV8/fDJAVyUCkZ/iHroqW8HyUoQH+Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ll+a+xCg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JvI3fPj7; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ll+a+xCg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JvI3fPj7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 219237A01B1;
	Fri, 13 Feb 2026 00:51:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 13 Feb 2026 00:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770961877;
	 x=1771048277; bh=Zn+GcrDz3iujcF0KayG6iwBLp1aW+sXuI5gZgwLOOAc=; b=
	ll+a+xCgt/0WHWk+he7iWshAxZxcaKZwsbTtWnQ7j0eO0b1YB477BehrICERFyxK
	l5BFypRt7mSAQK8HyxOmjcWB3YM6dg769/qxXP1A8V0r/gWUF2e2P1ur0R58T3eC
	PpD4Sx7m9s8YU5eoSv9EFZBi3+SxBGb75hA6utP/VT59rnuowqsvpAX0D/8LPSEU
	wmHLnS27oseniDyslKluzT2tDQAFwRhqVpqTyS4dxBAdKKVBO46LkdVR2J3l9m14
	F/FIEu15fbSMgSgvFDj9mSzOET4wQcUJcd3vTtuWBxUdPNPs7s3yKYrsRjP2PQrQ
	/luB8J145bU60n18F6lLFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770961877; x=
	1771048277; bh=Zn+GcrDz3iujcF0KayG6iwBLp1aW+sXuI5gZgwLOOAc=; b=J
	vI3fPj7cqVkY9KY688FCBKRyymE+NNLbn9QlFrMQGj+nPNQ4nwWayMCRe2gjAP9P
	MYHXyjG8UWBGvatWEV+1s/uf5Gv3xnfGYzPz2vgGCaqxfb1WwaKlDrND7rtI0KVn
	JMm666HIBnFN4WLQ3G4rjmzLkjG02rw8hgVSKp7uabjbqRfu3ALr8WeIA5n0ATz9
	PXhU0cz185BCoVj8pmcFO2x0m6PAn+LvJh19+CcvH84FFum962Tv9BNDsAVrCUGC
	H+dcEVZtMG5DmoCSvVmxSFRMuctEKFjK7cWKSXPdCSMqcuqZCIxe5j4jnf0NTSti
	vVG+bLL4z4QGzKmLECq9A==
X-ME-Sender: <xms:1buOadlrQjwmUOXLAKzqxl0hWXAekZ2RX1kKbXbbrhGgvLYWvmUJmg>
    <xme:1buOae2AzMeqRXnBdaPzOhZPVkU9_uXzGSsckaXtzLesWB9WWtW6LWAzk8txPn1PR
    Q6DOTzTNoASD6JbHMTQ49ULfs2v83810tlXIsXxVBQUrlndAen1sw>
X-ME-Received: <xmr:1buOaRTJrGIt5NkHepOcgoDDgY-KJXe2X38I2xPLz5CZcAyj28lHutkB2OwUt6bpNb1VO4NkmlgG7E5qC7pUixudfJcp5oeCPsa86_VCfhwJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdejgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1buOaYvegx4ZpeNMcyXimsj0ucriry9q0RnZ4UQ-ZXyhBqkTaM9Ohw>
    <xmx:1buOaeYgARTZpbM4_94ekp_jLPGRMRsBohCyT8PH5nkYEU_CZBn4oA>
    <xmx:1buOaVuRqe0fnlBQYgfiu4pqEx2vX8xwwz1KyZTGf9zGwjNak1Aa5A>
    <xmx:1buOaYFYQ097mIj8oLY6FlLQ1oQ9KEFRa9Q7yKHoRZ8u1C4bmfFJaw>
    <xmx:1buOaWW82uu6MkdEx0j3VbYPHMgk8igtfpHQwATL993EP_eOZGZvWonf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 00:51:17 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d8468530 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Feb 2026 05:51:17 +0000 (UTC)
Date: Fri, 13 Feb 2026 06:51:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] builtin/history: check for merges before asking for
 user input
Message-ID: <aY670nh0ElOZU46j@pks.im>
References: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
 <20260212-b4-pks-history-dry-run-v1-2-1ce03d631c1b@pks.im>
 <CALnO6CCciWF_GOd3WqOVwUDLoPRABNgDWbSu7FTgP8KLWQKvgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CCciWF_GOd3WqOVwUDLoPRABNgDWbSu7FTgP8KLWQKvgQ@mail.gmail.com>

On Thu, Feb 12, 2026 at 05:20:08PM -0500, D. Ben Knoble wrote:
> On Thu, Feb 12, 2026 at 7:45 AM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
> > index 6775ed62f9..12a9a7d051 100755
> > --- a/t/t3451-history-reword.sh
> > +++ b/t/t3451-history-reword.sh
> > @@ -203,7 +203,7 @@ test_expect_success 'can reword a merge commit' '
> >
> >                 # It is not possible to replay merge commits embedded in the
> >                 # history (yet).
> > -               test_must_fail git history reword HEAD~ 2>err &&
> > +               test_must_fail git -c core.editor=false history reword HEAD~ 2>err &&
> >                 test_grep "replaying merge commits is not supported yet" err &&
> >
> >                 # But it is possible to reword a merge commit directly.
> 
> Hm, I don't quite see how "false" tests that we don't invoke the
> editor at all, though I'm not sure if that behavior should be encoded
> in the test or not. (Looks like Junio noticed the same in 1/4; I'm
> getting better at reading my mail before sending, sometimes… :)
> 
> Otherwise looks good!

As replied in the other thread, this would abort with "Aborting commit
as launching the editor failed." if Git tried to execute the editor.

I'm not quite sure whether I get the other remark about "should be
encoded in the test or not". Do you mean to say we should use a separate
test?

Patrick
