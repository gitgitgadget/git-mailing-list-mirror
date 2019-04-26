Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0083D1F453
	for <e@80x24.org>; Fri, 26 Apr 2019 12:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfDZMdM (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 08:33:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37908 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZMdM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 08:33:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id c1so3023427edk.5
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 05:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=rGQqMkOhZuBmeEwvwgAXAtqLfSOqXAorBGAc6oglq64=;
        b=il89cHAP5I4g206vfRFT9MGvNXMxW+nBLumb1RvMj+VQPjn8LDpvG+mFNKHaa16mZl
         mAFlEHfMj5D4fQvCTPCPOTQ/woPYeipZDum9JzQ3gWN2ghoHl342jJ8jJ5hIpOZSG5hh
         2s/Wkh7biwByAzqdXhFx/Gt3Rk1cVVZcZvbkNTFNexbsJLk7134GL9rrkxlNpadZcgCj
         lIv2wt2ClYd3ued5XqPyJ9voaeMMMadhcfUwG1CNbJvZGzprwK+JZjEuxLhfBFysANMY
         +7RxUBopV4NeBUd0jINzJ0eVSTKA8hRgerIiKVnSLES+gDFmJjAzplrQuh7dc2JA5nrp
         W3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=rGQqMkOhZuBmeEwvwgAXAtqLfSOqXAorBGAc6oglq64=;
        b=Gtm/Bvqzq4jlsQ9Z3m5r0IHz74Zgyb4Gh5KST6LYKK5m4DZ+895jDFUHT/RUpzHsnr
         YeHH9eJkWc7fHbTmpjuj+3InG0RmTnha77wOYJfWlP3rYCeYnlNm8RyiGJpGGTUNyiCw
         at3q2sbUhsAQRKgy22vj9LEwTTAe9J9bVnRBLt1vN0q/KF+hqFLLrcxK6UL47WOMc1br
         JDx+uUSWvQiUa6i3pQUjuGb+T/Ft0kEiN3P3zITQtZAw+R6KGTYZOETwhdHgDVtWhpkr
         4GX+KYOOgggysAhgAE2xMA6PKADyZ5KJTETwqiV+IeeOVnpEe0OoAt6t39yCQETXTnC/
         +pOA==
X-Gm-Message-State: APjAAAVIdF1JJqO3RLXnwpTpkdtsJWQ0VXXHKUyHTKP5i5FRR4o+FC0r
        7HUFfOeD5NGk/G6Hm0NsLWg=
X-Google-Smtp-Source: APXvYqwJYYgdeJyujDL+oiTlwSEXDlUoXDIwU7ZgdHxv5wS44nFDf2cIVPqLw5k4BQ3iwzAg3QYzAQ==
X-Received: by 2002:a50:8a8b:: with SMTP id j11mr13028311edj.212.1556281990760;
        Fri, 26 Apr 2019 05:33:10 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id h60sm6135898edc.17.2019.04.26.05.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 05:33:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] commit-graph: improve error messages
References: <pull.181.git.gitgitgadget@gmail.com> <1751b479e79ba18990e4152ae2acdf60c8713340.1556279303.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <1751b479e79ba18990e4152ae2acdf60c8713340.1556279303.git.gitgitgadget@gmail.com>
Date:   Fri, 26 Apr 2019 14:33:08 +0200
Message-ID: <875zr1rlob.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 26 2019, Derrick Stolee via GitGitGadget wrote:

> The error messages when reading a commit-graph have a few problems:
>
> 1. Some values are output in hexadecimal, but that is not made
>    clear by the message. Prepend "0x" to these values.
>
> 2. The version number does not need to be hexadecimal, and also
>    should mention a "maximum supported version". This has one
>    possible confusing case: we could have a corrupt commit-graph
>    file with version number zero, so the output would be
>
>    "commit-graph has version 0, our maximum supported version is 1"
>
>    This will only happen with corrupt data. This error message is
>    designed instead for the case where a client is downgraded after
>    writing a newer file version.

This looks good to me and is obviously correct:

> Update t5318-commit-graph.sh to watch for these new error messages.
> [...]
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index e80c1cac02..264ebb15b1 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -420,17 +420,17 @@ test_expect_success 'detect too small' '
>
>  test_expect_success 'detect bad signature' '
>  	corrupt_graph_and_verify 0 "\0" \
> -		"graph signature"
> +		"commit-graph signature"
>  '
>
>  test_expect_success 'detect bad version' '
>  	corrupt_graph_and_verify $GRAPH_BYTE_VERSION "\02" \
> -		"graph version"
> +		"commit-graph has version"
>  '
>
>  test_expect_success 'detect bad hash version' '
>  	corrupt_graph_and_verify $GRAPH_BYTE_HASH "\02" \
> -		"hash version"
> +		"commit-graph has hash version"
>  '
>
>  test_expect_success 'detect low chunk count' '

Just a small nit/OCD :).

The only change to that test code that's actually needed is just doing:

    -               "graph version"
    +               "graph has version"

The rest were already grepping subsets of the message before/after, and
maybe worth it to keep it consistent that all these
"corrupt_graph_and_verify" invocations grep the part of the message that
isn't the "commit-graph <whatever>", i.e. now with just that change:

    $ git grep -h -A1 corrupt_graph_and_verify|grep -o '".*"$'
    "graph signature"
    "graph has version"
    "hash version"
    "missing the .* chunk"
    "missing the OID Fanout chunk"
    "missing the OID Lookup chunk"
    "missing the Commit Data chunk"
    "fanout value"
    "fanout value"
    "incorrect OID order"
    "from object database"
    "root tree OID for commit"
    "invalid parent"
    "is too long"
    "commit-graph parent for"
    "generation for commit"
    "non-zero generation number"
    "commit date"
    "invalid parent"
    "incorrect checksum"

Well, there's the sore thumb of "commit-graph parent for".
