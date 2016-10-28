Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A16332035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759693AbcJ1Stt (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:49:49 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:36706 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759466AbcJ1Sts (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:49:48 -0400
Received: by mail-yw0-f172.google.com with SMTP id u124so99580953ywg.3
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OV7W1Ib3f1n24rUPsOd4x4imJhLLYy8l0iEHlquATF4=;
        b=zI5YpWusLNuHc7qb7oL8rhY/IqMT38tQQb9U5g2fAHQxnDY0Dxdv/Ci+zVKfESe7hT
         jEDun2IhoSOqQlGFsOYUBtmKwPjnHtJOrX2eRdh46DY5sHqrzKXpIakWkfD5PJ4ZjJW4
         kCLBT6LnutMnpCm/j/6bPrPqr93+3ENPeMAbGhU5IEOsBAfuD79JOUPlCO4iR5INNUzR
         OvvhFMkANoXM0SBGsajLZdaBAJ+ZAkhcmgdri4EkkAPgEiYW/ae9VG1PnrnY4S47HoWo
         O+/BEtoE6p2dZPon4wr+6kIfbK/PcxQEVgIPzL+gayMuGYpTnPLEJXj8gkWyDzURcuY7
         Ukvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OV7W1Ib3f1n24rUPsOd4x4imJhLLYy8l0iEHlquATF4=;
        b=I0bH2PzmBkwjvoho1YCoBaDV3ERSERdGIpUy3GxEz9iKo+WEohdnxb5Z4qHL7wG0pI
         yiGvkBqv9nVGHudpehLTXIrbKDsir3PsHJ72yTUvSE6EDft4OAy/OeVEbC/flFPalcyq
         8nW2oSRE/7UV5P7GDawE12t9UQXUEK2O66Lfl1ulr7iAWzCd7T6Xjck5J3x2WveDmDfS
         JxvdyyfR0RrXAiVHMrOwqTvGEqJLZi+v3WLUTQoT8A4cZun8BkslE077gr31fPFc4R2s
         9e+AlVGonnYUrtn18W+F1kfVHDJCnqGlDCypbySWp4e2x6SdbQBxYtgYHZqLbHpG/rLK
         7I5g==
X-Gm-Message-State: ABUngvcJoz6HfAsXTFEg3mssdRrtguYqwUA8ZJqSJIYA4AXtqDXZx29tK6g9hlI3Q+dMVs5df+IYCqObil3wGA==
X-Received: by 10.13.231.131 with SMTP id q125mr13261390ywe.122.1477680585962;
 Fri, 28 Oct 2016 11:49:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Fri, 28 Oct 2016 11:49:25 -0700 (PDT)
In-Reply-To: <B5FD05E58E36480894F1BDBBC9589EE1@PhilipOakley>
References: <20161026215732.16411-1-sbeller@google.com> <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
 <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com> <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org>
 <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com> <xmqqd1im8foi.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbP3pgPHgv-x1Q-Q1QwmXc=gOyxWhXh2SngO8WSZc3PFA@mail.gmail.com>
 <34c88c40-2088-fd74-5d26-56c0599b7eb9@kdbg.org> <xmqqr3716301.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kY_fZ_pDtVnwJoDkR6PjTNoqDMN5OC70Z8SH_J0Wvkq-w@mail.gmail.com>
 <a2e5acd6-485d-0387-7a85-6042dee702f7@kdbg.org> <CA+P7+xpckfaeHmoEGQBdLD-=Kf7gQ-jOxGFKrKmiFH1SBN7GjA@mail.gmail.com>
 <2ddca5e3-3c4d-b555-4309-a180ceed581e@kdbg.org> <B5FD05E58E36480894F1BDBBC9589EE1@PhilipOakley>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 28 Oct 2016 11:49:25 -0700
Message-ID: <CA+P7+xoNSrhaQ50GZ4RzLregznw+0yf2=ttNuYf1VUw+YabdFQ@mail.gmail.com>
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Johannes Sixt <j6t@kdbg.org>, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2016 at 6:01 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Johannes Sixt" <j6t@kdbg.org>
>>
>>
>> One point is that the DCLP idiom must be implemented correctly. There are
>> solutions, of course, and when the initialization is over, we have a
>> miniscule overhead at each pthread_mutex_lock call.
>>
>
> I had to look up DCLP ( = Double Checked Locking Patterns), and found a good
> write up on the issues..
>
> http://www.aristeia.com/Papers/DDJ_Jul_Aug_2004_revised.pdf "C++ and the
> Perils of Double-Checked Locking", which include 'C' issues, and
> multi-thread, multi-processor issues. Not an easy issue when fighting
> optimisers..
>
> --
>
> Philip


Yep, this is why we have memory barriers. Ofcourse languages like C
don't really allow you to express them in the language and we restore
to various platform specific methods.

Thanks,
Jake
