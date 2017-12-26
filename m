Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 563E61F42B
	for <e@80x24.org>; Tue, 26 Dec 2017 21:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbdLZV7U (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 16:59:20 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34940 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdLZV7S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 16:59:18 -0500
Received: by mail-wr0-f195.google.com with SMTP id l19so23036562wrc.2
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 13:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ixOWOtSCTHlboc1zhNWLx83rXVNtRRtTeeAk6QJIQhg=;
        b=np3ZmFsG8JqFYYJYczYtIkdRRVMRmGYhdu6VPzErT8135ZsGS+VoEanpNAaC8OesAp
         xn59e+jejg2kuRhZ8newTmd61CCAdM9HZbntVX3ajZKzqRdkSWwkrERPl4YLq+5nNSA6
         Y2XyB5rNHc2Ct7XgkqybtXfng+y78dx1CRkDgI/yAoythzJIjSpAwFSGaAIVwiUA4WGU
         GF7r/D0uoIK8JJgzMZnt2+Ry8blQ6i0nb2gJMAUP6kF1YodAc8VUXnfhFe/OupOgmhH8
         jmUAVPmC+GvhR3eOwfs518CduupQepNzxYk1Fc9P+cqxSN8GIRws2THJ8kREVlMjmHhJ
         sbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ixOWOtSCTHlboc1zhNWLx83rXVNtRRtTeeAk6QJIQhg=;
        b=mOlXJIvSrXKf/z1cqgSbHJnsupAfUQiKwVGVdEyCvwKly8s730CXnjVmrID3Z3HdQH
         S5xQQWghyYie7yfFrLyB5+ceIe1wmOgGh3o8G6+3m08jxhhVU3kSD3P59LxuitWwa0y8
         xTfJmheAK968V1tuYac9DaN4U+yTZ0HlP3g8ZFoVW2gkUVKhtu16IfvDDbdg+Si9UdfF
         hswRSICc/zaqpLR5GnlMrcPhPw0kKtRCYurE6+hTQIIBEUhsLOdU6lUz0zLgvtpc67eF
         3Skrp7F8Zq0JpX/aOyD1nc87bPAwy8HoHoRKkCc2NjnRyADnUTuYnpb63tTajlVXV08i
         +NjA==
X-Gm-Message-State: AKGB3mI1iHF+LFAg7Gr/ZpR5t3C5MyN73ED38QMVmlabObutyH9UPwhr
        d8Rf9JK/VDxnBhsUAaPifaqj+td0
X-Google-Smtp-Source: ACJfBotro1gvlhDsaqpDIQD7DDHnzxPdR6BZIfMICsmhGLobgPtk4oWC/+SlItYYU6K46sA2z29X3g==
X-Received: by 10.223.189.13 with SMTP id j13mr25130984wrh.168.1514325557068;
        Tue, 26 Dec 2017 13:59:17 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id d71sm24516204wma.7.2017.12.26.13.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Dec 2017 13:59:16 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 5/7] perf/run: learn about perf.codespeedOutput
Date:   Tue, 26 Dec 2017 22:59:06 +0100
Message-Id: <20171226215908.425-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171226215908.425-1-chriscool@tuxfamily.org>
References: <20171226215908.425-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's make it possible to set in a config file the output
format (regular or codespeed) of the perf tests.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/perf/run b/t/perf/run
index 214d658172..4e62d6bb3f 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -144,10 +144,15 @@ run_subsection () {
 		set -- . "$@"
 	fi
 
+	codespeed_opt=
+	test "$GIT_PERF_CODESPEED_OUTPUT" = "true" && codespeed_opt="--codespeed"
+
 	run_dirs "$@"
-	./aggregate.perl "$@"
+	./aggregate.perl $codespeed_opt "$@"
 }
 
+get_var_from_env_or_config "GIT_PERF_CODESPEED_OUTPUT" "perf" "codespeedOutput" "--bool"
+
 cd "$(dirname $0)"
 . ../../GIT-BUILD-OPTIONS
 
-- 
2.15.1.361.g8b07d831d0

