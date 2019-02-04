Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 444821F453
	for <e@80x24.org>; Mon,  4 Feb 2019 20:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfBDUvj (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 15:51:39 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41451 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfBDUvi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 15:51:38 -0500
Received: by mail-lf1-f65.google.com with SMTP id e27so979153lfj.8
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 12:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/P1j/dbTN50cx23Asa/rE4j5dyjjPSsolANJCCDxxVA=;
        b=pTkF2Jfj+JCB+ulKgLYyS2vwrlN2xRsOwBt4aoud9LAFL/vNyFw7jneYmOzhgs236s
         4qKA1O4AvuvIcYzAvPo9qgQ4URzX74OtgUw9HVLJ9+M6LA2SP4/Lq56ARPfhdF71xeEk
         h/7/uxO7uxum2ORINEwjgRqgGFwpBY2JVFATMazGacmu5P1u4fCxxzrz5qGB4bVExjSq
         AsqOj8LS2fI1VRik/XUmCMKatTDAsPB06mZOfs6WSuwC6ri/bfZm53joGb4jKt1ZedMi
         ocMSDjUO9Y2xMRwYB/Pd20fdS+dLkfvS1VDEDbqam/uhPhnjlvrUNMJEvaButJ6Fjo+K
         rhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/P1j/dbTN50cx23Asa/rE4j5dyjjPSsolANJCCDxxVA=;
        b=Y3LE+1KXvqREoqc9y1Gqh3/U0hSC0EZA3Dgic74aCAFLbV1gyS8B6h+/SkbrRKOdC6
         i1j2iAoEC0dYH+dnV3scWMspAFUjA2Pkym9PkYr/squ4UOw2I/Erw2pc46LHPo1DFane
         Y9+XiMmJuVEhAFYBo82bh9gWYkUYU6zz9LQLq/wi4c2Pq7RinR7Q5roNAd/k8ow77OeL
         XfEjt1yz+IIeYBWAVPEFY5c/JqFasZ1tE6bjBc0OEhAFYWC8ov3GQNc3SKdMZzYeFRQW
         2l5haQCVLd7hroma5X8jDYsg5QwdfPsPwD2Dk8q/RpQ3vlOPLg0PIWVKmoO11rX018oe
         MZGQ==
X-Gm-Message-State: AHQUAuYZZiQmsgoP+T4o9ftxTToRbbCZ9/UMfHzNunpQh0eBZeq5JPVm
        24sNGVNyzVikGHuvITH/C4o=
X-Google-Smtp-Source: AHgI3IbWEorKY4xJmNNCXsg7vxv27Cu9d+WyfyxwwnTSbRLQ8cfHXygOVYVcHqQBJhM5rHAofBr7iw==
X-Received: by 2002:a19:9508:: with SMTP id x8mr803213lfd.112.1549313495862;
        Mon, 04 Feb 2019 12:51:35 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id d5sm3275674lfi.65.2019.02.04.12.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 12:51:34 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3] doc-diff: don't `cd_to_toplevel`
Date:   Mon,  4 Feb 2019 21:50:37 +0100
Message-Id: <20190204205037.32143-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1.390.gb5101f9297
In-Reply-To: <20190203230152.GA25608@sigill.intra.peff.net>
References: <20190203230152.GA25608@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`usage` tries to call $0, which might very well be "./doc-diff", so if
we `cd_to_toplevel` before calling `usage`, we'll end with an error to
the effect of "./doc-diff: not found" rather than a friendly `doc-diff
-h` output. This regressed in ad51743007 ("doc-diff: add --clean mode to
remove temporary working gunk", 2018-08-31) where we moved the call to
`cd_to_toplevel` to much earlier.

A general fix might be to teach git-sh-setup to save away the absolute
path for $0 and then use that, instead. I'm not aware of any portable
way of doing that, see, e.g., d2addc3b96 ("t7800: readlink may not be
available", 2016-05-31).

An early version of this patch moved `cd_to_toplevel` back to where it
was before ad51743007 and taught the "--clean" code to cd on its own.
But let's try instead to get rid of the cd-ing entirely. We don't really
need it and we can work with absolute paths instead. There's just one
use of $PWD that we need to adjust by simply dropping it.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Thanks Peff for the suggestions. Trying not to cd at all seems sane to
 me. That it allows `./Documentation/doc-diff` is a bonus, I guess, but
 you're right that it's probably nothing anyone will use.

 I've verified that diffs produced by `./Documentation/doc-diff foo bar`
 and `./doc-diff foo bar` are identical, FWIW.

 Martin

 Documentation/doc-diff | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index dfd9418778..32c83dd26f 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -39,8 +39,7 @@ do
 	shift
 done
 
-cd_to_toplevel
-tmp=Documentation/tmp-doc-diff
+tmp="$(git rev-parse --show-toplevel)/Documentation/tmp-doc-diff" || exit 1
 
 if test -n "$clean"
 then
@@ -109,7 +108,7 @@ render_tree () {
 		make -j$parallel -C "$tmp/worktree" \
 			GIT_VERSION=omitted \
 			SOURCE_DATE_EPOCH=0 \
-			DESTDIR="$PWD/$tmp/installed/$1+" \
+			DESTDIR="$tmp/installed/$1+" \
 			install-man &&
 		mv "$tmp/installed/$1+" "$tmp/installed/$1"
 	fi &&
-- 
2.20.1.390.gb5101f9297

