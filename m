Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A2521F597
	for <e@80x24.org>; Fri, 27 Jul 2018 14:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388309AbeG0P77 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 11:59:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43645 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730714AbeG0P77 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 11:59:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so5271840wrv.10
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gHDaanWZKS5puBGNSoLJr2xDH5QF1XS+T2PlaqHhaoo=;
        b=ftca7wMzDQRNCGdfv5g/Vu3dgFuwgo3sBfUiIY0bK3ZKfgtesp8wXohiW6W7JO7Uh3
         2u/2rgJDbR9ayZ/tDQbQl1sw4f9pCnvsQ7oWUFUJg6rCoGIGxGTYLt1AmfbvUbzMVKLQ
         8Epz01UU4TZT2Lbwfu6pSe2x95E7Lxov5oGqf9mnFKzPtM9u86wrC4PCBCRto4YIoFEB
         /SnW3veeAlgluvHxrp7+Lm8hSM5jkGrd/WLrXr9hDVXXSKVK43Sp4C1jHIyjg/XKRGEC
         Ba9TVsrCSgUMoIfdf5rBg9pusOaOCLk87zXfVVsYQhHNZbWdI2gDU62P9AjUKHlBaiQH
         rTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gHDaanWZKS5puBGNSoLJr2xDH5QF1XS+T2PlaqHhaoo=;
        b=W+I8H90nPasMpw1d+/cr8K8bGWDqMzP3sPr9oaIZ0N8m6lvwjsMvx+txNu2VIPcSW+
         nbbMRE1UnA1gxNr7DS2BvdsjSL1+MfVFkwPvnApcy1uQ1MYKVqx3d4orncndjWwohDZA
         GDGL7bz40voOgf9yU2SYJxB6YRtC1WLQ7VVllVWhJfsb57h9CRMNGgNtEWFaONNZn73E
         cmoL8YP0k+qV/dua2bej1HAK+4/weXL4GRl1BTZe8T2K8Hv6vOZkgpli0b6/TJhD5eHF
         X2dv5AQ5JeXVLFjc4UGhIXNu0W9WJlIig73iWItSY/mIiHUQ9PgDSGQW7Tr5SzhTY1Z1
         o8aA==
X-Gm-Message-State: AOUpUlFe+37fj5hhLySQL2saLKdFdokKe1EC+a9XJpKwLeQmCK/6pjgh
        PaUYeRQsrVmopPsN5CpL1DKIq7Ug7yw=
X-Google-Smtp-Source: AAOMgpc+Q3Cb3c/Cw57RU6Ep2GZdwmejDpjsKR1ZPZrIh9JymrvpVOmU0bwsr4lewx2key1iGETuqw==
X-Received: by 2002:adf:e0cc:: with SMTP id e12-v6mr4934820wri.199.1532702264372;
        Fri, 27 Jul 2018 07:37:44 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j16-v6sm3005479wme.8.2018.07.27.07.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 07:37:43 -0700 (PDT)
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
Subject: [PATCH v3 05/10] config doc: elaborate on fetch.fsckObjects security
Date:   Fri, 27 Jul 2018 14:37:15 +0000
Message-Id: <20180727143720.14948-6-avarab@gmail.com>
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

Change the transfer.fsckObjects documentation to explicitly note the
unique security and/or corruption issues fetch.fsckObjects suffers
from, since it doesn't have a quarantine environment.

This was already alluded to in the existing documentation, but let's
spell it out so there's no confusion here, and give a concrete example
of how to work around this limitation.

Let's also prominently note that this is considered to be a limitation
of the current implementation, rather than something that's intended
and by design, since we might change this in the future.

See
https://public-inbox.org/git/20180531060259.GE17344@sigill.intra.peff.net/
for further details.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 291b4f3c57..7ff453c53b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3408,6 +3408,27 @@ On the receiving side, failing fsckObjects will make those objects
 unreachable, see "QUARANTINE ENVIRONMENT" in
 linkgit:git-receive-pack[1]. On the fetch side, malformed objects will
 instead be left unreferenced in the repository.
++
+Due to the non-quarantine nature of the `fetch.fsckObjects`
+implementation it can not be relied upon to leave the object store
+clean like `receive.fsckObjects` can.
++
+As objects are unpacked they're written to the object store, so there
+can be cases where malicious objects get introduced even though the
+"fetch" failed, only to have a subsequent "fetch" succeed because only
+new incoming objects are checked, not those that have already been
+written to the object store. That difference in behavior should not be
+relied upon. In the future, such objects may be quarantined for
+"fetch" as well.
++
+For now, the paranoid need to find some way to emulate the quarantine
+environment if they'd like the same protection as "push". E.g. in the
+case of an internal mirror do the mirroring in two steps, one to fetch
+the untrusted objects, and then do a second "push" (which will use the
+quarantine) to another internal repo, and have internal clients
+consume this pushed-to repository, or embargo internal fetches and
+only allow them once a full "fsck" has run (and no new fetches have
+happened in the meantime).
 
 transfer.hideRefs::
 	String(s) `receive-pack` and `upload-pack` use to decide which
-- 
2.18.0.345.g5c9ce644c3

