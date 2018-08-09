Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA0CB1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 15:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732346AbeHISKK (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 14:10:10 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:46722 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732163AbeHISKK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 14:10:10 -0400
Received: by mail-wr1-f44.google.com with SMTP id h14-v6so5526212wrw.13
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 08:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5lTScPGqsTaQkTvb9FLFsIwHFx1F+k/yuM55+vLtefs=;
        b=S5YnJJ519PGuxi/oDSDTKF9aW/QvYA6uQEGeGW0mzA1ISuVeRtnOZ3ruqP46X6ncQy
         mrhTyO2aLxGaUGetEKKqwMcMJ7lV6IzUbRVDtSbuwjWBxYFMjZWXlHf+ROoULR1QENt/
         g0HU4Uig0ZyAnG2Bs20niAMiGO++jUKe2vM03BLj809rZ9k6+uqTQRjtX1IiR/0sEf+S
         yahTCLH5zg1eJUZuByqlHL9KjRtvOm64mLw60H4/tsRUfCODwnuOAybzrfTt/gMWdXL0
         rcdVHkF3YnfpAy8pd5FTTEv8Z9eU+vAksTm7rh/Tsyj4Hg2e2tHvqTyrhaUdvUlcxfSt
         4Gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5lTScPGqsTaQkTvb9FLFsIwHFx1F+k/yuM55+vLtefs=;
        b=Udcfjc+Qo8zltqKZTAqgKTWEz2IL59tp7JzkfoPqLLz0NsQ0oZuF4UMHNKSrT+UpFs
         +CEz4zf/0cI1CIGjP7BUkKj7U4+KTS7sAsYdLSa1EEyVb14/U6mllqHTEw9iqdWBz7ZH
         O+/qSjRF459afQ7ejMPnkLBoQaINtEL9zabQJK8BDv3RqMzEciMacnN8pbUEbTeNHSYj
         mHtNe91kMW6HoZUCW4gBfpADRiJJLxxEv07c4aKub14FaLMtlSKvwkQNtOaN8PFNmwkE
         Kj6ZkHB/8AxB2+KWmwo8uGW8gRExnYWGQGsS2/z/B5N+5dUVATvJS3efphylc+UatF4f
         z3gg==
X-Gm-Message-State: AOUpUlHXLc11ZQCVfJLSDyK66q6Carwgrkt88dPULxXEDsDXc8qu8iQ7
        2qpqZRaIHz7018qdimECTRY=
X-Google-Smtp-Source: AA+uWPxUujkrELolGFSz0gEpNzUixdNPc4yGGSk7nUvV6Y1MaTk+iMXQHMpDIACMnXnJOImkxFPZlg==
X-Received: by 2002:adf:eec9:: with SMTP id a9-v6mr1907964wrp.21.1533829480482;
        Thu, 09 Aug 2018 08:44:40 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m13-v6sm7956474wru.93.2018.08.09.08.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 08:44:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicholas Guriev <guriev-ns@ya.ru>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] status: -i shorthand for --ignored command line option
References: <CAPig+cTD7XYbaPBzj36Eudrud80r-cz1CPLDsLA9CHJC6Yc-Qw@mail.gmail.com>
        <20180809062142.15638-1-guriev-ns@ya.ru>
Date:   Thu, 09 Aug 2018 08:44:39 -0700
In-Reply-To: <20180809062142.15638-1-guriev-ns@ya.ru> (Nicholas Guriev's
        message of "Thu, 9 Aug 2018 09:21:42 +0300")
Message-ID: <xmqqpnyrczo8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicholas Guriev <guriev-ns@ya.ru> writes:

> It allows for uniformity with the --untracked-files option. Also
> the new short flag saves the number of keys to press for the
> typically git-status command.

Unlike "-u', "-i" is supported by "git commit" which shares the
underlying implementation, and that is the historical reason why we
never had "-i" shorthand, I think.  

While I do understand why sometimes "-u" is useful, especially
"-uno", to help those whose .gitignore is not managed as well as it
should be, I am not sure why a "typical git-status" invocation would
ask for "--ignored" that often to require such a short-hand.
