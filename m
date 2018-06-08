Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 794B41F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753259AbeFHWmL (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:42:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37136 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753215AbeFHWmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:42:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id r125-v6so6247547wmg.2
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1TUqJx+6PV/3NnXAP0d5u/U7OJuI6b+qmH1PhGeXghw=;
        b=Wnu06MKkPOU2q7LwkYkGuoK/lMOFNMRKe1Huv/jFGHUJSC+PLikKhZt9pMQOC8pRyk
         UtUMEruDz4mKVsMkuV9Ln/Mmp5r7srr3C/Gdi+cjTrCDm0V0PQmuDaaXAlUwhb+DscnO
         K6BGcN7d0lLE2Cc8X9Gr5yY56hMnTmvJKOCTk5vA0TORE/1/DYLhAcOnbyfXpYSgA4od
         LlnWuHslD5JA/B/ozlVLTHGl66x76PeWIqxnW+I1XMnSqu1gDRJng1l98mG/MupZ3gJI
         7xr5g7DRZ1iymMFM3bWJ8koS+8pKwnACLlwfCHr5z2ziMeEDdmDLnNoZiKSl3mti5Hr6
         lszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1TUqJx+6PV/3NnXAP0d5u/U7OJuI6b+qmH1PhGeXghw=;
        b=UAde0sJ9HZsmGzjW1XP+/PRDSBD17yC6VR0yxuAiKIbLTaldnoe8rMIkLT8Jhmfr2y
         u4Kslm48pmgAe/3C5fCEJ7mDgbmY/SmcQH8wGc+Qy544w4q4W9gfCHRAdf//U83GEyug
         2ETZmzXfB96X+2g2z9JP9CHVSUwbBswbYp3LEW24tphJqTBmTN7wVJcF0Bqih2sexQK7
         bPf5062soIiFgQupHkHycIpjxEtpip9WOnbZ9lVW2C89nWsjiuSsM7/WtYIb62qosgjy
         bnZWD/nO8yuF9nqv08MuM4WyTnt+0iozw2Cjg0wNOLTtMeX3FdkKYbdaHd8+tWS9Dhvk
         prbQ==
X-Gm-Message-State: APt69E3q0t199LfcLg36q4CBlC8UgAIWIidN+GZCx1oqEPyG4OWGEgf/
        YmumStGvOYvoaiJbOFBb5GC9e7m+
X-Google-Smtp-Source: ADUXVKJ4C/SgVSTUrMzVgUT5oZEyO/N6YqzcPFAVZ/eKVTtnxhHuaHGQXRerpFsD8JzTQnTpDaQE6g==
X-Received: by 2002:a1c:43c5:: with SMTP id q188-v6mr2794890wma.69.1528497727672;
        Fri, 08 Jun 2018 15:42:07 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:42:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/20] config.c: use braces on multiple conditional arms
Date:   Fri,  8 Jun 2018 22:41:30 +0000
Message-Id: <20180608224136.20220-15-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180608224136.20220-1-avarab@gmail.com>
References: <20180608224136.20220-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust this code that'll be modified in a subsequent change to have
more than one line per branch to use braces per the CodingGuidelines,
this makes the later change easier to understand.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index fbbf0f8e9f..12f762ad92 100644
--- a/config.c
+++ b/config.c
@@ -1149,9 +1149,9 @@ static int git_default_core_config(const char *var, const char *value)
 	if (!strcmp(var, "core.abbrev")) {
 		if (!value)
 			return config_error_nonbool(var);
-		if (!strcasecmp(value, "auto"))
+		if (!strcasecmp(value, "auto")) {
 			default_abbrev = -1;
-		else {
+		} else {
 			int abbrev = git_config_int(var, value);
 			if (abbrev < minimum_abbrev || abbrev > 40)
 				return error("abbrev length out of range: %d", abbrev);
-- 
2.17.0.290.gded63e768a

