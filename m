Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2B641F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbeFBEdq (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:33:46 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35627 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeFBEdM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:33:12 -0400
Received: by mail-lf0-f44.google.com with SMTP id y72-v6so17596866lfd.2
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GBXTMcv5l61RfMvZc0NNbOFU5+yTy6/CeV6dxEs5cls=;
        b=ftcb1TO/T0Lmsvfs9dKZLetcXPsaqNn5beL9GeJXVON6WfoOjMW1DQvOUgnzXMA64p
         96w1VGR8p0k5RHa4wU/WhCrg8+BZwRLTb4d0I1zKiPWUdEgWTw+NvvlowOUyEg7zpXXJ
         8kZT8ZRLbv658EvY+bIsDxgq01VXczjPbUazVS/8+xM9DBrum5rhZJoRa8nU4QDM/aXu
         WVvrp9et4sG6Cv4cgTXkj52rV3FvtPg2CQidFDYJYu1FSlsjAfnZe9H7SCcOJ3FCynuR
         2tXpbctLevK8rChlHJ1TwiD/TugU5H0+WVQbLWGofQeGwifyaZ5+trxRA4Cazp2LSpYF
         zwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GBXTMcv5l61RfMvZc0NNbOFU5+yTy6/CeV6dxEs5cls=;
        b=LVsQiGiyTGp85tbMBPh9S2rcfGVMXsSTytMOtYb8rZ+b1W77Tmvvir0dBU+H+sLwcy
         KwhTcXCFEr9C+sUxRWLOoI7tfFKQAALksVI/Q/goKDKyi2kuJhDxh6QeJrDBIqfH8r5B
         c813BJ9Y8BHW3lVtBI8SYOjvRHz9P7rzf0YhNjoME8+lAYTkYmoY9Y5AHZvOY+OMGftx
         RjFLXvfSRST1D1d6bWEIYIQOLDKJvNZQn7lYEucOaLjQPSZe3oVUMOzz4pswvj2XoYhu
         2ICetCcfiMXcEPnLF36T3d5APxZH7EIW0IYDHS23+9fakybVZp6xF96kIhqzTMh9tLsk
         ZVVg==
X-Gm-Message-State: ALKqPweQIr4+s9JK2LZCHzCSXtDgkEQUMGdu5wWbiQ6Ps0ddFHZLltI+
        Pa85ROf2sAPansaWFOqMIp3Mqw==
X-Google-Smtp-Source: ADUXVKJpMzBsOT5A7hFN2HBSSzS8ELQLavPvwJ9qEWugO9vbNdHxRipb88IkyEX3Jpx6VUCDTaZuSg==
X-Received: by 2002:a2e:594d:: with SMTP id n74-v6mr10117450ljb.128.1527913989612;
        Fri, 01 Jun 2018 21:33:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm644776lji.0.2018.06.01.21.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 21:33:08 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 18/22] replace-object.c: mark more strings for translation
Date:   Sat,  2 Jun 2018 06:32:37 +0200
Message-Id: <20180602043241.9941-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.309.g77c7720784
In-Reply-To: <20180602043241.9941-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 replace-object.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index 801b5c1678..ddc1546b8c 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -17,7 +17,7 @@ static int register_replace_ref(const char *refname,
 
 	if (get_oid_hex(hash, &repl_obj->original.oid)) {
 		free(repl_obj);
-		warning("bad replace ref name: %s", refname);
+		warning(_("bad replace ref name: %s"), refname);
 		return 0;
 	}
 
@@ -26,7 +26,7 @@ static int register_replace_ref(const char *refname,
 
 	/* Register new object */
 	if (oidmap_put(the_repository->objects->replace_map, repl_obj))
-		die("duplicate replace ref: %s", refname);
+		die(_("duplicate replace ref: %s"), refname);
 
 	return 0;
 }
@@ -69,5 +69,5 @@ const struct object_id *do_lookup_replace_object(struct repository *r,
 			return cur;
 		cur = &repl_obj->replacement;
 	}
-	die("replace depth too high for object %s", oid_to_hex(oid));
+	die(_("replace depth too high for object %s"), oid_to_hex(oid));
 }
-- 
2.18.0.rc0.309.g77c7720784

