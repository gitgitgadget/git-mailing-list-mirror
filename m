Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B51FB20966
	for <e@80x24.org>; Thu, 30 Mar 2017 18:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934565AbdC3Sx1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 14:53:27 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33587 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933891AbdC3SxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 14:53:25 -0400
Received: by mail-pg0-f52.google.com with SMTP id x125so47570131pgb.0
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 11:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ysIayvWgxs9+HRHU67Bsmxt05tN7xgDHG1DDvyLlYpM=;
        b=nP9BPiS+eaggvM/9e988hxnUC0bZWdc0wJu85oBB61FX6urNbgheDDGHSMxcMG8kjw
         73J+2eBgsVvZgE5LJKHy1Q1fim8MzemOSfFnlbTjClztdQ+yYuSOdwU7abX9V7fBIshQ
         2JdHcz0Jsucsmex44/x5t8io2MkiCo7VMffZIjdvcw6cyyGp7tMoom+lle0pp7EAy59D
         JNEXCHxwaQRSBeN72ayHorH2mfYcO1DOQt+cEOYcY/GfPHCQK+D0TDZRx8C9HuFo0zbz
         sF08UE20iv6qVlMj8JOhAnZUoCJAadewdFUyL9kshRiVno9reJbDGNWJTQs/IXoZ8oDx
         qx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ysIayvWgxs9+HRHU67Bsmxt05tN7xgDHG1DDvyLlYpM=;
        b=K7bnW6jS5jy5nmyuVhDoFumnYSxfEV5rN+3nU29TmlZ6WYFWPm6Rt0GlubjzR/eC9Q
         iQIRQIS+hyJVZbeyTXLjVsn59yDlFjGHrwspdKDxyT2c0C5AL4KQJT94DhYAObZxKjlz
         Knnjef7XPQbMjew0EpDBF9vX8P5qbJWsIqsauSMCPB4MMUdubRJkdLy57jaRCORpOANo
         Bb5m0YKV0wS5r3Jn8kFdWLidy8moZlyBmls6Kj+QVmSVeQ3tymYhFgngF7Mxw76qr6Iy
         eATZSg3Zk47vYL+CFG6Pp+ukjbH0zP3SWUAtDGHffb6GFJ6mC/mjsGZg9AU/3u4HJRo1
         dqzw==
X-Gm-Message-State: AFeK/H3a16CYLtTQG9Wy42yFlI/RYElswBDqBG6oJWr98B6Xp0c/xZbDi2o9R1+IPSiWdY1RkttlMh2N+ddO7sxm
X-Received: by 10.84.136.34 with SMTP id 31mr1039192plk.52.1490900004434; Thu,
 30 Mar 2017 11:53:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Thu, 30 Mar 2017 11:53:23 -0700 (PDT)
In-Reply-To: <20170330032219.ujqddocibufn535d@sigill.intra.peff.net>
References: <20170330014238.30032-1-sbeller@google.com> <20170330014238.30032-4-sbeller@google.com>
 <20170330032219.ujqddocibufn535d@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 30 Mar 2017 11:53:23 -0700
Message-ID: <CAGZ79ka6_wmVecBDpCrxr+3Vp5evKVUf164fs=CMGxgTx5PWxQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] WIP - Allow custom printf function for column printing
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2017 at 8:22 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 29, 2017 at 06:42:38PM -0700, Stefan Beller wrote:
>
>> Ever wondered why column.ui applies the untracked files in git-status,
>> but not for the help text comment in git-commit? Nobody wrote the code!
>>
>> This is marked as WIP, as it barely demonstrates how the code may look
>> like. No tests, no documentation.
>
> I'm confused about what this patch is trying to do. Is it just to turn
> on column.status support for the template shown by git-commit? Or is it
> columnizing more than the untracked files list?

It is just columnizing the untracked files list.

>
> If the former, why isn't just setting s.colopts enough? I guess because
> we write into a strbuf?

Yes, because it is a strbuf, and not stdout. the column code could only write
to stdout (which was solved in prior patches), but we still have to provide a
"printf like" function, which is the majority of this patch.

The remaining part of the patch, which could go into a separate patch
is the removal of:
-       s.colopts = 0;

> If the latter, then isn't that a separate logical patch from "should
> commit use columns"?

yes, I was too quick there.


> I don't have an opinion on the whole thing myself, as I do not use
> columns nor really know how they are supposed to work. You found my
> 4d2292e9a9, but I was explicitly trying _not_ to get involved in any
> behavior changes there due to my cluelessness. :)

eh, ok. I thought you had deeper reasons than that.
I did not use columns either, but now it looks like I am
a new user of that feature. If only Git would users easily
discover cool features. ;)

>
> I think Duy, who wrote all of the column code, is a better person to cc.
>
> -Peff
