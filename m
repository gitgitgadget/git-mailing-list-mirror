Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 975541FAE2
	for <e@80x24.org>; Tue, 27 Feb 2018 18:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbeB0Suf (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 13:50:35 -0500
Received: from mail-yw0-f174.google.com ([209.85.161.174]:41939 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeB0Sue (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 13:50:34 -0500
Received: by mail-yw0-f174.google.com with SMTP id w12so6656981ywa.8
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 10:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jwpqgW1Dstajye2RtdIam7L3VBZOS79rusdlW6e2x+U=;
        b=GCoahONk+yVLp7Zj5bHC/RqJVJgadmPGK9S7rhCOYDQbdiXn6GTNeBR44qgpX9Y9La
         r793b3uF41aEB181HiRKSSe+7CWYAVXz7hSJrW51Omo6ZMEXDuVlEYINiPywdbDLZEgF
         UG1bCXgwArWQAaE+K+/hU+aJwBHxvhkmMrwlvaSgaqzwCMGrA1SFJ8yoEPsZX0Hjq/5E
         bowaEUX44/je54CQ+HMFhav7lZZgudPFLh+7FVHx57F3NpM0qFPSY49Krm7S+9j8+2k4
         7q6vqk2oQj0KyhvE20jdVQ3oOJL8xxRBMQ92rMJCBSGkcIZDDcJlDgGUBwZg67GRjsv+
         MyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jwpqgW1Dstajye2RtdIam7L3VBZOS79rusdlW6e2x+U=;
        b=HNdKXUk9nHAlgV1BRbzERQJuA4Ie2YxEKthPWbiEyTPVJ8iU53a7qOiReER4AMU1jB
         a79YdAVToB090h7NyGqMsUR1ovQoXGy9Y3KCn1G4XWUo0ykjnorqlefjkV2mlI/IOYtm
         OnXLTZPjHhspcWD8B3IT3jF/Lv4JfwEM9oxViEiJ2/v6GnQCh2rQRYT9x8a/piJOYUPP
         1YKTlwgc2iP41eJZsmjGuyEInl4wBmL+ZZ+k3mc3lUHaFWpJvzhki0Ulyf+1RjNbys1Q
         125d8/3jAOZe7aov/gz71XyHTQqtsOCpdmfWTzO2Q051jD6ZmgoWNQjZ1SrjdMtD7KiU
         V8YA==
X-Gm-Message-State: APf1xPC5idL5sJ8sc1kX21zw7qrgygcRk0pJgBe2Vi2oHfnIdN6oXF99
        xOaoas8NkZje9oo9nCx96oY3wBJJuYS8N8IQor/5mM97z+U=
X-Google-Smtp-Source: AH8x226HitiQjlV4jD5LDX34PWn4pSisIw1qHrKN+81ywNOXWFc3mM+79Sks9IxP7auk8x6HvfwoP6c2Ao/rdJiNO0I=
X-Received: by 10.129.182.2 with SMTP id u2mr10150655ywh.345.1519757433610;
 Tue, 27 Feb 2018 10:50:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Tue, 27 Feb 2018 10:50:32
 -0800 (PST)
In-Reply-To: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Feb 2018 10:50:32 -0800
Message-ID: <CAGZ79kYKM0f7Sr-7_To57eLEW50ryXQdCbjYFw89_XW6xb-Law@mail.gmail.com>
Subject: Re: [PATCH v5 00/13] Serialized Git Commit Graph
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 6:32 PM, Derrick Stolee <stolee@gmail.com> wrote:
> This patch series is another big difference from version 4, but I do
> think we are converging on a stable design.
>
> This series depends on a few things in flight:
>
> * jt/binsearch-with-fanout for bsearch_graph()
>
> * 'master' includes the sha1file -> hashfile rename in (98a3beab).
>
> * [PATCH] commit: drop uses of get_cached_commit_buffer(). [1] I
>   couldn't find a ds/* branch for this one, but it is necessary or
>   else the commit graph test script should fail.

'jk/cached-commit-buffer', 'jk' as the first commit in that series
is by Jeff King ?

I found this commit by searching for its verbatim title in
'git log --oneline origin/pu' and then using
https://github.com/mhagger/git-when-merged
to find 51ff16f5f3a (Merge branch 'jk/cached-commit-buffer'
into jch, 2018-02-23)

>
> Here are some of the inter-patch changes:
>
> * The single commit graph file is stored in the fixed filename
>   .git/objects/info/commit-graph
>
> * Because of this change, I struggled with the right way to pair the
>   lockfile API with the hashfile API. Perhaps they were not meant to
>   interact like this. I include a new patch step that adds a flag for
>   hashclose() to keep the file descriptor open so commit_lock_file()
>   can succeed. Please let me know if this is the wrong approach.

This sounds like an interesting thing to review.

>
> * A side-benefit of this change is that the "--set-latest" and
>   "--delete-expired" arguments are no longer useful.
>
> * I re-ran the performance tests since I rebased onto master. I had
>   moved my "master" branch on my copy of Linux from another perf test,
>   which changed the data shape a bit.
>
> * There was some confusion between v3 and v4 about whether commits in
>   an existing commit-graph file are automatically added to the new
>   file during a write. I think I cleared up all of the documentation
>   that referenced this to the new behavior: we only include commits
>   reachable from the starting commits (depending on --stdin-commits,
>   --stdin-packs, or neither) unless the new "--additive" argument
>   is specified.
>

Thanks,
Stefan
