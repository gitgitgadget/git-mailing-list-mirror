Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C42C433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 21:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbiKWVyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 16:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbiKWVyX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 16:54:23 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A665E9F6
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 13:54:21 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id x66so9945678pfx.3
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 13:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ky4SBmDw13p/r2gkrUVo632ZaG05Iy8+7DX5zg5ITyw=;
        b=SfNUPhzfqOWeGZ/XdAxrF8/gF6ATG7DqrSRJD4APFUpzesCVEMsEpHpR9Qp1KmkGFx
         0PO4cpT8mJbouTo3E7t95MMC5cUqhhWZk3o4Xk5wtXwp5LIV4E+Dro6UIzwXQ+UxL/p2
         h1cPVQSNrLm0HQXWuIx4vlbVwrYdC6h7Evi9DjRoj9k2yeEjc7246NH7XVJEX8D3BcnI
         FbGtVbgeUWNAqZKmTGphP+j3e3XwOlCHgQ0q5OMlJ/0l1zmaQSPlKjlvPf7KxXX5vHj2
         H0ld9vn6ojHtle64EnZSEjAxuElrzvKTBLmhW/8mSKTlRLdR0HXa5EpT3pTs1xhhNZ4Y
         Cggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ky4SBmDw13p/r2gkrUVo632ZaG05Iy8+7DX5zg5ITyw=;
        b=oOSHeymxBuGhThbr/QLa0ccOkX/2J9jJL/z41E1hhl5cnMhHbKqg6FKmaMUAiJGI+U
         F+Rsj16SPIaXAgu5FGKamd+o2pIF/YLvIFJWy8F0NkTfLYUgzMQ1dtJJSDxdo9Bgr4sY
         6hIJanRtICASB9vqCORAZyWDpqEi/773lrymMQpl6oQU9BYwfOsGNLgUdiFx2dt+1+Nc
         lak4nGHOLME2kqrMpRIVgBp1BEFfxMDdetjhpNJQ6J1wiVS3zkJhBZ8r6sWAkSYtRD5Z
         /kpopaFLHNnCxlUPwniFu6KSVvGEVHlX2MeUWpW4DRlIsLWMfbZ6+j84437gOj8MMBtc
         2mng==
X-Gm-Message-State: ANoB5pndC2yIi7atJtT0uaX8dE5Tpx7IHM7V2cgCNteYyq0P+TAX8Bmz
        WvmUFwByKmzHTePhRR5lgp8V2GSfxQ6yewmUZthyv8DIF7DyzQ==
X-Google-Smtp-Source: AA0mqf7s3mn0sqnLnLKQYdQin9+3Q3O8hRZvRU/JnnEo+z97Pilt4KbQ3k7o6qe7wPaFUmnyxg9NYmwpkUdUeI8j9k8=
X-Received: by 2002:a62:b501:0:b0:563:771d:417f with SMTP id
 y1-20020a62b501000000b00563771d417fmr12500484pfe.45.1669240460818; Wed, 23
 Nov 2022 13:54:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com>
 <pull.1423.v5.git.1669187053.gitgitgadget@gmail.com> <ad7c299cb0f78ae3f36d57b67fa91e5ccaab3181.1669187053.git.gitgitgadget@gmail.com>
 <feb7db00-db00-6190-47cf-9101052b9be8@dunelm.org.uk>
In-Reply-To: <feb7db00-db00-6190-47cf-9101052b9be8@dunelm.org.uk>
From:   Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date:   Thu, 24 Nov 2022 06:54:08 +0900
Message-ID: <CAF5D8-uo5rWZ-8vMz3EXVownaBEfKZ4s5R=cjX5XqHCN4DHaiQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] git-jump: invoke emacs/emacsclient
To:     phillip.wood@dunelm.org.uk
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 23, 2022 at 11:58 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> I've just tried this out and it is much nicer than v4, thank you for
> tweaking it. It is a little sluggish to pop up the emacs window though -
> are you sure we need the while loop? I've commented it out and it seems
> to work just fine. The documentation for pop-to-buffer says it selects
> the frame displaying the buffer so I don't think we need to wait before
> calling select-frame-set-input-focus (I'm no emacs expert though). I do
> think it would be better to quote the filename or better still call
> git-jump from compilation-start as Peff suggested. It would also be nice
> to stop emacsclient from printing anything in the terminal.

As I wrote in the code comment, there is a race condition in
editor="emacsclient" case.
You can observe it by removing the while loop and insert "sleep 1 &&"
before cat command.
However, the while loop can be moved to the end, which reduces latency.
So, I'll change its position.

In editor="emacsclient" case, we can stop emacsclient from printing
anything in the
terminal by redirecting stdout to /dev/null. But it causes following error with
editor="emacsclient -t" case:
     emacsclient: could not get terminal name
You can use editor="emacsclient -u" to suppress output.

Best Wishes,
-- 
Yoichi NAKAYAMA
