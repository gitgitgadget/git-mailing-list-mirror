Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD83C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 17:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE8E61490
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 17:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhBPRPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 12:15:36 -0500
Received: from mout.web.de ([212.227.15.14]:52325 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229913AbhBPRPe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 12:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1613495615;
        bh=QuzvlFgE7MqQJwSZ0mNmwsxTtn+Unu0HLaSroeTN14g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=D6W2RSWFjRcHjYdV+RLi13oQMLO+jugTfgUU3nXi+yncL8aJ6DpKTBbrfkli0HXAg
         ueHxeP7LxKINp7TZl3guk7hbkXrALLMa8jI2fqDu1erwPBx1Odvx/8X1gMJ9vR40ar
         FcYjdfqB3Frbyl4N6u5UD0nYgpwTZI9ZrlB1I794=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.159.90]) by smtp.web.de
 (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MHp7t-1lAfnm0yjt-003foT; Tue, 16 Feb 2021 18:13:35 +0100
Subject: Re: [PATCH 1/2] pretty: add %(describe)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eli Schwartz <eschwartz@archlinux.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
 <87pn109nhr.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <66720982-04d6-3096-9ea2-ea5bc3fcd121@web.de>
Date:   Tue, 16 Feb 2021 18:13:34 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87pn109nhr.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5ru8lU6nau+Yx1taECdA6tCGdBlaQASKEWY+MXlm8ki3FH+C8S8
 1sRmmpKFKKyaGeV05VQDfwtN+zIJb7C1GLsI9SMmDJ7MjKnh2i1jzQoJqE91O4vhUYDYWuv
 FrO43/dNXtgdqWEbjVneBPFFkqOOnu1uaje00Mspf1ZArqY3opYJZK5tveLu+YDI2CzWNPe
 UT4nOc9y2dVodOS1ee9Jw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y8piitVkw38=:g6BqBS1Jx91u17vmk6i6LS
 P1KRXb09iLdHh1sBAehfz9eWvVArstFB432s6qM/fr7qEqTImX4x2swB8lm65qS4WRHssl5i6
 s6NffEgqO4baWJNhvnQM7TBfFpROXQaCr/+4KNtdW3xB4cCa8o9Cjj4ASHW91te6G54G8A+Qj
 0YPRKsQyJXrgFogaaH+wOd0+mQ/1mJ8jJzKGxfzIL3cZjJHguPuWB/jTi6VbWT5bWlWni2ZuH
 YkGJMsvcgg9JYPfCvIllfPJrL3t1u3ghfm5CUNqnKRSyKn55BvZ02Uz/mpBgbeDsXEaIWVkD2
 2dSIMUuItNqY4VZDn8HNCiNuvkae9H2lCImxQhRI+B/25sm4vZYzwQ2FHxY+ELw6QIP6hHau1
 r2nC//1P4jOqvuhg4HxaIOtMjBmy9ZXNEW44tDZPYB0y85TFAVdDa9bYm/zZj/UBK8zvXosAp
 LYVrLYLxgQdBdvOLRHkMcXTo8IYxu8fig9LmJCxKl8nJIVNgqzYc5do2Tgx0TRu9SlRAgV/vr
 mMqcN+VWyQuaLPzrMQcVcwZZ5NCI+GSWPA9+xLHZGv7KDTx/6lPYK/WDPpNCYw0SEZEYLZtD8
 hMXpNswdrMRkQZXb1p52XXGSJsm5z5SaP6mqcutYDSHv95rfv+KX20Mizn6tIA+pMekkuraBC
 rkwBnXV/lxOnxzOBACp8gZE2Oq3bNlYNi6Bv909rtF3JQp5FuNfglNQEu5wch78gwxTo0bEhy
 6XDeECAITdnuReOiyykOOcqvb4N+nzzwLQ0+4YR6qyLqWIZra8IUxCjRiWjrsnOZZxahPm9bb
 GMpuNVUA0KXQvXj2Jx68WSWcI0xKxgYSbo5RPugBxK2SqwkHRQTmbAOKjOL587fz5Sz7Gopz0
 +7t+gPPtWrnfIAbG4xpA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.02.21 um 14:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sun, Feb 14 2021, Ren=C3=A9 Scharfe wrote:
>
>> Add a format placeholder for describe output.  Implement it by actually
>> calling git describe, which is simple and guarantees correctness.  It's
>> intended to be used with $Format:...$ in files with the attribute
>> export-subst and git archive.
>
> Does it really guarantee correctness though? In "builtin/describe.c" we
> first walk over the refs and use that to format all N items we're asked
> about.
>
> Under "git log" this is presumably in a race where refs added/deleted
> during the run of "git log" will change the describe output to be
> inconsistent with earlier lines.

Right, didn't think of that aspect.  So we'd better warn about the
raciness in the documentation.

We could improve that by keeping a single describe process around and
feeding it object names through a pipe as we go.  The results would
still become outdated after a ref is added or removed, but they'd be
consistent.  This would be faster as well.

Ren=C3=A9
