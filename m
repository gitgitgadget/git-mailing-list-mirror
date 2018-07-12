Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 332731F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 16:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbeGLRGb (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 13:06:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35361 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeGLRGa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 13:06:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id a3-v6so13189056wrt.2
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 09:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dBfnJHQ3DqWRjyP24/j5jD8J1m0bdtv0qas0QiBDMkA=;
        b=HuSj7/a6PkuWZvBRYjRMYpB2M6f2dYAh+JPZfDwWGzV15c42XOV+6lyO/PnwbLBiid
         tp4WZFF2Qe+oHSc3ODg000nOdahJF+XOH6pNikT5ZWNU26H/i9eU3CsxoBSFHab5vf27
         IW81arc6i71a83XvEedsp7UphIRX0EOEyEZP2+ggUo2UA6iWDfHvWdFuYEBCUjVwzYdf
         jHEj/cEV0iRryMY9bcDyYx/QUuTLb4YwLLVWlAs8RMcbJL4RKJnqGUp3mjY3cMzGapeF
         Cr3Ew8bTeokPx7TjrM5lJYCWTS6xzDDHVSDQvurzfs+93H1mZ1OzWIR2+qPncVeGWGnq
         Myvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dBfnJHQ3DqWRjyP24/j5jD8J1m0bdtv0qas0QiBDMkA=;
        b=C/pu+9MXvM/Mmv/wi/jL7oIw+GnAlYkKMbHx/42tIYzE9J/cgbf27DzfaYNREeg+i/
         BGqXqWDHMJwvad6lcGueKeImvn9BmEculXdl8PqPL+kJseQ09x6Sb7pKyB0jegAQQHSm
         TQ28GFuvqbAVJbYfW9i8FWR8+EaIxDVTHy6qL/D/CNKvT2w9anxsn8V57CRpG8m9oQT7
         tt9SwmdazgSqtUGdByHePzG5qqpGkMI/TgHRT4zw6DS9C3a9NFZnK4WQaXVNXOqvrQY3
         sS2MqNO4uKzZ4NeL5Fk3Spblr3Ct+2vUdm91WK75C4/DaVRXpF3QfGl9w4YxVeEzqIAK
         xGMA==
X-Gm-Message-State: AOUpUlEtNW22OUuHYhgIJjuVEOXYu2d85FslBqIBjE59qnxWrW8ez9Yu
        XeEZgz5yCPXqcO8J7C6QeSw=
X-Google-Smtp-Source: AAOMgpeGcSoU8zRuU/6M+jZ+SaqaYtrI4tjNEbInqhvgYcwS/FnUoP5U2wh5stxJ6DVwW4gpNHt3OA==
X-Received: by 2002:adf:c321:: with SMTP id n30-v6mr2301636wrf.235.1531414566249;
        Thu, 12 Jul 2018 09:56:06 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a145-v6sm5816366wmd.39.2018.07.12.09.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 09:56:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Object store refactoring: commit graph
References: <cover.1529616356.git.jonathantanmy@google.com>
        <cover.1531348540.git.jonathantanmy@google.com>
Date:   Thu, 12 Jul 2018 09:56:05 -0700
In-Reply-To: <cover.1531348540.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 11 Jul 2018 15:42:36 -0700")
Message-ID: <xmqqd0vsz93u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> This is on _both_ ds/commit-graph-fsck and sb/object-store-lookup,
> following Stolee's suggestion.
>
> (It also seems better to build it this way to me, since both these
> branches are going into "next" according to the latest What's Cooking.)

OK.  I am perfectly OK if this left lookup_commit() with older
function signature and instead asked the integrator to fix up with
evil merge with sb/object-store-lookup, but given that this topic is
no more urgent than the other one, making them intertwined is fine.

Merging ds/commit-graph-fsck into sb/object-store-lookup already
requires an evil merge to build correctly due to this new parameter.
I really wish we did the more canonical "do not change signature of
a widely used function.  If the widely used one is a mere
specialization that calls the new one with the default parameter,
make that widely used one a thin wraper (or a macro) of the new one"
approach to avoid having to repeatedly create such pointless evil
merges X-<.


>  Makefile                   |   1 +
>  builtin/commit-graph.c     |   2 +
>  builtin/fsck.c             |   2 +-
>  cache.h                    |   1 -
>  commit-graph.c             | 108 +++++++++++++++++++++----------------
>  commit-graph.h             |  11 ++--
>  commit.c                   |   6 +--
>  config.c                   |   5 --
>  environment.c              |   1 -
>  object-store.h             |   6 +++
>  object.c                   |   5 ++
>  ref-filter.c               |   2 +-
>  t/helper/test-repository.c |  82 ++++++++++++++++++++++++++++
>  t/helper/test-tool.c       |   1 +
>  t/helper/test-tool.h       |   1 +
>  t/t5318-commit-graph.sh    |  35 ++++++++++++
>  16 files changed, 207 insertions(+), 62 deletions(-)
>  create mode 100644 t/helper/test-repository.c
