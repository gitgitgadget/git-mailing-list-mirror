Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E62AF20248
	for <e@80x24.org>; Mon, 11 Mar 2019 15:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfCKPyR (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 11:54:17 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:38854 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfCKPyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 11:54:16 -0400
Received: by mail-ot1-f54.google.com with SMTP id m1so4375744otf.5
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1atrsTJNa9XZhl7opvP8ME/IpEURo0z+zC7ecRis+Ww=;
        b=J6JqXP9rZz5FD73nxRI8UWS2wrEeZDwEwOcT7yqFmGCPxX+xvc3cWE/K2tXXXAj9kc
         bOfW7EQ+RGIQqXhOto+mEoUyCHjhAw87MehFp59vb14pdxM2paxfm/HMRf+XUVeeGM4A
         5IwEqzPPz64fgzaDFgH8YbH29KiVE3NKxMjnLFlCMH5dMhBHTJQ/zIhuKxrg4XjX3Azv
         EgLIQHeBTxEPSoSYhbqhnHyZ55FourkLMh7mTd+fm6wKnqwqZQkmC3T6E4zLapTKcZn1
         JocvWQSv3DIuNEdFjVWterPi8y17n1rL3hzIefSYt4Bf20DHq+Xw5xSITufXK+gFwk3s
         Z1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1atrsTJNa9XZhl7opvP8ME/IpEURo0z+zC7ecRis+Ww=;
        b=rXDI99XnB/EzZRJX4scBij4AqdwwsawGVnIL9WHqPCw5E41xG56S5RuyjzMEvW0xJ6
         UZylJn/hpfzDxO5Yi4VRT1soIwok3cobz8LIVQ79Srby0nAs0te+9D7jk9o6KSbbI9b3
         9Hrsq053fNWuvhaT225AfK8VU9RKFk0yAXrvzmdCk/Eg4QVry2HkZrkzJ0nAzoU9fJ3i
         0zS5/E31HGb4Ln0VtisthunxRBpdUxEXDaL6ghYg52WKUlQniC2ZY2JLwc2K9rgR9wbL
         1XG5DbfbvAIiYB0i1Kv4Mokcnk1cnI6nqQ/23vrx0QU9nHXxIHSamdgW6sqqnf9DRMc8
         kU7A==
X-Gm-Message-State: APjAAAXqVz+WMKT7kihfHSUptzbYDsSf2HlDpiPw/Z7/KXqdQzscm8nm
        JiDyIZZpoCx8SzRxX0/vnnvdAcfWj7sxyFFb9yMHUA==
X-Google-Smtp-Source: APXvYqwtSwrXHldS9w8KLu2KMJHkFTJg9IVqF7qETWNzNJ/uUJek+1axWUVKN9p2xnQuMr2YSJDEaAcdnsiIhdZdwzw=
X-Received: by 2002:a05:6830:13:: with SMTP id c19mr20059460otp.149.1552319655608;
 Mon, 11 Mar 2019 08:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190310080931.64134-1-ttjtftx@gmail.com> <20190310081023.64186-1-ttjtftx@gmail.com>
 <CAPig+cQxVfZ7L=cFfgAWOzL7Equ2HsFR7si=GxBxj3-mSpCUnQ@mail.gmail.com> <CAOAu_YJKNjGd3mw7K17ySQJeF4XxC+V00FFEYA7o593riEGN1g@mail.gmail.com>
In-Reply-To: <CAOAu_YJKNjGd3mw7K17ySQJeF4XxC+V00FFEYA7o593riEGN1g@mail.gmail.com>
From:   ttjtftx <ttjtftx@gmail.com>
Date:   Mon, 11 Mar 2019 23:54:04 +0800
Message-ID: <CAOAu_YJHOQt=6H2q+hMnsmFGsqZyedDO0LpCqNH_8A484iPyWA@mail.gmail.com>
Subject: Fwd: [GSoC][PATCH v2 4/5] t0022-crlf-rename: avoid using pipes
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, I forgot to Cc.

---------- Forwarded message ---------
From: ttjtftx <ttjtftx@gmail.com>
Date: Mon, Mar 11, 2019 at 11:43 PM
Subject: Re: [GSoC][PATCH v2 4/5] t0022-crlf-rename: avoid using pipes
To: Eric Sunshine <sunshine@sunshineco.com>


On Sun, Mar 10, 2019 at 6:03 PM Eric Sunshine <sunshine@sunshineco.com> wrote:

> All of the patches in this series are malformed. There should be a
> "---" line right here below your sign-off. The "---" line is
> recognized by git-am/git-apply as separating the commit message from
> the actual diff(s).

I will check it next time.

> It is a very well-established custom in Git tests for the files handed
> to test_cmp() to be named "expect" and "actual", so this change is not
> the most desirable. What you can do instead is:
>
>     git diff-tree -M -r --name-status HEAD^ HEAD >output &&
>     sed -e "s/R[0-9]*/RNUM/" output >actual &&
>
> which allows you to leave the test_cmp() line alone, thus (as a bonus)
> makes the patch less noisy.

Thanks for the tips! Now I see why "actual" is the most used name for
output files.
