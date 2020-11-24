Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE82C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 02:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3782071E
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 02:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgKXC70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 21:59:26 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42222 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgKXC70 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 21:59:26 -0500
Received: by mail-ed1-f65.google.com with SMTP id v22so19282637edt.9
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 18:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bukSrmeQf7f0PcJDTLRV/Zc6S11atcs8F8e5GZqqKVc=;
        b=KCl4XR3WrjxGYi9hl6EzdeZcCePG7E+txvw+xbEClVFlDMhwV72/0w3cSUn7FQ8l0Q
         DTv6kJrH2qS69PjAPa6tiEv07bViVCgX7YUJJIKTlIa9TzkhP4o/VgOpILE6BowD/mDP
         gWwVUr+U0IfBdjxwwS/VxTIvErO44/BkKwtrDJHZUW/jAvP30K5edHk0NP2CRy3LUF9x
         Edi3VO8RinjmluTuRm4n7hjdfb821TIikq8zHod8nShfTLuQ46BtP17BPK8qrgqJt6kN
         iyqobIdVOpkiSWlWI0L0Fdi1kJCpVHZGOZ2ryBa+Iw76DSYf92x/tefIYNVNw/z9AIlS
         MuqQ==
X-Gm-Message-State: AOAM533x4Gbkhl6VCR+lLZjDklbDaG+7Ogjdo7KjLUcc/ZeJda7HoVzg
        frMofFcA7QeCI1g2zD5NeGdkXoMn9MIgfbXSOJs=
X-Google-Smtp-Source: ABdhPJzwo/Vh9ybR1qLx5AP8dqFaSL770/SJKeTEhc+iNSszqY2j/0ddvOPEPmhDGcDCJtITdDmjgtMvYRGFxElvjLI=
X-Received: by 2002:a05:6402:1358:: with SMTP id y24mr1973112edw.291.1606186765197;
 Mon, 23 Nov 2020 18:59:25 -0800 (PST)
MIME-Version: 1.0
References: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
 <pull.776.v4.git.1605647598.gitgitgadget@gmail.com> <X7ReZXuwAaAZzMSU@flurp.local>
 <80762efd-c71b-4485-a2bb-f0577d90ff48@gmail.com>
In-Reply-To: <80762efd-c71b-4485-a2bb-f0577d90ff48@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 23 Nov 2020 21:59:14 -0500
Message-ID: <CAPig+cQA35f1RfrvoevTJPeAbxDtoXqdM-N8D_=hw7_ZaNYCAA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Maintenance IV: Platform-specific background maintenance
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 9:20 PM Derrick Stolee <stolee@gmail.com> wrote:
> I was giving your 'test-tool getuid' idea a try, and found that _also_
> the $HOME environment variable differs from the format we expect in these
> subcommands:
>
>                    $HOME: C:\...
>   argument in subcommand: /c/...

Where does this problem crop up exactly? Is the test doing a literal
comparison against the value in $HOME?

> So, there is another reason why these tests don't work on Windows. I'm
> of the opinion that maybe it's not worth _that_ level of cross-platform
> testing.
>
> Unless I'm missing something simple about a $HOME alternative here, this
> seems to be more work than the resulting value. Personally, I'm happy
> with the benefit you've already provided in allowing Linux to test all
> platforms.

Indeed, it's not worth investing a lot of additional time into it. And
it's certainly not a good reason to hold up the series. Moreover, this
is the sort of thing which can be refined/handled later if someone
wants to take a shot at it.
