Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D22C11FE
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769169400; cv=none; b=gWHtzomrVgnL2tpBkHD80DspjFHyXnXFS84o7Nll2paGVvFW5owLZXlT7Pft8UBC98wqy3+9WrNP7gD4rxEQGj4/RSI0VgVKXaZ9yQnjXtJLLmCNPSmLbb9RpOBth3TqMA7FoMD39i0BvPJJ4X8mdFmAY5j/Cs0WqjKHAGSAm8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769169400; c=relaxed/simple;
	bh=8bWchbFTbr1v0CSWRTa1zoHIv6kZ0heeSE0pP9Q/Xrw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WBYb5JvUtZuf2f/SMoAsbO8oWnbgY4Vr/fElYashqLDSolUCAE7fskXUMaqjNX111JFZ7lDztRj4MYwV298ajZ2zODFLkMyKcsabSQmBWwxBFafSKlQakuz24Ogd4nzmScQVj/9g3Jm+rMZEGs6zH9wwTXmUv5rlPnZNmXCiofI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtJ9PYcv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtJ9PYcv"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801c1ad878so21668895e9.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 03:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769169398; x=1769774198; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XoIjGtX1sp19VU9WpvNh7Y3DoZb/ODn0t3COzEIFLtk=;
        b=NtJ9PYcvReK11uU6WrRmChQMoGjLNeAubfLRRZyTFUFEDoB1kJEtABhgFnjjS/U6dA
         6TJ6+X2uGTj+5t2PpmPGnycNpKOmeQtZK2VtPEhLE/ufKB6xopC5XyCcdz88XO29JRUG
         o4r8Jq9F80pTORpcDVwJx1H1fjLbV9sBlj5HaA9Gwu0Sh9/iVI47WOw8KnMPi0fWLZLD
         D69Zb+iw2N16xbaPn5zdpc2u6rjjuiyhgwpm+jCtPIGyC+OdpleDpUI2NHRMSW8Fxh8x
         x39FhFHK3LY65Tx+CUM7psiCB5mYxdivlHbPCjYeEIiY9FBodxAEIC5LHhYT0jYk9oZ0
         vhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769169398; x=1769774198;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XoIjGtX1sp19VU9WpvNh7Y3DoZb/ODn0t3COzEIFLtk=;
        b=qAzs35oeyj+flJcWERv9KeZj5OY+0ZqW3YgngEuNlt8dfhU2ZpqUtkmVDfHW+BK8d3
         wTn8ZTgsMthDUotGoQTaPWELwz8dAQmrLWrXpUIRtXX6wRrMP7r59zoZyJ5OhUpQJQoa
         MZhSdBYdu1noEWkwZwbCQAOWn76UHBObVEwPC+r1BssmehFFEs/MJtR5nOOnkdR9/ALU
         4RvxG6PVDnUjHRcFf56jGsVT6MQtinkhzwo0bj93ivDPC1sfY52etHIPsxJgyUHBSHd1
         +zpGs+I9cdGkXp72ASuFnCWrmsHolG2w8CTHSr0ewe17YhppxOt5d7+G+a3a1tSem7DL
         8nog==
X-Gm-Message-State: AOJu0Yxkm5csLhmj42/QirRYCR+cxrXkiH7TpVTyCv3fNG8VS4rV7jCJ
	8ITdLSLO6ghmm/gu2Z18PRUNmq2oeyDWHmqwDRwxy3QYOp1ifVYt4WLfVO/ZFZL3
X-Gm-Gg: AZuq6aJDMhjXqWzPnnma+j64KohLerVbQNUt5MDaTFFrIF1r5avsit6U7j4lCZKzvJv
	ufl0vjvkuy0IKr5rdOCzS0rlWIwvvulJgNvRS+0jq6/pueOlnoZBxtRLdt32CQeWjIPYx/Dticg
	CJf3rftgmaqjwu19LAfgMJV+BMTVNvFDIdK1xIjyzNkJvYPamrkLggtM6Xf1DlH9vY75GD++Z3A
	fY+0kTqrism7bLhYH28OMJG8nFAdJQybLEhCilo/VngC/p9ymzf/ZxmhbLw4iQD1kxFlSydW0dK
	cuR4dYm4cCDROahdryCMrI9qfCo0AmRKNPJLkDdzvMR4g+jAgKMnUOBFfn3QsMMjrsUTlxWDVbb
	SsN1MkpOlonZoiDI9Qy11kgjhZiLH2kvPYnR+04A8y0tkj2/sPscnkzzHSjyPNhICv161Bo+NVj
	mNPbKnd0jwQyvuBA==
X-Received: by 2002:a05:600c:8b11:b0:480:4a90:1b06 with SMTP id 5b1f17b1804b1-4804c9ceea8mr41918685e9.34.1769169397558;
        Fri, 23 Jan 2026 03:56:37 -0800 (PST)
Received: from localhost ([102.88.77.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48046fba46dsm136602695e9.0.2026.01.23.03.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 03:56:37 -0800 (PST)
Date: Fri, 23 Jan 2026 12:56:47 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 0/1] add-patch: Allow reworking with a file after
 deciding on its hunks
Message-ID: <cover.1769164663.git.abrahamadekunle50@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
In the discussion between Phillip Wood and Junio C Hamano in [1], Junio suggested
some enhancements to the UI of the add interactive.

They include;
i. Add a way to see the previous hunk decision of the current hunk after the
   user navigates back with K/J.
ii. Allow reworking with a file after deciding on all its hunks without
    auto advancing.
iii. When having multiple modified files, allow switching from the current file to
     another file whose hunks have already been decided.

I have been able to work on 'i' above in [2] and this RFC seeks to find suggestions
on 'ii' and maybe 'iii' as this enters design realms

The patch is in no way a final version. I just want to present something that
members giving suggestions can work with.

While trying to follow the suggestions in [1] in the patch, when all hunks
have been decided;
	* A what_now prompts appears, allowing navigation with J/K, q to quit
	and '>' to go to the next file if there is a next file

	* If K/J is used to return to a hunk from the what_now mode, after any new decision,
	on the hunk, the user is brought back to the what_now prompt since all hunks
	had previously been decided on.

I would appreciate your thoughts on this.
Thanks

1. https://lore.kernel.org/git/xmqqseg9azdc.fsf@gitster.g/
2. https://lore.kernel.org/git/aV_IGCld5T_dBxTs@Adekunles-MacBook-Air.local/

Abraham Samuel Adekunle (1):
  add-patch: Allow reworking with a file after deciding on all its hunks

 add-patch.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 6 deletions(-)

-- 
2.39.5 (Apple Git-154)

