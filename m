Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA53720248
	for <e@80x24.org>; Mon, 25 Feb 2019 21:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfBYVy3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 16:54:29 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:37572 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbfBYVy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 16:54:28 -0500
Received: by mail-pg1-f202.google.com with SMTP id a6so8020163pgj.4
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 13:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wIWQj1ERu5ZQ4vQcGP8vETcHT/HJ+SgmJQiINVtQ6u4=;
        b=ZQyhtBBxJjRYRJz62frDrSL0MkXVazzUOTZl4W1PGG0ktq4+acYF1TojhDCuaUv3Bv
         O/YY6rAP84S36NkYpLmJl2UeIrDCPx/02DTEVxqMkSpdWh+atfUgro74K9+jLRTmYNhP
         RaCPJ/g9AfroyedYX05panBf39CfqzTqlOt+dF0KdmngZPuqciGYUQk4FiU5XyxokQN2
         Lni31vmwjjLtJqyXxf3211kemtKMpPYerCgi07CYhgTWoeARI2i2O77izGTNtlL0ByET
         nlwRmDfMNi2Omy0zi8/gPTIqa4cbQDEssd+dCxhXT+0xB0PkzvoF9UDA1ZmuAyMR9Ug+
         FDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wIWQj1ERu5ZQ4vQcGP8vETcHT/HJ+SgmJQiINVtQ6u4=;
        b=n0xo6+XDcDGNEvHTOuOxL8yFblxEP7G5JDhqOcH5Xtg6lOzBsMyp6P6Lc8q2S0O2M0
         rjCDGV3wU6VnKnjQJOh9DtmXGVqTmhoy96ZGSyCRwfdAnNA3pQ7aNFnsuA14mmGCdnP+
         9RGozw8nLq47/7kbvhtRZz14Jr7c0WmWKe1WI0O4+BZx73nBRaAO32USrp3qJ3ipairW
         DVyYkG53ol1+3fetlZytO9IFv4CjSqrEdlyna/Q9MEznPgSrYY5LXgyCOZH7Sa1wu+yE
         iKQLjXtpvbRtY1vyu3ciu8AJ13HkVgUeGcshz1aCx88OA+Z93kIaAcU5GAZv32DJJ78W
         NsTA==
X-Gm-Message-State: AHQUAua9R4qlOCcj9xygVvEICbTSo2J4to7ZDnKlIrpCFKbcdF3tHLFP
        LJ+Y0xNj+Txfk/eQN9lZfGlOauZTYdeJkL7Uv249BwOjs6naFv54OikKZWs5pTwxUxvFPXsi3rX
        kacFBOoyjWuTsVy8d4R/47dPEBOELh7xzuG1GW8IXQ0mJfZH22Kv9nVrWEKD8JzYMzIookarRmJ
        tj
X-Google-Smtp-Source: AHgI3IZf2jFfXoakCyJrh1dzmbR9mPzKEjGiaLkwA30KdlP69uN8tgmKuCiiPsizrAwCM48VgA+C7napW2x6hoLn2fK5
X-Received: by 2002:a62:7553:: with SMTP id q80mr6632636pfc.17.1551131667643;
 Mon, 25 Feb 2019 13:54:27 -0800 (PST)
Date:   Mon, 25 Feb 2019 13:54:09 -0800
In-Reply-To: <cover.1551131153.git.jonathantanmy@google.com>
Message-Id: <8f510c5c78dd5152307e30f8115188ad689b8c57.1551131153.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1551131153.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 4/8] t5503: fix overspecification of trace expectation
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to extract the wants from a trace, a loop in t5503 currently
breaks if "0000" is found. This works for protocol v0 and v1, but not
v2. Instead, teach t5503 to look specifically for the "want" string,
which is compatible with all protocols.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5503-tagfollow.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 4ca48f0276..6041a4dd32 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -47,7 +47,7 @@ get_needs () {
 	test -s "$1" &&
 	perl -alne '
 		next unless $F[1] eq "upload-pack<";
-		last if $F[2] eq "0000";
+		next unless $F[2] eq "want";
 		print $F[2], " ", $F[3];
 	' "$1"
 }
-- 
2.19.0.271.gfe8321ec05.dirty

