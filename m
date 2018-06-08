Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F1A41F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752974AbeFHWmb (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:42:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33647 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753251AbeFHWmK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:42:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so8571393wma.0
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T1VB4F9b2lWl2Nkl8SWBnHt2JLSLD/lCoRlXi/VUc0k=;
        b=bPpzd6MR33d94cbDSushi312uG+Vbs9b6n/i9OzdGyostzs15MH6zNT56aeCO+F7mH
         1tCv/JzL00bct4JbRJrRz/Y07RIVgn6YPIKmUs5t2KYukqImyKmoWUmkrEPt3QOqFP17
         uWy2moyWvi+cy3nhPc9H8QsCswtshyIVRsTUFv4l4sDH6eSs6ZViKYLS11Yu8GvgZ5Ck
         YmERFK0JJrNBTLXdYTu/QOfM8eY4gV7naF9Wi6ZiFQ7EJ87om5AMPPfV9fkSuajPW4yb
         XEiqd/6l1LHVKkibLRFhAOgY2etI/aHQDLTet2c9fZTaIDFo22DeRNqxglbgQKX5GhEl
         o+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T1VB4F9b2lWl2Nkl8SWBnHt2JLSLD/lCoRlXi/VUc0k=;
        b=p+QZwoqShMPcecPcrSqBPSxH6DjjUktu1UeniN9CtCefBeafO50psgBHHTdRcId70a
         LhQ87xLJmpQ2cnpKg8RqeYtJuwBpGHYpetu3nLBsWuoCfnuJB0cC5KPLeiYHymUh0w9O
         0CrvLqufB3cY+4POcw1P/O4oawZzIKW9Yl/DPVQGb/OqBseY/Y8w3N/d032iENcQ6Waj
         lCTtPl3R0XylSNfd8VHbXJJWHUZ2sSTAu4/svFYsgCqCvMQt3jFFgP8VRRb0rzV7xm2y
         i0XQm/O3+JGuStmwSWdrguS68kr/PcHNpR6LFZkemjAEvHxs/IC7eeB2HO0KNb79QRnP
         1T1A==
X-Gm-Message-State: APt69E1rhQ0LJ4Czgo+nVXAklwuPhM9+tpmX2rahoR3/HO6IegXYj3IY
        IfOCSWGK1FhDpGcIOKIjj2AgS9qE
X-Google-Smtp-Source: ADUXVKLVIFFF0PjEKlu/HGAGM3lQZE/YaeHAn3+uYNIfk1DqdH+Q+3jo02cZ42m8z1GDyZ/aBXF4oA==
X-Received: by 2002:a1c:168c:: with SMTP id 134-v6mr2680136wmw.53.1528497728746;
        Fri, 08 Jun 2018 15:42:08 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:42:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 15/20] parse-options-cb.c: use braces on multiple conditional arms
Date:   Fri,  8 Jun 2018 22:41:31 +0000
Message-Id: <20180608224136.20220-16-avarab@gmail.com>
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
 parse-options-cb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index 298b5735c8..e3cd87fbd6 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -19,10 +19,11 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
 		v = strtol(arg, (char **)&arg, 10);
 		if (*arg)
 			return opterror(opt, "expects a numerical value", 0);
-		if (v && v < MINIMUM_ABBREV)
+		if (v && v < MINIMUM_ABBREV) {
 			v = MINIMUM_ABBREV;
-		else if (v > GIT_SHA1_HEXSZ)
+		} else if (v > GIT_SHA1_HEXSZ) {
 			v = GIT_SHA1_HEXSZ;
+		}
 	}
 	*(int *)(opt->value) = v;
 	return 0;
-- 
2.17.0.290.gded63e768a

