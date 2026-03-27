Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCFD155C97
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 08:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774598862; cv=pass; b=XPkSAIvNE4eXgCZZErzoX4XqxWxVNt7/SBSm5YL3P4KPAPvTZPgHswkULNEybDXvxnvz9wyAQBpA9jO8iwc9hCVBiNh4rqekD334zN4+MwzmDJboLBEA5oXQ+UmcOl/Sv97nc40EHLZwQy7AGX3S/9W2bpIofGF0Wiy/abfhavY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774598862; c=relaxed/simple;
	bh=maPKPKyP18ELDxtLGO+/eODRtVw2hjEwHvmOuv2JVg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3YTDYxBu/g9H8ZtdsJDEO8dWR9o3hSeg/iZPHRUSWowqhN+RxLF+4zAC5v3JywXmDMuVyC6GuWrj+MbgwnbaK3sEGyIku6SAwzav4mLnUnati25piZLlejZWp1x/i9JeIRJJEweEuE62wqmhUUE27P0z8j7XvawAPcsusR5XjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IR/iVqb1; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR/iVqb1"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4e9694so603871c88.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 01:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774598858; cv=none;
        d=google.com; s=arc-20240605;
        b=DWMKV1SDmrrOVf/gjKzJJkO0261icC2rAp5G2OA5ix4QmfMWvqgIsiLJeTutUcT2NZ
         yWplELhzz/AldkiTzo7CrpW9/ahk0eZ9+NsALnozu82zWpIYosigrv08cXQV0Hy7cElY
         le4F39Ce9+u+etIu4VPdn40bDE8P3U/OJkQoDUFwOTsQdPbe1DCJApR3/OVye7jzFGh3
         3hskwI8NZZfyUe2EmTdIFNJJVcQNvKliJJ0RNXmRBuhyoRxbQ2/rW3jZyoWSkgEGTL5t
         rSNRSaGFEfgTL9EeWI3Ti4pLCQw6eHBdnCY6QEdcAhgUoOCeEgt4Cr48bKpn4DMzrndK
         +LEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8PTfWhrAWkKHBFFJYUCPwn1b8Mo6A1LbaMNS6IB0VOI=;
        fh=enNsqV2a4HGIPorBj7tfu9+cMpFZ3TdhURhIT8PMJm4=;
        b=A/atmpD07Bg82saqAVPNOQlj1+Cf6crb82PrvhXqS+dy6Y+GjhruHW37MDfdftvZw8
         n1I2cImNZurLF+5cVtAhbqK+Knc6MqSb5p50s2ySTegqyuMjovXX7/wDweIBkpUIaFXS
         uuV6GCnXuZincXjBWB3w3Mmcgm9V7C8mJH3EWSqzJR0kouSl0WVf6B6db94x2/7fkzPN
         0knqkcG8hTmyv48HT2fYngBEW+8+WXV1ezGzkTs/p96JrPGLl2B/CC/8oFUed12aHp4P
         0GCtlIENqTMi1hMmhndrdm5HX6hEo+dMwBTiRk34p63Pu0cF7g3OrhYevJOMfMpHfwF/
         WIrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774598858; x=1775203658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PTfWhrAWkKHBFFJYUCPwn1b8Mo6A1LbaMNS6IB0VOI=;
        b=IR/iVqb1Xyh0FPC2vViQ6FTAAWbL1YVl60qK1sqxZc8tP+IA1a5PiToSYRFOYW8ejb
         fe1ro4L4L4NwNcKTT9JeNRGGAkmr2rldIalKUq/Lp4d9/VGdhZSXE7UVJCRce0fVOeP0
         +nVz90SDgafWpttRlWUZY/v5bqMavW8eXb8xK9uDL2fcdaXpupgpGnAuRNofGq6BeqMF
         cddjBi2yGnVBmWfxisHNBYy/dfA+3x+TOr1NOPPkqSOIzPIagBh5qAfmavuGdbysFuxi
         omSi09FyvbXVYhBXMZ2cNxcVF7tgp3fOeY4/+che4SKeL5jdApRLJOm+6r93500TxsRa
         2qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774598858; x=1775203658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8PTfWhrAWkKHBFFJYUCPwn1b8Mo6A1LbaMNS6IB0VOI=;
        b=sZZGlnJU8BKMfVqAqZnFSEvt1aWXiXPAg/9XIbBpkFUI2U9aIVwoNPjZoyk+0uVcV9
         55KXHFAbZpqh1XT29STTgsXyg8wre54SSNLVdma1F4uGwyzdRgi37agI+/y8621JNuv0
         +B0Q6sHpl3DGHJLCFnZU2BafC1AF6KuL0aBGlRXsBHOVFS0y1bROWMed2QIXl54mdZ4o
         8HKtNFjwUfv5rVFU9VGiDO5LFUM2OqPQMTf2GAxbJDlA9Z492b0T87+oaviqcIulphSS
         /xwM5pM+kyDbZrb70zq2GqYHHNlukbNw9C1Kz421r+TcqijgHgofOijr47OqDa4Kb1vh
         WBBg==
