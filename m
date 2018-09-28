Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CB661F453
	for <e@80x24.org>; Fri, 28 Sep 2018 18:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbeI2AZW (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 20:25:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33146 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI2AZW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 20:25:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id f10-v6so7329284wrs.0
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 11:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HYWXH3u6Wh0OC/nYwfyWfuXYVZasXkIt6f5fdWZRVlY=;
        b=tpuxUIvsyFo2a/4HwuECI7P2RpxA6rOImdL4qyFYAFmuBaxZGL07hysw6Se/KcUJYt
         fYrZdTyxTJYj18LAKZ7UMzglLZZUlxz1bin1Kq/Haha/INZ+h4L+t5k9i4uwCVDLM5n/
         rNlH38OUYF/ANoiTV4IBY+5Ssm9z7lllpzcppUIBLN7pkjyBRvUfUsP7ZxLcTZWAQm6z
         3aUU9fcvqMULXoXAFsNxGc93+yMfDnOPLUg1/+R1q67QxV/NLi9jqt7+1RYWqorlNny4
         Npk5GhYTIKcbV0VFQCHW2+w0VZc2xflzZt81Q3rWrvIKkfBx+dt1fRw+Svr6JLFOGpJO
         RF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HYWXH3u6Wh0OC/nYwfyWfuXYVZasXkIt6f5fdWZRVlY=;
        b=VmmwJlxqNWzTbkdkyGgTF28fJjKhJozIsyBOSKVUbDdcJUIKbSICL/p/V2aax4cDQB
         XpjS1mo+RIPxAOzjl3Ta0lAOvaIiju6we9Tcg1YVCrtkThbExsssNsIZNM5T0yqsUDt3
         7h2yOk36D/1NZe/F8rjONmVlG7svJKVzkzXxPpLVa273fzlt+pqavVLXhr5vwJgPurnl
         mFEJxsfPfOQ8ehr0Eqqzo4kU7tCkhiKr/92s+eVI0XyDIngNVF0Ho4d/PaOJ3taUaPTj
         ckjLO44JJw9KqyR8tI5LmZTmY2ZmUAToUghL3brNLGS6Uj8moqs44GC7rNA2JgtUzKTG
         snng==
X-Gm-Message-State: ABuFfoi4sBRtwaMNm6YOBfzK4Su6YaoJQD3T5WFk0rJ+Y1D8LFvbnhD8
        bxZYb5M9nnDsV8PvddiY+2c=
X-Google-Smtp-Source: ACcGV63vxm2Fj4IyX0nqnUpfJUQsnOI+4335cO1btLgQVzbMCGNfdQxXyiCojDMzUyADj3oOk073Dg==
X-Received: by 2002:adf:db11:: with SMTP id s17-v6mr13627565wri.221.1538157625921;
        Fri, 28 Sep 2018 11:00:25 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t14-v6sm2452550wmi.35.2018.09.28.11.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 11:00:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sam McKelvie <sammck@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] submodule: Alllow staged changes for get_superproject_working_tree
References: <20180927181054.25802-1-sammck@gmail.com>
        <xmqqbm8ifvka.fsf@gitster-ct.c.googlers.com>
        <D09E2583-BD1D-4C56-9C19-6B1E97CEEDAA@gmail.com>
        <xmqqmus2e6rp.fsf@gitster-ct.c.googlers.com>
        <37DC7525-209F-49CC-90AA-D55463456D20@gmail.com>
Date:   Fri, 28 Sep 2018 11:00:24 -0700
In-Reply-To: <37DC7525-209F-49CC-90AA-D55463456D20@gmail.com> (Sam McKelvie's
        message of "Thu, 27 Sep 2018 20:29:40 -0700")
Message-ID: <xmqqftxtcxjb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sam McKelvie <sammck@gmail.com> writes:

>> Ah, that, too.  I meant to correct triple ell, though ;-)
>>  ...
>
> I wholeheartedly approve of that plan and your tweaking commit below. Thank you, Junio.

Thanks for a fix.  But now I re-read the title and think about it,
this is mistitled.  The word 'stage' in "ls-files --stage" is not
about 'stage' people use when they talk about "staged changes" at
all.  The latter is what "diff --cached" is about---what's different
between HEAD and the index.  The 'stage' "ls-files --stage" talks
about is "which parent the cache entry came from, among common
ancestor, us, or the other branch being merged".

Also we are not really "allowing" with this change; "allowing" makes
it sound as if we were earlier "forbidding" with a good reason and
the change is lifting the limitation.

We used to incorrectly die when superproject is resolving a conflict
for the submodule we are currently in, and that is what the patch
fixed.

submodule: parse output of conflicted ls-files in superproject correctly

is the shortest I could come up with, while touching all the points
that need to be touched and still being technically not-incorrect.

Or perhaps

rev-parse: --show-superproject-working-tree should work during a merge

may be more to the point.  It does not hint the root cause of the
bug like the other one, but is more direct how the breakage would
have been observed by the end users.

