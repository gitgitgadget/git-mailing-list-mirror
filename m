Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E48431F404
	for <e@80x24.org>; Mon, 16 Apr 2018 17:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752916AbeDPRpx (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 13:45:53 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:38527 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753087AbeDPRpv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 13:45:51 -0400
Received: by mail-wr0-f171.google.com with SMTP id h3so15742563wrh.5
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 10:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SG/nY1BhL9AVx/YPCp8EldZSUwuijJwIOUV+2BbLWCI=;
        b=Q8Ff5C+C3iwcFHye7sV6fUX6Ttrx8TpUl6JTzz5bhmtlf1a92wAMz3y18DF5EF7OZR
         HiwNvaAn2s+6iugPojhKIG6Co/oL9llWQg2dG9SYC98DdP1wNKOphmwq1ymAG0WsVXpa
         94Zm33c9yQPtrjYXruVHA2H0D2xEIBEZ5p+yK5h5G4HsDFpnfd3+BlFsvoWd2EA4S7mS
         01xuq2GkUvtO9mV/+x8JNtFZNnUYB9EjkqR/Np9oN+uQ5hC9UGjCeYj+rex+qNibVEQ2
         jrcHI12Zkvwb3zmthXLxr3T/lALGo9TNlr/Gu0sQ8TMllhqnTQgKd9HC65DruHxxlgv3
         6PKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SG/nY1BhL9AVx/YPCp8EldZSUwuijJwIOUV+2BbLWCI=;
        b=HkLjiHNXffOM6wjM246ut0ne1t3mF+HMr7DjAGJIiebMecuQ1jbnxtgD36PPCgwTD0
         i/Z0NqzHR+5CcGMwLRx0qxge551SP//d+cRqjoVxKt9+jWptB6Y5QeQExiHE7cmUgp+Z
         8+D8OGOplX2TWYfjsel//h1B/AsX0OEy5noO99aMlS+VYTN4VwAZFf50oFm7Z6Q5plRz
         Bo23grBORZGrHurOax+es9ZkWG9J4NZSSxyLDQBhH1VzbSuwOImpMcl9dKgJZ9gEk1X2
         QjtMm7nsyckswnWAFPNsxSdO0toPr5q8GUrZ+6PR3WiT1qaRXJBsRh0sJEytIsa1HXNK
         y/CQ==
X-Gm-Message-State: ALQs6tCropWNylj0LFPlhG+N+sWneImqFzgFBQVwGv+1KxV8QNvWeQlE
        JdKAM4M49jAhKQfIBcfUIokUVbPP56z+42tk09o=
X-Google-Smtp-Source: AIpwx4+gTHxiHoc6gg7r3EnYLUWmJCYxhV3zaIof4AcgPbivf3gDVnmo/5mtAnkIPyH+FwC1k3ZDX/3S2/WjNaIvEaY=
X-Received: by 10.80.208.2 with SMTP id j2mr33953160edf.44.1523900750000; Mon,
 16 Apr 2018 10:45:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Mon, 16 Apr 2018 10:45:29 -0700 (PDT)
In-Reply-To: <CA+P7+xrmAHjaF=wze1iu0=cZBY3WcHXqpuDep3Nrev+zmt_Gog@mail.gmail.com>
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
 <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com> <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
 <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com>
 <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com>
 <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com>
 <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com>
 <CABPp-BHQsOSCJiPU9Ku5b67QTkAjnEBrhx04mTXf2QdPBriHmw@mail.gmail.com>
 <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com>
 <xmqqbmekylgc.fsf@gitster-ct.c.googlers.com> <CA+55aFxP8j7YbYaRXt-8Y0n8cHafB=FPKMy8gKFYH5QsKX4S=Q@mail.gmail.com>
 <F1738316-71EF-4053-82E5-F009F491CCE8@gmail.com> <CA+P7+xrmAHjaF=wze1iu0=cZBY3WcHXqpuDep3Nrev+zmt_Gog@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 16 Apr 2018 10:45:29 -0700
Message-ID: <CA+P7+xoVcPV_mFS3WpUvCUR7N4SzJ5WBZqpGT3VVWdkPjh6Qww@mail.gmail.com>
Subject: Re: Optimizing writes to unchanged files during merges?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, mgorny@gentoo.org,
        Peter Backes <rtc@helen.plasma.xg8.de>,
        winserver.support@winserver.com, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 16, 2018 at 10:43 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Mon, Apr 16, 2018 at 9:07 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> What if Git kept a LRU list that contains file path, content hash, and
>> mtime of any file that is removed or modified during a checkout. If a
>> file is checked out later with the exact same path and content hash,
>> then Git could set the mtime to the previous value. This way the
>> compiler would not think that the content has been changed since the
>> last rebuild.
>
> That would only work until they actuall *did* a build on the second
> branch, and upon changing back, how would this detect that it needs to
> update mtime again? I don't think this solution really works.
> Ultimately, the problem is that the build tool relies on the mtime to
> determine what to rebuild. I think this would cause worse problems
> because we *wouldn't* rebuild in the case. How is git supposed to know
> that we rebuilt when switching branches or not?
>
> Thanks,
> Jake

I think a better solution for your problem would be to extend the
build system you're using to avoid rebuilding when the contents
haven't changed since last build (possibly by using hashes?). At the
very least, I would not want this to be default, as it could possibly
result in *no* build when there should be one, which is far more
confusing to debug.

Thanks,
Jake
