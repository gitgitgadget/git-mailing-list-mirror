Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F32ECAAD3
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 16:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiHaQXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiHaQXS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 12:23:18 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D88AFAC8
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:23:17 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 202so13918574pgc.8
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=wkkwx/fOO809T1OnCkav1G/BZv9xLdjb0Au2rac7FsA=;
        b=UdCWnAkQ5miYHiVUMxKrJMGy4i///Ugnm3c+RYpJtCo/icfRCSxAm412vaQ9uXn3+J
         idYy1ucJzVDoXWf9xBPh1BQAreXmeW2iC8BQNQFJmD87zz8w0UqQQOk7dEg4FFiJ7liX
         2/yFItqNR/eRDxPE9FkL7Hk87vfwY1HHYssyOnxD3h4ACqunIurseY8u30O2+1Gai/HY
         PxQmVUxWdDl2cv8sr2SZlfgu7fZRsomnKsS40qyBTAQZ4G2goEXU2bPjr4oUr3PKmw2b
         Z7YHFg5oOP1wNec1bhylwY50BUt8YbwRKJ3JnrPKDPL9kxIAfgjL+VwXd6ilVGflrEOZ
         lVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=wkkwx/fOO809T1OnCkav1G/BZv9xLdjb0Au2rac7FsA=;
        b=VRKelXgI9dik9LtZjPmxI1p740nDzqfqfG3nVyJ4J2ug4UGE0H6aFK5OYT4Vn8MhQn
         hQcUrlNWMXAdujiBkeDr7Pvab+dQkitsTJd+huvOUCtO+KJIGTG0gnwhl4ft86aNuO6b
         neiRcUOV13wC8znxEz0QtgeHRAqQUWRSpRhZmtUWNrpQMMj/9xpApCYQwRb9Uvc4IvpQ
         343X54bGEVRCRO3o3ZE6s16cIqSFq0AvBM+IwYO+lMwdIeLGAyGGOGj6+w4XP+yeSYFE
         dzuFv6HtPa9e8ndnCWHb7b1F8ESGVx2LG148rMPfu3xL7ck54vq9BgHCUGxfcQ2O9JnC
         C6Mg==
X-Gm-Message-State: ACgBeo2ye2zUgHhga+oXAWlg9h350gdkH5xpfR028Rc56h8pph67QZoM
        MctbrCcfSgTio2Gq3ViiDrDLYfoQJFU=
X-Google-Smtp-Source: AA6agR60G4v380RN78U27jPiGzWyhD3O8wntNVmOpp+pB5KdMigZ3iAfOkI7KFEhK23+GF7qcV5FHA==
X-Received: by 2002:a05:6a02:206:b0:427:93bb:9f99 with SMTP id bh6-20020a056a02020600b0042793bb9f99mr22331791pgb.542.1661962997097;
        Wed, 31 Aug 2022 09:23:17 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x14-20020aa79a4e000000b00537cfbb2810sm10932008pfj.65.2022.08.31.09.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:23:15 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: jk/unused-annotation + ab/unused-annotation
References: <xmqqilm9k0bc.fsf@gitster.g>
        <220831.86fshcal32.gmgdl@evledraar.gmail.com>
        <Yw99xMnkiv/Qjnst@coredump.intra.peff.net>
Date:   Wed, 31 Aug 2022 09:23:15 -0700
In-Reply-To: <Yw99xMnkiv/Qjnst@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 31 Aug 2022 11:27:00 -0400")
Message-ID: <xmqqr10wgz64.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, I think we should use the deprecated attribute. Since the original
> has been reverted, I think the next step would be for me to fix up the
> patches to use that approach from the start, and re-submit.
>
> I was dragging my feet a little hoping that we might get some coccinelle
> parsing miracle in the interim.

Yup, that was why I ignored the "deprecated" one when I dealt with
the replacement series yesterday.
