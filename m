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
	by dcvr.yhbt.net (Postfix) with ESMTP id 79BA11F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 10:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeKUVWM (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 16:22:12 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:41516 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeKUVWM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 16:22:12 -0500
Received: by mail-ed1-f47.google.com with SMTP id z28so4479606edi.8
        for <git@vger.kernel.org>; Wed, 21 Nov 2018 02:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Y6OOf10rxFgxThdaZpgqDvv1wRIh8hbBOco7gJ3ae1c=;
        b=GoXz/cwPHezDz27IoB73KSzLi/a6B/BU3gCBE1m/1Gx7IXzHRwjP/v1RMI3w2b6STT
         dL2/BYWZC/rjtFkQWsc3Y2N9F3Z8JcNXC90A4+/R3kzgAt/k7n1ze/MnAhm2AL1SCr8m
         L00rmYSNYThsBaQ5aCUutUJrwtIlFVUitfLLNFI6k6ZobesU7f5iHHRDXw6L8VjEYSwt
         LnXD/GevQIPzhC7fgd4N9gLUoV4Ft7akwlDxyrBU0cgRBxYQ4L13msi7FE4CYQEVBpEl
         THzpF7GBK1UyUc+RMlMHFFKn5Kh91cAM7zHxiARKwqq3PtO+1htfFcsD5vNONf1BBJl2
         K7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Y6OOf10rxFgxThdaZpgqDvv1wRIh8hbBOco7gJ3ae1c=;
        b=m2XlFGWL1ezv4DvYTZt4wOdrH8Lqd3BYfHRko5gP9RtGdn5SaMlpBDBDV3EHI1u8Kd
         1+QAYpSzxPrpVconBW71JZr8Y2io5uNr0Km3HYDOAVUChuh56hmFQw86rcgQ1eGI2Fpz
         ZLNhAA5oh0V3Y+1uN/cse1CPZEbpXw0UC2nsIrYTMBa+OK6ljRyGolk47HzLfToIii5t
         s0LDbIUCMWbFwSJyqr5GTl7sh46/654wy+GqeO0X2SkP1Z5AtNzFCz83kd5JQQFZP/cV
         ohgCIjrdMkch4HG8O+UFtE15G7gmRvexBxnwlX7Ox7L5itIRi9T686cMVdAcT6oEdwZt
         K82Q==
X-Gm-Message-State: AA+aEWY1RzfFs2TJsbQZMgtVoNVi5dO5DTJQOOV9VEMfN1i9Ju7YT50Y
        YpW/h4K2ETZlgIx88KUMhIo=
X-Google-Smtp-Source: AFSGD/XjVLcCojPhx/1CuYTEIqauvdquVa7qXiP9/0/t0LxNC6MypgUUlT5ztPELstgoD6L3PdMD7g==
X-Received: by 2002:a50:f489:: with SMTP id s9mr5259374edm.101.1542797296827;
        Wed, 21 Nov 2018 02:48:16 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id b49sm11006407edb.73.2018.11.21.02.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 02:48:16 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: What's cooking in git.git (Nov 2018, #06; Wed, 21)
References: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 21 Nov 2018 11:48:14 +0100
Message-ID: <87muq2zoy9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 21 2018, Junio C Hamano wrote:

> * jk/loose-object-cache (2018-11-13) 9 commits
>   (merged to 'next' on 2018-11-18 at 276691a21b)
>  + fetch-pack: drop custom loose object cache
>  + sha1-file: use loose object cache for quick existence check
>  + object-store: provide helpers for loose_objects_cache
>  + sha1-file: use an object_directory for the main object dir
>  + handle alternates paths the same as the main object dir
>  + sha1_file_name(): overwrite buffer instead of appending
>  + rename "alternate_object_database" to "object_directory"
>  + submodule--helper: prefer strip_suffix() to ends_with()
>  + fsck: do not reuse child_process structs
>
>  Code clean-up with optimization for the codepath that checks
>  (non-)existence of loose objects.
>
>  Will cook in 'next'.

I think as noted in
https://public-inbox.org/git/e5148b8c-9a3a-5d2e-ac8c-3e536c0f2358@web.de/
that we should hold off the [89]/9 of this series due to the performance
regressions this introduces in some cases (while fixing other cases).

I hadn't had time to follow up on that, and figured it could wait until
post-2.20 for a re-roll.
