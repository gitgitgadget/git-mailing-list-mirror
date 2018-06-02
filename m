Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A696E1F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 18:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbeFBS1y (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 14:27:54 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36234 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751267AbeFBS1x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 14:27:53 -0400
Received: by mail-wr0-f193.google.com with SMTP id f16-v6so23864638wrm.3
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Ca6M/v1+4M0ua/xM3b82S7TfoOCXHW5BJKZkLRlLi9U=;
        b=IXkNGFxeFQyl5jRECsKQ/IHRFiqEqMq6ZnL3oECPCRum+TSemOEoa7nYZynYlp/WMT
         DGsYopNAxgec+8iG02BWSLUddVZ46O2gJsbYjrU/kt5GiMRDJhDRA9pJz7wPOi7NkkOs
         jUGg8xrrKprEu3vJTHsHi8hMiMOz2sUd2zalE7aolMe639tbqwPwWJAbxvrEflB0Rusi
         r5iYcefWH8FkFMghOg0N0gj9tjPjAw9pJa+4fsUzV9gnIZ+16Vbv4q8sZr/15kbVM9BJ
         jWyReJumH8rzDQSuYIdyG+TRRJKiqQv3VkL00XeYoL5k1gBl6tZXIW2i30sP8uv9Nzr/
         6p6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Ca6M/v1+4M0ua/xM3b82S7TfoOCXHW5BJKZkLRlLi9U=;
        b=tAlzqepxEyOgWJwKOLLM7sJLM/HEaEz6c++XsioKXiWZxKz6qn5I/psYHwC8bH74Wf
         JNtmP24pWFgx0i8cMKUUqyuVwkQkJbbfvkLx1A6H/jmrkJvDlHt3JQ9gA3IGEiJ9s5pB
         RbRjH76Xj4vidOx8b1vyKkHs2wLQHFk4fKMGLrboriUKuEzvMAIE4r6qAhiWI6R9aCt/
         5MHoXxFswbEwxhnNvXcsKvHpl0UBr6qBAnD8xuNUNjSgJw/YpSEuQ+gOER8dfD1AuKn6
         Nlj6UljCvD36PkRMbVUcWJhXCBKy37GOTav3yaN3pl3OypKpDT6LQF8FlrkC3KyAaZO8
         cojw==
X-Gm-Message-State: ALKqPweZbDRZtL+EJxk+4szIm45E42DjzwsF412LBEXoyYqUOw/FlN20
        SKjXhhAEAmSGf6war02oM0Ob/e/9
X-Google-Smtp-Source: ADUXVKJo+am0Oe5dqibcyAHf5IRzId6eQJSylsMNsPS6LDeBfI7lppB35YSs2Jm2UKevPgz5mjvovQ==
X-Received: by 2002:adf:ff09:: with SMTP id k9-v6mr6304174wrr.15.1527964072572;
        Sat, 02 Jun 2018 11:27:52 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abri204.neoplus.adsl.tpnet.pl. [83.8.102.204])
        by smtp.gmail.com with ESMTPSA id y6-v6sm5171894wmy.39.2018.06.02.11.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Jun 2018 11:27:51 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 20/20] commit-graph: update design document
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-21-dstolee@microsoft.com>
Date:   Sat, 02 Jun 2018 20:27:48 +0200
In-Reply-To: <20180524162504.158394-21-dstolee@microsoft.com> (Derrick
        Stolee's message of "Thu, 24 May 2018 16:26:11 +0000")
Message-ID: <86wovhqc0r.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> The commit-graph feature is now integrated with 'fsck' and 'gc',
> so remove those items from the "Future Work" section of the
> commit-graph design document.

It is always nice to have such commit as a summary what was done in the
series, and to have up to date roadmap.

>
> Also remove the section on lazy-loading trees, as that was completed
> in an earlier patch series.

Admittedly, this part could have been sent in a separate patch at the
start of the series, but it doesn't matter at all; no need for extra
work.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/commit-graph.txt | 22 ----------------------
>  1 file changed, 22 deletions(-)
>
> diff --git a/Documentation/technical/commit-graph.txt b/Documentation/tec=
hnical/commit-graph.txt
> index e1a883eb46..c664acbd76 100644
> --- a/Documentation/technical/commit-graph.txt
> +++ b/Documentation/technical/commit-graph.txt
> @@ -118,9 +118,6 @@ Future Work
>  - The commit graph feature currently does not honor commit grafts. This =
can
>    be remedied by duplicating or refactoring the current graft logic.
>=20=20
> -- The 'commit-graph' subcommand does not have a "verify" mode that is
> -  necessary for integration with fsck.
> -

All right.

>  - After computing and storing generation numbers, we must make graph
>    walks aware of generation numbers to gain the performance benefits they
>    enable. This will mostly be accomplished by swapping a commit-date-ord=
ered
> @@ -130,25 +127,6 @@ Future Work
>      - 'log --topo-order'
>      - 'tag --merged'
>=20=20
> -- Currently, parse_commit_gently() requires filling in the root tree
> -  object for a commit. This passes through lookup_tree() and consequently
> -  lookup_object(). Also, it calls lookup_commit() when loading the paren=
ts.
> -  These method calls check the ODB for object existence, even if the
> -  consumer does not need the content. For example, we do not need the
> -  tree contents when computing merge bases. Now that commit parsing is
> -  removed from the computation time, these lookup operations are the
> -  slowest operations keeping graph walks from being fast. Consider
> -  loading these objects without verifying their existence in the ODB and
> -  only loading them fully when consumers need them. Consider a method
> -  such as "ensure_tree_loaded(commit)" that fully loads a tree before
> -  using commit->tree.

All right, this is about the change done in previous series.

> -
> -- The current design uses the 'commit-graph' subcommand to generate the =
graph.
> -  When this feature stabilizes enough to recommend to most users, we sho=
uld
> -  add automatic graph writes to common operations that create many commi=
ts.
> -  For example, one could compute a graph on 'clone', 'fetch', or 'repack'
> -  commands.

All right; actually it was done by augmenting 'gc' instead.

> -
>  - A server could provide a commit graph file as part of the network prot=
ocol
>    to avoid extra calculations by clients. This feature is only of benefi=
t if
>    the user is willing to trust the file, because verifying the file is c=
orrect

Good work,
--=20
Jakub Nar=C4=99bski
