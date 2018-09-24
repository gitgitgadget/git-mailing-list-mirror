Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43A241F453
	for <e@80x24.org>; Mon, 24 Sep 2018 20:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbeIYCJT (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 22:09:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34357 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeIYCJS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 22:09:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id t15so13045610wrx.1
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SlZr70RuczqnSOm9EuU0n470+jLrlszk6g1eIvzqrlc=;
        b=OGdwAh/WfAqGaKt5nLBe3v/o+gXqrQUmpzic8dQ7hmLPwMlIOHwGUi4Irx7n1R4wqp
         peHoEpFWmNytfs3p2ePR5tNjIGgELEknmFQKWXu6+R/5qnpD7K/Nw8tZteTVSZxyxUKs
         UWDRDh57+jaFxFdS1XqeKSZi2yinZGO+eurVu+UQei4eh1QCZfJ2Wa1ssALeUN2BY2Px
         K/7cIYQb/g3VgVOwU5Jz7AX51i0kpbvo6ZkoMuyJfoH1UDXKmkidFk2JDjgBhESftfxC
         9nzGQSk8dpxaR6MkgXnGEOz3AyEJGnbf/cWOCsI7ey8DpSLYzxymnU84s+zwEqAc36Ge
         q9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SlZr70RuczqnSOm9EuU0n470+jLrlszk6g1eIvzqrlc=;
        b=adNCaXGMdOTuRqKOQTJ4lyVO6Zb1O1FQNK+36sl6cmQpPq/UIaoZG+yv28vgmQoKqf
         E/TKCQYYecfPRuX8OgxyuHYVD5qoJkoGStr2HLYZPh16ANYeo1MXkrZ1INhawK+4UM0d
         TXV3w0kVUREiryTu9BdGCP/J5H6r0oCofkYiq6P2ik2QBD0Q5Yo0ds8LSOFSA175bPeF
         hC6F04b7Rjg/pgATcEO9+ISeC8RVHEHkPGmMRRwEOESgIszoJL6OpdrwsvtiCGvVBA6R
         8sTKQxMVph2+jBhKSQpr4F+PP1psLDH3LOuu3V1/TdLMXBpdufq+q/1PMZhxYrLqVYlk
         mrRA==
X-Gm-Message-State: ABuFfojkzIL7lDIiUAhLqFyho9RnqU3euM0+HiB0bkzKDEbhPT7V/RrO
        ZOglcf12oeNgvw966obyNUCI48fR
X-Google-Smtp-Source: ACcGV62l/qs2fyKYZbAIE36WXLRftlwUI6CUWe2iVRHW87pDBYxDrYajloMB45arr0Y1l5oZeDKEwQ==
X-Received: by 2002:a5d:6451:: with SMTP id d17-v6mr292690wrw.64.1537819524526;
        Mon, 24 Sep 2018 13:05:24 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q14-v6sm177954wrj.39.2018.09.24.13.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 13:05:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] Add an EditorConfig file
References: <20180917230307.588334-1-sandals@crustytoothpaste.net>
        <xmqqtvmm42es.fsf@gitster-ct.c.googlers.com>
        <20180920000013.GZ432229@genre.crustytoothpaste.net>
        <xmqqk1ng2rdo.fsf@gitster-ct.c.googlers.com>
        <20180921225039.GC432229@genre.crustytoothpaste.net>
Date:   Mon, 24 Sep 2018 13:05:23 -0700
In-Reply-To: <20180921225039.GC432229@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 21 Sep 2018 22:50:40 +0000")
Message-ID: <xmqqefdislto.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> But that is a response in a dream-world.  If there is no such tool,
>> I am perfectly OK if the plan is to manually keep them (loosely) in
>> sync.  I do not think it is good use of our time to try to come up
>> with such a tool (unless somebody is really interested in doing it,
>> that is).
>
> Would it be helpful if I sent a script that ran during CI to ensure they
> stayed in sync for the couple places where they overlap?  I'm happy to
> do so if you think it would be useful.

It may even be an overkill.

A comment addressed to those who edit one file to look at the other
file on both files would be sufficient, I suspect.
