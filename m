Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_24_48,DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FCB61F804
	for <e@80x24.org>; Fri, 28 Dec 2018 20:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388039AbeL1UNE (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 15:13:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36008 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbeL1UND (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 15:13:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so20481046wmc.1
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 12:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=/lEtI7xKttMEUPYCqJUka+WqvHe8QDc2aoP0fHa8jq8=;
        b=KxSZU46zBPPl8Fygv5IdeD89bzlMYtqaUXkcGgjkQc5rYLraaxX2xYIrUd2z3ircC2
         fpXUwmCgVmtghRjNPm2MCrIotHERO+kHaNc3C3v7tFZBdsgT7JYt0V7JRcixtqaULdDU
         1eE5QXoL+YdU7+V00Wopa9eeJ7UVkNAIfQ1f/39/X1I8c9PcIm8ieNeV+tx9S9IH855c
         SggVQEktvorjAcE7ZD7650KVMiJzgxlGIWFh9zfZoD81lfoAMA04hZfrbbSWzTDGcC9N
         kMxfsPPeEBQbAD25Fqu0M4R2E1to8E80oE+CDmMXrSyzZPUkVlbRslwPhBalAktV45GG
         mO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=/lEtI7xKttMEUPYCqJUka+WqvHe8QDc2aoP0fHa8jq8=;
        b=VLr0kjIjmxAtTYlQRY4KBA+38Gpi8oMKZifxZN4WxUqyrjgsaprtttyn00qO4EBU/z
         5cCEEmJu5Pj67xowEfnJZrP/7r0mTEOLSHYCP69UF3DrvF4eMWt7j2kBayMnzvc/uTiV
         /lpzBqgqDn8WWSZjpSAjulSfrgBgAqSX/VSfrjyjMFXitsH8VfFKFTt5C73GT3iSidGL
         VIRXwHIbJkvhbH0BoAjBjHDgMulJTRLAnBwRvs9jAH1S8spuuj8l4BWCGNh2k6AWBqGL
         PTE+bQLP+ESQk2uPuuJbC/iFvMnsh8aoJ6nx7okgdusOurXKM+GPJC1WgDyA4pV0yBZc
         DnlQ==
X-Gm-Message-State: AA+aEWYooEQyXXnsRkvzL5JXFkWNvx446kB9CnW0hKPqYLX5uarlPjYZ
        qliak2Vr/XpJFVXx5y54jEU=
X-Google-Smtp-Source: ALg8bN5Xg69XU9v61+XQg717rr/L+7JY2D6YDc2EbUI5IZ/r6tvl2A+Jr3Miv7Esjr02PqFPrH5SnQ==
X-Received: by 2002:a1c:8b44:: with SMTP id n65mr26143699wmd.104.1546027980394;
        Fri, 28 Dec 2018 12:13:00 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 126sm71373134wmx.26.2018.12.28.12.12.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 12:12:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        avarab@gmail.com
Subject: Re: [PATCH v3] log -G: ignore binary files
Date:   Wed, 26 Dec 2018 15:24:05 -0800
References: <1535679074.141165.1542834055343@ox.hosteurope.de>
        <f7cb34c6268f556772fa4ee374e2541ba518e2b8.1544811828.git.thomas.braun@virtuell-zuhause.de>
Message-ID: <xmqqlg49mmus.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:

> - The internally used algorithm for generating patch text is based on
>   xdiff and its states in [1]
>
>   > The output format of the binary patch file is proprietary
>   > (and binary) and it is basically a collection of copy and insert
>   > commands [..]
>
>   which means that the current format could change once the internal
>   algorithm is changed as the format is not standardized. In addition
>   the git binary patch format used for preparing patches for git apply
>   is *different* from the xdiff format as can be seen by comparing

This particular argument sounds like a red herring.  After all, when
the --text option is given

>
>   git log -p -a
>
>     commit 6e95bf4bafccf14650d02ab57f3affe669be10cf
>     Author: A U Thor <author@example.com>
>     Date:   Thu Apr 7 15:14:13 2005 -0700
>
>         modify binary file
>
>     diff --git a/data.bin b/data.bin
>     index f414c84..edfeb6f 100644
>     --- a/data.bin
>     +++ b/data.bin
>     @@ -1,2 +1,4 @@
>      a
>      a^@a
>     +a
>     +a^@a

we will see 'a' in the output no matter how xdiff internally works;
there is no way to express the above change textually without
showing "+a" somewhere in the patch output.

The rest of the log message looks good, and ...

> Changes since v2:
>  - Introduce a setup step for the new tests 
>  - Really start with a clean history in the tests
>  - Added more complex commit history for the tests
>  - Use test_when_finished for cleanup instead of doing nothing
>  - Enhanced commit message to motivate the change better
>  - Added some more documentation

... the tests are certainly a lot easier to follow.

Thanks.
