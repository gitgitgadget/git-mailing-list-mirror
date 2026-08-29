Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D5C18DB35
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788009884; cv=pass; b=nYfbVSJNbktzVtTVlCSSuCDfMHWTQUsQqd8BQfLHUxkQQEDE4jfcs6PC3XVYS26bn+KF5B3/ZT+rsdCjhwtoqJbZhgyPl/oaJtkv3/E2QNhyu/8AQC/fqsuZBp9jDi1KxqJ0WUdYkWO6y6CLcmSbT7+rTvzg9vxfF6aiZi9P2+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788009884; c=relaxed/simple;
	bh=oHbz3vztNmZEtcNG1ggsXz6UwbBywDkRR9X++lkSHlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tf81rMm5IyAKRd+wwwSTfdE96CmTb4bnhKgsrGC9rIu7NZ27YoxBJ8Em/FLS15WpbqrTKPJao+ARVKt0m72Z4GK4DPWuaxOWL7ItTbr0amfZyaIuwcuqFXWMMjNCxSkEVgsNXhOXbLygrIxOuqATPLB7Q7OY+m/NFE7V2odejco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKP6ZAnO; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKP6ZAnO"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1c73645a1so1504380a12.1
        for <git@vger.kernel.org>; Sat, 29 Aug 2026 06:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788009882; cv=none;
        d=google.com; s=arc-20260327;
        b=ed7EMqHf+R6cpbAoToG33Lz+DqcUTx0UPoEVjYOhoRNgX2C44hwQDUiGHQzWnEHo10
         PvJ30Puv+65uNzUyTrOZRZQIT+THWbdPfo2bF9Zc2JSBlyMUOc3P4wMSH6W8FbvzEisP
         8HSTybNRSA1741FzIUgH/qYD4FqAN6WSWlXJAS7NlcPuUoRQ2ZvvRSX3KqgVdw+MIk9K
         QUrftsgo1J+D67p6XSVSdxYwOGDfvLUJZjCDLdDurOZ3CxHAMkzBRdJJGQmcd+iF3UIc
         pwHxwPgLRBHEO7mlP3QYCBlMpqnmwG8+MxF2A7e0bSYAQFz6AomZErmD701Ons1Y6mX/
         +9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BjTlJjKsRpLafv9AGwyTqnuYdaTCY0e7Yyuhuss61iw=;
        fh=ZcozNGS/Aw0wHwU0ej3g0VvVmCt1wN1578SZwkT4MR0=;
        b=b05gCd+bzIvAyXW7iOv7vlzuVsQ0VQ3bksuUctEQuwRzl07eI0JgBS22DAjzIRr5qp
         mc2yeaKHGqM6S58nEpWrMsicGR8fwoXPZDMzstptEM8zwzCyp6ScfOe9yGxgNhjIjTxo
         PkQ+ezXoB7/wtBS5soaaCvjIBIP8kO3PrPcRcNNt4vkOqo0cRVkJcRPKohMZhxZqwS0P
         O8oEYK7K4UUIuBuhFdtrzkE0HwWfmOEY+4u6BAPvrxlcMJ3k55yEH2t95JUCIanSL2xW
         Z4Cm1mRFD2eJS3cTRCyswrJJDxlery5V7hkLb1sSRTxSRgFPuYLiLQjuwvENtNIvyKEU
         wu6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788009882; x=1788614682; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BjTlJjKsRpLafv9AGwyTqnuYdaTCY0e7Yyuhuss61iw=;
        b=bKP6ZAnOly0yg7aHTAVM1eDGocsu7elj8hFdc3Z31/nkUFiRMhNVvx2sRiXkjTAoNF
         XtPJWx+OEbMFg6KiyMQkCJt1p6H3rk9zyOCB+LLbjOMAWkSVywWT9emb+C4aFtxmg3Yx
         Yo5cVCXCma14NW3G6Gxsl29kKZiX0bNFKf8twVtgh3DAnRp+UDLZ/78v07XOazOr1TiW
         RF4YS5ErIy/nUlrLwi7TDA1NNhMM87j4Bf7sNS4P6h1/SEMiKeR0siMcJh0Lhu24XxbI
         6jAdmQjTobCiVrNyMJmYHrZtoIv/a0PXJEqpnxLO7S8IxFqhs7nFMBaly62YCyiSlclA
         TpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788009882; x=1788614682;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BjTlJjKsRpLafv9AGwyTqnuYdaTCY0e7Yyuhuss61iw=;
        b=KRXY3VkojSOPC78MNyv5om2D2GMYsc1LSIfR/Vy8TzKqOx+63hN+gEnig9VgsbHJwO
         FloL+eA7rdLtUHnriU/eKVEEXYH6+8eRfmqkCwd2oEQ3WyElFQ5ORjwDpDOWAUF74zw4
         ecEweCs/s1LbkQFUf+yRN4XkU5acRzrRCS60VyFmwKreYtITFCw0YHFoKCbnYCJ9EQRE
         A4BPJvUCCxMQQNQfJu/rWIonM9OvF/s9B8Kc5YOeCe2MLzMbPn9STFPXVWzjUpZP/jhD
         kMg7BTaTHYYLd7seZ73AYdUa5buDcHpDtCJk3BYpo88mBsNIewuRRIwPYt1V1/Ntu6+3
         GiMw==
