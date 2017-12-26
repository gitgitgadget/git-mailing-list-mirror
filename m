Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ABDA1F42B
	for <e@80x24.org>; Tue, 26 Dec 2017 21:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbdLZV7W (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 16:59:22 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44556 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdLZV7V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 16:59:21 -0500
Received: by mail-wr0-f193.google.com with SMTP id l41so23210387wre.11
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 13:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aleUtV+IUGAnIY6FzVDmVD927AeDBWudRlg3zESg/7A=;
        b=PCEn+4OSzNNifnSDDXpICj4JFfLd4sQMTpTFRrkGZderoLXXDIlvztbmboYaVNUHuv
         uPznW0dXCvL4sT/96IJyj1p/aFQP/nl3mV9FL7nr3lTqmQ2g+N1UEave8Uus0IoCemkr
         W1aEr1R2o4NsjEzv+M93/ikEG4J2O4hynUAfhIvma9lkvhlqwXoS5/U+O/VzDjfar4m4
         HKvb4VBRbsUV4NbJlEqrCLrGvPDQuIOAj9K608Ygqh6+GfZv87vR/7bW//Fu/3csyekW
         caXFLDjvaEaJG/N0EJtV0TTTzP1IwJOztwyFTwtIwtQwELWU+MiV2W/W/DboCDhLg7s0
         27xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aleUtV+IUGAnIY6FzVDmVD927AeDBWudRlg3zESg/7A=;
        b=Mv+Ni0xJRxotb+qqa5d89R7DVlfcstm3T7vVubcxe3XpfYOQ5BhoYbZkraJ/w1ncTB
         7svoAlhrI7yFFpu3+wN0/iIFcHB4uL7QYd6uNyfJLI6xIj3Z7LFsnqBr21D7uZaWubVf
         RI0o9kK9zSIY+kGtFvWdsTK+eWGUC03Ulog/6UfCOnEbx/xiiP8uXBLfcZJnRTeU51Ps
         VrOYdeOKSKDqUELoCR8C7c2qmCnmCSB9spSu9Se+nOCK0dmBwA+aAJmrDEzfqyTpI59t
         s88X/T2F+6N0A5p3RWDC+KCFqhr3MXywcaILW4ui6OIKqfpUaIOGbXrBuxkAncmO9aeR
         izDQ==
X-Gm-Message-State: AKGB3mL/juVzucYXX9fvoOqUj2SEynDxJ+9Ns6IrofdAuVCg3dOA9g0X
        mrY3cZirx23Y50kvetsVvbYZqqkf
X-Google-Smtp-Source: ACJfBov4d/9atngGzZl1lH8983pVe9ZtxUH2QeHIxh2L9g7UkzPkvr5Hd4UzhjfjJAWupjeTRsX1Tg==
X-Received: by 10.223.166.120 with SMTP id k111mr25721324wrc.125.1514325559544;
        Tue, 26 Dec 2017 13:59:19 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id d71sm24516204wma.7.2017.12.26.13.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Dec 2017 13:59:18 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 7/7] perf/run: read GIT_TEST_REPO_NAME from perf.repoName
Date:   Tue, 26 Dec 2017 22:59:08 +0100
Message-Id: <20171226215908.425-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171226215908.425-1-chriscool@tuxfamily.org>
References: <20171226215908.425-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The GIT_PERF_REPO_NAME env variable is used in
the `aggregate.perl` script to set the 'environment'
field in the JSON Codespeed output.

Let's make it easy to set this variable by setting it
in a config file.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/perf/run b/t/perf/run
index ef56396546..1a100d6134 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -137,6 +137,9 @@ run_subsection () {
 	get_var_from_env_or_config "GIT_PERF_MAKE_COMMAND" "perf" "makeCommand"
 	get_var_from_env_or_config "GIT_PERF_MAKE_OPTS" "perf" "makeOpts"
 
+	get_var_from_env_or_config "GIT_PERF_REPO_NAME" "perf" "repoName"
+	export GIT_PERF_REPO_NAME
+
 	GIT_PERF_AGGREGATING_LATER=t
 	export GIT_PERF_AGGREGATING_LATER
 
-- 
2.15.1.361.g8b07d831d0

