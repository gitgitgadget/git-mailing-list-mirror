Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 720821FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 17:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933606AbdCaRcR (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 13:32:17 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36689 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933389AbdCaRcO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 13:32:14 -0400
Received: by mail-lf0-f50.google.com with SMTP id x137so47731998lff.3
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 10:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qoYLm19TFBkLA6roVM9HrfTKivEFNWuiJ4X7FlEG4Sk=;
        b=XFUTn+CwU9yNR6qVEJjTG0gl2c+tVJ3zCNW2rbkK0RNJI9+wLgBo7m++9mrUd08cbl
         VK784wOoKcWVvcXxmK4LdCyRwnxKnl+7/jM2nW/vdH7cVJ5X7n4gGFUtPgvjifY+twEn
         mLwCOkKSEAMrQcb3Jfky3ub2DtKnv7c70XbOcY/atnpRCz78TGWu2uFZV8s1jalsJHyj
         zG52ILdSQKlADmny76fPhvxwxEpJhT5LbE7IOGSoiOf05ezNrp35c5MpYioe7E/IvPC2
         pZCk42KNBuNs/s5NXtp7ff9xeXuhRkbzCz1nGu6cgmoMUGru0uz8xL8n9j1C252nsDFE
         tVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qoYLm19TFBkLA6roVM9HrfTKivEFNWuiJ4X7FlEG4Sk=;
        b=sh2UAaq5u71YPoLq7yp5OyyYa4ExSLgQjgh31kowKNQAaqWXh5I9aD8W7S/82h7tnv
         vBJ9ol5H+EtZbTz28qjBnA/qbsAp3pnRNEcbfxDDA+KBUMwSG3tSwXHzPXvQYdl2m71i
         tP5qpFtplSOKLj1wPHEbZ0XxwLQug4lyLEG1bWlJya8fIvCS37gg7niaT7N+sKVmLe7O
         bszKEBw1GwMwTj6CgWr3enc6MTHi/RKPZz8ZRCw8xeeg8bNvM1EEK5aI2z4wl8Ta4O/3
         yTwG720olWLRcepdL/NATF/9Em8+O2I+SzA4rY+2uGrcMM4BXV6iaJGX/P/Zn3cC5JNE
         7V9w==
X-Gm-Message-State: AFeK/H21K9YHbsqDjXTPfInVg5sFq/fRZG6vzHDC0MQHxV3Cvy2tDMpUQczyY5XYboj6ZAZ8sl/fhYaki7qwiw==
X-Received: by 10.46.15.9 with SMTP id 9mr1557255ljp.108.1490981532307; Fri,
 31 Mar 2017 10:32:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Fri, 31 Mar 2017 10:31:51 -0700 (PDT)
In-Reply-To: <CAGZ79kapamr4=C_JQ4Ud2bF6NoXn8qeQR1fYScWB4+-EzEckmQ@mail.gmail.com>
References: <CAPd5SoV1F7MMDSRGzrd-7soty=61vnumQ02UtBJs2fwEyv+V3Q@mail.gmail.com>
 <CAGZ79kapamr4=C_JQ4Ud2bF6NoXn8qeQR1fYScWB4+-EzEckmQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 31 Mar 2017 10:31:51 -0700
Message-ID: <CA+P7+xoqWCpySc17104zggLgwx1mc0T+JXybrgd8sQxoQFP-PQ@mail.gmail.com>
Subject: Re: git diff --submodule=diff fails with submodules in a submodule
To:     Stefan Beller <sbeller@google.com>
Cc:     David Parrish <daveparrish@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 10:07 AM, Stefan Beller <sbeller@google.com> wrote:
> +cc Jacob, who implemented --submodule=diff
>
> On Fri, Mar 31, 2017 at 8:40 AM, David Parrish <daveparrish@gmail.com> wrote:
>> When I try to run `git diff --submodule=diff` in a submodule which has
>> it's own submodules that have changes I get the error: fatal: bad
>> object
>
> Thanks for the bug report!
>
>> Let me know if you need an example reproduce the issue.
>
> I could reproduce it when playing around locally with a submodule in
> submodules. I think sub-submodule needs to have its HEAD moved from
> the recorded commit.
>
> Thanks,
> Stefan

Hmm. An example reproduction would be helpful. Ideally in the form of
a test ;) But otherwise whatever helps. I will try to look at this,
but I'm  busy for a few days.

Thanks,
Jake
