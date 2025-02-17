Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C50513AA5D
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739796172; cv=none; b=ZKnpbH2M979PO4u19k9CsIBEDPW6d8Y6IKeFUazqI214xP+fEMGdv6wFFuWE/TNQ4Hh61sbsBYjEsh2yssmIn+NhWB3/88sZgnPRla44B6+X/qvtQa0pqNVJ7aqh84dAZX2lJSb+GGkVJaqRI4DP8NlDEiNPQBJJMkSwmIfrLeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739796172; c=relaxed/simple;
	bh=99h6Up/Bo88SlIC67Sqv2bbRw2wR5zxYRrLkRj1D0I0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=GgdrpP9SZBbbUs5/7h+asHqzh03/6y2Hy1FycMYJwGn9HqadoaZEQGTKOeapMa5YRAguI7kmNt8imyDL7g1r7MENYid/lUil5F2G0lVkFKFD2jLfMCU5Ht6/CCR/xvTt0dRA/T/drsRCSTyoNvtsIsE53Btyk+dzU8ULPrfGs08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j1gTyXMS; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j1gTyXMS"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8040B43281;
	Mon, 17 Feb 2025 12:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739796168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQIkaOtgv9p5Tq1qtTpt9szY9RK9M+3E8rtZ+qhtMLU=;
	b=j1gTyXMSqpZdYodZ71uqSGmhbVBRpO680HVl4MnRbUCMSO6FIRVFyPUuqd397SW87OHwGX
	Y7K214NaINsmi3/UYZf91YrlHOS6ednZBRrTZIiR3CNq0BPrTtHdeaohJYNW63eQXMAlBA
	wHAxVuR4QpIGpEfcY2DyM9jhXfJCHACSrS2Hf77KHGv0qrnUHeEpcr0x0nhgRp7VJ9T3cz
	TNJofZY5Yezi6JUp+eWR+DEMdFXTiCZH7Le0VWe0dGSiizYWghUX9clDqgUxPM17sQN8QV
	B2H8OIWXboAsYnjZy1WaxHy6p+P7O3vcXGwgd6KknvzCZIhdeX8pw+fhZrvyDg==
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Feb 2025 13:42:47 +0100
Message-Id: <D7UQ9PQOTOLT.26JEMSNOV4WP6@bootlin.com>
Subject: Re: [PATCH RFC] builtin/log: include From in git show
 --format=email
Cc: <git@vger.kernel.org>, "Emma Brooks" <me@pluvano.com>, "Patrick
 Steinhardt" <ps@pks.im>, =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?=
 <avarab@gmail.com>, "Daniel Li" <dan@danielyli.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250214-git-show-from-email-v1-1-df6469635454@bootlin.com>
 <xmqqh64wl0wl.fsf@gitster.g>
In-Reply-To: <xmqqh64wl0wl.fsf@gitster.g>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeegfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedftehnthhonhhinhcuifhouggrrhgufdcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepfffgffehheegtdeilefhffdujeefuddvvdejtefffedtteehtdehjeetjeeiuedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdppggpihhnihhtpggprdhphidpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepiedprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehmvgesphhluhhvrghnohdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrnhesuggrnhhivghlhihlihdrtghomh
X-GND-Sasl: antonin.godard@bootlin.com

Hi Junio,

On Fri Feb 14, 2025 at 9:35 PM CET, Junio C Hamano wrote:
> Antonin Godard <antonin.godard@bootlin.com> writes:
>
>> Currently, when the format.from and format.forceInBodyFrom options are
>> configured, the command `git show --format=3Demail <commit>` command doe=
s
>> not include "From: user <email>" in the body, even though I believe it
>> is expected when using this format.
>
> Aren't "format.*" configuration variables for "git format-patch",
> and not "git show" or "git log"?
>
> I do not see there is anything that needs fixing, but I may be
> missing something.

This is what the documentation seems to imply, but builtin/log.c uses these
configuration variables in git_log_config(), for example. In the same file,
cmd_show() uses git_log_config().

git show can be used with --format=3Demail, and you can use the format.* op=
tions
to control the output of git show --format=3Demail <ref>. For example:

  git -c format.subjectPrefix=3DFOO show --format=3Demail HEAD

Will affect the subject.

With this reasoning in mind, I thought "git show --format=3Demail" should a=
lso
benefit from the format.from and format.forceInBodyFrom variables, to corre=
ctly
display the output.

I should also mention that b4[1] uses `git show --format=3Demail`[2] to gen=
erate the
patches. So at the moment any user using b4 does not have their format.from
variables satisfied. This is how I spotted this behavior, initially.

[1]: https://b4.docs.kernel.org/en/latest
[2]: https://git.kernel.org/pub/scm/utils/b4/b4.git/tree/src/b4/__init__.py=
#n3487

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
