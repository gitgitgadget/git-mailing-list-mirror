Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 223A31F453
	for <e@80x24.org>; Fri, 21 Sep 2018 17:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390506AbeIUXHF (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 19:07:05 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:43897 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390076AbeIUXHF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 19:07:05 -0400
Received: by mail-wr1-f51.google.com with SMTP id k5-v6so13557012wre.10
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 10:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=M+O5MzokkcL4HM1tsx3ZP7IAevTUDf2KXGzfvbdpdUg=;
        b=pXgc8mSU4J8oSZ/1lXBnDPqu5/R+AQcdvcVErA55IIM51dsPCdB0oTyv18k366eAfz
         ol77N2dvSZL0v3Q/eVjSp9oTeAKlA/gL2meIznOsj3EnAu9wwTiQwFwlxOcPUCBUA7eQ
         PgNCV7iyUQORky5pXAgqMpLeTcsBAQ49B1gC/jhV9y35pyCcfOVmZJLSoBb5RQbKvWiD
         FtVYuygTVKLQxVRUUaO136yPHznDGwFNKLTI5frf0cn75Zmh5ygVlihrDZOvoGYzTf9a
         OtqSY06Ty3DP1MEnMg5/v07DHb381esSQqGVxQBzEwwDujh/BLKMYerWge+kszhWBWSc
         IhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=M+O5MzokkcL4HM1tsx3ZP7IAevTUDf2KXGzfvbdpdUg=;
        b=D19zFPxBoTFdTzyk/05i93zMxxPSzuuhGQQsI6UeJpCEuzvJFOR//IosIaLlRCmMF1
         faGJ+g5nVO0H+ouP3SUD4oIk6xNd0ofSLyCLjr4M2cCyrPdagJ2pA5qTcvHW50OET1N4
         PvmEv567IaZB+fX29a6muG2FwhCl9qZp5N6amlmkbWTbaHwQw45l4bc7uJ4hRqBxKiKd
         VZK0OEp5QKte15WnYHflFpt8OYrxrQKHYzQ03zbpBREb3PteVSKNWSB9go+q/J+uBAu3
         UBJzxqALRcj90B8AbjVTsLbeAoas3GrsfwfDgy0MzyJnbNgK+y9Ea+DKChIsXn/t9EUk
         BpDA==
X-Gm-Message-State: ABuFfojqX6BQXaoiKdDkeOzDDfnK91sRQ7+9CA1Z8BkOki8m3dr2bYEt
        tZ7IZ5QRYff0TewFrv3DjYg=
X-Google-Smtp-Source: ACcGV63zqGFSIuVDOuHIbhws8x4ESHXenrCTVYPU3JvVnvF0ohMBr6+yK8JRkv72HSDMNY3Ugvg1aw==
X-Received: by 2002:adf:d1ce:: with SMTP id m14-v6mr3434170wri.138.1537550233259;
        Fri, 21 Sep 2018 10:17:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 204-v6sm8180474wmh.25.2018.09.21.10.17.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 10:17:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2018, #04; Thu, 20)
References: <xmqqin2zxw55.fsf@gitster-ct.c.googlers.com>
        <e87e83c2-b371-1cc3-7eef-495f03ef05ef@kdbg.org>
Date:   Fri, 21 Sep 2018 10:17:11 -0700
In-Reply-To: <e87e83c2-b371-1cc3-7eef-495f03ef05ef@kdbg.org> (Johannes Sixt's
        message of "Fri, 21 Sep 2018 19:05:59 +0200")
Message-ID: <xmqq36u2wz1k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 21.09.18 um 07:22 schrieb Junio C Hamano:
>> The tip of 'next' hasn't been rewound yet.  The three GSoC "rewrite
>> in C" topics are still unclassified in this "What's cooking" report,
>> but I am hoping that we can have them in 'next' sooner rather than
>> later.  I got an impression that Dscho wanted a chance for the final
>> clean-up on some of them, so I am not doing anything hasty yet at
>> this moment, though.
>
> While playing around with those topics in my own build on Windows, I
> noticed a small glitch in your merge commits.
>
> When I compile 59085279e6, which is today's jch~11, I see
>
>     CC builtin/rebase.o
> builtin/rebase.c: In function 'can_fast_forward':
> builtin/rebase.c:443:2: warning: implicit declaration of function 'get_merge_bases' [-Wimplicit-function-declaration]
>   merge_bases = get_merge_bases(onto, head);
>   ^
> builtin/rebase.c:443:14: warning: assignment makes pointer from integer without a cast [enabled by default]
>   merge_bases = get_merge_bases(onto, head);
>               ^
>
> I notice that you fixed it in the next merge, jch~10 aka d311e29abe,
> by adding
>
> #include "commit-reach.h"
>
> in builtin/rebase.c; this line is obviously required one merge
> commit earlier, jch~11.

Thanks.  Near the problematic merges are

    41e89b1c02 Merge branch 'pk/rebase-in-c-6-final' into jch
    a9794eb0fe Merge branch 'js/rebase-in-c-5.5-work-with-rebase-i-in-c' into jch
    d348159563 Merge branch 'pk/rebase-in-c-5-test' into jch
    d311e29abe Merge branch 'pk/rebase-in-c-4-opts' into jch
    59085279e6 Merge branch 'pk/rebase-in-c-3-acts' into jch
    88091f8941 Merge branch 'pk/rebase-in-c-2-basic' into jch
    38a693a042 Merge branch 'ps/stash-in-c' into jch
    488f36e338 Merge branch 'ag/rebase-i-in-c' into jch

Actually 88091f8941 is already broken.  The merge-fix must go there.

Thanks for letting me know (even though it is very unlikely that
2-basic would graduate without any of these other topics---in a
sense there is not much point for these patches to be spread across
this many topics).

commit a581ba92f4f4e112a7d7e0c84c0ced1af271b7dc
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri Sep 21 10:14:43 2018 -0700

    merge-fix/pk/rebase-in-c-2-basic

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e817956d96..71367c8530 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -21,6 +21,7 @@
 #include "diff.h"
 #include "wt-status.h"
 #include "revision.h"
+#include "commit-reach.h"
 
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
