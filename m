Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9891F404
	for <e@80x24.org>; Fri, 29 Dec 2017 20:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbdL2UQ7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 15:16:59 -0500
Received: from mail-ua0-f178.google.com ([209.85.217.178]:41469 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdL2UQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 15:16:59 -0500
Received: by mail-ua0-f178.google.com with SMTP id x10so7150153ual.8
        for <git@vger.kernel.org>; Fri, 29 Dec 2017 12:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NwPSfF584Y8sUBH89Rno/Ub2DxprDEWB0xP6KoKhhwk=;
        b=rIxGqnJRmdzMYz/uo6aI6InPAz9ju9TE1hs/ClzqqjYRFkOqWEo46KP4Ov3AiTFMiz
         44bN8Xa5kgXh9Q4CkFn1H85Z6L5i2jF5YMn8cwTok/nigammMXE8GybLrBASwvUFfaaQ
         ROC+nGpECjbGTLI3b9XZCPafdFl/N6Oqeagri8Pn8P3QkcSU6t4+tmdg9OH9N/7n4bp8
         MAO0y2jBeGZ8cdlWqHZqy8HPH9wGRVrffTxyG4ys8Xp0qTQWMfEa3UFTVGCW5cEYcy0X
         ttzxzm8uzhnrGXrlfBeIHSvuK2YKRr6UpRz4z59pX4NrQN7qOx9e643EN/GJ1r5Y76SQ
         XVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NwPSfF584Y8sUBH89Rno/Ub2DxprDEWB0xP6KoKhhwk=;
        b=lweePBwIE10bRgDqNTVdrYDCtJcHnUt2dzllD8djXSpMowv8yulmWz0hOExsxos/DZ
         QpedCdrUZd0obNIoQ6nrtWns71+AGM4WtIUqpc6y/umhudZAE2wilizS0Vzo1y1xK9UW
         N5xyFy7/qlZZJnrGUuPgKSyIXmgthjmWTGv84RrmbVhVzTR2qh/aFrT0+o+QNT9VV8Lx
         F/yaSAMVdhDDvL/LIk4JmAJElv2uc1liN6KA2Uv9wHdQlvN1MlqUwfvq2k9JR51yBWZY
         VQmORiWloegL8OPDbqPPO3ANg0tztgGXSQYOSAkrZx6O4Xsh/ZVEP7lzecZtoxxHWfxK
         zH8w==
X-Gm-Message-State: AKGB3mJNDOV+OP8bLV2O3oaJ5ekiXpASfVkGTppji8mt55UdiEDau4T2
        CNFpngfrvjk1lguPqulw8ESp31S3BQVujsqEF0M=
X-Google-Smtp-Source: ACJfBosdt9xpdhJn1Tyc8w5uXERtxHYx+0RBRM1KnXTtnCI2QPV0fqCbFCaCPAuraerCNHybazS7KNhPiMI+aB8MaYw=
X-Received: by 10.176.70.218 with SMTP id t26mr6074033uab.30.1514578618379;
 Fri, 29 Dec 2017 12:16:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.83.46 with HTTP; Fri, 29 Dec 2017 12:16:58 -0800 (PST)
In-Reply-To: <CAM0VKjk+LtW4dCuwsZ8ffXrN4HGL=ZC1budCOd53_w-20gwNag@mail.gmail.com>
References: <20171227164905.13872-1-szeder.dev@gmail.com> <20171227164905.13872-3-szeder.dev@gmail.com>
 <35D78E08-1D27-4DDF-BCD3-F6B984D811AF@gmail.com> <CAM0VKj=U5fSHo=na0FqOJNWZLoN6VVC77vj989L+4PgQqMGzWw@mail.gmail.com>
 <EFD040CE-E88C-4893-A304-4514BF221AC5@gmail.com> <CAM0VKjk+LtW4dCuwsZ8ffXrN4HGL=ZC1budCOd53_w-20gwNag@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 29 Dec 2017 21:16:58 +0100
Message-ID: <CAM0VKjkL4VtbxspGFuQHfzVbch5tR_vY8hzHv4r7pdB9xJ3LBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] travis-ci: record and skip successfully built trees
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 29, 2017 at 9:03 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:

>>>> Or print it in a different color? Maybe red?
>>>>
>>>> See: https://travis-ci.org/szeder/git/jobs/322247836#L622-L625
>>>
>>> I considered using color for the first line, but then didn't do it,
>>> because I didn't want to decide the color :)
>>> Anyway, red is the general error/failure color, but this is neither.  I=
t
>>> could either be green, to match the color of the build job's result, or
>>> something neutral like blue or yellow.
>>
>> You are right about red. I think I like yellow to express "warning".
>> But this is just a nit.
>
> OK, yellow it will be then.

Oh, hang on!  Have a look:

  https://travis-ci.org/szeder/git/jobs/322841285#L629

That yellow is barely different from default text color.
Bold stands out much better, but notice how Travis CI uses bold for all
its messages.  Therefore I think we should not use bold and leave it
exclusive to Travis CI's messages.

Green looks good:

  https://travis-ci.org/szeder/git/jobs/322372326#L629


G=C3=A1bor
