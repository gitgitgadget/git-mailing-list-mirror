Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B537C1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 14:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbeG0P75 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 11:59:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51255 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732267AbeG0P75 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 11:59:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so5498271wma.1
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ssnyfDDdH4/Omirje8rtX1p6o9GYQRALJg5YodrQlM=;
        b=RpiWOLyjRQcd8mtYlhagnn0MR26hmawEOV8uHQcgFBL/PtpmdDdRSoLVM/9FTTJy9l
         Y+v1lFAXc9gh21CSM8vpgMUMPoFhJjst20aDbuz6b6oUTjVIUegMPFZNcsv7V3jLJv+u
         gHxjur74jcfz/fcJwgWkBjQ9iVHVCwR8rcWQfa7Z0OgxUiuQTFEquJAJUuUtzXo4FDJ6
         IvQf2qf/0EJC/a73FhLg0xF4fBOcTlf1RKtXoGdWkkzNaOudL0wo3mJRPCIiPbcsuU5M
         KlYlr9OPQq1EMskeTVjkftg+sGDMBT81SF/s98DFN6S2PAYKTMxsiuC1y/qDnoIG6EYD
         nHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ssnyfDDdH4/Omirje8rtX1p6o9GYQRALJg5YodrQlM=;
        b=noOpo89D9siLipZBCBg/u1tG1h1Gud7OhwoPvd5ZcjZi3oYO2IwONbMhBRep7esQzR
         HjOjhCJ5mDILdzwFdDvY/M6HmVOzJTLRUztO6ywppmOVa8Ko8VRGh0/HuSZE+zhTGouu
         fgEpqrCqqJuRGAQarY27asgbvOh7f6GO5FrqC6AAgealVz7e2REoHXz5ydFntXfptGxG
         CMdXn3HCsr7bvuLkAk2DW/GCyVGCGUisXiiikX5IwI8uyOpIKINGGDk4X0LRUEj4KVEc
         lRQHEPVRm03weyFevFYRhRZOw4aOZLXYk2Rs8QyrzQosZM5UAzYDvI75MKBVnZuEYlNq
         vesQ==
X-Gm-Message-State: AOUpUlFajvzi3ir5CwbjxnJ6m9iZeU7yCVO/H+dFJYOZ88ommLw9yEc4
        sV8AfBXqnI8MrTrnBL5u6uszmJfaZIY=
X-Google-Smtp-Source: AAOMgpdVOP8CvCIs5zhjrLI7MRupSQ1+J+9vh10LcIdB227bfzxIQfoNQonqpIyHMee167xvNb/WKQ==
X-Received: by 2002:a1c:1188:: with SMTP id 130-v6mr4471982wmr.138.1532702262936;
        Fri, 27 Jul 2018 07:37:42 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j16-v6sm3005479wme.8.2018.07.27.07.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 07:37:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/10] config doc: elaborate on what transfer.fsckObjects does
Date:   Fri, 27 Jul 2018 14:37:14 +0000
Message-Id: <20180727143720.14948-5-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180525192811.25680-1-avarab@gmail.com>
References: <20180525192811.25680-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing documentation led the user to believe that all we were
doing were basic reachability sanity checks, but that hasn't been true
for a very long time. Update the description to match reality, and
note the caveat that there's a quarantine for accepting pushes, but
not for fetching.

Also mention that the fsck checks for security issues, which was my
initial motivation for writing this fetch.fsck.* series.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8d08250a5b..291b4f3c57 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3397,8 +3397,17 @@ transfer.fsckObjects::
 	Defaults to false.
 +
 When set, the fetch or receive will abort in the case of a malformed
-object or a broken link. The result of an abort are only dangling
-objects.
+object or a link to a nonexistent object. In addition, various other
+issues are checked for, including legacy issues (see `fsck.<msg-id>`),
+and potential security issues like the existence of a `.GIT` directory
+or a malicious `.gitmodules` file (see the release notes for v2.2.1
+and v2.17.1 for details). Other sanity and security checks may be
+added in future releases.
++
+On the receiving side, failing fsckObjects will make those objects
+unreachable, see "QUARANTINE ENVIRONMENT" in
+linkgit:git-receive-pack[1]. On the fetch side, malformed objects will
+instead be left unreferenced in the repository.
 
 transfer.hideRefs::
 	String(s) `receive-pack` and `upload-pack` use to decide which
-- 
2.18.0.345.g5c9ce644c3

