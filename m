Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB90F20A04
	for <e@80x24.org>; Sun, 16 Apr 2017 11:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932267AbdDPLQ1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 07:16:27 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33534 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756271AbdDPKxe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 06:53:34 -0400
Received: by mail-oi0-f54.google.com with SMTP id b187so121956307oif.0
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 03:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=137zpAEpNsEiWZaJ6goF2UoBScoE9f76j2piYoxAySM=;
        b=K0fQcx0sidNbzmmNhc1z8IcSfAwuYPP5KLqVfUQN/DuElh0Pti0BtzflWlG4hHqNPE
         p0EBYd/bzKdjWhL7gEijGjxCXeKAULKpA4Fd71+Z9s9mesQpNti+E9jaZE5J67y2UDEG
         BgyeJTdg77HlaoP3IBeOw/oaeJtxNzyYdffFhwqQktjg2iCm9Of2NlnwuxZZZ0o9+hP9
         nRHZO3hKuIpYtiVz7KULct6cUFeFPwTpdd9DPxIrsLvlybkdfNe3SAShJyn/p6JXwzEm
         ssOQicpzlYHZDsbvBYo+IxG5RiceNacYA2kX49nf0X4gIUnRzKh/zjuO1rfYeR8cLBzf
         brHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=137zpAEpNsEiWZaJ6goF2UoBScoE9f76j2piYoxAySM=;
        b=efi3wmKpDbs80gGhc/RJc4ENo0KoS00ZXqznDt5zoS5a8Sun4lxxEgemzsKC9+NKTm
         GnAjGRvqq3xzcogvgAOn1v7fQgfqGMT46yedtb85nUhsXa27eXMjftJYc1s8w8wdsM/z
         +8l1Tza3vDDYzO+vSbMXoPiPuKVzUK89Tpi7XeE1tbTcw1T82WKXxH1Yt4BFVRPFaBMg
         ix8KoDd/tPKwCU2qwO1y3cpRtMZGMOyvYqtJQwa/Qj+oOy1I5To8DXHMUftuRs+TEv5P
         KsFYE6vHk3QUYP6wJV54Bs8hEIKGuF25sNBLgdnKBP5KcSOlavazJA6o+CjIUUOB26PM
         lfCQ==
X-Gm-Message-State: AN3rC/4+0oGQWCKSZsm/Wqo5tNDcrI3/0+tl6UsIkxiXn5CdCHh7Hd4z
        jP3ZnlT/dir7OZmVenGMueerT0MIhQ==
X-Received: by 10.157.61.163 with SMTP id l32mr3019129otc.28.1492340013690;
 Sun, 16 Apr 2017 03:53:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Sun, 16 Apr 2017 03:53:03 -0700 (PDT)
In-Reply-To: <CAO-Op+GujOUuueqwOKbb1NosZ-VYY5KVWm1+HNMC8xhd0ApEDw@mail.gmail.com>
References: <CAO-Op+GujOUuueqwOKbb1NosZ-VYY5KVWm1+HNMC8xhd0ApEDw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 16 Apr 2017 17:53:03 +0700
Message-ID: <CACsJy8ASuQqnZb97BmPtOeAoTuS4bE6-7p21SDd9DP6SNyX+3Q@mail.gmail.com>
Subject: Re: [BUG] ls-files '**' globstar matches one or more directories
 instead of zero or more directories
To:     Alistair Buxton <a.j.buxton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2017 at 2:17 AM, Alistair Buxton <a.j.buxton@gmail.com> wrote:
> To reproduce, go to any git repository and run:
>
>     diff <(git ls-files '**/*' | sort) <(git ls-files | sort)
>
> Expected result: No output since both commands should produce identical output.
>
> Actual result: '**/*' only matches files at least one directory deep.
>
> The same happens with eg '**/Makefile' - only Makefiles in
> subdirectories are listed.
>
> I have personally tested with 2.7.8 and 2.12.0. Others on IRC report
> that this happens in the next branch.

Another data point. t3070-wildmatch.sh has a test for this case

match 1 0 'foo' '**/foo'

so the pattern matching machinery is _not_ broken. There may be some
changes in ls-files (pathspec-related?) that leads to this. But I
didn't try to bisect it.
-- 
Duy
