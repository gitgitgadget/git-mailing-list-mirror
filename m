Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE9BB20248
	for <e@80x24.org>; Mon, 18 Mar 2019 06:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfCRGv6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 02:51:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56196 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfCRGv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 02:51:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so11717261wmf.5
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 23:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WYEPoVsNx5VJNzyEmwr9iaNHR+1yLBb9fU6Y9N/Arlw=;
        b=MKiv5GmflYfdMg8eawVhP5r+EwnV8Z8kcakKf8I/hz923QPvSr7INFBDiusTnIfjFG
         PXtNZAEVrqsKlHbQJyfOKZyhG1ECOfY4mPSBTbLZh4ZpW+w4yXIyHBfSOJ7Ok7dYZYEy
         fwjMmKkta2zrSx0Bwei8ijXt3q0cCtYBFM95QJN/hjWHBw2z/ZVeDk/SFxVlfKx51Q/O
         G0ny5eErZDqEzRI6/R64T8t04Ta+M307omP/PgCBa2jYPn89C9ubuf93CZNOBbh0plMb
         pt6NeU6SFagpeW3lZxJTilB6qMeuYiExTEAGB52t7rWgp1iMaBqSM3KNP6sZRFYl1Nfb
         nkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WYEPoVsNx5VJNzyEmwr9iaNHR+1yLBb9fU6Y9N/Arlw=;
        b=KozfJXTqLcxrOo8SagUF2CmXzQ1lxf5JL+kEYJlSydoEBuZUHEdURlWcwmzdu0D+fC
         6XZzfoQEIStI5kjB5/JA3+ztt8smWYrmAiyn+M6S2d04vo54RUvcKNlplXtfuRxuJaIV
         0cRwn087qyUMOKacWUAbVzMU9JU3/QEj/+ZLD7ZLbyaodcL8oFDhVMfiVXK0pCQcDy2q
         kYpVZ/d2uJXXpjN3ci+BZEXNiy+qR1mUMW8DMO+rSe9+U2PRIUeHUFVpD616CXwISFsV
         VVvsw5DQMEEMP1ZQ0/6LLFRHt5aKgZrok764L+clofR/hx7oGGEDxCnLP3GHO6yDeynG
         80Og==
X-Gm-Message-State: APjAAAV4GWvxyDITmd6Wb2f9EOsyMIa+t5dGz3QV6ukNmS9py6HbCytP
        yDpxOh/3gT832p/3pKfNU+A=
X-Google-Smtp-Source: APXvYqx5xYlsCN7UdjzjVFi4QkbDb3vDzOvttcdkC92HFzDocP/mEsW4AecUhYibQMmhOkzNjsBGFA==
X-Received: by 2002:a1c:5f89:: with SMTP id t131mr2256262wmb.145.1552891916353;
        Sun, 17 Mar 2019 23:51:56 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id g8sm4432340wro.77.2019.03.17.23.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 23:51:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] t4038-diff-combined: quote paths with whitespace
References: <20190317230239.10131-1-tmz@pobox.com>
Date:   Mon, 18 Mar 2019 15:51:55 +0900
In-Reply-To: <20190317230239.10131-1-tmz@pobox.com> (Todd Zullinger's message
        of "Sun, 17 Mar 2019 19:02:39 -0400")
Message-ID: <xmqqwokw1xpw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> d76ce4f734 ("log,diff-tree: add --combined-all-paths option",
> 2019-02-07) added tests for files containing tabs.
>
> When the tests are run with bash, the lack of quoting during the file
> setup causes 'ambiguous redirect' errors.

Thanks.
