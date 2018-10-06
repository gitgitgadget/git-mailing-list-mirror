Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 867781F97E
	for <e@80x24.org>; Sat,  6 Oct 2018 23:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbeJGGzm (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 02:55:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53250 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeJGGzl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 02:55:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id y11-v6so1896000wma.3
        for <git@vger.kernel.org>; Sat, 06 Oct 2018 16:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iDVwCECNpQgyRovf4rWgBZ1qnhChk7lU9ZCGPbPOZ08=;
        b=AlSUbTXPpfnVijYCGiKJU0TAVAH5YILjZABfXtLB7vy5N8edaZM3+p4KztWxWie5it
         G/1qvBRt9+lORTaUEtpoAm/5wJZ65UrBcZAuOWGDNqoBX7Ik2zdmV8bWkHoff0CewMU/
         36XtnySdkhJekOT735H3bO4Jd/Zyc9rUx03OF5IxBpWeVpk/7tkooH+4MLVjYgTAhCC7
         iCOnltELncR496QeAyfrv3aD6KkwbTFoOZlWyo1Ht9BJ0bcSQ/MpLlhq9t46bsK4P+gL
         j9bVIWaJO4CwcZ9QsslxpdvCjb6u8+DJXwrdtzYYxWclt2WdcPxN1Fgg6RAHZjCcxZfD
         KG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iDVwCECNpQgyRovf4rWgBZ1qnhChk7lU9ZCGPbPOZ08=;
        b=bdEnVLr/1YrbGLScdw4CyROLmlhnZs/SAbsWd7cXHzpdvVWIX0A6nEkNOO5thS2YVd
         0LavdIlWoA8pAriMfffqq7GIuCMOI1PLYdqsxQZ9htTOGe84tCxjY4d3U7dpeRkUvxe8
         A7WovVUvzpLb+As8QLmg7I0aGKgTnFpAemJ1OrPxojQkA5rm8UPl1et8PMRRmdiJL6Xk
         4ryzMaQil16wrWAfuAgyOHSk/QgpoZUvRNrUZfnmv2MxfgRBXysd8fRkjzU68Oal7GZF
         NmdaxxDtGghA2VtkDrqXGwjVQmkqBhkzVZ4OmZzCUtxLnEiYFeV/qGDlDw4nLOIXkmR/
         LLcQ==
X-Gm-Message-State: ABuFfojl73GS7C1gq5Y7ZB8sZ0vZ4GA0/Eyb/Qtkoz5aSsw7fqBkdPrh
        8Y6ZJWS//j62sXXhJqUlmBFxhRkozd8=
X-Google-Smtp-Source: ACcGV620lcC8e/LPc9IjIF9IR4oDVz3sfLCSwhef3OsRBlttJ1VwAWAM9CI10cGCcwVn906i3Qzopw==
X-Received: by 2002:a1c:87ca:: with SMTP id j193-v6mr10427940wmd.99.1538869828712;
        Sat, 06 Oct 2018 16:50:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w4-v6sm25776793wra.83.2018.10.06.16.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 16:50:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/1] Teach the builtin rebase about the builtin interactive rebase
References: <pull.23.v2.git.gitgitgadget@gmail.com>
        <pull.23.v3.git.gitgitgadget@gmail.com>
Date:   Sun, 07 Oct 2018 08:50:27 +0900
In-Reply-To: <pull.23.v3.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Fri, 05 Oct 2018 08:54:36 -0700 (PDT)")
Message-ID: <xmqqy3bavdmk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Note: while this patch targets pk/rebase-in-c-6-final, it will not work
> correctly without ag/rebase-i-in-c. So my suggestion is to rewrite the 
> pk/rebas-in-c-6-final branch by first merging ag/rebase-i-in-c, then
> applying this here patch, and only then cherry-pick "rebase: default to
> using the builtin rebase".

Is this a stale comment in the context of v3, where we pretty much
know how the resulting topic should intertwine with other topics?  I
am trying to see if I have do to anything differently this time, or
just replacing the single commit while keeping the structure around
that commit the same is fine.

Also, I see there is a new iteration v8 of ag/rebase-i-in-c on the
list, sent on Sep 27th (you were CC'ed but I suspect it was before
you came back).  Are you happy with that update?  Otherwise, we
should make sure that topic is solid enough before extending
(meaning: I'd replace this one while keeping ag/rebase-i-in-c that
has been cooking in 'pu', without updating the latter).

> Changes since v2:
>
>  * Prepare for the break command, by skipping the call to finish_rebase() 
>    for interactive rebases altogether (the built-in interactive rebase
>    already takes care of that).

Thanks.
