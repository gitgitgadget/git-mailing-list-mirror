Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC24F20248
	for <e@80x24.org>; Sun, 24 Mar 2019 21:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfCXVz4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 17:55:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40008 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfCXVzy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 17:55:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id t5so7907547wri.7
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 14:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mMemE2tYx2P4r8MS44OzkruoH1ouuk/8t5m3Z4hLimw=;
        b=skT/ucsUmI1h4ggj6yQ1+tqRO9FZVJQI7kPtnqZgtq5kVRFFY4Xl2zW29csLv76CVI
         Qz5CqklqvefmzUeFmqHoUhu5eRwXDlbF0W7CqZXBQW3EriBZd5zf0TLnhB72Vq1zrDsd
         w/qKDGrhynK9T5qcs0oqnM9jdlvLpRz91NCx4XbzGoloa77G7Y472MIawt8go7HS/ppZ
         VRRwal+Ci5yuDLiUco82aGVL9vkYbh2iVo2dgtOlKbEMwzM9mbd16BVwUuqmnk+nwrdg
         TmlicCZ8ygrmiGIJNlTTTnSYWW0HMf9UobHBImulKWQtJeGfbZ2rL5anYpWZU8dKRrf9
         Bfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mMemE2tYx2P4r8MS44OzkruoH1ouuk/8t5m3Z4hLimw=;
        b=PYlCdRr+onJ5RLxDUgkeMgbhxVGSi6QkZM7MmCa5H/l+CF98UfemHZ5K/jHMQBMMBw
         pbDqbOVJguOR5glHfiQ9P88gnqFIqDhFPT/VdvGB1fAQrhXOF2heaCOuaRVT+axntwCz
         yStDpZnDynv2VzvbWymeeoSdWcmF9rcZ+/bsniQzN9Rf1otBns4M+CtwsO//3yEAL/qQ
         9GQhQLy6vJqL7WPbSPUEh6ozjwONTASeodX1K1kMn74bN2OK3w/RdoeMcNwysYv98WK0
         piEarNlc0VFe3xXiPmrRS1xGg9HG1QCXjAFrq9p44NdijQ2a4wyCtfBnHLTksf0Cig1Z
         mS4A==
X-Gm-Message-State: APjAAAWiRBW9wdilC4vIVadysHpvv9QF/+gVOY3+47fP0uVMnf0DOHVx
        ua4xmkFoStSgwB2bdGz6t8682qoX
X-Google-Smtp-Source: APXvYqx1vA/UwarMmQBdd48Yujw4yJFezo67IXoxdX6PnrsDNOiYQAq+19w/s74XKMha1xZ0XaTaPw==
X-Received: by 2002:adf:afd0:: with SMTP id y16mr13003395wrd.328.1553464552716;
        Sun, 24 Mar 2019 14:55:52 -0700 (PDT)
Received: from localhost.localdomain (x4d0c479e.dyn.telefonica.de. [77.12.71.158])
        by smtp.gmail.com with ESMTPSA id o17sm15023530wrw.73.2019.03.24.14.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Mar 2019 14:55:52 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 5/6] ci: stick with Asciidoctor v1.5.8 for now
Date:   Sun, 24 Mar 2019 22:55:33 +0100
Message-Id: <20190324215534.9495-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190324215534.9495-1-szeder.dev@gmail.com>
References: <20190324155219.2284-1-szeder.dev@gmail.com>
 <20190324215534.9495-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The release of Asciidoctor v2.0.0 two days ago broke our documentation
build job on Travis CI, where we 'gem install asciidoctor', which
always brings us the latest and (supposedly) greatest.  Alas, we are
not ready for that just yet, because it removed support for DocBook
4.5, and we have been requiring that particular DocBook version to
build 'user-manual.xml' with Asciidoctor, resulting in:

      ASCIIDOC user-manual.xml
  asciidoctor: FAILED: missing converter for backend 'docbook45'. Processing aborted.
    Use --trace for backtrace
  make[1]: *** [user-manual.xml] Error 1

Unfortunately, we can't simply switch to DocBook 5 right away, as
doing so leads to validation errors from 'xmlto', and working around
those leads to yet another errors... [1]

So let's stick with Asciidoctor v1.5.8 (latest stable release before
v2.0.0) in our documentation build job on Travis CI for now, until we
figure out how to deal with the fallout from Asciidoctor v2.0.0.

[1] https://public-inbox.org/git/20190324162131.GL4047@pobox.com/

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 76ec308965..52a44c690a 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -56,7 +56,7 @@ Documentation)
 	sudo apt-get -q -y install asciidoc xmlto
 
 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
-	gem install asciidoctor
+	gem install --version 1.5.8 asciidoctor
 	;;
 esac
 
-- 
2.21.0.539.g07239c3a71.dirty

