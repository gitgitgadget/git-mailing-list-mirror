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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3173A1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 11:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfGAL6R (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 07:58:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41705 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfGAL6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 07:58:16 -0400
Received: by mail-ed1-f65.google.com with SMTP id p15so23048829eds.8
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 04:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tuPsSmDic2L64dkm6kao22RR7bgo2HS/6sEDS7XIdr8=;
        b=vUnu9PG5cvXUdquCjxNkkwWs+8vouHfonIQ3PGxd/2BY7LXyeHx7HsLd3DrH29CW6o
         n5OGxwWiuTDryrrX9Rk7WJfMyNFRa7GILCrXxVW6e9h2WdNtuH8TE2eUxdZrvzIx/RnM
         yP5kA0oAus6ceFUx/OWPnzqu8lIeypFpQ/v4kz0t8MafWOKWnT+Ab2xFHpQo1czQPBX9
         dtUPj8bbnpfYzoRRSdPWpvAWLgVazO/DHAD8G0b+H8fxI4f6rHQReX1LGWbvj9mxD62R
         0oWF7PPdGiDHzBR+Dg0kpKEAzQA16mju4i6dYSkwJluVVa9/CH/jj1AdIa1/Fsrj6FhP
         KlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tuPsSmDic2L64dkm6kao22RR7bgo2HS/6sEDS7XIdr8=;
        b=g2KLGuLpQASsxsUnLPYwT/xRjP0vrZFoYl9A6TeNMjNLBGDKD47fJiDF9758rvXPK9
         VeHzshvnN91HI2CcV8brf4NzUCoUCOQEMj6mCNue1Be+htsnofj0fRArMhjcZ4YdRCCK
         XkQD1q71l+31iu3j/fkdE5ZiSQ1aA1blFM2eZwFUOKAWnHpuosVBsBzk5TZPQDGdLpSW
         hY3EXsVhCV97uvuvJZTtzoLXQo5BTSFSUEnyek/yCZy+/xptK/kIe6Xo18yVJKn7Uqus
         qrQUQMU+yBWZexqY9Co9uoIpfsH+LFgS/7IiPdfcSnZ2a/l2tJ3y0ybrVUcebVMUUZok
         B0Rg==
X-Gm-Message-State: APjAAAUGRpD0MCEl8y5wr03oiYe88M9N+i8ZEPUFZswpDRN6LNgBsDCR
        t2wZlOmVezWXg/wQWAuyPnAWfsG0
X-Google-Smtp-Source: APXvYqxMviIrJBrbQ4WZQZuYQgFCUdYi4STpDM7uKcG0fIboz/D2g3TUlJ94Z2wIt/eNkwk4UwM9fA==
X-Received: by 2002:a50:886a:: with SMTP id c39mr28363446edc.214.1561982295434;
        Mon, 01 Jul 2019 04:58:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k3sm3386472edi.14.2019.07.01.04.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 04:58:14 -0700 (PDT)
Date:   Mon, 01 Jul 2019 04:58:14 -0700 (PDT)
X-Google-Original-Date: Mon, 01 Jul 2019 11:58:13 GMT
Message-Id: <pull.253.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.253.git.gitgitgadget@gmail.com>
References: <pull.253.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] Make rebase.reschedulefailedexec less overzealous
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Vas Sudanagunta <vas@commonkarma.org>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This config setting is pretty useful, but it unfortunately stops all
non-interactive rebases with a bogus error message. This patch fixes that.

Reported via a commit comment on GitHub
[https://github.com/git/git/commit/969de3ff0e0#commitcomment-33257187].

Changes since v1:

 * Based on Junio's advice, the commit message was improved considerably.
 * The error message now also mentions --exec, so that users do not have to
   know that --exec implies the interactive backend.

Johannes Schindelin (1):
  rebase --am: ignore rebase.reschedulefailedexec

 builtin/rebase.c           | 10 +++++++---
 t/t3418-rebase-continue.sh |  8 ++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)


base-commit: e11ff8975bedc0aae82632c3cb72578c3d7fc0b2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-253%2Fdscho%2Freschedule-failed-exec-gently-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-253/dscho/reschedule-failed-exec-gently-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/253

Range-diff vs v1:

 1:  fab124da41 ! 1:  beaeb24bc0 Let rebase.reschedulefailedexec only affect interactive rebases
     @@ -1,9 +1,13 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    Let rebase.reschedulefailedexec only affect interactive rebases
     +    rebase --am: ignore rebase.reschedulefailedexec
      
     -    It does not make sense to stop non-interactive rebases when that config
     -    setting is set to `true`.
     +    The `exec` command is specific to the interactive backend, therefore it
     +    does not make sense for non-interactive rebases to heed that config
     +    setting.
     +
     +    We still want to error out if a non-interactive rebase is started with
     +    `--reschedule-failed-exec`, of course.
      
          Reported by Vas Sudanagunta via:
          https://github.com/git/git/commit/969de3ff0e0#commitcomment-33257187
     @@ -35,8 +39,10 @@
       	}
       
      -	if (options.reschedule_failed_exec && !is_interactive(&options))
     +-		die(_("--reschedule-failed-exec requires an interactive rebase"));
      +	if (reschedule_failed_exec > 0 && !is_interactive(&options))
     - 		die(_("--reschedule-failed-exec requires an interactive rebase"));
     ++		die(_("--reschedule-failed-exec requires "
     ++		      "--exec or --interactive"));
      +	if (reschedule_failed_exec >= 0)
      +		options.reschedule_failed_exec = reschedule_failed_exec;
       

-- 
gitgitgadget
