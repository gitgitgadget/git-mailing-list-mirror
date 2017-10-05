Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B0B20370
	for <e@80x24.org>; Thu,  5 Oct 2017 20:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbdJEUc4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:32:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:46075 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbdJEUcz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:32:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id q124so4228304wmb.0
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DYlkwKbiCzB/8D810n5HGzaNcB0gnmCUwnEF0mlEHmc=;
        b=AEmVNxX2ArcLZ+QPnGBvE0k+43lV45Wj3nr91zrJTe2tRKWGD3tHHlYW/JwPQcWSuX
         wZesw8wi3TiB1/tiCCp+YSl+gJc2EEwQq2Pe095XgWT/8AvtCx3EGrwi7OoJ0/YJ/3jS
         aAjQSo8yc+k2f0TWtRS6p/kQxtH9DBHnwEynUb9Ho7yDddNA4s+KEyeRe95egw9Zjg2v
         cedLFYJ4FztIRyYxQmv9S6lJNukSNqJSJ4OstiByoi1edin1vLjvz2k5NSZ3qBz2jeg8
         hho6vnw1hlx2CTr/OfZCs2EuJdupRFIPSjFFSI9ArXh0B1FufsSsqvIgUmWQfcHn3E6m
         Y52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DYlkwKbiCzB/8D810n5HGzaNcB0gnmCUwnEF0mlEHmc=;
        b=leynjvvbe38WLkW8XLeEikc6yydvShliJGTvaIBuHpOmOPUslb4OYdJN8A0hAyJjm2
         fI0kKEoSkKjymNTxiueqKkIdCJDSKNZQ72XLy6SrjWrzf3NnnRjBLzUOQ2uO2sZm3iXt
         bD8YVgXa0HtuhI0rGPG6WLmPSF97aB3RkWLUKUe1ZZtl0H89uqnjEDKp+d7LuCw0sSdl
         nXc8lBdeSiwsI2SUklOGUEjdpx+W3aknzJND514iuzdT3HgKgWFNS8qbtjEwqwybftxj
         RNHMRyGvg+MYNsPs8ukyJGevhExcANeFWHxbcpvi+CwHkf2PrjmOZTY3l+1XzKEmHtwC
         CtvQ==
X-Gm-Message-State: AMCzsaV6dFgRvqfmCaMnD73RQ1wapBhuLWpz49h8cu92TH3YDXwZuqkP
        X/oK1Kj0yOWd9XmsfV5ZUgIif4Y6
X-Google-Smtp-Source: AOwi7QC9e0/KLunvorbsy12rAKz6R8kUI89Us+7YMz43I95eFyNHwV9gBx1ZWyNr+kBdTXm8Ihwbeg==
X-Received: by 10.28.93.84 with SMTP id r81mr245057wmb.149.1507235573692;
        Thu, 05 Oct 2017 13:32:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id i76sm698424wmd.2.2017.10.05.13.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 13:32:52 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/12] cache.h: document `write_locked_index()`
Date:   Thu,  5 Oct 2017 22:32:11 +0200
Message-Id: <5ece540d98b6e4b89a3002d8fd27a696b4ebd1ac.1507228170.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.2.666.gea220ee40
In-Reply-To: <cover.1507228170.git.martin.agren@gmail.com>
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com> <cover.1507228170.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The next patches will tweak the behavior of this function. Document it
in order to establish a basis for those patches.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
v2: Tweaked to go better with the changed approach in the later patches.

 cache.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/cache.h b/cache.h
index ea6c236e0..e9d9556e3 100644
--- a/cache.h
+++ b/cache.h
@@ -601,9 +601,25 @@ extern int do_read_index(struct index_state *istate, const char *path,
 extern int read_index_from(struct index_state *, const char *path);
 extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
+
+/* For use with `write_locked_index()`. */
 #define COMMIT_LOCK		(1 << 0)
 #define CLOSE_LOCK		(1 << 1)
+
+/*
+ * Write the index while holding an already-taken lock. The flags may
+ * contain at most one of `COMMIT_LOCK` and `CLOSE_LOCK`.
+ *
+ * Unless a split index is in use, write the index into the lockfile.
+ *
+ * With a split index, write the shared index to a temporary file,
+ * adjust its permissions and rename it into place, then write the
+ * split index to the lockfile. If the temporary file for the shared
+ * index cannot be created, fall back to the behavior described in
+ * the previous paragraph.
+ */
 extern int write_locked_index(struct index_state *, struct lock_file *lock, unsigned flags);
+
 extern int discard_index(struct index_state *);
 extern void move_index_extensions(struct index_state *dst, struct index_state *src);
 extern int unmerged_index(const struct index_state *);
-- 
2.14.2.666.gea220ee40

