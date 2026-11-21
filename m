Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795246911;
	b=cJC8AB1p2YZKTu0PnTQhiXBg94SySyPoOkfJ/MP8sn5gc1Ds4s/DJc5IeIP3V5Pe2v8a
	 Gw3EezkFluKNGbA746jujxNl1JVvKqb1+MGt0VheDu06dS/cf2CzKCpFoZ3X+u357A/aR
	 lrIYxArxMY4qMjNf70yTJh3S2VRrDhtKtfpqLuUtV5XIRwLrM/46uhhjOG9Xi7gww90G9
	 WRuKzua4d5aJ7aVJD7Y6gzFYu1XPegAK8XXJ9J3Y9HeqODCqaBZjA2LDlQPn0rAhJDIOI
	 QzcahY7w2v4APx8t2Ujh3QeLUqOkB09XEp8G6LkgEaojs7LJoOpNypln1qEzK5IciYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795246911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=f42NEjbvQ3IFTzln/COZlPuxJdKxCujNZ4vTc6Sm09w=;
	b=J6WVFXxpAFi8D1cqx5Onkx5A8tI0oblDrS1K2q9VUnmNUm/ebZhQUZ8RhWfzgJoEZMgi
	 DPpETNFqXBp04UI0NEIVDno57EHPUP6lpiUc/lOVO17k9ixYhLS7u6O9Jlf8jIP9OAkI8
	 etR5rqz6fUjcRbt+ZJYBVIdk0lD5g3ozBeeAvVLhVko3VbwdM0HQ36LX1p7Ejgj3vxi3M
	 S07W037ZTiDV55keZKZJEqDGBkJlSmsna2eIGjFbuVi2fGqr/9vI3lfxAYRzHrWD1imgd
	 73GtKIruXZrEzTvmKqbzfY1BG4V3Ud/evxwph/pks4TQolMgbhniLads03EqDPVkE0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i58UL7cT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20CD606A32A
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 07:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F20CD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i58UL7cT
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b413d04c93so1047872a91.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 23:41:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795246910; cv=none;
        d=google.com; s=arc-20260327;
        b=rKYQFkmGrjtRyb9p+jD92MfG8jJhlxA31MbNutQrqy/ypa+4RDNHxWUFv70rIrzaLI
         2tw8buqF/HplqJtG+NUYmtNLhN+PWtYdQazeAddi7pq3aftQeRvbeH7y/wNvBNNq0Ijr
         HTM9vRJvxGRIzizG2iYYUIwWwdu7Y29KKarQa3Nu+e3nkezuIK7HgdwWf+/Hzi5qWMx3
         3QJ7RBh3vqL1jug6Trl6moFyDl2OQkwIlnK4/ZyWs4m5bD5PhDziUTbepXveGpXb3N9D
         lIZrNrI4GGs3fDEVqZKFg//RfAIbtJmSOBgZdxSWc36/8KtJB/hWsSZsOzqydyY2df9J
         FMlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f42NEjbvQ3IFTzln/COZlPuxJdKxCujNZ4vTc6Sm09w=;
        fh=UWhsyynGaklnja/LJItJYSfbVKtcFOjUNSfReackNqc=;
        b=kVwCBZBCVXt5xqUM83FwQoZ/O8aXMrKhDQhDCskMg/UxZWrg+8I4NGACmG8PZi4Ww8
         WonRqV3lKW48X84zkg4EMYGignyqmWFYBbyikf7jASR+NnHdiWKiXDTlkCWcXB7Vh0Do
         XnVde/hIsa6Cy2GtkKpOjYumuK6NwmKHEeJSvZfAXjCZefiU3X1iiShggvq9iQY763eD
         MCk49sBou/4BhIORj7qI58YO0oTXP1Vh7sqt9lL3DfpVX12XCgJ/njk0db3aLQInyHxK
         VVqs5vHOENUfbg+ddKy+42GwLkLw2P4wYsJJI/r2TrhtPfT23oszrZ6LimzIvclXLoeR
         xD2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795246910; x=1795851710; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f42NEjbvQ3IFTzln/COZlPuxJdKxCujNZ4vTc6Sm09w=;
        b=i58UL7cTUwJoS7EtOvyOzBt9y9svCOhhrZllqPkRym83JYRZrj0+6YeQrXd5vkqeNE
         E7cD4hhbfifC22VuCWT57PLhMufY6o5skZajmXo5W5651f0yYVzgqNYsm74XkS48r5oL
         ZyuY636R1rC4uHTkyVfsWWCcJNXRkRpRriHuW5neBjErq96WgA4a6Hk8AXrdi2ZkhOjh
         Z3wZ1/9u/Db7pm7vz6hxHyauq+HmtIMsecdMSNS9xbTgMGYpIgimd4lk6+Jiiqp6utvy
         /F3mUdLfD2Yg2JOUHv6x1I4Vf9KOcgi8a1HiycVWBLeie7WuBZwUqWTwB1jio5XisNgg
         WOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795246910; x=1795851710;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f42NEjbvQ3IFTzln/COZlPuxJdKxCujNZ4vTc6Sm09w=;
        b=x+JNwcSttv3pNlxEXlUn3AW81R+LDJnOX3SMUKewJx2fd8TlzWxkgQLffbXTAgVfjO
         4BrRnb9B6FiuopPCH4BdruAAdcOcfj3mE/Bhih5sIu9xfzcUB68YJEIz7GTmoXDKw5/i
         8It7PU03VUT9TgJpJ/BKtf1YHd77jHGnwqPfmBlECJnYl7rnfxyJpt2tWDzUCT8Gxrlb
         fqWnaw79tLqI9vS4j90v7i7v6rrIis+F5kjq7LYfLBG7bmK4NeBRNc+JN42O/UOvyP6M
         jyoHlScG49V1QxAGTAZmrdmw2ybkjGfq0Xvhm1edQoV5gnpS79HAHSCEqUxQ7OUjX/a1
         KWHg==
