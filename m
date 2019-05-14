Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E6281F461
	for <e@80x24.org>; Tue, 14 May 2019 11:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfENLWc (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 07:22:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35364 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfENLWc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 07:22:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id p26so22356080edr.2
        for <git@vger.kernel.org>; Tue, 14 May 2019 04:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=91N9RP5ay9Tjj0AoB7+cyRGeEh+JSOQ6CqjF9TWM/dw=;
        b=sESOOJPfchWj83AHWp167qGfs4MAAlzJVz91Sk4LAfHkil+7WkLwNdQqnaegr12Tmv
         khUFCHJ7Kk5zeZbUXt1Ei69MDm+pdURR8R1xx0WjbJRJzWBHK+7CyFnXAgNpA1rDjvTZ
         X/sWLxtF3iPoYbuYDQmLW7p/8fVcHj2Da4+UK2EEPy60xz98HDv0KszdnBx+HY2sBMd1
         LU5abi4LdrUCIHWKWQxWeojbxGwN9qksra3d3IKzswphGSaPkuXfuVSHm1FU+ITYIM7j
         CzHS9HXsCqECYWsNQD099ZZAWv0sWKvgQC7uCWrSsJ+iilDOZnYBp6hwMlHBZH/6lGLs
         aRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=91N9RP5ay9Tjj0AoB7+cyRGeEh+JSOQ6CqjF9TWM/dw=;
        b=UV23+/l/TgHBH1TaJOQ9DfgEGELM3fKA41cyvhQbx3hwZhANI1weIdg1jjSyA7JwpD
         0KAJs1mY63Ct2D2CLpBSYxH6sxGmruGSX/zScHP4m1TkYO1dJZ3yaW1fYAagwf0WMFeL
         Lnys/0gnvIUVcmCWU1f4fwxP9c1j9/phXy/+TjHirsjMhywOcaasbwHjlyW+XMg1jk2F
         P/iX6JE9HmXmEWmNY0L2+7QNRIaVCcqlbPqfYHgeyMPOWmrMoMhh/2dhO4X6zSqBGH6V
         eKSchuUwO/LL388Xkn5YB5Lrt5WY9X/rpIMy0p56xNCFfZeDDpD1I6Fajx+h0r5pdE5a
         SxTQ==
X-Gm-Message-State: APjAAAX9T1jPqZH52/3jVgr6RZZCJss+ZBAHj4U0tP6IY6PILmj4UIwz
        urEwaxwdIeqQyb7HrWZfvv7fPQPE
X-Google-Smtp-Source: APXvYqzcGSQbqT74f++msyWXGUAqIJQ9kgwFw47wuCOOsGWvwL4TxazzYs8as7NCiHIkyhferYGrmw==
X-Received: by 2002:a17:906:e8c:: with SMTP id p12mr26264582ejf.18.1557832950844;
        Tue, 14 May 2019 04:22:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q11sm4581928edd.51.2019.05.14.04.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 04:22:30 -0700 (PDT)
Date:   Tue, 14 May 2019 04:22:30 -0700 (PDT)
X-Google-Original-Date: Tue, 14 May 2019 11:22:24 GMT
Message-Id: <pull.194.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/5] Clean up after the removal of the scripted rebase
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

Technically, there is still one part that is scripted: git rebase
--preserve-merges. But that is already deprecated, and the remaining parts
really are no longer scripted.

Meaning that we do not need git-rebase--am.sh.

While at it, clean up a few other places that reference the scripted rebase,
and also move the functions from git-rebase--common.sh directly into the -p 
backend (because it is the sole remaining user).

Johannes Schindelin (5):
  Drop unused git-rebase--am.sh
  t3400: stop referring to the scripted rebase
  .gitignore: there is no longer a built-in `git-rebase--interactive`
  sequencer: the `am` and `rebase--interactive` scripts are gone
  rebase: fold git-rebase--common into the -p backend

 .gitignore                     |  3 --
 Makefile                       |  2 -
 builtin/rebase.c               |  7 +--
 git-rebase--am.sh              | 85 ----------------------------------
 git-rebase--common.sh          | 69 ---------------------------
 git-rebase--preserve-merges.sh | 55 ++++++++++++++++++++++
 sequencer.c                    |  2 +-
 t/t3400-rebase.sh              |  2 +-
 8 files changed, 58 insertions(+), 167 deletions(-)
 delete mode 100644 git-rebase--am.sh
 delete mode 100644 git-rebase--common.sh


base-commit: ab15ad1a3b4b04a29415aef8c9afa2f64fc194a2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-194%2Fdscho%2Fdrop-rebase--am.sh-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-194/dscho/drop-rebase--am.sh-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/194
-- 
gitgitgadget
