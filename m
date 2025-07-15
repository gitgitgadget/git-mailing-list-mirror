Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BCC1547CC
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612415; cv=none; b=MRLtHonrxAvtEvNb2ROLY9GLFRCdRM/Z7wjdZj4ulSEHw6x6iv9qwUIVpmmATeMQfFYuIEHb+Oeimtpxn3pc0RAcxq0wu5IIu83HVXOKVFSGHMKyRJsX1wkukE4wX37e0+IY7oGLGJLnF+AofLcDnzS5FGV5EN+4//S30iv0kjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612415; c=relaxed/simple;
	bh=1kNMwExMmi98/MYqSncD1whJrtZK2uXwosOXJnRLha0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h/1TcsR5f6KWuIpIwlhK7Dboj05399RriMFl+2lrqWuAlxJ4Ml2+urfhNQVmKjt7/8eMdTlyejgfndhcTeQ5pe9mW54ymp94NRB54exk/N6DbAOdU9eOgdCgPCdU5l8GwuYmAflfBiP6kaqFljRbRP260kNjRUQc9uvVuwerzXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DMWycgV7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ej2ZKADK; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DMWycgV7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ej2ZKADK"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D7E27A0028;
	Tue, 15 Jul 2025 16:46:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 15 Jul 2025 16:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752612412;
	 x=1752698812; bh=jt6000g4X8/q97G56mjuIINjsv7Ab3xVWJ1tVxltvjw=; b=
	DMWycgV7aAZvvWh5NGXbAG/0fCdXuq3eT4451A0hH9uWjFm0DDHAQCXS7GKL/D2u
	dUUFR66RJtxJUiNZVPsdMi65CLXNXyENB6VarV5/O1irB81c8eHM64l6zR1Lwe3K
	vTA9KocUxf2FK9NxYHnk18QXszIn9pc6GYNjlwYvOJt6+9cwhMgkfGyxnC/RHvx7
	HYZLSiCdacRqrxiy2hHhImZ+0qPU8ApHpjV6uccoyfQ6O70j64fkGEf9GdokFoTr
	rsDo6av/0dc97DzLwO5uWG0MCtrnxKffgDj3s9q30KP6M10HhBP6ypurInxyu/xf
	+uKd19BA6PNNEcZhQzA7iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752612412; x=
	1752698812; bh=jt6000g4X8/q97G56mjuIINjsv7Ab3xVWJ1tVxltvjw=; b=e
	j2ZKADKaJZhkPMUGQQWgKltg876DpKEvtodUnW+zdsLbbJ1NLidBiJcIDn3AuCfn
	akS7ZKvIwT8RwNOD6i3atXJluhx6z8K/y9QJvtUh8RxFo377wl3DPJRkJ1HPCW+v
	tDNE+sZ/ZhossVCxEBnEa4/ZsZUczL7ag342Yc3JX+4DbH/WF52K3tR8tzTojT8F
	rhdiz74ZEAdaBHkL8zowQ3bB+53luQUfg70D0yqsF+E5oAekthXUdwt/2tGg460S
	hoK4B6SMsccewJct7pOoQb3H6eY6w2/94xQwnPrkGkAdkcPp/bM/SvzBQ4vdJQjO
	VFtTOMnIC8GsQLnAehxqA==
X-ME-Sender: <xms:O752aKodwbcqvfTIFwCDMpGJWnIVdQXqhNbSf7BZcpaihVPqRsO7pg>
    <xme:O752aDNrgvD4cU5wEM1DiKwBYI2t0Q2WLp1iilzMEfRpnWfXzrtlHWffd2kEiMlwj
    i8HcSlZxYJrwcecbQ>
X-ME-Received: <xmr:O752aLyE-3l9DD47d8i4Ftyngp18LmI3Ym6PoUnD4vQzeIy4WB63aT7XeLKgtVciMvdI5m6xmPt8fnDSnd4MX5lOZ-Ij-LWqMa6jjZo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihlhguhhho
    mhgvvdguvdesghhmrghilhdrtghomhdprhgtphhtthhopehhiheslhhoohhpihhnghdrmh
    gvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:O752aMuh6fu4UcMRIH7GnMU_Hw8uhY2_2NtRpQ2qCzst26kH6_yuPw>
    <xmx:O752aE6TkKn5sZUkCK6VUnNzm6AHGsGfbuEouH8ZTzH_A8UBQrszLw>
    <xmx:O752aLTfuQ7lz_0yfb86Ae22SibO7srvyjI4tGRPf4Xr_ZeleoeVCw>
    <xmx:O752aDrePLFkpI9JnzBp5haq-igXniCtNnGP1EqfItBmCcqDNoTCZg>
    <xmx:PL52aDByCgGfnDmytGO3kt0U2fKJtP3YbCkVJ54NB1d8s9LgKfplVJOB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 16:46:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: Bryan Lee <hi@looping.me>,  git@vger.kernel.org
Subject: Re: [BUG] git pull ignores pull.autostash=true configuration when
 used with --git-dir and --work-tree flags on a bare repository
In-Reply-To: <1AD9A170-8E17-411D-A13B-EA7780CF4D39@gmail.com> (Lidong Yan's
	message of "Tue, 15 Jul 2025 23:02:36 +0800")
References: <010001980c90be66-2401a0b0-5c86-4135-90e2-c325852ef168-000000@email.amazonses.com>
	<1AD9A170-8E17-411D-A13B-EA7780CF4D39@gmail.com>
Date: Tue, 15 Jul 2025 13:46:49 -0700
Message-ID: <xmqqa555gp1i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Lidong Yan <yldhome2d2@gmail.com> writes:

> Bryan Lee <hi@looping.me> wrote:
>> 
>> Would it be worthwhile to:
>> 1. Add a warning when users set non-existent configuration keys?
>> 2. Or at least document common misconceptions like `pull.autostash` in
>> the git-config man page?
>
> I think adding a subcommand like ‘git config verify’ might be a way to
> solve this problem.

Yes, but I do not know if it is feasible.

There always are end-user or third-party defined keys that are not
known to us, and we cannot tell if an unknown variable is such a
end-user defined one or a typo of a known one.

