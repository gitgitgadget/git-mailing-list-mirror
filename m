Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD84F20248
	for <e@80x24.org>; Fri, 22 Mar 2019 09:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfCVJdR (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 05:33:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54430 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfCVJdN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 05:33:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id f3so1420672wmj.4
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 02:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LJ+Tll2o8YpI1TmzYeKqWi+bKk2sRZoEFWzP+4GO/8Y=;
        b=RobghbQQ2JiHyAayTAzfxX+asv88D8rTCoFN+TOadErvOFrH/gWCulerPQ6ey7h+SZ
         nFh7QxRBST4EmSR5OY1LmksfxIpSyLKx4iNmGJ3H8fKda7R02G2EnxUIciRgxYtj0Bav
         Kk5FFIUG6Nyg+BWpYvosiHlji5GsXzAgsBTSaTDD+IM7wvTnxYRN3OWUYbE2A1cDxzqi
         JYEdsvUNcovpd5YzkEewXDD+i1DGHnW1BzncH5sCcxXCQm6LTqc4/FUXdXl8PKNmFHmF
         DIXhDIS7pEcXsnexZBc6Gkn3RJDDUG2geJeAyVEiaaIpqh6G4Lo/UhG9qu5wzYNtRjR5
         Rsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LJ+Tll2o8YpI1TmzYeKqWi+bKk2sRZoEFWzP+4GO/8Y=;
        b=P8aCgBMMRPldaNPWPF0oL5XyHzNzMLWAapFvlsUAxUJQoigjrLd3Zd6spORY7KwDi/
         YpPH8D82uTgbfJTnOv7dqSgwIFjpQgXQ/EfKGyiCshwmFLq+M1XtzlUxMq6SzBDy9rNI
         X4MBPHKFJa7C+GNV0eTNiZ4KThLp55sqVB9Te0nUPFzPFN74n7lI0nJ05leOJ4oiR6m5
         qbyZFOpUFp6wGxJQOCqhq69GPf5GrIG/vxs8rD8ovTmkQXHIzMbaPW8JIRfJkUC5Z/dY
         3X00unUjtdEF5/+fLezoXx43CPZAwlKa0KILNfyPhStlzJKzr58WzWPyX7148PWF7lWr
         i6nQ==
X-Gm-Message-State: APjAAAUDsOHP4HzXDA3m95EvMsARZiYj/y0XhfT5jmbfFgC/HQ5vRDyd
        Q8TuljEndxceoSAzKoI1Ey2WPoTaFlU=
X-Google-Smtp-Source: APXvYqyTgWhe0jDAACJ2/Q19+kb/ovZgmhwaiU4dgxOEvhUKbNQTcXLqNA4/lIQaAm8o7+FwYEv6Rw==
X-Received: by 2002:a7b:c5c3:: with SMTP id n3mr2418289wmk.82.1553247191133;
        Fri, 22 Mar 2019 02:33:11 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y197sm3521447wmd.34.2019.03.22.02.33.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 02:33:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/11] gc docs: note "gc --aggressive" in "fast-import"
Date:   Fri, 22 Mar 2019 10:32:40 +0100
Message-Id: <20190322093242.5508-10-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190321205054.17109-1-avarab@gmail.com>
References: <20190321205054.17109-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the "PACKFILE OPTIMIZATION" section in "fast-import" to explain
that simply running "git gc --aggressive" after a "fast-import" should
properly optimize the repository. This is simpler and more effective
than the existing "repack" advice (which I'm keeping as it helps
explain things) because it e.g. also packs the newly imported refs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-fast-import.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 43ab3b1637..2248755cb7 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -1396,6 +1396,13 @@ deltas are suboptimal (see above) then also adding the `-f` option
 to force recomputation of all deltas can significantly reduce the
 final packfile size (30-50% smaller can be quite typical).
 
+Instead of running `git repack` you can also run `git gc
+--aggressive`, which will also optimize other things after an import
+(e.g. pack loose refs). As noted in the "AGGRESSIVE" section in
+linkgit:git-gc[1] the `--aggressive` option will find new deltas with
+the `-f` option to linkgit:git-repack[1]. For the reasons elaborated
+on above using `--aggressive` after a fast-import is one of the few
+cases where it's known to be worthwhile.
 
 MEMORY UTILIZATION
 ------------------
-- 
2.21.0.360.g471c308f928

