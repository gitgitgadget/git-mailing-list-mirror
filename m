Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 064971F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 08:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfDWIyC (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 04:54:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38634 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWIyC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 04:54:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so7262532pgl.5
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 01:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=edS0/w9kqCKhoefxLNmTwht+sSOhW/i7QMD6DcixPO0=;
        b=qIjT5m1csQ2n1mvTnYbs5zHMlmiDnwKq8ydM5rVA5LkLn79higGcLbPhmQ173NGhkI
         hLUSxJGXxEzbLZTjrWiRXUqfSbwSryQHI2VXVBQReANmm6zPhgKjpTDTP2SkIE4sF1YV
         /quwGMtppemWcWMbUkLfCa+pk0MRZLxrZOrixJvdvTInTYm8zwtfsIewco4q+sUPEwKr
         y2cA2PKfElV38QOHLG4LmJU0PgNT/NHDZGk4Ro0ytg0+ticEn29SHEiiaESOXZBAa2xY
         cwzSDveZm0R4mLyuDm91VxtJRnM2FYeh8LY+bISYYDYNWTO5Cdyy11n7YDi8UROzJMIJ
         NEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=edS0/w9kqCKhoefxLNmTwht+sSOhW/i7QMD6DcixPO0=;
        b=bOb4wwkPiLYOxWxF8d3MTavRBiLPOVkNIA36+/Ub+rxcZ5bNWyTDOGc43yxCHNUlLL
         D+Xr047N5aH9oQ3sUG2OcJdrNC8E3Jq1eouu3i/suYbkIlFAn46u0DFw+yY5xyJqvkpw
         nvprhe3irbTSJKG+hTS6EMr/I5cNUd1QI4QU9bPRwkG4VY9xdLHvPGkUnlcwoZ3c+2Bh
         1Jt19QS9hbsm3redwak9ujpi+bXyV9GkuS+QSjk/1CuUiEcsdO3n9fJT/SYLNjy0IST2
         n5JJkqW5zI/m6x/I9njnUe53wS6ewSIb9eGEy1hgKEd6usMMMgQh+zmSNfPd98UCtsWU
         YmcQ==
X-Gm-Message-State: APjAAAUTDlDfISzYlGcV7+WRf5kT5bmS317FwG+wzo05BbGrsOQf2wKs
        08ZY7mZoS0ElKKlKAlau4R6vIJXm
X-Google-Smtp-Source: APXvYqwXYCTDXsRJPF0j7ZEQSBL3cMFDKBQq5Tde8jDImyUgsncBqSgNFCvQV9ia8yMG95ZSErv6tA==
X-Received: by 2002:a63:82c6:: with SMTP id w189mr3107737pgd.444.1556009641099;
        Tue, 23 Apr 2019 01:54:01 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id p20sm12803366pgj.86.2019.04.23.01.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 01:54:00 -0700 (PDT)
Date:   Tue, 23 Apr 2019 01:53:58 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/5] t7610: add mergetool --gui tests
Message-ID: <678f9b11fc7df7d3ee2050388574bcaea86af331.1556009181.git.liu.denton@gmail.com>
References: <cover.1555880168.git.liu.denton@gmail.com>
 <cover.1556009181.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556009181.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 063f2bdbf7 (mergetool: accept -g/--[no-]gui as arguments,
2018-10-24), mergetool was taught the --gui option but no tests were
added to ensure that it was working properly. Add a test to ensure that
it works.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7610-mergetool.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index a9fb971615..5f37d7a1ff 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -145,6 +145,28 @@ test_expect_success 'custom mergetool' '
 	git commit -m "branch1 resolved with mergetool"
 '
 
+test_expect_success 'gui mergetool' '
+	test_config merge.guitool myguitool &&
+	test_config mergetool.myguitool.cmd "(printf \"gui \" && cat \"\$REMOTE\") >\"\$MERGED\"" &&
+	test_config mergetool.myguitool.trustExitCode true &&
+	test_when_finished "git reset --hard" &&
+	git checkout -b test$test_count branch1 &&
+	git submodule update -N &&
+	test_must_fail git merge master >/dev/null 2>&1 &&
+	( yes "" | git mergetool --gui both >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool -g file1 file1 ) &&
+	( yes "" | git mergetool --gui file2 "spaced name" >/dev/null 2>&1 ) &&
+	( yes "" | git mergetool --gui subdir/file3 >/dev/null 2>&1 ) &&
+	( yes "d" | git mergetool --gui file11 >/dev/null 2>&1 ) &&
+	( yes "d" | git mergetool --gui file12 >/dev/null 2>&1 ) &&
+	( yes "l" | git mergetool --gui submod >/dev/null 2>&1 ) &&
+	test "$(cat file1)" = "gui master updated" &&
+	test "$(cat file2)" = "gui master new" &&
+	test "$(cat subdir/file3)" = "gui master new sub" &&
+	test "$(cat submod/bar)" = "branch1 submodule" &&
+	git commit -m "branch1 resolved with mergetool"
+'
+
 test_expect_success 'mergetool crlf' '
 	test_when_finished "git reset --hard" &&
 	# This test_config line must go after the above reset line so that
-- 
2.21.0.1000.g11cd861522

