Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5602082E
	for <e@80x24.org>; Sat, 24 Jun 2017 07:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbdFXHXO (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 03:23:14 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34902 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbdFXHXO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 03:23:14 -0400
Received: by mail-wr0-f195.google.com with SMTP id z45so17616401wrb.2
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 00:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ajRwrCsI7mTqwgYap1VDO2lEoQEZTCDqgPRBskgdw8I=;
        b=PHIT+UrLD65WQsSp+O3YTUoxwyFPss9GumMXoKTRk57dX3A6V+7WNcpVQGdFLUGVTi
         OCQzEdW9CRTW2aU5vdDQngJO0lZKpS9QeLKhKtZtWr0306gKR2Pue+fTsOu5WzCHv8HF
         mxbOvOZX2KjoG1H5jcbqeyuS/dqm9L7YFIKEbn+fATw2Q+QoqxJHTD0uxqVZSb2L5zGY
         Q5AiIOEPtrY7mQx3JkB4ADcorrfcuzWN67IxcDxU19QrKpYoK6gIpv+DL2xvnTHQeVGK
         lTcfMAimhLeIL8+nGKOuK/SHoYj5nHXlZTGb+t3WPtGeccBmRog+Sy/N4puYEW9+wZ1R
         EGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ajRwrCsI7mTqwgYap1VDO2lEoQEZTCDqgPRBskgdw8I=;
        b=la0AusXI4z3LXJeJ78rvUkDXXl6+Pd2db3dvk5xcMzE0mPyU+HNIgg2fI3u3DjdLYc
         LqCiPJ9UBEkaDWnR/LvZjOhjfkghXkjDT07VPZAamzlnwrM/wJXNmvf+RAWNoaBWren3
         hy/puvd9trq3OEglXCyLCXK1VQgibwcDWX3MYrJkurNXuJrJ9jDeG3923s7MzX9sIjjR
         obt5hH7XadvGlMeiY835Tq+0D6bSuCwtkC7ertCZc/CizIgC3g2Ufa+Hojt1hOLT2nhz
         EUHQTf7t07zHkxBJC/TV5n8UUkc1E1qN/3F1uOQDDIKINRA6fxypQdqmpqj+Ds7/p7kQ
         679g==
X-Gm-Message-State: AKS2vOw2NllDVO9jJu1x9hdBWgLNGlrm2SkG3N0mB1sK9lG8U764IQ6Z
        S8q36aMWJHhK/FcPjJI=
X-Received: by 10.223.152.34 with SMTP id v31mr7983801wrb.60.1498288992427;
        Sat, 24 Jun 2017 00:23:12 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:3418:cc00:d84:6e88:dbd5:afa9])
        by smtp.gmail.com with ESMTPSA id v5sm4114474wrd.22.2017.06.24.00.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Jun 2017 00:23:11 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH] doc: clarify syntax for %C(auto,...) in pretty formats
Date:   Sat, 24 Jun 2017 09:22:58 +0200
Message-Id: <20170624072258.6832-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The change actually adds only 

	(e.g. `%C(auto,red)`)

but reflowing the paragraph blows it up a little.

-------- 8< --------
The manual correctly describes the syntax with `auto,` but the
trailing `,` is hard to spot in a terminal.  The HTML format does not
have this problem.  Adding an example helps both worlds.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/pretty-formats.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 38040e95b..b03985101 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -174,11 +174,12 @@ endif::git-rev-list[]
 - '%Creset': reset color
 - '%C(...)': color specification, as described under Values in the
   "CONFIGURATION FILE" section of linkgit:git-config[1];
-  adding `auto,` at the beginning will emit color only when colors are
-  enabled for log output (by `color.diff`, `color.ui`, or `--color`, and
-  respecting the `auto` settings of the former if we are going to a
-  terminal). `auto` alone (i.e. `%C(auto)`) will turn on auto coloring
-  on the next placeholders until the color is switched again.
+  adding `auto,` at the beginning (e.g. `%C(auto,red)`) will emit
+  color only when colors are enabled for log output (by `color.diff`,
+  `color.ui`, or `--color`, and respecting the `auto` settings of the
+  former if we are going to a terminal). `auto` alone (i.e.
+  `%C(auto)`) will turn on auto coloring on the next placeholders
+  until the color is switched again.
 - '%m': left (`<`), right (`>`) or boundary (`-`) mark
 - '%n': newline
 - '%%': a raw '%'
-- 
2.13.1

