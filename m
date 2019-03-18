Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7789120248
	for <e@80x24.org>; Mon, 18 Mar 2019 20:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfCRUaM (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 16:30:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40221 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbfCRUaM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 16:30:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id u9so12177283pgo.7
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 13:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gF6JSW+Hv8+Mql32X7oIVNImiLscfXe8q3SBAOb707U=;
        b=s9428RqxxTQZQhpxQavlWkr3wKWdHggli7Z4tgdj4CPaZxGgXdHCJo5qSSUeIki+tX
         OLMQFQHBLiYjkq1O5EjNPiQyDNJF6GgwmSR8INdQUcchmHGooOiMkSXwdhS3W3Ysa9bd
         Fk5YfwVUayRlHd7qpfb/75n/WpKARK7HMkU102+HqFhhUYU4+PuDg5cp5vIrYo0OXtLp
         8wmBjO/HqW9n0b8P0rZglojFSsQmE8MMF/r6oZ9L5llw2cK3bHqDcoSVkeUJuQ5nUnHi
         KV4VK+lcrpfVgXd/M0rT9W0ZcS46eIV93f9LvknuXNzK5lDHQ7J3cqDSKZg3Jdm+4ir/
         NKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gF6JSW+Hv8+Mql32X7oIVNImiLscfXe8q3SBAOb707U=;
        b=oeqcxVXq3gDOOcwumSP7if2QPI+t8dmUxzPXvkrGQDEm/6Z2nCXke58cnpsS8Frs+R
         G606aHbxKO6pstn1Sia4ROyv5xIXVN7b91RrF7Uyhk4UEF12CrLOSVVmTZM+3pHU5Vhv
         esa/F6xvOi9sGU3J/p065WmjotfgpRTC/wx8t5Z7ZGgRsTAMR1gNSbQ7RlB1hihEYmh8
         io/Qirk5AqyFIXgerjCjc365F7wSBK60SoerBKyk+X5iL5DulaxesqOL4fGFQOWCeLeZ
         U8NfmEsKQDeepNnJ4LxaoMzNRVgbNVYCs+Bo66z9DDcqX0Ez7D8OEJfGgI3Rcp6HgN+c
         EHuA==
X-Gm-Message-State: APjAAAWNYhfNZ7ztQPs8uMdwVMp/ZpgXKJI/KCHMTwcxnUzNoIQzmUhN
        FIE8E8nuvBMkULL85COHiHU=
X-Google-Smtp-Source: APXvYqzbVt/BC5v397gwX9QbXt0HpsVN5x5EJe8vq1jM2PZPe+MkHeYEXKanLgsN0KuREIQrmGMg/A==
X-Received: by 2002:a63:9752:: with SMTP id d18mr19742012pgo.0.1552941011246;
        Mon, 18 Mar 2019 13:30:11 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id z21sm16551487pfa.81.2019.03.18.13.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 13:30:10 -0700 (PDT)
Date:   Mon, 18 Mar 2019 13:30:07 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v8 10/11] sequencer.c: define describe_cleanup_mode
Message-ID: <20190318203007.GA14875@dev-l>
References: <cover.1552275703.git.liu.denton@gmail.com>
 <cover.1552817044.git.liu.denton@gmail.com>
 <4edca9db0b2a32621a7622b5b709db23b2512d1e.1552817044.git.liu.denton@gmail.com>
 <CAPig+cRmz2C7mAzc7Z=ZStAxd3qDSmbC4sbwyLGKqvkf2yzVPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRmz2C7mAzc7Z=ZStAxd3qDSmbC4sbwyLGKqvkf2yzVPA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 04:04:22PM -0400, Eric Sunshine wrote:
> On Sun, Mar 17, 2019 at 6:16 AM Denton Liu <liu.denton@gmail.com> wrote:
> > Define a function which allows us to get the string configuration value
> > of a enum commit_msg_cleanup_mode. This is done by refactoring
> > get_cleanup_mode such that it uses a lookup table to find the mappings
> > between string and enum and then using the same LUT in reverse to define
> > describe_cleanup_mode.
> >
> > Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
> > Reviewed-by: Junio C Hamano <gitster@pobox.com>
> 
> These two Reviewed-by: lines should be dropped for a couple reasons.
> 
> First, neither Junio nor I reviewed _this_ version of the patch.
> 
> Second, a Reviewed-by: is given explicitly (not taken). When a
> reviewer has thoroughly read and understood a patch and considers it
> problem-free, he or she may say explicitly "Reviewed-by: <me>",
> stating satisfaction that the patch seems worthy of inclusion in the
> project. If he sees fit, Junio may then pick up that Reviewed-by: at
> the time he queues the patch in his tree.

My mistake, I misunderstood the purpose of the Reviewed-by tag.

I was using it to give credit for changes that I incorporated in
response to a review. In addition, it was helpful for bookkeeping who
suggested what where.

Would a Helped-by tag be more appropriate in this situation?

Thanks,

Denton

> 
> > Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
