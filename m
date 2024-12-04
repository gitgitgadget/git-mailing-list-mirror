Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A5029415
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733279949; cv=none; b=qN18Wg7miq5hBXdH47e4hpqpU93P1z+lvf8JJpQfocu0XxCBL2gb8Ic3OPkpGVMy2d9ibHorhzIZM8hCwOsXqct8//4xh/cGl/8GjQjNRHqHEJvoQjzhXJYiY7Cbsn85c+xPDHQH2HZMeVXn4x/5irC3eIDVYEXuC1hOJP1MN0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733279949; c=relaxed/simple;
	bh=AZNaBiZpJ7MY8hapDjzvrKO9zWE5Ff6Tq5owsEIgJQE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oKpNhWpXWaLvQeEY0Tx2pi+JjhClJk3MrlMqpsssJsWLS0va0xPdxtUvb8TxCwgIOEN0w7ZU5FxAvNHxAQhfwEIHq2cdqf9nFbCC9xEd4Ii/8dbPKaWoC6iUGZ2i3IzOx+H6/z880S0m8OBEvNCa44ES0DrFwjVPCkr45p61zjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tQnJpk6l; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tQnJpk6l"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id F2B141380604;
	Tue,  3 Dec 2024 21:39:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 03 Dec 2024 21:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733279946; x=1733366346; bh=gLkIKNGbOoVAwPGgjk25qU60F5szzB+IvQH
	B6bY8BK0=; b=tQnJpk6l8IhRT2EHtEZh04T7EGgB4RDH1hxtT2QfweJvbyGOF3G
	X3XsftX4qQdzq4kGTQvtZB8Bm/UdMxbcRlw7ek40VM8h3Qi4nW/xUMEbVIk3ZAZu
	E9hArURYD9Rkl2tUZhTxggg+n3bu9r74IKjwgq8tngsSd15r0oPD0EG9xq7gVwwl
	VacSewGTAMR3ncJrqW/coPpXFog+WAwfOlLxfsEkU8VxX7GquOcLjEVlfT/XIgPs
	do+jFsF5cJIIGigXDyR+benZa/P6YMB843p0Ek+zuPkdCFLmh3gIwzeDSgRveU3D
	6m/piN5c//+y+zDt9/4sJUhEL6m1EjKmBkA==
X-ME-Sender: <xms:ysBPZ-uauJVDjCcr_i3wpviDVr2J_3djh3rt4tHXl5hdrMM220_v2Q>
    <xme:ysBPZzc0Y33m2rndjgPSk0QRtm2Zhci38DK4kYTpTVF-yf5snotNzOUCk5zncpYCN
    gkqz09_WZsh9JPi4g>
X-ME-Received: <xmr:ysBPZ5z9OlD7vmXyUCnuK4jLk46v_GlGL0QiJcYxAVJ8h0uA4UcUTjBvFHY6j9IfozFW_NdCZI1ODnvd1S_EHG1WZKej1_Ft4qb5DRY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:ysBPZ5OPq4FW2A_CdlMqwPsFamVYyAQQ_vXR2-eaR3hFs6GU7DM1QQ>
    <xmx:ysBPZ-_30WqglWgMgwTnREGlWNebG47AQ2pNVdlds6fglBRX7mTK3g>
    <xmx:ysBPZxXnYXNrsWWqYrI3Dncd94tXp51m_mQJrZY7-jyig41asVWA7Q>
    <xmx:ysBPZ3fTRcZpl3dJRQMvQE4RS1coYvvk3yOYmMqtqqgZsjARVS-_Qg>
    <xmx:ysBPZya6e7tV18p6TOukT366qsLpdiHnN5XwBGVgAOGEN-cH-14wHYJX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 21:39:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 3/4] fetch-pack: split out fsck config parsing
In-Reply-To: <xmqqy10w9x0m.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	04 Dec 2024 08:17:45 +0900")
References: <20241127005707.319881-1-jltobler@gmail.com>
	<20241127233312.27710-1-jltobler@gmail.com>
	<20241127233312.27710-4-jltobler@gmail.com>
	<xmqqed2wox8n.fsf@gitster.g> <Z07QqowPVEgJ3sIw@pks.im>
	<i7tvwk462uwe3syarrnmjttgu4p7urtymq4n72kj7ziaptu7iy@vh4td5fd24ko>
	<Z08VoOHGZ1wecUx6@pks.im> <xmqqy10w9x0m.fsf@gitster.g>
Date: Wed, 04 Dec 2024 11:39:04 +0900
Message-ID: <xmqq34j45fzr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> I think the current version of this patch series is fine as-is then. It
>> might be a good idea to adapt this in a follow-up series, unless there
>> is a good reason not to.
>
> Sounds good.  We may want to tighten the rules a bit to reject
> obvious misconfigurations, but that is outside the scope of this
> topic.

This reminds me of a slightly related tangent.

There are pathname-valued ones that we added deliberately as an
optional configuration variable, IIRC, and fsck.skiplist may be one
of them.  In other words, they mean "In a repository that I want the
configuration to affect, I'll have the configuration file at this
path, but it is merely optional.  If it is missing, pretend as if
the configuration variable does not even exist".

In retrospect, it was a mistake to define that this variable is
required and triggers an error when misconfigured, and that variable
is optional and triggers only a warning when misconfigured.  That is
one more thing for the user to remember and does not scale.

We probably should have done something like

 - the value given to all pathname valued configuration variables
   and command name options MUST correctly name a path that the
   command can read, and a misconfigured configuration variable or
   an invalid command line option should trigger an error when the
   command needs to access it.

 - the value (not the variable) can say "I am optional--if the path
   does not appear on this system, or if it is unreadable, pretend
   as if this configuration variable or the command line option were
   not given".

The "when the command needs to" part is important.  Ideally, "git
log" should not fail when core.hookspath is misconfigured, because
it does not trigger any hook, but it currently dies while parsing
the configuration files in git_default_config():

 $ git -c core.hookspath log
 error: missing value for 'core.hookspath'
 fatal: unable to parse 'core.hookspath' from command-line config.

which we may want to fix.  Unsurprisingly there are other variables
that do behave correctly, like

 $ git -c core.pager --no-pager log -20 >/dev/null
 $ git -c core.pager log -20 >/dev/null
 error: missing value for 'core.pager'
 fatal: unable to parse command-line config

where a misconfigured core.pager does not cause any trouble when the
pager is not in use.

Any of the above are not within the scope of this topic, obviously.

cf. <20241014204427.1712182-1-gitster@pobox.com>
