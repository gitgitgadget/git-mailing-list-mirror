Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 798B020209
	for <e@80x24.org>; Sat,  1 Jul 2017 17:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbdGARg5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 13:36:57 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34295 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbdGARg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 13:36:57 -0400
Received: by mail-pf0-f193.google.com with SMTP id c24so6242913pfe.1
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 10:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A6hymtrGhPwB18Hw6qhgQ/0w1U2bRyY0DQby7Oh8Ass=;
        b=WKKVb9RPVvzZUhDNsY6ctOOiHcYyx8wui7eBK7g7fdaP3Q1Pm7OqmLoc5JLdm8Q3bC
         J7pNUXGzBYDoamYjagu/E+0UooMqb/QJ20aZ73/J0zyzvvGqw+ZhpUjE/AXoVR7gremA
         hIR5HR8ziz7B7UHXTeKRGE9MQKL76blk/0988DC62Fcb2IUMf+6FAyG0aM6JmEALu6Kj
         EGTT3hw8PMZ2h+9LrKMSqYVdhCSp4riLkN2LkklD/jMMIPlkwpijfS9geIkWWLbW9U8R
         A4kTAI3SWjnTCtAKgFBCa72K8SgNsoPKGQs60vnD+qSc8qsva0SP/aHfbjKMMnkGnWEB
         XcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=A6hymtrGhPwB18Hw6qhgQ/0w1U2bRyY0DQby7Oh8Ass=;
        b=t+K1JOy1ZXwI8CrQfNUi1ThOf2azK8hraSufwjV5BMpSXafozQmlGofV5bWXnHU4kt
         tg/aQAtZF42RihFHGEm991Q0GG1OqI6aoNqq9L0imrdN6imrENNG6q5iudiszddijByF
         /d1JYea4C32WA5AkUfm1JEEzI0zeHTDLTQ9uEpEl7SpFc7PFlh/RABvV+b83Q7gTghog
         PrQPBLeZK/EWYWw+BjojWdwkMFd7Ne4z979CgtEzLqAw5NfuAnC5SsvIuqhOy0cculd6
         jgsG9yh5iIEzzhoo1wgn729HH2iSngtQeDmy5cjyqu6roOspDZVOQfNoRVITk3NH5ZIC
         S6Rw==
X-Gm-Message-State: AIVw111z4GuEsV/XlZv8U9pXErvBGD15RHUFbCpkarxXRgh/atrWCg2e
        hFmXnOcKyktp7w==
X-Received: by 10.98.12.76 with SMTP id u73mr1601311pfi.62.1498930616167;
        Sat, 01 Jul 2017 10:36:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fd45:ceab:278e:5d13])
        by smtp.gmail.com with ESMTPSA id m79sm26139394pfk.117.2017.07.01.10.36.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jul 2017 10:36:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] hooks: add signature to the top of the commit message
References: <20170630154306.26993-1-kaarticsivaraam91196@gmail.com>
        <xmqq1sq1togq.fsf@gitster.mtv.corp.google.com>
        <1498918546.4321.1.camel@gmail.com>
Date:   Sat, 01 Jul 2017 10:36:54 -0700
In-Reply-To: <1498918546.4321.1.camel@gmail.com> (Kaartic Sivaraam's message
        of "Sat, 01 Jul 2017 19:45:46 +0530")
Message-ID: <xmqqfuegnjnt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

>> By the way, the one that is still actually enabled is no longer
>> needed.  The commit template generated internally was corrected some
>> time ago not to add the "Conflicts:" section without commenting it
>> out.
>> 
> I'll send in another patch that removes it but it seems removing it
> would leave sample hook without anything turned on by default. That
> doesn't sound fine, does it?

Actually I was wondering if it is a good idea to remove it, as it
seems to have outlived its usefulness.
