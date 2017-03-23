Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0265620958
	for <e@80x24.org>; Thu, 23 Mar 2017 13:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754153AbdCWNGR (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 09:06:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36498 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754104AbdCWNGP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 09:06:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id x124so16492784wmf.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 06:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yb5vW3GBrytlU1iAB9X/y6F8Gs+JnLJBxo32d8oFTR4=;
        b=QlxuO0ixhpg1KB/KqlArB10RaH0SWBEqjQoGLh1UPfVpO+SzaMM1Ta64j29O4vP6qQ
         38SFWthZ21qiIk0gIdoeEp+KJHrqgP1fVfkTSqFG6P6Pt0LeIpNXKsnPlaRhK4FKKf/H
         wYdcTlJ3xSKMWdy5RUyIYttywzx+TEodh6qWzhrIaNf6sA/HPxO1Niqcfw2/B8LHK5zb
         Yg/ddn/5STuRvanpLQqsSiGAns0EWCR0mLCHSFHvQ+bLMzc7xIOVHqGJfzqtGVsiZYOZ
         zmQzJ0RKaB+COAo9xlUN/+1s6CKd3GByGTUm3Ikm46iEWuUV89UEJpoL2eInat2KXZv0
         ejkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yb5vW3GBrytlU1iAB9X/y6F8Gs+JnLJBxo32d8oFTR4=;
        b=rSRlCbMPYrVC9BCmJyIHS7p722esZznlysJhwaq4RvHhy8A7DwqeYkHrYLgPbD1kT4
         GCuR1KTeqxCJsVWwaedXFK7F/sIytH+J5Hz2nWeii6pdd2hC/fe1VuQvT8bj6fcuItcu
         G+n7CluesQ6mk/3vEaQRm6kkF8Noe8/uC4rWFqzOIknAVYTH4ojMXVJLD2RGuSnzElMZ
         WTF7c0XOmXL5bntXs7+DLcDC/1O5NWu3KN58nAE0a7c8l5Jgti3O+Xw5s0fHWCPeuyvm
         cwDOkDWsoJCiWLkugsab/ROmL06ScMPQeDRECVMYkXLnnBCaxNx8jG/SKaiactY2si6V
         enmw==
X-Gm-Message-State: AFeK/H3cEYFCPlXL+cnYL9YBj6M3hjsOeDAZPEwSjEXCZwJzvcPp576K2fYIU1a5V+JsXA==
X-Received: by 10.28.47.15 with SMTP id v15mr2853368wmv.116.1490274372982;
        Thu, 23 Mar 2017 06:06:12 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h3sm5810071wrb.6.2017.03.23.06.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 06:06:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/16] tag doc: reword --[no-]merged to talk about commits, not tips
Date:   Thu, 23 Mar 2017 13:05:16 +0000
Message-Id: <20170323130529.11361-4-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170323130529.11361-1-avarab@gmail.com>
References: <20170323130529.11361-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the wording for the --merged and --no-merged options to talk
about "commits" instead of "tips".

This phrasing was copied from the "branch" documentation in commit
5242860f54 ("tag.c: implement '--merged' and '--no-merged' options",
2015-09-10). Talking about the "tip" is branch nomenclature, not
something usually associated with tags.

This phrasing might lead the reader to believe that these options
might find tags pointing to trees or blobs, let's instead be explicit
and only talk about commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-tag.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 68b0ab2410..3abf912782 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -125,11 +125,11 @@ This option is only applicable when listing tags without annotation lines.
 	specified).
 
 --merged [<commit>]::
-	Only list tags whose tips are reachable from the specified commit
-	(`HEAD` if not specified).
+	Only list tags whose commits are reachable from the specified
+	commit (`HEAD` if not specified).
 
 --no-merged [<commit>]::
-	Only list tags whose tips are not reachable from the specified
+	Only list tags whose commits are not reachable from the specified
 	commit (`HEAD` if not specified).
 
 --points-at <object>::
-- 
2.11.0

