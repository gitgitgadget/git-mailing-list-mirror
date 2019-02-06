Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ACA51F453
	for <e@80x24.org>; Wed,  6 Feb 2019 02:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfBFCvc (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 21:51:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39333 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfBFCvc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 21:51:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so2287434pgp.6
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 18:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LetYkmAmK/cg9Z1ZDrRcBH9WL8FzjnqPjAW1V6bQvU4=;
        b=XsxGV9rry7ByK8Erm0cSWthSqnyYJxc4tc03DLmumIOCtOrpWGuILekjAh3lA8QIHH
         2f9y5kXqthNg+19RwyxiWByxqbFC2mtjQW9ssXSlS0dfYP5421BNdsw3kD/PnCy+skjq
         nlbgIPxRr1lDfcxj6XrvLbqEfxBbEKJ9b2EMnNLCjQfV1PT28ZGHbZJU61uBbclD36Pa
         6uJj8f/ChxSkavCZNag1gNPgsDv8bQcZ5s5EpCM1q1pfukpvmO9pDeQb8+3jm2f2ucaJ
         mnN/3sMPnJs+BXETC1Zbk26+rKDHlvQDB8qciYMPd7qaV3ortdCDieFLAvGGuJLJ7OtO
         2S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LetYkmAmK/cg9Z1ZDrRcBH9WL8FzjnqPjAW1V6bQvU4=;
        b=abNAFO+t+K7iH2lVYD+st6oom2jWk+ZeTlDYIk7gsiywq1YrpQXBhxZVCRUg3ddOUY
         2jNY4YB1yRa7ITRDAqlnzrd8kGpMRLrj0b6LNRpEPEfkfCGlrs0F04gA/MozhYUPreyn
         rSVbxYKMvHzm8JXxjcyDwza+iQKO00GGlI4s/v0BShVo/SF5kmcn6KAyV9dlFZwk9BNr
         VZ9cNVudIzQEYZ20SsWW0SGs2mV6NtZMrT48WP28OTsF+4xaWCloiUwCjOX//WqUVOaL
         9jzmFvtVIrAMwhJRmOre3ASbjtivyonO5qO8KSCVFSKBfB9Dz8nWRRyqLeHiJqFH+DeD
         ehSg==
X-Gm-Message-State: AHQUAuaRqsyyiYxe7GBFVJYEV7QQ/0Y6rIVIf2D/UR+KW3BnHCKYFS5O
        0NO0i03ieTLT3ks+P6j+Q41YQdIo
X-Google-Smtp-Source: AHgI3Ibl2HAEUgoazvsP19LCgWvwEUBVTmXb0enNLOP00naHHb16+Tlh8D+Pl58sjAX7ZLSfIKfDAA==
X-Received: by 2002:a65:624c:: with SMTP id q12mr7539994pgv.379.1549421491253;
        Tue, 05 Feb 2019 18:51:31 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id i8sm10637380pfj.18.2019.02.05.18.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 18:51:30 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 06 Feb 2019 09:51:26 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/2] checkout: update count-checkouts messages
Date:   Wed,  6 Feb 2019 09:51:14 +0700
Message-Id: <20190206025115.26163-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190206025115.26163-1-pclouds@gmail.com>
References: <xmqqimy8a1gx.fsf@gitster-ct.c.googlers.com>
 <20190206025115.26163-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 0f086e6dca [1] counts the number of files updated by "git
checkout -- <paths>" command and prints it. Later on 536ec1839d [2]
adds the ability to remove files in "git checkout -- <paths>". This is
still an update on worktree and should be reported to the user.

To prepare for such an update since that commit is on track to
'master' now, the messages are rephrased to avoid "checked out" which
does not imply file deletion.

[1] 0f086e6dca (checkout: print something when checking out paths -
    2018-11-13)
[2] 536ec1839d (entry: support CE_WT_REMOVE flag in checkout_entry -
    2018-12-20)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9f8f3466f6..6e33850d9f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -393,15 +393,15 @@ static int checkout_paths(const struct checkout_opts *opts,
 
 	if (opts->count_checkout_paths) {
 		if (opts->source_tree)
-			fprintf_ln(stderr, Q_("Checked out %d path out of %s",
-					      "Checked out %d paths out of %s",
+			fprintf_ln(stderr, Q_("Updated %d path from %s",
+					      "Updated %d paths from %s",
 					      nr_checkouts),
 				   nr_checkouts,
 				   find_unique_abbrev(&opts->source_tree->object.oid,
 						      DEFAULT_ABBREV));
 		else
-			fprintf_ln(stderr, Q_("Checked out %d path out of the index",
-					      "Checked out %d paths out of the index",
+			fprintf_ln(stderr, Q_("Updated %d path from the index",
+					      "Updated %d paths from the index",
 					      nr_checkouts),
 				   nr_checkouts);
 	}
-- 
2.20.1.682.gd5861c6d90

