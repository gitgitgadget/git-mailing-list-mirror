Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA7DF1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 22:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754563AbeDBWxe (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 18:53:34 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37673 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754522AbeDBWxe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 18:53:34 -0400
Received: by mail-qk0-f195.google.com with SMTP id w6so16744460qkb.4
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 15:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ijCoNDAGWjJFy8nOEItPmQf8xFqu6prZKMgoA3jAOtI=;
        b=NwlFNZWBWXAKG5oqqxFVj8ay6pA9eIAY07b0cshnmFvKxSNpVQUTECZnYPtQo2T3Wq
         ygZmPfwM2yjM5s9bLLOUNx6zzgkKZyPwDQHptGugwFwp5gMCFG7eVbLaZuYzsRcOtFky
         3ijRdGyrFjy2YzI9QYv6/Fpgvwyeurcs7JLxEhf89GwacOZWlAKv+no5mlAbf9ZIcY8Q
         nHHDORuROPaSe8VlfYpaSjWy8o7iPBRkkv3o29Rtg2VhdMt/hC8ehNDLd0RFO0mW8Z1Y
         8NJFc9HEvBny0GUmj2c00S3His20q8xZ7AOpYw3Z2GGxkIa1Khvgp5wK+HI1DBeCQ0AF
         f+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ijCoNDAGWjJFy8nOEItPmQf8xFqu6prZKMgoA3jAOtI=;
        b=gxWH+7EDoAWo4HMi+Mf9Pt/NzszTpXfTlbRcQFVdu1RyFIU1EeFn0mxAdn7/sTgLrR
         JFUzQEHnC5jFHjV8Cvyzf4KN+IHuKw6D47LXQkng3ZwLO89uzljTCnmFc7nJ9HXUbvGi
         8oEnFiL5dE9lswUNeqTY4yz9XOaqwiQE9792TahJgO9SkyzBIa3Xy1Hr8A/AtU1I41cl
         nWLG44anDTMwnuRaW5HGGcOd9V3dvqj0AXHrNobCyt8fioMDz02JPQRmr3+1zliGSE1o
         br1EmwrliC2ManW1aFYYLrfWbGpRN83nw+Pe6YZRq2y7kUy9E6Qz01k+jgjXj3TZp0Lh
         YX+g==
X-Gm-Message-State: ALQs6tDk1KgfVBFClprLEbZm3r4Zo8YNK9pzXqd6J6jDuD21K43HGftO
        YCgRN6PXXKhElFuwxQwLOJ5CJTBDTXxuE6dSbBg=
X-Google-Smtp-Source: AIpwx4+T9PLUFC0K+r59HBKCU0jNnWNWjHsJOY5F/TcxIiHcpjc73msa12QLnf2jm7av8Rd+zPVpSjoFclNh03RWH/g=
X-Received: by 10.55.3.140 with SMTP id 134mr15814116qkd.26.1522709613291;
 Mon, 02 Apr 2018 15:53:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 2 Apr 2018 15:53:32 -0700 (PDT)
In-Reply-To: <20180402221124.88049-1-haraldnordgren@gmail.com>
References: <CAHwyqnV8tB63gQFVJhyNtr304Uv1TwWvYiX+3wuU0fDFhOphgg@mail.gmail.com>
 <20180402221124.88049-1-haraldnordgren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 2 Apr 2018 18:53:32 -0400
X-Google-Sender-Auth: qypdjKtZyGIAlr6Z1m3k9kHZSWo
Message-ID: <CAPig+cRTcY+XNedi=PdfRWpWR-LTAVvR4kkKkrs1e58LLYd3-Q@mail.gmail.com>
Subject: Re: [PATCH v5] ls-remote: create '--sort' option
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 2, 2018 at 6:11 PM, Harald Nordgren
<haraldnordgren@gmail.com> wrote:
> Create a '--sort' option for ls-remote, based on the one from
> for-each-ref. This e.g. allows ref names to be sorted by version
> semantics, so that v1.2 is sorted before v1.10.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---

Please take pity on reviewers and use this space below the "---" line
following your sign-off to explain what changed since the previous
attempt and to provide a link to the previous round(s), like this[1].
Thanks.

[1]: https://www.youtube.com/watch?v=r_8ydghbGSg

>  Documentation/git-ls-remote.txt | 12 +++++++++++-
>  builtin/ls-remote.c             | 26 ++++++++++++++++++++++++--
>  t/t5512-ls-remote.sh            | 41 ++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 75 insertions(+), 4 deletions(-)
