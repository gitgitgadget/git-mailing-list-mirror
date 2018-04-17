Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DE831F404
	for <e@80x24.org>; Tue, 17 Apr 2018 21:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbeDQVaE (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 17:30:04 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33559 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752310AbeDQVaD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 17:30:03 -0400
Received: by mail-wr0-f195.google.com with SMTP id z73so39325361wrb.0
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=72xdwE+Z7DwndswFH6/EzrxbxxKWjolZqTC8QtbCvkQ=;
        b=SYbv67/ffyV+bC3R5iI/cEFQFSJhz4hS0hzEmi7f70B+Z2yEQfZgLBzl27jCYOpgdz
         NKTzJsgOW2u+DuJ6yFRVwge6LLOkQRcQiDCLX6BzSti6LRbQsaNN0l+/YZRukWGM3FTZ
         2p8Pp7KdnBH5ZIv9E7VUDLqrVfi7y3JzhAy4WogO+gCAtFAyUEDkLqc7HtWFHtr+4EqL
         vHW8MVsRnkJrUDcgC3o/OdvuNOS1mQapRPSFQoxFCQ8OQvfEPgrZpPF53tdlbBtz2wAL
         2g2knsHXNUdjpN/IvyzsxRBcEroX3wPHjAp2O6OiKmzuSHDM9uzubL6vj1KL3TNKVEBq
         AnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=72xdwE+Z7DwndswFH6/EzrxbxxKWjolZqTC8QtbCvkQ=;
        b=bafGt47x1veXaRdgKJ4KRpg+DhJbFT+K4jwa3MjlWxiXwFp/r0jIUFLVjlFAYrIJf5
         QBeIjIj14gEzi2Phrnc5vEtJeN0r3tTZ3NDEhngQRlfDiG3R4ZCQUUZPUGrPpjlmhhhg
         wou4PTOspDSoiG5anKDTBXk4NUFETGKn0CBxEcSSM9smuNuG197d8mTYJrZXmcTpBOAf
         nQXk/QapAyjsKnHwg3CJQL5vzKQOhf1bMSVQQKwbbshbLiV/9D57V9B/juny94eFPPPs
         9fPdnwpaTOSmSN8cRgbozXhk1cCPQl7Rwa00t/sbet9Uuy6EVgT+b79mlVqogoTYRAbW
         aP1g==
X-Gm-Message-State: ALQs6tDIAmqaxdlzVQ7GBclCFFguXrNJ7W1/2gsCozURvVlLfDsqiPjk
        5rjHqPt1xrCTRLnBB/h4+yuD1+Eb
X-Google-Smtp-Source: AIpwx48sEtprCHb7nulg31k9oY9suqbQfXwNah2bEFAWxKO1NIQxsklarY+AO6wne5ZYrCqjecnTqg==
X-Received: by 10.223.153.45 with SMTP id x42mr2848325wrb.145.1524000601566;
        Tue, 17 Apr 2018 14:30:01 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id w14sm11487804wmd.1.2018.04.17.14.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 14:30:00 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 3/3] completion: make stash -p and alias for stash push -p
Date:   Tue, 17 Apr 2018 22:29:45 +0100
Message-Id: <20180417212945.24002-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
In-Reply-To: <20180417212945.24002-1-t.gummerer@gmail.com>
References: <20180417212945.24002-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We define 'git stash -p' as an alias for 'git stash push -p' in the
manpage.  Do the same in the completion script, so all options that
can be given to 'git stash push' are being completed when the user is
using 'git stash -p --<tab>'.  Currently the only additional option
the user will get is '--message', but there may be more in the future.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 contrib/completion/git-completion.bash | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 452c3d4490..8bd445b7dc 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2776,6 +2776,9 @@ _git_stash ()
 	local default_opts='--all --keep-index --no-keep-index --quiet --patch --include-untracked'
 	local subcommands='push list show apply clear drop pop create branch'
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	if [ -n "$(__git_find_on_cmdline "-p")" ]; then
+		subcommand="push"
+	fi
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
 		--*)
-- 
2.17.0.252.gfe0a9eaf31

