Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 558AD2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 13:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757426AbdCUNA4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 09:00:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34804 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756886AbdCUNAv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 09:00:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id u132so2771026wmg.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 05:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ovNHPNDIpXqVOzkBZH7SQ16oRbH/Dt/uvKWqUpfssfE=;
        b=lI9/L/PQO367dYc9BvN2yHv3mgC3Gb18B9xbZIFAUZkPHdFkrGVMPcmAiM+Pr3psOm
         QvgyNYq/EKj6TAONzhXXLJDzDrzkZCsTb0xnrqRUJ0zRowS4LgCBJ5viY3Dn2qH5yPBR
         hnNxqsWQK2ekgL7aRHvNzMWh56kWrlegWmKfd6rR+i8PCaWsh7SquzrEpfpiEtI3evdm
         YoRrZPjo11kCBxdd3qXqJlMsnrVrySqVB5wSLuArlm9348o2c+MQ4viNEHH1jM9WFESo
         mSYGhsQ7BdvCotW75bRMiGJAdVRv5RjGZutZLfRbie9X2vOKrLRmanypFOWnc90cIHb8
         okYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ovNHPNDIpXqVOzkBZH7SQ16oRbH/Dt/uvKWqUpfssfE=;
        b=H84a/ZPUxYlV1dyBw1TaQkOfrsxG2o2SMFtPLzzZ58s4J48CbEJ+v7C0C3f08Wam2n
         NRGEkoXQZ8uHQUkcxvf22z9DLkjiXb8PoUhK44mo722K8ul59voEamQHtxZgycNbsX/S
         SI/b37G8VjwbyiBB0ZjFHVNZNKREKW2HCd0y/NS4cK8wUBzsbySA8u3JvA3Y1IiRrBb0
         4UeoOQhU/hHQUor17/GgJ/+Cz5S4+Nru1KC4r5ZsqINr+/BkOknE9om+22zIJD8nPLYB
         LcC6Og7RjLvr6Kde0WPLu0dsUQYM7QhZRDkRr0lFA4v85I09G1ItgCLC/C6wAXCytOyM
         FWTg==
X-Gm-Message-State: AFeK/H2xzJe1Qsq07pxdBLyZZWuW2G06V4RnhWhWm3SdTPSbmIIrRm6SW9ojvXoKtg53PQ==
X-Received: by 10.28.30.19 with SMTP id e19mr2641956wme.52.1490101173614;
        Tue, 21 Mar 2017 05:59:33 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 63sm17555072wmg.22.2017.03.21.05.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 05:59:32 -0700 (PDT)
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
Subject: [PATCH v2 01/16] tag doc: move the description of --[no-]merged earlier
Date:   Tue, 21 Mar 2017 12:58:46 +0000
Message-Id: <20170321125901.10652-2-avarab@gmail.com>
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

Move the documentation for the --merged & --no-merged options earlier
in the documentation, to sit along the other switches, and right next
to the similar --contains and --points-at switches.

It makes more sense to group the options together, not have some
options after the like of <tagname>, <object>, <format> etc.

This was originally put there when the --merged & --no-merged options
were introduced in 5242860f54 ("tag.c: implement '--merged' and
'--no-merged' options", 2015-09-10). It's not apparent from that
commit that the documentation is being placed apart from other
options, rather than along with them, so this was likely missed in the
initial review.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-tag.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 525737a5d8..33f18ea5fb 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -124,6 +124,11 @@ This option is only applicable when listing tags without annotation lines.
 	Only list tags which contain the specified commit (HEAD if not
 	specified).
 
+--[no-]merged [<commit>]::
+	Only list tags whose tips are reachable, or not reachable
+	if `--no-merged` is used, from the specified commit (`HEAD`
+	if not specified).
+
 --points-at <object>::
 	Only list tags of the given object.
 
@@ -173,11 +178,6 @@ This option is only applicable when listing tags without annotation lines.
 	that of linkgit:git-for-each-ref[1].  When unspecified,
 	defaults to `%(refname:strip=2)`.
 
---[no-]merged [<commit>]::
-	Only list tags whose tips are reachable, or not reachable
-	if `--no-merged` is used, from the specified commit (`HEAD`
-	if not specified).
-
 CONFIGURATION
 -------------
 By default, 'git tag' in sign-with-default mode (-s) will use your
-- 
2.11.0

