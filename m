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
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B07211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 13:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbeLFNyk (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 08:54:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35965 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbeLFNyj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 08:54:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id a18so1143386wmj.1
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 05:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version;
        bh=F8nWxFeW/EMEck7/0I5lHmZKfdz7yZNfRz7/DmT6rHI=;
        b=G1NfMItT1O5e3iKZ1Z+Z8Ka69p0EKTZeeqn8blKrtwP4jbdAovCnYGls13juaaCc8J
         ibwTNRgiMbhp/RFNyLaUxph34jo242BoavLoB9xeUk6WttF3OmykC7eBiG6PlSZSsGxT
         5Yt16KGyaevD8FdVj9e0kaGfIBviOkp+unbpO9d/g/PgfLLVe/2/lYuBCoIWk7CfUfMa
         ZVsBxtesWlGe6sDgf9G8XQtBQt6b/IEqFa9FYnb5mpX6qaraPChZmQdvWLjM1WXbgUf4
         vU9uhGQ/7ijOPTFhLKavAywTEnwWBDcBR9oHr+vUJSmWJHXES8BZb6BllRzyg3GOadRY
         3lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version;
        bh=F8nWxFeW/EMEck7/0I5lHmZKfdz7yZNfRz7/DmT6rHI=;
        b=rTpUYp1n032yFCIkydmqNki7H5N80oz1wzKfW2pUKHg/XJycwfIszoeXJ09QOmmWzT
         YDDs0EilLUgVMUM/J2NVNYDjB9ufZpQnuIKDBfZEGast7ufT/+mxaX6jBCSXEFw7hqOc
         SdkYTk1HGjFgVumHBmR/MVTKpVjWHGQpKY545PhNTJqpvA72/NbtXxvJa+GQA3Fbcv0k
         2O1bR5ZP+GyYwgJIHbrNVDVeRXtLMNsbWVk8dT/e+c3wfwHwUc3JdcS1QTupVkTtlYJx
         cv0ER6uN5qJ3hPbFRquO+vJIhFDj6dggl6lATJgPCLSRvdf2G5BkovIVFlDhVSw6eJTw
         q0qg==
X-Gm-Message-State: AA+aEWbjLOE/HjddQ0LeMOCh24gLSnOE0tGi0uBRHN8NMs1eMj+GdjcB
        oV/hyU6POoT2Fuu8yuvghTcQ7lQzFwo=
X-Google-Smtp-Source: AFSGD/X0ws5Qbs3uo9XQvOOdTs6gG7ppfk5fj0cYLzzxRmVevHvoewii1ou7hJWxeraZl/Fm0WlHAQ==
X-Received: by 2002:a1c:1d2:: with SMTP id 201mr21259603wmb.69.1544104477304;
        Thu, 06 Dec 2018 05:54:37 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id t6sm374111wru.11.2018.12.06.05.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 05:54:36 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: A case where diff.colorMoved=plain is more sensible than diff.colorMoved=zebra & others
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
Date:   Thu, 06 Dec 2018 14:54:34 +0100
Message-ID: <87zhtiyd45.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's ignore how bad this patch is for git.git, and just focus on how
diff.colorMoved treats it:

    diff --git a/builtin/add.c b/builtin/add.c
    index f65c172299..d1155322ef 100644
    --- a/builtin/add.c
    +++ b/builtin/add.c
    @@ -6,5 +6,3 @@
     #include "cache.h"
    -#include "config.h"
     #include "builtin.h"
    -#include "lockfile.h"
     #include "dir.h"
    diff --git a/builtin/am.c b/builtin/am.c
    index 8f27f3375b..eded15aa8a 100644
    --- a/builtin/am.c
    +++ b/builtin/am.c
    @@ -6,3 +6,2 @@
     #include "cache.h"
    -#include "config.h"
     #include "builtin.h"
    diff --git a/builtin/blame.c b/builtin/blame.c
    index 06a7163ffe..44a754f190 100644
    --- a/builtin/blame.c
    +++ b/builtin/blame.c
    @@ -8,3 +8,2 @@
     #include "cache.h"
    -#include "config.h"
     #include "color.h"
    diff --git a/cache.h b/cache.h
    index ca36b44ee0..ea8d60b94a 100644
    --- a/cache.h
    +++ b/cache.h
    @@ -4,2 +4,4 @@
     #include "git-compat-util.h"
    +#include "config.h"
    +#include "new.h"
     #include "strbuf.h"

This is a common thing that's useful to have highlighted, e.g. we move
includes of config.h to some common file, so I want to se all the
deleted config.h lines as moved into the cache.h line, and then the
"lockfile.h" I removed while I was at it plain remove, and the new
"new.h" plain added.

Exactly that is what you get with diff.colorMoved=plain, but the default
of diff.colorMoved=zebra gets confused by this and highlights no moves
at all, same or "blocks" and "dimmed-zebra".

So at first I thought this had something to do with the many->one
detection, but it seems to be simpler, we just don't detect a move of
1-line with anything but plain, e.g. this works as expected in all modes
and detects the many->one:

    diff --git a/builtin/add.c b/builtin/add.c
    index f65c172299..f4fda75890 100644
    --- a/builtin/add.c
    +++ b/builtin/add.c
    @@ -5,4 +5,2 @@
      */
    -#include "cache.h"
    -#include "config.h"
     #include "builtin.h"
    diff --git a/builtin/branch.c b/builtin/branch.c
    index 0c55f7f065..52e39924d3 100644
    --- a/builtin/branch.c
    +++ b/builtin/branch.c
    @@ -7,4 +7,2 @@

    -#include "cache.h"
    -#include "config.h"
     #include "color.h"
    diff --git a/cache.h b/cache.h
    index ca36b44ee0..d4146dbf8a 100644
    --- a/cache.h
    +++ b/cache.h
    @@ -3,2 +3,4 @@

    +#include "cache.h"
    +#include "config.h"
     #include "git-compat-util.h"

So is there some "must be at least two consecutive lines" condition for
not-plain, or is something else going on here?
