Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CADF1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 19:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfBFT24 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 14:28:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36205 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfBFT24 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 14:28:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so8929156wrv.3
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 11:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=v1jIF1Want7lCONK1LonN1dGevrUqL2culIJYJigSB4=;
        b=uiy+EAZKGZS7ubUZLRXNUZLA6zhCsyd5E65hGffm/k48iYY2Ax1AYb8Br6X13EuZfP
         hVjVkcz3+SOi00utWtncLZ5NQlNLu0YERb6B2ajwl1/OJOGSX9zaS7xZuk4p1Vy6Xiix
         /ke5MSMazxn5rmB2BWYaOjbCFBL7kTxratnF42iJvh0o508oOBmy5HD+PtjCOp9nk90s
         jE7ZNyjb/kMQNoMO3kLv0HRkxw0caBSjb2AAkqy6biS3UtT/vnSM0wqc5LyXkrOsXhy9
         /55wsoLlQ9BodaC1eER+Vw/sPHicOJ3vsny0xk0DM9Hry7Wnjg1wmYzxNQo8Jd7AwIB8
         CB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=v1jIF1Want7lCONK1LonN1dGevrUqL2culIJYJigSB4=;
        b=AHPrTw20d6bmt8P1cxIGQvH6NyRg/w2wRLQIUE9PNsxZo1NxZj8ucd4yKd6YNhHWru
         FTlBjxDHSHqQZhgzPqSJqENIpulnIrNaAlEYfMsGiG7MfJHxPWTkXHx+D9iJLqqzGzNC
         iMMoJxyfGxqAcmdyPd2eVP2mXovr1lCvBtQ8XSdZYoa2GzfB0Fmdyz2L1bTFlqBFqyp7
         kSi0EV92dJHWdULMnZtc5DZlOs/l/fIfGCmq0C3tagYe9SXMyPlq8KGaRA0Kpsr1zpr9
         Qu7WnjSdRk2E087ly7vd1vDwldERMeyiG8x2eOdjww7bNZZKOue2dDyU1TiCmGEv1uet
         gfGA==
X-Gm-Message-State: AHQUAuY87qxDgMjkRmH4w5lP8xrB1tI8QCxFE7xlgdy+xBxPAcZmq9bJ
        Shh/AF+/AaFJwSty2wvRwb4=
X-Google-Smtp-Source: AHgI3IYUiy/No477ff2XiR26HrZnWk3xAg8bY6m3YJhX+OeCDfFewkWVamKta3rc3OFPwKyLWUpm2Q==
X-Received: by 2002:adf:f34e:: with SMTP id e14mr9692912wrp.240.1549481334517;
        Wed, 06 Feb 2019 11:28:54 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l20sm43027122wrb.93.2019.02.06.11.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 11:28:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/1] rebase: drop the unwanted -y
References: <pull.118.git.gitgitgadget@gmail.com>
        <pull.118.v2.git.gitgitgadget@gmail.com>
Date:   Wed, 06 Feb 2019 11:28:53 -0800
In-Reply-To: <pull.118.v2.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Wed, 06 Feb 2019 10:45:17 -0800 (PST)")
Message-ID: <xmqq4l9gra16.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> I totally missed that this patch made it into next, and then master. Sorry
> about that.

Will queue.  Let's make sure -y won't escape to the released
version(s).

Thanks for a quick update.  

