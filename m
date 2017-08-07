Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8615A2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 21:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbdHGVlk (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 17:41:40 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36291 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbdHGVlk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 17:41:40 -0400
Received: by mail-qk0-f181.google.com with SMTP id d136so10217594qkg.3
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 14:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neosmart.net; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Eu4Q/HFc0WERqdPR4BeDhEmtl5NbgEunRDlmL0DXYK8=;
        b=QRxmt5riCMpSxz1E28xrShlJWUy2Du6MuShsETYJgdX+lJB+wyWkDL3iZIX5FTWDut
         j7qibMhmZyhjlz0KwCjTpkQKJ6clgGVbwkHC5FRM9z9Ge1hcSkRoijlkHqN8SbNS2OdK
         Y/n5t99kmYWNtOcRiUJASRIhDHtMT6bG0R/ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Eu4Q/HFc0WERqdPR4BeDhEmtl5NbgEunRDlmL0DXYK8=;
        b=mv6u/ReA6Yl7eT5XsoNcq3vLUEOuvReYcALz3cwBACDzYiYlzmpVf3OnhpC+qoC/3k
         CXqzGm+s2VSeI/uAeQBJIzqxnIxa/1c8SCJT1qDpsCCurZH/LRXJVNSXuwlZyBltOaqk
         A5aO6JI1PkAKA8jm9ZVWG8RW2op2I/SbG/Gut7xacItEdfzOudP5Ga3EO1TuEQXwH3FF
         GobOvrWMfDZ3pVXEYJgmSJCGnsuY9utULByDjRht+FsKz/XkELbfUnqS57KUStV0NHpy
         zhNcpOLSObzqXngrqWer1lgpdVr+GHVDX0XNuvlZ0NXyUaXfkOdxObYcE7onI5VP7O6J
         V6oA==
X-Gm-Message-State: AHYfb5gQSs7nHhwA4m4x3NuMqgsVKMhsbMf+KVfGU44hAmqU8RBjSxWu
        CJ00CAkrh2vn0mi9wKX5204nQDpwfV1j
X-Received: by 10.55.160.135 with SMTP id j129mr2521491qke.341.1502142099090;
 Mon, 07 Aug 2017 14:41:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.35.85 with HTTP; Mon, 7 Aug 2017 14:41:18 -0700 (PDT)
In-Reply-To: <xmqqefujwqz0.fsf@gitster.mtv.corp.google.com>
References: <CACcTrKfPKdPCVONMcGRbisK_WOt70yLdjavZnLTMMVocrwzk1w@mail.gmail.com>
 <xmqqefujwqz0.fsf@gitster.mtv.corp.google.com>
From:   Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Date:   Mon, 7 Aug 2017 16:41:18 -0500
Message-ID: <CACcTrKewZRZpHotZ8GpO9zFifTdjkzP2th=KqkQqTvJb_k3W9w@mail.gmail.com>
Subject: Re: [suggestion] Include commit-ish in git status output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2017 at 4:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> HEAD is, unless you are about to create a root commit, always a
> commit and not other kind of commit-ish, so there is no need to say
> "or commit-ish" here.

I apologize for my errant terminology, I thought commitish was what
the abbreviated
SHA1 was called. My proposal was to show either the full SHA1 or the abbreviated
SHA1 in the output of `git status`.

> What would you do differently, after seeing this random-looking
> 40-character string, based on what it is?  Do you know recent commit
> object names by heart and can tell, immediately when you see 88ce3...,
> "ah, that was me fixing foo", as opposed to e140f7a... that is a
> different change you can immediately identify?

I obviously do not know recent commits by heart - the aim is to be
able to easily
copy & paste or visually compare against another value.

Aside from the practical implications of having the commit SHA
included in the output
of `git status`, I have also pointed out my ideological reasons for
it. `git status` currently
prints an incomplete picture of the local repository state, and
without an indication of
_which_ commit HEAD currently is, the remainder of the content
"expires" and is of no
use at some later date.

Looking back, I probably should have started with that. `git status`
gives the status of the
_relative_ current state of the local repository without printing any
information that can be
used as an _absolute_ reference to "frame" the results of the `git
status` command. The
relative state of a repository is useless for any sort of machine or
human analysis, since it
would require the state of both the cached remote and local indices to
be identical to be of
any use.

If I run `git status`, make, commit, and push some changes, then run
`git status` once more,
the output of the command can be identical to the previous run, _even
though the actual
state of the repo has changed_ which is... less than useful and
potentially misleading.

Yes, anyone familiar with git knows that the output of `git status` is
only showing you a summary
of the diff of the working tree vs HEAD. My argument is that all it
would take is another 8 characters
appending to the "On branch xxxx" line to make it an infinitely more
useful command.

Thank you,

Mahmoud Al-Qudsi
NeoSmart Technologies
