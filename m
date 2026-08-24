Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AD345FFA9
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587585; cv=none; b=smEiYOiROBy0U01/sHTRklg53n56P8SO02zZsmS1n6oHop2JhqkM65UaSretmPKZdExhe4/KZmTaFK8qoZh1efrVAVhXCm7fP806jHh++c9rkfAtqXpG9Jg7KoH3FF8mUegqTOvg5ZJD2rUe3D0IZRZiOxH4SmpG7R3TMsDWdn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587585; c=relaxed/simple;
	bh=mf68zQfFD1aaj6LkSJTWkEb9tkeKqul8xy9J3FEl31o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NUO3jnRRFSzYqaohifnSjmvNSf4BFEn4WUS/HyqFa3Gd6fQoWtuSIAUZLeUjtTYiRd+4fMHwaBe3PMgh1/kqvUlA8oiusnDdICMkp2WYulg4tbODV+yzB0YgpuL0AYVcbb58mdu8KmOJvtEytlQtAUbe33dor2fHr9QOImKiyGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VSZ90DXz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FKa4T06D; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VSZ90DXz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FKa4T06D"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 441FC140009B;
	Mon, 24 Aug 2026 12:06:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 24 Aug 2026 12:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787587583; x=1787673983; bh=9bpX4NaOXa
	gS7ofiKE/yR8UXGe//ftCrptI+BtAW1NU=; b=VSZ90DXztAFYBbVZ5lI5WkFWRb
	erDC24nI56gQNz5YGJKnqrFfObwhzN5IZC9/9RrWNN5OrxkxdrUBIOtXtCCy63QG
	sDkvl4vg7mRlvHU5Xzdz7WXOK3p6Ql8IdvxbN/BGuYhBditPVRUqK3Vqg7r/8LYy
	qcRl64NWp0WKnjLE7r6UeGCDXRbCuHusW1kdhs3HNTnIhEd4W2ve9g6eu2t9+23J
	7n3zXs6VsS/HvIA1I4Qu1JHO6Z+gqBtdg+PnEAdd02grJyCUL7hDu6IP/8vALVwh
	qyxtzp4gD/jcKGYn4DexpFG22YjNZVaD/chlB3Du/NI16h+4YSm14L9a4xKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787587583; x=1787673983; bh=9bpX4NaOXagS7ofiKE/yR8UXGe//ftCrptI
	+BtAW1NU=; b=FKa4T06DjX6kGBWCWyVjcqiamD9vWV8RYD+x0SD5maAhkUaXWXN
	QnJlB7vYvXRjoHCbUnJhfc5GkYMQUAlq5QOGw0DhgG4WnGS6zJ6Kj8RCIG7hm23T
	sHlO5UcZcC5n6kNnyqZmpcatfUzKAqScTEQVGrLYaM/Epx+DkMU9qU4XTshxT8hN
	QDajeVaJC/YAtDaL9LbKWl+Lgb7Ico0npoNBnEBejXVkS/5x6KF+sS2w2kl7Fl12
	yLz3NCGQMoczfMcTMEu9lYZ2zoWGefNcM8IOkWFimVkuQZYxtCe243LS8SGU+G6o
	Z+N0U0dlupSDOttTQVxS++zhJ24v+wUHA1A==
X-ME-Sender: <xms:_2uMavdKaIM3MaqYH_ByDlwMgvnv05PIrzP8-Xo24eROevsri6VK_w>
    <xme:_2uManfZQ_NO9Cm9--Wz-T6hoCBL2saYv9mN-ew_lKBniWMgmj-LqZs5yvMdqltSD
    2AxLSdFHm2tw2YP3Y4lGUH1zlELOLOMuXKwsfzCOilthV845ku_bA>
