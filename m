Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283D8C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 22:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiLOWp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 17:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLOWpY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 17:45:24 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F3258BF2
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 14:45:23 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d82so576578pfd.11
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 14:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Yba0TW6dzaKmIC8oABVxGRc+679sWvocOLcM4/tISrs=;
        b=JrEBPzCann6MBQQrHegoU/NlwU/w0emUNdScW2Pb8sd5ZzUW8LTLpOp7nueNIw3njE
         GgBgKZ3mpdQxLURCSM5YVJYk9p0f8xrzUce+Z0uMTJVci57hY1MAsgoj5H8RDricYLNK
         BmAvJJIw7AEnCAvyB3EWOJ/Wfdkm/2Qtw6+wYBt+XXz/2Ytl3nYure58pgtfmq5quN9u
         ws3sNRaJJl07a7LqjFs8hqvuMsxeNsrhoU93ZGq3d2Ns/I7h3p1zx+2jaP+x2K14l56o
         yNI1vCenR8PJxX3ywoFIDqKg9erwqQCX4j0d5CfiK9a457GhU7hDVjBn+Q7oTr012ZG3
         ws4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yba0TW6dzaKmIC8oABVxGRc+679sWvocOLcM4/tISrs=;
        b=OUiePa2hZiceoebfjSn56N1MgyUjOGXql7WVbunxYz7vz2WNHD8SMjACJtKTap2nIR
         ltjdo9zubS0J/3twF1WdyCX5Eg3QYXPRUW3XtVwfVFL1cK7xJxVcdHu48uq00IiI1EmQ
         L3W0Vilp+yaZNdT8nHLgAAqBtQlf8KouhO+pwsGp3+wqzNHSjIk6HM9U513OGyU72C+G
         2o9+sQyu/ZvCbKfvzHk0itojEma260q/pt/Vue7mpRK/0N/mU5sQBQt0C9WM4/AXw+S9
         IBh8QkPV+hfIqH9Mt1vGH37/zSC//G0Vn8RDWYlE7Ba0wjkhsbLXgeldrMldlJ2zBV+n
         DwDw==
X-Gm-Message-State: ANoB5plMspeme7IV4uSq74EJbMnePFNFwDXsPDeo7EwOmcAGDCgD3sO+
        D18jnNYghav2jV4w+oemwOBt+NRaJqeN0w==
X-Google-Smtp-Source: AA0mqf4RATRJkYQUUxhyJhPNVKKPVOeWPgMe9Apm6N1JDaXrKc32YZC1Pw65FnbL5Ld2qytpTRY6dw==
X-Received: by 2002:a05:6a00:290e:b0:566:900d:6395 with SMTP id cg14-20020a056a00290e00b00566900d6395mr29011321pfb.21.1671144322763;
        Thu, 15 Dec 2022 14:45:22 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w7-20020aa79a07000000b0056c2e497b02sm104444pfj.173.2022.12.15.14.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 14:45:22 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2022, #05; Wed, 14)
References: <xmqqiliewbje.fsf@gitster.g>
Date:   Fri, 16 Dec 2022 07:45:22 +0900
In-Reply-To: <xmqqiliewbje.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        14 Dec 2022 18:59:49 +0900")
Message-ID: <xmqq359gqoal.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

Let's mark the following to "Will merge to 'next'" again.

> * rs/t3920-crlf-eating-grep-fix (2022-12-07) 1 commit
>  - t3920: support CR-eating grep
>  (this branch uses js/t3920-shell-and-or-fix.)
>
>  Test fix.
>
>  Will merge back to 'next'.
>  source: <cbe88abc-c1fb-cb50-6057-47ff27f7a12d@web.de>

With reviews by Philippe and Eric, this one still looks reasonable.

> * ab/t4023-avoid-losing-exit-status-of-diff (2022-12-05) 1 commit
>  - t4023: fix ignored exit codes of git
>
>  Test fix.
>
>  Will merge back to 'next'.
>  source: <patch-v2-3.8-c5feef1c808-20221202T000227Z-avarab@gmail.com>

Simple, obvious and trivially correct.

> * jh/t7527-unflake-by-forcing-cookie (2022-12-02) 1 commit
>  - fsmonitor: fix race seen in t7527
>
>  Make fsmonitor more robust to avoid the flakiness seen in t7527.
>
>  Will merge back to 'next'.
>  source: <pull.1437.git.1669937534944.gitgitgadget@gmail.com>

<xmqqfsdgqonk.fsf@gitster.g>.

> * rs/plug-pattern-list-leak-in-lof (2022-12-02) 1 commit
>  - list-objects-filter: plug pattern_list leak
>
>  Leak fix.
>
>  Will merge back to 'next'.
>  source: <b4361c3e-852b-e30c-f240-86c34bc9c474@web.de>

Simple, obvious and trivially correct.

> * rs/t4205-do-not-exit-in-test-script (2022-12-02) 1 commit
>  - t4205: don't exit test script on failure
>
>  Test fix.
>
>  Will merge back to 'next'.
>  source: <c5b4d091-23c1-5a75-a255-99ec83973d8d@web.de>

Ditto.

> * ab/t5314-avoid-losing-exit-status (2022-12-02) 1 commit
>  - t5314: check exit code of "git"
>
>  Test fix.
>
>  Will merge back to 'next'.
>  source: <patch-v2-1.1-ca77a7249e6-20221128T141818Z-avarab@gmail.com>

Ditto.

> * ab/t7600-avoid-losing-exit-status-of-git (2022-12-05) 1 commit
>  - t7600: don't ignore "rev-parse" exit code in helper
>
>  Test fix.
>
>  Will merge back to 'next'.
>  source: <patch-v3-1.8-64dfec31fb3-20221202T114733Z-avarab@gmail.com>

Ditto.

> * jh/fsmonitor-darwin-modernize (2022-12-05) 1 commit
>  - fsmonitor: eliminate call to deprecated FSEventStream function
>
>  Stop using deprecated macOS API in fsmonitor.
>
>  Will merge back to 'next'.
>  source: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>

This one was updated <pull.1436.v2.git.1671045153981.gitgitgadget@gmail.com>
