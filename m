Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735558;
	b=st+GZcB9dzfIYiHQFOkv0DbxUy3Tt8QEq3hzLQeokewIS5v4NbrnIADVSP090ZHI5Ntf
	 EX5pJz3waV6HFG3FgIstlBuWTh4kpShn45N1lQm7FRkDC9bstixD/LDIh+oGP0IYYXFL3
	 1vO3SgCNNlqopSw+pzr/KRqyCsvSF+0VnLxE6vqJQNH8DAOyyz9hAZYlROELo1fVnAe9C
	 iOIflehWCruJAgfRizdTXSBC5Pm94Voy+iF+17L1Cd3QplwRxcdQgYlg0dlROSba5g+op
	 w8M2wK/0yNogo2BmdWMZmgJ06anCu3hbGOo2++T/ccXTVgQFjO8oFamT8xe+qy7lK/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735558;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=QkYRjp8bWcmt848iYK+tHWKlbuyS1cFFiiyAkCbhLD0=;
	b=PLK+XyVAUp8jNBhG121wgA+VIpABgqzKKrNmxVShFZFOJV5amXyNAbccrCAHg9nz3eSB
	 Wy29HCT3XJvi08khiO0nVyVF8z8N1qFvRZIXWttq79MZa0cvWFUeVKgmjS5nKPxg25Zq3
	 SGp90YEdMdghZaDHOXYz+nWIOk6QQ80MgmVL8DUjR0KugWBpAzA6pKQIaIHtYm1rrnBO3
	 16acVaMMCrg3KDzpQIezzvEaFtHoCOKbMu8bAj9RIrViLqLAFqbyQ8NSNrQzhNSgJbLmR
	 MfZZGVHNZybe/tbrCSnqaBN7zeAswpJSZd0MYeCFjTysX+HjzrmlBv2kXx7rTK+T5Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=HOw1W5TF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jcvE0F1l;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357AA606A31B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 19:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 357AA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=HOw1W5TF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jcvE0F1l
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8EE7F7A01DA
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 14:52:37 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 03 Nov 2026 14:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793735556;
	 x=1793821956; bh=QkYRjp8bWcmt848iYK+tHWKlbuyS1cFFiiyAkCbhLD0=; b=
	HOw1W5TFI8W8MGwFtv0v57HL81/gLVpCDvV4kxN5273JHUhA2XZHlnL5mk6HqSh1
	fYFkUZSTEJUUfi52MODjmNUAniVIGUsHFrmgNLeJhQwTCGO20lZ9ncp1PPUD25mU
	8MDCLga62xajkd/NlxjssLhPf1jo1wrKkYS+hpxHq+hlQFpJ3lUjXVTE3CE+MYxt
	SFsv/ouM9hOR4gjmgKA9g/61P0Xsn7Lc7WlLci7+I+4+6i8L5i1kel+bwMRMsfD4
	mOJBHuFr9GR9IfHwgs7PKoKGtx0vuf8CETUvFrUc9AChP2x9hFG3X0VUzLuL5nRy
	06iyXFLbzxWxUwkOKWhU3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793735556; x=
	1793821956; bh=QkYRjp8bWcmt848iYK+tHWKlbuyS1cFFiiyAkCbhLD0=; b=j
	cvE0F1llt4M+RLUs6yIb8I8cv7ywji5dC3wqDf12ex/uY6Q/cFWA0bX53Iq5/hid
	ym0dasNHV+dWbYJiWcLmWVKR6OJR5iOKrWUeL8XsipV29GxSuseMlAXX1rxd30SH
	UfQqTL5hjKBEOHV7GXpAwZVdTC3Wuhe80X6t8R/xHONXAViqMam5AQBMjzRemL3K
	6AD5hUGBHpobxMksmsahBpU06SVfUoDu7m6xsiXJmjRStvK+gXCtlYh3Qc6zOMVZ
	anyl1Zha9jhFqP0h5Nf9L3W6Qyhl9Df3Vm9ob4ibHBP6TC6znGIzjUsDtwB1EXyO
	H1vA7eJXWN87LkRK65bXg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793735556; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:XBFijJTMt0Bd+6dC445swGERZP2EP2+9VFPQHXJF6kGrCX3
	cZVxgRs0wnL5+sXoZXwOMpQRbkxre7NjFDoKXdC7+BuFNdYc0zCqJJSy3iCnqWS1
	uE6vzOlJ6MIrlHiWPZxugK8x1K7Ba4SNnHE7u+iTm3EsrJ5TAJx+7jysuTytJ/sa
	y/axfsCUcA3JvVHlNqCStg6DERNFBBiOHVBa81JJCpWwCwyrA0FJKwe2MfSbS7/1
	ZVeFbE1TltNVS3EC06U0TLu2FldDU5cw9etgIQHn/CRtMpUvFx8CDS/1CKy+oSOQ
	nJDCLYuc05obwVPQSjCo3LyzQQiaKHx5We9jAvg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:sXCBN4UQoqGOxcDfbi4NIXYIFQLFfStHc6AzMTZxwu0=:s7Ub4GHZ8RGKzkY+ydwYeLkhIoUH9MeSx2C++pHKMn8=;
