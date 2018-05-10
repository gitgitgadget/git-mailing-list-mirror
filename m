Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA3081F406
	for <e@80x24.org>; Thu, 10 May 2018 20:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbeEJUqR (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 16:46:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52470 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeEJUqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 16:46:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id w194-v6so5859911wmf.2
        for <git@vger.kernel.org>; Thu, 10 May 2018 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GyT7BIMvfDWQUrt7pnYPyqVKQqTJf4Oevmyi50ETyrY=;
        b=DVqQOwuVeF7+t2J2RRsX3yMcddcJYalG6/drNNNzKd9EgOqEfgGkVKV63kvZYyzLyF
         mhpyPrANW/GOch1lqQZDQQcoeupBydkIE+RpB/8aHMj/CrbVUwyp6vdQafHaezyO6LBa
         cOA1xUqhzgcrkHS4VUcbKG18IjUdAfO6jwnZpAiIC4IBciqsvVzJvxpwEGE5+R9pjNxR
         p2paxUjnIrEQjDfmaViRJpenl17+GVjIdObfSMi2IzZIOO9ChQHJAZEg20hkH65WE0/0
         oa0DKnkfWJ0ctyLQvEjsrtGxnUFkV27/ZpVoVT0FUgueyjrM6eGct8wr12nQPWw8du0c
         Xd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GyT7BIMvfDWQUrt7pnYPyqVKQqTJf4Oevmyi50ETyrY=;
        b=lckm0/NOdH26miaKcVSlu6CKVyddynsflp+H6cwmTNH1I9u79U85LOj2cfVJPB9MmE
         pYf1xeEMIIN8BC0kVMK+EaJANSviSr/Gp02O1jRbhZ2jEnIkTAUTuQMkBttmFhJhGhCs
         M7hiihjptyCC+gox9UOmfeE/XWBd8HkKVn7UsFp40Eup5xwrDmkCL8rb7cx/Wx2jM2Q8
         nmmJisOYIhEBVsnLGbvxB1Gras7ENpNHG3pq7IU9U8GYNDIGP6+Vf9PLJszmpS9OnEbn
         2XY86LVnATXxGQqwTi6ALgEZosd3QQVU1wU12heIkpebmf9rhe4XsTRy6Oz9xOwzaWob
         FVbg==
X-Gm-Message-State: ALKqPwcFjXCMiw3JFLwth6LMFXUvB9zEq5EDXnW2VaJXH9LMO2xrCRSh
        MSNNAhZx/J8pCoGLeg1maaw=
X-Google-Smtp-Source: AB8JxZpVBdDX6JhwmpYQn5vl+0NvBKF5IgdHBi7BfJ6Bk0scfAnCaOAuin+fEHq9mJaZEsXhJC4hAQ==
X-Received: by 2002:a1c:455d:: with SMTP id s90-v6mr249854wma.156.1525985175143;
        Thu, 10 May 2018 13:46:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id q15-v6sm1489063wmf.11.2018.05.10.13.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 May 2018 13:46:14 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 00/12] Integrate commit-graph into fsck, gc, and fetch
Date:   Thu, 10 May 2018 22:45:57 +0200
Message-Id: <20180510204557.16361-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 May 2018 at 21:22, Stefan Beller <sbeller@google.com> wrote:
> On Thu, May 10, 2018 at 12:05 PM, Martin Ågren <martin.agren@gmail.com> wrote:

>> I hope to find time to do some more hands-on testing of this to see that
>> errors actually do get caught.

> Packfiles and loose objects are primary data, which means that those
> need a more advanced way to diagnose and repair them, so I would imagine
> the commit graph fsck is closer to bitmaps fsck, which I would have suspected
> to be found in t5310, but a quick read doesn't reveal many tests that are
> checking for integrity. So I guess the test coverage here is ok, (although we
> should always ask for more)

Since I'm wrapping up for today, I'm posting some simple tests that I
assembled. The last of these showcases one or two problems with the
current error-reporting. Depending on the error, there can be *lots* of
errors reported and there are no new-lines, so the result on stdout can
be a wall of not-very-legible text.

Some of these might not make sense. I just started going through the
documentation on the format, causing some sort of corruption in each
field. Maybe this can be helpful somehow.

Martin

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 82f95eb11f..a7e48db2de 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -255,4 +255,49 @@ test_expect_success 'git fsck (checks commit-graph)' '
 	git fsck
 '
 
+# usage: corrupt_data <file> <pos> [<data>]
+corrupt_data() {
+	file=$1
+	pos=$2
+	data="${3:-\0}"
+	printf "$data" | dd of="$file" bs=1 seek="$pos" conv=notrunc
+}
+
+test_expect_success 'detect bad signature' '
+	cd "$TRASH_DIRECTORY/full" &&
+	cp $objdir/info/commit-graph commit-graph-backup &&
+	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
+	corrupt_data $objdir/info/commit-graph 0 "\0" &&
+	test_must_fail git commit-graph verify 2>err &&
+	grep "graph signature" err
+'
+
+test_expect_success 'detect bad version number' '
+	cd "$TRASH_DIRECTORY/full" &&
+	cp $objdir/info/commit-graph commit-graph-backup &&
+	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
+	corrupt_data $objdir/info/commit-graph 4 "\02" &&
+	test_must_fail git commit-graph verify 2>err &&
+	grep "graph version" err
+'
+
+test_expect_success 'detect bad hash version' '
+	cd "$TRASH_DIRECTORY/full" &&
+	cp $objdir/info/commit-graph commit-graph-backup &&
+	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
+	corrupt_data $objdir/info/commit-graph 5 "\02" &&
+	test_must_fail git commit-graph verify 2>err &&
+	grep "hash version" err
+'
+
+test_expect_success 'detect too small chunk-count' '
+	cd "$TRASH_DIRECTORY/full" &&
+	cp $objdir/info/commit-graph commit-graph-backup &&
+	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
+	corrupt_data $objdir/info/commit-graph 6 "\01" &&
+	test_must_fail git commit-graph verify 2>err &&
+	cat err
+'
+
+
 test_done
-- 
2.17.0

