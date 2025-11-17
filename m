Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D1030DD14
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763409137; cv=none; b=Byi8UOvZqC9tbplJdlF5elbE6OtTMmN9jUg2adU8IRREOQU0KFUOVss3hw8Hotv7r6do+/bAy1NJvlWNjSxUOUOeS/fWpITMiIqx2tSpRZnpzvWkLrdLLWVEuw5e7g2BgkJVyWrkQGjrebST3LeI+bxc5KnISM8h/6hdNa4Gdh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763409137; c=relaxed/simple;
	bh=bzETDG8GIU4+DwEddImnQeQCEBiv1U0bXnA0HxbL7EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjKBt6JfxptaU9a/i/K9qskEF2WiCZ0urz/vh6727jaZa8jR4nsPcAoP1OsxA9Ytdo435Xks1lih5IxfgiuAY47WadvaCIYGzt5MDT/ItuIhgSwK9Nt4uQM5yBoZa0lO4vkOdAYMg9VwURuRc72PApgoBm2KQgtlqqQFdifJH0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDktucZI; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDktucZI"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-9491604d00fso28933939f.2
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 11:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763409135; x=1764013935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubi3pnq4fMK1jbHE2wGx07Gs1M5y/WHBtnpM3N28xYM=;
        b=HDktucZI2sECWDNg3QYC9G1DGkUJ3tRws41+h3Jcgd7r4ZIRZVl8YuhtEQ2uKTPTT2
         5Q9ZCy7WG9+0micjGWZKFF+oq+cHe5PCTIYtz98QenWCZZvG56i7MiLAM8cxHHWHybdu
         52JTYeQYQWYdK5rH5YYppMMNbqNfqtcbUM3rBjmuDs5aaKmQG5brfJVxbBKswTzL7dnd
         gAeCohZyBcqYu0tEl0wF3fiL44g6HmHys1V9Q/1MDWusOipZm2fZfhfQADQAltih+liN
         sswtTloJ0lb/WDDeGH/VGmLDlTuzF6Lj0iYDdguBsJdBN/DHg4+MsGkMu8/hM1e9ZHpC
         5A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763409135; x=1764013935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ubi3pnq4fMK1jbHE2wGx07Gs1M5y/WHBtnpM3N28xYM=;
        b=bcXsorddbBibdeAbKSyrdvsEUG4GUtTw2BEQWg84dZ49TcyU4K0xY/Ex8kpi/xx1yd
         Eq3Su5Pz0L6PuhwDcGLD24YbuEm/xTtsznUphxK5pBxbTGagfc6juFhYO3L7ITkwE+7i
         OrpO7bo/PW24j/iNPdxpUG2+NLzLtNBhvG3xlYwK22BYI/84SrUZ5p45skn1FTHn7HnX
         /2YnoX5sYf2w9RuJG4Vngm57uf5lCDNB3V1MfYZ0cHt0t2GNUgqMGDlgjxYKC4Tkp0sw
         zkkOEhZVX5lmAavo6hc0qmr3IQamw5c+7xuUWwSYms7L5ml7pLVRivxIKetEJ0hn1pUr
         EwLQ==
X-Gm-Message-State: AOJu0YxlenbKRldJVO+OztK3++D+lcy6EoWfas6C4YSRp3Sb1GDtwN6l
	MuE9jpfbZedLDNGb4b32C5UDGPIxEMsU7uD+09RZCZ6RqGrgP72flAHXAajlEyjhC4q++x60hD/
	NvhB8bq+4ZsJ7MgPVUgwelgFsulpQ5Og=
X-Gm-Gg: ASbGncvxkk9CprJmOpPPfzj32uEqSSeNj6SqCQ0iKyD9nlOaBbN82soIy7GWJG082re
	MwZsbVP3oqbYtz/CAb1J1NZAnT5d3s3lKs9rig6qlyVLQg2CwMPZ9JWN9gApQ+78yDzVvkF/C13
	7gNFl9ctFKjTeZ9Lr/9GhjOWaFJB6M/5Mk2m8UtJKnO4fwjZdZtg6Szo2nNcAakhpgHltTTylxa
	mdqQi7e9fa0NLz040lY+hTsHa+ToJb9xYxrlxOD6KmCt1bMAIhxNHzOHPqMBgDYZYKRcTZepoDZ
	dGSbbY6F6zuIQKvB6a7pFIILix4t
X-Google-Smtp-Source: AGHT+IGKmx2sKWY/YE1qFyUQmZwUzMTndkbazVVqFl0xrkigzgaG2ZzROrye8V4VQwKiVt7SJVRA4dl6+Pc9GfAVNps=
X-Received: by 2002:a05:6638:6347:b0:5b7:1753:3aba with SMTP id
 8926c6da1cb9f-5b7c9d5ad69mr7108820173.10.1763409134795; Mon, 17 Nov 2025
 11:52:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105061918.3688870-1-christian.couder@gmail.com> <20251117043450.322644-1-christian.couder@gmail.com>
In-Reply-To: <20251117043450.322644-1-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 17 Nov 2025 11:52:03 -0800
X-Gm-Features: AWmQ_bmucbqRGG4BHl24T4CzHie5labrqWEGUH6DS20NvWRjKNOsRPT-uMf8p9k
Message-ID: <CABPp-BHY4SLmWY=V5aHJ6igN0GWeg6V1MoWDwszPe2O38wqBhw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] fast-import: add 'strip-if-invalid' mode to --signed-commits=<mode>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 8:35=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
> There are no code changes in this v2, only commit message,
> documentation and test changes:
>
> * Rebased on current 'master'. This avoids the need to mark some
>   strings for translation as a recent series doing that has been
>   recently merged to 'master'.
>
> * In patch 3/3, improved the commit message to better justify the new
>   feature using some sentences from Elijah.
>
> * In patch 3/3, removed tests with dual signatures. This avoids a
>   conflict with a separate series from brian carlson that adds a
>   "RUST" prereq that is then needed to run tests with dual signatures.

I'm a bit surprised; from
https://lore.kernel.org/git/xmqqms4rry7f.fsf@gitster.g/, I thought you
were going to rearrange the tests to avoid the conflict, not delete
them.  Are no tests of this new functionality needed?

> * In patch 3/3, improved documentation of the new option to say that
>   validation behaves as the validation performed by `git
>   verify-commit`.

Looking over the range diff, the other changes look good.
