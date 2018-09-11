Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB2C41F404
	for <e@80x24.org>; Tue, 11 Sep 2018 17:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbeIKW30 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 18:29:26 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37511 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeIKW30 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 18:29:26 -0400
Received: by mail-wm0-f50.google.com with SMTP id n11-v6so1848725wmc.2
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 10:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JPhtV9dAo8jBFwJzJwMSo8JmdFndwB9yPPnu/PHngN4=;
        b=PyikupbYeue2+yySeEQ4UKFIrApfSqiyCgytUf7Us/67+FXXkm/5BIdg8xhURcd31e
         bL67CXWiR69TdCnzi0pZLT/9Z7YyIBcoX/uTaTeYtvp9reAaFQThK5V+heHC4ukAK5nj
         IwZBVFjpfZKfoWvHiggz0s3UGjDP/3R2XnYFeGOHNpGqf3sJGmR0KdPk3Wr3BsqcnvZO
         y0osx/ezRsAp5124MUMfH4l/zTcPZV7ZcAA4Gwlwn55B7c6qimdRtr67KFfTPuS3vTw1
         o4c9/ME22oO0GKx0ivU5ojMmvhXOCEpHhGOgcNF24BUPV3XdLbsq2cju8kN5cFg1ztQf
         YiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JPhtV9dAo8jBFwJzJwMSo8JmdFndwB9yPPnu/PHngN4=;
        b=PXHcN7GpOCLU15HX2bJAD35IU4wGAZK9L2Ccef1V4H0BFnSOnSbUq8naexDgoa+o3I
         vTKSwG6vT2jsk+z/CRKQhYFCW6gIL0uDATW9oTivtROHx2dq2u/p58zZir6gMhv5jYhD
         0R9KGtx28tNH5KoJVFJpy7yTfNqtiwDobpWYbbw75nHbpRs7bpfdXGsr8r5KtTWYVLC3
         Pva3wOd3wwtKH/fufOM/isMF2F9MGAunnwl4zpC7x+DFO5SAlJO1wH96Tks9aVETGfmE
         PVj7Zi/AVgx4tGBfZeTnqt8ZLpWdmoO7llE792S+H3LGjz1/1cQups86QLZWjdNbvbLu
         tV5w==
X-Gm-Message-State: APzg51DsqlbHRf21Yf2AiAmIrmVf7Q0rLwENTpvHc3eEATYbTD51PuG6
        JUEqwRYJHnmsBuw1G7Jf+XW6l0fS
X-Google-Smtp-Source: ANB0VdYw7d8q/5jcpEs7aQPKCXKgeKGW6jR3XWDsbFbWs9mGEGRmjGSGbaQZItgCWAToiBiDo/BSsA==
X-Received: by 2002:a1c:8145:: with SMTP id c66-v6mr1877547wmd.139.1536686945612;
        Tue, 11 Sep 2018 10:29:05 -0700 (PDT)
Received: from localhost ([2.29.27.208])
        by smtp.gmail.com with ESMTPSA id v1-v6sm17971080wrt.34.2018.09.11.10.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 10:29:04 -0700 (PDT)
Date:   Tue, 11 Sep 2018 18:29:04 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     ryenus <ryenus@gmail.com>, Git mailing list <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Git 2.19 Segmentation fault 11 on macOS
Message-ID: <20180911172903.GC4865@hank.intra.tgummerer.com>
References: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
 <1b8a35be-4234-7f71-c0be-41736bbe60cf@gmail.com>
 <844da493-b1c1-b295-0094-beafd48f3b50@gmail.com>
 <fd241679-2283-4e01-315b-db27be8a794c@gmail.com>
 <20180911163419.GB4865@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911163419.GB4865@hank.intra.tgummerer.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/11, Thomas Gummerer wrote:
