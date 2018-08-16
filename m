Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70E641F404
	for <e@80x24.org>; Thu, 16 Aug 2018 21:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbeHQA00 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 20:26:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36791 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeHQA00 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 20:26:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id k15-v6so3451879edr.3
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 14:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=04AHEt6Fq2smpqTD0ZPHzzTPHHRofhNFJmvu35vlGJg=;
        b=vQvxAtLXJs1668mJyPs1hnRZsziS5F5mlnWKITwueyWJ7OEIIM21wAOZtgzyS+EcoM
         B0WcXFveij734+EMzZGQrkSKriJyz0eEvL1fciUzlK73I5a/pmbgx29ZasevmGguU/KH
         mPOPSlWjNN30oc86Ckh+HuaeR0uNvdujOp1JBCSDG32RFpQ+bXxlY693KWlfLd2HoiyN
         Rk0d6KPOGrad8IpveVubHGhGvnk60JmxoV4CX2Wvn7XQQNerxWisaGB7yv0y9wXkIZ3B
         aiBvO7EseFrbJSbu8i3yfroXzhzUyaapE0ea+DhetbV5XSvJNN0KhAVaKw3di5Y4gmcE
         qRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=04AHEt6Fq2smpqTD0ZPHzzTPHHRofhNFJmvu35vlGJg=;
        b=hhvDDkinj/W1bOfiGBnp0+Bm40Ihw90A+8SKE3oqo/HonxITX3QQVCDGlCkczrSV1k
         LNKu1zn5naeta0Z6wgUciXE1h285SJ1ctwQq5vbF/Ypu9kViGrI89U3Yvg2rlaKr/SDA
         zBgmJBZqzzZ7VZb74lWBghdnUbPU3KuANMNq+rdQ1l+00sRTHOvghckIkCA0mT7ECrZg
         L1vXzBN2UXvUHF/4dl2O0b8NWIpkSw1PrygS7De1YSKrXjnXeL7kOxzoe8CEIduYSm+k
         zl5y2XW/6gtqNr4Sh9Bc9WmJ40znfLi2HdJVkhyY2ohKIG3Ft3XO7uOuatFShhVvfq3d
         +a5g==
X-Gm-Message-State: AOUpUlFnEqHa/WphMaM9MqaG3kzfH+3NM+1ffiBxnJ629TMAA/Y9KR6m
        KdRUzMXIS5XSa1wMy1rj5fBfYZeM9zAP41CsO4B6O5KN
X-Google-Smtp-Source: AA+uWPzfYZZXqElijKjinP+Zu/Tbl8J+BuqqBL6Hb3Y9tU1/D6WrC+YaHdBz7CZoY6VgnGIwjVtp2NiQrVZxbt9O6ts=
X-Received: by 2002:a50:8ee4:: with SMTP id x33-v6mr38176867edx.175.1534454741363;
 Thu, 16 Aug 2018 14:25:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:2642:0:0:0:0 with HTTP; Thu, 16 Aug 2018 14:25:40
 -0700 (PDT)
In-Reply-To: <20180815222503.GR2734@hank.intra.tgummerer.com>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
 <cover.1533753605.git.ungureanupaulsebastian@gmail.com> <20180815222503.GR2734@hank.intra.tgummerer.com>
From:   Paul Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Date:   Fri, 17 Aug 2018 00:25:40 +0300
Message-ID: <CADzBBBYXQRda28oq6KmfpNNJvG9OCeTxMd1Ra-VfjP1S4FEJ-g@mail.gmail.com>
Subject: Re: [GSoC][PATCH v7 00/26] Convert "git stash" to C builtin
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Aug 16, 2018 at 1:25 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 08/08, Paul-Sebastian Ungureanu wrote:
>> Hello,
>>
>> Here is the whole `git stash` C version. Some of the previous
>> patches were already reviewed (up to and including "stash: convert
>> store to builtin"), but there are some which were not
>> (starting with "stash: convert create to builtin").
>
> Thanks for this new iteration, and sorry I took a while to find some
> time to review this.  I had another read through the patches up until
> patch 15, and left some comments, before running out of time again.  I
> hope to find some time in the next few days to go through the rest of
> the series as well.

Thank you a lot for taking time to review my patches. It really means a lot.

> One more comment in terms of the structure of the series.  The
> patches doing the actual conversion from shell to C seem to be
> interleaved with cleanup patches and patches that make the C version
> use more internal APIs.  I'd suggest putting all the cleanup patches
> (e.g. "stash: change `git stash show` usage text and documentation")
> to the front of the series, as that's more likely to be
> uncontroversial, and could maybe even be merged by itself.

Good point.

> Then I'd put all the conversion from shell to C patches, and only once
> everything is converted I'd put the patches to use more of the
> internal APIs rather than using run_command everywhere.  A possible
> alternative would be to squash the patches to replace the run_command
> calls with patches that use the internal API directly, to save the
> reviewers some time by reading through less churn.  Though I'm kind of
> on the fence with that, as a faithful conversion using 'run_command'
> may be easier to review as a first step.

Makes sense. Actually, as you said, the patches that replace `run_command()`
or `pipe_command()` were not squashed because I thought it might be more
easier for reviewers. The `stash: replace all "git apply" child
processes with API
calls` patch is a exception to the rule because I was highly in doubts
if the patch
would actually be good.

> Hope this helps!

It helps a lot. Thank you!

>> In order to see the difference between the shell version and
>> the C version, I ran `time` on:
>>
>> * git test suite (t3903-stash.sh, t3904-stash-patch.sh,
>> t3905-stash-include-untracked.sh and t3906-stash-submodule.sh)
>>
>>         t3903-stash.sh:
>>         ** SHELL: 12,69s user 9,95s system 109% cpu 20,730 total
>>         **     C:  2,67s user 2,84s system 105% cpu  5,206 total
>>
>>         t3904-stash-patch.sh:
>>         ** SHELL: 1,43s user 0,94s system 106% cpu 2,242 total
>>         **     C: 1,01s user 0,58s system 104% cpu 1,530 total
>>
>>         t3905-stash-include-untracked.sh
>>         ** SHELL: 2,22s user 1,73s system 110% cpu 3,569 total
>>         **     C: 0,59s user 0,57s system 106% cpu 1,085 total
>>
>>         t3906-stash-submodule.sh
>>         ** SHELL: 2,89s user 2,99s system 106% cpu 5,527 total
>>         **     C: 2,21s user 2,61s system 105% cpu 4,568 total
>>
>>         TOTAL:
>>         ** SHELL: 19.23s user 15.61s system
>>         **     C:  6.48s user  6.60s system
>
> Awesome!

I hope that it will get even better.

Best regards,
Paul
