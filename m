Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FA2E1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 21:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeHVA1I (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 20:27:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41683 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeHVA1I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 20:27:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so8324706wrb.8
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 14:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9BizQa/csaXcLV7tkVGbh7QtHc09E6uLEK0LDVjiT8A=;
        b=fZzA0AE0FIfr0F8bd/nh3CAOR843ARk8YlGc3xmHTgla9drWZtxoOraMaHL4jK3vta
         1yLFtPqiPbtB5jsawoOMCHbBwwjzT+uBQSbXnPP+FB0w8+EbjJKANY+ZIV2F/skktYhN
         MVhc9EbEcL3dzTuDZKLxd71JYjWFbzqoGYIbcHQFQI7CFfNTTdAxqSyngKTebHiS9a4e
         rWo67tF6sCVYkwJ0zFlyiGNxQJu4TxJJpXL238jrxWOxlaNyE8+6IO0/BNR0X3urWfMH
         gE8+SggAmPQxIw08MlD41+CTxEn7S5bOe0jgm1zI41JXNHpgiAmCTgtNnCDg0OLgebbK
         UWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9BizQa/csaXcLV7tkVGbh7QtHc09E6uLEK0LDVjiT8A=;
        b=WdeNAH087VIu+ISWKTb5EBAG+FzQgDSBxbN/XYQtMCefcop7s64rhGLd3KQwpUqlOp
         ibfHXNl/Oh8V7efBYKfwyUuLcN0hOcaoGZk8A4N01zO+5JxWkM4QR6xX3gZH3eOM0iEq
         JhwBU6jmAcDfRtxpEmy5eln1327qTQxu9gf402of83P0YRdGdHhy2DPM/p5wOUYBLOvo
         uyRXfIuMvdnMH0N4H3PJRWpDpcAZfsQBV6s8s4C6ShvdrqDGkVGXt8fuqAuhVZkrG+Q9
         a9x33ruKngnKkUneAcc8N9WYr7zeeQh/wDARKtykBEJpc56pxF/8CuYox6Bj4BC5kyKn
         p8Qg==
X-Gm-Message-State: APzg51D84UZqTHpJFE4CECPi8TJ+CN63R52kvi5fuMgXLEhfkKsxP3ok
        fClzFsyxcwX2E9xRJVAjI84=
X-Google-Smtp-Source: ANB0VdYEwXk+9YY65065fUsGWOve+DFkbYP9uwnpFlwTqGDJ5gd+IO6O6VzmbeEO25mIMqW7NIAUrQ==
X-Received: by 2002:adf:8b98:: with SMTP id o24-v6mr5215463wra.110.1534885521019;
        Tue, 21 Aug 2018 14:05:21 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b8-v6sm13357019wrw.22.2018.08.21.14.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 14:05:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "johannes.schindelin\@gmx.de" <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] commit: use timestamp_t for author_date_slab
References: <20180821205359.29569-1-dstolee@microsoft.com>
Date:   Tue, 21 Aug 2018 14:05:19 -0700
In-Reply-To: <20180821205359.29569-1-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 21 Aug 2018 20:54:12 +0000")
Message-ID: <xmqqy3cz77n4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> The author_date_slab is used to store the author date of a commit
> when walking with the --author-date flag in rev-list or log. This
> was added as an 'unsigned long' in
>
> 	81c6b38b "log: --author-date-order"
>
> Since 'unsigned long' is ambiguous in its bit-ness across platforms
> (64-bit in Linux, 32-bit in Windows, for example), most references
> to the author dates in commit.c were converted to timestamp_t in
>
> 	dddbad72 "timestamp_t: a new data type for timestamps"
>
> However, the slab definition was missed,

Makes sense, and obviously correct.

> I found this while reading up on the revision-walk machinery. This code
> hasn't been touched in years, so could apply to 'maint'.

Thanks.