X-Forwarded-Encrypted: i=1; AKwUvBzl8f/0P8vkkg2TGkAWdgj7Tp3+IUVZv82HcE/0k5qt4VG9sgT/xnF8MBBcHzcbi3yv4TI=@vger.kernel.org
X-Gm-Message-State: AFuF++nsOJwbjvfJ7KXsS58PwEJbdHPkXXGrzTUYug7swO4iKQigZNyD
	FLRTILUVeiQkr0xkIHOh6P9vzgX3024pBGzXJ2WuwKZ4+FpAfibh19U2w5x0W5TNLOwpCXK2o26
	8eBlbmLrLsa6uJ5rYVSGv5yOw9teuPva3y3Kw
X-Gm-Gg: AYBFou1qiKqBBXihOherM2647KUh41qAnP/um/WPnAPsKZtGKA1Z+ZJn8fwFV/S34jV
	BN717H6rRxrfZ9eigsP3ug1491jWTRGgFtHVTUNnhFMoCywz3zxMs9dBSR58S5tlxBxqiyFZfjg
	aytgnzD7i3RwZTFa1l9U1ov1p+pVMPJzV5u8zTiWB5tFuo7bbvMvEeVrx5AvekWxK/u7aCtmXWE
	oG3FuOzlDhH2n871TfIvEW6tD9yLKY9UBOWqNDHuoGbAkHQ0Ly8bQl8bWAywyMMIngVIlJMMXv0
	aihfLVd60Ogvz0IKjPmYXcejQdFRlIsVqf6EI2eeW9IJWljoLwPAw1Foxvjk38kLWzvqL+IRHmd
	K5XmUFs7hbVjJzgvRTRPSWZkvnxAitnJZMrGMUP1dLqkfubx/087/MfCJPxZSZUvDZJEorYKc
X-Received: by 2002:a17:90a:2c9:b0:398:9c39:520f with SMTP id
 98e67ed59e1d1-3989c3957f1mr6327466a91.15.1788009881968; Sat, 29 Aug 2026
 06:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq7blb8g04.fsf@gitster.g> <F276C11F-1904-496E-AA77-953724362C9A@gmail.com>
 <xmqqik4v6y6i.fsf@gitster.g> <CALnO6CCsJGmgmvKyMdX3q1Kr5AnBwYJ=_UiQ9+m7jWe7hv=3Qw@mail.gmail.com>
 <xmqqh5kd3lm3.fsf@gitster.g>
In-Reply-To: <xmqqh5kd3lm3.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 29 Aug 2026 09:24:30 -0400
X-Gm-Features: AcwNN1UyWw6d9g2YNzTUe4GfQv0JXYO6lXO3fu_NoMEhfPBxtK9fCDk1MYl_HjQ
Message-ID: <CALnO6CC9ModYeMp+D6kSDxW9iPgn3Hy1wY+0Cv-3DyKJOwAWkw@mail.gmail.com>
Subject: Re: [PATCH] builtin: replace the_repository parameter in is_bare_repository()
To: Junio C Hamano <gitster@pobox.com>
Cc: Hardik Kumar <hardikxk@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 6:51=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> >> > Hm. What if a program wants to do =C2=AB exactly what =E2=80=98git s=
witch=E2=80=99 does
> >> > =C2=BB sans shelling out?
> >>
> >> Instead of cheating, properly factor out reusable part from
> >> cmd_checkout() into a set of libified routines, and make both
> >> cmd_checkout() and cmd_switch() to call them
> >>
> >> An approach like that would help "libify" things.  libifying is not
> >> just reducing dependence of globals.
> >>
> >> Calling main() from something else is not a libification.
> >
> > Sensible. Thanks!
>
> I actually answered a wrong question though ;-)
>
> The way cmd_switch() and cmd_restore() were introduced by sharing
> what used to serve cmd_checkout() was serviceable, but ugly.  Had we
> started from separate implementations for 'switch' and 'restore'
> that were later merged into 'checkout', we would not have ended up
> with a design centered on a single monolithic choke point like
> checkout_main().
>
> That is what I meant by "cheating instead of refactoring reusable
> parts".  However, that is not directly relevant to your example.
>
> It is an anti-pattern to call the top-level implementation of 'git
> foo' in cmd_foo() directly from cmd_bar(), since these cmd_foo()
> functions are like main() in ordinary programs, performing one-time
> initialization (such as git_config() calls) and finalization that
> cannot be repeated.  To help our codebase, as well as the use case
> you imagined in your message, it would help to trim down these
> non-reusable cmd_foo() implementations by turning them into mere
> orchestrators that call refactored helper functions.  Such a change
> would put cmd_foo() and a client that wants to reuse 'git switch'
> functionality on the same footing, allowing more of our code to be
> used in different contexts.  I think that is what people mean by
> the "libification" effort.

Yes, I think such an organization would end up being quite lovely.

--=20
D. Ben Knoble
