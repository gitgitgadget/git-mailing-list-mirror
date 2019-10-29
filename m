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
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9081F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 20:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfJ2UB0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 16:01:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40244 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfJ2UBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 16:01:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so3735452wmm.5
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 13:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=rBLG35xXqJruNFIDmHcICBGEXdccLpxPtMY0//BbRgs=;
        b=OFJ6kh0DZ1+Bz6n04bwrzC7hoOuc0w6v69QNj6oHcK77I0LciTwtGuQGWuZOIhdD+a
         cS3gE3LMUQ+fPJ2HKGgKeWoSoe8XOS75+8gkT2yg50rhpOoDPN3RfujP7+ig+X5ImdfW
         iOtMQypbNFYvE9bKjuqQLsLnG6mHBBI5YaIZ6sVFctHhj8mEZX12pH2o23b1xXKEXME7
         utez9icfDnBr+SRxO2QTZptFpcu6SlRQ1uRNW55ZQY+rsChGXzzQ9/RUnJHBDAvERhOs
         zQqxWeq727cCLe3NwPwv0ksIz5sgs7NZly2sBTmxb2jDQwmk5iTxA6xH/WP5zMscxrNt
         dt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=rBLG35xXqJruNFIDmHcICBGEXdccLpxPtMY0//BbRgs=;
        b=T31ClL8oo3DWOAK9gadBmPksjvnfOdiRiPQhELcgmKSZ+ebTp5o9IvXUCI5gHrFbNJ
         kM5EBqu/Xjo6+63IJZAPkTPEHU2r7wHlOsji0Zcc/5P83rVjHdcBYq6oLRlARrD7ciDN
         byDeD9iJqIXXq1dbSwIxTHperwk5qD7spscG0lA7CdM6zAQzvnMEDp8Fd9UICQxqkS3n
         gj/wN3LVlx3hCrB06TB4HB967sjXCinlCzVNWJZ4k0EIryPBuRbxN7qz1JYPUIo70L0N
         KdPM8TQL1fQ+57nGEf41+hbtM69VbvHIdVrEwaMI5vtFG0o/FoOOZXCo7N8k0uhn1/lu
         +u/w==
X-Gm-Message-State: APjAAAU9/UWKZ7pKkSi4W7h4kM14OwOoEnHfwIffh5K1kQAKcpx/Gohh
        IIkZhNmK0qq3AxTxedNcqdxN4EQi
X-Google-Smtp-Source: APXvYqz6pIpDuNZKKHJsZ1pwODFNtRCshRPv+rwHXb//qY0vEZPsY+dR8RrE749MjVyZVpRB8X0BdA==
X-Received: by 2002:a05:600c:2317:: with SMTP id 23mr5550503wmo.140.1572379281946;
        Tue, 29 Oct 2019 13:01:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p21sm3400634wmc.25.2019.10.29.13.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 13:01:21 -0700 (PDT)
Message-Id: <pull.428.v3.git.1572379280.gitgitgadget@gmail.com>
In-Reply-To: <pull.428.v2.git.1572356272.gitgitgadget@gmail.com>
References: <pull.428.v2.git.1572356272.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Oct 2019 20:01:19 +0000
Subject: [PATCH v3 0/1]  Fix t5516 flakiness in Visual Studio builds
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Among the flaky tests, it seems that the Azure Pipeline suffers relatively
frequently from t5516 failing with the Visual Studio builds. Essentially, we
grep for an error message, but that error message is produced twice, once by
a fetch and once by the upload-pack spawned from it, and those error
messages are usually interleaved because of MSVC runtime fprintf() 
idiosyncracies.

As a consequence, I have to re-run about half a dozen failed builds a day,
which I would like to avoid. My plan is therefore to merge this patch into
Git for Windows v2.24.0-rc2.

The commit message of this patch is based, in part, on 
https://github.com/gitgitgadget/git/pull/407. 

This fixes https://github.com/gitgitgadget/git/issues/240.

Changes since v2:

 * Using write_in_full() instead of xwrite() again (to make sure that the
   entire message is printed).
 * When vsnprintf() fails, now we at least print the prefix.
 * The code to check whether prefix was too long no longer tests an
   inequality between pointers, but between sizes.

Changes since v1:

 * Changed the oneline to be more accurate (thanks Junio).
 * Improved the commit message (e.g. talking about the xwrite() function
   this patch uses, rather than the write_in_full() function used by an
   earlier iteration, thanks Gábor).
 * Revamped the actual code to account for insanely long prefixes (thanks
   for the advice, Junio).

Johannes Schindelin (1):
  vreportf(): avoid relying on stdio buffering

 usage.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-428%2Fdscho%2Ffix-t5516-flakiness-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-428/dscho/fix-t5516-flakiness-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/428

Range-diff vs v2:

 1:  e426627e14 ! 1:  fce0894ee4 vreportf(): avoid relying on stdio buffering
     @@ -16,7 +16,7 @@
          Let's avoid this predicament altogether by rendering the entire message,
          including the prefix and the trailing newline, into the buffer we
          already have (and which is still fixed size) and then write it out via
     -    `xwrite()`.
     +    `write_in_full()`.
      
          We still clip the message to at most 4095 characters.
      
     @@ -46,6 +46,7 @@
          Git Bash on Windows: in this case, `stderr` is not actually truly
          unbuffered, and needs the extra help.
      
     +    Helped-by: Jeff King <peff@peff.net>
          Helped-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
          Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
          Helped-by: Junio C Hamano <gitster@pobox.com>
     @@ -64,9 +65,9 @@
       
      -	vsnprintf(msg, sizeof(msg), err, params);
      -	for (p = msg; *p; p++) {
     -+	p = msg + off < pend ? msg + off : pend - 1;
     ++	p = off < pend - msg ? msg + off : pend - 1;
      +	if (vsnprintf(p, pend - p, err, params) < 0)
     -+		return; /* vsnprintf() failed, there is nothing we can do */
     ++		*p = '\0'; /* vsnprintf() failed, clip at prefix */
      +
      +	for (; p != pend - 1 && *p; p++) {
       		if (iscntrl(*p) && *p != '\t' && *p != '\n')
     @@ -76,7 +77,7 @@
      +
      +	*(p++) = '\n'; /* we no longer need a NUL */
      +	fflush(stderr);
     -+	xwrite(2, msg, p - msg);
     ++	write_in_full(2, msg, p - msg);
       }
       
       static NORETURN void usage_builtin(const char *err, va_list params)

-- 
gitgitgadget
