Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D15E01F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 20:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752381AbeGCUUz (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 16:20:55 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:55768 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeGCUUy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 16:20:54 -0400
Received: by mail-wm0-f45.google.com with SMTP id v16-v6so3581512wmv.5
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 13:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=g/qlLpVwBewkSZkzs4lA44MY1RuupNAoUcfu3HutoQE=;
        b=B41ch8bKvgd/YUdUq+bN8u39Q55SRTZ8ZFmHio85138E3xxmTXLuKjLIeWEHmCLp7V
         LKWj9Cz4vTWCY6JjjddyHZdmiqQ3jhucI+KJiBOednqQIaIEnyEnpaNJrREj5Fpv8Rio
         bnELD+8TfLH2NalWu3ngKsWn1AQyuX+aQy8Lm6zsYUNY3ttI4+FiwZvLzFyd0E3LmexL
         5LR5pIpcS2iUxqeS1jCNh6gutk3XuIHp4QSYh0BRshIP9HoFWxffe2VrmCXXI/akt+QV
         fjRDSZ8O7JZ8zvI0cnbM0y3zXh9wVnvuPQapNPoq49u7YJ01EoVsi+EhU17nujMcEzN7
         SUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=g/qlLpVwBewkSZkzs4lA44MY1RuupNAoUcfu3HutoQE=;
        b=rZyrvdbAmtgbB8WMWCmgZ6VqnNgE7T/C6nqrRjIbKHgnPZlS/7SDeYOgogfkyO6f5X
         mu0V3FQtSBhyMEKGiBiDVReEXdEARipC8QUnFqsj1X/BiGwGPYrfPt1Zynl9Xf3Gbe5v
         gP5HMlbLTePmwHUtq3TY4EnZPvikCspaS2XcSY51ulNWiB4Er6u7JorNExtVuxbCPVJx
         Eg5+bSoPFEiHVqzv3NlUOyTgl0cjUkVErvfio5jT7ZxBFuvjTGN0u1qmP/QWXa2bGY9I
         91pBQz3ts9XwrdNqAan+LPx0jJEwW/b51ghBP8+D8LI/goWSqv5jFh+jOu4swawU17nO
         Jy4A==
X-Gm-Message-State: APt69E3ny5CdNk+/H1SkdFI8b8TYc1/P8Rs0PRwQ7OImVk9jzWffybep
        kC0dWm9KpRsWRwAXgjWFxlg=
X-Google-Smtp-Source: AAOMgpfKMwi1F4KQvvhorFUu9awa91KRk4gbe5ng/Ctu38Z0WtFTrrgC4AmMyGQV7LSMHXw2mT5pWQ==
X-Received: by 2002:a1c:4004:: with SMTP id n4-v6mr11408240wma.83.1530649252808;
        Tue, 03 Jul 2018 13:20:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o3-v6sm14951wrs.31.2018.07.03.13.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 13:20:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v2 1/7] sequencer: make two functions and an enum from sequencer.c public
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180702105717.26386-2-alban.gruin@gmail.com>
Date:   Tue, 03 Jul 2018 13:20:51 -0700
In-Reply-To: <20180702105717.26386-2-alban.gruin@gmail.com> (Alban Gruin's
        message of "Mon, 2 Jul 2018 12:57:11 +0200")
Message-ID: <xmqqsh50oyu4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> -enum check_level {
> -	CHECK_IGNORE = 0, CHECK_WARN, CHECK_ERROR
> -};
> -
> -static enum check_level get_missing_commit_check_level(void)
> +enum missing_commit_check_level get_missing_commit_check_level(void)

The new name definitely is better than "check_level" in the global
context, but "missing_commit" is much less important thing to say
than "this symbol is to be used when driving 'rebase' (or even
'rebase-i')", I think.  "enum rebase_i_drop_commit_check" with
"get_rebase_i_drop_commit_check()" perhaps?
