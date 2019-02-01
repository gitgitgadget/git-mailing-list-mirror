Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF7821F453
	for <e@80x24.org>; Fri,  1 Feb 2019 22:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfBAWyN (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 17:54:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39445 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfBAWyM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 17:54:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id y8so7722925wmi.4
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 14:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=HxIZ2chfFwPuv+/UpDjePW0Vet5CkJb9+lxssDicMyA=;
        b=JKFmBtFKoNHDbX93NJx/7//w6Gj8qH/DM3QODj8ZRLxei+cQXMdsYxAJMDgggwoi0w
         SwdYuHuwpr8i1HCfNIYc+thYXGgOn57pIdzLUi6oYNWEwhSre6YspfmJ8mcLQrbk76pG
         bJyBIX67Mfa4dApNV9wzsxWPvL3hixiS9dXIfpGReWSjqhwki7WH+a4Vb+skAMdp7kk7
         bzN4YR3UesgsZhHZb3wwTDG0edxaSxOlCi2f0SQlmIzJ197I6mvz0RaWc4GhK1iLncFk
         /sgd4MXqg7RIMe/wP1c50t0wcOpNp+m76Lyc6UI4lbjGuku8loEzZ6BTY2DkBSQGjPdR
         eFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=HxIZ2chfFwPuv+/UpDjePW0Vet5CkJb9+lxssDicMyA=;
        b=JVfsH+KpAmhtI17RfK/N5V7stVsp3pOJ9+oAhd3sMe56CUxI87JSncKZ7EKzAZqN/L
         0/lX+WyrE2ixcXHtk+1UmQBxY7AElzlRQG0KIHom7tK7FBcq+OBmxqnbNmjWBP6Vl3dc
         i4HbplM736yhX32Oy9Pb5rVyJiITu0Ib1BRbgxj7hvZsD7SsoSEYPey8EbP1XUfTZwNI
         UGmbJfmvLSXUCqH8kjkFsN9F9v6eieAYjDcR/Ff2G5ynX5Hnx1RN6Gw1/AacOENONDSf
         EnBqvVYH10YNFdFs2oSyC7kd95VEa1UV5nwMHPKXMvwTgxQpZT6KLODs1ajEL9Mpmu3z
         E8Ng==
X-Gm-Message-State: AHQUAuZMcVQMCn1WvU03nJwz/URhhNR/4VpAxic8ku+aD3AO0ZikAYsF
        baqHwBmyFgep4GKaUG8krOE=
X-Google-Smtp-Source: AHgI3IbwgrID/DY3q7ogKgEoosov2U+eE2xzSq6C8sHcGbpiFUmgnZ/kmYuAkANzJtnx6hmtUegzwA==
X-Received: by 2002:a1c:23cc:: with SMTP id j195mr4048068wmj.124.1549061649915;
        Fri, 01 Feb 2019 14:54:09 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t5sm3127548wmg.43.2019.02.01.14.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 14:54:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, rafa.almas@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v7 2/3] branch: Mark and color a branch differently if it is checked out in a linked worktree
Date:   Fri, 01 Feb 2019 14:34:45 -0800
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>">
        <20190201220420.36216-1-nbelakovski@gmail.com>
        <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190201220420.36216-3-nbelakovski@gmail.com>
Message-ID: <xmqqlg2zw25q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nbelakovski@gmail.com writes:

>  If `--list` is given, or if there are no non-option arguments, existing
> -branches are listed; the current branch will be highlighted with an
> -asterisk.  Option `-r` causes the remote-tracking branches to be listed,
> -and option `-a` shows both local and remote branches. If a `<pattern>`
> -is given, it is used as a shell wildcard to restrict the output to
> -matching branches. If multiple patterns are given, a branch is shown if
> -it matches any of the patterns.  Note that when providing a
> -`<pattern>`, you must use `--list`; otherwise the command is interpreted
> +branches are listed; the current branch will be highlighted in green and
> +marked with an asterisk.  Any branches checked out in linked worktrees will
> +be highlighted in cyan and marked with a plus sign. Option `-r` causes the
> +remote-tracking branches to be listed, and option `-a` shows both local and
> +remote branches. If a `<pattern>` is given, it is used as a shell wildcard to
> +restrict the output to matching branches. If multiple patterns are given, a
> +branch is shown if it matches any of the patterns.  Note that when providing
> +a `<pattern>`, you must use `--list`; otherwise the command is interpreted
>  as branch creation.

I had to apply and then use --color-words to see what is going on.
Please avoid unnecessary reflowing of the text that makes the patch
harder than necessary to read.

I still do not quite see the point of this step in the series,
though.
