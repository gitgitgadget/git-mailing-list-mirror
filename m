Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB71D1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753226AbeFHWl6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:41:58 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37001 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753221AbeFHWl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:41:56 -0400
Received: by mail-wr0-f193.google.com with SMTP id d8-v6so14787806wro.4
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dLhGwHtJCI/AXaxI76u++ur/YGZWeolVtw7Ul866o/s=;
        b=U3hSv2MHrUoqn3SyS+yiGCpqgNt8WwPGEsZN0Ly6Sg06fBenX7nxz4YDrMUv12lwe4
         nLrCEWWBFjX2ttXDJtzc2EpBvLX1MmOh8W57TM9kSaQNSebvamPkIaOQh9sAxBhwoYho
         u/yh3mjL21WzvRDteZ3sKlc/vy0UOYuZc5n8JtAdVbscjL7269l2nxpfbJRK8e8PQRuo
         oM7mScpI5lMLNAuiZG2YzhYQPVvMQU6dpjXCCbQOKkJG4G/3J51RgfxTQSdC8e0CMTjX
         CBzmDZ/O54qHdqknVwZF77rRx6s11FV2Iv6KjaBscoDqjiNUZHFzrVUxUKDgMAOikOpm
         iLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dLhGwHtJCI/AXaxI76u++ur/YGZWeolVtw7Ul866o/s=;
        b=LYWrenjelAeUyLetdEwWAQyUYTgNYXIFiKo6Oc6vF0eHhCilaUfBE7a3VoS9SA2Gga
         B/5cPP+2Gr42UEj8gwlCVF4h4y+R/oTlh8IwKTvDSjyswQhx9NmLf6a3PjXr//mySZ8K
         uq3adupvYdJIit9LYarLSNZpKvUcbAkTk+4lTA050m12C4unLfg43m6+cm3MXrV0B3oD
         pK7dST21nDpCbF+1EbeUJcUReDTAMhNe4H4NFhi2lCrWxqiwXChI+zbTAFetLTUUv6QL
         0pTiBYiLyWKf8IbtBgZcGAmXnteWjSUlrSR1eSCHcIxYgo++7+WcC/J1/EqWAagBr6Ky
         CczA==
X-Gm-Message-State: APt69E2zCmRnksAhhEpU0OtXl/nnRaSiHh6uD3WtMfY/mEk/Ovib/s7W
        XIQUZ0AQzlT/0V+8FfK2xbRCt7f7
X-Google-Smtp-Source: ADUXVKLursC1X3QWfKw8n3PZAg3D5l0lPBNivw5qAmJDlOdz6g6IPZZ6jZw7TzMfelHbkHf36SU3Vg==
X-Received: by 2002:adf:f281:: with SMTP id k1-v6mr5894792wro.263.1528497714919;
        Fri, 08 Jun 2018 15:41:54 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.41.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:41:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/20] blame doc: explicitly note how --abbrev=40 gives 39 chars
Date:   Fri,  8 Jun 2018 22:41:19 +0000
Message-Id: <20180608224136.20220-4-avarab@gmail.com>
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

In a later change I'm adding stress testing of the commit abbreviation
as it relates to git-blame and others, and initially thought that the
inability to extract full SHA-1s from the non-"--porcelain" output was
a bug.

In hindsight I could have read the existing paragraph more carefully,
but let's make this clearer by explicitly stating this limitation of
--abbrev as it relates to git-blame, it is not shared by any other
command that supports core.abbrev or --abbrev.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-blame.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 16323eb80e..7b562494ac 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -88,6 +88,11 @@ include::blame-options.txt[]
 	Instead of using the default 7+1 hexadecimal digits as the
 	abbreviated object name, use <n>+1 digits. Note that 1 column
 	is used for a caret to mark the boundary commit.
++
+Because of this UI design, the only way to get the full SHA-1 of the
+boundary commit is to use the `--porcelain` format. With `--abbrev=40`
+only 39 characters of the boundary SHA-1 will be emitted, since one
+will be used for the caret to mark the boundary.
 
 
 THE PORCELAIN FORMAT
-- 
2.17.0.290.gded63e768a

