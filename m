Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55B781F453
	for <e@80x24.org>; Sun, 21 Oct 2018 12:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeJUVMI (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 17:12:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39455 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeJUVMI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 17:12:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id s18-v6so200078wrw.6
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=jIoOZ2GPunDcAcmh+N4Ga6XQeUZoR0niIec0Vv3yIPU=;
        b=rZm6M4AB3EwdGj2yj5TXwFpXS0MKmiA4LMScdTEmIlhB8mOMP/0l8qZ/M0vZ956Ar/
         Dmxa+pIhxUs/tBjfcj6+ClywPWSxbIUXmF9Gel5P/UEEj/i+pmjePPmykuRVcUsNPGTN
         uiESPtWQFVBRuWV/Mbfi49DFO0kNpdFObHjOtDWap3gR4pzTyWGDOP/TaRX2TYXDhuHg
         lc30VELeomLDu4KxiB51kszm5XTB1QXBIul1C5/NRbnfnqMT2hiJe070TJ8skhk8bAm1
         UxBHkgQh2gjjorIJcmkCrGpPtCmakwYXzILDJlHA4zr03PAtZPPMeMqqgfdiO96YsgLH
         1Kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=jIoOZ2GPunDcAcmh+N4Ga6XQeUZoR0niIec0Vv3yIPU=;
        b=iBNI+W0I0CQtU2mHu1MsFDbbHPPmnWW7wqoT1CArpN5fQPOGxNcy0In/B/0jngyPH0
         HE+kws/lbr8cFUzFjdQIU4xt5lvh89tgyxxSZwZG+0NgUS2eRQWkpu0bS7v+tKM4QlGp
         tWXyzQ5zZSbgGyASpwQsU+b3Gplc5zGi+jcsYQkY6bQ5/ulxl5YMhnkJubypHq2Ey3y2
         uh5nq0HRItpTU5H2DIw7hmtycu8e8g9+2z0MQ6Vq1K1IyJ2je5aSXfDZXLOvn94kANMG
         i9oQVlhWmRm46207fqP28hNQsYfhbV/ZQmn5zNnixWjXaMInLQkgILLwmooJxTGAIpY0
         XiWQ==
X-Gm-Message-State: ABuFfojE9QwoV4MEQ1aAq2r8YMS9SehUCapZXYfSk3KOgGQFz6ZaNFh8
        fBiXVYW7M4ETMmKMkUonkkc=
X-Google-Smtp-Source: ACcGV63nOfFA8gJxJkv9QnuXVs7nvZryKwib78/laqDj4wlrhLXXAMANnQ3TNtcYD4701WccoypwAQ==
X-Received: by 2002:adf:8103:: with SMTP id 3-v6mr40286756wrm.106.1540126672028;
        Sun, 21 Oct 2018 05:57:52 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abps207.neoplus.adsl.tpnet.pl. [83.8.60.207])
        by smtp.gmail.com with ESMTPSA id 4-v6sm8356892wmt.16.2018.10.21.05.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 05:57:51 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/7] Use generation numbers for --topo-order
References: <pull.25.v3.git.gitgitgadget@gmail.com>
        <pull.25.v4.git.gitgitgadget@gmail.com>
Date:   Sun, 21 Oct 2018 14:57:50 +0200
In-Reply-To: <pull.25.v4.git.gitgitgadget@gmail.com> (Derrick Stolee via
        GitGitGadget's message of "Tue, 16 Oct 2018 15:36:35 -0700 (PDT)")
Message-ID: <86zhv7h2y9.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series performs a decently-sized refactoring of the revision-w=
alk
> machinery. Well, "refactoring" is probably the wrong word, as I don't
> actually remove the old code. Instead, when we see certain options in the
> 'rev_info' struct, we redirect the commit-walk logic to a new set of meth=
ods
> that distribute the workload differently. By using generation numbers in =
the
> commit-graph, we can significantly improve 'git log --graph' commands (and
> the underlying 'git rev-list --topo-order').
>
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

I wonder if we could make use of existing infrstructure in 't/perf/' to
perform those benchmarks for us (perhaps augmented with large
repository, and only if requested -- similarly to how long tests are
handled).

--
Jakub Nar=C4=99bski
