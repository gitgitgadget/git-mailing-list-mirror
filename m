Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8181C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 13:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhL1NcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 08:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbhL1NcV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 08:32:21 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4143C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:32:20 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y22so73976614edq.2
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Sl+13/Scri619fmSjD38lX7C4LphHPRAusZR4YSfATo=;
        b=e9fSRTl9hdLzjr/oOxOUvvRaXxBcY564abLJfD7Z1kYg8vSmR8wv8UT61CQTfAAFSc
         Sy9J8ooo2PsjJhClV/mwC1Tdn/+7p30xxm4H7cxL8s3jSswf/YadoHp35vW2TQNQuyBj
         Jsji2N7FLuzG75Z5ekqu2GOJeXe6GHRtjMsQktGGZeDVTPa/J6Yo8OK9/q4jn9YXrtyV
         HPlD1l8UinnhaagfmTzyvHoFrvHAqQVuf17epIQgTYsayL7S10k+GO3POzO1qyUPXkaT
         8bvUm0T4RjyEOQwY61lzFEckLoSlKcB2d/CbPbvs04kr3BZw6lkmKE+3Gq1WiIAzALXq
         2bVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Sl+13/Scri619fmSjD38lX7C4LphHPRAusZR4YSfATo=;
        b=NOWin1L/M8J1W+q0jVddPtQA814lXtLr6C3UnanHbnTfVHkdIfqHLW8eWnYcf42h8r
         t/LiTnaRIjkrqnQ5VrQ4B8kIY8O01wtBG5aPD2Wvkj+x0peoKZb5Q2GDHFkC0Fx4ekMe
         GtSZb0ujOOMObX9py3ZAjwEvtpMSz9kWvcFiVd684HSH93M4J841K+Ns9THLrnEezZgZ
         1pKac1YadXK47z74KGXaR9qVcgyJdRg9pv0XQBieHewzug+FUh0dCqY4GFl9pRfT/jVt
         mMI4HOBS+6KbHTwXazyBtgC1lyEA69XcoWDR6IuYfsu+Hrcck2dcTG10UXbRoNx+yvAN
         5jTw==
X-Gm-Message-State: AOAM531p59r7PAGgv7jv4A5a3VZj6TSGTfYuDak9Ga7catVTTugmKSmi
        /YOLQW3vnvmds1Y9BYWPxsU=
X-Google-Smtp-Source: ABdhPJwXlVijQtutGLVdVUzRJxL0rLwoOlD9yFIk7bU0+Gzhfe9IDf2Hy2xrJr7YkH7Jf7joUIXJog==
X-Received: by 2002:aa7:da44:: with SMTP id w4mr20095865eds.391.1640698339270;
        Tue, 28 Dec 2021 05:32:19 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id sb7sm2239094ejc.203.2021.12.28.05.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 05:32:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n2CaO-000Bt4-9E;
        Tue, 28 Dec 2021 14:32:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: ab/cat-file (was: What's cooking in git.git (Dec 2021, #06; Mon, 27))
Date:   Tue, 28 Dec 2021 14:31:10 +0100
References: <xmqq7dbpvb0q.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq7dbpvb0q.fsf@gitster.g>
Message-ID: <211228.86pmpgj1nj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 27 2021, Junio C Hamano wrote:

> * ab/cat-file (2021-12-25) 11 commits
>  - fixup! cat-file: fix remaining usage bugs
>  - cat-file: use GET_OID_ONLY_TO_DIE in --(textconv|filters)
>  - object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
>  - cat-file: correct and improve usage information
>  - cat-file: fix remaining usage bugs
>  - cat-file: make --batch-all-objects a CMDMODE
>  - cat-file: move "usage" variable to cmd_cat_file()
>  - cat-file docs: fix SYNOPSIS and "-h" output
>  - parse-options API: add a usage_msg_optf()
>  - cat-file tests: test messaging on bad objects/paths
>  - cat-file tests: test bad usage
>
>  Assorted updates to "git cat-file", especially "-h".
>
>  Will merge to 'next'?
>  source: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>

I think it's ready. I just submitted a minor v6 that integrates the
fix-ups you noted in
https://lore.kernel.org/git/xmqqr1a04377.fsf@gitster.g/; It's at:
https://lore.kernel.org/git/cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com/
