Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39B101F403
	for <e@80x24.org>; Tue, 12 Jun 2018 18:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754364AbeFLSKK (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 14:10:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40207 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754223AbeFLSKI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 14:10:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id n5-v6so599067wmc.5
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 11:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=TdE8RTW4cGYlFT7CFTL246H/VY3x7i6/6fjSkHJPsAo=;
        b=kSDRbYdPym6Rxxf7fdTT+zVr3i4irRff8ynLEnbXZ52Hdc/kZG+A3vaZxGkR2C1Vv0
         804XKsNS+o6zHTTx4roieGi6B0ILQR/Inyfsx3+tAzSQcTM2ojzfmrz9GybAcHee2dWl
         O5TizR5I/3AVwwFwTDBw+FhszVejn+BbVvs06xHHBbTEkBfry3qXYuqcb0XR763K+4bG
         6G32dvG/S13rTX0/gQMPw5r/J6Fgeb17qHDOe+fyvCD6r7WLjmGD0avNMWmDRFLx1Elc
         rkRMUGvZLY3pqjrnx1U/ALW2/BR8O92QgLq4XklT+4G1h/yC3Aj6ohbFJKLJixMz9uTk
         IaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=TdE8RTW4cGYlFT7CFTL246H/VY3x7i6/6fjSkHJPsAo=;
        b=aEySmIT2P6EfO7bB+d5aIylOtFgKRWFbxeZGL33kDS4Oj0Yhf5OGMWUPGfD2xMc0HY
         DKhrI14TsrDpNYLuGVqbhQphnz3ecCN890+qWTgyYL/QWBpX6ZY7Dr5E3NNDqwjR8GJD
         pPU1JsUIClQReHnuEFckHTdW7BOzCE+QnwSzkQ18ZRKePsgLrxreWHiiGhaiZ7ne08Uk
         ibKnvXej7IThNPzk4jS804H4S+tNTmVN/TG2U7qTyhvJ4i7DWMf7TgrcmmscTiaTB716
         B7v4RHCDZj87ZquBXgrm6fTyyxQTir3zVgRom2YUiqewzVXYvDWlDEbL0Cbp5qh3+PWo
         7RCA==
X-Gm-Message-State: APt69E1JTPQY2aN1d8finBRYQqUojkDnyLP0cAxUBKPaP3irSLzRX2bb
        J1xZEqtyf7Hfm8WST6op+4/1x2n6
X-Google-Smtp-Source: ADUXVKLHqxp/fiHrnY55vO+Y4aBmr6e/EZZv66A8udp6xmyGNRx3XEBya2BX/KxxtUTnNN8m0fhFDA==
X-Received: by 2002:a1c:dcd4:: with SMTP id t203-v6mr990172wmg.156.1528827007128;
        Tue, 12 Jun 2018 11:10:07 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h77-v6sm1667469wmd.9.2018.06.12.11.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 11:10:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, johannes.schindelin@gmx.de, jrnieder@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 03/20] blame doc: explicitly note how --abbrev=40 gives 39 chars
References: <20180608224136.20220-1-avarab@gmail.com>
        <20180608224136.20220-4-avarab@gmail.com>
Date:   Tue, 12 Jun 2018 11:10:05 -0700
In-Reply-To: <20180608224136.20220-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 8 Jun 2018 22:41:19 +0000")
Message-ID: <xmqqbmcfanb6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> In a later change I'm adding stress testing of the commit abbreviation
> as it relates to git-blame and others, and initially thought that the
> inability to extract full SHA-1s from the non-"--porcelain" output was
> a bug.

... meaning that it is not actually a bug, as the output format
other than porcelain is for human consumption?

> --- a/Documentation/git-blame.txt
> +++ b/Documentation/git-blame.txt
> @@ -88,6 +88,11 @@ include::blame-options.txt[]
>  	Instead of using the default 7+1 hexadecimal digits as the
>  	abbreviated object name, use <n>+1 digits. Note that 1 column
>  	is used for a caret to mark the boundary commit.

This is outside the scope of this patch, but is the above 7+1 still
current or do we need updating it for the (not so) recent change to
auto-scale the default abbreviation width?

> ++
> +Because of this UI design, the only way to get the full SHA-1 of the
> +boundary commit is to use the `--porcelain` format. With `--abbrev=40`
> +only 39 characters of the boundary SHA-1 will be emitted, since one
> +will be used for the caret to mark the boundary.

OK.
