Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBEB21F404
	for <e@80x24.org>; Wed,  5 Sep 2018 16:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeIEVMR (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 17:12:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55830 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIEVMR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 17:12:17 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so8651150wmc.5
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 09:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VHwJaX58fugyZIOPtGF2Wd7RuIM4UDQ8eTgGiGZE88A=;
        b=ZMLBfl/OHRgKz+tqNweggO7/qQvcYHE3TpZOooYlF7b+CGaPs5ByCqnXLjBPXfA/ih
         T9DFOiK0qetiZYmYlD9/eECbAOFME6Tuhec8ta6vziBT3YKxV1yo1nbJIGasHCEwFgbz
         ucLrz5qFIocdN/f0nFu80rgg1YbhXSlpuNQZfcy3tlBTOaABtxHenqrHekPsy9BrRr0O
         Jm0cJYmncgOi/SEhBFFhvyWd9L+qxSsjEytzeWH0VvhK+Bkm1jKPjfTHZNcSJM8W80au
         XpmnDmOeGvGFFV8ZJ2KbhohZZGfkbfbZgbCHwEeEp3uSTaTvr0nqM5vD4c+qq+iWfd+I
         dUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VHwJaX58fugyZIOPtGF2Wd7RuIM4UDQ8eTgGiGZE88A=;
        b=ArU4CEE9AVIuP7d7xqMoOigVZO/+/zApoiB3z3mhgLFZmB2k0nbwYOGe42rPLebXWg
         EyiWZrkegE38fCC03pQCURNCJ4AgjJYOrKbSm+8K3iE96Snew2kCygJog/5365+RDJyc
         mGMUsTPvHkqNINrS0aqYKEWWRuX+AMsM/ghHaZaxMwuSYbndmvL0OsxZrrrv2C3dpVtx
         7jlZEmGv9GygCWGbR2QDnt2FiMcgAmCwGC2sRGnQll8th1e/aLfwj/osFjFHxFfQEdc6
         eK46cHo5hnLWFyYBzhRqaAnCl0bL3mKDPEGTa6hVHkcf9sjb3aIMHuUBmT1eG87aU/J5
         tFbQ==
X-Gm-Message-State: APzg51Bz11ANVi1XJpo8BHodHGE9W9y0Z3pbtdmb+IJqnUHx9rdRCR19
        /3maiU6zcfokBJ5CgOQ+Ojs=
X-Google-Smtp-Source: ANB0VdaUolbJ8YwjrqjwDRJftrIbbB4gDY49N3KkhAL8A3L40EzA5aBfzaJ7rocgyuUxK6oEo+0/wA==
X-Received: by 2002:a1c:af53:: with SMTP id y80-v6mr754968wme.55.1536165677276;
        Wed, 05 Sep 2018 09:41:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q5-v6sm3124835wru.79.2018.09.05.09.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 09:41:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: jc/rebase-in-c-9-fixes, was Re: What's cooking in git.git (Sep 2018, #01; Tue, 4)
References: <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1809051536391.71@tvgsbejvaqbjf.bet>
Date:   Wed, 05 Sep 2018 09:41:16 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1809051536391.71@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 5 Sep 2018 15:38:18 +0200 (DST)")
Message-ID: <xmqq7ejz6gnn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 4 Sep 2018, Junio C Hamano wrote:
>
>> * jc/rebase-in-c-9-fixes (2018-09-04) 1 commit
>>  - rebase: re-add forgotten -k that stands for --keep-empty
>>  (this branch uses ag/rebase-i-in-c, js/rebase-in-c-5.5-work-with-rebase-i-in-c, pk/rebase-in-c, pk/rebase-in-c-2-basic, pk/rebase-in-c-3-acts, pk/rebase-in-c-4-opts, pk/rebase-in-c-5-test and pk/rebase-in-c-6-final.)
>
> Quite frankly, I'd rather you pick up my two v2 series. I promised to take
> over from Pratik, who is busy with exams, and I did. I even announced as
> much in that mail where I pointed out the missing short option originally.

Yup, I'm planning to replace the large pile of patches with the new
ones you'd send once the final is done.  The topic above is just a
stop-gap measure to keep the tip of 'pu' testable, to be dropped
when the series it fixes is replaced with a corrected one.
