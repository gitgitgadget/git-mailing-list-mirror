Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D184C1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 17:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbeKAC1n convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 31 Oct 2018 22:27:43 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34815 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbeKAC1n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 22:27:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id z2-v6so18064821qts.1
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 10:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wbyl8lEBb18amXoNSzvGVOG2vI8dilqA8aSNMnHsKDE=;
        b=lbt/vcbHVBO8I1SuiZpIqiIs6WB02KMNRUrZhEwwXfyJoEhQtWbnuNwqr+O1GOJfbg
         lwA27EqOXLTtfO7wQjOAHIDiusXhrXkuSRpcSB4jh1jJc2CVncdfvnc6kSN+RWfC7T/k
         1Kxbwxyj46N+dha42V4UMhX1xbscz2j+d6RoQTRYix/spvyyD9jhV7/KBpPvMHL1CoDq
         PDiXdimZKF9ZUhH01sCwn+7fDu1XvV8GpHg3yU37SNj2mehH14ctc9/EOMQDg308FJnj
         gvgfuEljzRpep8nZbGD2Tmoz52bMbRBFDHMo8d2dN+58bDUE6QJ6vrRHUyPuuUJ++2qx
         ahag==
X-Gm-Message-State: AGRZ1gKKZXiHfrjBqRBMD7+D+bAUS34zcwkZs8OiWRRTHs2O6qi4L5w8
        C7Nyjl0GwKQaiYpY+h2KDEMazg03dIefS/brPqg=
X-Google-Smtp-Source: AJdET5cHIyHAG2C6Dp2geuPraV+gTecuneJyPmIHFp3DZuNjyKDnRPZFjj1x7PcEW9NvdyHVWKmDcCkF6La56jECLwc=
X-Received: by 2002:a0c:d29b:: with SMTP id q27mr3596393qvh.62.1541006925566;
 Wed, 31 Oct 2018 10:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqva5l76zs.fsf@gitster-ct.c.googlers.com> <20181030080937.11118-1-martin.agren@gmail.com>
 <nycvar.QRO.7.76.6.1810311553480.4546@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1810311553480.4546@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 31 Oct 2018 13:28:34 -0400
Message-ID: <CAPig+cR-W1bQ7wY8k8Zok3hCBxHL8uXmUA2p2Tc9pYYXc7Zr+g@mail.gmail.com>
Subject: Re: [PATCH v2] sequencer: break out of loop explicitly
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2018 at 10:54 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Tue, 30 Oct 2018, Martin Ågren wrote:
> > Rewrite the loop to a more idiomatic variant which doesn't muck with
> > `len` in the loop body. That should help compilers and human readers
> > figure out what is going on here. But do note that we need to update
> > `len` since it is not only used just after this loop (where we could
> > have used `i` directly), but also later in this function.
> >
> > Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> > ---
>
> ACK. Thanks for cleaning up after me,

Looks good to me, as well. Thanks for working on it.
