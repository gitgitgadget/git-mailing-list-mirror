Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A7211F406
	for <e@80x24.org>; Tue,  2 Jan 2018 10:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbeABKLH (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 05:11:07 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:46736 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbeABKLG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 05:11:06 -0500
Received: by mail-wm0-f46.google.com with SMTP id r78so60593092wme.5
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 02:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QgWSGvP8FF8VAdvJcHuoaYGugju3Dy+zcJPUTuS1XdQ=;
        b=ELt4+MR4+MGhAKqFVQiss9lh7zi4GwnQ86UO4IuhYKKA3LbcQkmH0WaYsbIbWJ05S4
         g+SkYZ1+bhIEgiTYs5Jephz/Nucm6D/XL5O1Sy8ALh3Eh0s6BVlDPgALR9HM+HvvuR7Y
         x+lFeSBkWsz9omhwwmJ5l7QNWgBiEOJ3kw05jlx+i66eO15EODKR9w8e5vLKP5Z82BK8
         gAeaQZIg2LoxG/Fsbt4uuf5F/g5qY0uCxL1hLi8xeZM2u8S++iK6n6tAU/kxe6k+36i1
         VnEZ0cvoaHhfFcamuXXBm328R+yd4QOFLjkna0yH8hBtPL2SyK/msB9yOVzOFN3bOIwf
         5PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QgWSGvP8FF8VAdvJcHuoaYGugju3Dy+zcJPUTuS1XdQ=;
        b=MD/KGNnSMZKh1nOLtpiaweSkZw0qKjCD2zVGNLWUTj4ZBtIMa8iXKV7JbcnW+Qhmd6
         FVO2hhvJEvRwLdDdqTI4g5w6cGFUQYkKWoZ8No6ObmmSYObOyjr/VrtGo6VSChrJDWGr
         QqCFesHPr7Eoln0DG4fUeOHceOUh8Y+VzXcMwyZ1V9bMczorkhbchXUsmGYskuyW0fp7
         xe7sF62qRpNpAABzHVruybsL065HlZhsvoub6hpf/jZrnWpCjUc65b5PKuQ8sT0UfoBB
         ZrhscbrLqdBG4hgv6oJLoSQ50BIjsHY5RKAuvDI/AVn8eDuWuzQgmYqRqlyL6PreoJ1k
         xPzg==
X-Gm-Message-State: AKGB3mLUsWelwG+88scoiuX7OILC4gnJPbP7d0EgKHmo9nuWjaPAisRf
        UgiBJ+Pi7U5h+swCxQ2i3MvUaSCaiRg9KRX3rpgh9g==
X-Google-Smtp-Source: ACJfBosormKTpuxfTywvW+LHcvPT3TtDfINCDi9lFbsgicg7lNHGe8VaLrXZMHQRH3pm3592vaGdIFDANJM6V4QenNU=
X-Received: by 10.80.204.152 with SMTP id q24mr61857966edi.108.1514887865552;
 Tue, 02 Jan 2018 02:11:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.149.170 with HTTP; Tue, 2 Jan 2018 02:11:05 -0800 (PST)
In-Reply-To: <CAPig+cQhL-r-V8tMtmn3cTB90=2sxFAk65zpzEvMM5rRHdH3Ow@mail.gmail.com>
References: <CAO2669gb9+VEEkS2Pa=ZNbA9FsZT2t-7MmG9Nc=-nmB3Rcicig@mail.gmail.com>
 <CAPig+cQhL-r-V8tMtmn3cTB90=2sxFAk65zpzEvMM5rRHdH3Ow@mail.gmail.com>
From:   Andrew Tsykhonya <andrew.tsykhonya@gmail.com>
Date:   Tue, 2 Jan 2018 12:11:05 +0200
Message-ID: <CAO2669iv1+nCmWYuytiBaV2kqbGpew7bZvQZxf5nhXsYC3zvhA@mail.gmail.com>
Subject: Re: Segfault
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I made:
$git stash
$git checkout <branch_name>
$git stash pop - crash here. changes were applied, but index.lock was
not removed.

The issue appeared only once, I haven't seen it before and cannot
reproduce it now.

Thanks, updated git to 2.15.1.

2017-12-31 10:59 GMT+02:00 Eric Sunshine <sunshine@sunshineco.com>:
> On Fri, Dec 29, 2017 at 4:04 AM, Andrew Tsykhonya
> <andrew.tsykhonya@gmail.com> wrote:
>> git stash pop resulted in crash:
>> /usr/local/Cellar/git/2.10.2/libexec/git-core/git-stash: line 470:
>> 14946 Segmentation fault: 11 git merge-recursive $b_tree -- $c_tree
>> $w_tree
>> although, the changes have been applied successfully.
>
> Thanks for the problem report. Can you come up with a reproduction
> recipe in order to help debug the problem?
>
> Also, what happens if you update to a newer version of Git? You appear
> to be running 2.10.2, whereas the latest version in Homebrew seems to
> be 2.15.1.
