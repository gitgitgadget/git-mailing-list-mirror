Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 035191F453
	for <e@80x24.org>; Mon, 28 Jan 2019 18:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfA1Stn (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 13:49:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34311 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfA1Stn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 13:49:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id f7so19361012wrp.1
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 10:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bSUZ8LRGWG7EmrMKCnjg0E59KFKO8YFiaeYYx/qF1ms=;
        b=OyH+l/VYslR+CboLDzwQ6AkkD7wmyc1L7f5D1rxvlTFM1LFTlOTLCYwUJx4PQH9Dk8
         z1emj04O6QOzOLF96AgWbIpCcUIMbsjU5F+lhcI+hqt9ALR1ap9baFzGYzhjSonGFzrl
         jMcJsbMAfpGH8JNybHzaFGQAtF4cqIfkZoZwRv07mnJp9/No5LA/RvbYebpY6vSBoZEY
         Nlga5UZajd0ZebnuCg46MpSYaug1yPOxuoy4Reobm1gZp4jdPiSWFOzZgssj8fbTdgLE
         YDGvJ4snbBLAV1GRZaZq8rhVuRSWs7W9AAo5+GPflN8dqreViLSwn9+YGpnid2Wg/pfk
         Zxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bSUZ8LRGWG7EmrMKCnjg0E59KFKO8YFiaeYYx/qF1ms=;
        b=nVktvq3f7ZO3r0N7GkaVJEMD9xKwhaHNmYR22mCmNyiXZonnlFT3T+yyAM0ikgRv1G
         CC0XcORWU1rhgzoTa6+MYcAejXs7R21+nkCUI1Zks2UV3MJnXJSozE3ZCWEgekYTEIQt
         3CwCcYLq98JUPj+KB+HNT/hLCmXbKwWOnuj6FIy7/nvYpqwxcMuv9+GDRoIelA6iLV2u
         tsHBMVqG9JihmuepkkDaqKQQENCdcdfVgQscfxWV9eF0I0N9RbGmogqtYacRbC5J1B84
         nKZSLRhpW6ZrIy/ph9RA8pv4kaj8zltStVrVSKYZyzFGg09JK/zBy9dKJnBRIWmrodMj
         YuOA==
X-Gm-Message-State: AJcUukfZCw5EqLV1KdXI+LgIhQ3AjxrrqO46KRfNjCOe8ykqYXAubVLl
        ihtz2z1RAK9tqZ4iqdWGpAg=
X-Google-Smtp-Source: ALg8bN4uRtfC5pHp8MSBjf3fUEULavP63ZxmOUhBz3psvbankLQfgUTaizjfe7X/ddK6jByu6CESaA==
X-Received: by 2002:adf:f848:: with SMTP id d8mr24370996wrq.178.1548701381756;
        Mon, 28 Jan 2019 10:49:41 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t5sm350301wmd.15.2019.01.28.10.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:49:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 06/21] test-date: add a subcommand to measure times in shell scripts
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
        <aa053ed9936ebae0ca5e18d27de96f1d054d7f89.1548254412.git.gitgitgadget@gmail.com>
        <xmqqo98754gy.fsf@gitster-ct.c.googlers.com>
        <xmqqsgxdelqy.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 28 Jan 2019 10:49:40 -0800
In-Reply-To: <xmqqsgxdelqy.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 27 Jan 2019 15:14:45 -0800")
Message-ID: <xmqqva28aa7v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I think the goal to have our own stopwatch so that we do not have to
>> worry about differences among system-provided ones makes sense.
>>
>> The only thing that may become an issue is how widely available
>> getnanotime() is.  As "test-date" itself is built on any platform an
>> end-user/developer runs our tests, which is wider set of platforms
>> than what we run Travis and other CIs on, unconditionally relying on
>> its availability might pose an issue.
>
> Sorry for a false alarm, as the codebase in many places like
> fsmonitor, progress, trace and wt-status have been assuming
> getnanotime() to be available for quite some time, and this is just
> another user of the same function.

And there was yet another misunderstanding on my part.  I thought
that the mention of getnanotime() was about

https://www.freebsd.org/cgi/man.cgi?query=getnanotime&sektion=9

and I did not realize that the hits I saw in "git grep getnanotime"
were referring to an unrelated function trace.c::getnanotime() of
our own.  Of course, it is safe to use that function in the tests
;-)

Again, sorry for the false alarm.

We _might_ get a complaint from freebsd devs when they want to use
their getnanotime(9) to implement highres_nanos(), and the cleanest
solution to that complaint will be to rename our own getnanotime()
to git_nanotime() or something, but (1) that is totally outside the
scope of this series that adds one more caller to the function and
(2) we can do that when we actually get such a complaint.


