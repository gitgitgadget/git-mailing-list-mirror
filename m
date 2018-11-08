Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36C4D1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 06:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeKHQHl (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 11:07:41 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:32894 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeKHQHk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 11:07:40 -0500
Received: by mail-vk1-f196.google.com with SMTP id d201so1718925vka.0
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 22:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJIh0X2+u//co9iph0GjXQHF+KToQSdKCcp7hiZn7aU=;
        b=HtI2EdkL7plFm0QtTrIFWzD6t1jHtCYihItHAm3UaRjE3gIB7BQgrtV+97BDgdhfXy
         S2C0Y2XoZddNr33spjFhIRCQ7htVv/7gjoWxXPstFcct7M9JgvX77NfOcw3poN9X/Syz
         Vu7aX+V0x9jUoEBahAWqXYyRra5s1VgTuzEZQW/0POKscEL1R7jIY1kHDSBXe0cH0xNs
         QqqIGX07ZOaaqEF3ipNJlyKLVcADOAhRwiiQNPOK2kTSDoUK3OX8IuobbADgcrujsZa1
         q2JDfAu8YgpPzUCe5FHDQZIPsY/W167VoN6lRPJQ4bUud2uHBfSnv7YuKzQcbjtfXKHN
         RC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJIh0X2+u//co9iph0GjXQHF+KToQSdKCcp7hiZn7aU=;
        b=Mdy9cQcziOq7MYnMTG4JCu5GC629Vv7XhfsaLPD1O7nZpJGy051J0iSgBJT7ULfOCv
         YKOyxLk4lVZs4YjLpJTiz02n3GD5F5dtlnnKHX91d94lJfcGoZsO06xx5iWP0pT97Lgd
         tRl2WzyvOGYioYln65XxTrJ9fdJUHHtEo5k40LHyPI55bt5LQ6icNBTQFXKCPN/366IL
         Lyw7vP3pe/5enBNLrcFGlbrnJx5yUoTM7b3e4Vm75cxNmXArl0aCRWB1H8hhXcQAMT2e
         rp9mBd99Gc3QUB/2tQP+hFrasNPsIFGFZO2sZhwqmJRvymKG2IP4IQwlL1eLVushRjkL
         JITg==
X-Gm-Message-State: AGRZ1gJQ3wfja3A66yFdWxqzyM37BQyziVwYmimYIBILHY94h+CAm1Qe
        SCJzWk7TireCl3zjvJyxJba9VgqT1273l3b8lp3klDzh
X-Google-Smtp-Source: AJdET5foPmQazEzf4ehUDPjXOe6JH71K0yF3Y7iVkxuFIHvxzRBmKgL6kCuXdJVvrlEg5GZnnO4i/riwpirldYVhpyg=
X-Received: by 2002:a1f:97d1:: with SMTP id z200mr1445506vkd.15.1541658823749;
 Wed, 07 Nov 2018 22:33:43 -0800 (PST)
MIME-Version: 1.0
References: <20181108060158.27145-1-newren@gmail.com>
In-Reply-To: <20181108060158.27145-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 7 Nov 2018 22:33:32 -0800
Message-ID: <CABPp-BHY8kB-hFd-MZ2-aC1CNQggXz9a+CcfkKiOiD=q9NLHwg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Reimplement rebase --merge via interactive machinery
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 7, 2018 at 10:02 PM Elijah Newren <newren@gmail.com> wrote:
>
> Now that the rewrite-interactive-rebases-in-C series have finally
> merged to master, this series deletes git-rebase--merge.sh and
> reimplements the --merge behavior on top of the interactive machinery.
>
> Differences since v1:
>   - Updated code to hook into builtin/rebase.C instead of git-rebase.sh
>
> (No range-diff provided, because it has been months since v1, and v1
> was only RFC and was only discussed at a high level.)

Actually, that's not correct; it's been so long that I forgot.  Dscho
and Phillip both reviewed it and I updated my series at the time with
their suggestions, but didn't re-submit because it depended on so many
other series and conflicted with the rebase-in-C work.  So other
differences include the changes I made to address their feedback,
but...even if I dug up the old v1 and created a range-diff against it
I'm not so sure it'd be helpful.  If anyone thinks it would be, holler
and I'll generate it.

Original series here:
https://public-inbox.org/git/20180607171344.23331-1-newren@gmail.com/
