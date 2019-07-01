Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39FE61F461
	for <e@80x24.org>; Mon,  1 Jul 2019 08:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfGAIgH (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 04:36:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37020 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfGAIgG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 04:36:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14so12769871wrr.4
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 01:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GCU+DlRG8wQTtxuZjaFle0TxmtFM8lijxnhb3OPYogY=;
        b=gRTiDZsuu4+V7uB9Dbxb7DoFtpDbdFvl0V5BUd/MVykYTPwcS6HnONhzYKAK92B8S1
         iggMiGyV6P2LSktSXUmvdoP60haeddIq7l4yBUDeF1rlLmCFNu+gjy7LsvRPfbIuUZBW
         huAO2sUlDW2FZxtPnE9Mr0ib/G+crHjv5su5Rc/jVOon6edabbz/f9BBsjivRN+67J5k
         gPKm6fkocHqtZqVff3B3lv0yZHo5HOwFPku9eIvg+PUGZsAXeqaTcswIruSU00X5aYTW
         QmDOIa9Vg8JNvmRyzWHrLEGHLAy6fOE5VNybgstKO/4snvY5eaV5rqYXuY7tKqN5oMVh
         q14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GCU+DlRG8wQTtxuZjaFle0TxmtFM8lijxnhb3OPYogY=;
        b=p2eDNHWpzCC6kF7g7dJEy/nQpIs87le7clU9hnAWouIV7kCewGje7D9TTIxnnXmZwJ
         QNjuy8TVsUeqyQqZFE4xyNx/YjAoMVm8OpyafyeGz5n4tjkByDZddG/USx2mVvptL4k/
         VsXsWlKOesidR2lOYRv9al2sYT4RzXS7IzRH9EJPFY8zFCeR2lc+iBfQtwUAJq5fab6E
         LpGD36D0iHJVGpfdsQssejpC8gX07sbIb0CtYDM/44vVoXt5Ag5POlxXASfJsVABICyQ
         QAzBjHdBZ2ZMcchd/8Gopr+DJquyzw9nOi2PAXqW5sEXXEREZK5ZORqtsxtpmiIPG+f1
         fitg==
X-Gm-Message-State: APjAAAWoftS+8RM+m+pNWWO2bq3eG/EbDgxA3xNx8DffDT03wubgCz45
        nncJTBfTJoa3/PMFCZl8s1o=
X-Google-Smtp-Source: APXvYqzqz+W4CKchAUo8C6jH/nkli3BQdMHxhTBtYinhdTAV5yiZEA+wzF7MCXPdQI549psoJCQMRg==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr16883971wrv.224.1561970164870;
        Mon, 01 Jul 2019 01:36:04 -0700 (PDT)
Received: from szeder.dev (x4db347f2.dyn.telefonica.de. [77.179.71.242])
        by smtp.gmail.com with ESMTPSA id u18sm12872554wmd.19.2019.07.01.01.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 01:36:03 -0700 (PDT)
Date:   Mon, 1 Jul 2019 10:36:01 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5319: don't trip over a user name with whitespace
Message-ID: <20190701083601.GJ21574@szeder.dev>
References: <pull.261.git.gitgitgadget@gmail.com>
 <d4a3f56b-5eaa-1325-f8c1-be6797a9ac03@kdbg.org>
 <CAPig+cRpOHRgtCXXiqAZtmEtkWnMy7=4GsTVv0XB9R3fF0-66A@mail.gmail.com>
 <1a5bb5f9-e090-7f42-ec3f-cd74bcad831f@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a5bb5f9-e090-7f42-ec3f-cd74bcad831f@kdbg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 30, 2019 at 10:59:34PM +0200, Johannes Sixt wrote:
> Am 30.06.19 um 21:48 schrieb Eric Sunshine:
> > On Sun, Jun 30, 2019 at 2:57 PM Johannes Sixt <j6t@kdbg.org> wrote:
> >> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> >> @@ -443,7 +443,7 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
> >> -               MINSIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 1) &&
> >> +               MINSIZE=$(stat -c %s .git/objects/pack/*pack | sort -n | head -n 1) &&
> > 
> > Unfortunately, this is not portable. While "stat -c %s" works on Linux
> > and MSYS2, neither that option nor the format directive are recognized
> > on BSD-like platforms (I tested Mac OS and FreeBSD), which instead
> > need "stat -f %z".
> 
> Ouch! I did notice that stat(1) is not in POSIX, but hoped that it was
> sufficiently portable. I need a new idea...

'wc -c' perhaps?  We already use it in a couple of places in the test
suite to get file size.

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 79bfaeafa9..ddba862114 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -443,7 +443,7 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
 		touch -m -t 201901010002 .git/objects/pack/pack-B* &&
 		touch -m -t 201901010003 .git/objects/pack/pack-A* &&
 		ls .git/objects/pack >expect &&
-		MINSIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 1) &&
+		MINSIZE=$(wc -c .git/objects/pack/*pack | sort -n | sed -n -e "s/^ *//" -e "1 s/[^ ]*$//p") &&
 		git multi-pack-index repack --batch-size=$MINSIZE &&
 		ls .git/objects/pack >actual &&
 		test_cmp expect actual
@@ -455,7 +455,7 @@ test_expect_success 'repack creates a new pack' '
 		cd dup &&
 		ls .git/objects/pack/*idx >idx-list &&
 		test_line_count = 5 idx-list &&
-		THIRD_SMALLEST_SIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 3 | tail -n 1) &&
+		THIRD_SMALLEST_SIZE=$(wc -c .git/objects/pack/*pack | sort -n | sed -n -e "s/^ *//" -e "3 s/[^ ]*$//p") &&
 		BATCH_SIZE=$(($THIRD_SMALLEST_SIZE + 1)) &&
 		git multi-pack-index repack --batch-size=$BATCH_SIZE &&
 		ls .git/objects/pack/*idx >idx-list &&

Note that 'wc -c' prints the numbers in its output left padded, hence
the 'sed "s/^ *//"' above, and once 'sed' is already up and running,
it might as well take over the role of that 'head -n 3 | tail -n 1'.

