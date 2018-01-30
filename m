Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADE9E1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753152AbeA3Vr4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:47:56 -0500
Received: from mail-yw0-f180.google.com ([209.85.161.180]:43959 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752329AbeA3Vrz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:47:55 -0500
Received: by mail-yw0-f180.google.com with SMTP id x190so5935158ywd.10
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mOVnvxE63ICIRo1mXjUj4qhdURg2aSAEEUYvoiyIYTE=;
        b=RCk5msFLFNdEKVMgttZcaQRqeje8F4GjRqT0FYLZIQ8YZlJgIxa70t1+pONNcBlbz7
         FsTE0U+GlhgvB9vZ6l69r0pDz/9qP76LJ9S38L6bjbbi7gPyYKYJcmioYctaDRtOfPSS
         vJu/nzFrr/mVGp0Xz6Yc4Xir33hkzOQwFvU6wyQgiCGGOHbcNnxCVoKt95TVFHERs5lR
         dUCXkTL17upZ7PIDCkOy5KmPWibqe76DFlrF8MLJKowYEAsvsvSJIGIlJgDFWplBatq8
         DnikssxusNEMh0LQDTqKr5IGdsQUXotUUIogsp9CHbwwsrlpLG1jl91ebUtkYTc1+EjT
         mbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mOVnvxE63ICIRo1mXjUj4qhdURg2aSAEEUYvoiyIYTE=;
        b=lYJr84v1bhBF2hA65zN1CAH1OTtvUrk4FOeKSX4AmpMl6yUBGJjstSWKoyZKcvKfqe
         Umi8AIrMvnkrL5OR6eYgSFRNoDXQGHloPoj646rPsN0ndAi2hzSG7dSxK9/WL19raCIi
         oap/jCBovC9Ck9gsmkI3jCMCxsmj7A9VJmFPKq28wv7676ltOsGWh7QdfijfAJGE5Kva
         UBKNIBqi1YBqj5BpzH5hKaUPyM5rtfw0WIazp+SOVobWaTEJZbxGBzi8Pn+rIIR07Juh
         dBb4boix/rHopf6Vci0+9vPsHlugUjcbz/543zRwNQR6bGevIuiCZ+sq7DWgsPACf1lp
         28ig==
X-Gm-Message-State: AKwxytc/84+29dRzai1ZHwz/T6b22obPqaWKeD1Bwj5IgOT7pCG/TvQG
        JCHvU8ZoVy4ofQKJ7+/fJ/nA4bwa059iMFQyTUnQxQ==
X-Google-Smtp-Source: AH8x225SjWTY0fBhcgjxARi96d06VMaEpFc9ca+nk3gx9KuC9IucKvQg0TLdCdO9im62V2uKGsfaw/CGBwE+2HWKVoo=
X-Received: by 10.129.108.196 with SMTP id h187mr20938419ywc.249.1517348874565;
 Tue, 30 Jan 2018 13:47:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 30 Jan 2018 13:47:54 -0800 (PST)
In-Reply-To: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 Jan 2018 13:47:54 -0800
Message-ID: <CAGZ79karMKMTAFZma8WiThacyWp7FqYPd6NNZ93s4xa48SnOyA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Serialized Git Commit Graph
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 1:39 PM, Derrick Stolee <stolee@gmail.com> wrote:
> Thanks to everyone who gave comments on v1. I tried my best to respond to
> all of the feedback, but may have missed some while I was doing several
> renames, including:
>
> * builtin/graph.c -> builtin/commit-graph.c
> * packed-graph.[c|h] -> commit-graph.[c|h]
> * t/t5319-graph.sh -> t/t5318-commit-graph.sh
>
> Because of these renames (and several type/function renames) the diff
> is too large to conveniently share here.
>
> Some issues that came up and are addressed:
>
> * Use <hash> instead of <oid> when referring to the graph-<hash>.graph
>   filenames and the contents of graph-head.
> * 32-bit timestamps will not cause undefined behavior.
> * timestamp_t is unsigned, so they are never negative.
> * The config setting "core.commitgraph" now only controls consuming the
>   graph during normal operations and will not block the commit-graph
>   plumbing command.
> * The --stdin-commits is better about sanitizing the input for strings
>   that do not parse to OIDs or are OIDs for non-commit objects.
>
> One unresolved comment that I would like consensus on is the use of
> globals to store the config setting and the graph state. I'm currently
> using the pattern from packed_git instead of putting these values in
> the_repository. However, we want to eventually remove globals like
> packed_git. Should I deviate from the pattern _now_ in order to keep
> the problem from growing, or should I keep to the known pattern?

I have a series doing the conversion in
https://github.com/stefanbeller/git/tree/object-store
that is based on 2.16.

While the commits are structured for easy review (to not miss any of
the globals that that series is based upon), I did not come up with a
good strategy how to take care of series in flight that add more globals.

So I think for now you'd want to keep it as global vars, such that
it is consistent with the code base and then we'll figure out how to
do the conversion one step at a time.

Please do not feel stopped or hindered by my slow pace of working
through that series, maybe I'll have to come up with another approach
that is better for upstream (rebasing that series is a pain, as upstream
moves rather quickly. Maybe I'll have to send that series in smaller chunks).

> Finally, I tried to clean up my incorrect style as I was recreating
> these commits. Feel free to be merciless in style feedback now that the
> architecture is more stable.

ok, will do.

Thanks,
Stefan
