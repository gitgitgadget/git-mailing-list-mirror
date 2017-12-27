Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABC641F406
	for <e@80x24.org>; Wed, 27 Dec 2017 11:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751358AbdL0L3K (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 06:29:10 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34181 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbdL0L3H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 06:29:07 -0500
Received: by mail-wm0-f42.google.com with SMTP id y82so39024314wmg.1
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 03:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aX6NP/KOsYt6KC1B0AXbeHdqc6bbJujj0fh+FMqBuG8=;
        b=ZdtF6NCpbSWv5BOq5bhIJ4xM3EH2BSGw9rDJhmUuRA7ppp0sESPbpCF0myo3AC9Lqy
         ox4wHvILhAg6v/xLF5hzNNtmStwH0YNoPsah9e58d2Sdo7mTcvoKZR/5WK5rMiLZ57Kp
         UZ5MXK1rwT8nq/lF3posqNBOoC9gv0q9xUVAY0DSF6usW1ColRkhdkeSVZVnlNJjTCT2
         qpVP7yXn86ZMasp8/EqtpRpcyX3fzNFTL/qrKtgGLpYcsESj0FGx1E5Frg0WtuHJULNN
         sz8F9FucUMb0ghiiX9QJDfb9Swu699QsMh85gA/7CYBuw0Ep8ScK5hnaT+oUjixp4ktQ
         30tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aX6NP/KOsYt6KC1B0AXbeHdqc6bbJujj0fh+FMqBuG8=;
        b=fGFOTQAo5yNyJSTNcsuN4Un8enaR9b0MYXnMqOVJ/tw+sUmPO99SdXQaFGfQVI6Odn
         XxDvxjhD/JN4ZFxo2c4tUeYPh7Sl6FTYu92EzeCadVl3VY7B7B90Gr5QS8aLq9UF/smJ
         IQMyLR2fo0K8fA6AdXg4uOGCS+kH7ir1wlaGgHpCkdve/ik9RaKN0GeeXe1ZeZAEdHmd
         U2uQ68+LwaAMBz9dyoL8lu89arcT5oKMAuFGeA1QOslS4/kJugTIgilOOlqxyfj/Z2ex
         HJnybESdIT4DbB0GF9MvciLGcv3nmNAABZ93UzW1V6wmt9eAfQ5Xln9dmuObrn8Zbt7Y
         ngZA==
X-Gm-Message-State: AKGB3mKS5PhR1GN5No0pi1WYVW2o3wz9MNBN68N1LdS/kh61hm6TVRUC
        nPTnaL04w6L6pKM6M6w51hDpMNu5
X-Google-Smtp-Source: ACJfBotAiKKq7peqN35xlaMqbAD8NZVNzT8XB05UfPEIGonRY+WhFXo3bftXxkhp7Wrn7Qaw891Ypw==
X-Received: by 10.80.138.34 with SMTP id i31mr33994756edi.193.1514374145852;
        Wed, 27 Dec 2017 03:29:05 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id f53sm28376470ede.86.2017.12.27.03.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 03:29:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/1] update-index doc: note a fixed bug in the untracked cache
Date:   Wed, 27 Dec 2017 11:28:54 +0000
Message-Id: <20171227112854.1322-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171227102551.GA26616@ash>
References: <20171227102551.GA26616@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the bug tested for in my "status: add a failing test showing
a core.untrackedCache bug" and fixed in Duy's "dir.c: fix missing dir
invalidation in untracked code".

Since this is very likely something others will encounter in the
future on older versions, and it's not obvious how to fix it let's
document both that it exists, and how to "fix" it with a one-off
command.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

> On Tue, Dec 26, 2017 at 05:47:19PM +0700, Duy Nguyen wrote:
>> Strangely, root dir is not cached (no valid flag). I don't know why
>> but that's ok we'll roll with it.
>
> I figured this out. Which is good because now I know how/why the bug
> happens.

Thanks a lot. I think it's probably good to apply something like this
on top of this now 3-patch series.

 Documentation/git-update-index.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index bdb0342593..bc6c32002f 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -464,6 +464,17 @@ command reads the index; while when `--[no-|force-]untracked-cache`
 are used, the untracked cache is immediately added to or removed from
 the index.
 
+Before 2.16, the untracked cache had a bug where replacing a directory
+with a symlink to another directory could cause it to incorrectly show
+files tracked by git as untracked. See the "status: add a failing test
+showing a core.untrackedCache bug" commit to git.git. A workaround for
+that was (and this might work for other undiscoverd bugs in the
+future):
+
+----------------
+$ git -c core.untrackedCache=false status
+----------------
+
 File System Monitor
 -------------------
 
-- 
2.15.1.424.g9478a66081

