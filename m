Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57D951F463
	for <e@80x24.org>; Wed, 25 Sep 2019 17:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392132AbfIYRJG (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 13:09:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45904 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731087AbfIYRJG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 13:09:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so3893798pfb.12
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0qMgrlycqXkFbx3TdhkdJqzCoP7TuODALyI4OKiFQvw=;
        b=s/YBi6UKOhzfduime+f89ZZJ4y91P+Wj7UNTnrUsyOYHLsWnMy8bCYsKs03mGR4gtp
         BOPLTTIBLHke765T2vJMmn52CjTRSYpZspkZBVcVUyrSao0hsBAIQhhSb0XHkZZ3TAXo
         /5Git9aLmTZYJx5ca9PHL6s6o5OJiV6uuuA5IGh9lLZQfzyT5JDqNN1XVx9Ye4UUWu6D
         izFvfx8Lqz9JlrUwMPC2GJGHEkEQLRKPHuR2BB0MvBzqlQyD1a/HIwQ2vVylmS++necR
         OkSdcoKZj44aLh1Np/GB2P8CYkYCee4PKanVCMb3s6nTUY9daE9c3yaTMURbjdHuikFJ
         3qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0qMgrlycqXkFbx3TdhkdJqzCoP7TuODALyI4OKiFQvw=;
        b=VXXLXap/EHDevOEsEv9xpHUMe91wDIlwgHk2HZyk4vEOuq9ZXfU9ndj9w6jKj4BZ9D
         aj3MlPz+SUgzLReGfNQD3bu2iAgQytNxvaJGC4oRj76bw6o7dHzLNckc5Q0p8Qhiu3Ea
         xsrYAb1AZbLYRreZFaZUT3AO4gypdhhkEL7OnMPj2sLrOL+j3JFJODA+TYBzztBb6CtG
         WnNhg02ahW2z0D9VajDeKXkpHlUTbF9Tx7/gtXanNEFuPMPOu3RQHQkGE8eghTo2FoKt
         0slmPyq5FXQqb3KsZHYhETsEQWZtaIQmCrvu42ap2gPKYmfnqa0g51PGhPGsIIA9MZ+S
         E3lg==
X-Gm-Message-State: APjAAAUcMNRGdZ1ebs9wfd4+d5xvyNLPjcUDN3mRBhaBYZ85Q9vBDvbB
        Ja9nnD4DTp/7sIprVu70mPig4G7H
X-Google-Smtp-Source: APXvYqyTARYoKWeo9WKkQ5XIQhdWCHrLMmDyHm5zgJ9qkwvmWZzZzEUcPePyOUx67cPyRJotrYL7Fw==
X-Received: by 2002:a65:67d4:: with SMTP id b20mr318156pgs.445.1569431344908;
        Wed, 25 Sep 2019 10:09:04 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id d5sm12061489pfa.180.2019.09.25.10.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 10:09:04 -0700 (PDT)
Date:   Wed, 25 Sep 2019 10:09:02 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Allan Caffee <allan.caffee@gmail.com>,
        Noam Postavsky <npostavs@users.sourceforge.net>
Subject: Re: [BUG/PATCH 0/5] t4214: cleanup and demonstrate graph bug
Message-ID: <20190925170902.GA11547@dentonliu-ltm.internal.salesforce.com>
References: <cover.1569407150.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1569407150.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 25, 2019 at 03:26:57AM -0700, Denton Liu wrote:
> I tried my hand at fixing the bug but in the hour I spent going at it, I
> couldn't fix the logic up. The buggy logic is in graph.c:
> graph_draw_octopus_merge() in case anyone is interested.

I guess for the record, this was the final patch that I ended up with.
Two issues with it, though: 

1. It assumes that there can be no parallel paths on the right side,
which I'm not sure is a correct assumption.

2. It _still_ fails my last proposed test case.

-- >8 --

diff --git a/graph.c b/graph.c
index f53135485f..f9395a2327 100644
--- a/graph.c
+++ b/graph.c
@@ -881,8 +881,7 @@ static int graph_draw_octopus_merge(struct git_graph *graph,
 	/*
 	 * In both cases, commit_index corresponds to the edge labeled "0".
 	 */
-	int first_col = graph->commit_index + dashless_parents
-	    - parent_in_old_cols;
+	int first_col = graph->num_new_columns - dashful_parents;
 
 	int i;
 	for (i = 0; i < dashful_parents; i++) {
