Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F58920248
	for <e@80x24.org>; Mon, 18 Mar 2019 00:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfCRAqk (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 20:46:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46130 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfCRAqk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 20:46:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id 33so15153829wrb.13
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 17:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JDvKzQdCC0IDunGjtzBSbhl4ELb2YDZ/MEQmbGgW3hQ=;
        b=IoeALmHyw7EbUxqra0yRR3oba5CjuRmDWk9eh9ur6wB3JwyQ4cGxfSU9ZQHGIK+oBq
         F6a/pdZbfZyIp1jeG//hS9VLzN9rt+QHJsK5MbALvdTfNhC86iOQpekUw80L7p3T1zFY
         j++Z9n47q9Qa1WKQlsjaRCUxfsTxglN0TyM28Ry42MdTJEbtIRznxY8U+vcvjQF/PqTY
         2SVqeKA/Ze+cs8OJ/McgkBZUtPHrNvr4LjRaANv9ZafGFhmDCvSBkyrIIIIVwufVsGcy
         duNM9tDQwLnPb2JGRodjH3mKJu+p2tAo9llC+MF/1Z1C9GDbEVHkXPb9JwhrZLSUTpV1
         mNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JDvKzQdCC0IDunGjtzBSbhl4ELb2YDZ/MEQmbGgW3hQ=;
        b=mBgO+FY4A89tYIb5eBDpDn4GsXbC+uprvW7Al7C3WkxY6rwlI8oCrHFInGI563FKog
         ewSTpUQiCqmSS4vTHtUB20PuDWMsYE8kXqjOKhZxnURpmc4CfrPqNTheaYtg0fWUcJ5s
         FVz7CyOhn3t3884aTaUX83kKnG1Eb2DSxtWOKtvHBD06PP/GjZGkcKZry85mJc6ZVM8O
         RL6mwibhsur+demJNWckxBCMDC7mpx9H1dtcoHjqQXLQa504AtdjiJ41MHV8P+JzTiZB
         0eXns/yQB6rfHqws05UBfo5JbvaIqnkF5tvmSEx4B2fT5oqniBE98mWwJdj7RwkVBYyI
         VIuA==
X-Gm-Message-State: APjAAAUv+kU97ZN/QiyUzNjXW9QszvJm9nQBKNuDz83foKyn2RVYuBGY
        eHHK7C73rmd+ZnNG3XGLcGtyXkgemSI=
X-Google-Smtp-Source: APXvYqxtNpCYocy+2qUzdUfqup8OGb6V5YoRH+LvwZXPEsvwxCeRJ1AsCz5yRI3Uj99CZvr/lUnZQg==
X-Received: by 2002:a5d:644a:: with SMTP id d10mr9657013wrw.308.1552869998474;
        Sun, 17 Mar 2019 17:46:38 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id t2sm31193887wra.9.2019.03.17.17.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 17:46:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: separating regression test patches from fixes, was Re: [PATCH 3/3] cherry-pick --continue: remember options
References: <20190313182615.7351-1-phillip.wood123@gmail.com>
        <20190313182615.7351-3-phillip.wood123@gmail.com>
        <nycvar.QRO.7.76.6.1903132344350.41@tvgsbejvaqbjf.bet>
        <xmqqimwm9hh5.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1903141432000.41@tvgsbejvaqbjf.bet>
        <CACsJy8DCZLNNa9zFj04kPx=f1S_5VJqqP_qTK6QYJ0fFmusymg@mail.gmail.com>
Date:   Mon, 18 Mar 2019 09:46:35 +0900
In-Reply-To: <CACsJy8DCZLNNa9zFj04kPx=f1S_5VJqqP_qTK6QYJ0fFmusymg@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 14 Mar 2019 21:30:53 +0700")
Message-ID: <xmqqbm2980wk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Mar 14, 2019 at 9:10 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> In any case, before we get better tooling to work around these issues, I
>> still think it makes a ton of sense to encourage proper separation of
>> concerns: to keep patches that introduce regression tests demonstrating a
>> breakage separate from patches that fix the breakage. It would certainly
>> help me (e.g. when staring at a range diff).
>
> Then perhaps improve the tools now because these separate patches
> enter 'master' and stay in the history forever. One of the problems I
> have with separating tests from the actual code change is the
> description of the problem often stays on the test commit, which I
> can't see in git-log if I'm searching for the code change. And no
> sometimes I can't just look at the parent commit if I filter code by
> path (and with --full-diff)

I do not think the phrase "separation of concerns" is applied
correctly here.

The concern of a simple single-patch is to fix a bug---the test that
shows what bug was fixed and protects the code by ensuring that a
reintroduction of the bug gets noticed is an integral part of it.
It does not make much sense to artificially split it into two.

It's like arguing for adding declarations for new functions and
global variables in *.h files in a step before a separate step adds
their implementations in *.c files, claiming that the first step
designs the interface (which is sufficient for writing the client
code) and the second one gives an implementation of the interface
(which can be replaced later), and they address two separate
concerns.

And then you would find that there are some compilers that warn
against unimplemented functions and undefined variables.  The
"solution" would be to enclose the whole thing that was added in the
first "*.h only patch" inside "#if 0/#endif" to hide it from the
compiler ;-) That in fact looks quite similar to how "test only
patch" marks the new tests as expecting failure in the beginning.
Neither is truly useful when applied to a context different from
where it is originally developed for.
