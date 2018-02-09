Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D98E31F404
	for <e@80x24.org>; Fri,  9 Feb 2018 21:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeBIVFZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 16:05:25 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53148 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752409AbeBIVFX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 16:05:23 -0500
Received: by mail-wm0-f66.google.com with SMTP id g1so17625539wmg.2
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 13:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5QoGzfpQt+3P8KOezvXlqg0WCyo/9nbTrGniICt6ip8=;
        b=Gp3jJRgKFsR6hVzQbJqUZ2z4PkiGwj+1dLE2QF2Z+LWcXba8DtbrOp6Ray72MMWDzn
         W/0/uHaxczFzE7sbPSdkJGglWRl6UsNbZIgPpOBDuhsB1tUMnxTI0Cj10QWUKnLfJJRD
         KiU5lmZ7cOHhOgZgmUj2JIfhEKEsTxRdOFsDArc7KesXfDP3vrGHWOnvquPZ66ZPLkww
         QsMdFqxpn1l/qn4h6dUzdyKLaP7ymQPH+HVdcoUDaXSEjcMeXWq2/yevlT/Pr1QVaycU
         nWhCvkIfYFN/P/vCheqihlBI2r2Ur/JDnUTYzti5Cx8P0yxUlc4UACc4iRqGm6wDwThp
         cyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5QoGzfpQt+3P8KOezvXlqg0WCyo/9nbTrGniICt6ip8=;
        b=szCY4123giF7pRSMXhqnkDaa5A+Hew/Z83eOFRgs024gxRFaM9vs9cQ1iWwZgHcDZ9
         nsoLD4pNh9OGpBcMmOQ2eihGmcNmEaWIACGFpXwfOK2tU59PKLZS55j9cUgSy5ZOu2+t
         15tJswWoqU6MVXw0XgZ8g1twjwelZABhsw94ggfZKGD1ReQ8ACIlKatRBZklyjspCO99
         wFf2Z035Cr2aphagXmA4MXyiNMjzU6itEK3zvZ+GfNGxxzk4oZF0Ld+WFDCck7cWPNuk
         wHKRWSprFShKjlCZ3dm0CabVA+OoONQTb/DQ9A0h6vS7kpOhSTtUiiLaFdv1Ja66lqsz
         Rkrw==
X-Gm-Message-State: APf1xPB7ZihfzgFfXJoPqW+56yZk+lvI/ZfV6ZosyAXZRWMKayI3Ce1G
        oxQ3qdZxHYHJ1Z4iGDnpWvcz54Y3
X-Google-Smtp-Source: AH8x225VuqlxLgwoGNzUq3iVUwVFFqcD1ftYaBu4tsKPM2ljupTdO1xNyrJT0Hg3Lq0x7nNIjtSRGw==
X-Received: by 10.28.88.70 with SMTP id m67mr3330815wmb.134.1518210321614;
        Fri, 09 Feb 2018 13:05:21 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b54sm5800259wrg.27.2018.02.09.13.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 13:05:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] update-index doc: note the caveat with "could not open..."
Date:   Fri,  9 Feb 2018 21:04:31 +0000
Message-Id: <20180209210431.409-3-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180209210431.409-1-avarab@gmail.com>
References: <20180209210431.409-1-avarab@gmail.com>
In-Reply-To: <xmqq6076xabo.fsf@gitster-ct.c.googlers.com>
References: <xmqq6076xabo.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note the caveat where 2.17 is stricter about index validation
potentially causing "could not open directory" warnings when git is
upgraded. See the preceding "dir.c: stop ignoring opendir() error in
open_cached_dir()" change.

This caused some mayhem when I upgraded git to a version with this
series at Booking.com, and other users have doubtless enabled the UC
extension and are in for a surprise when they upgrade. Let's give them
a headsup in the docs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-update-index.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index e30b185918..0c81600d8c 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -480,6 +480,16 @@ a directory with a file when it comes to the internal structures of
 the untracked cache, but no case has been found where this resulted in
 wrong "git status" output.
 
+There are also cases where existing indexes written by git versions
+before 2.17 will reference directories that don't exist anymore,
+potentially causing many "could not open directory" warnings to be
+printed on "git status". These are new warnings for existing issues
+that were previously silently discarded.
+
+As with the bug described above the solution is to one-off do a "git
+status" run with `core.untrackedCache=false` to flush out the leftover
+bad data.
+
 File System Monitor
 -------------------
 
-- 
2.15.1.424.g9478a66081

