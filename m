Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977B221C9F5
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575691; cv=none; b=AI5ypnpSMDTjdnWb5GJQCtMy11h+mqk+bmlTwoLrGCWB1ir2YZISqDMb/dZLcjXI0H/eLwSuc+fhI5HO2iMx51J1rCGq3OBNpE+DrYATWfNgbqC6FHM+Tji6x8Tj7ue+RP6qc/8LVHiCrqHF83jeAmJjUu4/RmFV8bIKzMeBN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575691; c=relaxed/simple;
	bh=fftiCUfzmE7zC2Clz351uCeXAWfANdWv360TP2ZcPDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UH9xkN+OHgX5V8QL3fFxP+FFnIOTOucB/bdj4hM+njbVvmr1Dmx1eU6MwJoaHGxmE9GdpLVOqXQ+UzPGdUDzmc5ZmKbPNU0CusPeX1Cyd0WUAUAbdSVl/VZeRf039cV+KItfS0RzDLti66i2awJUrePGz9g/hORIGJ7pAXIZIu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=tF3zn56Y; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="tF3zn56Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1752575684; x=1753180484;
	i=oswald.buddenhagen@gmx.de;
	bh=4KZ3E17LqzQxi7l64jYZikSuZZmhqQTpsNdz5Jscg2w=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tF3zn56Y1IWHRIzlpZL3cM7VM7QInqTK2ToytGpzSZBFOi649fYenyD+DRKfYcEw
	 U+RsZVHL6vg5rYgzlGuAkWg4uGSfFon8YEKxZ60nEUag4+ovc8evfe+gsr2DZ5M50
	 MYh0s7Dwwtb9ZJEkXgTZ/QRnmlDbLaWShGCyT1aUqcG+PuksAxPWiMmCEOJqUKnWE
	 ctCwipoQb2Jxvx6be/Xfkta/sP8XWr67p9+YnTW2nmr6RlFlWXX0zs0HYsmprcCGW
	 WdEnADFUAp7KfpTqNK6WRocEXI5heiRv5DxbOedhFtKWGYV5zQhNeb7a9uK/7xiYa
	 eCRVFx4KmaJZlefLPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.109]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bX1-1ukK3c3to3-014dlX; Tue, 15
 Jul 2025 12:34:43 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1ubczi-n7s-00; Tue, 15 Jul 2025 12:34:42 +0200
Date: Tue, 15 Jul 2025 12:34:42 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com,
	ben.knoble@gmail.com, gitster@pobox.com, phillip.wood@dunelm.org.uk,
	jltobler@gmail.com
Subject: Re: [GSoC RFC PATCH v4 0/4] repo: add new command for retrieving
 repository info
Message-ID: <aHYuwlWlbkc600Ps@ugly>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250714235231.10137-1-lucasseikioshiro@gmail.com>
X-Provags-ID: V03:K1:xrFNobvY6HUwv6qriBqnGpkhmzpFWHEpDRhRNQSLGlMQBFShX4p
 xzGfQVNT8RAfmE4ayzeZpDner+04c4gL6ERTwz8HUcZWhYWdZKKqZl3TOFvky17Am8nde/J
 Z+4RFIB9imEYREf9+LB6daOjwmyNPI6a2UhibW/BdVPTfT3X3y+05frtubasEnz95sWZumd
 l4l2ulDuSSD9sjMpbSA9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:56B9Nv9MaQY=;i3rtswd1HqcJr29CBPT44bgiFzT
 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
 Ths2I0CeofUFXsGceQ3r/JE=
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 08:52:27PM -0300, Lucas Seiki Oshiro wrote:
>- Renames the command to `repo` instead of `repo-info`. All the=20
>functionality
>  of `repo-info` will now be under `repo info`. The functionality of `sur=
vey`
>  will be moved to another subcommand of `git repo`.
>
this strikes me as a bad idea, given how established the `repo` tool is.

without much thinking and reading prior conversations, i'd go with=20
"query", because it's a database-like metadata ... query.
the obvious followup idea would then be "meta", but that suggests that=20
it isn't only a read-only command, which i think it is supposed to=20
remain?
