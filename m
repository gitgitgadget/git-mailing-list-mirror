Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7EDF1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbeHHVUb (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44883 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbeHHVUa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so2906176wrt.11
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uUn6iHEpINkLUHdbsi8zZZZ6hmlyXA8XDU8PmL+s+1c=;
        b=k0Dvlnfyyi50zkNhu25jnkBWcOfxQMK6bzJWVf8IxW63PzdwcAoIZq8i/nbjZdDenw
         1IpnWyLDcq+p86MntHbLzB9wIIrV1J+6MxmuN1EifgpUywlQa8Gi9mSXT1rxARibnbB6
         pUDQTHzJPrNqZO9SpQYe4WDLOo8MVuF0Sasykqb+qJ7AqleRnz/K6VgCF5rAlAR1d+2U
         dfhBaK0iO7GaLUqOokDikim5mRsBXKMYsOAtN/ujTwy7tA2dqhhzp/4wj0B6NLliVPf8
         aqLatOD4IDo93Nf802YqSPZOWhtX7hiyF3BTKY3Sp4HSXw3XFlcqaLKweXyy3qye2ywX
         qy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uUn6iHEpINkLUHdbsi8zZZZ6hmlyXA8XDU8PmL+s+1c=;
        b=E35vdFte9MEGvhI5oODawS1zzAEdcSHR/zDD2l6ciLrZCJewp/dVJioDkvf1qH+Hla
         CMumebRQiCasaCgzh4Jme1oRKxBJzvfCGaCFxWJg73O6KCD1o06qjwkypwTROVr3vFz6
         Z10W9oSUa2M0zV/wnh3q/itzI24ntM92sOro5YvmyCBuEAUsJrXq2V9vwM5R+btpNkvV
         zFff950xYF4+OXhG9GaLUfDPcPR3J+8GMNq0t+1m7jDrTCyif5miTFjmKxQ/TgluMu0y
         +jwysIAJgktDwiNdgtuer19xgmZYeiiNlVPHzOdnVTLHZG0yBgN8cDbNNU+6N8NVmiEX
         9PNQ==
X-Gm-Message-State: AOUpUlHDar1KENinD0CJ+DJwK0pmu8A6tzCBh9gtE2hVfNK/n4CDxutc
        hzMUF0O9SLxJ/4BtGNeBIMntx4DQ
X-Google-Smtp-Source: AA+uWPww9V+QHqXni/DGSUJIJ5Z3p/miTdJFeaYEoCU3ugpEDloDv4otnSjSmbAW6IY5BwkffA2jbQ==
X-Received: by 2002:a5d:6550:: with SMTP id z16-v6mr2645985wrv.194.1533754768234;
        Wed, 08 Aug 2018 11:59:28 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.27
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:27 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 13/26] stash: update `git stash show` documentation
Date:   Wed,  8 Aug 2018 21:58:52 +0300
Message-Id: <46b04e256f045a53111d52439de376a5f332cb55.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add in documentation about the change of behavior regarding
the `--quiet` option, which was introduced in the last commit.
(the `--quiet` option does not exit anymore with erorr if it
is given an empty stash as argument)

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 Documentation/git-stash.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index e31ea7d30..d60ebdb96 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -117,6 +117,9 @@ show [<options>] [<stash>]::
 	You can use stash.showStat and/or stash.showPatch config variables
 	to change the default behavior.
 
+	It accepts any option known to `git diff`, but acts different on
+	`--quiet` option and exit with zero regardless of differences.
+
 pop [--index] [-q|--quiet] [<stash>]::
 
 	Remove a single stashed state from the stash list and apply it
-- 
2.18.0.573.g56500d98f

