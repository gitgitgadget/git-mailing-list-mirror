Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AE771F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 18:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeJMCOc (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 22:14:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42745 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeJMCOc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 22:14:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id g15-v6so14449862wru.9
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 11:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U+SCkoh6TZ2iBFSHdd7HQBlMzESxj43ZeSCtW6RUYYI=;
        b=o6vGFauhBqahU1cs2pSawcTgFAbBs63AS9phT+rJVXU2hu/GQtVx63p1u0y9/b4dmH
         aILrYraFQcy3cJ2U2glWGVRjmdCOwvYutuQnjtzAP72w51OG0NtyzpUKveRRvsJfsSv/
         9StsTEqmyFo+B911GOjvhU97dloei80ZptHSJYIqbBJcUOuj6lacxSCKGAHQmBi3T2Kc
         pSzFHHPYu3derkgrY8PxOBcZP0Jo6/ira6RxW9IMS1mzfPDTQjWxV/Ox5vhOc8fRDE/7
         n9Do5dwea28VrW9MOQRqSNMJ5JfIhTnGuQYiR/eK9jG/OxQhJEM6ZvuNh1yEt37wxIKm
         5GtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U+SCkoh6TZ2iBFSHdd7HQBlMzESxj43ZeSCtW6RUYYI=;
        b=RDa9czWl/kbi8j9wW70h28BhCzozgjF3Cb+O0YEws5GD2bPg7VC+gmA42O6UtngY8y
         kv+CF547J+6+3wgJ1v4yUQMViFVsztyMB4Ho4ZatEyDjtB2fwvRh0s9XmLwap8uA5yP+
         KBXUdG6Qh3mmb23WE3n7URmDcyoOUHg1GRQv3H3fifVHTj4m+eNxv8n3PP+I7Z58eRae
         AzB+4G8LE691XQvL0Nr8EB7cK41hTgP6LDsnzuSVPoqyWjiMm9YYKfi2oO0d1xBDv/Su
         aM0hDv9YOTrLwyb4H82C1YJsqQRrFRMfAAUKX9am1AoKmAc4mDbW93Gq+usnHsG10DPV
         mrdw==
X-Gm-Message-State: ABuFfog11kA1t3n9FmCT5vGiO9gGJ0pZWr0l/16GW1fFYbGAVDspzSWC
        Bmy4v/dPiGh03q/cHfXczDi+5+BI
X-Google-Smtp-Source: ACcGV63DTxydcPyLcUzBHiaPXRATxMjhtOVMZWXc4MBmEklsmveyO62hgqdO34FbNVOHWCLmLIyMbw==
X-Received: by 2002:adf:bf11:: with SMTP id p17-v6mr6083898wrh.235.1539369640866;
        Fri, 12 Oct 2018 11:40:40 -0700 (PDT)
Received: from localhost ([31.127.45.92])
        by smtp.gmail.com with ESMTPSA id t3-v6sm2093900wru.47.2018.10.12.11.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 11:40:39 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] config.mak.dev: add -Wformat
Date:   Fri, 12 Oct 2018 19:40:37 +0100
Message-Id: <20181012184037.15076-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.19.1.937.g12227c8702.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

801fa63a90 ("config.mak.dev: add -Wformat-security", 2018-09-08) added
the -Wformat-security to the flags set in config.mak.dev.  In the gcc
man page this is documented as:

         If -Wformat is specified, also warn about uses of format
         functions that represent possible security problems.  [...]

That commit did however not add the -Wformat flag, and -Wformat is not
specified anywhere else by default, so the added -Wformat-security had
no effect.  Newer versions of gcc (gcc 8.2.1 in this particular case)
warn about this and thus compilation fails with this option set.

Fix that, and make -Wformat-security actually useful by adding the
-Wformat flag as well.  git compiles cleanly with both these flags
applied.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

Sorry for not catching this before the patch made it to next.  

 config.mak.dev | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.dev b/config.mak.dev
index 92d268137f..bf6f943452 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -7,6 +7,7 @@ CFLAGS += -pedantic
 CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=0
 endif
 CFLAGS += -Wdeclaration-after-statement
+CFLAGS += -Wformat
 CFLAGS += -Wformat-security
 CFLAGS += -Wno-format-zero-length
 CFLAGS += -Wold-style-definition
-- 
2.19.1.937.g12227c8702.dirty

