Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 192F2201A7
	for <e@80x24.org>; Mon, 15 May 2017 12:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbdEOMXr (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 08:23:47 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34999 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbdEOMXq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 08:23:46 -0400
Received: by mail-qt0-f196.google.com with SMTP id r58so15179884qtb.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 05:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=56BBPIRql2rj2bhITCdObf1IZ+LCKK0vT4JUic+9hMQ=;
        b=WfN60be9bR4KnJxwwvpvUE/hRUo6p/mvUu58BRPb8yUxFCI7bYp1fNAjwD5jClaU3B
         NvH7cxKZcsFBLp/WwQA1KGhiH3PXWrgOaDr9afP4BkmNlIoj5LG/nk56CUBgtg2U5USU
         QCh1KwKleu4Ok3FoPUXKvRYJh4fsuQd094C+9WDWBQVWVao9d24ylMQSvWO6fFz/1Ssb
         fHfN45OvIMymnn4ggKJy16hBNCyQl86hE54ZG/xIupOyj6O2UKp9MWaXd2qiUMS7YeL1
         1isC6y8xm1SQGx8VOBcAFdiHftOG3nqO9Bim8edRMXuTVJOSoLy/t6iW1P9HCxgZoo32
         o1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=56BBPIRql2rj2bhITCdObf1IZ+LCKK0vT4JUic+9hMQ=;
        b=NygjfVeQ4CMTaHePIgD6hzE4vGPa8gc1pBFX4+tzap62e/7xVncWr5xT01cmQmJe5u
         kwJNZUoT4veNhW6aCd1jImSB6a5Kzcc9sm62NApumEkpDPeyDodsKv2f0D55v+YbzUgR
         m8v5hsn1JeGxjauO9bXuSOwkwgVkg4tslM91V4R1UJq2SAnfV45m/XeeUdW/bN4gQkwd
         BZQT+Qxmi08JVXwMKFWW+YrqjUV9CUyYxrwGr+CuWBsnXubBpL5hFE+lE9yMNx1kLmJV
         oNIy5qtuj5pIo5VIg4gv1OTmW3OJIn0B37iYcTUQaaW9REFf5iGIP1hRCiuczMJ5Sgac
         nY/g==
X-Gm-Message-State: AODbwcDK0ReTmgC/SHZhvRdP10cZL1hLlGVQhwf6K78hKsEb2JV8K2+d
        8PjJ6beOpHyx0g==
X-Received: by 10.200.49.75 with SMTP id h11mr5015442qtb.13.1494851025514;
        Mon, 15 May 2017 05:23:45 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y76sm8122414qka.51.2017.05.15.05.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 May 2017 05:23:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] tag: duplicate mention of --contains should mention --no-contains
Date:   Mon, 15 May 2017 12:23:31 +0000
Message-Id: <20170515122331.17348-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a duplicate mention of --contains in the SYNOPSIS to mention
--no-contains.

This fixes an error introduced in my commit ac3f5a3468 ("ref-filter:
add --no-contains option to tag/branch/for-each-ref", 2017-03-24).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-tag.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index f8a0b787f4..1eb15afa1c 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
-'git tag' [-n[<num>]] -l [--contains <commit>] [--contains <commit>]
+'git tag' [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]
 	[--points-at <object>] [--column[=<options>] | --no-column]
 	[--create-reflog] [--sort=<key>] [--format=<format>]
 	[--[no-]merged [<commit>]] [<pattern>...]
-- 
2.11.0