X-Gm-Message-State: APuU4Z9RTB6hhYH29vQXpx0RYhJy0AUyTyAhXbdQngcAlboJ7MtoZxyH
	p8zzfLE7uCtj4VT9JNLQZXy+F6i+HkN5TIwZbO6+O8shP4HLTTA3pkAlrUECQpEpYOpAb4AdSDC
	bWwaKYrAt6p2myicaudb/SDsfHoyqBpc=
X-Gm-Gg: AZFdTZf0I2E9Zxy0puyWvcJWBXXJ6n6GAkiCxJsxoj2EQ7TBOJWH4pEP94MR194L1Y6
	uUzXrQUSAsGtCm1sZTawU8+1hWKLtltKYyL6lqbWYTNguadYVFq1LeB15lSSUNjtLTuE6/xxeIO
	WSKfn9tiIR7uFAxctA7cUZpGEWHmVJY+Vu71lDuHPw5946Qj8lCvMvOEgH032fVUu7hBXIKbEJF
	l2LucQojVLxORm87OjpqlGVgbqiwqVcu4yjr9MEz9uTNSzXj/xU8q5r4+HTZ1Qkcbu7oyl5+L4o
	/YzgqJcJ2Z53mbNVR6yfjo8CvE1brXYAv/QbeOuInKic9EFzd3XEE/DmSrTyd4voRxJhs7emTXP
	Y1wCW6dH5mfbyo6DqjVjffYPJ/tF10nNXj3X4cL0mBWErxeHAPoaZhIKcveX2TKXniax4MIY=
X-Received: by 2002:a17:90b:2c86:b0:3ac:9c37:9430 with SMTP id
 98e67ed59e1d1-3b41c9b2bbfmr5367380a91.21.1795246910276; Fri, 20 Nov 2026
 23:41:50 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109113515.198671-1-husainsitamuwala21@gmail.com> <a7ea1ac5-bb63-4bd1-b3b8-a6c36d675988@gmail.com>
In-Reply-To: <a7ea1ac5-bb63-4bd1-b3b8-a6c36d675988@gmail.com>
From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Date: Sat, 21 Nov 2026 13:11:39 +0530
X-Gm-Features: Aa3M54qbdEJVGO2jsI5WJ5jEHEktSLJCP9a2B2XPVJbL8c5GEvtMnJV3BqOLDDE
Message-ID: <CANRKfoASdPus9ODkdAqCY+zF7gOh7-paunZf1ze0TFGM1z9kfQ@mail.gmail.com>
Subject: Re: [Outreachy] Proposal draft v1: Implement promisor remote fetch ordering
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Kaartic,

Thank you for the careful review, and for pointing out the unclear
parts. I will fix them and send an updated draft as a follow-up in
this thread. Replying to your comments in order:

> It's in 'next', not in 'master' yet. The application page asks you
> to give the status the way "What's cooking" reports it.

Thanks, You are right. Section 2 now says it was merged to 'next' on
2026-11-12 and that Junio said it will merge to 'master'.

> I think linking to the permalink of the cover letter would be
> sufficient in place of a thread link.

Will do for patch 2.

> I think these are in lazy_fetch_objects()

Thank you. I will re-check the call sites in the source and correct
section 3 and reference [5].

> I would've appreciated a hint here clarifying that D1-D4 here were
> referring to Deliverables mentioned above.

I will say that each goal G1-G4 belongs to the deliverable with the
same number.

> This kind of reads as if the way in which these are implemented are
> already concluded.

That is fair. I will reword the goals to describe outcomes only, and
mark the config shape and the protocol field as open for discussion.

> This has a conflict with your preference for Shape A, doesn't it?

Yes, you are right. If the server's value is stored with
storeFields, it ends up in the same key the user may set by hand, so
the two cannot be told apart. I will rework 6.4 to keep the user's
value separate from a server-supplied one, and I will also drop "fits
storeFields" from the advantages of Shape A. I will leave the exact
keys to the RFC.

> The discussion about this is rather premature for a Outreachy
> proposal, I would say.

Agreed, I will remove the draft documentation and error text.

> It would've been helpful to include a reference for which "earlier
> review" you refer to.

I will add the link in section 7.

> Every new branch must make a test fail when I break it on purpose
> ... Not really sure what you were trying to convey here.

Sorry, that was unclear. I meant that for each new branch I will
temporarily break the code on purpose and check that at least one
test fails, to make sure the tests really cover it. I will reword it.

> I suppose we expect this (patch 4) to also involve an RFC rather
> than being something that we already concluded.

Yes. I will make it clear in the series plan that patches 4 and 5
follow the RFC and the design discussion.

> I wonder where the patch 1, 2, 3, etc. are coming from.

They are the series in section 11. I will say in the timeline that
the patch numbers refer to it. I also noticed that my intro says
"timeline (10)" while the timeline is section 12, and I will fix it.

> Whose patches? / This should point to a review that you did.

The heading should say "My patches". I will fix reference [4] so that
it points to a review I wrote.

Thanks again,
Hussain
