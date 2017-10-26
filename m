Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0A59202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 15:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932501AbdJZP04 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 11:26:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:44206 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932343AbdJZP0t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 11:26:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id 196so19752149wma.1
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n/F9xsagWJU3VpJoVcMXPkqqrW55jyJRPdIcRJwBzHw=;
        b=cjruky3Kq2pQ5RUbLC3LH5OvkSnFdOmUhv7MF/lrven6WBfHi6LRWPBSRYhPw9xeiK
         eup5aW0zH0ee8RV51ielPetJcKtwbqUGoRj41ylU1BDd5zcnqtTyJ9z/WqrN/2WYKGCr
         ygYDfJVsCzf+J0TMS6GtC7wD7xnImt/4cTPgf/eiJtRQ1HrovLNE+CE7mgbJOx3WpEdB
         ZkiCU8LNi94d2cBhK41zmGJVUYt3VOUQyCM5kYBvwJNQ6pWhO0QD6E7SIBhkuQMMqeMV
         nb6fuFbG90nm1p6HutEmIqMSdW9Cfp3+Xx12s299OLUzqXvCVSRNqC2euu+M7MPlgH/u
         cujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n/F9xsagWJU3VpJoVcMXPkqqrW55jyJRPdIcRJwBzHw=;
        b=sA8DxDay99TsNHOq1L2P3j6zhiXHzyUDLRziSilEz9WPyXK3o6pIU1KqfUJ27fFAOB
         Le37HzW3Cj19x1HZlQc3nCBk7MNf/7YkEUHFjU5OPKtxRTsYRun6BMLRMypFn004XONB
         gZ6XKu5viuIGY/s5DqiGXp/ZQS0fHJ/HPUF585BSenIja9UQvpKilEIv6rerfjdHOSeF
         0c3AdH1CpfPkPd1dPxZZke/UYZwfhF3OMpFT3JFM2zWOeVssdAZ2aS2IU7x9DNU7pc16
         GRVO2VzcRsGYgpKRznOy8Ry9vhNcy0ht0H98CxsF8vAoLfQt6gku8Hg4aY2IQwhTDFlc
         qH/w==
X-Gm-Message-State: AMCzsaV9QuGRFonRsksKR/3az49ktcdwQVx/7RwRwQvNl9WSksH1AMi0
        gYdnEeikMNxe2ed9+ZaYlzc=
X-Google-Smtp-Source: ABhQp+R8E3NSaIgq8uMOSXxVK84hEsATnEu8tU5WD1YtjD3mMbeOWZWeh5S3HsI4H3VJ+jEPYSzWhQ==
X-Received: by 10.28.194.67 with SMTP id s64mr1860119wmf.7.1509031607667;
        Thu, 26 Oct 2017 08:26:47 -0700 (PDT)
Received: from localhost.localdomain (x4db15b4c.dyn.telefonica.de. [77.177.91.76])
        by smtp.gmail.com with ESMTPSA id p7sm1738801wmg.44.2017.10.26.08.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Oct 2017 08:26:46 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] rev-list-options.txt: use correct directional reference
Date:   Thu, 26 Oct 2017 17:26:37 +0200
Message-Id: <20171026152637.21629-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.0.rc2.117.g35d527b84
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The descriptions of the options '--parents', '--children' and
'--graph' say "see 'History Simplification' below", although the
referred section is in fact above the description of these options.

Send readers in the right direction by saying "above" instead of
"below".

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/rev-list-options.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 7d860bfca..13501e155 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -799,11 +799,11 @@ endif::git-rev-list[]
 
 --parents::
 	Print also the parents of the commit (in the form "commit parent...").
-	Also enables parent rewriting, see 'History Simplification' below.
+	Also enables parent rewriting, see 'History Simplification' above.
 
 --children::
 	Print also the children of the commit (in the form "commit child...").
-	Also enables parent rewriting, see 'History Simplification' below.
+	Also enables parent rewriting, see 'History Simplification' above.
 
 ifdef::git-rev-list[]
 --timestamp::
@@ -846,7 +846,7 @@ you would get an output like this:
 	to be drawn properly.
 	Cannot be combined with `--no-walk`.
 +
-This enables parent rewriting, see 'History Simplification' below.
+This enables parent rewriting, see 'History Simplification' above.
 +
 This implies the `--topo-order` option by default, but the
 `--date-order` option may also be specified.
-- 
2.15.0.rc2.80.g094badb02

