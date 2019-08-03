Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 821CF1F732
	for <e@80x24.org>; Sat,  3 Aug 2019 23:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfHCXwM (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 19:52:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35581 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbfHCXwM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 19:52:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so69725796wmg.0
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 16:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Qe//y22+5m9jIt2OrZZOav+OagvivZaRyDCjQwL3TzE=;
        b=VRnMIvFLC8yABDddGyXOTlI5WiWyCzPKqwWvfTIaZEniEFNxCRAwo5fSP9S9LPMGSg
         60FT9lpZPgRRU+UXDhQXWGzVtrQ8Nn4yYPBwd2+tv8PhE9NiDeNdmvni3fnnAobl7Woi
         CMbdxNQdvrUx3NJ97o2GMc9KQNmR0S//OBxO9ZtZJSN7aznF91kqy4rpcIoyhgGemocc
         Zl6HmL8LimrrCFOU/RrnJwuSRJqCB1k9h7F9gay036WH2KuNrhHx86+ElUbKcr9f0okf
         r9A7BEOD9tT5x6PPH9dDDIiSdFtXGX0pu3A7MPYdC1+QwlLeXLlsL1vjgE8BYj2PnbbY
         cEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Qe//y22+5m9jIt2OrZZOav+OagvivZaRyDCjQwL3TzE=;
        b=CMRnluX+HvOfEqWnwy09pyThGTRvNzEwUD3APthCo5sTaZmj8LUilTExS88bOYmemw
         ojptvkPGWq7hP1sDzt0rz2DDt4J5V+g4VRjoHW0DhUmP2QtnWF7vSYWmyMVYvzXrDdK0
         IQDlLCRTPhRCuOQtxrGCSj1HtIvZKo5EVZQeaJR8bDx9uqn4snhOCxmepl8a+Mpd9F+b
         Q4rZW0Om072dOXJ2t5t+v7uvNz0uF0tP4eEpFlXxGuqeqpt/moL0gfI5u2ZaYLctDAmE
         TICC5Feorl/o2gOsbXFhwHhabNN7xwGUsr8YFvnBQUXKvyiS4TCKm2JidhFbkDBuHl3c
         P2vQ==
X-Gm-Message-State: APjAAAWynqy5/nC24HflItQ3+TQpV9kYykQm+jt0o2RnesWAMc1fpIdM
        8XcgYrkuxCQ/yJcSmpjZxfGVUjeC
X-Google-Smtp-Source: APXvYqwQB/Nn3kBlxXORVHZxjcyFuhirCrJXx3lmMBaITSti0lwqIf7xmuAnYsbd3Rwq91vx/18KEg==
X-Received: by 2002:a1c:228b:: with SMTP id i133mr10653944wmi.140.1564876329420;
        Sat, 03 Aug 2019 16:52:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u1sm75589355wml.14.2019.08.03.16.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 16:52:08 -0700 (PDT)
Date:   Sat, 03 Aug 2019 16:52:08 -0700 (PDT)
X-Google-Original-Date: Sat, 03 Aug 2019 23:52:01 GMT
Message-Id: <pull.305.git.gitgitgadget@gmail.com>
From:   "KADOTA, Kyohei via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/6] Port git to Plan 9
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I ported git, and git subcommands only written in C to Plan 9. This pull
request contains patches for existing codes, and new files to build git in
Plan 9.

All build options such as NO_PERL are not supported yet, and also some git
subcommands written not in C is not available yet. But git can synchronize
to remote repository with git pull and git push via HTTPS.

This pull request don't contain a part of Git toolchain for example
git-credential-store, etc. So I'm going to port other parts of Git toolchain
too in the future.

Whole installing process is published at 
https://medium.com/@lufia/14fee2ad7493

lufia (6):
  Change HOME, PATH, and .gitconfig paths to be customizable
  Fix C syntactic errors for the Plan 9 C compiler
  GIT-VERSION-GEN: Use sed instead of expr
  Port generate-cmdline.sh to rc
  Add plan9/wrap.c
  Add mkfile to build git and subcommands for Plan 9

 GIT-VERSION-GEN               |   2 +-
 Makefile                      |  26 ++++-
 builtin/config.c              |   2 +-
 compat/plan9/openssl/crypto.h |   5 +
 compat/regex/regex_internal.h |   3 +
 config.c                      |   5 +-
 credential-cache.c            |   2 +-
 credential-store.c            |   2 +-
 exec-cmd.c                    |   4 +-
 generate-cmdlist.rc           | 102 ++++++++++++++++++
 git-compat-util.h             |  17 ++-
 help.c                        |   2 +-
 mkfile                        | 195 ++++++++++++++++++++++++++++++++++
 parse-options.h               |  18 ++--
 path.c                        |   6 +-
 plan9/wrap.c                  |  16 +++
 remove-bitfields.rc           |  14 +++
 run-command.c                 |   4 +-
 sequencer.c                   |   2 +-
 shell.c                       |   2 +-
 20 files changed, 402 insertions(+), 27 deletions(-)
 create mode 100644 compat/plan9/openssl/crypto.h
 create mode 100755 generate-cmdlist.rc
 create mode 100644 mkfile
 create mode 100644 plan9/wrap.c
 create mode 100644 remove-bitfields.rc


base-commit: f36d08d72e7f68f880f8c1d7646cb3809c820485
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-305%2Flufia%2Fplan9-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-305/lufia/plan9-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/305
-- 
gitgitgadget
