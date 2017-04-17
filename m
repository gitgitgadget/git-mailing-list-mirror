Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27EF21FA14
	for <e@80x24.org>; Mon, 17 Apr 2017 07:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933023AbdDQH7u (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 03:59:50 -0400
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:54048
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932979AbdDQH7t (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Apr 2017 03:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1492415987;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=sZbU7U1ZaEHk2+EGjH2h6qhnCxaa6Yj3pomTUIicFTw=;
        b=gS3waAw2QL9ZdDkNZkCbgdhdKRYRbmzqSQhXZKT55VneWhkqPqKc/QGxKBF6aTR1
        wdtjMr2l0u/7Wg6fYYhXRjX0AucTvZnQjWfj2RK7H+0A4kXFnxW2qz4h7YX0VxdYvP/
        dDuNDLImKNlWkRmbrJCT/3cy5uRloYMkkOdNWTT4=
From:   Sebastian Schuberth <sschuberth@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015b7aecbf67-2f63e58b-5f75-4c9b-975f-e8e35176d510-000000@eu-west-1.amazonses.com>
Subject: [PATCH] submodule: remove a superfluous second check for the "new"
 variable
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 Apr 2017 07:59:47 +0000
X-SES-Outgoing: 2017.04.17-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 submodule.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index c52d663..68623bd 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1396,8 +1396,7 @@ int submodule_move_head(const char *path,
 			cp1.no_stdin = 1;
 			cp1.dir = path;
 
-			argv_array_pushl(&cp1.args, "update-ref", "HEAD",
-					 new ? new : EMPTY_TREE_SHA1_HEX, NULL);
+			argv_array_pushl(&cp1.args, "update-ref", "HEAD", new, NULL);
 
 			if (run_command(&cp1)) {
 				ret = -1;

--
https://github.com/git/git/pull/345
