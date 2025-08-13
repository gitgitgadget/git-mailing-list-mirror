Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FA72FD7B5
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755116603; cv=none; b=DY+FP6cCkplwzfhai/d4P6TODxEFyGMU4s/tHj2z/gek3Ofyv+k+wai2oE8F1yxBl0az+Byi0L++AFczSiixX2KxNm31pOytvZqNVlibxjsUkaNdNQ2GHSkOXb7DsjWHoE/RIyWEmCucEcF35/x+szRKOJDO76r+284Kqr6mOz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755116603; c=relaxed/simple;
	bh=5NIF1h4Wj11CiHkYR6L9i5xYMyEqHjTd5mliKhH4HJI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p5eRCQnyWr2cYm1QFJ5dMeM6A0G3UWMUSQE9/MePo4LxY2HOxK0uFdhi7GytqDlgQ72pkorZIcBbjEztEjv84RCfRRslm6erhSErQstBM2KXf6fXGEOfSc3OuM2DbidCMPsC3lidN6VD3IpS7e4UwJmMyLBzPnqEoK+FvS6WwRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P0CVYRuR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lNcGD8Gc; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P0CVYRuR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lNcGD8Gc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9A1DA7A011E;
	Wed, 13 Aug 2025 16:23:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 13 Aug 2025 16:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755116597; x=1755202997; bh=xNiAlDvluG
	XzLz4Q36FXVam4jJsohkgVjLgJmJ6978o=; b=P0CVYRuRiRcQLRVudurCuvtIuP
	WIo6z0jKHJpi/t7CAEK+j1VRQ64jGaw9SY18tQDCW8UbS1E/aZsu8KPmOl31ClHk
	jaE/iEVTaAH5yTrMfXomV/lGg9doDcXmez3HzxXwivigEXlYRRZPoT1yGFh7+r5n
	Jo3mYZMQYPGsftmyzW/+oeUP09iPUC/5ZQeSp/jctUi7hHhZsQ2tZ7ICkMv6ItdW
	xLgiU29Zx6JdUlePmjKVVjYdS92AYwdBLHSEOdFHh21BXrQ4v4hwLrzcc+VO34rb
	0BbuF5CvWd4hDTQFMjhUMkYGbhXqW7HjwPAUyULKKT8mKy9Tio0US9OTAIZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755116597; x=1755202997; bh=xNiAlDvluGXzLz4Q36FXVam4jJsohkgVjLg
	JmJ6978o=; b=lNcGD8Gcn9VURNwDTZAz+4boiEVHEr+uwFOmZMpfCqO16ewW8Yq
	tOUyY8Su8v8fLLhk8h916K++cJH0MiyeaDglKHgHSMhB1sSvTfvf3EoE2yT9iVvQ
	Ae2/i6ap4zkcf6K70PkzFWrIYqyn/p977tGYH5jkLUeHFHLjFO9jxBdODWRBpmRL
	Er6hQXjZDVZuugeVQR0PV4/20rcEIZTv6xPnnMCtkEzdCLZ46Sx/VQ4uk0udgjNa
	rTVU8BcyOA47XssWezxzRFJt7TQGTWOrymHdH/rbFxlf7GZ2vlAsrND3T/Zwd8A6
	o8Sic7Yf44i+h6xQ4DKcwk7vUii1IiCwnwA==
X-ME-Sender: <xms:NfScaLf3azR4CYW2ucNkJuwGNveJBARALckb_H_tzImGrb5uFeW7XA>
    <xme:NfScaEfruJUwGH39RuHYPTSaTfYput8rLd4OtX6y6-Rax6C--Xzx-9RHvwcC4lfYY
    tYz9G1j_dsBcecQCg>
X-ME-Received: <xmr:NfScaN96XEN9SmYGhzqaFtcIZ-X3sOe4qNLiEUS7aikKF03EKEfG6x56jY1tMfOY5eyJLfabDbQ4kUurmb-FxQPA0EdjE58GZpxPZ1c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeludeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkvg
    hnrdgvnhhglhgrnhguvghrseihrghhohhordgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:NfScaIkmutaj1MaTF8M8MpXqKsv6JOagkUUmYVkHii-ExzOtlIaATg>
    <xmx:NfScaH__vgoUuQf9XvHq8sdpBpyt6fAV7yRprVkud9ZiD_z5vbsQ6w>
    <xmx:NfScaOnsxUUJ71LIv8cMlfQeIxYELQt-XV06Ge5JCUpO1hGAoWZ0-A>
    <xmx:NfScaM31GWA10yCAbzrZmkeqTspfMlDNa8tZCRug7ovyxDiIzFbKpA>
    <xmx:NfScaM6DIQbdt6-3wjy6qMF6WmuQEbQWq_7l7kPXxfbB16BkhD-aHDuG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 16:23:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ken Englander <ken.englander@yahoo.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: installation comment
In-Reply-To: <SA0PR19MB43679ADC65CCBE9DB385FFE8AC2AA@SA0PR19MB4367.namprd19.prod.outlook.com>
	(Ken Englander's message of "Wed, 13 Aug 2025 18:04:10 +0000")
References: <SA0PR19MB43679ADC65CCBE9DB385FFE8AC2AA.ref@SA0PR19MB4367.namprd19.prod.outlook.com>
	<SA0PR19MB43679ADC65CCBE9DB385FFE8AC2AA@SA0PR19MB4367.namprd19.prod.outlook.com>
Date: Wed, 13 Aug 2025 13:23:15 -0700
Message-ID: <xmqqy0rnas3w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ken Englander <ken.englander@yahoo.com> writes:

> I just wanted to offer a suggestion related to the installation
> procedure. I am a new user, so I do not really have any idea how
> to answer the questions I was asked when installing Git (for
> Windows). I made my best guess based on the descriptive text
> provided, but not sure that was very clear in some of the
> questions.
> ...

The Git project does not ship any binaries or installers.  The Git
for Windows project, however, does ship the installer you had
trouble with, and you can report this at

    https://github.com/git-for-windows/git/issues

which is their issue tracker.  People from that project are surely
monitoring this list as well, but but interacting with their issue
tracker directly would help them.

