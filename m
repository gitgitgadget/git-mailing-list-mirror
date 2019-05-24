Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E85A1F609
	for <e@80x24.org>; Fri, 24 May 2019 12:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391352AbfEXMVe (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 08:21:34 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36206 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391216AbfEXMVe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 08:21:34 -0400
Received: by mail-wm1-f42.google.com with SMTP id v22so1766303wml.1
        for <git@vger.kernel.org>; Fri, 24 May 2019 05:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Ab/rvBmfEXGY1PXIRdVW5fe2Ibg1/m8yNyjqsSeqYcg=;
        b=RiWhXr20GWppZEIzoTGKmjl//zvVIt4BLUONqIuFHCZ0BrBWYJgIwzlAQKURb0K481
         Gg43UM0Nwq/0TiI00nrVjM8eDHZW2t5SAvitbsIDlDL5WsG988sL0HVQqpGoJ7fY3+w6
         3Eryjl1M442txgYWfLeRdXKa33+rfditMwcm5+y4h8RLz1fmYVxktzDuI1OcZqAQH5w0
         47HDPDo2hWgaMn7hR/jmuyfhk5a9PeF3UPTQVGlmM1+ASdCohGx0ERnFCe+E5XcMZE+O
         vT9r7O20r5UfuoTO/XCMV5NzzCS24bPq59PjFBflqM0YRjcpcLxZGBc8WNQ/LHNEzs2u
         vTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Ab/rvBmfEXGY1PXIRdVW5fe2Ibg1/m8yNyjqsSeqYcg=;
        b=eCT2Ue+M7s4430yTjF/HrO5RJFpeB4I9K3MOEeEcFp+bfzA80snBURZKi36peTKwUs
         f6OsoA4Di/orMYesSfn/0SunTpWQuoU5u6CPvYFbDqXxMXPbmwIC62rwFP58wG9zlNYu
         qOCa9OP5/U49yig1A3gYN1w14iyU7MIT1Pqjh52g0K2zqvrWr/bakzYI9myZFDcdU2Xg
         pIc6DlX8KtEVL8b9SAZ7YsPJeXd7+16WUCS3hYhEqOb+hQfLGjCHN115n+PpO7i+BHO5
         rCU4OHK/fDVor0It37egz6micF0rbV59w0AFZl7fUCEb6/zGH0PwvS0zg5vU7x2NZcUj
         TOvQ==
X-Gm-Message-State: APjAAAWbsh/L3+2s0NLGaPv8UpSwlD+7aRkwCrz3yO3RTx1QqodnBgqh
        RVBKRCv2G6mr4uP3cIYCxT4=
X-Google-Smtp-Source: APXvYqysb1d8Lp96f4a3pnIFAPKkW612LzrelgJnMirBicGmDFxHZu+o8Azys+0Phna+3ufmykslwQ==
X-Received: by 2002:a1c:7e08:: with SMTP id z8mr15081731wmc.36.1558700492209;
        Fri, 24 May 2019 05:21:32 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id 74sm2648547wma.7.2019.05.24.05.21.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 05:21:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Matthew DeVore <matvore@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH] list-objects-filter: disable 'sparse:path' filters
References: <20190524120318.4851-1-chriscool@tuxfamily.org>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190524120318.4851-1-chriscool@tuxfamily.org>
Date:   Fri, 24 May 2019 14:21:29 +0200
Message-ID: <87ef4of3g6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 24 2019, Christian Couder wrote:

> If someone wants to use as a filter a sparse file that is in the
> repository, something like "--filter=sparse:oid=<ref>:<path>"
> already works.
>
> So 'sparse:path' is only interesting if the sparse file is not in
> the repository. In this case though the current implementation has
> a big security issue, as it makes it possible to ask the server to
> read any file, like for example /etc/password, and to explore the
> filesystem, as well as individual lines of files.

Removing this is a good idea.

Just to clarify, what was the attack surface in practice? We pass this
to add_excludes_from_file_to_list(), are there cases where it'll spew
out parse errors/warnings that allow you to extract content from such a
file?

Or does it amount to a DoS vector by pointing to some huge (binary?)
file on-disk, or a security issue where you could via the error or
timings discover whether the file exists or not, something else?

I wonder if server operators need to be paranoid about the DoS from the
issue with <oid>:<path> noted int/perf/p0100-globbing.sh which this is
presumably vulnerable to, i.e. someone with repository write access
uploading pathological patterns. That might be particularly annoying for
e.g. GitHub where the fork network's object storage is shared.
