Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 294A4208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 19:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755197AbdHYTP1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 15:15:27 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:32935 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754535AbdHYTP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 15:15:26 -0400
Received: by mail-yw0-f172.google.com with SMTP id s143so4085422ywg.0
        for <git@vger.kernel.org>; Fri, 25 Aug 2017 12:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=orEBxNTginVIjJTnMYWcwvQwR7rwCOugbPjfesz3WZg=;
        b=ixSulL1qpoB56wHlthO9JLOlrAUCUZPtp5hAJ2B1rdus+2NwqTv3G30jJCg3iSN3qA
         va9ox6eMdDJQ6r5reP+wRjenT7l6R/t/djuA83tMxtGpQkKSyD65bY9JoewFCrS7y1UG
         Vk9li38ZR7daOKRvaks19CA6awAbWnx33ml0VQjWl676dYpHk6aJogSxRDIl1AC/8sc2
         DT1Ve9F7nUuZFWGJFf6KQRVLmQd3N8IgFYez8I8l6woKDfBtzvQx/zs0wa3Vi+KBrtIl
         iarQxcnIMfDxr+Pwwv1hUfzcQGFRKBd7Khvq/8qMsg+nJECpjajEmlnxuS5kj7JuZyMK
         IBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=orEBxNTginVIjJTnMYWcwvQwR7rwCOugbPjfesz3WZg=;
        b=ojoJZH0RJAk4IyvVnamK/g9XfIg9zBSir2hOJvX3y/valObEdHETjUwajmZyUzkfPi
         ctOVakwySURitwvHHPQkWoYPF+omNNNwTBpkdremVtFoIltDWQKgeg15Juv5yUvLzwma
         tMFN0fwW9y/tEHQ3fALw6Rsm+f8oqj8+WE+zGD0JdC7SpEtPPt5D99bMWBWhb2twh5XJ
         qUI+XmW13A/STOtB/EaKOrP5a8TS3lypsh25zPAWJ74NPKIZkZBbzAFaA8UtOpUfJN+7
         S86yg+kYFhHDMd29ta2aXHKvwb5pBEV5X4P0YvtjACLJAAih+SM+VGirtt+YxDTI0kqP
         2q1Q==
X-Gm-Message-State: AHYfb5ie+3F9WT5t8yyAY7vWw5ZNUfegK4BY/jHG+lck/GcSDbx7e6Nw
        QI+gPdP0gjcVIIcl7GYXojd1lJ3ahpj0
X-Google-Smtp-Source: ADKCNb7xin8XyCBfiAb5lusNIoBSudkzp9fksX9gcqhi2ZiWz9oVkWG+q3u58mTUzxDFxneBZCQNRYIcNausihSjFiU=
X-Received: by 10.37.47.84 with SMTP id v81mr726883ybv.145.1503688525210; Fri,
 25 Aug 2017 12:15:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.248.26 with HTTP; Fri, 25 Aug 2017 12:15:24 -0700 (PDT)
In-Reply-To: <xmqqlgm7scpm.fsf@gitster.mtv.corp.google.com>
References: <xmqq7exuysc7.fsf@gitster.mtv.corp.google.com> <20170824195051.30900-1-pc44800@gmail.com>
 <xmqqlgm7scpm.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 25 Aug 2017 12:15:24 -0700
Message-ID: <CAGZ79kZwpu9YXr5gSXWQBmqhXFB7+2rFWh6zVtRoiyQORkUsdg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3 0/4] Incremental rewrite of git-submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 25, 2017 at 11:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks.  I'll try to queue these before I'll go offline.
>
> Mentors may want to help the student further in adjusting the patch
> series to the more recent codebase; unfortunately the area the GSoC
> project touches is a bit fluid these days.  I resolved the conflicts
> with nd/pune-in-worktree and bw/submodule-config-cleanup topics so
> that the result would compile, but I am not sure if the resolution
> is correct (e.g. there may be a new leak I introduced while doing
> so).
>
> Thanks.

Ok, noted.

Presumably I'll review your dirty merge then for this series?
(And later parts might go on top of the new dirty merge)