X-ME-Received: <xmr:_2uMaqxdPCDPF-0nbgguQpaXdbQdimXXaeCjjYdx4t8Qm0D1WHIkjOWIJK0mN83YFmt20JGyizjYsgOsp6RvECLUIBbEgeF9bw>
X-ME-Proxy-Cause: dmFkZTGeKHtmQQNAHUlrhkzY37sIyYHx4cTxYEdg38Qep8DmhkqFzUGhNEt9F+Qphv47MF
    JMCGR0d0V4LP5a2MVma1Uo15T9Y9IFdw8uJ4ZiWTjlIQ8QIkFZgmIS5miRnI+ZOpF+G4rW
    hYwK4Cn3sbf5zBjGxRuG5izuJ+9nGm7yhmIlp7y7GHXeWUV1mckseyzmv2APnOUcUK7O45
    5zgFtiysc6mynTBUl/4gPw0PmtuNzA6wmYJRN4g6PRRhFXKbkP2grglL5nbYhENe4HvqsJ
    +eQ4NbKkj0CvGX3I1YjypmC5r4BOSX59j0rwZx5mwmHvezWvz0JhTl9GPgTN4CzMz3JNql
    AK5o/wZwrllmAON3OW8hHq+EIjBkSCdM6ZN/BXaMxXY4Tc5ullUyBuQ0xFsFwnLS9fRNQV
    dFMw//nzQMwLuAqdamjLtWavvaf9dbv02KlT7gcY0RdMK/V9+44b7Je7HpP7xKLn3ic3uE
    MEDH5iZvegAJXvy2tuxWuKYBXzpAAZWWxfCCB8mehs3g1mkZqPwezt1A7Y/WVnq3bKKcYi
    NMUwzRtoXLqZl4qF2MzpeEJptAauOqhHC5dyVDFm06tNLKSG1JG0djecL3ms2iTbgzLYRs
    YqjZP8sE3zixAxJES6DEDRCAlveJbJmDLXs3sGBGAZpw0VV2bzN/h/4DhwGA
X-ME-Proxy: <xmx:_2uMam_YGwc4CE1OKBnS8suxrLxRERDS2Hg9VQkY21JrLiUTZ09uuw>
    <xmx:_2uMaqi1Vxso9W2NEUIlq5WB9brnxpyjsQDYIWo6sPy8rPMdGVBhag>
    <xmx:_2uMalGouurkgQRNnMju3TP6imayTWeDFlssOLPcvA-IY9MfHUxqew>
    <xmx:_2uMah_MOIG7BxXPYA_TIn0r9K36bENK3gPDnxuWsgD1MKOPYShJHg>
    <xmx:_2uMaiuzFN0fQBoaBhhA9xOkhiMRglTgx5-r4dmnVsuzHnHzHUMPAsH8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 12:06:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Weijie Yuan <wy@wyuan.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Alexey Samsonov via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Alexey
 Samsonov <vonosmas@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] treewide: migrate from legacy utime.h to utimensat
In-Reply-To: <aoxkQHCGJENGxV2I@wyuan.org> (Weijie Yuan's message of "Mon, 24
	Aug 2026 23:33:20 +0800")
References: <pull.2209.git.1787322203.gitgitgadget@gmail.com>
	<aonIVn-ZQoMKWCAd@fruit.crustytoothpaste.net>
	<xmqqzeyeujde.fsf@gitster.g> <aor07LvsXOy1p7vh@wyuan.org>
	<xmqq5x10vowf.fsf@gitster.g> <aosVkqwcsmAWrDr6@wyuan.org>
	<xmqqfr04thhe.fsf@gitster.g> <aoxkQHCGJENGxV2I@wyuan.org>
Date: Mon, 24 Aug 2026 09:06:21 -0700
Message-ID: <xmqqjypfqz9e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Weijie Yuan <wy@wyuan.org> writes:

> What I was trying to understand is how that fits with the particular DCO
> concern being discussed here.

You may never be able to tell where the AI output came from, but you
can see if the updated code has resemblance to fixes we applied in
the past to correct similar problems, for example.  After all, you
yourself without help by AI can copy our code to your patch to
enhance our code, and that is perfectly legit.

Take for example 5fe676f448 (t1300: remove global config settings
injected by test-lib.sh, 2026-04-26) that added

      test_might_fail git config --global --unset-all safe.bareRepository

that clearly mimicked the tests that prepared the stage by clearing
a relevant configuration variable done in an earier 313eec177a
(safe.directory: allow "lead/ing/path/*" match, 2024-05-29).

By "sufficient due diligence", what I meant was that I trust Dscho
well enough that he's done a similar analysis to make sure that he
is copying from ourselves.


