Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C1FD1F406
	for <e@80x24.org>; Sat, 23 Dec 2017 02:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756885AbdLWC0c (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 21:26:32 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:38118 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757236AbdLWC0b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 21:26:31 -0500
Received: by mail-vk0-f65.google.com with SMTP id l63so10380457vke.5
        for <git@vger.kernel.org>; Fri, 22 Dec 2017 18:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gzjh4SpCWPr6WBvaPf+sqkT/ZJD44ugDSu9QmM/h2ns=;
        b=UcooOnY2IBAC0TglRrLR4P/sJVDfaeYunEisMPM5bfd/p/U11P1Xc7K4iWb/xVRXo9
         tkyrSzR0nzdBJ6GqQZXOfTZMfEIroep+8zPqoaaZEvgO52yLlWgTl6UZvD5c+AF1evzC
         FNSx+j6xurbUJ94AK4Rb9todYAgYBxeIjgqy5lbxBdFM7pk9eNithpU5aNMjMjJRT20D
         chg42iXn0iBCBPLegmsFrqkDSepm7ZHGK2izZ0/k96G6PVQM6x1reYHNtpLuCCkKksbZ
         XY+lGqGYqVdoBS+f7BBmTIRLr5ztfC9dPn5nwtDOrVFToXXLOWU4XSVxrBRqU9uqberu
         lyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gzjh4SpCWPr6WBvaPf+sqkT/ZJD44ugDSu9QmM/h2ns=;
        b=sMZFKCpV8yX/YfamMZylFr7sBln2qlAnsPf96NWPoHUbJhoHhDNRo1mGMBFE5QXX36
         W/rypJfcZpMMHn/3d0AdK7XtCRFWz3Nw8zEkItKu/R0AQR4vQnVOJOeH8/OMbsjdvFI/
         G4wa/aasMgYs/6fEvNm+3flebrLzhigkW9ZxOQXpMuijeazywhVyJhA4yRguM0s60kqN
         RCMVJvhJgDQ1+AnnBzQ6SQUER8QDiO1N/7cjViulcccYsKBZxmkyaIe60AG+W4hma6Au
         fKvB3DahV0nc+CZw8m7imRP6EoI7ae1QlwL+mJnI41OQ712Yh2q1ifqDkbdahiumCEqi
         kORA==
X-Gm-Message-State: AKGB3mJrDpBYfRkAbtJAb4cs4XfcXF1G+tFANY7MF3r5mTJ6bAeRkSVB
        x5GT2BZpZp9nTlji8iDafvE1TFyDcWFYSb8OI/4=
X-Google-Smtp-Source: ACJfBosH2Qc8sUNM1ckPJ/5cwzWe1z2eCOyuSFdx7vXlvKT6IQDsnAiHuOL5A1gReszEIvzyNe6a1NCUrUjMsq1U0ao=
X-Received: by 10.31.41.137 with SMTP id p131mr16199083vkp.68.1513995990869;
 Fri, 22 Dec 2017 18:26:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.82.5 with HTTP; Fri, 22 Dec 2017 18:26:30 -0800 (PST)
In-Reply-To: <xmqqd136qymc.fsf@gitster.mtv.corp.google.com>
References: <CABPp-BGy3_RyVQfCm+9O_AAfKA0_CZ5ajJE7NuLbToERWyWmqQ@mail.gmail.com>
 <20171221191907.4251-1-newren@gmail.com> <20171221191907.4251-2-newren@gmail.com>
 <CABPp-BGwZq2m4fexVKThGHwSFM3i3xxy2x9cZhtQvSHZ07unYg@mail.gmail.com> <xmqqd136qymc.fsf@gitster.mtv.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 22 Dec 2017 18:26:30 -0800
Message-ID: <CABPp-BF4h3nBUhr-akw0SFy_RboRjf_gYXe-+ikgRhFNXf3C1Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] move index_has_changes() from builtin/am.c to merge.c
 for reuse
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andreas Krey <a.krey@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 22, 2017 at 12:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> On Thu, Dec 21, 2017 at 11:19 AM, Elijah Newren <newren@gmail.com> wrote:
>>> index_has_changes() is a function we want to reuse outside of just am,
>>> making it also available for merge-recursive and merge-ort.
>>>
>>> Signed-off-by: Elijah Newren <newren@gmail.com>
>>> ---
>>
>> Note: These patches built on master, and merge cleanly with next and
>> pu.  However, this patch has a minor conflict with maint.  If you'd
>> prefer a version that applies on top of maint, let me know and I'll
>> resubmit.
>
> I think I managed to create two topics, one that is with these three
> patches (2/3 backported) on top of maint and the other one merges
> the former on top of master.  Please see if you found a mismerge
> when I push the results out.

I'm about to head out on a multi-day trip, so I might not get to this
until the middle of next week.  I'll try to take a look as soon as I
can, though.
