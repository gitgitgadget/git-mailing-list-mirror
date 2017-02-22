Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E81F52023D
	for <e@80x24.org>; Wed, 22 Feb 2017 14:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932611AbdBVOFj (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:05:39 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34252 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932342AbdBVOFi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:05:38 -0500
Received: by mail-pg0-f66.google.com with SMTP id s67so549297pgb.1
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ij/tz3Yr2n1jQWv6xzwO+OBB/EenmTJ7KvY4JromhCs=;
        b=H++gohxZKyoeMXQM8x9L7yEjEDnfvWhLG2OxnpiqIn39nbiTVrQ2he35qTxKDCTmyG
         3vQQQGVVb1SVK+sjWAj0uj3jj2JPgH+Aha5Aq86dtuQ+Z1sZqIs6+HiTAI1lfrAHjoS5
         8oYTOBdmSrS7sewYpxrpfGyx7AvdU2x1Yw26LuuPOG/txux8b9wAfXcEx/xPcBwn2dqt
         NPeMsByh+onKp1shX3+9VG//Z6bTnyjukrmbrT++ay7Rx+q1KAX0p7JLZN7cNcAIHQ56
         TqRNJE1lSvSz/J4MRKvad/g69fnAhxidQ1HezxizXXYlSObCC/mp2IojmH3FCHN7HTbF
         zB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ij/tz3Yr2n1jQWv6xzwO+OBB/EenmTJ7KvY4JromhCs=;
        b=NMqGWa1XevqCrrwNi/Jl+Ft3q8wjLk+yxLLGqfFt28jvye8PUTY+qVFhcvz45aM16N
         AI7rtI42vNv/mY20OBbVbPgn9f9xiaUaTH6qv7F6UMTGYZrRbVHEcV0CZ34/OXxHy6Oa
         71GLojSwz47gG63V6yNq29ncQoceS9EMJMcf3AEq+p3T1HOilbPPA+Ebc7oWHPgqqjLj
         A0EbbUKakOdwLqEW7hOyiPURJROPfcsXLsysQHOZ/wAOyyokV3KkFaGXb7gaA73KJp5U
         2zGggQGzrsZIYatPsvj638031cGK+7jJcQPe6xdVeJvCrsxvNEc/P2+6qI84UF702R2X
         8s3A==
X-Gm-Message-State: AMke39mM6pKUgYSrvbeJeOF05c96ybYRNZ7I9C1DdSaWKHo6403/21Z63WLzVr1oB4SRxA==
X-Received: by 10.99.114.70 with SMTP id c6mr25490518pgn.163.1487772337179;
        Wed, 22 Feb 2017 06:05:37 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id 6sm2326667pge.30.2017.02.22.06.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:05:36 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:05:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 01/24] refs.h: add forward declaration for structs used in this file
Date:   Wed, 22 Feb 2017 21:04:27 +0700
Message-Id: <20170222140450.30886-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170222140450.30886-1-pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/refs.h b/refs.h
index 9fbff90e7..c494b641a 100644
--- a/refs.h
+++ b/refs.h
@@ -1,6 +1,11 @@
 #ifndef REFS_H
 #define REFS_H
 
+struct object_id;
+struct ref_transaction;
+struct strbuf;
+struct string_list;
+
 /*
  * Resolve a reference, recursively following symbolic refererences.
  *
@@ -144,7 +149,6 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
  * `ref_transaction_commit` is called.  So `ref_transaction_verify`
  * won't report a verification failure until the commit is attempted.
  */
-struct ref_transaction;
 
 /*
  * Bit values set in the flags argument passed to each_ref_fn() and
-- 
2.11.0.157.gd943d85

