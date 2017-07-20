Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00C931F600
	for <e@80x24.org>; Thu, 20 Jul 2017 14:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965647AbdGTOTx (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 10:19:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38322 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965642AbdGTOTw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 10:19:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id 143so3709291wmu.5
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 07:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=afykyWj569HKIJA1lxGWdp/wtd+/2ag06sK7kLVgARI=;
        b=LyhHir261Gj3HVQ4S2p42D7nBw9mTrbZWEyEOXWm5XMOUK3zJrpVlZ5cvK640DyFM3
         fNtgRvfa7X+CRgd9WuhtVyImBfSqzwwbQ+hsfl1ym7jET97DoU6bdxTe2G8ERJMulD00
         +DVRjx9r1di9rHUReG1RtF6Jq58fFn0O4U6Gee3dEAf89WkqckWsFe3eeDYJdci0w80M
         tU+Xu3WPjQzaLgHAag9rIf/3p0G8I8l+KAsQXlSYZfrTS8Al5ZNtCcMt70DSgfCgKUYu
         joobz0xZ23aPeZhkEDzwHpBmgc9NftHf5/aAxVXUrdJLnAj274mYtGGDlTU3tH2PfBLX
         lVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=afykyWj569HKIJA1lxGWdp/wtd+/2ag06sK7kLVgARI=;
        b=WLZ7gkYyCEFpUYRGPqpmjIdwOLcFFn4bBdl9GNogyLzqZCkT1AIBqgm2tTWBeodayi
         wlUM/600to4Vw3r8mFpkab3CnsE61hpwHcfyREtCUsxYhxHDrMK7nWjcnXXsR1OJyin7
         CwUFbI11vr9mrILFV1zeMnm7Y414+CSw05fPGzyFD3dulB9mqd07o425gQfto0e0nuUA
         MDxHknrRs9/5heK/Ee6aUn4YuDvFo5eCNcYppCvIKMtLlnZ0O9Bzn8P0Ix+cBuZr1QYH
         Z7KkGWsmXg2nIBeZNH45TfsATkpg6Ku51T0CAn4imUwNO0RVUER+ZrJlxlcRLYXroVTl
         MS+A==
X-Gm-Message-State: AIVw113IfvhZ0ngetxIMEw9/fOJTTyw1OGcbioU9ffRH+zcSTdHktdCG
        xRnNIaGscQfsjOC/TLY=
X-Received: by 10.80.216.66 with SMTP id v2mr3148056edj.255.1500560390680;
        Thu, 20 Jul 2017 07:19:50 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l24sm1630566eda.11.2017.07.20.07.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2017 07:19:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/6] RelNotes: add more notes about PCRE in 2.14
Date:   Thu, 20 Jul 2017 14:19:27 +0000
Message-Id: <20170720141927.18274-7-avarab@gmail.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c
In-Reply-To: <20170720141927.18274-1-avarab@gmail.com>
References: <20170720141927.18274-1-avarab@gmail.com>
In-Reply-To: <xmqq7ez6hk2y.fsf@gitster.mtv.corp.google.com>
References: <xmqq7ez6hk2y.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We were missing any mention that:

 - PCRE is now faster with JIT
 - That it's now faster than the other regex backends
 - That therefore you might want to use it by default, but beware of
   the incompatible syntax.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/RelNotes/2.14.0.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.14.0.txt b/Documentation/RelNotes/2.14.0.txt
index fb6a3dba31..a6a1cb963b 100644
--- a/Documentation/RelNotes/2.14.0.txt
+++ b/Documentation/RelNotes/2.14.0.txt
@@ -88,7 +88,16 @@ UI, Workflows & Features
    learned to say "it's a pathspec" a bit more often when the syntax
    looks like so.
 
- * Update "perl-compatible regular expression" support to enable JIT.
+ * Update "perl-compatible regular expression" support to enable
+   JIT.
+
+   This makes grep.patternType=perl (and -P and --perl-regexp) much
+   faster for "git grep" and "git log", and is generally faster than
+   the system's POSIX regular expression implementation. Users
+   concerned with "git grep" performance or "git log --grep"
+   performance might want to try setting grep.patternType=perl. Note
+   that the syntax isn't compatible with git's default of
+   grep.patternType=basic.
 
  * "filter-branch" learned a pseudo filter "--setup" that can be used
    to define common functions/variables that can be used by other
-- 
2.13.2.932.g7449e964c

