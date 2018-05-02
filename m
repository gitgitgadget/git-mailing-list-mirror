Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3828D21847
	for <e@80x24.org>; Wed,  2 May 2018 00:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753414AbeEBAbC (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:31:02 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38501 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753332AbeEBAbB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 20:31:01 -0400
Received: by mail-qt0-f196.google.com with SMTP id z23-v6so16429388qti.5
        for <git@vger.kernel.org>; Tue, 01 May 2018 17:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1v0oUdCxqBq9cvGdHL/v26wQdk4vlRKETXv+1kderpw=;
        b=LdZ6X5C5zYubjKnyoGaTw1ld2jUc9pm8u5tfDl0y3k/wDUA3Emw7zXWFo592D3iL+v
         C8GBhlv+JrWpBGod+sSDTvWc4w2stZ9B5ZJ/4O6+PMacp8XTdjJOECOfN8L2qjrQHQvV
         HVm1Yk5DfvqqflMHYFndx+1ro+BdCFFTjF32/MBZU0UNDKAduvmlAegLq3L2a/rdbJe6
         GTx7qY1brWcSyHGxDwj1orld7nEuOeWsuvG1uSq4BCpQ50zkwgdVbpBHNMRXTVSyGIsR
         aD6hcn27agEcEicFr0ZxeD5Hn+lJKaqnr6lzKgzRu27NdjQNwoVYgNQHgbFlk1rDOwVu
         jarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1v0oUdCxqBq9cvGdHL/v26wQdk4vlRKETXv+1kderpw=;
        b=hE0En/lMteSwz8wWt3ulazDpJpFTfD4d2De/YCX4VVEXjAzFys7pGsrFrsKLmIOfqj
         roVvJGQcv+CLT3doCpOz68zsWNih6MqlmdDGuqOJfKvxlucDcuoP4LxOSLy5Fwc3HfNW
         DCTzbESi/nRqdNcqufG2qevx+8Rw5kxOSznb94ZXoaoelxmreWO+3uscgQFgYyMObuKv
         K5zjoheT35OLEKQTzu37n/guNpzvIUWC/ELiK+9zVFoCNM1sMHPGPNAkeqiV7qHVdhcq
         GUOn7XDfsuIihqHkbFya8S/zm0+X2N0KViwFooD3mSZnz8nnTe4LoeamsHiY9tazZ3qO
         SDsQ==
X-Gm-Message-State: ALQs6tBF4EyRxs15fhJfqGOPSYB2y+4glPCLSB3pflXySSbR/iffcRS2
        OHY74zo5y3+cuMJXLVhpkXKulgWI
X-Google-Smtp-Source: AB8JxZqclYAV+KNyWdVaozwYkToj/OYP3q066zuxuZLvCDs9WzNxeAgyoKb/+C0AVSlmEwhSpnoNnw==
X-Received: by 2002:aed:3fec:: with SMTP id w41-v6mr14818942qth.154.1525221060653;
        Tue, 01 May 2018 17:31:00 -0700 (PDT)
Received: from localhost.localdomain (64-121-142-251.s4089.c3-0.eas-cbr1.atw-eas.pa.cable.rcncustomer.com. [64.121.142.251])
        by smtp.gmail.com with ESMTPSA id q10-v6sm9706428qtk.7.2018.05.01.17.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 17:30:59 -0700 (PDT)
From:   Casey Fitzpatrick <kcghost@gmail.com>
To:     git@vger.kernel.org, sbeller@google.com, sunshine@sunshineco.com
Cc:     Casey Fitzpatrick <kcghost@gmail.com>
Subject: [PATCH 1/3] submodule: clean up subsititions in script
Date:   Tue,  1 May 2018 20:27:57 -0400
Message-Id: <20180502002759.8207-2-kcghost@gmail.com>
X-Mailer: git-send-email 2.17.0.1.ge0414f29c.dirty
In-Reply-To: <20180502002759.8207-1-kcghost@gmail.com>
References: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
 <20180502002759.8207-1-kcghost@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'recommend_shallow' and 'jobs' variables do not need quotes (they never contain
spaces) and do not require any additional prefix, therefore remove the
unnecessary subsitition.

'progress' is a boolean value. Treat it like the other boolean values in the
script by using a substitution.
---
 git-submodule.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 24914963c..262547968 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -465,7 +465,7 @@ cmd_update()
 			GIT_QUIET=1
 			;;
 		--progress)
-			progress="--progress"
+			progress=1
 			;;
 		-i|--init)
 			init=1
@@ -542,14 +542,14 @@ cmd_update()
 
 	{
 	git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
-		${progress:+"$progress"} \
+		${progress:+"--progress"} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
 		${reference:+"$reference"} \
 		${depth:+--depth "$depth"} \
-		${recommend_shallow:+"$recommend_shallow"} \
-		${jobs:+$jobs} \
+		$recommend_shallow \
+		$jobs \
 		"$@" || echo "#unmatched" $?
 	} | {
 	err=
-- 
2.17.0.1.ge0414f29c.dirty

