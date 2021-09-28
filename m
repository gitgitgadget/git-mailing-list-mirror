Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923B0C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 08:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A7A961153
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 08:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239580AbhI1IZd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 04:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239568AbhI1IZc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 04:25:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5126FC061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 01:23:53 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v18so44794033edc.11
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 01:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=MEXDEkeAvQOkpZf/KzqlSiLsnQNgzT4LOHzeBxgVBcY=;
        b=ZLDNk8ChOlybpni2Uc5749E+ukhPEDA3+iSRoAwj8KkQPRhs+a5wn7kULGJ2C0Ovt+
         KyhaZIKNTQf3dk5ssHqSLPsM+J9GhbF99mqHU3NQ0ZSnbyi67Y6zwoHCJ9jG2r0OcCjI
         asHkJnaAEekhlyaiDPS+4X7095VXvA2v+CVwvfnOnOMrs0eAKOcUJ/hV+24HILZHrzaG
         iRXoutxX5v4i9w/eJg4UW0wUjQsvMdEFOy7/w8X2uRZZGV+FAf9QeVDns5T2BUjG44RZ
         9F/40qqY+masKjWO0vQz+gEeEvy6kUdRTn4jaYEP9574jX4PmZ3sSejGElLqg477yi4/
         z97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=MEXDEkeAvQOkpZf/KzqlSiLsnQNgzT4LOHzeBxgVBcY=;
        b=4bu524gu+4KWW2liJ/dtTw+1ohyU3QGBOOgZ9wjkdOgcV8vBoFna+nf9Dod5x8DV+9
         oRa11u00GRMKQaTC3PXpMynnx+Icf6h7DK4d8WXqBdTO6Q1zuWAP39dpTEeUKS/Gt5HD
         WGSCCGV1+6NUVfvXEcNH10xw414DxcTYuj/72PrMcAW1WYM91Emsd86/uabUw8XK6bBC
         a/Yvl5JmASWJj7e19zUsh46g9OZVimzf2UayafVBor19rba35/8BIzxYsyugtzQd0+v+
         RqJRBk5kG5d6dWOhyJ02sxKxRNrKnyVPQDlLuZiOLv9GuKtzb5AwarsrXagL3Cx2Kd6m
         InhQ==
X-Gm-Message-State: AOAM5323pX41+yBmr07ctP7hNyWNynCrHRDCWbDmhjfW3itrgFLEieAi
        VLfFram5mRFen2iElQNfnJenaGZ7yYbVqQ==
X-Google-Smtp-Source: ABdhPJzIBovRkrXhiccabP+kCdCA82mlVdONTRGj2YmtkcRX/lXCOUtD35AhxeiVialxzDUs7uxD9g==
X-Received: by 2002:a17:907:2be1:: with SMTP id gv33mr5261294ejc.478.1632817431843;
        Tue, 28 Sep 2021 01:23:51 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bc4sm12267642edb.18.2021.09.28.01.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 01:23:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: da/difftool (was: Re: What's cooking in git.git (Sep 2021, #08;
 Mon, 27))
Date:   Tue, 28 Sep 2021 10:22:30 +0200
References: <xmqq8rzhmsi7.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq8rzhmsi7.fsf@gitster.g>
Message-ID: <87ee99xg4o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 27 2021, Junio C Hamano wrote:

> * da/difftool (2021-09-23) 4 commits
>  - difftool: add a missing space to the run_dir_diff() comments
>  - difftool: create a tmpdir path without repeated slashes
>  - Merge branch 'da/difftool-dir-diff-symlink-fix' into da/difftool
>  - Merge branch 'ab/retire-option-argument' into da/difftool
>  (this branch uses da/difftool-dir-diff-symlink-fix.)
>
>  Code clean-up in "git difftool".
>
>  Will merge to 'next'?

I think so, I looked it over and left a comment about a weird edge case
in the pre-image to do with negative return codes, but all of the logic
seems OK to me.
