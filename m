Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8DEC12002
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 09:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035B9611C2
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 09:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbhGSIUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 04:20:33 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:38565 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbhGSIU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 04:20:27 -0400
Received: by mail-pf1-f178.google.com with SMTP id i14so3852885pfd.5
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 02:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ie4EMs6jz6Zy6DsridMx27i9hn8f72rLMKI1BmFAlYw=;
        b=NPJWu4HX0xdMaXPuWeG0WCKXV22oYoCQKXQgW21Xn2l6n+Lc6TyA8s/NGKEn2TiYlJ
         b2tESeHSomhme6BUukmMhg56lB2MhElm2lq3GCghNWFuG/kV8rKorwPQxOGZDaSyioAL
         chY0ZVBWgycFB7450a2R86MwbsNpWTNcB4imzUgHE2b+QqlE+tEWHVOEZtgcTB31ig+2
         1QaznajRt52JD2QjhwQXc2lLPrXddHtF+gj4q1OJVVrsGPsXi2XIM4ILbZT3Us044QjQ
         X3633P3diZODaxaH/JqSDwHEBPbqH5Dn4PGW2yDpYn/2EG2dZIVnhSIfFGQq2hN60CrM
         2ZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ie4EMs6jz6Zy6DsridMx27i9hn8f72rLMKI1BmFAlYw=;
        b=B6Q43S2AGErQwwiCF0Z0AcJiCcvka5Tjg785BhgsU1kbSW7v4grWM8uu1fbggC+s+v
         bbXhqaXb+vy2+Mcf0ZwU6WyAJsvfjLwkEyRmSnwT0XY3IjXTdKUyUjtRZj2VkpH2euX0
         GdGtBMRNDgAwOFkEYnAPTI2JC8LtXYlXKNFgSywoDzI85CWN2mbYCejatsyzh7PmUtki
         dVOD3wYorFnK8CzFFJ2nSxA/vT2JjnyXscKWtoJFHRTY4o2ZMowZgVdPaM0LGgDCE56I
         3ONGjUNqpwd+N0WEjU+5FCYEFt+rMrBc8YCWa0fq+tJSbVgQxWVlBWpR/Hw4NNYq44eA
         0o5A==
X-Gm-Message-State: AOAM531fu8d1lNVwN80c12sRyUkb20ERYrXgIfuiZPl6VLTYTnxwyw1B
        ZS/I42389gwiWJDn7CJF47YSYIEfr2bfrg==
X-Google-Smtp-Source: ABdhPJy6iBRwzVkcMDL0PiQYH0WeIwEyhA1P45YzxVZMnPuopSp+PqdL8rBs/3aRKn8dstw7v8Lv0w==
X-Received: by 2002:a63:3107:: with SMTP id x7mr15954081pgx.303.1626684813067;
        Mon, 19 Jul 2021 01:53:33 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id n12sm19444897pgr.2.2021.07.19.01.53.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jul 2021 01:53:32 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: My Git Dev Blog - Week 9
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <fcb14e9b-c76d-9a54-fccb-d66e7de04f7a@gmail.com>
Date:   Mon, 19 Jul 2021 14:23:29 +0530
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E8CA36A6-2FC0-4A76-9461-D5F4CA205AB8@gmail.com>
References: <ED260A04-153A-46D5-8A84-CF517085DEC9@gmail.com>
 <fcb14e9b-c76d-9a54-fccb-d66e7de04f7a@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19-Jul-2021, at 06:21, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>=20
> On 18/07/21 18.59, Atharva Raykar wrote:
>> Here's my latest blog post:
>> https://atharvaraykar.me/gitnotes/week9
>=20
> You wrote:
>> Interact more with the community by asking questions in your patch =
cover letters and replies to reviews.
>=20
> Did you mean something like [RFC PATCH]?

That would be one part of it, but I meant it in a more general sense, =
ie,
it is better to be detailed and specific about design decisions in a =
patch
that one may not be sure of, and mention it up front.

That, and asking questions to reviewers to clarify what they mean, and =
their
motivations behind it, if one is not sure of those.

> --=20
> An old man doll... just what I always wanted! - Clara

