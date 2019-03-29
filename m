Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F083720248
	for <e@80x24.org>; Fri, 29 Mar 2019 23:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfC2XfC (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 19:35:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40044 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbfC2XfC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 19:35:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id b11so1706097plr.7
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 16:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZEntqyu/LmrckfcGi2vlz9fWEtFCk2w13ahcaLe5fIw=;
        b=IrY6e+UYmUbZHXk+9e+P3+0yRJmiKJ54QXT8RlN3/2URuFV4Lfq1qez1M1YXrNhCu1
         efiitr2pB1kLrGSdyAHTrZ6XI35v+osfK0eJ3/WWZlXLFUNk9XKVRjeBDo10798Iyk8l
         95YhR4qpyj3fPOkRku6/fKme8/TGp/p8P090zhyvhrpoX3u3HPjfDt5TKaHNcwp21DpS
         RU94XdAUV/xJoisnzcG7G6aFuHloQptl8kLjXyP5H9oLyTDUBxTHf6pjdLM5KkpWmA39
         MCnc/QPfALEFTyQefOqlBAZEA5fEbg2G35jtaK/HaKODg/gk9VEc94iwpS5GOYAWEHI9
         mabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZEntqyu/LmrckfcGi2vlz9fWEtFCk2w13ahcaLe5fIw=;
        b=bNopPWoloJwNNlB6zRBM3wb4tl2b2GLICuuRuoX+tC/btEd5AL4c2lL2NyR4/QJjst
         etmNGcQkMb2zLG7HzkAwl60i3tz1bF5SB5Yq5Qik2VUCpyjQRu7C3q4U3LEJEaNSTLdk
         loC5S1VH1AqC8Lzfa9fe2oO7WVowhsm0fQ7ZH0uhE+5TfQgyteSXTntNhKsnFieED/bf
         AQV3MDNaDqDE7zvKQGKNfd+1xRIf3DZyNgLv55bGZLnycmB/zUqw03WgHcdgj6N65Xuc
         bVtfu8M7KlffRUSl6PEO419oqs1ntWQjuRs/ySKiM/UcrHIoYlQ1z23SWQcroHwE6Bzn
         twWg==
X-Gm-Message-State: APjAAAVvIF19QjgXzgy+jxQguYqYdEzer4W+DodHhI5V1ClAQOSEBmpB
        SfN9AC6DFElmdP02Ufm2Qdg3wpqaNnY=
X-Google-Smtp-Source: APXvYqy2W2vUVNePvVPw4kK/W7J6NUGrxSr/wuyCjiPnzC3nG5gqfDylfcslBouHYQjpbKCJlgQsDg==
X-Received: by 2002:a17:902:bd92:: with SMTP id q18mr2028179pls.136.1553902501789;
        Fri, 29 Mar 2019 16:35:01 -0700 (PDT)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id 75sm6977057pfr.55.2019.03.29.16.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 16:35:01 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     newren@gmail.com
Cc:     Johannes.Schindelin@gmx.de, alban.gruin@gmail.com,
        artagnon@gmail.com, christian.couder@gmail.com,
        git@vger.kernel.org, rafa.almas@gmail.com,
        rohit.ashiwal265@gmail.com, s-beyer@gmx.net, t.gummerer@gmail.com
Subject: Re: [GSoC][RFC v2] Improve consistency of sequencer commands
Date:   Sat, 30 Mar 2019 05:04:07 +0530
Message-Id: <20190329233407.13049-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CABPp-BETuwt96jeBMMhzT84-=-MqEA3D7uhLb2uxW3fijx7p7Q@mail.gmail.com>
References: <CABPp-BETuwt96jeBMMhzT84-=-MqEA3D7uhLb2uxW3fijx7p7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On Sat, Mar 30, 2019 at 4:56 AM Elijah Newren <newren@gmail.com> wrote:
>
> Overall this looks pretty good to me, just one question...
>

:)

> >     5. `[Bonus]` --signoff
>
> --signoff is new and surprises me.  What's the plan with that one?
>

I was reading the documentation of git-rebase[1], where I found that
`--signoff` flag is not available for interactive backend, i.e., it is not
possible to convert a commit into `Signed-off-by` commit while interactive
rebasing.

I though it might be a nice bonus to add, hence I listed it in "the plan".

Thanks
Rohit

[1]: https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt---signoff

