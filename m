Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D34820372
	for <e@80x24.org>; Fri,  6 Oct 2017 20:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbdJFUM4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 16:12:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34959 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752678AbdJFUMy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 16:12:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id b189so12342213wmd.2
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 13:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BzvKsPjj7Ds6OlMoErNIQSWnlqFORSF2TE0jeiU9DBc=;
        b=VQeKIXcRDZyI8Z6rWTEKhZoNaeaqqkUEfUXn+hCWPL2reyjUkIjeKfQXwXwit8rSJ6
         Oq8raP6tHl4rjFNIwiKIEWmnJClfpxpGojpaHAOdQEMDiHmMHUSTbAn4uvpQ3GIk/VeN
         ewoAmAlIwcLofXYY9rqibxuYyERn0n50pdnoc0y3nXtDxpwMvGsd+MyP72eStmETColp
         TAINGASgOaxXRbNJcqP6Sqzc8lqPIuOFx/X7eXwPtVFbwQqEEBij9HEZ7XZ660/x5D5v
         s5/F3+A/BPWaGR6QYlSbdyzBvl+HCsTfkmPMWDKcrSAJ1xPfYssuvNyT749OnU+1sjNz
         rrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BzvKsPjj7Ds6OlMoErNIQSWnlqFORSF2TE0jeiU9DBc=;
        b=iOIq9KmYOUrFrfxfVFDrERa5fAdGllMpmspxYqoWExfRAI6XAY/Xq5C1hzontvCt+p
         fZ4NvrMntxJdBXJD+r/dZgakU1W+Loph7QwSsf1Y3DSc8CwzfHcAhoTtIcn+KTnnOvNh
         9W6MIMVNxfI1ucVMnkJnPOhq0BKEgqqPpGmu1NgQHhssmDNk28TLyqs9pEPegkjZYfRg
         gVKOIpgZzSJUgqsbMrQdKvpFXBu5xv17xy25DHA0z+2hyrQsQ0nbXiivs9Sv/lZqDKem
         DvPHYxJ8TtM6NrttGEtsSxV7/ONttRk4ijd4G3W4Lzx6Eg4tIi+xHyRN/JAzkNGeWiC6
         qK8A==
X-Gm-Message-State: AMCzsaU+AJLvc6/VXySczj2jjDUQBDYBj/0JEnxVpI0Jpy5EuejEey7Q
        uNzMxSOeHJQg/AD2+huFqtkFhUipAQU=
X-Google-Smtp-Source: AOwi7QCou3EPUzBxmFRFKLc4y9aIk2fwF5jXBVIRVC9JPWsqSgi8Fv8TH9Ad1HPsKdf4S2EjZhCyEA==
X-Received: by 10.223.151.221 with SMTP id t29mr2947252wrb.34.1507320773438;
        Fri, 06 Oct 2017 13:12:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id h45sm2906522wrf.36.2017.10.06.13.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 13:12:52 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        Paul Tan <pyokagan@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/12] cache.h: document `write_locked_index()`
Date:   Fri,  6 Oct 2017 22:12:11 +0200
Message-Id: <8dc3834610b676c2eb64cfe2a08b8b3d05be05df.1507320376.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0
In-Reply-To: <cover.1507320376.git.martin.agren@gmail.com>
References: <CAN0heSqr77dptPG2mixnLdNKKcgD36aPnEFtnTB6Oyip6WfQBA@mail.gmail.com> <cover.1507320376.git.martin.agren@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
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
2.15.0.rc0

