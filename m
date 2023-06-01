Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5EEC7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 21:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjFAVPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 17:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjFAVPC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 17:15:02 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B228A12C
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 14:15:00 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f6ffc2b314so20417075e9.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 14:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685654099; x=1688246099;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=If+xbtG0etIMEf5e8y2FRVZlVtHmI9cNydA1y8Mtv80=;
        b=HVT14Nst2+J/szC4ChX5O3PdHk5nxHGQIFKgjNB55IzC4GzKyrSK2C9p1A7kuYRxVi
         8hzFNAxCqhtKGnF7krdyyfTOcoE1cp46YIqBxtm6XhddlpJo+9gJb8ErcsobRWcJO8Nd
         JM2Igzfgn56wzE7jX6bH79WtPMV3NsoytilbUOSBatfA6ZQPDnQEvjOEWT8C5HU7QVp6
         f8mMutVbYp4fmDrZLo2y2jxSUzitW0pNR06YKiu/3ydK7/viZgGpQlZareE8judaVaQf
         9TxcIZIasfL68kDZHCcI0PrrAzON/ZzchyXc/9a262P8BwXIeL/FDf73lL2bmbr2cmtL
         hzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685654099; x=1688246099;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=If+xbtG0etIMEf5e8y2FRVZlVtHmI9cNydA1y8Mtv80=;
        b=XokZx/JxmJBPTpKrun/TO5ynDJ+uXXkCcS7ASdB+z0yF8fPkwDyFyyyGwgs+RgxxWV
         POwf1/c0fDJEzC/UNTSl9DMA+Q3y/BzUZefhtlG3W4pp2Iieg19JYo7u3qvIaPsRP+lU
         x7KTa+Vy2Tg74RGUFuZFZ9Wi6t/Xc9QEaQLCCsr9jL8+sQu73+axgOzlh9fvxE5FNaPy
         fgUDQ2De7nYKnpYZ3F8SlWpbSCfODJzGwoOMC7PCmcsmwwM/TFS+3dGM4AVSDRGVyIz2
         ak8VVVVKjfuPfDnSATGnROXJFhPBnf2gCS7KQ/G9TcSPcDZuMyj42KPlT+ewfmEZuD56
         tjTw==
X-Gm-Message-State: AC+VfDyhXguwpU219F4d5Q/LWucEcfN0c0uPMP7/uH7L48/C+MDRiIDN
        l0oY0Le6egvEu+rW+u5ngZaRtS5YQUM=
X-Google-Smtp-Source: ACHHUZ7xuCGdiE30aOIb+kwwGihhqy27EoXrLKIAcWt8dyOZBDVhPxF+hJKtnGlJkZpNgVNx9cv4KQ==
X-Received: by 2002:a1c:7518:0:b0:3f6:1ac:5feb with SMTP id o24-20020a1c7518000000b003f601ac5febmr245930wmc.16.1685654098765;
        Thu, 01 Jun 2023 14:14:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m25-20020a7bca59000000b003f7191da579sm3429065wml.42.2023.06.01.14.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 14:14:58 -0700 (PDT)
Message-Id: <pull.1504.v2.git.git.1685654097812.gitgitgadget@gmail.com>
In-Reply-To: <pull.1504.git.git.1683282753768.gitgitgadget@gmail.com>
References: <pull.1504.git.git.1683282753768.gitgitgadget@gmail.com>
From:   "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jun 2023 21:14:57 +0000
Subject: [PATCH v2] doc: restore: remove note on --patch w/ pathspecs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Adam Johnson <me@adamj.eu>, Adam Johnson <me@adamj.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Adam Johnson <me@adamj.eu>

This note was added with the restore command docs in 46e91b663b
(checkout: split part of it to new command 'restore', 2019-04-25), but it is
now inaccurate. The underlying builtin `add -i` implementation, made default
in 0527ccb1b5 (add -i: default to the built-in implementation, 2021-11-30),
supports pathspecs, so `git restore -p <pathspec>...` has worked for all
users since then. I bisected to verify this was the commit that added
support.

Signed-off-by: Adam Johnson <me@adamj.eu>
---
    doc: restore: remove note on --patch w/ pathspecs
    
    This note was added with the command in 46e91b663b, but it is now
    inaccurate. The underlying builtin add -i implementation, made default
    in 0527ccb1b5, does support pathspecs, so git restore -p <pathspec>...
    has worked for all users since then. I bisected to verify this.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1504%2Fadamchainz%2Faj%2Fgit-restore-patch-docs-fix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1504/adamchainz/aj/git-restore-patch-docs-fix-v2
Pull-Request: https://github.com/git/git/pull/1504

Range-diff vs v1:

 1:  784143b9949 ! 1:  556f4323ce6 doc: restore: remove note on --patch w/ pathspecs
     @@ Metadata
       ## Commit message ##
          doc: restore: remove note on --patch w/ pathspecs
      
     -    This note was added with the command in 46e91b663b (checkout: split part of
     -    it to new command 'restore', 2019-04-25), but it is now inaccurate. The
     -    underlying builtin `add -i` implementation, made default in 0527ccb1b5 (add
     -    -i: default to the built-in implementation, 2021-11-30), supports pathspecs,
     -    so `git restore -p <pathspec>...` has worked for all users since then. I
     -    bisected to verify this was the commit that added support.
     +    This note was added with the restore command docs in 46e91b663b
     +    (checkout: split part of it to new command 'restore', 2019-04-25), but it is
     +    now inaccurate. The underlying builtin `add -i` implementation, made default
     +    in 0527ccb1b5 (add -i: default to the built-in implementation, 2021-11-30),
     +    supports pathspecs, so `git restore -p <pathspec>...` has worked for all
     +    users since then. I bisected to verify this was the commit that added
     +    support.
      
          Signed-off-by: Adam Johnson <me@adamj.eu>
      


 Documentation/git-restore.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 5964810caa4..d31a06a673e 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -51,9 +51,6 @@ leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 	restore source and the restore location. See the ``Interactive
 	Mode'' section of linkgit:git-add[1] to learn how to operate
 	the `--patch` mode.
-+
-Note that `--patch` can accept no pathspec and will prompt to restore
-all modified paths.
 
 -W::
 --worktree::

base-commit: f285f68a132109c234d93490671c00218066ace9
-- 
gitgitgadget
