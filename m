Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE683202AA
	for <e@80x24.org>; Wed, 27 Feb 2019 18:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfB0SSZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 13:18:25 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41914 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729577AbfB0SSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 13:18:25 -0500
Received: by mail-lj1-f194.google.com with SMTP id z25so14756489ljk.8
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 10:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lm3VpTi4rV0BJJp9W7KdITBxIGnT6raINZ5B1Q+EoOQ=;
        b=DHUYpj0FfogYuE9ukPgFKeWNCdfvHx9iP1PpyywmCZy8M8+zWJOf3ZbtXcsn0EAOPR
         UPkTkb/uZ008Bx1Iy6vDRlmCR6gXqwkrHta1sBcYF5CVgHWq+nQCDYhxC2F3ZZLJKiOw
         ojAbG+Op1qKpx0e6zRLu0gkAhrSNstoxO1BqPr+Dd63MIHuqhQbOiOuJHC/9FzoOI6mP
         B3ybzKUghSIi2Ny1mYwrgMLTynipwjHyIVMcY/Yf8tdxOvDDIrGSLAzob1cTJvv77wje
         xgYgtP4WjUWnhUXN/gAE2iID+BX1jh2B4Jy9avSnfYUclwph4znnENwXA8hFbRXI1jXn
         Xdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lm3VpTi4rV0BJJp9W7KdITBxIGnT6raINZ5B1Q+EoOQ=;
        b=OURg1pEnxSNCK0DXIqPiKRbszeECfed5PhrtmcPOPUf8BR5aqLT/5vuK1MQUds86bx
         ZPwRk4pzjrly5w8tlo/H8HmVhMrJVkoZHhaKKVlP02oqXGk3tJe449YQkHnFphiHQUlS
         QHIVX1cpUtllklGMBFOISdeqBFsPXkFNiDNZtZPw4nADCpodSQTngcC2/M/9faY26gav
         51bL5igLBV04VnqkPBeFMBWYem5v6WBM2gHidXeKnT7AC7doIbuD45CeD01MKAXvOvpc
         9RgDFPBhMKPVhsDiibDD3GnxfkyGtmn9PWl/4HdFfraE/XLm6y1PxPyw0UPy4bMBztkC
         dTTw==
X-Gm-Message-State: APjAAAVR9xaxgG0eWRVKX/th5qAP3L1oxoXm29LEPWM/QIgBAhNYXW3K
        ia1Smt8OnGwZjdAhPVSxFbSiKTtM
X-Google-Smtp-Source: APXvYqyBAUCmAmDWsD1B1lHQ6u4W/mKkRDrjCpLtk7rXI1+UjjUl81sQFwPhDls+GU5hfIJaNFE1Ww==
X-Received: by 2002:a2e:9c8e:: with SMTP id x14mr2327606lji.166.1551291502361;
        Wed, 27 Feb 2019 10:18:22 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id f19sm547297lfk.69.2019.02.27.10.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 10:18:21 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/3] asciidoctor-extensions: fix spurious space after linkgit
Date:   Wed, 27 Feb 2019 19:17:54 +0100
Message-Id: <e1021ad4a97a78e7428fcdfbf2af7196a0c8d340.1551290936.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1551290936.git.martin.agren@gmail.com>
References: <CAN0heSqLbn7dRu4eARpyMqhFYpj3Pr5i=EMPnQZK9hUfWmf-KQ@mail.gmail.com> <cover.1551290936.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we render, e.g., "linkgit:gitglossary[7]." with Asciidoctor, we get
"gitglossary(7) ." with a space between the linkgit macro expansion and
the punctuation. We can fix this by dropping the trailing newline after
we've turned `linkgit:foo[bar]` into `<citerefentry>..</citerefentry>`.

The diff produced by `USE_ASCIIDOCTOR=Yes ./doc-diff HEAD^ HEAD` is
almost 6000 lines large and shows how this fixes "git-foo(x) ,", "(see
git-bar(y) )" and so on. One might wonder whether this also turns, e.g.,
"see linkgit:foo[1] for more" into "see foo(1)for more", but no. We get
"...</citerefentry> for more" in the XML, see, e.g., git-am.xml, so the
space ends up in git-am.1 just fine.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index ec83b4959e..f7a5982f8b 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -16,7 +16,7 @@ module Git
           "<citerefentry>\n" \
             "<refentrytitle>#{target}</refentrytitle>" \
             "<manvolnum>#{attrs[1]}</manvolnum>\n" \
-          "</citerefentry>\n"
+          "</citerefentry>"
         end
       end
     end
-- 
2.21.0

