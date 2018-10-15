Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B17171F453
	for <e@80x24.org>; Mon, 15 Oct 2018 14:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeJOWCA (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 18:02:00 -0400
Received: from smtpbg303.qq.com ([184.105.206.26]:51858 "EHLO smtpbg303.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbeJOWCA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 18:02:00 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Oct 2018 18:01:51 EDT
X-QQ-mid: Xesmtp4t1539612535tikoaciq8
Received: from localhost.localdomain (unknown [180.165.118.30])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 15 Oct 2018 22:08:54 +0800 (CST)
X-QQ-SSF: B1000000000000F0F5100000000000Z
X-QQ-FEAT: nNqzOPJj1O4F6eFRQG08jTkIiqfvEvY4PPW9wJaXa0uYe+dPnS62VllA74WyU
        oyIxhxzcvGMhHhvpnsZ67/5pC70RISdvIRzKUr4mLMVrG9EB3Q6Oo4bqqbcMGASn4S8qW1y
        4tawqoqblp6wUYSrcPpU3h71hquirLJnAZDMLufwkEF1sGuUXz+u5I1q3ydQ1rpvcrIi52L
        wJlnaNpGOZTufrizpR3ZHmb+XHlPfzbz4w1RX80/uApZpyGTgTLLzSKk1NE4knL1FRzZvgE
        rsnZsLUoaIgJBwp1HLdfkKDHXfMpzrzEQwtG4phYnJYRLu
X-QQ-GoodBg: 0
From:   Tao Qingyun <taoqy@ls-a.me>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, avarab@gmail.com, Tao Qingyun <taoqy@ls-a.me>
Subject: [PATCH] builtin/branch.c: remove useless branch_get
Date:   Mon, 15 Oct 2018 22:08:39 +0800
Message-Id: <20181015140839.4925-1-taoqy@ls-a.me>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <CACBZZX7i-Uob9EJ8GeDKYVTyKtdRiy=qPbxSOe=FGh2cbHG9Zw@mail.gmail.com>
References: <CACBZZX7i-Uob9EJ8GeDKYVTyKtdRiy=qPbxSOe=FGh2cbHG9Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
X-QQ-FName: 83DE58107C114F18B213CD3A884C1BC2
X-QQ-LocalIP: 10.198.131.167
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Tao Qingyun <taoqy@ls-a.me>
---
 builtin/branch.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index c396c41533..2367703034 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -809,11 +809,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		git_config_set_multivar(buf.buf, NULL, NULL, 1);
 		strbuf_release(&buf);
 	} else if (argc > 0 && argc <= 2) {
-		struct branch *branch = branch_get(argv[0]);
-
-		if (!branch)
-			die(_("no such branch '%s'"), argv[0]);
-
 		if (filter.kind != FILTER_REFS_BRANCHES)
 			die(_("-a and -r options to 'git branch' do not make sense with a branch name"));
 
-- 
2.19.0

