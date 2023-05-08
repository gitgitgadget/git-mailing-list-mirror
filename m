Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E21C77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 19:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjEHTTX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 15:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjEHTTT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 15:19:19 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82054EF8
        for <git@vger.kernel.org>; Mon,  8 May 2023 12:19:15 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1aaf7067647so33683355ad.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 12:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683573555; x=1686165555;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hiMQAKuqPOYSB8Ssja40MA+PgKLBw0+4Vb1054d4pQU=;
        b=bd1NyUTKqORngG3p0ALcP/9NpjSAez7uiq6sGmEROBoFZ2uH/8KuMcsA4lz+m5KBbw
         BDME9s6VwfDn4GprA5ZyvwcK49IY0Dh9hXWP4kdjETfXMSiIdfV94foTlW961IomxMPm
         i91QDAmH5BtVUrmtCA4kbJbzVfCxn84EVr2Vpj5BRxwmEvJMfeiEZYIejQ9F60rLwohI
         rH+xU4Ec3t0OtDHbZICcrOxBvIQfsiBMMJdGMHUiWU7FDANbVtASW0cdN9MkXB1WAXEl
         IJe7FSFZTAuXaNSmzW+aPj/U0IelTbgAUhfbFFli/oilkYWviTPg+vtcUcw/JC/fYpri
         GdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683573555; x=1686165555;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hiMQAKuqPOYSB8Ssja40MA+PgKLBw0+4Vb1054d4pQU=;
        b=ZaQW1GY+WILjzI824vGJR+SYDJiLnyprFdWmkf/p3dsWzJ6KAaH34Rj1bXYf2FxS5j
         VIdRmwPf9dIZTH6nPYUZ2DDvmjMZVbwkHScC1WxkoIDyWzq/gJ/gV71AY3Ur7Rf+QoV9
         w6+Mnh6Cv17p+TbYx5Uqu1wVTP6tfpgafSmX7mOWth9A+IoHsowC4gsCq3HhoauibztX
         knViVm5hKkFMAlLGHLaeYlbnbVTbVwrr72/wB6fG+3oQqCqt2DUNAxayizRBqf97mKAh
         33sP8aI1MdYxkRFZNtKeS676MgcjvGzIaLpStIqEzb58GwILvx19okcZ/hfLhCaWH9kL
         GMpA==
X-Gm-Message-State: AC+VfDz2Td5z2/q4I9SaT6UzpN3yZvgaFDwx8RgwJ70ed4mQ4bVhm11W
        CsITiXbvUbFlPZiAs3Tcbug=
X-Google-Smtp-Source: ACHHUZ6JiKzU4F4JygylRuSPThsQWqTahw1T70kROBtQYaYPH3xytajdo8dloWPeuYQWxJMkmT9abw==
X-Received: by 2002:a17:902:e88e:b0:1ac:451d:34b with SMTP id w14-20020a170902e88e00b001ac451d034bmr15398214plg.9.1683573555276;
        Mon, 08 May 2023 12:19:15 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id jm1-20020a17090304c100b001a50ae08284sm7619111plb.301.2023.05.08.12.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 12:19:14 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH 01/11] doc: trailer: fix grammar
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <12d4850a9ab8659c40fcb6470caf8f98d7f6e486.1683566870.git.gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 12:19:14 -0700
Message-ID: <xmqqpm7aoclp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  Documentation/git-interpret-trailers.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 22ff3a603e0..e695977fbfa 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -14,7 +14,7 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> -Help parsing or adding 'trailers' lines, that look similar to RFC 822 e-mail
> +Parse or add 'trailer' lines, that look similar to RFC 822 e-mail
>  headers, at the end of the otherwise free-form part of a commit
>  message.

Is that a grammatically incorrect sentence?

The command does help doing these two things, but we can say the
command does these two things without closing clarity, so I do not
have an objection to the updated text (the only "ungrammatical" part
may be that ", that look" should probably be "that look"), but I am
not sure if "fix grammar" is a good explanation for this commit.
