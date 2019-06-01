Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0EFC1F462
	for <e@80x24.org>; Sat,  1 Jun 2019 21:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfFAVOV (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jun 2019 17:14:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36257 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfFAVOV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jun 2019 17:14:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so5669998wrs.3
        for <git@vger.kernel.org>; Sat, 01 Jun 2019 14:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=clDQCpeP6R5elh7Taxmmp9QCXU1PUlBHiEMghPg8yYs=;
        b=LWZ/FXUkIoWFFyzWrBN6hyPKB4/mMb/I50JVGx3AnNOgESIJuMdqyqJxB46JsqbYVC
         EUVN9LPWROJVFUUnL6yXAyej7jVWBu79ZpcXtWT5zG5oEoLNDeJU0BWbqmh2fHpo36J8
         nocLMWmEMubsaDwgzYHOdwB0tkpommmrIHd0wCbhBpISORFjGeCgBYPxWHZLbjthR32s
         37VgLE2Ra/fi9hP1XXcK7fe2IZ8Pgsvt3d0XK3it42Mm2FdQeE2vULW7DMGeAtf9V4E3
         pWNvbWH8x1RjX8/saR5u/5/EwLfHbA8RiPqE6hK54OfAZZhKudrbg86Ooe8LbgyApwe+
         IWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=clDQCpeP6R5elh7Taxmmp9QCXU1PUlBHiEMghPg8yYs=;
        b=jW3rXmPbb7DROrgHME9ALuzSs+UWWi9GUmXQOVdY2cTHVlwXYqd84oUBESWdeqPamj
         KUtbDnUxkiXhGO775a/YPQQUSR6To5gf6kFn4h8O9x54Kcv19fJ0/aFHZUZM7nF0DfqJ
         GpJZ+emVK8rLV3tL+g5BHfoef/1tXNc2e2s7tXSL7wQ78y1//4TcmKJoADQ+pKGbmXbf
         R/V6gHPV4p45nRA/LUTLC9cHjaeE/ZirCGPFSzogqQ8DJrB5B/FBclZepSmW1rAWesW2
         6H5W4V0houSYuCxrY+mFWsHbs99cDWh4bDXSRN19bfuBSxwLS7gLGpe3e8phM3620cj4
         HAbA==
X-Gm-Message-State: APjAAAUVXhLBgb6zkUXGT4AL7SsBNrC0hGDCkghLrrX1clHElLNLA/TX
        DXnUxeTa/UT11I1btf8w/45awZW8uGc=
X-Google-Smtp-Source: APXvYqyyDRjzCaGp7/LVth/uyoIAMXWawhFGwvY/gGhnFEwXo74i4qANfpI+/X+6POueF6I3svOumw==
X-Received: by 2002:a5d:5607:: with SMTP id l7mr6633359wrv.228.1559423659261;
        Sat, 01 Jun 2019 14:14:19 -0700 (PDT)
Received: from localhost.localdomain (cpc91214-cmbg18-2-0-cust207.5-4.cable.virginm.net. [81.102.75.208])
        by smtp.gmail.com with ESMTPSA id p16sm20088960wrg.49.2019.06.01.14.14.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jun 2019 14:14:18 -0700 (PDT)
From:   michael@platin.gs
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>,
        Michael Platings <michael@platin.gs>
Subject: [PATCH] blame - fix some issues identified by coverage report.
Date:   Sat,  1 Jun 2019 22:09:25 +0100
Message-Id: <20190601210925.15339-1-michael@platin.gs>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <Re: [PATCH v7 7/8] blame: add a fingerprint heuristic to match ignored lines>
References: <Re: [PATCH v7 7/8] blame: add a fingerprint heuristic to match ignored lines>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Platings <michael@platin.gs>

Thanks to Derrick Stolee for highlighting missing coverage.

In the case of "certainties[i] = CERTAINTY_NOT_CALCULATED" this was
defeating an optimization that preserved results of calculations
between line-matching passes. This had caused other code to never
be executed - that code is now executed and only discards calculation
results that are no longer valid.

In the case of "max_search_distance_b = 0" this was never executed
because another statement was added earlier in the function to return
early in such a case.

Signed-off-by: Michael Platings <michael@platin.gs>
---
 blame.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/blame.c b/blame.c
index c059063688..2b47c942db 100644
--- a/blame.c
+++ b/blame.c
@@ -825,10 +825,6 @@ static void fuzzy_find_matching_lines_recurse(
 		*get_similarity(similarities, most_certain_line_a - start_a,
 				i, closest_local_line_a,
 				max_search_distance_a) = -1;
-
-		if (certainties[i] >= 0) {
-			certainties[i] = CERTAINTY_NOT_CALCULATED;
-		}
 	}
 
 	/* More invalidating of results that may be affected by the choice of
@@ -947,12 +943,8 @@ static int *fuzzy_find_matching_lines(struct blame_origin *parent,
 	if (max_search_distance_a >= length_a)
 		max_search_distance_a = length_a ? length_a - 1 : 0;
 
-	if (length_a == 0) {
-		max_search_distance_b = 0;
-	} else {
-		max_search_distance_b = ((2 * max_search_distance_a + 1) *
-			length_b - 1) / length_a;
-	}
+	max_search_distance_b = ((2 * max_search_distance_a + 1) *
+		length_b - 1) / length_a;
 
 	result = xcalloc(sizeof(int), length_b);
 	second_best_result = xcalloc(sizeof(int), length_b);
-- 
2.21.0

