Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC93C433DB
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ABBD64E0B
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbhA3JIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 04:08:25 -0500
Received: from mail-ej1-f44.google.com ([209.85.218.44]:35091 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbhA3JIB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 04:08:01 -0500
Received: by mail-ej1-f44.google.com with SMTP id ox12so16543498ejb.2
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 01:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gmv8tz8Gy/Z0enx6FGr5M5zboKu9u4ALwOvXRlq0tkI=;
        b=QAemIR4+JzcgRXntF3GYcZ8BSXkaSVOarwI/YIOoyxuiNUPUzZW9Trl6fnPMSLMM7i
         R3ugZn7KYBH5G9yk1c1UTZ3mW9MBLDdZE0cN7W0mc/m+WTuGyl99pjlMoJW7I6mhbThp
         d3PNioYFRa3z8Hie+j4puENFEBFaBLO7ecOTOZ0HJ0HXmALZQGzHdOrKgGvzO/WF+3DP
         u00+8iI4h17yQM05J1CEMG1ZUag1ooS5cyUf453pV+RSVf/hnob8cldhqFx5mX5tY5qj
         eb8OOtrwwwTDAXqzsZ2/PuKMyQNzV6KnmHgY+/+WeNcBWtFqtUlJOVXBb+ffvSzjv+6X
         DS1Q==
X-Gm-Message-State: AOAM533vexHS1vPgM/9HxNR3j3IdmgC0W2Ls7rUR0MXM866ABpcfRCH2
        z3KkkmsP0x0WQEQ03osYMkrS2ohuWT9XvzYiWyZcbCjySEPLPA==
X-Google-Smtp-Source: ABdhPJwsDYEfUZJEGEtF12FtiBpqCRSipgLp45fxt3E1TpQq1ELEV4030+3HtBa/au9Raj89g9OiNx9gyTQf11oBhkA=
X-Received: by 2002:a17:906:4159:: with SMTP id l25mr7627917ejk.311.1611990301866;
 Fri, 29 Jan 2021 23:05:01 -0800 (PST)
MIME-Version: 1.0
References: <20210119212739.77882-1-rafaeloliveira.cs@gmail.com> <20210127080310.89639-1-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20210127080310.89639-1-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 30 Jan 2021 02:04:50 -0500
Message-ID: <CAPig+cTt-TyOR8kc6YvBVLpf-bgFdJ+FVYA2NvG_Vvn7tMbBkQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] teach `worktree list` verbose mode and prunable annotations
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 27, 2021 at 3:03 AM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> Changes in v4
>  * Added documentation to explain that the lock reason is quoted with
>    the same rules as described for `core.quotePath`.
>  * The `worktree unlock` issued in the test cleanup is splitted and
>    executed after each `worktree lock` to ensure the unlock is only
>    done after we know each locked command was successful.
>  * Fix a couple of grammos in the [4/7] commit message.

I just gave v4 a complete read-through and it looks great. All review
comments on previous rounds have been addressed, and I didn't find
anything important to comment on in v4. Very nicely done.

Please consider this entire series:

    Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

Junio: Perhaps the summary of this series in the merge message can be
refined a bit, as it only talks about verbose mode, but this series
does a bit more than that. Heres a proposal:

    `git worktree list` now annotates worktrees as prunable, shows
    locked and prunable attributes in --porcelain mode, and gained
    a --verbose option.
