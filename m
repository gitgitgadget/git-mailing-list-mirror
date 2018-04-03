Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7070F1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 18:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeDCSaN (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 14:30:13 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:35277 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbeDCSaM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 14:30:12 -0400
Received: by mail-pl0-f42.google.com with SMTP id 61-v6so8055083plb.2
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 11:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2NBuJRxqTqQX5DJ5Dzn85qZpZeGB5T9af5x5N7kf+aw=;
        b=NtVg4OJAdGTbNonRZ+ps208WNQ0B3m7kM/iD52MrdXja6v/c7YWCq1KA5vldKmq9tH
         lcW2Hbez7z5zxU50KIDYd2wtKbzmqTkDvleMzNZ7sbuFZm/+nqNnjnF1Ynus11l8fdFE
         2ky2J2sWOT08JQZCJNL28ftStN81zXBH76l0Qzz+uVvGo4O47WgmJ06S1YsUbM51St49
         eUJfNBUUvnMzYmLSbLHJftKIY1WiNLU88VsSmO6gaeF7jmVhShqTRwlC0NL3lfa3Wc2T
         PvOEMY5i/OMkMbv4HHZ/C7uGzNbYV4RBs6Y9d4/aQbmfdG5Uz3WAfgHbb3MLIYbVpxfr
         WgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2NBuJRxqTqQX5DJ5Dzn85qZpZeGB5T9af5x5N7kf+aw=;
        b=NwumZJ7UBq+dWdP3XvcEkPIXLpoTCLvzsgcGfLuTD1QwOtzeWeThb1QeaLDtEJXmU5
         7rDrcZEXaS9k78CMXfUnOeXtzE5HflWhC6P0D4Mzjn3RFVmj7WHIKnVZe+nWJGe50Z+6
         egx503llA2Iun6zoernMgrbdGvmtXgc+16QdE6j6QcxXu3x6R0v0vCd9YSX2gwSDP/2I
         yUhC10tXRYjJJNAJwi2ZeCNIjmqlSw0+aMeklhh80BQBTraqjc3oUww0qe4PLqI9e93x
         8Cu+9ZB17isZBEvkm4Z6cnZ1OKN8W9a9ezjp/WX2hUuz3hg7ayaP+iTc1HLnyZhD7A+q
         JKqQ==
X-Gm-Message-State: AElRT7GvfTAGJ9OuCyTokBK/a6yLaCq8QaOyXRmxwL9Qt419CFxVH+ZN
        ELfw0UYhnloMjhCizok+PudDx1jbEww=
X-Google-Smtp-Source: AIpwx4+MpDbmj3rpEAbbOIEG/WFBIH3203G8pkwnasT7or5Rrw4HFwm/ewCyJ2wuDMa4Soxdmy1F3g==
X-Received: by 2002:a17:902:24c7:: with SMTP id l7-v6mr15128347plg.320.1522780212357;
        Tue, 03 Apr 2018 11:30:12 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id b65sm7382936pfl.145.2018.04.03.11.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Apr 2018 11:30:11 -0700 (PDT)
Date:   Tue, 3 Apr 2018 11:30:10 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sbeller@google.com,
        larsxschneider@gmail.com, peff@peff.net
Subject: Re: [PATCH 3/6] commit-graph: compute generation numbers
Message-Id: <20180403113010.170ef6a14b0c126f99651bc4@google.com>
In-Reply-To: <20180403165143.80661-4-dstolee@microsoft.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
        <20180403165143.80661-4-dstolee@microsoft.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  3 Apr 2018 12:51:40 -0400
Derrick Stolee <dstolee@microsoft.com> wrote:

> +		if ((*list)->generation != GENERATION_NUMBER_UNDEF) {
> +			if ((*list)->generation > GENERATION_NUMBER_MAX)
> +				die("generation number %u is too large to store in commit-graph",
> +				    (*list)->generation);
> +			packedDate[0] |= htonl((*list)->generation << 2);
> +		}

The die() should have "BUG:" if you agree with my comment below.

> +static void compute_generation_numbers(struct commit** commits,
> +				       int nr_commits)

Style: space before **, not after.

> +			if (all_parents_computed) {
> +				current->generation = max_generation + 1;
> +				pop_commit(&list);
> +			}

I think the current->generation should be clamped to _MAX here. If we do, then
the die() I mentioned in my first comment will have "BUG:", since we are never
meant to write any number larger than _MAX in ->generation.
