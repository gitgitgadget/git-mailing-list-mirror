Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CB06207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 20:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754957AbcILUK2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 16:10:28 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34288 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754922AbcILUK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 16:10:27 -0400
Received: by mail-lf0-f67.google.com with SMTP id k12so6238721lfb.1
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 13:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:date:subject:mime-version:content-transfer-encoding:from
         :message-id:user-agent;
        bh=PSpehFGiRJRZv/fCXOYrXLD5oC/G5AQIXtI0KGZAaQY=;
        b=UvJzwV2R2z4F7o6r5dKjfgBaIwNJCbvmfGAdB8AnSWTbCq5mXd8NhGsl/Q1cuSjcGj
         i9+rP9wN88tog7WoCEyXSxrqMjJTzqe+LIgzI2nGQD8inaGchyVNKgqaAOciMsxewTrP
         CLZs+8q4Epvj1tiwXcV1NVI/05zaxmwbuWZ+3VHIiduRZqdF0plczTHCJe+9xYyJ/MJv
         yPszT0rO1EYiPNh2nHqHfMRS5mgA1BUI17lgFPnYf+VkuyP0WmzfwzGvSfD5lZik3ad5
         GS6XU114gBIcd7NNm0Ufeio6whfKI5ajsrkudMtMz1+r3QBpp7t4Ca2tnJJX4I2bQ2Fs
         FV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:date:subject:mime-version
         :content-transfer-encoding:from:message-id:user-agent;
        bh=PSpehFGiRJRZv/fCXOYrXLD5oC/G5AQIXtI0KGZAaQY=;
        b=FqLG0Gajf9vcMkqta2k/6Yo9x2Xc+v1UD2YVNRtVnaRBwUSxx/1cGGIv6JZtCuqqq0
         O0fXwBGzVzd4BjJlS2J4Tz6eicBhtn4hs9cnuToyoSZ70ODuqsSu37QZpP0CsH6xXmu1
         sGqcRVGh9z4NV5bgcAPfNxrQnG5SNRvofBmKpYtWlT9JGJaHjTC7zfF8Hmp8+hzQlioo
         D16gqJWwE8kathO7qnSRBJe6i00gnsLIyjq8hHm5sLwODdjvCb5RxATYhPN8ObmBYu3s
         EZKjhsFumxDLqODZf283goskyVajViDbqWUhn4AZdJakNFnlvHXPA68GckUem82AZIiM
         J44g==
X-Gm-Message-State: AE9vXwP82ijh/ZqBFiRlIeJvw4s42ckfbIzkfFK1Cz1y9Noizo09V4xRjoH/WmlKvI9m0g==
X-Received: by 10.25.198.147 with SMTP id w141mr3353586lff.112.1473711025319;
        Mon, 12 Sep 2016 13:10:25 -0700 (PDT)
Received: from localhost.localdomain (system8589175140xdeo.mtvk.pl. [85.89.175.140])
        by smtp.gmail.com with ESMTPSA id k133sm1238038lfb.2.2016.09.12.13.10.24
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 13:10:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To:     git@vger.kernel.org
Date:   Mon, 12 Sep 2016 22:10:23 +0200
Subject: git-am includes escape characters from 'From' field
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Swift Geek" <swiftgeek@gmail.com>
Message-ID: <op.yno0zli7ig5ot5@localhost.localdomain>
User-Agent: Opera Mail/12.16 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-am seems to add backslash that escapes double quote character, example  
git format-patch

 From 63da989a5295214f9bd06cd7b409a86a65241eea Mon Sep 17 00:00:00 2001
From: "Sebastian \"Swift Geek\" Grzywna" <swiftgeek@gmail.com>
Date: Mon, 12 Sep 2016 21:27:32 +0200
Subject: [PATCH] Example showing git-am bug that includes escape characters

---
  testfile | 1 +
  1 file changed, 1 insertion(+)
  create mode 100644 testfile

diff --git a/testfile b/testfile
new file mode 100644
index 0000000..b48e119
--- /dev/null
+++ b/testfile
@@ -0,0 +1 @@
+test file contents
-- 
2.9.3

In .gitconfig I have
name = Sebastian \"Swift Geek\" Grzywna
which appears to work fine with regular git commit - backslashes are not  
included in 'From' field.

Regards,
Swift Geek
