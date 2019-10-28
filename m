Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F17CB1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 22:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfJ1WBg (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 18:01:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40532 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfJ1WBf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 18:01:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id o28so11497081wro.7
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 15:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zCwmD05sku7CiK+/kH+whWWo22bq/8ISANkmtJjm0nI=;
        b=VAjqKJqOoXIksx5FBh+oc5ZnACjgv2ovzovnKkBrZR2qQT8ctEWmAZYxsLNPZHOtmD
         rHfc0YdbNxuh8h9B35H7n4n83Gnx+e9AG4zpMGsfjRbftPuWu4Q0t+gWXNz98aklf9cR
         cr58k9WoDaoYc+fQS7kZ7THXndAB2bV11BIAAJIDWQfvwNmYR0pw7+k1J5mzimIlKW4i
         BKqHm6O01nouNfGAyEKu7SMOuY/B2Vw0ZULXdtFuxnLtpSzZn7d4fPBI5WKBRjp74XVm
         BRHNXMbJ+czKucAByuo4SS+P/BAea+FlWrFlL58WRQVL8JFdJtSsAw5hbtifWt1dIUp8
         9FGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zCwmD05sku7CiK+/kH+whWWo22bq/8ISANkmtJjm0nI=;
        b=Cyo2L3QZ7s05J6As5irnW7srfklwb//XgxJGh2lP1/WK64OW0XHu6UFqIkjBaCy6Ey
         34P2swYOAYWZGo8lFACROB+d+oVb19KiaGUSOzfKH11nrKJkK5V4mrjtfj/l5qBa8xtP
         46i/qOyFahqSm7GO/NkKgpXBr0WjAfMt5k4mLGeWFM1eToOyPDS5QhL1eYZUBIwi5Os1
         MFDYKgYgEFg8ZYW1H+OqHUV7rQSqT+FdSY6vBOHanadcmZuJ+i8wZ4JipsLWPJ5Y4nsL
         rU2i8a2/HO1j5IQ/t2jjSo1FVa18jMmhfrbB6pZsYUhlVCPh7m7REkK02tNd0ecCfonZ
         itfw==
X-Gm-Message-State: APjAAAUKmx01DvMX4OmjPBRu12hVPlYyZdzEZuJ+TDxMFJUTbgyOlY9L
        3+CW69or2VGTbvcw4nQ0ReFu8tbzRXI=
X-Google-Smtp-Source: APXvYqw5tQJ7KaAEyUejiIk9cWnWOqSLQyYOeNGqTOPgvcvvEKDeZmfZ2QzjydrES3B0HjxmUyJTzQ==
X-Received: by 2002:a5d:4dd2:: with SMTP id f18mr16160958wru.4.1572300093628;
        Mon, 28 Oct 2019 15:01:33 -0700 (PDT)
Received: from evergreen.lan (91.223.75.194.dyn.plus.net. [194.75.223.91])
        by smtp.gmail.com with ESMTPSA id i3sm12849586wrw.69.2019.10.28.15.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 15:01:32 -0700 (PDT)
From:   Mihail Atanassov <m.atanassov92@gmail.com>
To:     git@vger.kernel.org
Cc:     Mihail Atanassov <m.atanassov92@gmail.com>
Subject: [PATCH v2] Documentation/git-bisect.txt: add --no-ff to merge command
Date:   Mon, 28 Oct 2019 22:01:22 +0000
Message-Id: <20191028220122.21449-1-m.atanassov92@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The hotfix application example uses `git merge --no-commit` to apply
temporary changes to the working tree during a bisect operation. In some
situations this can be a fast-forward and `merge` will apply the hotfix
branch's commits regardless of `--no-commit` (as documented in the `git
merge` manual).

In the pathological case this will make a `git bisect run` invocation
loop indefinitely between the first bisect step and the fast-forwarded
post-merge HEAD.

Add `--no-ff` to the merge command to avoid this issue.

Changes since v1:
 - removed comment change

Signed-off-by: Mihail Atanassov <m.atanassov92@gmail.com>
---
 Documentation/git-bisect.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 4b45d837a7..7586c5a843 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -413,7 +413,7 @@ $ cat ~/test.sh
 
 # tweak the working tree by merging the hot-fix branch
 # and then attempt a build
-if	git merge --no-commit hot-fix &&
+if	git merge --no-commit --no-ff hot-fix &&
 	make
 then
 	# run project specific test and report its status
-- 
2.16.4

