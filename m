Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88FB91F428
	for <e@80x24.org>; Sun, 29 Apr 2018 23:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754527AbeD2XrN (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 19:47:13 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39743 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754409AbeD2XrM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 19:47:12 -0400
Received: by mail-wr0-f195.google.com with SMTP id q3-v6so6473195wrj.6
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 16:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lp1U5hn/wUo7XToi31DZRbMZTRiYCJeCfUSOv2wHIzs=;
        b=Qu14fJVmQNG01Djgun3sCK6tYZnXqf0P0ipLFm+LEXI85zSBAxas1lmY2dBs6ucfgQ
         RrJONy9vX4ky1i46x8G4DwVDeGSd8m+3izN+zj6GHpe8MKyEukowx6j96ciGfKlrNrZA
         0a3GUHcQC+MmBJRMyCI4pYLFRScRlKE4AM/C+S8dDNu5WPWgkOPnvK4/qmdUOgltnY8J
         vB4NylLwV31Bx65jkH3rfcLjteImCTKJdmoiAKixTGPFKNVTVmvQyBPH300OTLaD/CCh
         JRQvepFR+K0E5DIP39WfTag5sHbkhKCxJT8jO5l7taHhd8BL++BKSyRGaGJwce5QxmZh
         kdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lp1U5hn/wUo7XToi31DZRbMZTRiYCJeCfUSOv2wHIzs=;
        b=oyBMR6P3tdwMPC2jvVI920NhT/CaSjxiIgdhvjN9i3uaYaf0aLt/uK28DIzo1UGdlt
         Kkh7Mc8/v7EA24oqBi5n/epgKxbYyS3W1ydHcWqxOdkPKTamWaGJaNQVXH8V6qFFZXq1
         F4WmHrG0XMg9PkrwL/xqeFxR08KbxaJN5BDbKOeN/9Dq6Q+yscodXvGENMzWEU3njdLT
         MvnlxfRwoJz9azCITRtzBP/GK9V9GR9abcBt5HphKJJYslqgBDVo/pxt1B2PMyT5lFZD
         JJowGruJSRSakNxdGrOP11CR25dLt3/KvCy1MHWeuqSs3JlcS8qTPCcQ1AjJXS73qJBS
         zBIg==
X-Gm-Message-State: ALQs6tBzdBGEGaZXuipOVybYkKX9dZXJy42FMYvJQ7IMtYxLdXpn6Mn8
        xgjYVYnjsaaJiBPCvj2hZjQ=
X-Google-Smtp-Source: AB8JxZpFz5KVYmm149yNJW0NuttXVq+yt3MpdAAb6Uka8udUyFdWs3JCrmOu8/8BDMJqHl1JTvtGBw==
X-Received: by 2002:adf:b00f:: with SMTP id f15-v6mr8092269wra.254.1525045630762;
        Sun, 29 Apr 2018 16:47:10 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p128sm10363575wmd.45.2018.04.29.16.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Apr 2018 16:47:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
References: <20180413170129.15310-1-mgorny@gentoo.org>
        <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
        <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
        <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
        <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com>
        <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
        <CACsJy8AVTkqDomQW7Np5opnK+bMk53pcMtCQRBr-=QXEXs8Nqg@mail.gmail.com>
        <CABPp-BGPA5BVh7NpBeat+9f0-=ryNg61tf1osgKXGLGDBN1U6w@mail.gmail.com>
Date:   Mon, 30 Apr 2018 08:47:07 +0900
In-Reply-To: <CABPp-BGPA5BVh7NpBeat+9f0-=ryNg61tf1osgKXGLGDBN1U6w@mail.gmail.com>
        (Elijah Newren's message of "Fri, 27 Apr 2018 14:08:06 -0700")
Message-ID: <xmqqtvrtzibo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Here's a crazy idea -- maybe instead of a list of pathspecs you just
> provide the timestamp of when git checkout started.  Then the hook
> could walk the tree, find all files with modification times at least
> that late, and modify them all back to the the timestamp of when the
> git checkout started.
>
> Would that be enough?  Is that too crazy?
>
> Sure, people could concurrently edit a file or run another program
> that modified files, but if you're doing that you're already playing
> race games with whether your next incremental build is going to be
> able to be correct.  (Some (annoying) IDEs explicitly lock you out
> from editing files during a build to attempt to avoid this very
> problem.)
>
> That does leave one other caveat: If people intentionally do really
> weird stuff with having files with modification timestamps far in the
> future.  However, it seems likely that the group of people doing that,
> if non-zero in number, is likely to be dis-joint with the group of
> folks that want this special
> uniform-timestamp-across-files-in-a-checkout behavior.

These two groups may share the same degree of insanity ;-)

But the single timestamp idea certainly sounds workable, except that
care must be taken to make sure we really grab the fs timestamp (it
is not uncommon for ">F; stat F" to yield quite different time from
"date", when the filesystem is on a remote box).
