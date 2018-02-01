Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 587651F404
	for <e@80x24.org>; Thu,  1 Feb 2018 19:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754714AbeBAT3R (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 14:29:17 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:51342 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754695AbeBAT3O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 14:29:14 -0500
Received: by mail-wm0-f49.google.com with SMTP id r71so8175279wmd.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 11:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=uZnFHCMMfoSuw0R7DGpgv+09s77gKyvj2wLQLZUp4p4=;
        b=pRWG/1Xwp/gT7B4vnU0U9AlV9Ajc8nkRbENcIB85nHeHNw4yPa3R1lLKC4S6a/8Cx5
         NqEQyRNJn+z6SprmRhZA9reM/wGlLcMNou4g700HQvfm3Fb5ZU0gv6pF+c/lTxcXJkVZ
         X9lBI/Nr3lzXBV8iEaQrbG2OGKRKaQFUb5Jstcf6vHAwGfhJ4kZAhLq4RrTj+5edkeRe
         +U9hgvq0tojWNZlvQEQO7oA8G0nG4W+sAq6FdmyHrEqHjN6qxq0uns8EXHyMpiL/fxzV
         C7SR7VS4tzOZafl0Ximyfu1cw9Q2bKxO2ZaX49WWZrrpWifexL1f6s5oGKcsPsvxYK1Z
         poTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=uZnFHCMMfoSuw0R7DGpgv+09s77gKyvj2wLQLZUp4p4=;
        b=to70/hnJuDHC9jnqWxi5Mjq44000EF+5Bp4KN7UTVZ4aMGjcg/sTinYrgABvhJRc5V
         IJp4iyvH04GwgkTbEASK8Zw8hiAbEM8/RUzcXH32yD6b2IjH2/eyZkALKU/gq6BOGS7h
         QX/rbK33qDtzRCVhN/xHmYO/rFvnC7Zha/ejNYpYBNmRADyqpWbgFPAjbADeiUeS3MA9
         sTflXNBHTveGbISLpNvnz3fYtp/ZYWaRVP1Bnhy183zu9mTgM4+4hnfO4mgOo979q3Og
         JJ4HXJ2bz3zdtk09L46Cfz10ghtR7eLQGGa4JZid9UVw+UkOXdSq1vUjlsnk0xktCfgE
         9eSw==
X-Gm-Message-State: AKwxytedJmBhsV4vewJxdwQfAuff/59fPth2+KnZn3mXdGStU9b46py0
        pKzA316WAmQ3+f+QfYhG12Q=
X-Google-Smtp-Source: AH8x225sKuWC8FqtqgQTwHsV1dC+n4aIktOFxKea30xnJ4Is0lbyuAoxlMJCmxb6Baq0Bn+kaMrGXQ==
X-Received: by 10.80.137.178 with SMTP id g47mr63147409edg.100.1517513353200;
        Thu, 01 Feb 2018 11:29:13 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id 6sm295825edl.87.2018.02.01.11.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Feb 2018 11:29:12 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     sunshine@sunshineco.com, git@vger.kernel.org
Subject: Re: [PATCHv3 0/4] blame: (dim rep. metadata lines or fields, decay date coloring)
References: <20171110011002.10179-1-sbeller@google.com> <20180104224007.214548-1-sbeller@google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180104224007.214548-1-sbeller@google.com>
Date:   Thu, 01 Feb 2018 20:29:11 +0100
Message-ID: <87inbgmrug.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 04 2018, Stefan Beller jotted:

> Stefan Beller (4):
>   color.h: document and modernize header
>   builtin/blame: dim uninteresting metadata
>   builtin/blame: add option to color metadata fields separately
>   builtin/blame: highlight recently changed lines

I like this feature in principle, but I can't get it to work. Building
pu and:

    ./git -c color.ui=always --exec-path=$PWD blame Makefile

Shows no colors. Neither does:

    ./git -c color.ui=always --exec-path=$PWD -c color.blame.highlightRecent="red,12 month ago,blue" blame Makefile

And there's a bug, it segfaults on any custom value to the other config
option:

    ./git -c color.ui=always --exec-path=$PWD -c color.blame.repeatedMeta=red blame Makefile

    0x00000000004c312b in color_parse_mem (value=0x8f6520 "red", value_len=3, dst=0x1 <Address 0x1 out of bounds>) at color.c:272
    272                     OUT('\033');

The repeated_meta_color variable is NULL when passed to
color_parse_mem(). Didn't dig further.
