Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1995C1F404
	for <e@80x24.org>; Tue, 20 Feb 2018 21:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750781AbeBTVnF (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 16:43:05 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44964 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeBTVnE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 16:43:04 -0500
Received: by mail-wr0-f193.google.com with SMTP id v65so18487435wrc.11
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 13:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=95fM7+4ABPWlFfiHL8IREkJvShKyK+dBfB4ni4BXo2Q=;
        b=B3sukt+d4sK3yu4M9MrkyN/oxsM31esZ0BBkoLQPx/xwtH23+o2oLEgr3g4kTPj6tC
         Ly+LOo5CF/NQMHuLN+W7R1Eb5K2aaN+6aHoycXKjeMBydDQZ3tFu1aKY97s9JQmtA5KU
         7lsikPse/WBtuokyCdFhrnIy9oz0V66QXREmRWKNHwyj38yKSgytqN41ua1iUsFfLd9R
         eJ1QSwmN/LYB7idfpeeLCHBqcebhcRy843ZFuyJXE6arKGHwhafkGCfl7xSVAYq4/hA4
         8Bfpn7WYCDutu7BJt9T4Wx53sTathA2YLwWDOnh17pl1lgyw1zDOOYiVzycVZQ1Z1Lbm
         zKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=95fM7+4ABPWlFfiHL8IREkJvShKyK+dBfB4ni4BXo2Q=;
        b=RFhgWXd5iBKwIWk6YeMz3idb3kqtaXiI6MIvZJLCj86nx/vakOG1sMCVr1dABbiRdz
         OVP8bo9qoQeOoP1XZQGJlqkUtKQK8sn7fgZK6+Wf7Fa00cLFiFhWUvGHROBj/YsgwWQP
         6bOAgA9x/aZIAEctfo800pwl26Jzr5Nhc4X3tSMYyExTtQ/WtIkH1JDJTjeVUKVSsfFZ
         p60kuNMDf1ophVeuWV6X9G51z1RLERxU5lw1N4GhmQsf7NmP76hMO3Bi7sE7SvYwGAwF
         Ae/s/T7HLFQDPiVD998vBY6mVow9luUemqfFvbL68pOHETYlAizq5KvBfHIlG89bnXEK
         qo6g==
X-Gm-Message-State: APf1xPB2WqUVbqnZXbhvuixKMrI4LTecU/ho4pFJmYPZ32MRouQZ1CSA
        M5AHnjkVLbQvOQLbFFTXgBc=
X-Google-Smtp-Source: AH8x227ATCbLbxVpTJbtiDglFmLjzxeGeK/GfeNMpGHylZp0/1rfnbaI2dTPeNri70LYr0tCgpTN1g==
X-Received: by 10.223.132.103 with SMTP id 94mr932377wrf.115.1519162982173;
        Tue, 20 Feb 2018 13:43:02 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v63sm42846885wrc.69.2018.02.20.13.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 13:43:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 02/13] graph: add commit graph design document
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
        <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
        <1519066406-81663-3-git-send-email-dstolee@microsoft.com>
Date:   Tue, 20 Feb 2018 13:42:58 -0800
In-Reply-To: <1519066406-81663-3-git-send-email-dstolee@microsoft.com>
        (Derrick Stolee's message of "Mon, 19 Feb 2018 13:53:15 -0500")
Message-ID: <xmqq1shf2v8d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> +2. Walking the entire graph to avoid topological order mistakes.

You have at least one more mention of "topological order mistakes"
below, but we commonly refer to this issue and blame it for "clock
skew".  Using the word highlights that there is no "mistake" in topo
order algorithm and mistakes are in the commit timestamps.

> +In practice, we expect some commits to be created recently and not stored
> +in the commit graph. We can treat these commits as having "infinite"
> +generation number and walk until reaching commits with known generation
> +number.

Hmm, "pretend infinity" is an interesting approach---I need to think
about it a bit more if it is sufficient.

> +- .graph files are managed only by the 'commit-graph' builtin. These are not
> +  updated automatically during clone, fetch, repack, or creating new commits.

OK.  s/builtin/subcommand/; it does not make much difference if it
is a built-in or standalone command.

> +- There is no 'verify' subcommand for the 'commit-graph' builtin to verify
> +  the contents of the graph file agree with the contents in the ODB.

I am not entirely sure about the merit of going into this level of
detail.  Being able to use only a single file looks like a more
fundamental design limitation, which deserves to be decribed in this
section, and we could ship the subsystem with that limitation.

But the lack of verify that can be called from fsck is merely the
matter of not the subsystem being mature enough (to be written,
reviewed and tested) and not a fundamental one, and we will not be
shipping the subsystem until that limitation is lifted.

So I'd guess that we prefer this bullet item to be in the commit log
message, not here, that describes the current status of the
development (as opposed to the state of the subsystem).

> +- Generation numbers are not computed in the current version. The file
> +  format supports storing them, along with a mechanism to upgrade from
> +  a file without generation numbers to one that uses them.

Exactly the same comment as above applies to this item.

> +- The commit graph is currently incompatible with commit grafts. This can be
> +  remedied by duplicating or refactoring the current graft logic.

Hmm.  Can it be lifted without first allowing us to use more than
one commit graph file (i.e. one for "traverse while honoring the
grafts", the other for "traverse while ignoring the grafts")?

> +- After computing and storing generation numbers, we must make graph
> +  walks aware of generation numbers to gain the performance benefits they
> +  enable. This will mostly be accomplished by swapping a commit-date-ordered
> +  priority queue with one ordered by generation number. The following
> +  operations are important candidates:
> +
> +    - paint_down_to_common()
> +    - 'log --topo-order'

Yes.

> +- The graph currently only adds commits to a previously existing graph.
> +  When writing a new graph, we could check that the ODB still contains
> +  the commits and choose to remove the commits that are deleted from the
> +  ODB. For performance reasons, this check should remain optional.

The last sentence is somehow unconvincing.  It probably is not
appropriate for the "Future Work" section to be making a hurried
design decision before having any working verification code to run
benchmark on.

> +- Currently, parse_commit_gently() requires filling in the root tree
> +  object for a commit. This passes through lookup_tree() and consequently
> +  lookup_object(). Also, it calls lookup_commit() when loading the parents.
> +  These method calls check the ODB for object existence, even if the
> +  consumer does not need the content. For example, we do not need the
> +  tree contents when computing merge bases. Now that commit parsing is
> +  removed from the computation time, these lookup operations are the
> +  slowest operations keeping graph walks from being fast. Consider
> +  loading these objects without verifying their existence in the ODB and
> +  only loading them fully when consumers need them. Consider a method
> +  such as "ensure_tree_loaded(commit)" that fully loads a tree before
> +  using commit->tree.

Very good idea.

> +- The current design uses the 'commit-graph' builtin to generate the graph.
> +  When this feature stabilizes enough to recommend to most users, we should
> +  add automatic graph writes to common operations that create many commits.
> +  For example, one coulde compute a graph on 'clone', 'fetch', or 'repack'
> +  commands.

s/coulde/could/.

Also do not forget "fsck" that calls "verify".  That is more urgent
than intergration with any other subcommand.

> +- A server could provide a commit graph file as part of the network protocol
> +  to avoid extra calculations by clients.

We need to assess the riskiness and threat models regarding this, if
we really want to follow this "could" through.  I would imagine that
the cost for verification is comparable to the cost for regenerating,
in which case it may not be worth doing this _unless_ the user opts
into it saying that the other side over the wire is trusted without
any reservation.

