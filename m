Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F97C38145
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 17:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343775AbiHWRHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 13:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343972AbiHWRE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 13:04:29 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898D7149F94
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 07:07:12 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id ay12so7265176wmb.1
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 07:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=z9Y72uY1JWvEyAbZ56e7nhzE+B7jE355dN0HbRWkLyk=;
        b=bbfhcLLwSZw4idOS68AZj9GQdj9TABlAmy7fprmecj7Rz+P0gYBvE/ZvdEPbrhgZFQ
         3gPhKcSwLz5VL0uR0Rkh+DeGPGLRhT02Vgej475bYN3TEIXRicuVjZPuKjBXDSGAnpBS
         BAesLwNh7yhYISuHn2OszntSrwXWAjSKMteYyQWnJDlFO4uQhPgwOJa/D1uxlKp3rAvy
         QpbqLlKBDxKDocXmyhsGM0F+LYmaK8OhLTncjoP7SOJ+6+YvohXxi4zm94AkNhn5CGnK
         MnInazfYqcaPjYH/bW4mSxo8xoZlgHfJ5EGYUlEx4OIWJfS5enzxs2DmvYRC/t12yyUY
         KdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=z9Y72uY1JWvEyAbZ56e7nhzE+B7jE355dN0HbRWkLyk=;
        b=Y8GL4CGB5AoyU8aa6ItR1gjuPgcndOjHwdSe/PJVZJYA489HzvGRXTHvUSrPQ/5erx
         THZuynr5QyDkEb+D/+07Stty/769JHr8tQ/gRIfw2RmZhni0FFcYjgolbJYp3u4+hbK0
         NRyJnBzbznzetmnCnaZ2molHNQU5I2+ERHgyRY9ooyzfBB3o7n1nQNeWfvkAtY2liI61
         7GGksAk/2zSP1kdbS6uTeK2wMoipPjdd/1qT7USx2g3hKRjr51l930C9gQN8LbW815C7
         nVk+DJCK3J/Rkl/q+ZBnAKC9JjmamOryVkkz6mIYQKJiG5XjL3hEWmw7ChLPQ7Z4HNdB
         OxnA==
X-Gm-Message-State: ACgBeo3Hv3r5hTbEo44000ij9AEGxkdhmzBN4twWbR27pFCIHjbn0GHS
        ZnryiYJhzsNQiIlihHkga7ffg2Q5R2nGqg==
X-Google-Smtp-Source: AA6agR5Y5EGovMijIUCF/MLCZi0xbV6W8o8DK6tUaGI54JALQpX4LokIbO9P6Xj2d8X+11yEQ01g1A==
X-Received: by 2002:a05:600c:198f:b0:3a6:2482:b2be with SMTP id t15-20020a05600c198f00b003a62482b2bemr2396951wmq.110.1661263630712;
        Tue, 23 Aug 2022 07:07:10 -0700 (PDT)
Received: from Precision-5550.dscbox.lan (lmontsouris-659-1-134-106.w82-127.abo.wanadoo.fr. [82.127.97.106])
        by smtp.gmail.com with ESMTPSA id be13-20020a05600c1e8d00b003a511e92abcsm18028056wmb.34.2022.08.23.07.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 07:07:10 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Maxwell Bernstein <tekk.nolagi@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH] Documentation: clarify whitespace rules for trailers
Date:   Tue, 23 Aug 2022 16:06:30 +0200
Message-Id: <20220823140630.159718-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.37.2.383.g1c78c54f66
In-Reply-To: <CAP8UFD2kMXHxvg1tKVNLhY0Gweq2YrD7+tHmZXKwguYzRQ1Qpg@mail.gmail.com>
References: <CAP8UFD2kMXHxvg1tKVNLhY0Gweq2YrD7+tHmZXKwguYzRQ1Qpg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit e4319562bc (trailer: be stricter in parsing separators, 2016-11-02)
restricted whitespaces allowed by `git interpret-trailers` in the "token"
part of the trailers it reads. This commit didn't update the related
documentation in Documentation/git-interpret-trailers.txt though.

Also commit 60ef86a162 (trailer: support values folded to multiple lines,
2016-10-21) updated the documentation, but didn't make it clear how many
whitespace characters are allowed at the beginning of new lines in folded
values.

Let's fix both of these issues by rewriting the paragraph describing
what whitespaces are allowed by `git interpret-trailers` in the trailers
it reads.
---
 Documentation/git-interpret-trailers.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 956a01d184..0e125d795b 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -60,10 +60,12 @@ non-whitespace lines before a line that starts with '---' (followed by a
 space or the end of the line). Such three minus signs start the patch
 part of the message. See also `--no-divider` below.
 
-When reading trailers, there can be whitespaces after the
-token, the separator and the value. There can also be whitespaces
-inside the token and the value. The value may be split over multiple lines with
-each subsequent line starting with whitespace, like the "folding" in RFC 822.
+When reading trailers, there can be no whitespace inside the token,
+and only one regular space or tab character between the token and the
+separator. There can be whitespaces before, inside or after the
+value. The value may be split over multiple lines with each subsequent
+line starting with at least one whitespace, like the "folding" in RFC
+822.
 
 Note that 'trailers' do not follow and are not intended to follow many
 rules for RFC 822 headers. For example they do not follow
-- 
2.37.0

