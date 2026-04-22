Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBC21A683E
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 01:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776821879; cv=pass; b=VncNxmqP9Purh/ZKaJDkP0u7vqCs9cvROETdONY0sissBjlhn5xcpAkhcol9aB0V5+SIfk/fN9noIjLQe3Atxh50TzAAUEn8x4zAFmNZ+rahOcevbHVl5PPOHhuaBWyTCdfkvQVjmXO14kMvvG7DgjOJStTqx07JF8Prz1Z4s2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776821879; c=relaxed/simple;
	bh=QbX3ito2/PHb5BGBxi7njse1rHdbSfzi2NjazHm9hMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfihkdikDIH02aSNGeHUU0GVmmzE2gUCIT0V83IBGzDt9fTASWCgdHN0IrAP9VrBKIpwD1vi4hnkAoHo9QBzwtgq0e2oeYnGlJUO7eib33/39KhhdrdYq9D8wgukhYPRFXFpQe9UYBOXHs79Hx0jyJcLbm6zPr+sb0czzrkCul0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5JDzZFU; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5JDzZFU"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7dcd17e19b6so1190170a34.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 18:37:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776821877; cv=none;
        d=google.com; s=arc-20240605;
        b=FPYq7vbSZ/yxIyYD/vlPErBCWsl9mdDhwjDMzcfrNlVYXPwn0fycMAaP1GqPeP/z9e
         OKkUceCDL2T5tPrjDj+ut1UEV8AcUHRip/xrRjtPlb6xVIU1JrGYnYEveIbDS+Uc6c3V
         8YvDqmxi2RlpLbFcEQ3sBUdzhHp3CT4jaNx9F0C8fVcEVGDSpFs2r/oXuD8YZxxM9jvX
         Mp1ry+x2GyU61KeClmCDv8dQ4IApW8bC3Y7dvcANJ41xwWi+qYO59D9XW51XPyBLxKa8
         Mn0jouqEQCx2rRHsQ/NoaPXE0gcc06si3K4inCLyblfOmIv8RPVneHRGpVpQ8PMMpkdy
         FJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7/GxX1A+7Jeo1vjm4V/ZbZsSE2q3CftsRAp2dM+p908=;
        fh=SlejNgZhDGxYE3RoeDx16OjaGxHLTwSxXQ+/jdvn8IE=;
        b=AN3DLqZ6KeAsXdSMCT2N3pM5+d0Bz7+2lqDUQCfZoq9sU/LJmUmFne+CVzl7GS1fqB
         BlgcQlKj/+eMEbJnDmzIv4TkjJNYPdkXF3cj21lLELG9PEeGaN3/WnyT18N+foLL3oXm
         6GjXtPHTO18fXlc6ks2ERX2C55+JgpIoiAZFh/th9DA4YNIfd5rwGmnunuppIXq6XYo0
         A9HQSYlP+a2H870sAmDXiNUlEIPy54nPKmoAAsJvGO6SPqR0+8JQWuHhTBv+l70G/dxm
         VY2/t042AavHtTcLmuVmI5iptlTiFdjM+2gVen/z8LkRx0JFynVrZ4MGcVsbSXazx/wg
         lKZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776821877; x=1777426677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/GxX1A+7Jeo1vjm4V/ZbZsSE2q3CftsRAp2dM+p908=;
        b=M5JDzZFURDD1DLcgc18QjNpeX4JLGbkfwgjIE3YTcT4let3T8pZJSmuxZeFwQnmGJN
         ED3xOoYlgRHfSP7pdg4cs9UUIqNzw2dprYVJRrRR3e08EL4uqQoiel12eoG7BEsydjTD
         s50wzRUMcoA2vc+z4wxmXPZ732DqQ/8cV7WAvPQf+USBlwYxHd0n/hn98qAI3+uZabyo
         2wGJCC3ksgvD4gzRfwenGN8IFo5gptPSDHVmQCRJlYn8Oj2icoPcykaycLyK7rwvxi8w
         5yVft0LgwH/CpWG+d+vJV1DL7j4eyHnGC9GfgRWw4L4sqq5bUDFT/UWnqVOQyKo1OKDN
         dfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776821877; x=1777426677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7/GxX1A+7Jeo1vjm4V/ZbZsSE2q3CftsRAp2dM+p908=;
        b=lr0rOBx7ajAMbY9Hwd5iMM99t8IFBB7JYPkf9xYYrrrmuSpX2IeF5pzC+hzytVO6nP
         QKRk7SQEWF+khy/UZmIO3Wp6HjpUoWKLxeH+5MEo/8h7so2cEHPy3HRg/Yl9tqxEDrDl
         I05emhT9CthLxxfuRaTZ09Xrp8UbbxjqBPMukwBUmInQSJBktR287Q24mNTqHVBFGEcS
         X/N9K7BwE11MnIcJmavhjB5MIADL7iIT1A6OzTG7L/bz/kHmC4Z5sT1yHGWJQfibCBHr
         Izl/FfqpAz4PgaPJwrvftY3OpPCBQOP//ILAV7XsB5frsZhSaqSpruYVn2EIzIXRhPU0
         sasw==
