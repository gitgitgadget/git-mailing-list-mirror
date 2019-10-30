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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E6721F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 10:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfJ3Kok (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 06:44:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34772 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfJ3Koj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 06:44:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so1735100wrr.1
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Ofk+2c7NHOJDvYO3Z8GABLj7RuUWUeE4S4aTjz+hpqI=;
        b=EsgG3suX3tc09FgIJbc10gQBvOAu7WTDMnsPnYLV65DbC3W3DE5l4hbVtqyKVbszRR
         TCMu+jw8TA+cFe3vRUtivxhunSMpCwRAcYXKnph537PZf3Y3lko30yLWTunxiGZcfqDO
         WnBLg1LydEBYdfXYvWLUFWbSAxYjqCQiLlO7fm0pkLhIE7J2M8mKoC1QyhTGIcdTQs5J
         K1L3exKwAKsbn70A5jdCmlBIFQ+v8IkSo73E4EvUIDAIg8zKteqctiqwT45LJ7atrg+X
         IHcte8WMe1aZgYayIeSxkaNbZXQ8cLYkcVoD++WVBLu3VwKG7QZYYvPDnAM+P0cSh9x8
         0fcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Ofk+2c7NHOJDvYO3Z8GABLj7RuUWUeE4S4aTjz+hpqI=;
        b=UO5uM88k1VAuZ8WDLdPhOKVKkVQ/QqKmMoFHSkX9xHPXujnNOPYIXvZcC1hWhX4HVn
         Cl2r1u1YIpE+pZ9fZSycPimHCaU2xJiwepn3CZZSI75cdEJbWcNqAqwpyDFenbkXWLLu
         /MYkqz2PaytZtfgX12MPxcy4DGlRHj+BNajdaGp9R6I2v2Z0/7ebSYkGgZi/DgK2zoXE
         bkjYaujkl0LZMGtbMjzw8wIghB6YoHh/8sE3hG/QxE0nQpClj9NGYVLOnc9akDV/57/H
         aQvZXPCjmyMLXZ96oNI91xv+V/ADfoUCz8XRT4hAryAy9l95uSso1IejK3ntHCzFiad8
         7RVw==
X-Gm-Message-State: APjAAAVlWT9yyTohxY7RoUjGhbdfyfbxqAk9yscSMKH27FhWoVJZQPlp
        vn5JZRwIVQ3P0ZNFTp6tF/Rov1da
X-Google-Smtp-Source: APXvYqxEiPe4sizuUzWkDEUl7tLtjqj38cXVG15cD1l1reWjpF4JeUOVa3gMakuyKwH9uuqLoypz1w==
X-Received: by 2002:a5d:4705:: with SMTP id y5mr23995206wrq.364.1572432277629;
        Wed, 30 Oct 2019 03:44:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k3sm2147102wro.77.2019.10.30.03.44.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 03:44:36 -0700 (PDT)
Message-Id: <pull.428.v4.git.1572432276.gitgitgadget@gmail.com>
In-Reply-To: <pull.428.v3.git.1572379280.gitgitgadget@gmail.com>
References: <pull.428.v3.git.1572379280.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Oct 2019 10:44:35 +0000
Subject: [PATCH v4 0/1]  Fix t5516 flakiness in Visual Studio builds
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

Changes since v3:

 * Reworded the part of the commit message that talks about the need for 
   fflush(stderr); for accuracy, as suggested by Junio.
 * Simplified the flow of the prefix handling as well as providing a proper 
   BUG message and abort()ing when the prefix is too long. Thanks Junio!

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

 usage.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-428%2Fdscho%2Ffix-t5516-flakiness-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-428/dscho/fix-t5516-flakiness-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/428

Range-diff vs v3:

 1:  fce0894ee4 ! 1:  f6d6c8122a vreportf(): avoid relying on stdio buffering
     @@ -42,9 +42,9 @@
          the error message; There is little we can do in that case, and it should
          not happen anyway.
      
     -    Also please note that we `fflush(stderr)` here to help when running in a
     -    Git Bash on Windows: in this case, `stderr` is not actually truly
     -    unbuffered, and needs the extra help.
     +    The process may have written to `stderr` and there may be something left
     +    in the buffer kept in the stdio layer. Call `fflush(stderr)` before
     +    writing the message we prepare in this function.
      
          Helped-by: Jeff King <peff@peff.net>
          Helped-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
     @@ -60,12 +60,17 @@
       {
       	char msg[4096];
      -	char *p;
     -+	size_t off = strlcpy(msg, prefix, sizeof(msg));
      +	char *p, *pend = msg + sizeof(msg);
     ++	size_t prefix_len = strlen(prefix);
       
      -	vsnprintf(msg, sizeof(msg), err, params);
      -	for (p = msg; *p; p++) {
     -+	p = off < pend - msg ? msg + off : pend - 1;
     ++	if (sizeof(msg) <= prefix_len) {
     ++		fprintf(stderr, "BUG!!! too long a prefix '%s'\n", prefix);
     ++		abort();
     ++	}
     ++	memcpy(msg, prefix, prefix_len);
     ++	p = msg + prefix_len;
      +	if (vsnprintf(p, pend - p, err, params) < 0)
      +		*p = '\0'; /* vsnprintf() failed, clip at prefix */
      +

-- 
gitgitgadget
