Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6650C20A04
	for <e@80x24.org>; Mon, 17 Apr 2017 18:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754530AbdDQSCF (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 14:02:05 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35431 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753071AbdDQSCD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 14:02:03 -0400
Received: by mail-pf0-f179.google.com with SMTP id i5so68910406pfc.2
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 11:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ydK7K0dqx3xAJhmD1jG+04c8uDDGGMXIma1fa5jjQCs=;
        b=ovkAg9nvsMSM5aNF6FZmeI8RcV5C7XMWTW2MmTXnm5QnXR/i5+zW3zKvjyDqH6HzTq
         rK6cuDkyZSv5e/c7Y8cI5VSnFSFBXUQEPtq2LayMxiAZ4wPCQMhDJWhciwJKVrXXKNVY
         sq1K0TsO1LQXu4ZJw4Wm6HyT27lepP1mAmXxlqZstauwApeDdjRcBTRhwhCU0/RKJu3y
         MQx24CxHIlN9o/zPC3fGZJglz+K2Lmrk6FHdj+flfaE0rkqfdQ0+TVjdZ5Z9v4YA7Zaf
         cjXIVafT/A2tTMuRqFpG6hZmIyE4mDGqqTY/gy4YJOAu+YW4Iaryoqu/7zUbssTvnvvG
         WfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ydK7K0dqx3xAJhmD1jG+04c8uDDGGMXIma1fa5jjQCs=;
        b=BS2B7eCn3ADmYh2AqT8tM741g9PAxzLp9P/TGsTX2cUhAWUWVW43zD6fRc8igwuMhv
         PoxbAIY9FnFt6JwUOAsuoaN9VNorn45Rb9hDr1ds9FertuaAj9cJBN4Wzv2DQC84Xdok
         ImzATuFYaS9qUnmzGfsDiwFpC7blGE3HJS5+HtyuLecLGK4guCZKixqKLzmwMFXMh+7V
         KZjiNjFZf6InnIQHVJbGQKskBzv5Ys2WheQ1M+l0PkYzXfu72w2azvsXj6YlKyOT+az/
         3hUli/CArdB4Khpldn1sSzSg8UiDcdMownwaGpz5no9dyUwcrM25uWrFYEP8AkIRrIAB
         8+oA==
X-Gm-Message-State: AN3rC/5TErjir6Rf3QJULLkCjnnFbI+vYWLlZ1W9TSLZWpZmbo/ZaCzx
        UdCNY+CfcFucZT+9SAZc3CegkUljjZ8l
X-Received: by 10.99.146.30 with SMTP id o30mr4820378pgd.183.1492452122888;
 Mon, 17 Apr 2017 11:02:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Mon, 17 Apr 2017 11:02:02 -0700 (PDT)
In-Reply-To: <0102015b7aecbf67-2f63e58b-5f75-4c9b-975f-e8e35176d510-000000@eu-west-1.amazonses.com>
References: <0102015b7aecbf67-2f63e58b-5f75-4c9b-975f-e8e35176d510-000000@eu-west-1.amazonses.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 17 Apr 2017 11:02:02 -0700
Message-ID: <CAGZ79kb01g0AoD0b+ysqd-H049BAX-j0om2pwPqXA7fXhX2Y8w@mail.gmail.com>
Subject: Re: [PATCH] submodule: remove a superfluous second check for the
 "new" variable
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2017 at 12:59 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  submodule.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index c52d663..68623bd 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1396,8 +1396,7 @@ int submodule_move_head(const char *path,
>                         cp1.no_stdin = 1;
>                         cp1.dir = path;
>
> -                       argv_array_pushl(&cp1.args, "update-ref", "HEAD",
> -                                        new ? new : EMPTY_TREE_SHA1_HEX, NULL);
> +                       argv_array_pushl(&cp1.args, "update-ref", "HEAD", new, NULL);

EMPTY_TREE_SHA1_HEX != NULL?

Can you clarify the intent in the commit message?

Thanks,
Stefan
