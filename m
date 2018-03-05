Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 403EC1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 18:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeCEShx (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 13:37:53 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36424 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbeCEShw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 13:37:52 -0500
Received: by mail-wr0-f194.google.com with SMTP id v111so18343444wrb.3
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 10:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=kISfl28iGGbkgOiFb4A+EW+NR1A74ccqvHbCX2l9EB8=;
        b=YDPItLSo4eqH0Thz/1KS/5LF/SOwUJ/uQ1ctPN2vhMh9tl+KJpCZ4XQracBDzqxug0
         ziJYW4+KpgoHHMxSukBa87QyElnQJZayiyJ4lK7Boinem+uHd2D6IZ7Vc8Q6Z7D1vw/X
         E215QdMvPhoyqW+ql6xUW5AtYIThkIoG66wi1wAji7cqIV44Lpye+6vXo0kzRgCJafsU
         3dVpzxNNVD2gxiZrHHGjfc+uu8krYg/E8mlfGjNnSUQx0ATB+OrE+0CKFDLcXibgwBtF
         vS/meGvDR1yDMJ5+DAPrpHTEFmZYzh6liTFN5UbiFOMagnCvV4BXZysRFQ7Gz8AQ0sD2
         /nTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=kISfl28iGGbkgOiFb4A+EW+NR1A74ccqvHbCX2l9EB8=;
        b=ATTxAuA29u6GO3PZLpkFJfk+ZMxgxwD4LUcoJclg1uQoR08/Bcvpn1x23i4HTaT4RL
         hPwlJWqx7/VzL0sehIKcRl3LCEZsuLRYq+7BFOitMU6pZVUVb9MnupOyW1HLmYsnxr3r
         iw6ky+YWHKoiEQVM12YpLTPkc4TQu1/tkvd6HHVHU9XLtDCWfU1yo5/1hpqSwcTny7z9
         EE7cky/Dvh4KFHURFjQl+lZ1t9JOT4ku5MTgaWyJljI7h7tp4ZmNoqe9nixckvqgpSWE
         vF/JWNu7xk03gOj+y3JAj10l8LhK7ttrZ0T4hrHnleQiOGLNtyphJus69dR/H86rb/mT
         gxUg==
X-Gm-Message-State: APf1xPAowBh3UhunbX1XbZJOKTwGCjHBU2rqdYOehHmR52hM21BSyojx
        g0CGfnVLJwwqb0B4te1oyyQ=
X-Google-Smtp-Source: AG47ELsgPPiWe9jHvndhgX8El78wCJHJf7vWT1rPakeqtKRidyUVQccNLaVlqL+V0C8AdmW/+QDueA==
X-Received: by 10.223.187.147 with SMTP id q19mr12722756wrg.150.1520275070996;
        Mon, 05 Mar 2018 10:37:50 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d27sm17042002wrd.60.2018.03.05.10.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 10:37:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] t2028: fix minor error and issues in newly-added "worktree move" tests
References: <20180212094940.23834-1-pclouds@gmail.com>
        <20180304052647.26614-1-sunshine@sunshineco.com>
        <20180305124848.7272-1-szeder.dev@gmail.com>
Date:   Mon, 05 Mar 2018 10:37:49 -0800
In-Reply-To: <20180305124848.7272-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Mon, 5 Mar 2018 13:48:48 +0100")
Message-ID: <xmqqh8pu9xmq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> There is one more issue in these tests.
> ...
> The main purpose of this test script is to test the 'git worktree'
> command, but these pipes hide its exit code.
> Could you please save 'git worktree's output into an intermediate
> file, and run 'grep' on the file's contents?

Here is what I tentatively came up with, while deciding what should
be queued based on Eric's patch, as a possible squash/fixup.

 t/t2028-worktree-move.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index d70d13dabe..1c391f370e 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -7,7 +7,8 @@ test_description='test git worktree move, remove, lock and unlock'
 test_expect_success 'setup' '
 	test_commit init &&
 	git worktree add source &&
-	git worktree list --porcelain | grep "^worktree" >actual &&
+	git worktree list --porcelain >out &&
+	grep "^worktree" out >actual &&
 	cat <<-EOF >expected &&
 	worktree $(pwd)
 	worktree $(pwd)/source
@@ -74,8 +75,10 @@ test_expect_success 'move worktree' '
 	toplevel="$(pwd)" &&
 	git worktree move source destination &&
 	test_path_is_missing source &&
-	git worktree list --porcelain | grep "^worktree.*/destination" &&
-	! git worktree list --porcelain | grep "^worktree.*/source" &&
+	git worktree list --porcelain >out &&
+	grep "^worktree.*/destination" out &&
+	git worktree list --porcelain >out &&
+	! grep "^worktree.*/source" out &&
 	git -C destination log --format=%s >actual2 &&
 	echo init >expected2 &&
 	test_cmp expected2 actual2
@@ -90,7 +93,8 @@ test_expect_success 'move worktree to another dir' '
 	git worktree move destination some-dir &&
 	test_when_finished "git worktree move some-dir/destination destination" &&
 	test_path_is_missing destination &&
-	git worktree list --porcelain | grep "^worktree.*/some-dir/destination" &&
+	git worktree list --porcelain >out &&
+	grep "^worktree.*/some-dir/destination" out &&
 	git -C some-dir/destination log --format=%s >actual2 &&
 	echo init >expected2 &&
 	test_cmp expected2 actual2
