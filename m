Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85142C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C4C610CB
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhJ1QYy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 12:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhJ1QYk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 12:24:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B34C061226
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:22:12 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 71so4047337wma.4
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=XX1lWVKMhb1BXx65TAaKwXO4xOQZX6EKOafabP6/jkQ=;
        b=lRYwdw/+j5tBd1x3QhrSOvdu9E2jHX4cf3qZnmcVL/Tqu4PBJFvfh7Ps5QKmvvXKll
         3jKWsF4DBTLfud/upPLoUMh7JFnE0UzpV/2GQctvUrudyknjOzsibsp30sakVl63qdZ+
         awy8tsdjlop3PWaG0C4FOCmgTnVzlOdqGnumyQ8NxL5o5i+1acDtiCz9mNR7iR3ZnxSN
         vjnnTFV+8k9UVva67qWsA7Pff0U6F2z57K0saaJOHuwG9pdgZLuGaXjYjSiyImJpbcvj
         sctLHZNcZGBmBmBML38b6ehx9e+I42A3kCc2Gd/HF0d0umU0LBbVSegP+RFluyNt717l
         0lcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=XX1lWVKMhb1BXx65TAaKwXO4xOQZX6EKOafabP6/jkQ=;
        b=tzwgazebp1Zbeb47FiBiFsuXxwwskz3gW6MtzL9bRglJVfMVPmDBQFPGADGkYKHlM5
         MN1MrPtU6Foxq1qgWaAzie4EAkvRx1marMBzlFQK7ENDBolanjYb9c2K3sZTgy66stSN
         N1AB8r1KzVF9+OCF67XwhgzzY62xsNW2EH3gO39tvfkjzwmlxUpHjCHxJJhAmk73lmFW
         uwnrkNcEvOy0tBZVLVOZF4v4R1UXJ8B2j0KHPIx4gvELEI2geHgA3oJRtzypho8FLT1I
         g9Fou3kmb+hw/jA/V/8HAruv0uQsoKJAeqouzr622tosk664WisbKe98p6+aA8KaqLIy
         dOEQ==
X-Gm-Message-State: AOAM532/d9FLJwDTjdTXM2yLmdnk5DxsEdui0vuc+mrr0ZzbjfYW4RA7
        mUURp1aAG3S8dBQIzuT8A3TDhL74JFM=
X-Google-Smtp-Source: ABdhPJzyyt8TKqR1eRh2NeCmGfdpKhorJCVFBLT/SMIDpiyyYWyD7Hhg//EO357EAMVhs3nC8qPhVQ==
X-Received: by 2002:a7b:c1cf:: with SMTP id a15mr5492227wmj.163.1635438130702;
        Thu, 28 Oct 2021 09:22:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y5sm4493624wrd.75.2021.10.28.09.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:22:10 -0700 (PDT)
Message-Id: <7eef3538f3c3015c4f446961ddca78e2868fe644.1635438124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
        <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 16:22:04 +0000
Subject: [PATCH v2 9/9] doc: git-init: clarify file modes in octal.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

The previous explanation was mixing the format with the identity of
the field.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-init.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index fdb7b3f367d..af0d2ee1825 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -79,7 +79,7 @@ repository.  If not specified, fall back to the default name (currently
 `master`, but this is subject to change in the future; the name can be
 customized via the `init.defaultBranch` configuration variable).
 
---shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
+--shared[=(false|true|umask|group|all|world|everybody|<umask>)]::
 
 Specify that the Git repository is to be shared amongst several users.  This
 allows users belonging to the same group to push into that
@@ -110,13 +110,15 @@ the repository permissions.
 
 Same as 'group', but make the repository readable by all users.
 
-'0xxx'::
+'<umask>'::
 
-'0xxx' is an octal number and each file will have mode '0xxx'. '0xxx' will
-override users' umask(2) value (and not only loosen permissions as 'group' and
-'all' does). '0640' will create a repository which is group-readable, but not
-group-writable or accessible to others. '0660' will create a repo that is
-readable and writable to the current user and group, but inaccessible to others.
+'<umask>' is an 3-digit octal number prefixed with `0` and each file
+will have mode '<umask>'. '<umask>' will override users' umask(2)
+value (and not only loosen permissions as 'group' and 'all'
+does). '0640' will create a repository which is group-readable, but
+not group-writable or accessible to others. '0660' will create a repo
+that is readable and writable to the current user and group, but
+inaccessible to others.
 --
 
 By default, the configuration flag `receive.denyNonFastForwards` is enabled
-- 
gitgitgadget