X-ME-Sender: <xms:hDvqajiZsgG-q-_VvBw3YD9c0ghxKwXZOKFmVq5VS0SejDEnBdgdtQ>
    <xme:hDvqaq1g4tn6rpXixYSzSU-VejGdFXYTjSW7KYF8ICYVwJimbHJJlZ8DliaJsUQsR
    kaIIb2UATP6ryTA_Q5-Hyvp22plmyTRHJE_knnPVyVa5lZh_-nFn5cc>
X-ME-Proxy-Cause: dmFkZTFTQYYG123ajYwskh2ANxJEgS81wp82rfFA9ed2K4flhauXpCzWMYpcu6L4tL9u9l
    6NtNnIw1JPXkAbhV9+8YP9d2x/F1CP2LmkkdXaH8uZYHO7VCyuYNdasij7gXAWCrKsLdKq
    ROkpioLFe3LWR85vqt6G1kFSHCIj2Ys256r46t3/ZdtZWD9lSLaEq9Ie8K7kOK3JqdW8+S
    UKAOXT7ZANy65HhsxG5leSbCySZxYcrjFKyOun1MHWCBd8CR5tDbs0NFsF2uy24OQ/PZMO
    0WxAk0T4IzZmGRG7jW0iHYs6W/YJdqKtjGvzpfwdHAv9MdQNVzAC0bYty9KnViT/7sGNbZ
    kFWshwEFOZRYVBSReUqU4BHW4bIh06kJ/4dkMnwD8EkHXiicpV8GBHe+vCRn0nDEcQote7
    AOqg+xuDmsa4bspowotCon5BJ8zvRvJVJuDymeS5VwUHNk3Hl06DryWHATqXS5TLl6Qhdj
    +6gEbqskGt5ryKI9lcbE6zGuulkWRgPYHU1HFlUj67X0SX3QFldeFUDMGaHzgeiAiEy0HO
    LpQ3UrqRcZfsNE42XKmt3e0OsOiBWiznJ/hWOVPGdK1rYIAq8hBL4w4UFN8HhT6rHkmyGT
    EBI4xGucaDYD/4mtMZGX7wxLqOeDHx9N4n49SILz/kOQlycQD6SfyJG5Elpw
X-ME-Proxy: <xmx:hDvqamIHLe3MrUNRz222qwWF4kQ0L3TQt1EiocOiBqeZRXoJJS767g>
    <xmx:hDvqar8-RhRZsq5UcxxGUpPiiJWvLcJa2AOlkOMAY24lTkBb5EtSTA>
    <xmx:hDvqahKHneUphcCaUj2RaiU0N8OSLFggfSheymgWY_DC_NHQFhj2zg>
    <xmx:hDvqaon8mrp6B8-pKikuKIrmcNBs1B3mtzqMzMzg9pmorECVMw2vcw>
    <xmx:hDvqats7fW6RARwBHU17vRanTQdT2CyJoRvlnNuIa_JVWgOM5qhB_Zrm>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C5353782738; Tue,  3 Nov 2026 14:52:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AEuMsLfrft43
Date: Tue, 03 Nov 2026 14:52:16 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <9a6ae876-78d5-4513-8c75-c4c071c3db6a@app.fastmail.com>
In-Reply-To: <xmqqbj857l9r.fsf@gitster.g>
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
 <xmqqbj857l9r.fsf@gitster.g>
Subject: Re: [PATCH] doc: git-diff: rewrite EXAMPLES section
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


>> +[cols="1,1"]
>> +|===
>> +|Show unstaged changes
>> +|`git diff`
>> +
>> +|Show staged changes
>> +|`git diff --staged`
>
> Do not sneak this change into an unrelated "change the format to use
> table to make it readable" topic.  Doing this change to just this
> single example would be a severe regression.

I can change it back, I didn't realize it would be an issue.

I changed it because several people said that they find `--cached`
confusing and that `--staged` was easier to understand because
that's the language Git normally uses in its UI when talking about
staged changes.

> Look at SYNOPSIS of "git help diff" and notice there is no mention
> of "--staged".  The description on "--cached" explains it as a
> synonym for it.  If we wanted to promote "--staged" (which I would
> not personally support), we'd need to do matching changes to the
> main part of the text.
>
>> +|Show all changes since the latest commit
>> +|`git diff HEAD`
>> +|===
>
> Yes, as you mentioned in the commentary, loss of AUTO_MERGE is a
> regression.  I do not see a reason why you needed to drop it?  Is it
> because some external limitation like you cannot have a table with
> more than 3 rows or something?

I dropped it because I wanted to start with just the commands that
people said they found useful, and it can be hard to introduce
too many "new" commands that aren't well-known already.

That said I think `git diff AUTO_MERGE` seems useful and I'm happy
to put it back.
