Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20D501F404
	for <e@80x24.org>; Tue, 14 Aug 2018 14:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbeHNR0J (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 13:26:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36355 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbeHNR0J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 13:26:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so17450602wro.3
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 07:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5wrmEYnNW5AzZdQ7/S7DJZMtD3EucUWqZ8DOfa7dZVg=;
        b=IC5+qGZF0nhH+SPn8Kvp5x//Rbbdq2r0B8SEMZh3p0yt6dQYoN6Ofz57CaIo8kkcw4
         ihkULORbk7g/oUa8yN07LBI2rTxb2MFZYiMe4K5LzT2943BeKW234EJ3nG4bB2GImVdl
         ZwwDPiK0Fti5tERo9PlYli7D9JJ7tdra8SBIjhpvXmIx8pOANZt80HqQyV6MacgeKvt/
         3+zqW82ry5184wezTuZU7lL+Z3GVqtLeaJVxrU7OYxtG/4oJbvfM6l2dBoMWyc9t7gtK
         CJu8S3vTfKW/1NsqyzTr9JqCo8tv3AXjjoKsCf8+IG+PJnl8yHfpDScxKydOtQPUAPKw
         Kutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5wrmEYnNW5AzZdQ7/S7DJZMtD3EucUWqZ8DOfa7dZVg=;
        b=gbEuzb0YJwO9H8N5VkwswC5UDzUlemH+4BM9GtPwBhx3o9MQnOWNsBgHUs4yYORN4a
         vPOUrDzcJAEJmfo1sEjiH/iVCbbTlSOTfxMT7dPaeQDCp1v6ga9HCe1amOYkZZKgruUw
         SHzM9YZ43gHZJeRaeIB4F7QgD7oVW05sgnUGn+5Qj5iO5Un4FXyUQtKPhhoVwn7aEcSC
         hdoEfGnuvGGikL7Iy3Td6rV8mpO/RIEhRWLCDul07apqo7GQHGXtQRYxsSfXMvBMChGq
         Ze175mytvxgi0PVyuxgbB7UyqGCd6+DTV4jL9RluwGvUS4Rhb/v6/ZAhuWCC5MAGULgZ
         VVFw==
X-Gm-Message-State: AOUpUlEA9+Lc4DNiTESMe5Bxi+60rL40M1nhBSHRjvlCafgRXO3x59Xs
        rzG9v6riDygicZ+082WwuPE=
X-Google-Smtp-Source: AA+uWPxnkd6zwjy4MJftfa+h7htK37oJDqyfBa+aFCWk4seZ/aWHwTU6iO0rhxppVcCTBMPjQn0m5Q==
X-Received: by 2002:adf:f28c:: with SMTP id k12-v6mr13674367wro.263.1534257521405;
        Tue, 14 Aug 2018 07:38:41 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t186-v6sm15921083wmf.14.2018.08.14.07.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 07:38:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] mingw: enable atomic O_APPEND
References: <pull.17.git.gitgitgadget@gmail.com>
        <811ded48-6f33-c46e-7bae-b9f7c7e8764c@kdbg.org>
        <xmqqin4i83zg.fsf@gitster-ct.c.googlers.com>
        <bc9132ab-3030-07e3-03d1-d2ddae6a1b45@kdbg.org>
        <5a7e7ed1-da0b-20a4-147d-a24ca7da5832@jeffhostetler.com>
Date:   Tue, 14 Aug 2018 07:38:39 -0700
In-Reply-To: <5a7e7ed1-da0b-20a4-147d-a24ca7da5832@jeffhostetler.com> (Jeff
        Hostetler's message of "Tue, 14 Aug 2018 09:01:55 -0400")
Message-ID: <xmqqftzh2ets.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 8/13/2018 3:02 PM, Johannes Sixt wrote:
>>
>> Fortunately, Windows does support atomic O_APPEND semantics using the
>> file access mode FILE_APPEND_DATA. Provide an implementation that does.
>> ...
>>
>> Diagnosed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> Helped-by: Jeff Hostetler <git@jeffhostetler.com>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>
> This looks good.  Thanks for following up on this.

Thanks, all.  Will queue.
