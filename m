Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129A0C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 22:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiJNWdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 18:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJNWdx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 18:33:53 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903581CA5B4
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 15:33:51 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 81so7199906ybf.7
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 15:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y11c9F/N4tC2K5B1zw3YlN5Irq+KkdKgsgVx58POVyM=;
        b=o/MurtDe7vMIS46XU+LUwZCx/1e/wEMbDhoDKxPWCIXKfW2vHml36CiwAsViGXy2qp
         snzpbWv9eJrcu5+IBalD/N/LmwnpKV9cHNOXcX60pY6SN8dmjymMoOnd1ABV/FIiq9Qz
         /qX/IL6geTOYNRQJ6dNG9LsH5VIYd4J05sTUjNiICx4Ozi3mTIGDGUAjOpf3HJE4ezF0
         QJ9UlU12ECt5KrKpAVA1amMlH7LweDz24fg+JqCk8guL/Wvu8Q5vjPORW2pqDbvXFaCR
         uJvYrXkq6xsdB/LbwUSig6sLTJ6HUKFTX2DKYc/G0xiZJo+VaIiEGDIQ8dmNgY1gizhp
         pfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y11c9F/N4tC2K5B1zw3YlN5Irq+KkdKgsgVx58POVyM=;
        b=VQByshLVIAkiR7/IbFrWOW7NdkoO/Vcv+jLYM7abmKGOwtORA6sTMgdl8RZnd1IKgM
         2Ujr9W7MegbcFLH/VO7/2Pj1W5ms/RT1TnJAOtYp7sX+hHW7gwtD7AwoqGArYWD9BwJA
         IC9MRMPnYYLXydfNHODKI+1P6qgAHtBa5iczwzoLLR0ZM77xbzJNTiOyZ8bqbscLVPkd
         SMfCijN7+jpfB8r/kc4ab76GjolfAZgZzFX7H1/a9YjEryoSKGQRhhpEggmFZgNtD7kI
         59HEHKXKl0ioqoTrO5k+0WFPWzzne13mv/OmNug7fCiuZ/q2SOizz1Nt1Pd63o3t0fg6
         a7RQ==
X-Gm-Message-State: ACrzQf0HfqRzqu6eQqCHIDltvYrYiWUrfNg2BwnSnhUfr0BmMGMX075M
        HLAoBmgtDEA3J78UHRa/A7u8YHn5YIJX3+CKe5aDqQjUf3qoTw==
X-Google-Smtp-Source: AMsMyM7oJDagV+6lerVHB6k/3Dr4k8SUOegs366wcv6y6EJPMFJ1r2+SH2JT6McdCaVRkUbF8iMYlxr5DZLfzza8bKA=
X-Received: by 2002:a25:9983:0:b0:6bc:71fb:75fe with SMTP id
 p3-20020a259983000000b006bc71fb75femr6548000ybo.393.1665786830706; Fri, 14
 Oct 2022 15:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
 <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com> <2164212892712930cb34223499bb3e03bf2c2392.1665737804.git.gitgitgadget@gmail.com>
 <xmqqa65y9vm0.fsf@gitster.g>
In-Reply-To: <xmqqa65y9vm0.fsf@gitster.g>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Fri, 14 Oct 2022 15:33:40 -0700
Message-ID: <CAMKO5CtKorXv+SO821V6s4COp4MZxHbNCCY_-MR=YUjC_vgH4g@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] builtin: patch-id: fix patch-id with binary diffs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jerry Zhang via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2022 at 10:13 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Jerry Zhang <Jerry@skydio.com>
> >
> > "git patch-id" currently doesn't produce correct output if the
> > incoming diff has any binary files. Add logic to
> > get_one_patchid to handle the different possible styles of binary
> > diff. This attempts to keep resulting patch-ids identical to what
> > would be produced by the counterpart logic in diff.c, that is it
> > produces the id by hashing the a and b oids in succession.
>
> It is sad that we have two separate implementations in the first
> place.  Do you see if it is feasible to unify the implementation
> by reusing one from the other (answering this is not a requirement
> for this patch to be looked at)?
Yeah I wondered this myself, it's tricky because they are actually doing
opposite things: the diff.c logic is adding diff metadata before doing the
patch-id, while the patch-id logic is parsing out the diff metadata. We could
refactor it, but would have to be careful not to accidentally change the output
semantics.

Another possible path to "unifying" the logic would be to add a
"--patch-id" mode
to "git diff' that produces the patch-id of what would be the diff,
rather than the diff
itself. For the usecases that involve piping "git diff" into "git
patch-id", this would
require not needing the separate patch-id tool at all. Of course
people also like
to run "patch-id" on the output of "format-patch" after the fact so
this isn't a perfect
solution either.

Speaking of which, do you have some context as to why we promise that
"git patch-id"
output will remain the same across git versions? Were there cases in
the past where
people actually made persistent databases of patch-ids, or complained
about the output
changing? I ask because this requirement makes it difficult to make
big changes, and
there aren't any tests to verify consistent output between git
versions. Also git itself
is already a persistent database of patches, so I'm not sure why
someone would choose
to implement a new system for this.
>
