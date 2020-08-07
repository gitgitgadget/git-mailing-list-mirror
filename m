Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B72C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0862D2086A
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgHGVR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:17:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36636 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgHGVRz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 17:17:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so3083393wmi.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 14:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2GHEyf3PSCoq4zLESoO51R78I+ol6VOXsEpvy0/kYTI=;
        b=agf6QLdupXSiNdxYM4BxdP81hz9R/Xqk20MnBQqOxMD9xCh3EovYZ4tBlAjIUFErkB
         CPuMGlHh0MKt6QWQiCkO1qrtpGEVV8DBaOKr40UTaqpByyfNxCnKUGKVxYTD6m1bAGt2
         CWXZbjSIklqgarbUFVTlNcvBkHiAuBoRqm+3DQDPfaRFCANKc3qeu9FR3Mto33qWtPMi
         Uc/J75YQw711PMvGKh16uePleMvFKUJDzqsyPv1dhRUffm8THcMYJV70xNoI/LpJP5tF
         UAw9S4xCvaKyLDBAFbhMXmJvTI8rFecZNiUj3lZ0bLVNgmE9ZmphyJTUJud8cgJX2elm
         b5ZQ==
X-Gm-Message-State: AOAM531HJyFwrVdM7R0GcXzCn6tlEqUv7Xxt2QSL+cRUOTwaq95FU45h
        tiXnVmAKNGCeZoJeFUXfX10ymsQxM9r/Y0uMTgA=
X-Google-Smtp-Source: ABdhPJynV+RMt1ct8G2w+BkFpZRtB7KQS4kforTKdqUX6gu3l7hrbs4Hbr1V2EqVwhQ0t+XIHUSW7pxupH8rByDWHFo=
X-Received: by 2002:a1c:e304:: with SMTP id a4mr14222784wmh.11.1596835073979;
 Fri, 07 Aug 2020 14:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200801175840.1877-1-alipman88@gmail.com> <20200804220113.5909-1-alipman88@gmail.com>
 <CAP8UFD1Z1V6+iPO2CMOqdHhUGkmTdvCK+TDNtoOcX8QvC4coNQ@mail.gmail.com> <xmqqmu36f9pv.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmu36f9pv.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 Aug 2020 17:17:43 -0400
Message-ID: <CAPig+cT_1JNZOk7wZr3akdCmv7tn2RHieJd+A-usZ49jS0eCmA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Introduce --first-parent flag for git bisect
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Aaron Lipman <alipman88@gmail.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 7, 2020 at 5:05 PM Junio C Hamano <gitster@pobox.com> wrote:
> OK.  It appears that the patches themselves do not have fundamental
> issues, perhaps other than test style updates for [2/5]?
>
> Aaron, Eric, can we have the hopefully final update to close this
> topic, if that is the case?

I have not personally reviewed any of these patches, nor have I been
following the topic. My one contribution to this thread[1] was merely
to point out minor style violations in [2/5] which I noticed while
quickly scrolling through the email. Consequently, I'm not in a
position to say whether or not there are any fundamental issues with
the changes made by any of these patches.

[1]: https://lore.kernel.org/git/CAPig+cQumRSCQA3Et5=h7SD7zqMm_Z6LJVUTonkewR=hNR55Ug@mail.gmail.com/
