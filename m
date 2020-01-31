Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEDFC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8824A20CC7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJ0tajLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgAaUga (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:36:30 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43951 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgAaUga (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:36:30 -0500
Received: by mail-ot1-f66.google.com with SMTP id p8so7819073oth.10
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 12:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cTP03bknPPJBaW8gIsVFhPHq7h/2yhC2pBj0MPgtcIE=;
        b=pJ0tajLMIIrKD8mWolmOkAJazaJ5s3e0GnCHudkFgPPwUoslOTHlPXTxF8HQQV/geT
         z2Ph604AVCdLf/rivhH9MDST8+SXxb/uta28H/hdt0aQlmi/uXJeIxC7Y+MmUitzchQf
         ghsV3SLRhn13f7lPxsahENyQ1AJKr4/5EYBuzhbxssMsuWcBG9I5vtjDuvcWRK3ovZs+
         Trk1BAWtuIrumMCm/6aIC5uA8H3pfrw1B0ItXMiqu+OgV2AHMQltfR+J0dk8bNY5DQVl
         5aL3lnAexSLxHkpx7QsuZkrFcdrF4V/VRo/7iaHzdHzP8wB4+y90AnXly0aP+U68gV0Y
         3uGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTP03bknPPJBaW8gIsVFhPHq7h/2yhC2pBj0MPgtcIE=;
        b=qGmYYb38vB3UAAcosM5cbQ/o3OjJ41FLtbI5wlqHzEehd+Sv/1IqSKUZsLZgmjtnO5
         +8X7RvcG5HXt9ZDVDeKxrG7ZS6mBoNrlce87YPN8eNAs+XNv1gCvHA7i3mKqMV4gP/FH
         V28V8WHmWIlyNMaj4rfNAofs3hhiaNlGfk7HhC6TFFqp3C/vLCwy76PRXLjKUePmwSMq
         5d8B7A5DCC1DhLJstdggvBFhYb08vDWicx+4T0zTJ7roI2H1owTsjtGXErypi2PFUlne
         TFxU+nvV9ghaFdcdf6cMPI8HA1Er3s7RitLvQqkrcjInLfuyijF3eMtR75CLT4cyE43e
         CYHg==
X-Gm-Message-State: APjAAAUOL9KPtFadbYcjaydpdGtOQfn3qkup/NLwdMht8lgs3bL/QbkU
        Hdr/Z/KT9on6S/q6XfWokbL33uW6SI0emsmmYFI=
X-Google-Smtp-Source: APXvYqwIbOgva3FeCZeFdlibIQoGSlcZz+DVkMlewcmdJPRUsn2M/h8pfSx1aoe3CKIUSnRWVIFApuyAbaWC+MijZGc=
X-Received: by 2002:a9d:634e:: with SMTP id y14mr9302253otk.162.1580502989417;
 Fri, 31 Jan 2020 12:36:29 -0800 (PST)
MIME-Version: 1.0
References: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com> <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 31 Jan 2020 12:36:18 -0800
Message-ID: <CABPp-BHoEgYXgzxjweWDR2BZPhLdW9wcbWzwo6N+HF2kste3WA@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Harden the sparse-checkout builtin
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 12:16 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series is based on ds/sparse-list-in-cone-mode.
>
> This series attempts to clean up some rough edges in the sparse-checkout
> feature, especially around the cone mode.
>
> Unfortunately, after the v2.25.0 release, we noticed an issue with the "git
> clone --sparse" option when using a URL instead of a local path. This is
> fixed and properly tested here.
>
> Also, let's improve Git's response to these more complicated scenarios:
>
>  1. Running "git sparse-checkout init" in a worktree would complain because
>     the "info" dir doesn't exist.
>  2. Tracked paths that include "*" and "\" in their filenames.
>  3. If a user edits the sparse-checkout file to have non-cone pattern, such
>     as "**" anywhere or "*" in the wrong place, then we should respond
>     appropriately. That is: warn that the patterns are not cone-mode, then
>     revert to the old logic.
>
> Updates in V2:
>
>  * Added C-style quoting to the output of "git sparse-checkout list" in cone
>    mode.
>  * Improved documentation.
>  * Responded to most style feedback. Hopefully I didn't miss anything.
>  * I was lingering on this a little to see if I could also fix the issue
>    raised in [1], but I have not figured that one out, yet.
>
> Update in V3:
>
>  * Input now uses Peff's recommended pattern: unquote C-style strings over
>    stdin and otherwise do not un-escape input.

...and updates in V4 are?  (I looked over the range-diff which
definitely helps, but a summary would still be nice.)
