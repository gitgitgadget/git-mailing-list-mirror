Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 088A31FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 22:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbdLHWaX (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 17:30:23 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41410 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753336AbdLHWaU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 17:30:20 -0500
Received: by mail-wr0-f196.google.com with SMTP id z18so12109486wrb.8
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 14:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qgtWhCM5e2AFXkxq0RglRROJR6ReEaYcfCeWIDYZbOI=;
        b=djpK7SIa3f9LiZJrrrWYNcBeMe6RTtA3+xUbpIjmr8FCkQ0V6ilaLmZ07yE4dh/gVd
         /VB6ygvftzhsnZ90o0Zq7ywqMKk8Wvcy8kQezGUk5A4YZuEHGWAqu4oNaJuq/I09zzRX
         f0yJROklhYxKZ4vPe8l1ooeO9WjsutDiV+LxJtMmjAZDEguKt6sNUIue5xAzGs76IwtQ
         y2cIRtuld6VBVHi/kddWx+r12xCNEzRcgctFdjVBOF0SXA0E7B5vsLzkuVGWabxYR/7z
         28xbvAcwLDavgxBEFNYOkNzUXiLWEJIHzoDcXYTNF/lET8mPJq2k/00lreTGH30phlGF
         ZegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qgtWhCM5e2AFXkxq0RglRROJR6ReEaYcfCeWIDYZbOI=;
        b=rToBtMkFJMKHztlfgwHJkVkIJZGFgDiHIzSsKFkZIGA29pDg+e2AXHnu/pavOLcrNh
         YEm5UQqYwa/kqoSRLbl6MOs3dRMS/W1mc6V4kqLmA3wArKCHp6zfrCQf7FoPGk3mN6Gk
         zlZ33qv+GafP1xLaICsWOUPR7KaRP+Sf5Z0cCRSDuqI9uoPIMZMqg0k2ZrpEAyTkeCrU
         7xmEhj+UgFVlqJQgbirc7Hnwq89wua358rxRT1oKXEOAmT5x0P4OMgodcEm9UGvNNba0
         VAdApTNYyZ7E2lnl+ftzz/VTFNggglB98A+42rq1VPKnCHXvq9JFIbEWo5LJsWJTleh3
         Ks8A==
X-Gm-Message-State: AJaThX5ZcJBWz0QdDiRD02a2YYwNF6Xjxl4qoAFBAbrnuRmpAYJ10A7d
        FL0jg3LGLhvTOkSt1Zgkr71eK6GD
X-Google-Smtp-Source: AGs4zMZMDTFwH8wT4Sd1ogTvQbT/S/vg3l54trKbL/41le6OSS0BifAA0cKXiJkUDsPEzD/h4D7X1A==
X-Received: by 10.223.180.66 with SMTP id v2mr28235515wrd.93.1512772219119;
        Fri, 08 Dec 2017 14:30:19 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o48sm9688661wrf.85.2017.12.08.14.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Dec 2017 14:30:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Takashi Iwai <tiwai@suse.de>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] sha1dc_git.h: re-arrange an ifdef chain for a subsequent change
Date:   Fri,  8 Dec 2017 22:29:59 +0000
Message-Id: <20171208223001.556-4-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171208223001.556-1-avarab@gmail.com>
References: <20171208223001.556-1-avarab@gmail.com>
In-Reply-To: <20171128213214.12477-1-avarab@gmail.com>
References: <20171128213214.12477-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent change will change the semantics of DC_SHA1_SUBMODULE in
a way that would require moving these checks around, so start by
moving them around without any functional changes to reduce the size
of the subsequent patch.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1dc_git.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sha1dc_git.h b/sha1dc_git.h
index a8c2729278..41e1c3fd3f 100644
--- a/sha1dc_git.h
+++ b/sha1dc_git.h
@@ -1,9 +1,9 @@
 /* Plumbing with collition-detecting SHA1 code */
 
-#ifdef DC_SHA1_SUBMODULE
-#include "sha1collisiondetection/lib/sha1.h"
-#elif defined(DC_SHA1_EXTERNAL)
+#ifdef DC_SHA1_EXTERNAL
 #include <sha1dc/sha1.h>
+#elif defined(DC_SHA1_SUBMODULE)
+#include "sha1collisiondetection/lib/sha1.h"
 #else
 #include "sha1dc/sha1.h"
 #endif
-- 
2.15.1.424.g9478a66081

