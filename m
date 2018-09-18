Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83C461F404
	for <e@80x24.org>; Tue, 18 Sep 2018 06:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeIRLgk (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 07:36:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41275 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbeIRLgk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 07:36:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id f38-v6so856459edd.8
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 23:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=h22BEjAalXu1nVRslfKg+JstJ/bBWCyNe27gkz1QGQA=;
        b=DCa62sPzWCGtkxMDUg2y12o1LbBxgydAkFFKxfmc5cXqjnCi54iyfShuhnRWpxH1Ut
         2/c8mp5iOnBuZJRfldZbRZHBn58FXcgrjCgTukwSYgFXHLcDyb3fVpguaiM6dCiSnV9u
         39yfGE2bM3dXoQl2f7FX9tClY1Hq+RQE0Lw35o6XyxkxfI/B+Sy6WxqxJ0OjYIE1ew2/
         FhNboiTgfK3Tgk3WOta5dnz5W4SXMCOz3JTjJl8JPj1gRPB7dKxWY+i/8lbX2SN2o9ww
         Zugk46Q64qAdOAVi0AIDSASd+qNtND4ne71ewxy+k8WVKDUef6j0an4eLyRBnd8t1Qim
         m3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=h22BEjAalXu1nVRslfKg+JstJ/bBWCyNe27gkz1QGQA=;
        b=ggucWv82nCHgxigYpbfIrF0+FZAUVGGW7ZWYu+bBeoavYBYq1qJlA0rS4SX9fhCQB5
         yCCzgRSb2eK6nmQqyCrwToiI6T0TWRhP4LSGyajYNDBdyLtBgR4/cVL8mYgLDSpSr4V7
         BluFs3OEA6D3en5ImNZbGiHP8CGiqs+pH4zxbhgxipLGIlAMCI/hVxwVKmtXpjAQfk8H
         SvF48fqnqPehZrNqUOpx1e2KPvf5gnnqWOMzxsCngbfeY7nZSqJrH6DwMFFn8hljV/py
         NJokKErOfLIFKBoc+R/PZdVWhUjUm/Ncy1CkP/2x5CKI3D1OJhObM19JY80DWO5l5B/t
         YQ+A==
X-Gm-Message-State: APzg51BI/W7duzo1sdInE8A7CzGQePpsTkrZT5iq3B1PuJDiTrOTKbWI
        AahXDkNfCHskrSU+ezEdP0yUCOpjhT0=
X-Google-Smtp-Source: ANB0VdaY8ZRa25oRIS+apjEaTiExch+S0SHOu9TFvoKS/bZYG6u0ytYQETiotSBT/G0jCb2CWVQV2Q==
X-Received: by 2002:a50:9306:: with SMTP id m6-v6mr47928158eda.206.1537250737131;
        Mon, 17 Sep 2018 23:05:37 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id a33-v6sm7863545eda.2.2018.09.17.23.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 23:05:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] Use generation numbers for --topo-order
References: <pull.25.git.gitgitgadget@gmail.com> <pull.25.v2.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <pull.25.v2.git.gitgitgadget@gmail.com>
Date:   Tue, 18 Sep 2018 08:05:35 +0200
Message-ID: <87worjjq6o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 18 2018, Derrick Stolee via GitGitGadget wrote:

Thanks. Good to see the commit graph used for more stuff.

> On the Linux repository, I got the following performance results when
> comparing to the previous version with or without a commit-graph:
>
> Test: git rev-list --topo-order -100 HEAD
> HEAD~1, no commit-graph: 6.80 s
> HEAD~1, w/ commit-graph: 0.77 s
>   HEAD, w/ commit-graph: 0.02 s
>
> Test: git rev-list --topo-order -100 HEAD -- tools
> HEAD~1, no commit-graph: 9.63 s
> HEAD~1, w/ commit-graph: 6.06 s
>   HEAD, w/ commit-graph: 0.06 s

It would be great if this were made into a t/perf/ test shipped with
this series, that would be later quoted in a commit, as in
e.g. 3b41fb0cb2 ("fsck: use oidset instead of oid_array for skipList",
2018-09-03).

Although generalizing that "-- tools" part (i.e. finding a candidate
dir) will require some heuristic, but would make it useful when running
this against other erpos.

> If you want to read this series but are unfamiliar with the commit-graph and
> generation numbers, then I recommend reading
> Documentation/technical/commit-graph.txt or a blob post [1] I wrote on the
> subject. In particular, the three-part walk described in "revision.c:
> refactor basic topo-order logic" is present (but underexplained) as an
> animated PNG [2].

We discussed some of this in private E-Mail, and this isn't really
feedback on *this* series in particular, just on the general
commit-graph work.

Right now git-config(1) just matter-of-factly says how to enable it, and
points to git-commit-graph(1) for further info, which just shows how to
run the tool. But nothing's describing what stuff is sped up, and those
sorts of docs aren't being updated as new optimizations (e.g. this
--topo-order walk) are added.

For that you need to scour a combination of your blogpost & commits in
git.git (with quoted perf numbers).
