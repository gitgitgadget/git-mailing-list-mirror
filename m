Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6959820899
	for <e@80x24.org>; Mon, 14 Aug 2017 21:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbdHNVaz (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 17:30:55 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33585 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752349AbdHNVay (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 17:30:54 -0400
Received: by mail-pg0-f53.google.com with SMTP id u5so54861684pgn.0
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 14:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=paOcrIOyBLJAPmNvgcqJ4BhZ5SoWrhXDUslBGUzeLJo=;
        b=teLhyu778DJx4eVtFFBGPb9+ziaBZYAPQ5bAlW1rJJMvxmerm8EUgvHvGoXCxSWIiY
         IbeCKQ3aa7Y/eKfK2nRXUaxiQoYE6eIoF3MobxrvxDcK0LvcPY6lO7sxIf/pVnJBTAy8
         PPtAVbID8Irv5JTNt6GN1dF4flJXrNjCrnkl7pRRxmYdnL5vb14afgwQXElq3C6xOQqW
         Gq8V1OpnPjGwB3CQSs+T79q/hmAFlWW9e4awJ25A53jQtwpHWrjZioL2SQSiGJaANVdp
         PGbCDvVk863P0UPLgT3HS8aAflC1KPzsuY16RUuM2HAxyqYAPh4hcXs2lVabl+ZTO1QX
         cDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=paOcrIOyBLJAPmNvgcqJ4BhZ5SoWrhXDUslBGUzeLJo=;
        b=gJm7Cj/pkoWWQUnl27NK/tKytrGFDviy++KwI0L5uHTMIYksD8WKIzwXU+IWngjPEV
         ZM08FZnmGVIh3ZGKPQVMxZqAB6NfGI84AXfOP5W5/Hwh4BSdfYN92lOt1MOHVKIqLWx7
         fBft2f3atsu5uZZ4yGN8Q+N9rQgKMLQwPUeY6Jy5vd83DFs+Hr/UcW4OM60VsKiohDjg
         3Ej4t9pTQseQctHoE9fB/31LeDwxYC2Bw6LCWYLY11VIoIzP1/Qy+UZ8EWAEgXr1cbM3
         Qzc/uZDlrYxBn5QuEmtt9RLdO3EhzJQBvvWTz4DCWown+mivd+BXmqdLC7xJvOK0tWNH
         Ntpw==
X-Gm-Message-State: AHYfb5hbrL0YHvrL+nGfKg+rBkHzB3LaUPTs1yMuofOLTByXCiQU4OjU
        yFe9XRdL+ESXiwWsdHGBxg==
X-Received: by 10.99.126.87 with SMTP id o23mr25879135pgn.443.1502746253400;
        Mon, 14 Aug 2017 14:30:53 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id h62sm15842737pfc.97.2017.08.14.14.30.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Aug 2017 14:30:51 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com, peff@peff.net,
        peartben@gmail.com, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 0/2] clang-format
Date:   Mon, 14 Aug 2017 14:30:44 -0700
Message-Id: <20170814213046.107576-1-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <20170808012554.186051-1-bmwill@google.com>
References: <20170808012554.186051-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v2:
 * Changed a couple rules to be more inline with our coding style.
 * Added a Makefile build rule to run git-clang-format on the diff of the
   working tree to suggest style changes.

I found that the llvm project also has the git-clang-format tool which will
allow for doing formating changes based on diffs so that the parts of the code
you didn't touch won't be formated.  It also has a nice '-p' option to only
apply hunks of suggested changes.  I also saw what Ramsay did and attempted to
add a Makefile rule to run clang-format.  This bit may need more tweaking to
get it right.

Brandon Williams (2):
  clang-format: outline the git project's coding style
  Makefile: add style build rule

 .clang-format | 165 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Makefile      |   4 ++
 2 files changed, 169 insertions(+)
 create mode 100644 .clang-format

-- 
2.14.1.480.gb18f417b89-goog

