Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3C9020C31
	for <e@80x24.org>; Thu,  7 Dec 2017 10:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbdLGKTx (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 05:19:53 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:47086 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752422AbdLGKTw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 05:19:52 -0500
Received: by mail-qt0-f179.google.com with SMTP id r39so16110002qtr.13
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 02:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Hzk5XJSwiAZTXuO2SP9d5VRr8dSceuCh1vhJOpXyHtk=;
        b=IznYj5wiOP+vs7FtDUaxSKeMweQgz4zynCbk1pq2xMeD3hbNYQ6wsGCQtjbrDdPFm2
         seG7O/XoHxOOwGdzNSpBCOM8Ir/NEDZNtzcYU1moszybVuBK91cePkkNBzEgbVmSDcJC
         aI/7MPRGhLMPdXyo8/48QnNWWsg4RdDEKwNi05t3Azxd6aoDfYrHeNSLOB4GVqex4TVX
         qLBxZYQX0yjzxcGiK2q8ZWx9FXJEplRImy9xUIHJcHF6ERsdGw6FbcZo1odsGt94bE2e
         44FFDB3hm1Zqz7Zraf/lcLX4B3RMJ+QTlMPKxS6DASN0dZZM/66y+vkX2H+llWz75PdO
         iaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Hzk5XJSwiAZTXuO2SP9d5VRr8dSceuCh1vhJOpXyHtk=;
        b=Jq7O62yacY/7JZa00DGg4A0x8JF0GSgatMXOJ93DEuywXolBQxRNtFBMzFU/pekyTO
         JnY/dvECHVRQ3awBhYBmumMnzX0rUwe3ys1ddWyor1tpNO8z90ftjTUr18SnxzSK7uHp
         w6idryGKvJGeVP7VfqT2Z7DiCSehwXBcQg1a49lI6tL8uXAuwOUm60SwBctweQTZUGW1
         5uKrkkm+7YMVqXCGyChLqhgqUbsu9dDgXLPBL86p4dcF6DC572P8JbnfakhOLswqagWn
         GhN8sDXZMLI0BlTKGZbV4v4Pc6asHEmJptefZeuX4kTa+uyMGnOU4cutdqxU/mZHwmNz
         57Ew==
X-Gm-Message-State: AKGB3mKijbM/GieLz1kPm1QSNQvuzdB7OGKYq2WnbbHO2Iz3iS+l2erH
        IzYPF9l8Mzec1G/2qfs79magITfRdbbgnZQYNlI=
X-Google-Smtp-Source: AGs4zMaIDp3qb/anTC+qI6kY6jUF5Rf0R6VJVCfA2cCs6+7kcP77n30yJiXHaMcgL+TJoYxgSM4+5JPV60IGISY770k=
X-Received: by 10.237.35.37 with SMTP id h34mr9155580qtc.9.1512641991656; Thu,
 07 Dec 2017 02:19:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Thu, 7 Dec 2017 02:19:51 -0800 (PST)
In-Reply-To: <CAPig+cQXeC5Nh+=rO9U46PNgnNALd4H3on+feo_NzMg45HqUkQ@mail.gmail.com>
References: <DA0A42D68346B1469147552440A64503C60832DB@ORSMSX105.amr.corp.intel.com>
 <CAPig+cQXeC5Nh+=rO9U46PNgnNALd4H3on+feo_NzMg45HqUkQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 7 Dec 2017 05:19:51 -0500
X-Google-Sender-Auth: IrbCZyB03iT7-wONqujvhYRwn_0
Message-ID: <CAPig+cRAth85f+Euim8Sw7An8UQQeOAo6e6kVP_yruw400aJug@mail.gmail.com>
Subject: Re: 'git worktree add' does not fire post-checkout hook
To:     "Gumbel, Matthew K" <matthew.k.gumbel@intel.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 6, 2017 at 4:45 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Dec 6, 2017 at 4:00 PM, Gumbel, Matthew K
> <matthew.k.gumbel@intel.com> wrote:
>> I've noticed that when I run 'git worktree add /path/to/new/tree',
>> the post-checkout hook does not fire, even though the worktree
>> manpage explicitly states that "worktree add" will, "Create <path>
>> and checkout <branch> into it."
>>
>> Is this the intended behavior? Seems like maybe a bug, but I'm not
>> sure.
>
> If you'd like to get your feet wet at contributing to the Git project,
> this might be a good first dip, as it looks like an easy fix (a one-
> or two-liner). The only thing which needs a bit of care is to skip the
> hook when --no-checkout is specified. Other than that, 'githooks'
> documentation would need an update to mention that git-worktree also
> runs the hook, and t2025-worktree-add.sh would want a couple new tests
> (which would probably be the most complex part of the patch).

I worked up a patch to fix this oversight which I'll try to send out
later today.
