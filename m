Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C713320372
	for <e@80x24.org>; Fri,  6 Oct 2017 20:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbdJFUNC (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 16:13:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52114 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbdJFUNA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 16:13:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id f4so10071337wme.0
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 13:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=irl2TFa837MQAFGvxXS3XX5K+aI+H7UBnAXo80yU4Z8=;
        b=vI2sHSywWqXAdCPHO5Fl554WXmEQTnaSesWueQ8uZIgI9tSuCW+uCHPWH52T7V66Qb
         q5ih8pQdr78bc53Sg7JFLPeRjuDNZp6avdPn7Mtav3JWdC9dbmynGV8BjgTuEh352Q4O
         8bP4jqHguTAsk8hRTCyzdQEz5pAALET4U8zS8ac8/9k1m1Y9mEDon1MxHcZBijuARYTK
         zfuCWRAc1cEqd+BGkhj5iBTRnTGJlt7rekJpxUFKJpkqd8EezB1sskmYgZXwvi2lzOl/
         wA92QUxSrDLfbh6d4NAa1uY6zBJIo8e8YfAGQskDc9zAzwNMgPKyXAH2G/xt4wzxHnIP
         p6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irl2TFa837MQAFGvxXS3XX5K+aI+H7UBnAXo80yU4Z8=;
        b=p5U9dPGYZ8dCrFE8HVbBsaJFLD/WHfOgQcOX1KPEv3Jmk0eC1rNM1nJnF5CYY3PCDN
         pCmrl9H6dNkDdAkhi6+73zCbKKa7n295N93H0EwApKIX+4k+CD1TttN80XC2Ev3nVtps
         VVh4wMNLvSf5b/AxohtOP/PFP+wourNqlL7N/k6Uw/G2VpMfgWFn7lGuIp9zFNYFzT0D
         15JvJ0BZBMC7HSXOQM5z4jNjdNneLtv1rnwQvEL3hXhVoIXpVvvx7lkVjzXcP0pe0m2L
         rXtwn0fTK/LJXmma43vJL0LDavE+mC5MjZLB+xRjhfA+nLA9K+pZHFJEZYYAZkVvs7C7
         Jc5w==
X-Gm-Message-State: AMCzsaUfqlSGIyV3MXAwAgkdiz1vxdDT3yvVRvrxS9LDGbFe+Xy0uecb
        eqEm3UNgUI6CyH7C9mylh2rvwH4C9x4=
X-Google-Smtp-Source: AOwi7QBKcEx5vUXBhHDmavsEXNILhMGS8avTBjOK7QD2bVefEIv6FqB2CF/mknjUNS0jtu36qJG6/g==
X-Received: by 10.28.215.4 with SMTP id o4mr2642214wmg.0.1507320778945;
        Fri, 06 Oct 2017 13:12:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id h45sm2906522wrf.36.2017.10.06.13.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 13:12:58 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        Paul Tan <pyokagan@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 12/12] read_cache: roll back lock in `update_index_if_able()`
Date:   Fri,  6 Oct 2017 22:12:14 +0200
Message-Id: <d7e1a460350b084943479a562774d570028afa0e.1507320376.git.martin.agren@gmail.com>
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

`update_index_if_able()` used to always commit the lock or roll it back.
Commit 03b866477 (read-cache: new API write_locked_index instead of
write_index/write_cache, 2014-06-13) stopped rolling it back in case a
write was not even attempted. This change in behavior is not motivated
in the commit message and appears to be accidental: the `else`-path was
removed, although that changed the behavior in case the `if` shortcuts.

Reintroduce the rollback and document this behavior. While at it, move
the documentation on this function from the function definition to the
function declaration in cache.h.

If `write_locked_index(..., COMMIT_LOCK)` fails, it will roll back the
lock for us (see the previous commit).

Noticed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h      | 4 ++++
 read-cache.c | 5 ++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 0e26224b9..8c2493766 100644
--- a/cache.h
+++ b/cache.h
@@ -734,6 +734,10 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 extern int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
 extern struct cache_entry *refresh_cache_entry(struct cache_entry *, unsigned int);
 
+/*
+ * Opportunistically update the index but do not complain if we can't.
+ * The lockfile is always committed or rolled back.
+ */
 extern void update_index_if_able(struct index_state *, struct lock_file *);
 
 extern int hold_locked_index(struct lock_file *, int);
diff --git a/read-cache.c b/read-cache.c
index 0d8d2dede..87188d390 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2176,14 +2176,13 @@ static int has_racy_timestamp(struct index_state *istate)
 	return 0;
 }
 
-/*
- * Opportunistically update the index but do not complain if we can't
- */
 void update_index_if_able(struct index_state *istate, struct lock_file *lockfile)
 {
 	if ((istate->cache_changed || has_racy_timestamp(istate)) &&
 	    verify_index(istate))
 		write_locked_index(istate, lockfile, COMMIT_LOCK);
+	else
+		rollback_lock_file(lockfile);
 }
 
 /*
-- 
2.15.0.rc0

