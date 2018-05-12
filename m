Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 725911F406
	for <e@80x24.org>; Sat, 12 May 2018 13:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750905AbeELNbg (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 09:31:36 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:44814 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeELNbf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 09:31:35 -0400
Received: by mail-pg0-f46.google.com with SMTP id x145-v6so3576419pgx.11
        for <git@vger.kernel.org>; Sat, 12 May 2018 06:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yo+sh9Bji29XBj87UaQNeX/ft2Da5ScPREOAqmf7x6s=;
        b=fdjjUADr4Y84QM9CayTA3hm6NKNW25n0rV3cDkSUjfZFLm/oXOQZQUPmYg5+ysmM9r
         98ENTzIs3cvqGCrFbwpP+YzoHo/wJP+5wmg5PcYe2ueyCipAB6SPh8iwiCFYAEdRHkzq
         J/KVWlxcII/MJbRXfEZGvYbxh1VwhvNwYYjB1EtrWRqbG001C/pYxCgJXRTCIhyciULR
         YWEM1Qekjznuqf2WpX1Tf+9QjcSBmjOyH8KYNmXpE609vXysyULpbMMs9abowUhnuXGD
         XQgwYF0Dah6/NNAMeZOyk7Ww1Tp11J3bHN33E/BkLSyRdxuKjyroZ7VMldrP+jVIML6b
         GNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Yo+sh9Bji29XBj87UaQNeX/ft2Da5ScPREOAqmf7x6s=;
        b=tEPnMIDEMmrq8ChYpvZb1ljyc1TdZqJQhqJ9i5j0aToSWPe4NIxK0VO5nxrvh40sCN
         Qc1aQ3VRGYgu2XBiQ42Fm6auRUK9FsaEmwxd5h35FfFwGe3SyDpjNg08gQ/SOUp1WvGV
         tvpPurcG8PDQ5OtMIUqgjE6eKCe05LlLYKRsb2nyi2LuGwy/RahX0yl5237zytXsHoOZ
         Vhx7Lw1478cvjUBfmiDrML6Zob0ELu2pvU0GDa/s9uvuQDiLsIzAMLIG71qhC9cwlMIO
         HWrOKsNGuG1LfG9KhHvvGECDwHkkru/7MTPqReiu9oqYVrMyagj14wIhOIw9dFYiU1cU
         M5wQ==
X-Gm-Message-State: ALKqPwd+nxzAejMTf3IaS4gCI3KtIO9vIgZLNhAmnqi4IG/VyAbgIb34
        63oSGHSiU9biJjQ37ep3GiE7ke0/DtNQg7SM2IqEMZ8V
X-Google-Smtp-Source: AB8JxZofp3xyBJDRA9OXmwl1QcABAgJG/etda5stc1IFHnaWdZzDZCt48flpW5LrfqJtJyTuVvvl1c/tKy1uI1jbHyg=
X-Received: by 2002:a62:62c2:: with SMTP id w185-v6mr3172710pfb.78.1526131895073;
 Sat, 12 May 2018 06:31:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Sat, 12 May 2018 06:31:34 -0700 (PDT)
In-Reply-To: <20180511211504.79877-2-dstolee@microsoft.com>
References: <20180510173345.40577-1-dstolee@microsoft.com> <20180511211504.79877-1-dstolee@microsoft.com>
 <20180511211504.79877-2-dstolee@microsoft.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 12 May 2018 15:31:34 +0200
Message-ID: <CAN0heSotYYgrwMLT1yyFVk4VEZ4OQKF_Xwm9-wZosJ6_-gAVBg@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] commit-graph: add 'verify' subcommand
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 May 2018 at 23:15, Derrick Stolee <dstolee@microsoft.com> wrote:

>         graph_name = get_commit_graph_filename(opts.obj_dir);
>         graph = load_commit_graph_one(graph_name);
> +       FREE_AND_NULL(graph_name);
>
>         if (!graph)
>                 die("graph file %s does not exist", graph_name);
> -       FREE_AND_NULL(graph_name);

This is probably because of something I said, but this does not look
correct. The `die()` would typically print "(null)" or segfault. If the
`die()` means we don't free `graph_name`, that should be fine.

You're still leaking `graph` here (possibly nothing this patch should
worry about) and in `graph_verify()`. UNLEAK-ing it immediately before
calling `verify_commit_graph()` should be ok. I also think punting on
this UNLEAK-business entirely would be ok; I was just a bit surprised to
see one variable getting freed and the other one ignored.

Martin
