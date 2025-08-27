Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E245E227BA4
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756314593; cv=none; b=lu6h2w61t9twa6YzTokhSWffYxpNyDlgVhnC6Cs6ToYxq4Xcd4gfu2x5wa02Okvc1yH1wVv5w6XWMIiM05Z3G7v6YG/Cnl/IHRaNHV1HfdQMAwcnY69zRejQoDpvXqgB53JRjroGPCcfJCNujgnKQoI069/hyJHBifbjw31JeWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756314593; c=relaxed/simple;
	bh=/NFkkncHA2ME0+S0MY/EAFywf4nxv3Ys0Bl9rfpB6ig=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MQAjK2UqnZ3QH+HvkKbxyOvpqW5Y462lq8oleaQpV74T1V/BU0rzZEFzrfqc6f0a05ujpHztYGtbXUpZEYpoX+ONPW8HecASvjBEozQFztoE0UbPff02MOxzS/1i8t55yX/v01S1p2uHeIi3NGjv4v4UtFOC0uXVfhK15L0FQzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cCHUSWVS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cl/q8/dq; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cCHUSWVS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cl/q8/dq"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 02D54EC03EB;
	Wed, 27 Aug 2025 13:09:51 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 27 Aug 2025 13:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756314590;
	 x=1756400990; bh=IyTM2P7D9mbA3/0RvHnG3iyUcBWVSJor7ZQmIsnzHHc=; b=
	cCHUSWVSL/jrRkkgf4s773T+FvbwJjHc21cQhrB62KGXpQcraiGjKjvezVYkWBiq
	XE7sHC7S/niJnGltG5YsW5Ijdofmv48xhAH4Vv8j9XplRCEbQMjN+nLSm0EAjNFu
	s2mt574wI0gkF4dxopuc6i3kdFeLvDsG9rrLAHSepD4aKdgQG3yX5Nc567cuMWK3
	qp0Hm5isfhf2DCYv2Qop391zo88qMs29Td0U//bkplarOveCvnQ9/ppZVCq3tvkW
	qMcoHeM9PTgyQ5TjmEax2BjAKsCcXW0Nr/qvxM5PVfOtHHF14SgERKzmqjoNLFjz
	YZVkX5I5vWNExVg/HzKERw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756314590; x=
	1756400990; bh=IyTM2P7D9mbA3/0RvHnG3iyUcBWVSJor7ZQmIsnzHHc=; b=c
	l/q8/dqzptRqxJgAYKcnfgUlb8lZr4bFCtIc5JDuyWjv68LlEZhQeV29ki2mPJsB
	pV739RrJpK70pwABozBsqUMLPWKWXp9p3G3etZqbGFlYFnC5DV3zX4Uj6pwIwidh
	ey9dzzjA4heUYNoqsya8wZVziWyNRLgSDf9d+kGPrGi0jJXVal/csC2nGBU3EZTe
	aiSIYajPbrVLq3vi5lbiFAx4qqfr37BB4bd0Xb4Ol8QwvMIyQvb30chwDTz9eLsW
	p5UlF2RIUdqn8QSRLsOFHnNRH29rQcwoKP7XE6hZCqasb9DRM9UCth/CzBWlUlNt
	tof8+i41ZKcTc2FLqNd5Q==
X-ME-Sender: <xms:3juvaN7mbu0PUogO838PDr6Bafn1NoTmkxclfvANAAmmFyDyO99zCj4>
    <xme:3juvaK7cQVwqOtfNfAb98eKTdPupym2AxIz775zzJKIuT0VHsMim69oZKj7qD6ayf
    fV0ghRwOVs-F4ZtzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveej
    gfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptg
    houggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:3juvaLDQvUQrvrjxgKEQudQAyQZMnh_wW-LP_a5fMLZgJ4l_sXWiBw>
    <xmx:3juvaIZ28TrBBWg7-uYM8qFRxVog2TM0ww0YaSfGpv5Zbbr3slmqVw>
    <xmx:3juvaDhcZYvDYrmK4TQn7WlXDW9aHRvgnPJVRTX57uI3Dkg-uyJsgw>
    <xmx:3juvaK6ddWwZztYGtZNL6eCvBI2THAT5yxCyJMXcH1M5ya7eAwFORg>
    <xmx:3juvaOJIRVWqLY93O2d9kuXWU562XWDcTm8gd31UcAV8ir9WIwgdprcI>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B1ECA1EA0068; Wed, 27 Aug 2025 13:09:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AizzdEHxvRsg
Date: Wed, 27 Aug 2025 19:08:43 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Message-Id: <28875b20-91d9-44ed-bad1-d0a7aedfbfbd@app.fastmail.com>
In-Reply-To: <xmqq1pow3e4b.fsf@gitster.g>
References: <cover.1756311355.git.code@khaugsbakk.name>
 <5407c0955af7b5bb30fbc32264481990b2e4e8b8.1756311355.git.code@khaugsbakk.name>
 <xmqq5xe83e8q.fsf@gitster.g> <xmqq1pow3e4b.fsf@gitster.g>
Subject: Re: [PATCH 2/4] whatchanged: tell users the git-log(1) equivalent
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025, at 18:48, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> kristofferhaugsbakk@fastmail.com writes:
>>
>>> -	if (!cfg.i_still_use_this)
>>> -		you_still_use_that("git whatchanged");
>>> +        if (!cfg.i_still_use_this)
>>> +		you_still_use_that("git whatchanged",
>>
>> I spot a whitespace breakage here.  I didn't check if there are
>
> Sorry, I read the patch backwards.  You are fixing an existing
> whitespace breakage, which is very much appreciated, as this is
> immediate vicinity of the real change of this topic.

No, I did inadvertently replace the tab indents with spaces.  I=E2=80=99=
ll have
to configure my editor better.  I=E2=80=99ll fix it.

(`ci/check-whitespace.sh v2.51.0` turned out to be helpful for me here)

--=20
Kristoffer Haugsbakk

