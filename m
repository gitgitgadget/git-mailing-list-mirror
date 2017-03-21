Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC69C2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 13:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757326AbdCUNAz (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 09:00:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32902 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756962AbdCUNAv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 09:00:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11so2784728wma.0
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 05:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yb5vW3GBrytlU1iAB9X/y6F8Gs+JnLJBxo32d8oFTR4=;
        b=uaTpN6V/fWqyMfVtm3feEUP7yk9rM7NYICpUkdf4Rq5mgvOV2+Cs+SL1ievtKqDfns
         Gi1K8Juzj6DQ5rFfKN9Qy9uq4vNIMQ3fbYYfV6LANoEGuG/uxyCijoK0Pg20bD9WAU74
         lsCYTeaW68V7KaDOz4HmfU2Sq/T+3yIaBJVolb8w0UvKHKJOikOwrNQi6MDJilA3E/Pd
         iFdE7W+7bjFCRxkMX5bKyIuNUDEya7JBuKeMVgQnVWfAnG8M4YCbVW7SqcSI4UsWvHxI
         W4CLydcfSH5hX1qRlQeVm7dWm2+Y4CsDRAGsL3CuL5kiZC4amnc+ABz/MtB72RXC/PF4
         Wssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yb5vW3GBrytlU1iAB9X/y6F8Gs+JnLJBxo32d8oFTR4=;
        b=KdW3Bbz0wIBLftgdA4mQlDYfz8Whnyc7ZPMCsjmC1FSX10RzQFy9ZMyqeA7WUJUldA
         iS0yMHExD3ISa2Rb/6hVf0RHsUO6QUW+3Ty082igMc1uNLmHbuai6VPoHCzvqeugX82X
         2barBSYHZVB4PXuO9lHojtKGpQ+Ik2QBUyvNsn2pFE2+A6qe8jhLuUiBe+vklRm51k4n
         cyTUkZ+jvv7fH9K5YZqYV9/T/ELfZrc+GEDArYSTIIZdK/Prh1cz+VmqCl3JP4zhrbDE
         5qF/497at7hZo42uRmQEyucOld3XOXzJ+5K3G3abder4ZUlmbZn9cge69B2fmHXFXgwI
         YSpA==
X-Gm-Message-State: AFeK/H0cInhC7+gcO//ve2r7XfFwyuMVPs2Q9G5htL0q72R2/fwhDEIWlO0UyNZ5Fb1OBg==
X-Received: by 10.28.87.6 with SMTP id l6mr2646884wmb.109.1490101189986;
        Tue, 21 Mar 2017 05:59:49 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 63sm17555072wmg.22.2017.03.21.05.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 05:59:49 -0700 (PDT)
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
Subject: [PATCH v2 03/16] tag doc: reword --[no-]merged to talk about commits, not tips
Date:   Tue, 21 Mar 2017 12:58:48 +0000
Message-Id: <20170321125901.10652-4-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170321125901.10652-1-avarab@gmail.com>
References: <20170321125901.10652-1-avarab@gmail.com>
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

