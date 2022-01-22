Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDBDC433F5
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 21:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiAVV43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 16:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbiAVV4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 16:56:16 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E343C06173B
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:16 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c66so20393599wma.5
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TkPdobH4MibBT4N/wYT3RVIO/1rz+5jRHdHl+Ke0pzM=;
        b=j3ITPR/JoUWnHrSVIUcNb4hCHf3ZzyYX78zm5j3hgeMHTijVKmjCEQbdXXk1rzUmPr
         /j9KCbGV1G+E3dmM5hZZXdMEhRMBr3d6JT0rgwz3ZxAX/4WDMO8biSi8Z6jjN4GAhyWx
         T+FYh2OaT5jyu9xjyQGLTjc8vsVc72pIVkRYghmMSUddI9PXIkEYS2coMm103K57dJSf
         +uDBWu2khG2EnhT22HLrSwDXqA1AunDvTHcVdQk0wmltZzVWAkza0+W+nPilzha1/9My
         RA3mc4OGjW18V+LzIMNYy9cdu6oVUDrZOuDeUN+BiPI+U2kdW9Z25Hdu60HBg0Ut109O
         fqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TkPdobH4MibBT4N/wYT3RVIO/1rz+5jRHdHl+Ke0pzM=;
        b=2wpCGyN/a9eKm7BG12W5sbg3X7Cxo2X8l62mXhrU1CpT8DGkmxmjoC8tJRIQBdm/1O
         ONqolqG7iySZgLfBLbMmw/5Znh3DvCOJ19mAKxuXd+4UJxjvvXBehWJ88Ff2qlQWHfdW
         g8dY+QXy7JWCCgZUtrX0YIZyijMYwlMpbXDY9u33PTDq/aH9UUKiG+eMla/gOqzSnG6A
         WhBpzkS3oi2hZSJFFxpMT8Y+4qjHhz+zneUgjEoNqm7UGsvQsJPuW8IdRnT36t0105Uw
         Yywor0tgdl06lQatZ3Ta3hheTDWtGzxxqEeaZl9lFBiuOgZ+EwLnBI77Sk1bXQIeikkH
         lT4Q==
X-Gm-Message-State: AOAM530lPG8cXBvgJpziXWbt0JCuDrUFMB9k969ViLrySSTqr2Mrg3u6
        +TlaE941HcSV9u7JxZC9cb5wg/umIME=
X-Google-Smtp-Source: ABdhPJySocQnA387F81PeR15rnABjwEbioZSss8N2XyDhRbEhnKXSHxeoeGgb3BT/HMb2K5o0rh4PQ==
X-Received: by 2002:a05:600c:414e:: with SMTP id h14mr3549610wmm.165.1642888574745;
        Sat, 22 Jan 2022 13:56:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 6sm7734976wry.69.2022.01.22.13.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 13:56:14 -0800 (PST)
Message-Id: <4123209cafc953939be66c17e0560749770c5ecc.1642888562.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Jan 2022 21:56:02 +0000
Subject: [PATCH 12/12] git-merge-tree.txt: add a section on potentional usage
 mistakes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt | 46 ++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index df10a5963c7..3c1aa0ffbae 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -136,6 +136,52 @@ that they'd have access to if using `git merge`:
   * any messages that would have been printed to stdout (the <Informational
     messages>)
 
+MISTAKES TO AVOID
+-----------------
+
+Do NOT look through the resulting toplevel tree to try to find which
+files conflict; parse the <Conflicted file info> section instead.  Not
+only would parsing an entire tree be horrendously slow in large
+repositories, there are numerous types of conflicts not representable by
+conflict markers (modify/delete, mode conflict, binary file changed on
+both sides, file/directory conflicts, various rename conflict
+permutations, etc.)
+
+Do NOT interpret an empty <Conflicted file info> list as a clean merge;
+check the exit status.  A merge can have conflicts without having
+individual files conflict (there are a few types of directory rename
+conflicts that fall into this category, and others might also be added
+in the future).
+
+Do NOT attempt to guess or make the user guess the conflict types from
+the <Conflicted file info> list.  The information there is insufficient
+to do so.  For example: Rename/rename(1to2) conflicts (both sides
+renamed the same file differently) will result in three different file
+having higher order stages (but each only has one higher order stage),
+with no way (short of the <Informational messages> section) to determine
+which three files are related.  File/directory conflicts also result in
+a file with exactly one higher order stage.
+Possibly-involved-in-directory-rename conflicts (when
+"merge.directoryRenames" is unset or set to "conflicts") also result in
+a file with exactly one higher order stage.  In all cases, the
+<Informational messages> section has the necessary info, though it is
+not designed to be machine parseable.
+
+Do NOT assume all filenames listed in the <Informational messages>
+section had conflicts.  Messages can be included for files that have no
+conflicts, such as "Auto-merging <file>".
+
+AVOID taking the OIDS from the <Conflicted file info> and re-merging
+them to present the conflicts to the user.  This will lose information.
+Instead, look up the version of the file found within the <OID of
+toplevel tree> and show that instead.  In particular, the latter will
+have conflict markers annotated with the original branch/commit being
+merged and, if renames were involved, the original filename.  While you
+could include the original branch/commit in the conflict marker
+annotations when re-merging, the original filename is not available from
+the <Conflicted file info> and thus you would be losing information that
+might help the user resolve the conflict.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
gitgitgadget
