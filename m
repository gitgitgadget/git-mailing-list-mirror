Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D3191F597
	for <e@80x24.org>; Fri, 27 Jul 2018 17:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388999AbeG0TMG (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 15:12:06 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:34018 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388957AbeG0TMG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 15:12:06 -0400
Received: by mail-wr1-f42.google.com with SMTP id c13-v6so5839168wrt.1
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 10:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5qw26pTacf3jMEMhVHgqDdsXn3nzM35CPPLq+AThEVE=;
        b=lKGWip9NGZVMf1CZTo1CpJFFmBE3gH5Ar57A5Rr1NH+uloh7RYB5GT3fUqnRjUC6Hw
         vf03Xgh/jhLSAJZGGCDMXHiB2cDW687FH+bdq8tAk8dHcOPdSbf9zN3a97TdAnLZT/TC
         rlXuQlEUxJZSDleZ9mBfdFkVBChQhcpN5an0MtCROUvhZMiOe3eGpLdaOkifau+JBYaj
         u6pfDJNGcm1NgU34YMBQDanhD0tm6ePVYwZxBRwttuhbA7oozCezXabeOuR3wCkSGVlF
         ud9Imq19ZhgYBhnPZU6jOlOAaDevZqp0kUdWAh4aYRlma6i56kKrsG3kqISgG3ViSG70
         jABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5qw26pTacf3jMEMhVHgqDdsXn3nzM35CPPLq+AThEVE=;
        b=gKMny7LD88iysSrGM8on81oVzzYuC6+92Jb/KR/tsm1z/3RM8C6yU65IcnTwCBSi9P
         G7BLj1HymBGau9OV1dZpB2szSfKsRPi5vkd75Qvr7Ak6oE/f1ne98A+ndrmpauXI82rX
         PrpyNC27TUHPPBWNs/l8AyPbqaFgLHX0laZj8FBc50q29mDUrCVMmP4tfaGmTZ3gZcP9
         uz57JP/AaCdLJ93lDQ1mHaVzRVQk/At/ouqD++ZUwoe8klH2COkXYMXoYrDWnFvP4n8m
         xVQiaIO1T4DBDLaPjs3avuQD8+6HDDSxCigESHP5jqDw34XiJVKFqWlWDOAyVfa3YJ6t
         Kj8A==
X-Gm-Message-State: AOUpUlGsBxlo9M+JUxxJD8nY+9+RMMW5TCPubBgwOVaUTLnNqTMP1N8b
        fvIljbQDytcp7xx2/MMU8D8=
X-Google-Smtp-Source: AAOMgpcmWCZwXx6Fpqa5yKrxu7MSl13iq6ofukysx+ajJVv7cMXh/TfWZuTHpsYBBsTP2bVcCfz3/A==
X-Received: by 2002:adf:8895:: with SMTP id f21-v6mr5792970wrf.250.1532713747193;
        Fri, 27 Jul 2018 10:49:07 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f23-v6sm4319677wmc.42.2018.07.27.10.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 10:49:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v9 0/3] http-backend: respect CONTENT_LENGTH as specified by rfc3875
References: <20180610150521.9714-1-max@max630.net>
        <20180727034859.15769-1-max@max630.net>
        <20180727035013.GC1959@jessie.local>
Date:   Fri, 27 Jul 2018 10:49:05 -0700
In-Reply-To: <20180727035013.GC1959@jessie.local> (Max Kirillov's message of
        "Fri, 27 Jul 2018 06:50:13 +0300")
Message-ID: <xmqq4lgko9gu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov <max@max630.net> writes:

> Only the 3rd patch has changed

Thanks.
