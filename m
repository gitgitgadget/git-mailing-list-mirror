Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8386FC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 17:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60946610A3
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 17:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhIHRwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 13:52:49 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:42615 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhIHRwr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 13:52:47 -0400
Received: by mail-ej1-f51.google.com with SMTP id mf2so5827524ejb.9
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 10:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z2WLE1YkYqLvm77hm6j775rUlR3qy09dssfzqtn7pLM=;
        b=TWy6UnEtkH7DpNJcOHou7eZ4+ZljVxd6opeRo3UkfcNenl25A8tS0yLgAe2cRQjFdU
         +747zC7rrZaZ22/8dq9L3iROitAEte5xHh37TBq+1aGXtpH0fRCfzuj+g+yVPCzAySS1
         SdqmB4Ru5zQ42VQSc4rHqADzMyKnTVs7EcKug4o6M8wZBrV05ZuWsFB9DOFGwtp5Az9x
         srHaXTUyYSvpY2KaKS0vDb2fQCYJaM0wTl2I8N+25D3z0p1qwyCoWW1JeLtW7IjXJit/
         hBb9gsom6RET9pU0NCly4Ubh7mXy4oi6tzjmSfFEJHqO1DoK6/sVYHsVzTuFE16dJTAM
         M8TQ==
X-Gm-Message-State: AOAM532dCfLEh42pO15n7IfU+Vndd7muV7YpX+gUMacioRLM7mtUTdRh
        oe/CIqr7LdrBqByRWc8XWSUNXLeGOwqCNsgVJF9QhKll
X-Google-Smtp-Source: ABdhPJzTLNVmYf88PLSZ+uYAOsV+3SoLwUWLVr5zDYvpC3KwKoygseRGLEDbGzYzEPFBpk69UeB5fu/gb7chnWBz1K4=
X-Received: by 2002:a17:906:1484:: with SMTP id x4mr1177803ejc.72.1631123498461;
 Wed, 08 Sep 2021 10:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com> <53cde4825b408e5fb893bbd9a222e7387d69a408.1631108472.git.gitgitgadget@gmail.com>
In-Reply-To: <53cde4825b408e5fb893bbd9a222e7387d69a408.1631108472.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 8 Sep 2021 13:51:27 -0400
Message-ID: <CAPig+cRL-EOZJVEDefdUgP3-DjrBnXVSiMc2EzimYOoECm5bfw@mail.gmail.com>
Subject: Re: [PATCH 1/5] sequencer.c: factor out a function
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 8, 2021 at 9:41 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> This code is heavily indented and obscures the high level logic within
> the loop. Lets move it to its own function before modifying it in the
> next commit.

s/Lets/Let's/ ... or just drop "Let's" altogether and start with "Move".
