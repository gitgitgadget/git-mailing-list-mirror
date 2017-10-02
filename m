Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C855620281
	for <e@80x24.org>; Mon,  2 Oct 2017 17:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbdJBRaV (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 13:30:21 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38496 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbdJBRaU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 13:30:20 -0400
Received: by mail-pf0-f196.google.com with SMTP id a7so6354533pfj.5
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 10:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2XbSCzX75ioKvL0i2Brkvt/7wtJUvGuZ8nkV7x0rhyI=;
        b=oPVXKEdhBggO/kwzEZjwiJn4Ktd4fwc4zamgjmCgTQS11ixIMgR3GRoIfJKTdvHCGd
         pguxY2mArqZLr/fxCNBIIXli5DM2OAPrkf4OXqn1uENFtKZNzshjoewKTF/fp4tNdXwp
         YhjfY9P3wDVEVriGKNFLsEBfk2yNKklRQa+F5c16tOLFz5ZE0R6LEu6ckIL+5nyny7GO
         tqHyANzaAq+TBuId06pyTAylvGKUjPmb2ZmLFqsoUjUbTIv3+FAckkQiQb0nIjXLIVnJ
         t+FeWZBitISIy9zPslEXJlolhG9pM6eHajSKIRrHr1iC/h3Vch/dEsBxE4BvdexDsdKn
         eBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2XbSCzX75ioKvL0i2Brkvt/7wtJUvGuZ8nkV7x0rhyI=;
        b=e7HAcquaeaeA3iKhwIntjxpJaF599A1sRmepYucvvhnoSfZ5SJzxQOiy68aGSMNJDa
         K+vUmrtvkmZFpZzkmOc/U9GrAFoA5+T0O07zhp7BfgWsfRgbr9QsorNTA+3ypY4yWmEJ
         8P3wuQAYwSZGddUsjQTi2kfuSQxP1jcvN9bVX+F0Noo2BI6fk61l0atCvXrIKh2ffRzs
         sojx9/gG9RZoGVdcVIA9lRBq/8XxCzgH/lYQj2SdZfX4nnNnuFiRCBif2gSr8hQvp+iw
         vCPDiuNwtgzs3ys8g4Om9tOIdr6gKgTgv6fIht5NPrtzkgAbDZvdgatJNAFW6VezSs3a
         FtMA==
X-Gm-Message-State: AHPjjUjroGtliwFTzVtj/816onZ3SaRPPiak74+ENxVjgLqt+Mcl9Xkp
        l/SmGj14hF0Xc9nDCGs2z98AOl8z
X-Google-Smtp-Source: AOwi7QD97u60ehGEikrRkIKJCGXf1/ducIx4GGCd24ixQS5/578sAb3lmda39o/C/Hz+nZgKx803ww==
X-Received: by 10.99.143.14 with SMTP id n14mr12922971pgd.107.1506965419871;
        Mon, 02 Oct 2017 10:30:19 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7287:7232:c31:a746:72c9:9586])
        by smtp.gmail.com with ESMTPSA id g25sm17640660pfg.166.2017.10.02.10.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Oct 2017 10:30:18 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Google-Original-From: Kaartic Sivaraam <kaarticsivaraam@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: [PATCH v2] setup: update error message to be more meaningful
Date:   Mon,  2 Oct 2017 23:00:02 +0530
Message-Id: <20171002173002.4278-1-kaarticsivaraam@gmail.com>
X-Mailer: git-send-email 2.14.1.935.ge2b2bcd8a
In-Reply-To: <xmqqlgnbq7sc.fsf@gitster.mtv.corp.google.com>
References: <xmqqlgnbq7sc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>

The error message shown when a flag is found when expecting a
filename wasn't clear as it didn't communicate what was wrong
using the 'suitable' words in *all* cases.

        $ git ls-files
        README.md
        test-file

Correct case,

        $ git rev-parse README.md --flags
        README.md
        --flags
        fatal: bad flag '--flags' used after filename

Incorrect case,

        $ git grep "some random regex" -n
        fatal: bad flag '-n' used after filename

The above case is incorrect as "some random regex" isn't a filename
in this case.

Change the error message to be general and communicative. This results
in the following output,

        $ git rev-parse README.md --flags
        README.md
        --flags
        fatal: option '--flags' must come before non-option arguments

        $ git grep "some random regex" -n
        fatal: option '-n' must come before non-option arguments

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Changes in v2:

    Change in error message.

 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 860507e1f..09c793282 100644
--- a/setup.c
+++ b/setup.c
@@ -230,7 +230,7 @@ void verify_filename(const char *prefix,
 		     int diagnose_misspelt_rev)
 {
 	if (*arg == '-')
-		die("bad flag '%s' used after filename", arg);
+		die("option '%s' must come before non-option arguments", arg);
 	if (looks_like_pathspec(arg) || check_filename(prefix, arg))
 		return;
 	die_verify_filename(prefix, arg, diagnose_misspelt_rev);
-- 
2.14.1.935.ge2b2bcd8a

