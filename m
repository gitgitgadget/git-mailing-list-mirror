Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 842C21FC3E
	for <e@80x24.org>; Sat, 29 Apr 2017 19:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S376862AbdD2TAC (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 15:00:02 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38676 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S376859AbdD2TAA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 15:00:00 -0400
Received: by mail-wm0-f53.google.com with SMTP id r190so71738982wme.1
        for <git@vger.kernel.org>; Sat, 29 Apr 2017 12:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6/nzGuoK384j4RTeeLQdccxXkKHcJirPE3OIYczPfDo=;
        b=qsegI2BBM0W2ZiWgvqOU3W7yU0gQLIcSmxBTAzPLri7/idxGKxh9durFlPpoQVY6n7
         /e6G6FiTPWKNBiRqnCO8Bcytp9/a3JCaCc0nDkmm/1Vwd+qHhSaRg37fqh86tOhcl/3o
         3v6q0Z1NpnfLty+J3SIm9ufKKMvI3QmMH8Rr4TCdb+0Gt0mR2hV74KKyA2AbWMDXx1L5
         YmI+98sNT/7AGTpB56obQOdmltuId5/9p9tEaf6L8ezqXthqDwKvyH2D2qO6+rY6DY2F
         egYUK8orMFbWU6XycvNIGXHPmhQCPcwdYHzLKqKzpUmpA46Xel0miCxwhdCYG+bIl9Xj
         PNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6/nzGuoK384j4RTeeLQdccxXkKHcJirPE3OIYczPfDo=;
        b=cyriRfKri3mV3IlLU+T/Q8DsiXbbr8U6/Stq9pn+hZ+1+Yn6m/V6kQG6evy925X3mX
         fboVxSx7UDT18GDWKYvvcgMLdChkZb3Q6OW407JceEvF3f9qiPOwhIlQgPBWeUofks1i
         T9cv7G3tJiFESfd5b+MiTlq9aRA4y9BcE1eUoGsUX6tSxnc0BkksY3T+MzT4AbhOQ2t0
         Jwo4YVdY61fPYJmXhAMmG28rqb6Sd0Iu0TmHs4fUyMQFTbm0YEQCFLRJRH9NWUqSy0aT
         i+TzLonWj3sO5zxeP6MG46fTX0mWGOWLmY9bwMvTcvVuDE1MV4LNPWJrQ91N9OXyGshL
         jL9w==
X-Gm-Message-State: AN3rC/79tWs3gM0+rE8rhoxfGY/3KnmZM4IXkPvwZRrKxmr55334cbwt
        JMBxC9dFxpFKvQ==
X-Received: by 10.28.113.135 with SMTP id d7mr2288193wmi.71.1493492399316;
        Sat, 29 Apr 2017 11:59:59 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB6C59.dip0.t-ipconnect.de. [93.219.108.89])
        by smtp.gmail.com with ESMTPSA id x64sm10963112wrb.10.2017.04.29.11.59.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 29 Apr 2017 11:59:58 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v1] travis-ci: handle Git for Windows CI status "failed" explicitly
Date:   Sat, 29 Apr 2017 20:59:58 +0200
Message-Id: <20170429185958.10560-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git for Windows CI returns "completed: failed" if a build or test
failure happened. This case was processed as "Unhandled status".
Handle the case explicitly.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Notes:
    Base Ref: next
    Web-Diff: https://github.com/larsxschneider/git/commit/57840905a5
    Checkout: git fetch https://github.com/larsxschneider/git travisci/win-fail-v1 && git checkout 57840905a5

 ci/run-windows-build.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
index e043440799..1bb3a021ee 100755
--- a/ci/run-windows-build.sh
+++ b/ci/run-windows-build.sh
@@ -61,7 +61,8 @@ do
 	case "$STATUS" in
 	inProgress|postponed|notStarted) sleep 10               ;; # continue
 		 "completed: succeeded") RESULT="success"; break;; # success
-	*) echo "Unhandled status: $STATUS";               break;; # failure
+		    "completed: failed")                   break;; # failure
+	*) echo "Unhandled status: $STATUS";               break;; # unknown
 	esac
 done
 

base-commit: 1ea7e62026c5dde4d8be80b2544696fc6aa70121
-- 
2.12.2

