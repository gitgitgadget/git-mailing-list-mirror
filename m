Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C7031F404
	for <e@80x24.org>; Wed, 12 Sep 2018 16:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeILVZ0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 17:25:26 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34021 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbeILVZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 17:25:25 -0400
Received: by mail-wm0-f54.google.com with SMTP id j25-v6so10962852wmc.1
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 09:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+ZT3E3NqWGv/vl6AJMaD+93dLPbc9VyLT1ddb2MHHDM=;
        b=ZKiFIdVwsdkZGf85FCeIYB55CPvawndGRm1SBMrpQWjH7QZf6v5H7aUCHz589RFTye
         kF9UXbtXr25ZwtK/B3xSUWvgdgdSi9fGaKkJQsk26yefmwUDfDBtBeA44ElzvmbgOpOa
         9VQuK4PO4Lq/jiP0fOI+aeXfZB9PYpkBHROSP9WPzEVzyb72i6QoO4bqnbBWuRpwUN+E
         sbaTALKkemhjEzQ6LpV6+WgaIJj3MMLN4OG+HKNW0TEkhl1ru540DJtK5P6e5dBDM5hO
         qAJyyKFqFKgW1n3tDXP3tOuFYcrahMstGtJ/x3Kbj3kbiYTYZfEY2Yedm9tCn5jORU/A
         XgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+ZT3E3NqWGv/vl6AJMaD+93dLPbc9VyLT1ddb2MHHDM=;
        b=AVXRvSsFaCwkGpIlXvTqZE/bx0N4dL2MgH1wIi+/erJXCuKZF1oGQ+3OAZ0A8LXtzl
         yVeH0tWG8FxQnwf+NJHy7I4VORQ6QVjLQkLdeJ7S7IcXWPHXtkvfmpZB5E+CqKz4wMGO
         ccAmZ7Iv21EyXTvLe2XTKNToE2wW3rji2Jiy6J4/e2OMObs6r+3E+kzVvx6YYmW1WNyY
         zz06DHbOl5JPu4MeitkSYeIjQknAYaWjS5pJzBvMjmwB/h8gA6dViGokWh234Rj30WPt
         tNMf1CGubLXavsDz3Zg1vPnIxJzo6Jw1NyZGGfk2RrnYWuECHxERN7W3sy9bi1QaosPr
         7ihA==
X-Gm-Message-State: APzg51B68/iklr5/2kgWfF2n9jD507xq0pfMoiyP7p+dyDG6rblCJpAS
        sUsYJGXihpV6W4NZ4m4R0wU=
X-Google-Smtp-Source: ANB0VdbvEQMLtRI8GQwkBZxAmVh8fDyOLIeMpQMTZ2ieRo/YeEV24iWJhWgS4I6JqGX3osFtgqP9bA==
X-Received: by 2002:a1c:b686:: with SMTP id g128-v6mr1971857wmf.83.1536769208939;
        Wed, 12 Sep 2018 09:20:08 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 144-v6sm2173252wma.45.2018.09.12.09.20.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 09:20:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shulhan <m.shulhan@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC PATCH 0/1] builtin/remote: quote remote name on error to display empty name
References: <20180912144504.7498-1-m.shulhan@gmail.com>
Date:   Wed, 12 Sep 2018 09:20:07 -0700
In-Reply-To: <20180912144504.7498-1-m.shulhan@gmail.com> (Shulhan's message of
        "Wed, 12 Sep 2018 21:45:03 +0700")
Message-ID: <xmqqftyen0w8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shulhan <m.shulhan@gmail.com> writes:

> Rationale: consistent error format
>
> When adding new remote name with empty string, git will print the
> following error message,
>
>   fatal: '' is not a valid remote name\n
>
> But when removing remote name with empty string as input, git did not
> print the empty string with quote,
>
>   fatal: No such remote: \n

Thanks for noticing.  I think the consistency given by the patch 1/1
is good.

> Follow up question: If this is ok, should the po files also updated?

They should be updated, but not by you and not as part of this
change.  The po files will be updated by our l10n coordinator,
typically when it gets close to the release time, for all the
message changes done during the release cycle.

Thanks.

