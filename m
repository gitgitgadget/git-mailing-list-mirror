Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8454EC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 21:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347088AbiHRVlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 17:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347050AbiHRVlB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 17:41:01 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AE5BD292
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:41:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r16so3144398wrm.6
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=jCcEN1Fq7Sov4sFy7+377W2MPZQJ/v3rAKdOKIPYXKw=;
        b=H3uARC2I2XEK7ItT+pNF0hxmjY2Erksholt9loPxeWDt4Li15jeXs+ZDV0Bsije7vi
         T4tIgmRCLNLWbP2Jx2l5PmUAL47w7CmVKxItN2PnmmjFe0JBTCPu2UPNmEi7VDC/7s1V
         FNAjshsxUiD3BJuKSCHZ6BYFE9x5DKiDfOHMviBZSACJqM0mGWcvQTIHfXpBFG33xyAO
         fFG8Zw6E4wsFprN8aHFjYPt75lkFD892yBliFtdkvHDIfqej+gJgd/MNoSfv1pn7gIpU
         CZB9FXBXRcFgTnIVMyZKyd2dFIXxP+vPxyov80rNbI+t11/P/U4TOib9iuvEJ7zxaFe5
         PmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=jCcEN1Fq7Sov4sFy7+377W2MPZQJ/v3rAKdOKIPYXKw=;
        b=046iIR4NiKHKYmoRETod3K/D5WBuoamWZtevNBmwASZH4ASh0apHxZRN+6eQA044+T
         BCJ1okg/JnJNMnPpOr33NfF4xQOfZ+yFu86SqrAB3qP4GdwSIh8wW+yCft5Y4+4rCTPt
         Ehdo/iwGhPeRX9WwcpzMf31MKsW7i5V+9y72UoCwIaSQQ06u6lrP6mKlGFJq6eu0NGSp
         tojS6vHa6W5MnD2wLMFhhfsleOdQumzTYyW0qcuP2rUcW+axX2mfe4wy70STiL66n2DG
         GXj/aKVQUR/9Ke8030nXLG5QMzzEK/I/yMKQvLlrylbOvuGX5TDlulrcuM8diIIeRBZm
         Z3TQ==
X-Gm-Message-State: ACgBeo1hpgiwm5ibYh9BBfn8NOjXBpIRJam4775WnahrY3iT0xSHO6b3
        NMWZcAddadKnD+nYIhrfQzSSmEL4CIY=
X-Google-Smtp-Source: AA6agR4ey2MPfXm6yrhyKtLahYozv+IyYkgpf/lidhA4CNGG3u7pU+Uo2YVtp7sUPQS0FPOIFcLhBQ==
X-Received: by 2002:a5d:588f:0:b0:220:761a:6894 with SMTP id n15-20020a5d588f000000b00220761a6894mr2642477wrf.406.1660858859074;
        Thu, 18 Aug 2022 14:40:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d4411000000b002252e5a6841sm2342177wrq.57.2022.08.18.14.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 14:40:58 -0700 (PDT)
Message-Id: <aced836aaa39c4c619d03510ba2343527e3a24af.1660858853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
References: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
        <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 21:40:49 +0000
Subject: [PATCH v3 4/8] scalar-delete: do not 'die()' in 'delete_enlistment()'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Rather than exiting with 'die()' when 'delete_enlistment()' encounters an
error, return an error code with the appropriate message. There's no need
for an abrupt exit with 'die()' in 'delete_enlistment()' because its only
caller ('cmd_delete()') properly cleans up allocated resources and returns
the 'delete_enlistment()' return value as its own exit code.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 7be2a938b0c..6de4d5b3721 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -407,7 +407,7 @@ static int delete_enlistment(struct strbuf *enlistment)
 #endif
 
 	if (unregister_dir())
-		die(_("failed to unregister repository"));
+		return error(_("failed to unregister repository"));
 
 #ifdef WIN32
 	/*
@@ -418,13 +418,16 @@ static int delete_enlistment(struct strbuf *enlistment)
 	path_sep = find_last_dir_sep(enlistment->buf + offset);
 	strbuf_add(&parent, enlistment->buf,
 		   path_sep ? path_sep - enlistment->buf : offset);
-	if (chdir(parent.buf) < 0)
-		die_errno(_("could not switch to '%s'"), parent.buf);
+	if (chdir(parent.buf) < 0) {
+		int res = error_errno(_("could not switch to '%s'"), parent.buf);
+		strbuf_release(&parent);
+		return res;
+	}
 	strbuf_release(&parent);
 #endif
 
 	if (remove_dir_recursively(enlistment, 0))
-		die(_("failed to delete enlistment directory"));
+		return error(_("failed to delete enlistment directory"));
 
 	return 0;
 }
-- 
gitgitgadget

