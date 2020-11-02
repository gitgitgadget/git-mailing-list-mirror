Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694F3C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 17:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91C522226
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 17:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="gXzioMhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgKBRpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 12:45:24 -0500
Received: from mout.web.de ([212.227.15.14]:52767 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgKBRpY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 12:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1604339122;
        bh=mooei3bHqp2I5NXlFoswwq3tBu9Zl/W4XsqVYj1Ceeo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=gXzioMhiDeAWbuazqmpV7++/H7BYguPkMOPvboNIZl8Nre5FW5HNEu5voQZh1YgJN
         v4UEXP3SL/lm5rqAfCfQK3tx0SS/2ozOU1fqbTIgFfFbt2dePHBMcmRaLLpU7QALOs
         E8vV/CcH7fHEkiyOtd8eSlZ0Ia6HS2qoIveIveuY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LoHfd-1k7TsR1U0f-00gK2L; Mon, 02
 Nov 2020 18:45:22 +0100
Subject: Re: git-diff bug?
To:     Eli Barzilay <eli@barzilay.org>, git <git@vger.kernel.org>
References: <CALO-guviA4xKjUi0HfA+RLkTPPaQw7KArj__A9fKz0oP3m5MGw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <72cfef26-e986-d34c-eea4-46ec0fda2688@web.de>
Date:   Mon, 2 Nov 2020 18:45:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALO-guviA4xKjUi0HfA+RLkTPPaQw7KArj__A9fKz0oP3m5MGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mc6P65Feb8Q7+lytC4vSSnyueoo06asppIZzNU0dI5ZyuaR6D/u
 CI24LwLK426BY85fBhgzilnCK47Dfauf2AB5MKk1IrUZ5MLK0+B+4m1c4sSqFWTgt59RJm5
 yuQCY16lTEo/xCwMMZD2EaZdtaGqvc1wKjAGRRetBq9GWgUF/jaIA7UKI8YH3Ls8SZjQCYC
 Qj9rO3nXDmQAV/Kj8tYyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mUAN4+qOzBE=:Kgpys5ujZS6RMbdeTJP7Y4
 khSVA/DfSSDAFnPf71cDfjbcjuowVsWyTThBVML8Ks3kxNVGiz+J5HnXyUjhIfCWjPkv0v7mw
 vm+zC5nDxUIBJ12GafBxU7tZQvRRYEUhUpC5WwQfkYemAUf5nG9oV7WE7kvAjZqbtWfAeAnjT
 mZwnZRISQow/EEzObv3r+WCiO+5Cu4R+SwnUYiHu58sugpQhIox6zG45z8+KiI1KafJqrNPs+
 M00jFT7hxJ6hMR6FS9m0QEbDoPEkK9aatlWvUbLAH20qG9VzWO7nq82QNQaQVwO0AC5OUEHZW
 t7hxzkeWhj1JqsCgUA0JregnQvXHOn920tyRriydotG+5eFGnyXqO3IigmqAKuvR8DyUAJ/Ay
 i8TJCUo8vj+dUqBKZs4bE8JtYv6OAAbUO6bc5QaCB8U9iF4I+tMc9xMzwL237BgRJvamVr/Q3
 +6WyhL3d1E8LW6nUnVQuAxKtgMnbqdK8pGDpAzWv1a5DwTN2aTCjlLcpcMCGve6Mrq/MRZrma
 uxHnLaXqlslJazT8PVs3v1cQqnp6oetCKziPBrDl9NsaFsvNWq6hBclBiAyvhSBwCwQVfhfgw
 6q7wTA2BK0pRKJsLg2z872TNGf1fJA16bA+duuHA0dySdYATBI66lXTh2Lor1Q6TAu4tk4pJG
 s4flCPbeCK491k5Gi+Tq+DwVXntH8lYevCT4nKfBlXd1lnnC9A6Jn76Im0Sya8Z6ZuSyvh8AH
 QZejC0E8H8FJrTj8O7ex3KnfQ9OLT2GKJ+AZnhgiwSFyZbNisSJtMOZ+TJwcflYc+EYZ15JjI
 fb8rxPfpyruDtMf7Fup/InqhbVuSFa+btIqRSl/ztnTrqjcSmhTlze7Jp5zdNfd/HW0b3UT+h
 0QcW5qjTMs3R5/48gCuQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.11.20 um 07:53 schrieb Eli Barzilay:
> Is the following a bug?
>
>     $ printf "aaa\nbbb\nccc\n\n" > 1
>     $ printf "aaa\nbbb\n\nccc\n" > 2
>     $ git diff --ignore-blank-lines 1 2
>
> This shows a weird output, as if `ccc` was removed and then re-added.
> Flipping the 1 & 2 names makes it show no difference at all.  I tried
> a bunch of variants, including --minimal, and the four algorithms, and
> all show the same results.  (Similar brokenness happens with an empty
> line at the beginning on one side and after the first line on the
> other.)
>
> I'm really not sure that the following is a bug, because I see the
> same behavior from `diff` (which is what made me try git-diff, hoping
> that it would be more consistent).  (But I can't think of any rational
> that would make it not a bug.)

    $ printf "aaa\nbbb\nccc\n\n" > 1
    $ printf "aaa\nbbb\n\nccc\n" > 2

    $ diff --ignore-blank-lines -u 1 2
    --- 1	2020-11-02 18:11:04.618133008 +0100
    +++ 2	2020-11-02 18:11:04.618133008 +0100
    @@ -1,4 +1,4 @@
     aaa
     bbb
    -ccc

    +ccc
    $ diff --ignore-blank-lines -u 2 1

This matches your results.  That the order makes a difference is a bit
odd.  Both are valid diffs of the inputs and neither one changes blank
lines, though, so it doesn't look like a bug.

    $ git diff --ignore-blank-lines 1 2
    $ git diff --ignore-blank-lines 2 1
    $ git --version
    git version 2.29.2

This matches your expectation, but not your results.  Which version do
you use?

Ren=C3=A9
