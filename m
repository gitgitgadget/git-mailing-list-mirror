Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD29CC76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 05:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjDAFdt convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 1 Apr 2023 01:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjDAFdr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 01:33:47 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9421DF87
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 22:33:46 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id m6so17934074qvq.0
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 22:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680327226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtvtWWvIZgrNQeRAPvMOj5ImSnP5aCcuAqPjzt/srpI=;
        b=gDhAFuyAGNaHpvUMxg9lBH2H8RYtcRTBwgNgEqJui7FBsjYoeo4t2giKkS57fvf+7s
         2a2cqp2xZiBflBYXfz9E8t5SW13xkZtZGM5jKf1IHUmRH/+xAZA8kHgmkvR3ooXtXgUb
         DjV4b0Xg00By+9l1ltvZ/U8UpKyHefXEbMC9I10fT+Y3pQCzuuEky8gfcThRIPkfDLaK
         qYc3zWGCQ0bYheHFgy9FaNkRmtR/i875EXOs39zN7+cbKiSKV+KJ8Y0xtBevdYhylfQq
         x2PwlUlZaEpvWIDXtTr9FpTdXX82G4hZqwml4q1dLg6uYcmMa5OihrtigTk4kl+T8Lmm
         f86w==
X-Gm-Message-State: AAQBX9fQIDMMmG7U36bBSeen4goosJFVkLGXv+OntOB/OBtNiH41ovrt
        pTIvUBS5AfNCvXrGhHJy8WHgIhv8x8j9dF/UzJgh35nh
X-Google-Smtp-Source: AKy350YG+EF/w6uJlhKu9HqrmEaqvgvSpeFBqHik2YtmZcAkhkDG5JROOPIDlfOebPgPrxQjSWT7uq6QI36Zw5yJgRA=
X-Received: by 2002:a05:6214:a64:b0:56e:9197:4ccd with SMTP id
 ef4-20020a0562140a6400b0056e91974ccdmr2576793qvb.0.1680327225713; Fri, 31 Mar
 2023 22:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230401015632.103581-1-felipe.contreras@gmail.com> <20230401015632.103581-2-felipe.contreras@gmail.com>
In-Reply-To: <20230401015632.103581-2-felipe.contreras@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 1 Apr 2023 01:33:34 -0400
Message-ID: <CAPig+cR_F0Xi3qTAJdSs7n3ad545JwHxLmR+xXuNGCB6P460xA@mail.gmail.com>
Subject: Re: [PATCH 1/2] test: fix build for zsh
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2023 at 10:16 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> zsh has the ability to emulate Bourne shell, which is closer to what our
> testing suite expect.

s/expect/expects/

> Using the POSIX_ARGZERO option makes $0 behave as POSIX seems to define:
> show the name of the command launched, as opposed to the zsh default:
> the path of the script.
>
> This enables many tests, but not all.
>
> We can run the tests with `zsh --emulate sh` which has more more
> compatibility, but doing `emulate sh` inside the script allows us to
> just use `zsh`, although it's not as compatible.

s/more more/more/

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
