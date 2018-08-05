Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21A5208E9
	for <e@80x24.org>; Sun,  5 Aug 2018 05:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbeHEH1o (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 03:27:44 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:37643 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725728AbeHEH1n (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 03:27:43 -0400
Received: by mail-oi0-f48.google.com with SMTP id j205-v6so16731621oib.4
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 22:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QGVnRlt9lnfSyf2dyPOG8+DgpdzA9saTvUIWYH/DwGI=;
        b=HeZt0R5bwlTYbu1ClM1x5bdvzl6zStO1mIm48c2M4EI4BiJjzGGWESgBmB5DUqNUke
         DjA87Zwhw8zrdyBLbuTvIcOvGsTsJNSK2GBuYUBoKGXkAcU0ppK2zNxpH+2Ci6bXV/tj
         EA1Y4F8By0yk2KDCzvr1RflVn5cvqPgIcvakwFcQNaLv9OxIMnVDTeS/oUFtUKp4dU/o
         IVDWSpRrzxgffXUseFYBCHwdNOs4FKP0t/p9F1yTGphcMufTGjbvW0i8eHiK4KXXt98Z
         RQ0M1FSTQDOs8AKopD77nGS+4txyg6I+WUooQlMisFJ29gMhdrTcB9ugHHP+mBJ1V844
         33fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QGVnRlt9lnfSyf2dyPOG8+DgpdzA9saTvUIWYH/DwGI=;
        b=nYXxhQ20FBDT2ZGNONwY2oJPnAVRjkZdYWHpExFA8OzR6O19FTUox1cYb5jVfVHerX
         7/PhWkVc0wmuvNXeIvO8wZj79eUM8tgy9W+/ARKnqEe+s7TZFvTT4B4LgFWRk9EGkTM8
         jNe5GdKCS9/AvmxX72of/qiWmJghF9uPDQ2pXuvsMlZ67v66cutO+nqpa3X2mdZnyBh5
         SYR7NmzphDFTliu5lO0J6Nq66nAsgZsOhxHhrYGtoVH6znET+76Xl1PsGfSpNR9kFfJX
         qzDy3HhWqK6NiAx28UmHH5qyS/mvPmzm+D5X+NR9nZ/pgwV52flF9ttCzGKK+zJcXj/9
         2/MQ==
X-Gm-Message-State: AOUpUlEfHZC83mThpYlcmeo8Tx3EvJHR+9KjeDJFrBnUWfbUFzJr8QjZ
        JaB+Wp41drCi7Hm81OLU+6FF9M+bmagu+T2yiV8=
X-Google-Smtp-Source: AA+uWPz+IGtnPGFw/JHj2AAJRh2GfdnIjraNbYKOwEis6FUbkCF6ybIK12Gd0/9acKHs1tYIc25pMyPqzm7AsmuCnyk=
X-Received: by 2002:aca:cf97:: with SMTP id f145-v6mr10029016oig.131.1533446665543;
 Sat, 04 Aug 2018 22:24:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:70d9:0:0:0:0:0 with HTTP; Sat, 4 Aug 2018 22:24:05 -0700 (PDT)
In-Reply-To: <20180805041956.GI258270@aiede.svl.corp.google.com>
References: <20180805022002.28907-1-wchargin@gmail.com> <20180805022002.28907-2-wchargin@gmail.com>
 <20180805041956.GI258270@aiede.svl.corp.google.com>
From:   William Chargin <wchargin@gmail.com>
Date:   Sat, 4 Aug 2018 22:24:05 -0700
Message-ID: <CAFW+GMBrRUQ88XZzLMVAiEGDjLDwLaW6Qi1mSGrXYHoSu8iJag@mail.gmail.com>
Subject: Re: [PATCH 1/1] t/test-lib: make `test_dir_is_empty` more robust
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

> This subject line will appear out of context in "git shortlog" output,
> so it's useful to pack in enough information to briefly summarize what
> the change does.

I'm happy to do so. I think that "simplify" is misleading, because this
is a bug fix, not a refactoring. I like your first suggestion, though it
exceeds the 50-character soft limit. What do you think of:

        test_dir_is_empty: find files with newline in name

?

> I don't think "xargs -0" is present on all supported platforms

Wow---I'm shocked that it's not POSIX, but you're right. (That makes
`xargs` so much less useful!)

t/t3600-rm.sh seems to just literally embed the newline into the
argument to `touch`. I can do that. (I intentionally avoided $'' for the
reason that you mention.)

> Not all filesystems support newlines in filenames.  I think we'd want
> to factor out the FUNNYNAMES prereq from there into a test_lazy_prereq
> so this test can be skipped on such filenames.

This makes sense. Would you like me to send in a separate patch to add
this `test_lazy_prereq` to `t/test-lib.sh`, fixing up existing uses (of
which there are several), and then rebase this patch on top of it?

> Another portability gotcha: wc output includes a space on Mac so this
> test would always return true there.

That's good to know. I can use `test -n "$(ls -A1 "$1")"` as you
suggest, although...

> "ls -A" was added in POSIX.1-2017. [...]
> That's very recent, but the widespread implementation it mentions is
> less so.  This would be our first use of "ls -A", so I'd be interested
> to hear from people on more obscure platforms.  It does seem to be
> widespread.

...if you prefer, a variant of `test "$(ls -a1 | wc -l)" -eq 2` should
satisfy all the crtieria that you mention above (POSIX since forever,
should work on Mac). The assumption is that a file with a newline
character may take up more than one line, but every file must take up
_at least_ one line, and we get two lines from `.` and `..`. If this
assumption is false, then I will have learned yet another new thing!

> Can you say a little more about where you ran into this?  Did you
> discover it by code inspection?

Sure. Yes. I have a build script that accepts a target output directory,
and rejects if the directory is nonempty. I used `ls -A | wc -l` to
implement this check. When testing the script with Sharness, I ran
across `test_dir_is_empty`. I was curious about the implementation,
having recently implemented the same test myself. The `egrep` in the
implementation stood out to me as suspicious, and so it was easy to come
up with an explicit counterexample.

> I do think the resulting implementation using -A is simpler.  Thanks
> for writing it.

You're welcome. Thank you for the detailed and helpful review.

Best,
WC