X-Gm-Message-State: AOJu0Yyz/uUDP1JPAVGhSpYiZ9Kb5OYUj43pgygdNj8VpmXfJcykmLBZ
	R8T+4y3Xun+X6xetAuXkiJ3Natygk+ibimlkuzrPxId+H718MAIccN7z7cdlTs5x53SnMeJrYDD
	8ILKRkIO8sdnl1falKfrJKZV51sjYwoM=
X-Gm-Gg: AeBDieth+iWoROqXrhWFMebN7yEFRKnoqC+j3Ucrair4Lq814KW3lgJyM4npOF8cZAB
	BfZC8ccnwFIy6D0wJ+YRy4hJ2iszJv6UvhnteYQ8VGYmbCu9xBPAFG5sjWOkT7GFUyehdX6+YIr
	6fZu0dKjcWSexYw7P+FIhYt1n0N6qKjPtfZjgcpRCn9kJT53goiSkBUW6tWNDubi2vsjVyBm6aY
	eOebd3sKhIgmLOkjmqyYi0JLDZjFx9cV1S4ap2iEAF1w8SOfXEVTxiP31mZvDzDEZXm2aSG1gFt
	eJYv7ykNQ4g/Fi8i61igdMBbIwYM4AyqKhi7wQc9KF77EqvZ2t8nsyUW0LIPgkbbto2iNnWqvub
	x+Td6U2hL6tMUbEhmo6VfcWEnSndD2Ludjeibrg==
X-Received: by 2002:a05:6820:c0ce:10b0:67e:f8c:6bcc with SMTP id
 006d021491bc7-69462e64b14mr8263331eaf.19.1776821877407; Tue, 21 Apr 2026
 18:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776124588.git.me@ttaylorr.com> <cover.1776801694.git.me@ttaylorr.com>
In-Reply-To: <cover.1776801694.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 21 Apr 2026 18:37:45 -0700
X-Gm-Features: AQROBzCs_bVDmYsxo3udND5DaDSVrW5beXlvJEG3mIz_Y4WI9ECn8B6RkQQtIYI
Message-ID: <CABPp-BGkfavqezk2SV3+K6iF8MLm8j_=ijHiPDLmv_U_o_Ykgg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] pack-bitmap: fix various pseudo-merge bugs
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 1:01=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> [Note to the maintainer: this series has been rebased onto the current
> tip of master, which is 94f057755b7 (Git 2.54, 2026-04-19) at the time
> of writing.]
>
> This is a small reroll of my series to fix several bugs in the
> pseudo-merge bitmap implementation. The main changes since last time
> are:
>
>  - Fixed a use-after-realloc bug in the test helper introduced in the
>    first commit.
>
>  - Swapped the order of initializing and cleaning up repositories in the
>    new test scripts.
>
>  - Updated bitmapPseudoMerge.<name>.sampleRate's documentation to
>    describe the range as (0,1], and added a new commit fixing a broken
>    example in gitpacking(7).

Thanks for fixing these.

> Range-diff against v1:
[...]
>  4:  af9f651269d !  4:  07f70a07c20 pack-bitmap: fix inverted binary sear=
ch in `pseudo_merge_at()`
>     @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'apply pseudo=
-merges during
>
>      -test_expect_failure 'apply pseudo-merges from multiple groups durin=
g fill-in' '
>      +test_expect_success 'apply pseudo-merges from multiple groups durin=
g fill-in' '
>     -   git init pseudo-merge-fill-in-multi &&
>         test_when_finished "rm -fr pseudo-merge-fill-in-multi" &&
>     +   git init pseudo-merge-fill-in-multi &&

Here you fixed the order, but...

>     ++  git init pseudo-merge-fill-in-multi &&

...then you immediately run git init a second time?  I'm guessing this
was a stray edit made while trying to fix the order; could we get rid
of the duplicate?

>         (
>     +           cd pseudo-merge-fill-in-multi &&
>     +

Looks like you addressed all the feedback so far from v1.  There does
appear to be a new accidental double-init that I noted above in patch
4, but I didn't spot any other issues.
