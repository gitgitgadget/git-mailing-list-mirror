Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 897B720A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 01:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeLKBTF (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 20:19:05 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:35623 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbeLKBTF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 20:19:05 -0500
Received: by mail-wr1-f50.google.com with SMTP id 96so12408171wrb.2
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 17:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=62DnFqC7qUsAaeF1KabREyxWVIhoksNPMNv44VHQwwA=;
        b=cTK16zNZblV4wmiI8NCf7z9/lW7P/3XmrLYHkLK2/44j6TUCGAiCLsH5gZqDJZKQRz
         jk3eJ86nJYubNCPMDDRvSGshfVkTrnMn/TEnkAoifrzC8siYDW5TEwL1YtvTDqK4WYmy
         /ypRccgLNiH3L2jqs/S5XvRWjIpccishdiOndmzVRA6aWYDmtK6X7hwv4aIwaJK3AJe8
         rC9502ocU6ziXtV99NtMdF5KWxQQ7aVOd6uUISR2mV5O90W/CsiJ+bVGoKRcbnTrdqy1
         hWrCpF2zOePht0GkAg8ee1A6EpQRDcztFbehOe/D/bDu5C5R6rYlNnQdAaljCtVXicM+
         7a4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=62DnFqC7qUsAaeF1KabREyxWVIhoksNPMNv44VHQwwA=;
        b=FpAs90+C2pVkBt8GfQqZjoRSo0ZDM+BQ3aF7uPqT6sFvtQRGt5y3j7/QcA6aVt3Flm
         Gga8zJdhR2dRgF4HiaFETmRvgOZdS9trDkZIS0X4s9FNO58TkDO9TLR8YyNKd8RfNekv
         /c8PuqlnOtCo3ce56DHsEtQWy2qCv7c8gZgr1371+FrUjKUvMmO+e0lYG8pJKUOnjiri
         lBB/1GHYHKXhjhkYZSvNJpaJLTZRH4aeZvpie7Z4W/gZ3F/bRRKe+7hticJMqeAsySZ/
         rt9IvIsoeIeis8r17or6mMhHKUWK5QMsmWOrH67vLg9THMHEdEIFUxRM2NEIqgPYKiY3
         4F8A==
X-Gm-Message-State: AA+aEWYa31wqPIaIu3SMlgCK9xKCZ7BPjPac1X193rJE5pD85f1HuvM7
        cIIixt7g+Y1swwgPI2G6qSY=
X-Google-Smtp-Source: AFSGD/UFm1YGdmmRC7wQC16oep2+KIlbR4wlJCdS7bB2EzDMXo25CpACaUKKnI+FzKkmpI28DaTemw==
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr12646380wrx.149.1544491143111;
        Mon, 10 Dec 2018 17:19:03 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d16sm204072wru.52.2018.12.10.17.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 17:19:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     biswaranjan panda <biswaranjan.nitrkl@gmail.com>,
        Bryan Turner <bturner@atlassian.com>, git@vger.kernel.org
Subject: Re: Retrieving a file in git that was deleted and committed
References: <CADHAf1Y_d=-9By4jC2xd+BmWJgfGmBNUr=uSuQtfuHDrarN4kw@mail.gmail.com>
        <CAGyf7-FUHMEq_FfPNrH6uT2b-nCd_wi=Aww+OUuoDem11DROGA@mail.gmail.com>
        <CADHAf1Y8or_frf=Ecu-82z-jo06NKe7oqo1cxtsZsOxhKKxjAw@mail.gmail.com>
        <20181207072004.GA32603@sigill.intra.peff.net>
        <CAGyf7-EkyGOi02fqMcCPBzj-=wpsH4zCgvP5VhOoKMdG+wfoLw@mail.gmail.com>
        <CADHAf1bH5Aaw3-5WvoHawjXUXL9B-YNvh+AYU1fpGbUe=c0E+A@mail.gmail.com>
        <20181208072915.GA20697@sigill.intra.peff.net>
Date:   Tue, 11 Dec 2018 10:19:01 +0900
In-Reply-To: <20181208072915.GA20697@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 8 Dec 2018 02:29:15 -0500")
Message-ID: <xmqq8t0woo6y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> You can feed a set of revisions to git-blame with the "-S" option, but I
> don't offhand know how it handles diffs (I think it would have to still
> diff each commit against its parent, since history is non-linear, and a
> list is inherently linear).

It would diff each commit against its parent specified by the file
given to the -S option.  The contents of the file is fed directly to
the graft mechanism to make the fake history in effect while the
"blame" runs, and you are not limited to a linear history.
