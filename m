Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7E981F453
	for <e@80x24.org>; Tue, 12 Feb 2019 09:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfBLJ4R (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 04:56:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42411 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfBLJ4R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 04:56:17 -0500
Received: by mail-pf1-f196.google.com with SMTP id n74so1043882pfi.9
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 01:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Clk+wFX7Wv5eSVRv/iYXBdhhpiY2dDces9vCMo3iIY=;
        b=CfWlMgIa9Y8nngrY2jYpGAElFeBlkgX3XR6f8BA3dYbSMqc2EeFUqstWabITNCDgL4
         V/mpppi9DgflWL3O+CYiWiBuwC96m2blhCEDpMYjT866SdR0n5cOPzVW7AfRgGVtoJ1Y
         tk47fkaJWoikfLPfIb4CnECprVgP19J+oW9INTvDaaplMyTCtBSW2Tk2fIBvmO0y7kmu
         aTJqBEDQEs/Wy1L7ZBZlIQocxgUbCNkf6Z5U6Aus/jvit2Iif6Ly06EIDIMppiI0GVzR
         1TGfWHzlGcnGObOKxApp/BlFp6mt+73JeSZoLw8HSUskXhkmejketJLzTacVGGMY6wAE
         6tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Clk+wFX7Wv5eSVRv/iYXBdhhpiY2dDces9vCMo3iIY=;
        b=KeckxqKh8ivp8Y6kQ1UnJ1ynvOpW/g+mP6be3UiA+q+5SvLJhsNy3Ei/3PYSL+eCVs
         IYFvBJb9bHEAhoa+U9lI+wlx1D/1u8GS3f35fkwKtIJdIk8Ns6qn/KjxRXPVOmc08+b9
         pHF/wbey6pCdrlMU7Ef2BPdTDV0eAMZgLkU2gkPvFXS2tX+LHlTMdcJBBcFrluratvD9
         NGJstuRb8DPuSwbxyh/nzZGwZdKeS+W5xZ4uMYH1alC3OjmrE4z4gfqvVZi6leCW5Y1J
         HKbCsreWlu/zedyeFpmyKvm78yNm1C7tgpohg9CpckNwO7h8z1YfQujSckLWMddScyel
         IFhw==
X-Gm-Message-State: AHQUAuaUxiBV1CNro09wL72oITY8+W36qg9Q7u3tZCodXGOD+fOboePS
        2qNXw2F5PdNO9rIWrzHX1iiidlWR
X-Google-Smtp-Source: AHgI3IZ9gtYsiLwNRnX6CbPwnTd/EsjITSUeEkIjEmM87oh0RJ8W5CkkgoepnB471AWL9MUHLeu7hg==
X-Received: by 2002:a65:4049:: with SMTP id h9mr2847620pgp.304.1549965376040;
        Tue, 12 Feb 2019 01:56:16 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id y21sm17903491pfi.150.2019.02.12.01.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 01:56:15 -0800 (PST)
Date:   Tue, 12 Feb 2019 01:56:13 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com
Subject: [PATCH v2 3/3] submodule: document default behavior
Message-ID: <d8785cdd01503f2a7b9a6fbc19105c41a9a04046.1549965172.git.liu.denton@gmail.com>
References: <0b62f65a8016c41b96aa6caead366e1ed9dda333.1549944164.git.liu.denton@gmail.com>
 <cover.1549965172.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549965172.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch documents the default behavior of submodule if no subcommands
are given, similar to how remote documents it in both git-remote.txt and
in its usage output.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-submodule.txt | 4 ++++
 git-submodule.sh                | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 65a952fb96..2fdf9f4cf3 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,6 +9,7 @@ git-submodule - Initialize, update or inspect submodules
 SYNOPSIS
 --------
 [verse]
+'git submodule' [--quiet] [--cached]
 'git submodule' [--quiet] 'add' [<options>] [--] <repository> [<path>]
 'git submodule' [--quiet] 'status' [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] 'init' [--] [<path>...]
@@ -28,6 +29,9 @@ For more information about submodules, see linkgit:gitsubmodules[7].
 
 COMMANDS
 --------
+With no arguments, the default command is 'status'.  Several subcommands are
+available to perform operations on the submodules.
+
 add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]::
 	Add the given repository as a submodule at the given path
 	to the changeset to be committed next to the current
diff --git a/git-submodule.sh b/git-submodule.sh
index 5e608f8bad..1ccc758e79 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,8 @@
 # Copyright (c) 2007 Lars Hjemli
 
 dashless=$(basename "$0" | sed -e 's/-/ /')
-USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
+USAGE="[--quiet] [--cached]
+   or: $dashless [--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-- 
2.20.1.522.gd8785cdd01

