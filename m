Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3668C4708C
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 23:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiLEX2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 18:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLEX2T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 18:28:19 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A672AB1F8
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 15:28:18 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 4so12336557pli.0
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 15:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rc0N/j9c2jCm/Ph2M6/M41s6zYa3Oh3JpJhI/S1auW8=;
        b=KbJjTVgoraLlvhzf9dzGnfP27i2e/3Pn63WDYDVHJ/6NkOHUaUfZimXqrNwZDxDnKa
         LW8yID2380l7Yg5MQYxKCUVXRrwwyr5opOLbBj/Au/JZkZBwJdpqEtCdHzYXlon/NdRh
         ZTGmeuaW7guuA6dKXW1jU+4BWjJ8FZqZwrH3a2klghrsq5YxtA6YaW/7wi/cX+I8HsW8
         m3y0gWM7RyEI+dgccz9bGz1+UYKqAXUfWUvtue+HZHXWRKh18Ka6YL4HHE2E33Cy/hKw
         YHcvXGnFTMnfwdNJAPt9FYg322L2pXV38gaQaHHTApl9FiF21TGkWuVHAD8WURsIedmo
         AE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rc0N/j9c2jCm/Ph2M6/M41s6zYa3Oh3JpJhI/S1auW8=;
        b=64yzF8+gGcU8XHxr7ja130rWOWHv+SzU7f6XiWQ9pF1RnyN7c3bGniMlX3UGN0wGLU
         a5nvgBCG/uxQcM77l5DTyfXj4VE5f1XkjRPgCKUi0P8wowVPNl4XR5qlCY1qqE3A9Exo
         uZV3xEAUt7h8AY6iLVABhAIaznyzu8GspJsiuIf1R9LusvVcAJX1HEzMv425beYR9f8o
         Y7uMXHsjSWhMUocUBoVO5DBO+tPBQ90gXYLPxqhkFxxjRNVu1zoyMuPznqJxAlTY5v7M
         CsxKklgLh4OKOEmJagKL2JZeNovFhXBheXiF5MKBOFtQFVhRLkIH7MCvQRxkSX/ijogK
         L/ig==
X-Gm-Message-State: ANoB5plEbJxysZg1+wteCfqRBzrBgUARolse5bYjeFUSkuwNoJucnN2U
        AORMRr1Qa7eq7U5SlcOOqSQ=
X-Google-Smtp-Source: AA0mqf4vfjmWpKIA05wURmvfhIz8ZMr+DLANn5XudjOi59k1Uz0eNqPEA9fIU9qF4g6j3RNNZBLObg==
X-Received: by 2002:a17:903:191:b0:186:5cda:1e01 with SMTP id z17-20020a170903019100b001865cda1e01mr69270751plg.111.1670282897977;
        Mon, 05 Dec 2022 15:28:17 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b00575ecd1d301sm10384394pfj.177.2022.12.05.15.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 15:28:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Oscar Dominguez via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Oscar Dominguez <dominguez.celada@gmail.com>
Subject: Re: [PATCH v2] ci(main): upgrade actions/checkout to v3
References: <pull.1354.git.git.1665388136.gitgitgadget@gmail.com>
        <pull.1354.v2.git.git.1670234474721.gitgitgadget@gmail.com>
Date:   Tue, 06 Dec 2022 08:28:17 +0900
In-Reply-To: <pull.1354.v2.git.git.1670234474721.gitgitgadget@gmail.com>
        (Oscar Dominguez via GitGitGadget's message of "Mon, 05 Dec 2022
        10:01:14 +0000")
Message-ID: <xmqqmt81ph0u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Oscar Dominguez via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Oscar Dominguez <dominguez.celada@gmail.com>
>
> To be up to date with actions/checkout opens the door to use the latest
> features if necessary and get the latest security patches.
>
> This also avoids a couple of deprecation warnings in the CI runs.
>
> Note: The `actions/checkout` Action has been known to be broken in i686
> containers as of v2, therefore we keep forcing it to v1 there. See
> actions/runner#2115 for more details.
>
> Signed-off-by: Oscar Dominguez <dominguez.celada@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

I do not know about Johannes, but the latter two S-o-b by others are
very questionable, as this is the first time I see this iteration of
the patch.  The chain of S-o-b is used to record that the author
handed the patch to somebody else who forwarded it to another
(i.e. the order of custody), and the above makes it look as if I
picked this iteration of your patch up, passed it to Johannes, and
he gave it to the mailing list readers with this message.

If you wanted to say "Input from Johannes helped me greatly while I
polished the earlier work to produce this version", it is more
appropriate to end the proposed log message with:

	Helped-by: Johannes Schindelin <...>
	Signed-off-by: Oscar Dominguez <...>

in chronological order.

In any case, I've been disturbed by the "Node 12 is going away, use
the one that works with Node 16" warning at GitHub CI for the past
few weeks and it is very welcome to see this topic moving forward.

Thanks for working on it.
