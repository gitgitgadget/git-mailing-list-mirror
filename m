Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFF721F406
	for <e@80x24.org>; Sat, 16 Dec 2017 12:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756820AbdLPM6D (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 07:58:03 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33453 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756320AbdLPM6C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 07:58:02 -0500
Received: by mail-wr0-f194.google.com with SMTP id v34so4331508wrb.0
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 04:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W5NXPKUHLGgW/EsDSwH1/VlzM5+f53wERuvT+CQL0EA=;
        b=aL5FJx2e1wrnJLtFADf0ag4E4Y576la3pIClj15EWcq1b0AkadhnWHFAgCccLTNzSS
         dUTpEWx0xJzyM0R3HiHnHP9fUOMFq2uc9+fKsTwNYECRWXJIL40KzrlkCyMpfzD2srDj
         z1JpeqArHr95P009SXnawkpZ6MCQd/55+IXcGmBA8g5C0CQiN/0EIWaUAmntEUDmFIM4
         FjISYNctvKWV9KnYP1bLDxK+MBiW8MLxQTHTC2gvW7kTv1O9pPW1iW/oxWYkYC2q/YFo
         XxV64aS+oPjaN48DSUTn/nKuU/ZJ8nTPmhV04GrtMlc6hn9RvrKrYFydvRY21E3CVdx5
         5ycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W5NXPKUHLGgW/EsDSwH1/VlzM5+f53wERuvT+CQL0EA=;
        b=bxfGGbvb/7Iyrrv6hV32cJB1O41LArN3WLvXG5q77NuCMg5wPU6VMckVZR8njjUtLH
         N28lgetQE5T07yDXrqVoyRt4zkgcvTpNXzvGGFhA1BafvGOv5/4ComiFmYsY11A1e+2D
         tIbs7puDUZoBBUBtj97ydvvZly3dUl1VWChPzIgTVVKq8FfdmFtsq4LpXxW2uy9dUWXH
         B46i73Hx4SzdEVh06Uf8F2yTevqc6aagnPAgXAGPBY7rmZhIshBarKOX9phduo0ZsS8H
         BTTW1T30JCoq3s3lo4QTkBLG4HmdgQsdR923V1JlDEDhuc6ew9LX/TkuJO0NXQrZuSbW
         WxCQ==
X-Gm-Message-State: AKGB3mLJtN+2xOkitQ8fKGOL+TnOPtZsK9WruIyRzguK/eieb9fua//7
        gbEPwTgpfu7/18FZ4xi+WSg=
X-Google-Smtp-Source: ACJfBouaAAMQSNkPJbaGL1ZWegBFqbpFkSyNbsPACMccMoE1QJp8BHL2HopejWD/Rvw9IUHtDK2npQ==
X-Received: by 10.223.161.158 with SMTP id u30mr12964256wru.96.1513429081368;
        Sat, 16 Dec 2017 04:58:01 -0800 (PST)
Received: from localhost.localdomain (x590e5997.dyn.telefonica.de. [89.14.89.151])
        by smtp.gmail.com with ESMTPSA id 19sm12204819wmv.41.2017.12.16.04.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Dec 2017 04:58:00 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 6/8] travis-ci: don't install 'language-pack-is' package
Date:   Sat, 16 Dec 2017 13:57:58 +0100
Message-Id: <20171216125758.11120-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.429.ga000dd9c7
In-Reply-To: <20171216125418.10743-2-szeder.dev@gmail.com>
References: <20171216125418.10743-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since we have started to use Travis CI in 522354d70 (Add Travis
CI support, 2015-11-27), our 64 bit Linux build jobs install the
'languate-pack-is' package.  That commit doesn't discuss why it was
deemed necessary back then, but Travis CI can build and test Git
without that package just fine, even that commit introducing Travis CI
support.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 .travis.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 4684b3f4f..ea11b5af6 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -17,7 +17,6 @@ compiler:
 addons:
   apt:
     packages:
-    - language-pack-is
     - git-svn
     - apache2
 
-- 
2.15.1.429.ga000dd9c7

