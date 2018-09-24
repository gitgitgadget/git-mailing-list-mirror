Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BC641F453
	for <e@80x24.org>; Mon, 24 Sep 2018 22:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbeIYEdz (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 00:33:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51481 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbeIYEdy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 00:33:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id y25-v6so3888682wmi.1
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 15:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=mn+km6are53E17nSxzsA/wdXzWxV0z00u4Rs3SXizQQ=;
        b=Ith6zEYgsCOQcwaGyc3Hbsz5+l84j8Q18BijSmpzHrCdvshy/pGzLvbrI8SflPEcp2
         W3LuOyfij1aHZPbDmZl/AVAPeEISS40TZCXiWwKW6zOE5nDAkHYgC5OUWtAlz+/qHhPl
         z9V9vpl5FFk62oYBUruvZg+jIDF6BhAy65/SEfJdQ59E8/MtTjEr5MsYVWnBSR9bT4oY
         5cK07p88cWNVAoItcpIaz8osUMevggyt3NwXA1Po+/qWP4jcOyR+1Ft6dIFWPwi8gSqP
         Zg7oatRV05EAxpq3upmUTjsW6bDm9FkVESO9mYhgKKXlztVi4Xq1r6CurJQ834zfgHjt
         MDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=mn+km6are53E17nSxzsA/wdXzWxV0z00u4Rs3SXizQQ=;
        b=gIhQhO5cXwN5sSNNVFSTTjz073BnvQzYiDBX+5zpF/lIVwNgsRC/ifgdI/o4MSLfLI
         DcxrHCAuasrznpzw9eygjFAhneML92PJTmyr0No1Pw1EB8cG8lpamZFrYSv/chXCvduS
         UK2NomHePhV1LeE7NNz3Ab3OezyW+v3h2A4IYG0aqIEhoRjhvn9/ViRUAUOpwMLsZGld
         c4y0QNGmSxttVTKD/ThzutJnJc5Ix4LTrP1o8/h4pLw0AWCA6FAWysnKiBLTZvU+aXqJ
         83WDOwyfEiCwuqaXHjUbRxrAxfjEW3laLE8+16oJ1slxfIxo2/1rylFl8vmNJWC022v6
         nysw==
X-Gm-Message-State: ABuFfogXv6rFaVissqYHQZ4JS7WoKjFglFxD8EcbNbFZGSVm/jCn8FmK
        DpicANXaGKSAscyWysDiYxQ=
X-Google-Smtp-Source: ACcGV62Zbs49kAu60zCffk6rnI5yfu0mpn1ZL425DFJ3cAuqykY2PCMlS1M55OV4rVr9jtGVG8j5pA==
X-Received: by 2002:a1c:3282:: with SMTP id y124-v6mr275071wmy.11.1537828167207;
        Mon, 24 Sep 2018 15:29:27 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 198-v6sm280071wmm.0.2018.09.24.15.29.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 15:29:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com, peartben@gmail.com,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] read-cache: update index format default to v4
References: <pull.41.git.gitgitgadget@gmail.com>
        <56374128136fe9377503d446daf98e67847194aa.1537823728.git.gitgitgadget@gmail.com>
        <20180924213223.GG27036@localhost>
Date:   Mon, 24 Sep 2018 15:29:26 -0700
In-Reply-To: <20180924213223.GG27036@localhost> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Mon, 24 Sep 2018 23:32:23 +0200")
Message-ID: <xmqqa7o6r0l5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Mon, Sep 24, 2018 at 02:15:30PM -0700, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>> 
>> The index v4 format has been available since 2012 with 9d22778
>> "reach-cache.c: write prefix-compressed names in the index". Since
>> the format has been stable for so long, almost all versions of Git
>> in use today understand version 4, removing one barrier to upgrade
>> -- that someone may want to downgrade and needs a working repo.
>
> What about alternative implementations, like JGit, libgit2, etc.?

Good question.

Because the index-version of an index file is designed to be sticky,
repos that need to be accessed by other implementations can keep
whatever current version.  A new repo that need to be accessed by
them can be (forcibly) written in v2 and keep its v2ness, I would
think.

And that would serve as an incentive for the implementations to
catch up ;-)



