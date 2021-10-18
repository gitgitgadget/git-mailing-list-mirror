Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F7DC433FE
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 12:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93CA60FC3
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 12:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhJRMnc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 08:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhJRMn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 08:43:28 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6328EC06161C
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 05:41:17 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id t184so13766185pfd.0
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 05:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t/Bu2/6pgzP/2vdq6GEAgKqoYBFNWRRq1Hg2ewLGGGg=;
        b=FwloW4oy2VMctqFC7ohbSuyeJ2rELVwR+8adUg7++Sge0vcP5hGIDO2JjiQojp9Icf
         n38ZrDQOUOOrHp+bt6EQrMIez0UaO78Yg72UJLvI5ZeYHYIM433O1my5PRaiBocqgxhr
         q3tcQ5IFXjv9vuKackzUqx5815hCAdzMFy7zbkjjAzNWBBnxyq5Zm+TvNRfObJyvhp/5
         v8LKstJjk/bCyM2XXd6CnZHSNIPSSVDB3meHADWLL9pM7Z5ZzwWy6an10jlh3otaarBQ
         EVJh1P7Ts6sBcnBb1Wxa3NaF2lmfwhqLR25GdCtvCMhZKGs4VhsdFsbABMvWYjjB0Pt6
         mpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t/Bu2/6pgzP/2vdq6GEAgKqoYBFNWRRq1Hg2ewLGGGg=;
        b=CH0G2m8FkIxeKCQFpNaGHxWFJZEDmIhseduq0Y585QMm51ObDiK+1tvxk+IMiq/jvU
         kfzls+IMsHl2s5SSv8dKPdoTfTCYGugPSZETJGaOUzwWxVVHig9eugIcwxCy1VPVpAym
         PQ86IUHAOD+Jlj1VowGuTateNXZzmqZ1N5c1l5HxEalP7dfPd/k/bx6NuP+jLHdDfVN8
         RuBPQPo0N5nS+TkRcl4y8IHED+bqvWjRzgtl07w1TkGUI6RlrRnnd9C1oW4F1BY1l5JA
         TydKi+x+nDWWUOvyD9q3aP4IWq63P3zJzO2ruURwU6fubmkEi8fd9lVLZvn9IM5hMcW6
         lKug==
X-Gm-Message-State: AOAM5316A+wgEfXK2Y9KoJERcNQr7pvvNvXC0RrwTzGdy3R6psvKUYWN
        urAuT7e66oix+T0SWAP1FZ8ncvq+1HyY7A==
X-Google-Smtp-Source: ABdhPJzLsaA39ZJNDyv4P5yqyxneNJeCB+yX9d03bnN6GrNNOVtucDw8/bo3nKl7KkIpjn8WmNU5YQ==
X-Received: by 2002:a63:7402:: with SMTP id p2mr23487738pgc.472.1634560876655;
        Mon, 18 Oct 2021 05:41:16 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-4.three.co.id. [180.214.232.4])
        by smtp.gmail.com with ESMTPSA id u24sm12978841pfm.27.2021.10.18.05.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 05:41:16 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v3] Documentation: specify base point when generating MyFirstContribution patchset
Date:   Mon, 18 Oct 2021 19:41:06 +0700
Message-Id: <20211018124106.542050-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Specifying base point (commit hash) can help reviewers and testers
interested on the patchset. Mention how to record it with `--base`
option to `format-patch`.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Changes since v3 [1]:
     - rewording (suggested by Glen)

 I don't apply Junio's suggestion that use `--base=auto`, because in
 most cases invocations of the option requires full hash of base object
 and AFAIK people just do `git checkout -b` without specifying the
 tracking option (`-t`).

 [1]: https://lore.kernel.org/git/xmqqo87q6whk.fsf@gitster.g/T/#t

 Documentation/MyFirstContribution.txt | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index b20bc8e914..1c4cd092ee 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -902,10 +902,19 @@ is out of scope for the context of this tutorial.
 === Preparing Initial Patchset
 
 Sending emails with Git is a two-part process; before you can prepare the emails
-themselves, you'll need to prepare the patches. Luckily, this is pretty simple:
+themselves, you'll need to prepare the patches. Luckily, this is pretty simple.
+First, we need to get hash of the commit the patchset is based on. We call
+this commit the `<base>`:
 
 ----
-$ git format-patch --cover-letter -o psuh/ master..psuh
+$ git show -s --format="%H" master
+----
+
+Now generate the patchset, passing the hash of `<base>` to the `--base`
+parameter:
+
+----
+$ git format-patch --cover-letter --base=<base> -o psuh/ master..psuh
 ----
 
 The `--cover-letter` parameter tells `format-patch` to create a cover letter
@@ -916,6 +925,10 @@ The `-o psuh/` parameter tells `format-patch` to place the patch files into a
 directory. This is useful because `git send-email` can take a directory and
 send out all the patches from there.
 
+The `--base=<base>` parameter tells `format-patch` to embed base commit
+hash to the cover letter. Reviewers and testers interested in the patchset
+can create branch based on the specifed base commit in order to apply it.
+
 `master..psuh` tells `format-patch` to generate patches for the difference
 between `master` and `psuh`. It will make one patch file per commit. After you
 run, you can go have a look at each of the patches with your favorite text
@@ -1046,7 +1059,7 @@ reviewer comments. Once the patch series is ready for submission, generate your
 patches again, but with some new flags:
 
 ----
-$ git format-patch -v2 --cover-letter -o psuh/ --range-diff master..psuh-v1 master..
+$ git format-patch -v2 --cover-letter -o psuh/ --base=<base> --range-diff master..psuh-v1 master..
 ----
 
 The `--range-diff master..psuh-v1` parameter tells `format-patch` to include a

base-commit: f443b226ca681d87a3a31e245a70e6bc2769123c
-- 
An old man doll... just what I always wanted! - Clara