X-Gm-Message-State: AOJu0Yw/DEY6jFR8159YZBYKs5SrOyqA0cRPDcSSnBjEljdM0ysyUiYj
	DQKfCNizNllzfASG+rMfGtDS8TUm/uwnddOmME/8p3Zxl5xplGOYQjNjIplsrxTDitsvXUFd6hj
	JhXF0rjFjZsGAPNBVkX72w+OIFGCel2Y=
X-Gm-Gg: ATEYQzwdQTqBnBlAPNJ8FM3xy7gWQOHZB9xcTAMJu9hZMtFnt8sBhRnES+V8Q5eg8uo
	Hsc0cHW07kmUL86mLFlqs3wY1cd8dKlywgoSL4xtUxew5o54ENMG371HU34VvR/wJNEKMHHJLEA
	8yJ/L7G+1JQaCdP8gSr9DxrxpbtksZA9ePp1SgKwTVFejwRkfdbNRg2964RTTHpnMXNoGFGZnDR
	v5tRGWifiKwBJGxUKEFvR4Bb2BrdNOW8fd+bOgfTUSPHp65vvwrnx3nZAa6WyfWiaJBsQTPH5Us
	wK3j1ncCLVni0lerbfetE/0Fqdd90TJ3P/aXsPmWj4elpZ4R4bHkFfi3IDJiV6ENrpSF
X-Received: by 2002:a05:7022:2385:b0:11a:61ef:7949 with SMTP id
 a92af1059eb24-12ab2857bd5mr843506c88.9.1774598857939; Fri, 27 Mar 2026
 01:07:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq4im2npv2.fsf@gitster.g>
In-Reply-To: <xmqq4im2npv2.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 27 Mar 2026 09:07:26 +0100
X-Gm-Features: AQROBzASvTwZOmlF_9vEl_zTG0MqsA-3qphuQBfC3BIru-lMiPjtzRHhYxkGlKw
Message-ID: <CAP8UFD3kxL5xAcd2OBNmLFMdBaRLgB0WKtvSkuO2m7GP=kZK6Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2026, #11)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 12:17=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:

> * tc/replay-down-to-root (2026-03-24) 1 commit
>  - replay: support replaying down from root commit
>
>  git replay now supports replaying down to the root commit.
>
>  Will merge to 'next'?
>  source: <20260324-toon-replay-down-to-root-v2-1-34e723489f6e@iotcl.com>

As Toon said that the silent failure in case of "topic" instead of
"main..topic" will be addressed in a separate series, I am fine with
merging as is.

> * sa/replay-revert (2026-03-25) 2 commits
>  - replay: add --revert mode to reverse commit changes
>  - sequencer: extract revert message formatting into shared function
>  (this branch is used by tc/replay-ref.)
>
>  "git replay" (experimental) learns, in addition to "pick" and
>  "replay", a new operating mode "revert".
>
>  Will merge to 'next'?
>  source: <20260325202354.10628-1-siddharthasthana31@gmail.com>

It looks good to me, and I think the v6 properly addresses the latest
few small issues that were found. Previously Phillip also seemed OK
with merging except for the issues that are now fixed.
