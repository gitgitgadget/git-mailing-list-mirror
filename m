Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 816B920285
	for <e@80x24.org>; Wed, 30 Aug 2017 13:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbdH3N7i (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 09:59:38 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35350 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbdH3N7g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 09:59:36 -0400
Received: by mail-qt0-f193.google.com with SMTP id u11so5187866qtu.2
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 06:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lHTd/er/RiCgJOPu51F3vYe30iajzgX8+Nbfo85S47w=;
        b=W5lxOQ3lRYzDgfeO2k0JOKbZiRjwShoghJz3CJKF+yNRXTcq0xBOu3bzE0gcHnTRPa
         MZkeAp20GXcqIpU+myfUWmpvQ6x4TvZn0tZsk3Be6TyL9eJa9uHlV0HjPA1hA56bBzTC
         hZU2kdkO4+cJ7Xlj7+qh2GUUxWdKDiHfSpx7xiJm3JMtloe1WJ/KRGtaXT8hiV5QKtPI
         3zOdej5LfwQdDH6dNKF9Lfc9RYLrSLXLw5JQCxx4jrxahDFkfZMSr8tVkP+Qv4fZygCY
         bJkmdKni0gsVDandNvrPBHhluPB+2pyLVICE/qMNpYzC4oy1g8d/aROD1pzXg2spByeh
         eTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lHTd/er/RiCgJOPu51F3vYe30iajzgX8+Nbfo85S47w=;
        b=LalDMnwMR7gRnymHy1SEOm3mBbkVe1JQNhpISFDFZyNm+YtjZoL5YzKP+HQE7Shd4w
         L34a1jEbCuvluXh7EF3bTN49iRwCP4zqAgbfZb1sMzw0T3mABjeLBNle5ljg5yxnhQ2J
         Pxz0dSbu8Cybp0eFZ3vRMQ0kRhGrlN4hj3gdW05UuCOIra6VUX917FKt1lq19M1RmmtU
         SDF8JrecConDMSHJvfZdiYWTot5NB8LpJm1trzUp0qDnPC9nrTK7Dt1Wd2MDGIcWUqrU
         WoR/XIB6eAr5pHCpLd28vMerLP//6MtO9QX0ldQhJPOYMcc1l7EZ1khsaNPu/0onULUK
         I1gg==
X-Gm-Message-State: AHYfb5jcP907v//yMSrCNs0DIs4FTQ1fXcxQuUVqfFBhswHdbsFSHk/T
        5JMzzonuSKmwVA==
X-Received: by 10.200.28.123 with SMTP id j56mr2212370qtk.305.1504101575598;
        Wed, 30 Aug 2017 06:59:35 -0700 (PDT)
Received: from localhost (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id o67sm3577486qte.71.2017.08.30.06.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Aug 2017 06:59:34 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Ben Boeckel <mathstuf@gmail.com>
Subject: [PATCH v2] Documentation: mention that `eol` can change the dirty status of paths
Date:   Wed, 30 Aug 2017 09:59:32 -0400
Message-Id: <20170830135932.1738-1-mathstuf@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20170822174918.GA1005@megas.kitware.com>
References: <20170822174918.GA1005@megas.kitware.com>
In-Reply-To: <20170822174918.GA1005@megas.kitware.com>
References: <20170822174918.GA1005@megas.kitware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When setting the `eol` attribute, paths can change their dirty status
without any change in the working directory. This can cause confusion
and should at least be mentioned with a remedy.

Reviewed-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 Documentation/gitattributes.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index c4f2be2..b940d37 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -151,7 +151,10 @@ unspecified.
 
 This attribute sets a specific line-ending style to be used in the
 working directory.  It enables end-of-line conversion without any
-content checks, effectively setting the `text` attribute.
+content checks, effectively setting the `text` attribute.  Note that
+setting this attribute on paths which are in the index with CRLF line
+endings makes the paths to be considered dirty.  Adding the path to the
+index again will normalize the line endings in the index.
 
 Set to string value "crlf"::
 
-- 
2.9.5

