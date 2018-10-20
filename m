Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_IMPORTANCE_HIGH,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1ED01F453
	for <e@80x24.org>; Sat, 20 Oct 2018 23:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJUH4h (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 03:56:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52652 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbeJUH4h (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 03:56:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so6815534wmw.2
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 16:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:importance:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=58qWktnurCP52s33Z5qXyOX6fXWLrD+8JS4IETB5erg=;
        b=emhFVDkeeNbgPMNcSMzoELmC2H/vlid2gDTGS6Z6PHXlvqb+SQbDSi+avUaxmes8cZ
         keEi1Q5m/B/EWmhkWkOU3Mku0PXj1ghVlhpDRfuaMpZ05DISCrFvQm319TuEP7H2yb2E
         JgTflI01hV9yrdr2SmA2hxNxRnz4g+YvFUSszw7iUuEht59NOGwfxoOrtJRboMU0jDdC
         lQISrTSObv7qhp9D9wj/Fr/35hecaJS8zdK+AargjxTy0F/ZDN/F4E1cd98XhjNAs4BZ
         63HOeRYhY7WXhWsAiGK9gLUScD20Alj9xLJzrKQka0Op+SmzTHFDjeQ4raaUw/zz8uSc
         7Ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:importance
         :date:in-reply-to:message-id:user-agent:mime-version;
        bh=58qWktnurCP52s33Z5qXyOX6fXWLrD+8JS4IETB5erg=;
        b=ov/FyJEko8VJ/xIqOe51ndgvyV8VeTUS0x7pQKLeWS0SuU2QwFw+g8yrFqnTdaJZZb
         lauFjYpoaXBadUWgVw0xMtAqc6MPZzGAcMNisabaucIoX3BP44FjhWqq1xkCT09xHTwQ
         GQ9x8oaBgCFYxixjnegE8/Ya85qH0gJ7oF8tsIUNgBEH063taAfaW3dRtUslcwwu4c4V
         /d/SJ0ZxL5iJmreI0GxbQbIt8oyRcs+fN8kP2DMv8/BlSYeUBgUIkaGiJDcIEQ61uMi5
         73Ia2KsxzFy9D+PG2vwBqVUgbTHQaCIWOXhj8TRjEwnqU8fSp8IVjfMghPURhfC3Mjaj
         D2/A==
X-Gm-Message-State: ABuFfohmwtQyyCBebEKiGtlW460MEaPpcsNFXbLutzk2cBp8F2yyHt6t
        N+H2EdWqoqTf9SqJeX7DEKg4r5kmuD0=
X-Google-Smtp-Source: ACcGV62hmxOqtWX28YeNxt4uVT3YqHZ1ZHRP/sTDbaArK1XYlTdoDzxMW3H0Gjr3lZO+Nd9su4+lug==
X-Received: by 2002:a1c:1dc8:: with SMTP id d191-v6mr10052667wmd.27.1540079062012;
        Sat, 20 Oct 2018 16:44:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p7-v6sm9407808wrt.10.2018.10.20.16.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Oct 2018 16:44:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2018, #04; Fri, 19)
References: <xmqq8t2u1nkh.fsf@gitster-ct.c.googlers.com>
        <20181019124625.GB30222@szeder.dev>
        <6e4fdcdd-6c50-a07e-74b7-1fcd15c33444@gmail.com>
        <5f0fb76f-0774-3545-38fc-b86137f747fa@gmail.com>
Importance: high
Date:   Sun, 21 Oct 2018 08:44:20 +0900
In-Reply-To: <5f0fb76f-0774-3545-38fc-b86137f747fa@gmail.com> (Alban Gruin's
        message of "Sat, 20 Oct 2018 16:31:59 +0200")
Message-ID: <xmqqmur8yyi3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> The error comes from the call to `git stash apply $stash_id' in
> builtin/rebase.c:261.  When $stash_id only contains decimals and no
> letters, git-stash tries to apply stash@{$stash_id}[0][1].  Thas was not
> a real problem with the shell script, because it did not abbreviate the
> object id of the stashed commit, so it was very unlikely that the oid
> would contain only digits.  builtin/rebase.c shortens the oid[2], making
> this problem more likely to occur.

OK, so make "rebase in C" a faithful conversion of the original, the
code that lead to builtin/rebase.c:261 must be fixed not to pass a
shortened oid.  I suspect that internally it has a full object name,
so not shortening would be the right thing anyway, so regaredless of
this bug, it probably makes sense to do the fix.

But as you said, even the scripted version that passed the full
object name had a (10/16^40) chance of using a 40-hex that only has
[0-9] and caused the same breakage, so such a change to "rebase in
C" is sweeping the age old bug under the same rug, in the context of
discussing this particular bug.  

I agree with you that it is a better fix to the problem to allow the
caller to say "I am giving an oid---it may (or may not---I do not
even bother to check) consist of only digits, but do not treat it as
an index to the stash reflog."
