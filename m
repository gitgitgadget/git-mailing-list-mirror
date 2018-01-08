Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDD6B1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 22:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755964AbeAHWGf (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 17:06:35 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:37908 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbeAHWGd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 17:06:33 -0500
Received: by mail-pf0-f182.google.com with SMTP id u25so6983937pfg.5
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 14:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xJpDQh/06HkcAUq3x9B9ePhslijA9ef0CjpnmVZIuIA=;
        b=MxEOxAwxI/v/rMWrjf1WsXBTopROMLDYC3bTqCWsS43qINi0JAUGmorM2ydYmr6tU0
         bdYEFabJ9mxQiaK+gDEeRtlthZlgYc/ruEA+6JhJxKQiMnIS01KLyu6/sna1P7X/LEEC
         6Wj3yZUmkOeGYagQBIGperb+AZ42hHqWc0c11dnV8MqpXIzv/RGewLg5lLNp1t4XuOOM
         5ne5VU07Adh++liRjixjvD1A8griLhOe9WTg3t22auNuLiVE/cZJ8Mz6CmenVXM+N5eg
         8uTJuuYHMuCbRQUQQDvyGJV//F2pGVCL/LE9/wB2NB2eMMWCRo3j75fVJCnnphzCuzPs
         Qx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJpDQh/06HkcAUq3x9B9ePhslijA9ef0CjpnmVZIuIA=;
        b=C7SaTfv++PwnL8ROqNNX5ZPt11LxcLqyUo6+Mr7L6FAMpgWRkFPZNmwLJidWuprCf/
         Jfi8YwuauqtNLnk8KQ3uLAYrdvaTWnoSHFfv3V6Zel6BJPHY/ItDeytyRzzNAV8cobpq
         RZrVz269bA0fLe7lmIM+UhJlXMmiwzoa/Ev+pjMVQ2bjYIZHXOCqNXME0tA2kKzll6Qi
         YLpPxpUVrT8by/owqmOla4PrPyXBMCeW+Bf21+9gqnxgfN6lBDDmBMpj1KWtSPv2whCm
         L1r3NtE2N5CtO3IYCA3AGKBdmSS6fyp2JR4VK89dQsSPzXlSdCGCgzRXv7eMhXbkC/e4
         yrCA==
X-Gm-Message-State: AKGB3mIEYXQ4H9ClpshfpDd4s0WFo4d3eTcFkRO9fXF+NwRlKQ/QKj2/
        GqToS7v1zpu+WKsNTdNyNan0fQ==
X-Google-Smtp-Source: ACJfBovxgl1YWx15MB6ZhlbZQV77CiRFIMZ6BVUjDgZBD7SVoBPOh+WUdF3gRba9H3cZIHTkWp7xGg==
X-Received: by 10.99.106.138 with SMTP id f132mr10597607pgc.211.1515449192976;
        Mon, 08 Jan 2018 14:06:32 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:b54f:f5a7:98a3:acf1])
        by smtp.gmail.com with ESMTPSA id u81sm29993081pfa.70.2018.01.08.14.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jan 2018 14:06:32 -0800 (PST)
Date:   Mon, 8 Jan 2018 14:06:31 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: Re: [RFC PATCH 01/18] docs: Multi-Pack Index (MIDX) Design Notes
Message-Id: <20180108140631.1205a837baab24cb0fe021bc@google.com>
In-Reply-To: <4d7a1fb2-84ca-6bf9-811c-29ad21b4c5a6@gmail.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
        <20180107181459.222909-2-dstolee@microsoft.com>
        <20180108113226.da265814e5c1deea1f8c404d@google.com>
        <4d7a1fb2-84ca-6bf9-811c-29ad21b4c5a6@gmail.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 8 Jan 2018 15:35:59 -0500
Derrick Stolee <stolee@gmail.com> wrote:

> Thanks! That is certainly the idea. If you know about MIDX, then you can 
> benefit from it. If you do not, then you have all the same data 
> available to you do to your work. Having a MIDX file will not break 
> other tools (libgit2, JGit, etc.).
> 
> One thing I'd like to determine before this patch goes to v1 is how much 
> we should make the other packfile-aware commands also midx-aware. My gut 
> reaction right now is to have git-repack call 'git midx --clear' if 
> core.midx=true and a packfile was deleted. However, this could easily be 
> changed with 'git midx --clear' followed by 'git midx --write 
> --update-head' if midx-head exists.

My opinion is that these are sufficient:
 (a) functionality to create a .midx file from scratch (deleting any
     existing ones)
 (b) either:
     - update of packfile.c to read (one or more) midx files (like in
       patch 18), and possibly usage in a benchmark, or
     - any other usage of midx file (e.g. abbreviations, like in patch
       17)

In general, a way to create them (so that they can be used from a
cronjob, etc.), and a way to consume them to show that the new way works
and is indeed faster. This functionality in itself might be sufficient
to merge in - this would already be useful in situations where it is
undesirable for repacks to happen often, and we can "bridge" the
intervals between repacks using a cronjob that periodically generates
.midx files in order to keep up the object lookup performance.

In particular, I think that it is fine to omit a more sophisticated
"repack" for now - the .midx mechanism must tolerate packs referenced by
.midx files suddenly disappearing anyway, and in this way, at least we
can demonstrate that the .midx mechanism still works in this case.
