Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C6951F404
	for <e@80x24.org>; Fri,  7 Sep 2018 21:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbeIHCXe (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 22:23:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42183 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbeIHCXd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 22:23:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id v17-v6so16227279wrr.9
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 14:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=c3D/fBRh0ZsL85c5Ij4YyUMFqIFrgy6uEQO87VptI3g=;
        b=bJjgfJt5SEF+6wXmm4LBB3ncp4ObJ7tEiDYZJYRjwe2PBFZ9EGDbbw/2ChpHQz8EJ4
         fbw9d29dDrJ5aTTRBI6Wf1npZOB9QyFDwhCsWtdJ3nOVifAygyD5R4hmOvxZXKrzTazV
         NBgXHHAgYSEHOjaVDLDVN2wp16UZQFpbbZNqmTMiDZ6j0KDilNy+F3RMnjDbVnY8lOD+
         e4l2kIyKyIVEJnACqpOLnJRwZgAoanjqnobbOd2M+6Rwnlr+GkZgsyRFavaEjjxw1UEk
         ulLYNnUxkyIyWfmwckrWog/QIeUqMY2bkbWIh0R5CjSMdwLS9TnQRNtOayurPe/Ge4P2
         CUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=c3D/fBRh0ZsL85c5Ij4YyUMFqIFrgy6uEQO87VptI3g=;
        b=b4RJjNpuKUDNsS5lDBf8G6ss10XtOMOobqnujoPoEx9KdoB9UgKuSxZHQ4R5aHMkFg
         Tjkec4wGoe0KbkMj288reoG78Y9BwlUcdq1h3dvDB8+cR2xh6ZvxrtdssTi00WIU63TN
         EDToHJ+fa11GzCMUJDbgq9w9GKN/s7eED2J8iP6nZ1MJNnegw6PCxeIxtU4a77O7rt0n
         Mj7TvtpKw89mpO56409kwRcvIytYkjtVR3rVIrEDaOpPk7UFBO15cAqRPH5rzf+jr8NQ
         ZTBDej6Pv1zctf/N80wdQH9TmCJ9WAyJcIQQTqQd5h38ANyNt4JLKdYSLoYSS5gnOU4n
         gfCQ==
X-Gm-Message-State: APzg51DwTgiT/4HHdgnD2ljf0x8Mq9uP7Ori0bwOnIqkWcBvHIr7yhX3
        m+d6DZPKrKMoWWTBAa6h2s0=
X-Google-Smtp-Source: ANB0Vdaw1zx4fUt1bqsMSmvMK7lyqtMy8GfCNq7sotkav3COPWyMb+N4vJD2qdhVovN7aHeWXVPbWA==
X-Received: by 2002:adf:9b11:: with SMTP id b17-v6mr7975106wrc.119.1536356437664;
        Fri, 07 Sep 2018 14:40:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k63-v6sm10843361wmd.46.2018.09.07.14.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 14:40:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 0/4] wt-status.c: commitable flag
References: <20180906005329.11277-1-ischis2@cox.net>
Date:   Fri, 07 Sep 2018 14:40:36 -0700
In-Reply-To: <20180906005329.11277-1-ischis2@cox.net> (Stephen P. Smith's
        message of "Wed, 5 Sep 2018 17:53:25 -0700")
Message-ID: <xmqq36ulvve3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Stephen P. Smith" <ischis2@cox.net> writes:

> A couple of years ago, during a patch review Junio found that the
> commitable bit as implemented in wt-status.c was broken.
>
> Stephen P. Smith (4):
>   Move has_unmerged earlier in the file.
>   wt-status: rename commitable to committable
>   t7501: add test of "commit --dry-run --short"
>   wt-status.c: Set the committable flag in the collect phase.
>
>  builtin/commit.c  | 18 +++++++++---------
>  t/t7501-commit.sh | 10 ++++++++--
>  wt-status.c       | 45 +++++++++++++++++++++++++++------------------
>  wt-status.h       |  2 +-
>  4 files changed, 45 insertions(+), 30 deletions(-)

Thanks.
