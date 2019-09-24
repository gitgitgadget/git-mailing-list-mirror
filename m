Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AE631F463
	for <e@80x24.org>; Tue, 24 Sep 2019 20:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441975AbfIXUva (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 16:51:30 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:56492
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731288AbfIXUva (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Sep 2019 16:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1569358288;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=DEsNlmoqPtftkYlxxuJb6twb7pKFg+jR8lj4HV4BGEI=;
        b=E1PggtEXqYmyFqQzVHIujtz1rNEGB/KVZXFD3YQOBkzFsLqtp1GTfz5vp961u5Pm
        iE64HDhsdhDOaUbCwkt/qxPbRjPDMjMnsIwp//gA2riLIVyAXlqrR2Xf+NOFXx2VhcO
        XuzaXLHnDrG75OnAhzKJmTjNX11+PDM43QwAjtL0=
From:   Durant Schoon <durant.schoon@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016d650b16ca-073c796f-065f-4966-9f94-f276c8fe6ee7-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016b2ebafc26-1bd39076-62e4-4b7e-9309-b08cc072fbdf-000000@eu-west-1.amazonses.com>
References: <0102016b2ebafc26-1bd39076-62e4-4b7e-9309-b08cc072fbdf-000000@eu-west-1.amazonses.com>
Subject: [PATCH] completion (zsh): fix misleading install location
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Sep 2019 20:51:28 +0000
X-SES-Outgoing: 2019.09.24-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the code comment in the zsh completion suggests that this file
should be copied to `~/.zsh`, many users might be misled to believe that
this refers to a file location. But it refers to a directory, and won't
work when it is a file.

Let's just add a slash, to make it abundantly clear that this must be a
directory.

Signed-off-by: B. Durant Schoon <durant.schoon@gmail.com>
Helped-by: Johannes Schindelin
---
 contrib/completion/git-completion.zsh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 886bf95d1f594..0e63004e2613e 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -11,8 +11,8 @@
 #
 #  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
 #
-# The recommended way to install this script is to copy to '~/.zsh/_git', and
-# then add the following to your ~/.zshrc file:
+# The recommended way to install this script is to copy to '~/.zsh/_git/',
+# and then add the following to your ~/.zshrc file:
 #
 #  fpath=(~/.zsh $fpath)
 

--
https://github.com/git/git/pull/609
