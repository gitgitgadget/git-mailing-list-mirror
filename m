Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D3DF1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 18:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfGRS6X (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 14:58:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44669 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbfGRS6X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 14:58:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so13298499pgl.11
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 11:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZHU+ZB7+DjiXNIhCVAP01+oPVUPeR4kK3OjdMv2tSfk=;
        b=hiznAUxcQwC5LzHiPK8xSYt3gLSFar3ef2NLx9MiMYWhQWhNRH5MFGvMDjQkSHsZg0
         e/EDP5drF5oNKE5grFwVgKWPDChuZqWl55u8sZ1+X/MYMuBZgs7BrtDVEuEXZFPGkgFH
         RnosiLpwsq9J8pdp7k+OVw3nRY4aLH8UcoMvAnIJWglWbAK++gM6HRDRb3v8iK+bIUet
         WEuu0JrJ6cou8Nr7Q1h4m9Ekq7UVbu9gLYvtQT6LIHACwfs3sAg55ulWX4pO/PtePWRF
         qddVCsDlNoM6H7j8P/gnANVAxInsI4wV1sWiK7wtkG0P0+ryzRHYOsxK2aggf3CylLQb
         ih2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZHU+ZB7+DjiXNIhCVAP01+oPVUPeR4kK3OjdMv2tSfk=;
        b=tze0jr49XuMfc7VNOZaxMYizT8f4V98mncJaeDCfb9OcozH6Q13vw2P2Q2sybmCB/f
         G4W8eJ8KxoKUhZ5K3Fd0iA21DEIF1jFB8ISAUYLP3uRfo2MbgPwljA2Hq6RJ+7a+Z2+c
         dGloopODF3NzOyI1LslKEx5PL3aWhdk63TTCpVVbloB43JKGNApYizdIJ2OaaQaK4QBr
         boR0B2/oZzKk5K0MmS68wkUyeOu607WsD/y6/z1iJSHCqgbcPLd8pT4gjJEAov7u+PwR
         OVBPin2ELZd7y0qpixTmmBntLSNhDMH5Q/HfmwJxS0RgaA0zfPqHeaYtacG766t9StPy
         edMQ==
X-Gm-Message-State: APjAAAXxjTtqHdlQdQojZshWYgh+MTBKFhb9eU9tsUYF5DDAKjZCBDde
        55XVZtNSHH+FH7+Hh4Sz41c=
X-Google-Smtp-Source: APXvYqzqPlUpFoL5zPGwFhkTuFwddbaOlGs67ykcyev6R1+F9J6s+kgo2jRPXn7iZIMTVfmUm4VtnQ==
X-Received: by 2002:a17:90a:8688:: with SMTP id p8mr53446261pjn.57.1563476302061;
        Thu, 18 Jul 2019 11:58:22 -0700 (PDT)
Received: from ar135.iitr.local ([27.63.78.254])
        by smtp.gmail.com with ESMTPSA id f3sm45861671pfg.165.2019.07.18.11.58.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 11:58:20 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     Rohit <rohit.ashiwal265@gmail.com>
Cc:     Dscho <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio <gitster@pobox.com>, Martin <martin.agren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>
Subject: [GSoC][PATCH v2 0/1] rebase -i: support --ignore-whitespace
Date:   Fri, 19 Jul 2019 00:25:13 +0530
Message-Id: <20190718185514.20108-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190712185015.20585-1-rohit.ashiwal265@gmail.com>
References: <20190712185015.20585-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Another revision to keep the thread alive.

Rohit Ashiwal (1):
  rebase -i: add --ignore-whitespace flag

 Documentation/git-rebase.txt            |  9 +++-
 builtin/rebase.c                        | 26 ++++++++--
 sequencer.h                             |  1 +
 t/t3422-rebase-incompatible-options.sh  |  1 -
 t/t3431-rebase-options-compatibility.sh | 66 +++++++++++++++++++++++++
 5 files changed, 97 insertions(+), 6 deletions(-)
 create mode 100755 t/t3431-rebase-options-compatibility.sh

Range-diff:
1:  7dda0de288 ! 1:  a1bb91fe43 rebase -i: add --ignore-whitespace flag
    @@ -85,6 +85,15 @@
      		OPT_STRING(0, "strategy", &opts.strategy, N_("strategy"),
      			   N_("rebase strategy")),
      		OPT_STRING(0, "strategy-opts", &opts.strategy_opts, N_("strategy-opts"),
    +@@
    + 	argc = parse_options(argc, argv, NULL, options,
    + 			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
    + 
    ++	opts.strategy_opts = xstrdup_or_null(opts.strategy_opts);
    ++
    + 	if (!is_null_oid(&squash_onto))
    + 		opts.squash_onto = &squash_onto;
    + 
     @@
      	am.git_cmd = 1;
      	argv_array_push(&am.args, "am");
-- 
2.21.0

