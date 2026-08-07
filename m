Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5310838F945
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786101899; cv=pass; b=ZNiY/dG1/3rNpRoj1vUta4M95sk2lvsO6xzwMfM46c+rCsB+8hRpHLbTWIzaEh+JD8+9L9r9ctSbURcJcwmo/4jzlVesCQbeubSb9YoTHBW0Jwkzj2xaZk37e82RkWUNNY36cnvPndvVOuMyFMjWUaVYhllGSb4taITyqoUdRew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786101899; c=relaxed/simple;
	bh=gWViY0oWuwOt7YY1x41xLz3U3et3i/I9cGRm+e2L2AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUJ8t5K+kL2wXK9ZKVEd8JWqL+/aqWZ7NCkHECc6zCkr29hVAjBhVrlKagH4N69/hUAYDMt6DaLijUQeHDp4jX19pKMGbsxnpzXW0NKXdROEN4/VtiKKncHsYTk/j62675FglVRp0VPenQ7Al24659LA/0lo5Zh1i+tEjErOrcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTOM9ZfN; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTOM9ZfN"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf52d15d88so30344375ad.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 04:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786101897; cv=none;
        d=google.com; s=arc-20260327;
        b=T5KbnnJoIkbpenNhDbQj2VfcvRimmPwCYPp4r/Il+y9MbT9GMfAHoQsVEJmjxKb/y+
         dMl8JEsi/h7iwndawjW0oAnCZJbowDwfJgsHDc1uwxk763ptJFYA0/KRmC+e0MVsZkDb
         t98eLhiBFwswITPhbhh+FBikMUyLeG5YP4Ja8oNe7G2GneE9M8Q329kMUmy6Ok2aBN1j
         hbIy/Yx7dxSIUik7j1lPSauUX33UIQg46/7CS9502cw8nlGp8Zx5zUo+THswg3KUKt2+
         RkNHRQRimIDI7cby3pquFcjAMWocU3bkoyrruAFf0ElTaXzwqkp63b/ogIrPHEHUVR6m
         3ppQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=clgZ1iiZj5MaZkZQsvt/7Kv2BYpZVsUUPekpfBMJUI8=;
        fh=yuk30xaZd/QAqzU/pcMGNW/Dyvedn/xAhOKxTQzpzJU=;
        b=DlNJIPqPHbC8toAqRp1lysg1aeCgLsoeyQtvBR4YkvTGd9KGM3SamnzXKu6HTGy8gT
         DN8J4w1vKqSjm4CJCnNtTNQQGQg9Xc87OtvjUwXryGKas8yg0toHiQg1LR9PCeVt+Q1G
         Iwh31i+BRm8y9oEZNkT+H9vdCQDoXGOS+txJK2qoPcEIwvEEHErp9gE3fcf29d14uPQb
         UjdVoqE/sLIZFi3REpvgOw08bEM/ySyDRzC5ZSZQSNMcPLDFjKfYJFV7aYyzEXQ40fqb
         iZiO4wDU3ARXkjTRlokh4OL7Ihj+42B204JJwXrTC0go4LBnCE5h/XmT1U3uxqBJ76tt
         DPcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786101897; x=1786706697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=clgZ1iiZj5MaZkZQsvt/7Kv2BYpZVsUUPekpfBMJUI8=;
        b=lTOM9ZfNYHhqMoArie2V5qufTS36ApSYYDTRPgEw1jVt8rZCqh6OBDIh3WGSLeH7u0
         0V0kW8eZY5O7mgLW6RsSX3up96p38cc/9ConPdpMTpnaBiG7J05+FdkH0Mq56NDN6sey
         SL3aWpbI5EPx5EAvsq/uqd9QmQAm5t5NqV74pYLylq+npM3kosTf7QVLv20fP0qmSIYx
         vvqfgUnm/Ly9Rp77dp9DIF+Bdxk0xbMs4LBsAubfxIfmRfx3i9r747ICG/5DOVRv18Gi
         EGpDuNq5gOUChNMncSjsxu6HuSDjnNfGRmnV/LDQ18oGAOyhw/ir4R+F0TASb6TY7hR+
         SkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786101897; x=1786706697;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=clgZ1iiZj5MaZkZQsvt/7Kv2BYpZVsUUPekpfBMJUI8=;
        b=Stopt5BSqNH20r1H/L90cpjLcJyly1y6L3w5FcHkgIeDelJrWM0JpeQBD/GNsw8zVN
         Jh0vQf/sgRSBmRcJhSKTUFZbqt7eju9mt85PSkrmLLS7dpdJHqOALBwq/3zOhTfHM/ht
         REJNBArAvRAhtm8z/qGKtQ1cm93J6fz3mIjYfQdkpFOcVQh7qtgUad33RYfsmqTuh08r
         JQwCeHZ13vgUQilRVkhufZ7dB+O0EOYseLCKcq3pLNCD+CvD6alecASFbfhuE3LEu1wG
         dbUTgOxz3jz7BgZzqZPEk0gPxL3lgKo3U+7Rf5iXDSCWkQ686TO73h/Jzq7UbtyVAgDp
         FBPw==
