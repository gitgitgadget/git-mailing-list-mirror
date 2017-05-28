Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 389511FD09
	for <e@80x24.org>; Sun, 28 May 2017 16:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750814AbdE1Q53 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 12:57:29 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33995 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbdE1Q52 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 12:57:28 -0400
Received: by mail-pf0-f195.google.com with SMTP id w69so9785840pfk.1
        for <git@vger.kernel.org>; Sun, 28 May 2017 09:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f7OaaxSqjcWAUTozxskI5XKDuRE+lTqPz4lUIw5eXiA=;
        b=hE/9OreG41OvHBx075Azp+SI69LN9aMorosjerytwv/NQrYrYeMK+hskIv8YSsx1JD
         OpW0ejBIvSo910eRq4KLWFgJhLtkdQIN2y5vV7c1uBwkLKunJvWNMdOkiuNQ6/imMwVr
         48TU7MBXSCMcG+ppji0gErNYVkdW57ysRZSLig1iUvZMh8WAGaVXym2obzTC/gTK0EgL
         3IZYbGpzPSBQ5r5xLfvwcBXYQzuBjYbqxIoY2f+zc6jWyvg+ETRzZI02QijjXDNWj/DZ
         a4M+E/1ODf/iBtWCJw42bnI1qcqD1Y9yXE7toCkYB7xExkAlJIBIDtbIZaa62QmLSyiE
         zRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f7OaaxSqjcWAUTozxskI5XKDuRE+lTqPz4lUIw5eXiA=;
        b=F2qpK9YP1FhK/CEMocxAH1EDpA6p3UpzKD7CMHVI4BFlwD2/aj7toZ2qr2nlOnXG+u
         akSzQVF+1W8Md6dSbGp99TomAoW7NfnPvhuJpjaG4q1JMiBAHePAdNvBaxmctPNxRk/L
         dXlJtfeyDHbkGIyT/KI6yGSowX4mCl668rpMAS5GmmK1HtVbr9SNWLm6xFNEl9+zBgLJ
         Isdwzegk/uMPrV7StwH9Lzpaa92XqlSgxJde6ecWM/XiIKoA/YW9R+OJvBqvwZ5gcvg/
         D5RjQ69TtdPYDJ1axnXV7hhp0t6AYnI5UfyJR26oR3SIY0w+27mssXSImj1ghYPkEsKm
         gg0w==
X-Gm-Message-State: AODbwcDhyPEaHE5UlCnSUb37WE4sO41GyKz3anRIsBOCe20HlTZ+nZjz
        bAD0OFCQlAYEuESV
X-Received: by 10.84.231.141 with SMTP id g13mr26836225plk.157.1495990648072;
        Sun, 28 May 2017 09:57:28 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id w67sm12511824pfi.2.2017.05.28.09.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 May 2017 09:57:27 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     git@vger.kernel.org, t.gummerer@gmail.com, peff@peff.net,
        Johannes.Schindelin@gmx.de
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v3 1/4] stash: add test for stash create with no files
Date:   Sun, 28 May 2017 09:56:39 -0700
Message-Id: <20170528165642.14699-2-joel@teichroeb.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170528165642.14699-1-joel@teichroeb.net>
References: <20170528165642.14699-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ensure the command gives the correct return code

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 t/t3903-stash.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 3b4bed5c9a..aaae221304 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -444,6 +444,14 @@ test_expect_failure 'stash file to directory' '
 	test foo = "$(cat file/file)"
 '
 
+test_expect_success 'stash create - no changes' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	git reset --hard &&
+	git stash create > actual &&
+	test $(cat actual | wc -l) -eq 0
+'
+
 test_expect_success 'stash branch - no stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
-- 
2.13.0

