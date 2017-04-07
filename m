Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A20820966
	for <e@80x24.org>; Fri,  7 Apr 2017 19:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933744AbdDGT1X (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 15:27:23 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33790 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754895AbdDGT1V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 15:27:21 -0400
Received: by mail-pg0-f48.google.com with SMTP id x125so75044755pgb.0
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6da+5/A5Hy9BGJUN5qGF5yZVs/+P+04AA3dOMW6Hgfc=;
        b=d5ha+zGtGfh20KZsOKoM8rRPSlPw789qZsYd08RIW1s64JUYsm9RyszuDlx45EboNA
         e/OXe0rYGocUNCS6BLDIj6S8NJ/zJnexFtKSEsu8hk008/Tq3d1Zt7RWbb71pVuxOeBv
         91CXqnDJwQJogQ+UJq8N3EKDashoVdEW/M9qiume/9dMPIxzeREMjgCfkRrrLa9/fgHb
         q3Wm3HEW5CWLBjnBiWHwqc3job2f0CAjzkSOviW2qEFmDen9FSVBcA5AZKZxFM7Bek4s
         eBkSh4/O1PEKEgoySFP6PXoqdTIh9vMUerLpGsczM7+mIYneG/H3NahPKtkGRFUhD2zh
         nDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6da+5/A5Hy9BGJUN5qGF5yZVs/+P+04AA3dOMW6Hgfc=;
        b=GA3uaGNkR85uWqoQmPiOeafWFGuvGgAuWPYxIevYsaUR2o09uJrEPt3/sOezbvNXKd
         L5JZma7G6y++sDroAg+bvs2sGap07LOJDmITXK23fAgyMV1VcehNnIx5Rwe0VMRNyb24
         THBCWYQb/DX/XOO2CHv4eMsiiqQh+/ZJlsZn7WnSrPIPu7TOP+vVU7cjje0Mtb4y7YcM
         sKEDkiqZnTEXrtmq7ozSmtfRr0uslz+emhgMYPesizhBbEW5BATv6LN6+WOTsnfjrrXJ
         +dLaqkXqUq3Av4UhQscnNQFwgKMYAIlALRp/ZPh3s6XAzrEBVPEKmacIfZwH8yfvVEkj
         p4rQ==
X-Gm-Message-State: AFeK/H31YgwNGpe+dSlK8DnaJewuN7gNyOZavx27nHFG3KQxarSjgfn8sg0aA1hL6bQfTd7PCnaMiyg+o6/HXPCJ
X-Received: by 10.98.193.69 with SMTP id i66mr41962762pfg.35.1491593240657;
 Fri, 07 Apr 2017 12:27:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Fri, 7 Apr 2017 12:27:20 -0700 (PDT)
In-Reply-To: <CAGZ79kZg+QpQ73i2=boGTDAhdtfkrbA8ijNEf2pmanNhiiLwmA@mail.gmail.com>
References: <20170407192357.948-1-kewillf@microsoft.com> <CAGZ79kZg+QpQ73i2=boGTDAhdtfkrbA8ijNEf2pmanNhiiLwmA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 7 Apr 2017 12:27:20 -0700
Message-ID: <CAGZ79kYKVwCLjvo0_qpwHvnd0XVzKM0DL-xPsMKqh8=Y01=ROw@mail.gmail.com>
Subject: Re: [PATCH 0/3] fix working directory file issues while using sparse-checkout
To:     Kevin Willford <kcwillford@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Kevin Willford <kewillf@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This time for real.

On Fri, Apr 7, 2017 at 12:27 PM, Stefan Beller <sbeller@google.com> wrote:
> + Duy, for sparse checkout
>
> On Fri, Apr 7, 2017 at 12:23 PM, Kevin Willford <kcwillford@gmail.com> wrote:
>> While using the sparse-checkout feature there are scenarios where
>> the working directory should and should not be updated.  This patch
>> series addresses issues found in reset, apply, and merge conflicts.
>>
>> Kevin Willford (3):
>>   merge-recursive.c: conflict using sparse should update file
>>   apply.c: do not checkout file when skip-worktree bit set
>>   reset.c: update files when using sparse to avoid data loss.
>>
>>  apply.c                          | 18 +++++++++++++
>>  builtin/reset.c                  | 34 +++++++++++++++++++++++
>>  merge-recursive.c                |  8 ++++++
>>  t/t7114-reset-sparse-checkout.sh | 58 ++++++++++++++++++++++++++++++++++++++++
>>  t/t7614-merge-sparse-checkout.sh | 27 +++++++++++++++++++
>>  5 files changed, 145 insertions(+)
>>  create mode 100755 t/t7114-reset-sparse-checkout.sh
>>  create mode 100755 t/t7614-merge-sparse-checkout.sh
>>
>> --
>> 2.12.2.windows.2.1.g7df5db8d31
>>