X-Gm-Message-State: AOJu0Yw3kubAh2IUJXNhFxQrXrF2JhRAEMaygMPMmJrnHuiHE0jYYi9E
	lWaLwWLzkTJtDDbH+gcJmppacyYSDSSuN2JKGYbpdxaBY9wPz1INq2becElt5f344UKaTNhj/Bm
	DQEDm5SMG1k7njmHHgQxAnGvuxKQGBpk=
X-Gm-Gg: AR+sD10B9FmMcXTSuYw/DcrVwukPdrWVVundAVsv9BdM9uWYCGkfrrsQX88Aa1SMNo0
	G+LkK5JGBhKr1I/9rYh6l2/ff3xdxoOGowJGAOMFtcTXkf3vXexKu4hFHTucoZyFWq7wkL0m2NW
	sSCntn3YccoX4LLFELm2BWq/NI30CXvT/gUCXoJYEqzPoOPfj3FYhb+AhsF86WSd59nYvjB4Xi3
	fqOwY5wcxXoeHi/4dMimws+2Jzz6x40V5R1vPF/gzegsBGVS8YCJFyJ2kaXYJ9/rfcowhbEDGXL
	D/+vly8YLmscAX38NUsG1dh5xjc4JLJrvh8SDDLVvxd4qjd8SuDnjkFUxh96bcOCGTEvSotO0DZ
	rhwqTIssXxFUctsgMHE5IqeV00zuHZgHv526tc4YoEPoRzcXbNUkiV5BOBfu2/nGskVyWfE21Wz
	FBw7Z48v+3ub5mB8wehg==
X-Received: by 2002:a17:902:ef0a:b0:2c9:c517:d070 with SMTP id
 d9443c01a7336-2d0ca7afebcmr267953295ad.3.1786101897329; Fri, 07 Aug 2026
 04:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq8q6ih924.fsf@gitster.g>
In-Reply-To: <xmqq8q6ih924.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 7 Aug 2026 07:24:45 -0400
X-Gm-Features: AUfX_mwbFRXUFoaFks9Q4JsURaoup1qWEHv37xJGoMDQ0ixHNlPCvJ-eogDZyAI
Message-ID: <CALnO6CBu8ZBDk9YwLW2jVJtBUk1=pvai5QHiLN6XLOOL-3KA=g@mail.gmail.com>
Subject: Re: Can we do better than "git checkout/add -p"
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <christian.couder@gmail.com>, "schacon@gmail.com" <schacon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 12:03=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> I am doing more "git checkout -p" (selective revert of local changes
> out of the working tree files) these days, as well as "git add -p"
> (selective adding of local changes to the index), and what I often
> wish is to have _both_ as possible options in a single session.
> That is, the local changes in my working tree often fall into three
> categories.  (1) One that is clearly good, (2) one that is good but
> not yet ready, and (3) one that is bogus and should be discarded.
>
> "git checkout -p" is a way that is very suitable for (3), while "git
> add -p" is a way to deal with (1).  To (2), I say "no" in "git add
> -p", but there is no easy way from "git add -p" to say that the hunk
> is (3).

Not a core Git solution, but the interface provided by Fugitive [1]
(inspired by Magit) makes it easy to browse all hunks, with options to
(e.g.) stage, unstage, or revert.

(The revert command even shows how to bring back the reverted content,
in case you made a mistake.)

It's a bit hard to explain how this works over email. There's an old
video [2] which doesn't reflect many newer enhancements to Fugitive
(e.g., you no longer need to open a file to diff it; you can toggle
the "git diff" or "git diff --cached" view from within the status
buffer---from there, all the staging/unstaging/discard maps work on
individual hunks or ranges of lines), but still shows the general
idea.

[1]: https://github.com/tpope/vim-fugitive
[2]: http://vimcasts.org/episodes/fugitive-vim-working-with-the-git-index/

I raise this as the kind of interface we could learn from: emulating
it might be a bit heavier (a full TUI?), but is certainly more
convenient to use than the prompt-loop over hunks.

Best,
--=20
D. Ben Knoble
