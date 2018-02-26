Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCFE71F404
	for <e@80x24.org>; Mon, 26 Feb 2018 16:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeBZQ0y (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 11:26:54 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38017 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbeBZQ0x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 11:26:53 -0500
Received: by mail-wr0-f194.google.com with SMTP id n7so21864048wrn.5
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 08:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=/LeAdc5q4zSpnDdKaATFeXYamJmOFZXwpiVipV1nnX8=;
        b=VQdada8qEHTbmiinPZm62xltLgL9wwhY/DDciqT73nIG2lEtQpqStQkln5yI0gEJne
         L8an91QtuVSso+dcXm+9Ydzi97DcNIHDZlh93KmdXP7rv9rrmFUPLgEdgIlSDe3UrTYe
         aaoG7jVLAWr7EqTBoC5cklNttyke3hZydL0pwDvVu68xxTF9XUck1EVQG0VSkt4tlN1Z
         J0D/NdT4nexNXeJCqW/l6n1KSefjOzpF1ypjPmisxoNXVVBi87dMxiPVZGJ0X9nqoINZ
         c/lOC5UbsZ6xAI61OIMLE6ClFiQ/vg7h62h88dV8ZVd7qFCJKxHS+iGddXERo8qLpBmw
         ieoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=/LeAdc5q4zSpnDdKaATFeXYamJmOFZXwpiVipV1nnX8=;
        b=pR9MXVPcUHwgBoIhUydWTEbQQQJcHUW/C4q/GJU1Fkr+fNihqS/DM1MXEcOvBfrttZ
         wH/03ysXykOdV5Zx6xq0f00J6D8gOafpwtxIjXx19xyDI++YNtE5V1HxzNSUhhHmbL/8
         1hbP6rqfR+WEDmbY+BB7NhvNmdDHjJwN/5M3N7DgvsvKjxvzO6pCc1VoMa5hyS1UZtfd
         ley4Ot13IhVqMdyeGvtYQhrH9SCt6ogAVbbwhiq07PJSDixL4/Yk+L+tl56yTPK8WVMU
         AcBJvS+//6D+iM3Hike6zt2fYtdi0cIunJ10+Uysk8miD5fViw3HGCAGk3RNLY8QFaMM
         vcOQ==
X-Gm-Message-State: APf1xPD/pOuNMwFWY1jWluyc21WnsEREW7f+06jcZmD5hYtSm94k33yO
        ysnuCc+hhoLi3IdC+hyVJqo=
X-Google-Smtp-Source: AH8x227X3TWm8WDiVh4DyG0N+z7t/u9ixH+SxFQ89OHWaROqitF2XNRP0oM4exr9UC/UDrBZpdxvlA==
X-Received: by 10.223.143.101 with SMTP id p92mr9707984wrb.241.1519662412829;
        Mon, 26 Feb 2018 08:26:52 -0800 (PST)
Received: from localhost.localdomain (x4db1d28c.dyn.telefonica.de. [77.177.210.140])
        by smtp.gmail.com with ESMTPSA id b99sm9087652wrd.75.2018.02.26.08.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Feb 2018 08:26:52 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, sbeller@google.com, gitster@pobox.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 03/13] commit-graph: create git-commit-graph builtin
Date:   Mon, 26 Feb 2018 17:25:39 +0100
Message-Id: <20180226162539.7463-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.409.g7f85f628cc
In-Reply-To: <1519066406-81663-4-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Teach git the 'commit-graph' builtin that will be used for writing and
> reading packed graph files. The current implementation is mostly
> empty, except for an '--object-dir' option.

Since 'git commit-graph' is a builtin command, it shouldn't show up in
completion when doing 'git co<TAB>'.
Please squash in the patch below to make it so.

Furthermore, please have a look at
  
  https://public-inbox.org/git/20180202160132.31550-1-szeder.dev@gmail.com/

for an other oneliner change.


diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 17929b0809..fafed13c06 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -841,6 +841,7 @@ __git_list_porcelain_commands ()
 		check-ref-format) : plumbing;;
 		checkout-index)   : plumbing;;
 		column)           : internal helper;;
+		commit-graph)     : plumbing;;
 		commit-tree)      : plumbing;;
 		count-objects)    : infrequent;;
 		credential)       : credentials;;

