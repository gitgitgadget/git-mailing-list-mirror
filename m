Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CF6E1F453
	for <e@80x24.org>; Mon,  4 Feb 2019 18:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfBDSOk (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 13:14:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38155 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBDSOk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 13:14:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so891933wrw.5
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 10:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yNJzggIzHYsOjP0+oEpa/ZJzQjomKlXV34BkksVRXow=;
        b=LQee2k0pyFgIz9V4HLvBZu+7VnYDoEyiX20BXErzzAr5Z70zGRTr4CcueDpNTK3oWF
         GenRx5N0F0rFDUx9lYv2hOUESBf4mxJTG7zPcBBejfzyyXJiVEd7XP6WUzwW1GVMckgJ
         M945e/iNnQn7gVgTKZUc4V0JGxrQjEyI1pBXfDcSrBnMYOE/m64WfPxkP/lwlj1wlJCY
         p4gZBorv91013YJ5T+wM2IkGf2fovyLqBEn0Sa2cyxuoKzNWzTTXOwnPJV6Gl2tx5xjA
         ZQEcNTK9SqH20uF5ZqsIRIooL1u4hY2rL8KgdNIqgU4moR7z/vE2I/AyMPNyeBIUbLYr
         awPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yNJzggIzHYsOjP0+oEpa/ZJzQjomKlXV34BkksVRXow=;
        b=URwYf0w7rsqPEODJ1ShuZ9g43JbvvmlZbZ66nMT7gYJTof20qIO+DdM5xlGMrnfoT9
         qJ8HIIINcQLjJM9Jd9lKRaPBfeOgjNXe2xVZWkb116FG4/IdmBCW3gsWVhV/3OEByjZj
         X7eceGMtOjxR0rlibxBkW8XYvykTgQZ8N0WTEWHBCCyD6mM57BIcG0/HDFPLmPo/LJA3
         R3PH9SJBrbfedScTWRIb29FBQgyWCVmH7qJed1JZJuRo6ncQaCleobGnZo2ufs/Dy0eO
         We2Xj7A+2yfwNOqgbZgLSnxDkLB1hvMhPuCUUpEai1Wcq+5SkMtyNA3K0PELgJt4SCZh
         akxg==
X-Gm-Message-State: AHQUAubKD0sRmCQVcyKiBvkvAqfnKfdEQ2QvUIJmKcFdiH9UqxTW4ax9
        PmsbBSY5YTDUfow8QaLeguI=
X-Google-Smtp-Source: AHgI3IY6P0u3MlR1WWjKvI7b8518i5dwf4rbwXIynauJzFGwvzwE7xCWiKT6Vjxg3DmRK48mx2zMtw==
X-Received: by 2002:a5d:6889:: with SMTP id h9mr513024wru.222.1549304078364;
        Mon, 04 Feb 2019 10:14:38 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f8sm2623549wrv.41.2019.02.04.10.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 10:14:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Rafael Ascensao <rafa.almas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v7 1/3] ref-filter: add worktreepath atom
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190201220420.36216-1-nbelakovski@gmail.com>
        <20190201220420.36216-2-nbelakovski@gmail.com>
        <CAPig+cSfw=dun__contMMiHrdsZPPN68U4UzfBGz4Yt8DwO7mQ@mail.gmail.com>
        <CAC05386a+FZP8hGawYsfZrmA--JuZBqi_aop7202JQnJEfKyJg@mail.gmail.com>
Date:   Mon, 04 Feb 2019 10:14:37 -0800
In-Reply-To: <CAC05386a+FZP8hGawYsfZrmA--JuZBqi_aop7202JQnJEfKyJg@mail.gmail.com>
        (Nickolai Belakovski's message of "Fri, 1 Feb 2019 14:41:30 -0800")
Message-ID: <xmqqsgx3v2sy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nickolai Belakovski <nbelakovski@gmail.com> writes:

> There's been a little back and forth on it, but my understanding is
> that using the colon separator bypasses the caching mechanism in the
> atoms, so every instance of "worktree:path" in a format string would
> require a lookup.

Would that be a problem, though?  You now have a singleton hashmap
that is a file-scope global not tied to any particular atom, so...?
