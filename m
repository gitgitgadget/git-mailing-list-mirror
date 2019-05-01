Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 646391F453
	for <e@80x24.org>; Wed,  1 May 2019 19:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfEATND (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 15:13:03 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37321 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfEATNC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 15:13:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id w37so121707edw.4
        for <git@vger.kernel.org>; Wed, 01 May 2019 12:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=SyREde7Vd7U+bJ7ez2fyxZf0CTSusOy5X0+nSpWEKUc=;
        b=OVuQLfNiugFypoaEHaW6bFHbV6GdZGFQa1N3se+O62RbrsU1WeTjfEW+LrhPFe0wlT
         JJuHfd5F43axtGorCGO6C/pKmpDUTZcrBLM1OynbsFc5K5wn8Fr8FiD31xdQkjc8Vr5p
         KyocdkyduJqk9c6MC4uyKiuA8BFdKzemIgT/FxqhWM8oKHtA3FqGvdvrNqdsUF3WbVKX
         412zr3M44hhRsNQTX0D7n4/qeZMgEaBWzsb6EmNJPbpTRsa6Q4z6IevQSi6TBrLQlLUl
         XPYEQKKIvVWWI2+t9lnETe2pG6apXkGsPiYW1Ekio+k2gXjryJebRetzJGSl0E2dvmk9
         XLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=SyREde7Vd7U+bJ7ez2fyxZf0CTSusOy5X0+nSpWEKUc=;
        b=OYXZk9uN03a5GIzhJSkx37ydjNUU72Vqw5o8CatWb1nmnGnDrQVcmSJSUIjz29k5b4
         pd8KfN3eZCA2EcnFzOloRLi5XKMSXul5BlP8ywfpHhk0bzneih5gw/SnsjfKlTOUXSZe
         iriK1MgpH755NUGoR/P4AYN4HJOhQldzwdJdQDeXUniEyxqs/3pe9KC10TZ8IADlFfAn
         2ueD40u326OGYIYj8iS/NSNjJdOQ2ofv4oBDRQfARJ/F4aAX/9eV5JvhasJ7iZQlYPZ7
         JXvG8Rgp1DIlGRvGFJRrM91YKY7Yiz5f/OLUBSG06VWwEeaumEiaA6depn5FdYK45zBQ
         aPQQ==
X-Gm-Message-State: APjAAAXVZWyU/qbM54m/RhXwR6FhvvJe/s20mJJhss/L/sJW0kDkQvlr
        ugUNfOrzKzr0CTJU65xLbbY=
X-Google-Smtp-Source: APXvYqx/42AksijUAw9drlr4bmnyxuY1HaqOElbguEpe6whCeWr46cPFUPsgsGS96B8QUL0ZezsK9w==
X-Received: by 2002:a50:f405:: with SMTP id r5mr501650edm.258.1556737981440;
        Wed, 01 May 2019 12:13:01 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id f32sm11292edf.36.2019.05.01.12.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 12:13:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 5/6] commit-graph: implement file format version 2
References: <pull.112.v2.git.gitgitgadget@gmail.com> <pull.112.v3.git.gitgitgadget@gmail.com> <cca8267dfeb382005ae3c5a4935f2281dabf26b4.1556716273.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <cca8267dfeb382005ae3c5a4935f2281dabf26b4.1556716273.git.gitgitgadget@gmail.com>
Date:   Wed, 01 May 2019 21:12:59 +0200
Message-ID: <87muk6q98k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 01 2019, Derrick Stolee via GitGitGadget wrote:

>   3. Git did not fail with error if the unused eighth byte was
>      non-zero, so we could not use that to indicate an incremental
>      file format without breaking compatibility across versions.

This isn't new, I just missed this the last time around. I don't see how
this makes any sense.

On the current v1 graph code you can apply this patch and everything
continues to work because we ignore this padding byte:

    -       hashwrite_u8(f, 0); /* unused padding byte */
    +       hashwrite_u8(f, 1); /* unused padding byte */

But now after ab/commit-graph-fixes just got finished fixed the version
bump being a hard error of:

    error: graph version 2 does not match version 1

This v2 code is basically, as I understand it, introducing two ways of
expressing the version, so e.g. we might have v2 graphs with "0" here
changed to "1" for an incremental version of "2.1".

OK, let's try that then, on top of this series:

    diff --git a/commit-graph.c b/commit-graph.c
    index 5eebba6a0f..36c8cdb950 100644
    --- a/commit-graph.c
    +++ b/commit-graph.c
    @@ -1127,7 +1127,7 @@ int write_commit_graph(const char *obj_dir,
            case 2:
                    hashwrite_u8(f, num_chunks);
                    hashwrite_u8(f, 1); /* reachability index version */
    -               hashwrite_u8(f, 0); /* unused padding byte */
    +               hashwrite_u8(f, 1); /* unused padding byte */

Then:

    $ ~/g/git/git --exec-path=$PWD commit-graph write --version=2; ~/g/git/git --exec-path=$PWD status
    Expanding reachable commits in commit graph: 100% (201645/201645), done.
    Computing commit graph generation numbers: 100% (200556/200556), done.
    error: unsupported value in commit-graph header
    HEAD detached at pr-112/derrickstolee/graph/v2-head-v3

So we'll error out in the same way as if "2.0" was changed to "3.0" with
this "2.1" change, just with a more cryptic error message on this new v2
code.

I don't see how this is meaningfully different from just bumping the
version to "3". We abort parsing the graph just like with major version
changes.
