Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD04C43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 00:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383808AbiFRAVq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383234AbiFRAVc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 20:21:32 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AF969CCF
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v14so7517785wra.5
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MUjTW0FGzziTHwmT76HmwERAj5PW1p0v96TUM4MmGVE=;
        b=l0vd9xoDA2olKoYw/iG+QfVT/6AWTnwGBMH/ClDyc8rP/NzdVuvn4Bo3la6YXrqpTf
         DYs5dlzLu+sFN3SwVK4OdMc1DHbpXQxC/FOSEr2VjIx2oqjD8SiyBB6ythl9nnQRH1Ha
         N6TLlSBAN2eo2nyr8yg7q25KC40HqW1kFFIzDL6xOsPlwQqnec7XU69cU8WEZa6BffE6
         c8F3cqkCBqPeYdWRVNM8TwPR0u7DktA229S8dMolikUNPBP4hx6QIygZ++0/YuLq6ua8
         vUyhbaOLcCoPFaeK/DifmtfSxaH9NMwqiDf5bUSVm7MTV9RS7k6zpmYaRF9znpGOf4qb
         SbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MUjTW0FGzziTHwmT76HmwERAj5PW1p0v96TUM4MmGVE=;
        b=6inVldxpv/qbDCUdB6TiIwhwQT1PBMJyPCiXK82amtvrKpojrVj6HZo3vqD2db48eW
         RJD/vn1MdX93vpJCy0WOqoj3YpisrwoclocZWHkPYu5z9BFaUBWyUrjfXkAu59gGPGwR
         YIrZuprQA6ft8PnRUwyppcHzj/sSAl9A07g3UFvSTU66uF8ldcFp5FXI2NOWTLXA1hp8
         0aGVKnoe8nF61DTE6oXN+UrjddoCZsaSSy+7oCYOgUH9VogA540SNfHee0pq58bSmqaa
         u+qj5EiRnP862jECIlk6s7DKBTruElAkiiMqw+K49nW1910ysmjzo+0p6YeC/kOF+HuJ
         yUlw==
X-Gm-Message-State: AJIora8rKNHxjSuBK1FuBT9SSBJItVycyXBLlgJeFQ1o/YwDlOrflTll
        K4hDMYWwk4Eto/zBfkrOSyvW4XwKL5IxUg==
X-Google-Smtp-Source: AGRyM1s2DsJLW2HqJzdQEzKEYiY7WCkWJ2ZU2q5PsTq8Uc+WQdO/z6YJO8W1jSwEVUHtZs2kQUpliw==
X-Received: by 2002:a05:6000:1c01:b0:20f:c6ff:43d9 with SMTP id ba1-20020a0560001c0100b0020fc6ff43d9mr11646470wrb.156.1655511683790;
        Fri, 17 Jun 2022 17:21:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b18-20020a056000055200b0021a38089e99sm5732054wrf.57.2022.06.17.17.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 17:21:23 -0700 (PDT)
Message-Id: <70ea8281952c4ee75ce67fe907ce32340032e7e3.1655511660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
References: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
        <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Jun 2022 00:21:00 +0000
Subject: [PATCH v7 17/17] git-merge-tree.txt: add a section on potentional
 usage mistakes
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
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt | 53 ++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 628324646d3..d6c356740ef 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -156,6 +156,59 @@ with linkgit:git-merge[1]:
   * any messages that would have been printed to stdout (the
     <<IM,Informational messages>>)
 
+MISTAKES TO AVOID
+-----------------
+
+Do NOT look through the resulting toplevel tree to try to find which
+files conflict; parse the <<CFI,Conflicted file info>> section instead.
+Not only would parsing an entire tree be horrendously slow in large
+repositories, there are numerous types of conflicts not representable by
+conflict markers (modify/delete, mode conflict, binary file changed on
+both sides, file/directory conflicts, various rename conflict
+permutations, etc.)
+
+Do NOT interpret an empty <<CFI,Conflicted file info>> list as a clean
+merge; check the exit status.  A merge can have conflicts without having
+individual files conflict (there are a few types of directory rename
+conflicts that fall into this category, and others might also be added
+in the future).
+
+Do NOT attempt to guess or make the user guess the conflict types from
+the <<CFI,Conflicted file info>> list.  The information there is
+insufficient to do so.  For example: Rename/rename(1to2) conflicts (both
+sides renamed the same file differently) will result in three different
+file having higher order stages (but each only has one higher order
+stage), with no way (short of the <<IM,Informational messages>> section)
+to determine which three files are related.  File/directory conflicts
+also result in a file with exactly one higher order stage.
+Possibly-involved-in-directory-rename conflicts (when
+"merge.directoryRenames" is unset or set to "conflicts") also result in
+a file with exactly one higher order stage.  In all cases, the
+<<IM,Informational messages>> section has the necessary info, though it
+is not designed to be machine parseable.
+
+Do NOT assume that each paths from <<CFI,Conflicted file info>>, and
+the logical conflicts in the <<IM,Informational messages>> have a
+one-to-one mapping, nor that there is a one-to-many mapping, nor a
+many-to-one mapping.  Many-to-many mappings exist, meaning that each
+path can have many logical conflict types in a single merge, and each
+logical conflict type can affect many paths.
+
+Do NOT assume all filenames listed in the <<IM,Informational messages>>
+section had conflicts.  Messages can be included for files that have no
+conflicts, such as "Auto-merging <file>".
+
+AVOID taking the OIDS from the <<CFI,Conflicted file info>> and
+re-merging them to present the conflicts to the user.  This will lose
+information.  Instead, look up the version of the file found within the
+<<OIDTLT,OID of toplevel tree>> and show that instead.  In particular,
+the latter will have conflict markers annotated with the original
+branch/commit being merged and, if renames were involved, the original
+filename.  While you could include the original branch/commit in the
+conflict marker annotations when re-merging, the original filename is
+not available from the <<CFI,Conflicted file info>> and thus you would
+be losing information that might help the user resolve the conflict.
+
 [[DEPMERGE]]
 DEPRECATED DESCRIPTION
 ----------------------
-- 
gitgitgadget
