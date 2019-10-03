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
	by dcvr.yhbt.net (Postfix) with ESMTP id 429FF1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 20:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfJCUtN (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 16:49:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33402 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbfJCUtN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 16:49:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id b9so4309855wrs.0
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 13:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qTKfGY4trfoxfZdN/U8al4iElukaPF21AC8QZaTyMSc=;
        b=lbRBzmyh60MgEizzC/tEX7uL49T82I5rKAz+xSXoAnytpSHprAf4LqwqdA8JHa8twL
         ss2P7yRPKh+2ZW6s4lYckjXgE10d4g9MNFtkr0rmmwhcM8i89hTTtoDp21mfrCi226/k
         ydGGuaTROBK1iiXtXHfmnDV0lKrwczpRqvvwI9D0AS3Rmv9jpQYkf2Z4Mr0kPL6mYkjD
         n4gQ53BXhpFWaalm/CjbZUrvWcVJw1NUH/UBSrQRguncYPfiaV7EId+zVhtnpqSe+Tyd
         JCKm7/QfrPrOAAibXEqchre8FGvLwK2ztOcvvn9gVWpCfJug91RnpptFushDE5Dtle55
         iLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qTKfGY4trfoxfZdN/U8al4iElukaPF21AC8QZaTyMSc=;
        b=KSEFwwiI/uOZ6rfGYxA8bGWswFMdRVWJ8hgJAMMB7RHhao3zHBt7Mz5ox9UFhJUO39
         kFuNWm8tv/FJIpp1U7hjPExym0rt0YOVurF9bbqTIZQFrbbc2IF0539+Xuy64ZWL8xjQ
         F7xsMp+r69m5zBY2dyLeandeRYWhMojPonDgu0uzd3TAciVQ1aRaxDZAmNudrzNoctS2
         TN8T07xY+JdvztbSUsjgcjGCvu1n+FruuYJ/nODrqFSgvHfrbHevlyx0p0A8ZAPoYd47
         Y5al+bNBwmCEhjSm26AyNRbozyYlVDMXZLAY1tP7qE7GXhV9rQJzPfIqP55P3qW+y8Ip
         8Cvg==
X-Gm-Message-State: APjAAAXc5iWL8jIFrVlatfcsHDSxhFlnxSMMj8u6UMbDYQTK0tKa5Y7T
        CXv43LDJQmucCKV10bJILhx0Xejc
X-Google-Smtp-Source: APXvYqy1WvMZbEIourZ1tzvdX4O3zqVblNul22kOg4splzL0RaRlTfu/U1AlPJ9nXXeoKHnpk+gyyw==
X-Received: by 2002:adf:9c93:: with SMTP id d19mr7178358wre.383.1570135750683;
        Thu, 03 Oct 2019 13:49:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 33sm5875268wra.41.2019.10.03.13.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 13:49:10 -0700 (PDT)
Date:   Thu, 03 Oct 2019 13:49:10 -0700 (PDT)
X-Google-Original-Date: Thu, 03 Oct 2019 20:49:08 GMT
Message-Id: <5594c953f0901f3f5643fc8003c37e37ea7221e7.1570135749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.375.git.gitgitgadget@gmail.com>
References: <pull.375.git.gitgitgadget@gmail.com>
From:   "Arash Bannazadeh-Mahani via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] gitk: Addressing error running on MacOS with large repos.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Arash <axbannaz@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Arash Bannazadeh-Mahani <axbannaz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Arash Bannazadeh-Mahani <axbannaz@gmail.com>

The change is stemmed from a problem on the MacOS where, if --all
is passed to gitk it should show all the refs/commits graphically.
However, on really large git repos, in my instance a git repo with
over 52,000 commits, gitk will report an error,
"Error executing git log: couldn't execute "git": argument list too long".
Mac OS has a limit of which my large repo exceeds. This works fine on Linux,
however, not sure about Windows.

Looking at gitk script, the decision to have all commit-ids on the command line
comes from return value of parseviewargs() function which uses the value of
"allknown" to return. If it is '1' then --all is translated to a string of all
the commit-ids in the repo, otherwise --all is passed as-is to `git log` cli,
which according to git-log man page it is the same as listing all the
commit-ids.

So, this change is to prevent --all option from being expanded into list
of all refs on the command line.

Signed-off-by: Arash Bannazadeh-Mahani <axbannaz@gmail.com>
---
 gitk-git/gitk | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index abe4805ade..96634d9d33 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -250,8 +250,13 @@ proc parseviewargs {n arglist} {
 		set nextisval 1
 		lappend glflags $arg
 	    }
-	    "--not" - "--all" {
+	    "--not" {
 		lappend revargs $arg
+	    }
+		"--all" {
+		# we recognize this argument;
+		# no expansion needed, use it with 'git log' as-is
+		set allknown 0
 	    }
 	    "--merge" {
 		set vmergeonly($n) 1
-- 
gitgitgadget
