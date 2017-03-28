Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 789FE20966
	for <e@80x24.org>; Tue, 28 Mar 2017 20:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754120AbdC1UGJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 16:06:09 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36803 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbdC1UGI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 16:06:08 -0400
Received: by mail-lf0-f42.google.com with SMTP id x137so43895069lff.3
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 13:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lj+/hBtIh/gwHhVowWjUkJBnZDz3bid8VRfbDQVrolg=;
        b=NOYOllrrjHCgZAhM9GR46D1pqMi5A3vFUdxbTiReJw52SC67DtCnrBTAgbywnM0YmO
         DKI6UyBivn0OtniGhio1+TTRSytZmKcsyMJSYLzR46QLOqtVOU/zEZWJYFCz49RfGBq7
         DGlvDt/VFYbq3go6dgsUjG7CkfKNesaqOFvkbECucN7ULplNzvCKo4Q2Aztbj7aJXSb+
         gLsEQv6EN+7JGKcLF8HkoZNRQS9JTPWlZQJN56bGHHvwVkOLL71DvmrzvlKmrpjU1/ip
         8A7mJ7N/wNrdUjBGSYL4popmuMu/JvGvJAeZqNII4fsFrka4AR2SeiNSMYbA5dbhmLIx
         0v6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lj+/hBtIh/gwHhVowWjUkJBnZDz3bid8VRfbDQVrolg=;
        b=Uy/WwWb2m6BKSNUORwuaSVmV4mQwqiAYW/NUXt/Vy2eDx8kxM25VZBLPNPgoFbfkwJ
         fDvmFJbHe4WTj9tCH/clDflLb9jzfg3CpWAkyIGshP6YXKn3pKFCu4AF+YkDq9Yjs3/A
         gN+6wJTYZNae9GKTE7liaT7inWJ4qpCziGIoPw0PugjM9iXU6AE1zM6CeSjNpGPqS58j
         f5JtKhREJ1mVTAdss3IhqH8zVyVERFWWBCT8AqeZfl6DJdPxMGdEK2PYdW94WMW3rFuY
         uzZat8n9/p+pS46iUIZdsQpwZNJhMBURMn3PRmbq7D1Bxq6GroVYRolqY1QkbBqmwPpQ
         lCyQ==
X-Gm-Message-State: AFeK/H1iUae3YdaVjW/RPhi37Y6/UumNrWTudVnr23eBWTiYuxF2IFijnrYICwKOdHfiWXznAjdwJRfMeFIgiA==
X-Received: by 10.46.15.9 with SMTP id 9mr2307944ljp.108.1490731560819; Tue,
 28 Mar 2017 13:06:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Tue, 28 Mar 2017 13:05:40 -0700 (PDT)
In-Reply-To: <xmqqk279cjfs.fsf@gitster.mtv.corp.google.com>
References: <20170328122209.4861-1-jacob.e.keller@intel.com>
 <20170328122209.4861-2-jacob.e.keller@intel.com> <xmqqk279cjfs.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 28 Mar 2017 13:05:40 -0700
Message-ID: <CA+P7+xqA9ZOfaeVg0wjgXVs=N=OJUZjjY1pahUn2xbvSQohfUQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] diff: teach diff to expand tabs in output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 12:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> I'm really not a fan of how the ws code ended up. It seems pretty ugly
>> and weird to hack in the expand_tabs stuff here. However, I'm really not
>> sure how else I could handle this. Additionally, I'm not 100% sure
>> whether this interacts with format-patch or other machinery which may
>> well want some way to be excluded. Thoughts?
>
> As long as you do the same as "do we color the output?  no, no, we
> are format-patch and must not color" logic to refrain from expanding
> the tabs, you should be OK.
>
>> I think there also may be some wonky bits when performing the tab
>> expansion during whitespace checks, due to the way we expand, because I
>> don't think that the tabexpand function takes into account the "current"
>> location when adding a string, so it very well may not be correct.... I
>> am unsure if there is a good way to fix this.
>
> This "feature" is limited to the diff output, so one way may be to
> leave the code as-is and pipe the output to a filter that is similar
> to /usr/bin/expand but knows that the first column is special (this
> is the part that "this is limited to diff" kicks in).  You may even
> be able to implement it as a new option to "expand(1)" and then
> people who aren't Git users would also benefit.
>

That makes more sense. I'll take a look at that. It might even be
possible to modify the pager setup so that it does that as part of its
process.

Thanks,
Jake
