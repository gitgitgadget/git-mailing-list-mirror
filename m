Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622B51F51C
	for <e@80x24.org>; Thu, 17 May 2018 19:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeEQTrE (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 15:47:04 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33728 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeEQTrE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 15:47:04 -0400
Received: by mail-pg0-f67.google.com with SMTP id v7-v6so2283459pgs.0
        for <git@vger.kernel.org>; Thu, 17 May 2018 12:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fz7JXxj2KJkDguOPU19f0MqZE8EUmcMfd4ewbdWZOSM=;
        b=AemrouNMGDCh1Kh3X92sZOT4Z1EyDvAtKbjMMi5IjDaMfAJTFyOzOLuQejIbcYCCUK
         /zIVzSMxdlRUvmgL/PHNGkJ3s8v8F9ipLBK0fdXaCU0WQ4htaGC14zDVUlLPBCkr7dcC
         ujd5eyMJpD/5RqCWP2WJWFSGkOHxcz9MMo4MMdtZ4h8emXI9PqgItRRUZqq5guHmR8RA
         JHrnApAMni25+cCetiiuWT2rNEt9VA/E18t4afRznW9Acn7rCBGZJiwayYNU5dxqzZDv
         4ZgE8ovS/gsDsDIY9hnIq6dJ85QL5UuQbQ0Gy0GKpo26Dl0Si0QdFx48cPsef58hL7/Y
         IdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fz7JXxj2KJkDguOPU19f0MqZE8EUmcMfd4ewbdWZOSM=;
        b=rxhL+rKk02CE9/otd8/unK31eX+Th6PMMxx7AhwS+yfOmpo0RD5pvEoSfaiMyJj739
         tzQT+6VsdiEp4dGznPDmXgPqhV6jpiEUwRmvSpy/XTmh1XpJNDB/LQZUW+yZOi4H2gRr
         NWR1nvgeyscNDlDCbUYBhwOFqN1qk6D1+f9soiYtPpHwWeQuMpz2FeomyBcU/zcsTb1U
         sWD+4C8YzEruPQI54XeOveGg5j4BbVkhGzhDOlJBcPaDIk3OUGGayZ59CR77i5T6Fza4
         //1mWvy546bJyWFwSNZOYyNw2aaWYp7xv9O2mxLcddpMAP4b2/5PNilk4NWWbSB0JR6D
         sCxw==
X-Gm-Message-State: ALKqPwcsuYRYvhREpc+GXRVieQvd+q56rQ1Cz78+igLmTNVU9oORZdmh
        dlVtbP/8RmCwGXEYqLeI9/a+g9BlNBU=
X-Google-Smtp-Source: AB8JxZqZVKi++bx1XNtbclyDFecEaOUlBKClhdcc6azJXAEupoMhtsdt3YdJIVhSsFXLl7RjkV0V0w==
X-Received: by 2002:a65:648a:: with SMTP id e10-v6mr5088007pgv.34.1526586423056;
        Thu, 17 May 2018 12:47:03 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id m14-v6sm9482220pgs.72.2018.05.17.12.47.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 12:47:02 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com
Subject: [PATCH 0/8] Reroll of sb/diff-color-move-more
Date:   Thu, 17 May 2018 12:46:45 -0700
Message-Id: <20180517194653.48928-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
References: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> * sb/diff-color-move-more (2018-04-25) 7 commits
>...
>>
>>  Will merge to 'next'.
>
>I did not get around to fix it up, there are still review
>comments outstanding. (The test is broken in the last commit.)

This is a reroll of sb/diff-color-move-more, with the test fixed as well
as another extra patch, that would have caught the bad test. 

The range diff is below.

Thanks,
Stefan

Stefan Beller (8):
  xdiff/xdiff.h: remove unused flags
  xdiff/xdiffi.c: remove unneeded function declarations
  diff.c: do not pass diff options as keydata to hashmap
  diff.c: adjust hash function signature to match hashmap expectation
  diff.c: add a blocks mode for moved code detection
  diff.c: decouple white space treatment from move detection algorithm
  diff.c: add --color-moved-ignore-space-delta option
  diff: color-moved white space handling options imply color-moved

 Documentation/diff-options.txt |  25 ++++-
 diff.c                         | 138 +++++++++++++++++++----
 diff.h                         |   8 +-
 t/t4015-diff-whitespace.sh     | 197 +++++++++++++++++++++++++++++++--
 xdiff/xdiff.h                  |   8 --
 xdiff/xdiffi.c                 |  17 ---
 6 files changed, 336 insertions(+), 57 deletions(-)

-- 
2.17.0.582.gccdcbd54c44.dirty

1:  a7a7af6b76b = 1:  a7a7af6b76b xdiff/xdiff.h: remove unused flags
2:  a7b6aaf7bc0 = 2:  a7b6aaf7bc0 xdiff/xdiffi.c: remove unneeded function declarations
3:  d9e57cc6b05 = 3:  d9e57cc6b05 diff.c: do not pass diff options as keydata to hashmap
4:  87111ba726d = 4:  87111ba726d diff.c: adjust hash function signature to match hashmap expectation
5:  9559b8cb456 = 5:  9559b8cb456 diff.c: add a blocks mode for moved code detection
6:  41a70464209 = 6:  41a70464209 diff.c: decouple white space treatment from move detection algorithm
7:  c0114b2ce56 ! 7:  72bb8213cab diff.c: add --color-moved-ignore-space-delta option
    @@ -6,7 +6,6 @@
         changes uniformly.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
     --- a/Documentation/diff-options.txt
    @@ -237,7 +236,7 @@
     +	not adjust
     +	EOF
     +
    -+	git diff --color --color-moved-ignore-space-prefix-delta |
    ++	git diff --color --color-moved --color-moved-ignore-space-prefix-delta |
     +		grep -v "index" |
     +		test_decode_color >actual &&
     +
    @@ -246,20 +245,20 @@
     +		<BOLD>--- a/text.txt<RESET>
     +		<BOLD>+++ b/text.txt<RESET>
     +		<CYAN>@@ -1,7 +1,7 @@<RESET>
    -+		<RED>-QIndented<RESET>
    -+		<RED>-QText across<RESET>
    -+		<RED>-Qthree lines<RESET>
    ++		<BOLD;MAGENTA>-QIndented<RESET>
    ++		<BOLD;MAGENTA>-QText across<RESET>
    ++		<BOLD;MAGENTA>-Qthree lines<RESET>
     +		<RED>-QBut! <- this stands out<RESET>
    -+		<RED>-Qthis one<RESET>
    -+		<RED>-QQline did<RESET>
    -+		<RED>-Qnot adjust<RESET>
    -+		<GREEN>+<RESET>QQ<GREEN>Indented<RESET>
    -+		<GREEN>+<RESET>QQ<GREEN>Text across<RESET>
    -+		<GREEN>+<RESET>QQ<GREEN>three lines<RESET>
    ++		<BOLD;MAGENTA>-Qthis one<RESET>
    ++		<BOLD;MAGENTA>-QQline did<RESET>
    ++		<BOLD;MAGENTA>-Qnot adjust<RESET>
    ++		<BOLD;YELLOW>+<RESET>QQ<BOLD;YELLOW>Indented<RESET>
    ++		<BOLD;YELLOW>+<RESET>QQ<BOLD;YELLOW>Text across<RESET>
    ++		<BOLD;YELLOW>+<RESET>QQ<BOLD;YELLOW>three lines<RESET>
     +		<GREEN>+<RESET>QQQ<GREEN>But! <- this stands out<RESET>
    -+		<GREEN>+<RESET><GREEN>this one<RESET>
    -+		<GREEN>+<RESET>Q<GREEN>line did<RESET>
    -+		<GREEN>+<RESET><GREEN>not adjust<RESET>
    ++		<BOLD;YELLOW>+<RESET><BOLD;YELLOW>this one<RESET>
    ++		<BOLD;YELLOW>+<RESET>Q<BOLD;YELLOW>line did<RESET>
    ++		<BOLD;YELLOW>+<RESET><BOLD;YELLOW>not adjust<RESET>
     +	EOF
     +
     +	test_cmp expected actual
-:  ----------- > 8:  9e0508c8381 diff: color-moved white space handling options imply color-moved
