Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B13C433FE
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 21:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54DD361247
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 21:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbhJBVdC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 17:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJBVdB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 17:33:01 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BA6C061714
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 14:31:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o20so3725810wro.3
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 14:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5HpEFRgJq0O69ZuRNMCvE6ly2Jp9QU5AuKvOo2VI9fk=;
        b=QqenQjjL44TRb+6YzRISUvNXOTci1uxGr0KpntV0xXXkPU6ecnyWW17fbaNPEYa4cb
         v6SsfojKfqUMABKJ5wzJLMytrS+l8VtJv2GlEPU55HnyDSfdvFaNHwTOkF9zDPapTleu
         ijujmQZe8sDYIkoa5zFbRYArfDwBMxqiuU6oIexqhP3D+FjWHZCjwNujv7CFDXz0B003
         /YdKYl4VXAbAfCxfiisiDe2+ntUpXBrHAoJ2Sptl41KZobuT2oTJiZHEO/JYgl95gZkx
         hhNZCKuHJ2mUdISLQP+DX2SRt7fJ6IFCLTRE95VK8bNBZKDXtlt5uYFAMWZZPOD8mzWM
         BV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5HpEFRgJq0O69ZuRNMCvE6ly2Jp9QU5AuKvOo2VI9fk=;
        b=AhMOYSEdJ82Kzq6warYkhGNtGdNd93yfPTZ1Ke/p6CQs79rJbpDsuYGRM1YDI92cjg
         z7hpCFD4hbUsHTcGCKM22uXOxE2Lpju/0xFzPXLLT2OLdVfffukOZssqkXTYymC5rVBS
         K4rdiVGnSoSLg8B9KbOx5bC38lUBGi5vldNiEv/jqKND/m1jeYe6JPal8wq1iYNoJhX4
         T4tCzxiQ9TrnchV3pI8rSVaAO7kn1cN2wAtUzSPT8C2OV0h0IVUE4huKCt91RQH2uzSq
         Ek8Al5c1W0cIH3auGtkwXGjFGepAyruKqtRc+38C3GjOyauKs8ZKH8QUaOJDBPRLwrE6
         ZG7Q==
X-Gm-Message-State: AOAM533aqu+iA1BPfVGzLXD1qxoLGOJZoOT7f70ZaCwSXTPH82yzIW/T
        KS1BvzC5gyrgIew6q0/9o/v1vDpro4c=
X-Google-Smtp-Source: ABdhPJzqCZmX79T5ZeNjhZesFx9kQfuGjDnZ9YxWlx7Zlock9Le36/Q/sMFej+5vbfsDmuK7dVXA2Q==
X-Received: by 2002:a5d:6c65:: with SMTP id r5mr5136652wrz.85.1633210273435;
        Sat, 02 Oct 2021 14:31:13 -0700 (PDT)
Received: from localhost.localdomain (77.119.208.5.wireless.dyn.drei.com. [77.119.208.5])
        by smtp.gmail.com with ESMTPSA id e5sm9607297wrd.1.2021.10.02.14.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 14:31:13 -0700 (PDT)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     git@vger.kernel.org
Cc:     aclopte@gmail.com
Subject: [PATCH 2/2] Documentation/git-status: document porcelain status T (typechange)
Date:   Sat,  2 Oct 2021 23:30:46 +0200
Message-Id: <20211002213046.725892-2-aclopte@gmail.com>
X-Mailer: git-send-email 2.33.0.rc2.dirty
In-Reply-To: <20211002213046.725892-1-aclopte@gmail.com>
References: <20211002213046.725892-1-aclopte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As reported in [1], T is missing from the description of porcelain
status letters in git-status(1) (whereas T is documented in
git-diff-files(1) and friends). Document T right after M (modified)
because the two are very similar.

A porcelain status containing C (copied) is impossible because "git
status" does not detect copies, only renames. I was going to delete
mentions of C from git-status.txt because it keeps confusing users [2]
but a discussion from 2014 suggests that "git status" should re-learn
to detect copies, which was disabled in 2005 for (obsolete) performance
reasons [3].

[1] https://github.com/fish-shell/fish-shell/issues/8311
[2] https://www.reddit.com/r/git/comments/ppc2l9/how_to_get_a_file_with_copied_status/
[3] https://marc.info/?l=git&m=141755095826447&w=2

Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
---
 Documentation/git-status.txt | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 83f38e3198..40f308c6a6 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -207,6 +207,7 @@ show tracked paths:
 
 * ' ' = unmodified
 * 'M' = modified
+* 'T' = file type changed (regular file, symbolic link or submodule)
 * 'A' = added
 * 'D' = deleted
 * 'R' = renamed
@@ -217,14 +218,16 @@ show tracked paths:
 X          Y     Meaning
 -------------------------------------------------
 	 [AMD]   not updated
-M        [ MD]   updated in index
-A        [ MD]   added to index
+M        [ MTD]  updated in index
+T        [ MTD]  type changed in index
+A        [ MTD]  added to index
 D                deleted from index
-R        [ MD]   renamed in index
-C        [ MD]   copied in index
-[MARC]           index and work tree matches
-[ MARC]     M    work tree changed since index
-[ MARC]     D    deleted in work tree
+R        [ MTD]  renamed in index
+C        [ MTD]  copied in index
+[MTARC]          index and work tree matches
+[ MTARC]    M    work tree changed since index
+[ MTARC]    T    type changed in work tree since index
+[ MTARC]    D    deleted in work tree
 [ D]        R    renamed in work tree
 [ D]        C    copied in work tree
 -------------------------------------------------
-- 
2.33.0.rc2.dirty

