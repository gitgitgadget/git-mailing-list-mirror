Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DA071F42D
	for <e@80x24.org>; Thu, 31 May 2018 19:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbeEaTxk (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 15:53:40 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35984 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754152AbeEaTxg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 15:53:36 -0400
Received: by mail-wr0-f195.google.com with SMTP id f16-v6so18797873wrm.3
        for <git@vger.kernel.org>; Thu, 31 May 2018 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0dJTfrSqCm+EZnTUhjCSuZkZt7wIfGxA8qJLDHnX2wA=;
        b=bIMejgsHaAjt3NNepW0QRJ8hsk9l1jnAoD5UDn22+bF/Mx9wP/fwyzqspi7gJ/AztD
         zs2cJjbtFGhSAS5DzAmF4kZU69P3Q59Eef6HxBR3l35xOHaLO0E3QTYAO2TNcvt4BcP+
         fumBGbdZ+Pz/0L/TDZV6kP2mo5VxVuJXkW2/Fa2ukrPGaRuzG7lhTsQUFXMftE40AYJ3
         UxghbyDi+tjviBMlzSEWzydg9M9/dLnfpzpvnMKzQoUwiYJhih3QXHRKb/4Y+YZC+RjV
         kaRxdnqRNZ/svW9XNDwXSaZxk45KduhPzSMzuE/9V2S+RpKhZKJZYrcnaOaMMQMveZ/f
         iW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0dJTfrSqCm+EZnTUhjCSuZkZt7wIfGxA8qJLDHnX2wA=;
        b=kujoyIZzYI8zKM8mQwXdGJVJzh2MpfT5C+wmQGr4OQtlABH1qZkx2aCBZLHDErvvuh
         bLADvvTLojqV0Z11JKaV7s9q4GA31W3EWiZV8IqPt3yHO264OCvp82raAOYqLzRmDDdg
         9VfRAlCsjYvMYtgAMqmnmWI3o91wtATXrhQpltewVyNUR7QJgTrSWEANDDRCYA1JYNdQ
         YCXNZFb8K38T5jQZkZe9SbyEYL3ILeWvRt6GZx/7eJz8vQyr2A0jusnPebHx2jbGuNDi
         91pyrNbZ5UOBDCRFekfWdB8PXUkLtH/YPJYQVu034B79Bj3wcQzDWcc+Wh9IWNTS1Zjg
         3hpA==
X-Gm-Message-State: ALKqPwdn482hCyrRkfLWKLbR/f/2GuHZoT+P8DX76t3T9glzap1SJgBz
        5YPKx1V5oGJmVXnTJO3RdScHIEae
X-Google-Smtp-Source: ADUXVKKA7yNTkotvvzWprwa+7IqaJpXMB0LtXFBRtWzH6tEZxbQxAsqs/hi1p+OKlVrOoypNDBNdAg==
X-Received: by 2002:adf:e084:: with SMTP id c4-v6mr6256916wri.199.1527796414728;
        Thu, 31 May 2018 12:53:34 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l10-v6sm19809118wrm.29.2018.05.31.12.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 12:53:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 7/9] builtin/checkout.c: use "ret" variable for return
Date:   Thu, 31 May 2018 19:52:50 +0000
Message-Id: <20180531195252.29173-8-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180531195252.29173-1-avarab@gmail.com>
References: <20180531195252.29173-1-avarab@gmail.com>
In-Reply-To: <87a7sg9sjz.fsf@evledraar.gmail.com>
References: <87a7sg9sjz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no point in doing this right now, but in later change the
"ret" variable will be inspected. This change makes that meaningful
change smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/checkout.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index ec7cf93b4a..423e056acd 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1266,9 +1266,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	}
 
 	UNLEAK(opts);
-	if (opts.patch_mode || opts.pathspec.nr)
-		return checkout_paths(&opts, new_branch_info.name,
-				      &dwim_remotes_matched);
-	else
+	if (opts.patch_mode || opts.pathspec.nr) {
+		int ret = checkout_paths(&opts, new_branch_info.name,
+					 &dwim_remotes_matched);
+		return ret;
+	} else {
 		return checkout_branch(&opts, &new_branch_info);
+	}
 }
-- 
2.17.0.290.gded63e768a

