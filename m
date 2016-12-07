Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0C0E1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 21:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933198AbcLGVwL (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 16:52:11 -0500
Received: from mout.gmx.net ([212.227.17.22]:60948 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933042AbcLGVwC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 16:52:02 -0500
Received: from fermat.fritz.box ([92.76.239.239]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M0cs6-1cVjJQ0Y9O-00usXs; Wed, 07
 Dec 2016 22:51:58 +0100
From:   Stephan Beyer <s-beyer@gmx.net>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 5/5] sequencer: Remove useless get_dir() function
Date:   Wed,  7 Dec 2016 22:51:33 +0100
Message-Id: <20161207215133.13433-5-s-beyer@gmx.net>
X-Mailer: git-send-email 2.11.0.27.g4eed97c
In-Reply-To: <20161207215133.13433-1-s-beyer@gmx.net>
References: <20161207215133.13433-1-s-beyer@gmx.net>
In-Reply-To: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
References: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:gZGD0F6XHs0ZGjQ9GMC8ESvjAspeidN5w1/f2m7StNvpw/6KWpf
 0LGgE74cj7866dC5X4ZWeqvbGk5Hal8X8P6OD1le7bWfKa7+DM2jH015H+diPMMdR6xMe+d
 XLvGw+LkImT9OZ1RNkDPby6m/6H16I/oSRyVAMXGkVpM1JqsS2MlhtZajSSanRUke0eQhAQ
 GqggPqGY02s75eYMULS9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+bzq98UPkfs=:JeLt2tHUONWGiEraKT9iM2
 Jja6LnPHxNk++Fp2Q3Y4KPEj5FgYLjpoIffhDsk25lKQnWm8HG1gX4+NwDx8wR+60Sy8mMxUX
 XuFOpsP3XqxHXQsFqcuFqdnNAIJ4j1UkY9IoPcaUbIqYUHLOMK1CDQU2PbH4xkV+PYgBPog1r
 9w5Fiw1xXWTC3MFPZh9c9BOsHPX3FebBV3veoE7ZoJTWaCD9BmnlEEb3JwAXau0GLJnQ30Pev
 MZiSRv290Fl74fER1HpQyvkfPg69HQRNOUf+bieHkcSx3orMSw6cpD6onOT+v1LFnKO2QcY/m
 iSKTMJt/VdrrHbjdwxNrIJG6CDsvjjaoPVmPMiHKE8WV/XE9oLlbSAE4C+iT8It2FJGCt8tZZ
 fpfQu4aUje3RSbgA7SrvVoEATIX2WT7l1MzGZDw2FmSLmfkhzl1QxbibaJHEyiv+GJf4bkRza
 gbGtiyU3dpiBDOiou+uHzkcy8d+vQUbLrj35WHrIo+AMW91+qZvykgy4wzw+YqNL+E8JZlBGm
 8TZ9ohQgzTwB7FQcZS1fjzG+6xtyA9eVUF0fIavEqQlnQE6M5y0OUrnBzwqnlmXf69GvQvR1X
 wPnJW1I65Nf6xozCG2jfppadKEt8gqF2QY6JiyrNAYP5qKJGjGgyxieFarLvVUwjKbo3Gci/y
 L7V8F+ryHagLjJEMKTm1Uu4IZpQroLEEmtfPeBeiqh7rkmwSRZD1prbfi/PKokpXH8OVx6RfL
 OGL2hW4NS/siHU2CNlFYBCM4jWGStEGF4EGHjkJu2b1zr3RSo3ar3X2kjIc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function is used only once, for the removal of the
directory. It is not used for the creation of the directory
nor anywhere else.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 sequencer.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index c9b560ac1..689cfa5f1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -47,11 +47,6 @@ static inline int is_rebase_i(const struct replay_opts *opts)
 	return 0;
 }
 
-static const char *get_dir(const struct replay_opts *opts)
-{
-	return git_path_seq_dir();
-}
-
 static const char *get_todo_path(const struct replay_opts *opts)
 {
 	return git_path_todo_file();
@@ -160,7 +155,7 @@ int sequencer_remove_state(struct replay_opts *opts)
 		free(opts->xopts[i]);
 	free(opts->xopts);
 
-	strbuf_addf(&dir, "%s", get_dir(opts));
+	strbuf_addf(&dir, "%s", git_path_seq_dir());
 	remove_dir_recursively(&dir, 0);
 	strbuf_release(&dir);
 
-- 
2.11.0.27.g4eed97c

