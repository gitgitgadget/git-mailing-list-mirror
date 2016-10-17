Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2C4B1F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 13:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755052AbcJQNRb (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 09:17:31 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:50965 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754734AbcJQNQS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 09:16:18 -0400
Received: (qmail 23344 invoked from network); 17 Oct 2016 13:16:16 -0000
Received: (qmail 14217 invoked from network); 17 Oct 2016 13:16:15 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Oct 2016 13:16:13 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>
Subject: [PATCH 4/4] i18n: diff: mark warnings for translation
Date:   Mon, 17 Oct 2016 13:15:29 +0000
Message-Id: <20161017131529.27856-4-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.10.1.459.g5fd885d
In-Reply-To: <20161017131529.27856-1-vascomalmeida@sapo.pt>
References: <20161017131529.27856-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark rename_limit_warning and degrade_cc_to_c_warning and
rename_limit_warning for translation.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 diff.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 1d304e0..1687317 100644
--- a/diff.c
+++ b/diff.c
@@ -4638,25 +4638,25 @@ static int is_summary_empty(const struct diff_queue_struct *q)
 }
 
 static const char rename_limit_warning[] =
-"inexact rename detection was skipped due to too many files.";
+N_("inexact rename detection was skipped due to too many files.");
 
 static const char degrade_cc_to_c_warning[] =
-"only found copies from modified paths due to too many files.";
+N_("only found copies from modified paths due to too many files.");
 
 static const char rename_limit_advice[] =
-"you may want to set your %s variable to at least "
-"%d and retry the command.";
+N_("you may want to set your %s variable to at least "
+   "%d and retry the command.");
 
 void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
 {
 	if (degraded_cc)
-		warning(degrade_cc_to_c_warning);
+		warning(_(degrade_cc_to_c_warning));
 	else if (needed)
-		warning(rename_limit_warning);
+		warning(_(rename_limit_warning));
 	else
 		return;
 	if (0 < needed && needed < 32767)
-		warning(rename_limit_advice, varname, needed);
+		warning(_(rename_limit_advice), varname, needed);
 }
 
 void diff_flush(struct diff_options *options)
-- 
2.10.1.459.g5fd885d

