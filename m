Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23CCD1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 16:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeHCSFs (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 14:05:48 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38334 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeHCSFs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 14:05:48 -0400
Received: by mail-wm0-f54.google.com with SMTP id t25-v6so6951103wmi.3
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sHm6clz/Mv9VYU0V8YhTlRyFG94OVFbX2P34+hrdXjo=;
        b=kbF3cINMhxUy09bENnibkTx7hW4TUZj2fvJ6pzQqRmKA1zqPJtCQ2u4Jub69iycgoE
         pMfljTXUgL4zVzTmqZPpCkoBt1U2QDNERTwjBOrQ7nr3jtCT9tBf48bsDMT/ySg4+t/z
         svh8nlxo69RYW9yrq3ZGdDU1yONfyiA6ghPbXAwnpotKl71nn6xGH6yf2xEzKP38RdXa
         e16Hfd8nyjAevShO7ZK08meSziViEA/yj4k0bPbqdq8k2ufJOd8dr+KPgQtxEDBxavt0
         JMKKvWvmLPBUH55ESMWRPV9S8uKlO0ofHFFsDRu71nOZQSeoVGBpORUWCjJu+x0suGy7
         OppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sHm6clz/Mv9VYU0V8YhTlRyFG94OVFbX2P34+hrdXjo=;
        b=J+/AuTxkviLe3zHBBh5/u2Swf8dbDjqMltNE5doKu9XWDWAYL3IoBqkFOG88WpN0ys
         /KV99/NC+cKuhV5+oQifseWPxf54wuBJUq/zzsMS3Rhg9/2g1tlei0VN958bzuDlJZ42
         MzX0r4OhWutgQks1BlFKjh9qmg+/rfK2hFr2UV3A3i1FF6MykqdNtRwnFWhf9H0WX4zC
         EjKHlznbLo4d4h2a2YLu3KfeNRfzu/04aZG7od3GIKQXnfWtMsA3pkLiQE5YP+9F7NiG
         dBTzCxwyueQ6un0HnSmgpKiooQ3zH96q68HMEDHuXwnjvicPg73sJoJplKUjYonXO2rX
         nHAQ==
X-Gm-Message-State: AOUpUlGGuhWzXJLoVVh8RJCls6DS1DLhLL7fwrR5Va151/ptN5chgvqT
        h3SwmG4MmJmzAmrmRhPCNSw=
X-Google-Smtp-Source: AAOMgpfSfW/aooAPMLiZk8wA4fiTY8NTbDQO+JatLscBG3sMxMYAEqTN0GUhGBPF3t1doupPF7JKVw==
X-Received: by 2002:a1c:3411:: with SMTP id b17-v6mr5175243wma.85.1533312529403;
        Fri, 03 Aug 2018 09:08:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z1-v6sm3989016wmf.5.2018.08.03.09.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 09:08:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2018, #01; Thu, 2)
References: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZ1R8sxmtfgPOQcpoWM7GWV1qiRaqMq_zhGyKBB3ARLjg@mail.gmail.com>
Date:   Fri, 03 Aug 2018 09:08:47 -0700
In-Reply-To: <CAGZ79kZ1R8sxmtfgPOQcpoWM7GWV1qiRaqMq_zhGyKBB3ARLjg@mail.gmail.com>
        (Stefan Beller's message of "Thu, 2 Aug 2018 17:05:06 -0700")
Message-ID: <xmqqk1p7zb3k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Thu, Aug 2, 2018 at 4:02 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> * sb/config-write-fix (2018-08-01) 3 commits
>>  - git-config: document accidental multi-line setting in deprecated syntax
>>  - config: fix case sensitive subsection names on writing
>>  - t1300: document current behavior of setting options
>>
>>  Recent update to "git config" broke updating variable in a
>>  subsection, which has been corrected.
>>
>>  Not quite?
>>  cf. <xmqq4lgc1rbv.fsf@gitster-ct.c.googlers.com>
>
> I'd rather point to
> https://public-inbox.org/git/xmqqftzx67vo.fsf@gitster-ct.c.googlers.com/
> https://public-inbox.org/git/xmqqva8t4s63.fsf@gitster-ct.c.googlers.com/
> instead (reason: shoddiness),

Thanks; I do not think the series was particulary shoddy, but does
deserve a bit more polishing.

> Personally I do not want to care about the old notation
> and by implementing it the way the series is, the
> old notation doesn't see any *changes*.

Yup, I agree that it is good enough.

>> * ds/commit-graph-with-grafts (2018-07-19) 8 commits
>>   (merged to 'next' on 2018-08-02 at 0ee624e329)
>>  + commit-graph: close_commit_graph before shallow walk
>>  + commit-graph: not compatible with uninitialized repo
>>  + commit-graph: not compatible with grafts
>>  + commit-graph: not compatible with replace objects
>>  + test-repository: properly init repo
>>  + commit-graph: update design document
>>  + refs.c: upgrade for_each_replace_ref to be a each_repo_ref_fn callback
>>  + refs.c: migrate internal ref iteration to pass thru repository argument
>>
>>  The recently introduced commit-graph auxiliary data is incompatible
>>  with mechanisms such as replace & grafts that "breaks" immutable
>>  nature of the object reference relationship.  Disable optimizations
>>  based on its use (and updating existing commit-graph) when these
>>  incompatible features are in use in the repository.
>
> Makes sense as a whole, but I dislike the first 2 patches
> (they were my suggestion) for the refs API. I plan to re send patches
> https://public-inbox.org/git/20180730194731.220191-1-sbeller@google.com/
> but fixed for real.
>
> (do not let this stop you from merging down this series)

Well, I do not think we are in a particular hurry to get this down
to 'master', and honestly I'd feel safer to cook a topic that has
potential impact to the core longer in 'next' than other things like
this one (the distinction between the "core" and "other" being how
many things are potentially affected, and because commit-graph is
being integrated into history walking, a bug in the subsystem has a
lot bigger impact than say "rebase -i" that breaks "rebase -i
--root" by producing a malformed author-script file, whose impact
may be severe but limited).

>> * sb/submodule-update-in-c (2018-07-18) 6 commits
>>  - submodule--helper: introduce new update-module-mode helper
>>  - builtin/submodule--helper: factor out method to update a single submodule
>>  - builtin/submodule--helper: store update_clone information in a struct
>>  - builtin/submodule--helper: factor out submodule updating
>>  - git-submodule.sh: rename unused variables
>>  - git-submodule.sh: align error reporting for update mode to use path
>>
>>  "git submodule update" is getting rewritten piece-by-piece into C.
>>
>>  Will merge to 'next'.
>
> Please do not, AFAICT this is still breaking in combination with the
> series merged at 7e25437d35a (Merge branch 'sb/submodule-core-worktree',
> 2018-07-18) and I do not recall fixing the interaction between those two.

Thanks for stopping me.
