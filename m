Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3689D1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 00:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfH1ANP (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 20:13:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34904 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfH1ANP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 20:13:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id d85so460408pfd.2
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 17:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xt9DOqKfkJ1xbizDP8LXtXefze3n8RU02LicksjtuzE=;
        b=EKPbV7yN4C1WfWOYC1W5P1iU+7JyEeAeskdwAaFQmMt3UKXdBXosAmBEL8UExJmeA+
         fD6EArW9acbTi6NRpVRx13/prFdtlRT3IPCqj8+4R4AOUO3AhRNg+MtRyRIc95xLVoSa
         HE1tPKUctoVDfliS9E2l2CBu46xvWFTVnaIcIOrLRZY/M6QY5ql4V4f5pK1PZqUbVB/Q
         6+9mGpwzDnyhncKs6bhnTtzplySLiZjRQd0iRM4PgdvWAVynX/hHkAcufk9DKMm40nmG
         AroDlUQOkJLq6sckPUd+AXuxaTs+rlV0LGjqOdVWOYeoJh9tn6TndgD47YPpqTx5anS1
         srFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xt9DOqKfkJ1xbizDP8LXtXefze3n8RU02LicksjtuzE=;
        b=iC8NpAPXTL69i5lp3xioofjglQTMZjuU+9J90TOyIwPBhQal5uJrUpCmNWoLhLDtuz
         RviJDLm38YCBpsm3da395WDiiBnwhNuF6xW832/aKg7A5gCMEaAQVG4goQ1ajRulW71H
         1TWelKUP+gMeZwpAF3J97dWo5vfCDRLRRimVqMwiYctGVGfIUh3MlJTM5z3DdcZa955x
         qK9h8CUUY4ogEDhdk9mUlF0gLwd0B+yxIZt6OuLYWwzLfvfYS/uIyGqm3YrJtk58fNzY
         EaODnI52Oe1ZBCFHn77kLErzq8Gb0/qGONN+frKlXcvSAPKH/g6u+w9Ho8zKm55orITM
         Lu4A==
X-Gm-Message-State: APjAAAWFUE7sFEwICnKmzV7MitBLIN9wr4czmPiXJgVeTTjsUe5H9ESO
        88caEd+RGv3uI4r62JyA+7Yp2oHI
X-Google-Smtp-Source: APXvYqyt5dYwAze8ahnlOrRRFcZj1CnNxOEUDepgbyIygYEopu/zocwJ2B/4AujoeQUmbOO2bcdWOQ==
X-Received: by 2002:a63:e901:: with SMTP id i1mr953006pgh.451.1566951193765;
        Tue, 27 Aug 2019 17:13:13 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id p5sm469115pfg.184.2019.08.27.17.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Aug 2019 17:13:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH] merge-options.txt: clarify meaning of various ff-related options
Date:   Tue, 27 Aug 2019 17:13:07 -0700
Message-Id: <20190828001307.8042-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.38.gfc6987be7e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discovered on the mailing list, some of the descriptions of the
ff-related options were unclear.  Try to be more precise with what these
options do.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
I noticed this patch sitting around in one of my branches, and noticed it
wasn't upstream.  I'm pretty sure I submitted it a few months back, but I
think it got lost in the cracks.  Resubmitting and I'll see if I can do a
better job following up on it.

 Documentation/merge-options.txt | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 79a00d2a4a..b39df5f126 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -40,20 +40,22 @@ set to `no` at the beginning of them.
 	case of a merge conflict.
 
 --ff::
-	When the merge resolves as a fast-forward, only update the branch
-	pointer, without creating a merge commit.  This is the default
+	When the merge can resolve as a fast-forward, do so (only
+	update the branch pointer to match the merged branch; do not
+	create a merge commit).  When a fast forward update is not
+	possible, create a merge commit.  This is the default
 	behavior.
 
 --no-ff::
-	Create a merge commit even when the merge resolves as a
-	fast-forward.  This is the default behaviour when merging an
-	annotated (and possibly signed) tag that is not stored in
-	its natural place in 'refs/tags/' hierarchy.
+	Create a merge commit even when the merge could instead resolve
+	as a fast-forward.  This is the default behaviour when merging
+	an annotated (and possibly signed) tag that is not stored in its
+	natural place in 'refs/tags/' hierarchy.
 
 --ff-only::
-	Refuse to merge and exit with a non-zero status unless the
-	current `HEAD` is already up to date or the merge can be
-	resolved as a fast-forward.
+	When possible, resolve the merge as a fast-forward (do not
+	create a merge commit).  When not possible, refuse to merge and
+	exit with a non-zero status.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
-- 
2.23.0.38.gfc6987be7e