> I think you're on the right track here.  I can not test this on Mac
> OS, but on Linux, the following fails when running the test under
> valgrind:
> 
>     diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
>     index 2237c7f4af..a8b0ef8c1d 100755
>     --- a/t/t3206-range-diff.sh
>     +++ b/t/t3206-range-diff.sh
>     @@ -142,4 +142,9 @@ test_expect_success 'changed message' '
>             test_cmp expected actual
>      '
>      
>     +test_expect_success 'amend and check' '
>     +       git commit --amend -m "new message" &&
>     +       git range-diff master HEAD@{1} HEAD
>     +'
>     +
>      test_done
> 
> valgrind gives me the following:
> 
> ==18232== Invalid read of size 4
> ==18232==    at 0x34D7B5: compute_assignment (linear-assignment.c:54)
> ==18232==    by 0x2A4253: get_correspondences (range-diff.c:245)
> ==18232==    by 0x2A4BFB: show_range_diff (range-diff.c:427)
> ==18232==    by 0x19D453: cmd_range_diff (range-diff.c:108)
> ==18232==    by 0x122698: run_builtin (git.c:418)
> ==18232==    by 0x1229D8: handle_builtin (git.c:637)
> ==18232==    by 0x122BCC: run_argv (git.c:689)
> ==18232==    by 0x122D90: cmd_main (git.c:766)
> ==18232==    by 0x1D55A3: main (common-main.c:45)
> ==18232==  Address 0x4f4d844 is 0 bytes after a block of size 4 alloc'd
> ==18232==    at 0x483777F: malloc (vg_replace_malloc.c:299)
> ==18232==    by 0x3381B0: do_xmalloc (wrapper.c:60)
> ==18232==    by 0x338283: xmalloc (wrapper.c:87)
> ==18232==    by 0x2A3F8C: get_correspondences (range-diff.c:207)
> ==18232==    by 0x2A4BFB: show_range_diff (range-diff.c:427)
> ==18232==    by 0x19D453: cmd_range_diff (range-diff.c:108)
> ==18232==    by 0x122698: run_builtin (git.c:418)
> ==18232==    by 0x1229D8: handle_builtin (git.c:637)
> ==18232==    by 0x122BCC: run_argv (git.c:689)
> ==18232==    by 0x122D90: cmd_main (git.c:766)
> ==18232==    by 0x1D55A3: main (common-main.c:45)
> ==18232== 
> 
> I'm looking into why that fails.  Also adding Dscho to Cc here as the
> author of this code.

The diff below seems to fix it.  Not submitting this as a proper
patch, as I don't quite understand what the original code tried to do
here.  However this does pass all tests we currently have and fixes
the out of bounds memory read that's caught by valgrind (and that I
imagine could cause the segfault on Mac OS).

This matches how the initial minimum for the reduction transfer is
calculated in [1].

I'll try to convince myself of the right solution, but should someone
more familiar with the linear-assignment algorithm have an idea, feel
free to take this over :)

[1]: https://github.com/src-d/lapjv/blob/master/lap.h#L276

--- >8 ---

diff --git a/linear-assignment.c b/linear-assignment.c
index 9b3e56e283..ab0aa5fd41 100644
--- a/linear-assignment.c
+++ b/linear-assignment.c
@@ -51,7 +51,7 @@ void compute_assignment(int column_count, int row_count, int *cost,
 		else if (j1 < -1)
 			row2column[i] = -2 - j1;
 		else {
-			int min = COST(!j1, i) - v[!j1];
+			int min = INT_MAX;
 			for (j = 1; j < column_count; j++)
 				if (j != j1 && min > COST(j, i) - v[j])
 					min = COST(j, i) - v[j];
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 2237c7f4af..a8b0ef8c1d 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -142,4 +142,9 @@ test_expect_success 'changed message' '
 	test_cmp expected actual
 '
 
+test_expect_success 'amend and check' '
+	git commit --amend -m "new message" &&
+	git range-diff master HEAD@{1} HEAD
+'
+
 test_done

--- >8 ---
