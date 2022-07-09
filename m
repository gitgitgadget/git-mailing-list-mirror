Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D80C43334
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 16:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiGIQ43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jul 2022 12:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGIQ41 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 12:56:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF89217066
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 09:56:26 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so2783580wme.0
        for <git@vger.kernel.org>; Sat, 09 Jul 2022 09:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5Np9XCP+2hhHHOOnvqdJGru4DY8gi1d7+5EgVNfQazQ=;
        b=Vf6XJTwlFILlg3BxH3i5vUh2bjRJNPvqkgDINPDS7pKI4xVgLg2bEx8gJAYmMd6IML
         CjlRcX/GLU+DzPxYVpGc6bPQxR8wAKZ2lsr3ORWA5q7RG/B0rBRqz5etsy2Q6DYpLYTG
         /2/YMezY3WkBHoUUnxzKMUayc9jAEZOYFfi4mRxblNfgfVo3HnPLCFc8lCgttXNp+u0R
         ebOrylrD7839BCi/63Z2p0VOxy7aXBAksvOlLkiQHouc2CYlbFitT7tZKqoO8QSeLnS0
         xNY/V3UtfPhZztawc6vMvHNy4Cgk6pNUW50R6xT6lRw+QU3EpZIitWsdK85p0qwpRNQ9
         MAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5Np9XCP+2hhHHOOnvqdJGru4DY8gi1d7+5EgVNfQazQ=;
        b=RvQp9xoEfFQXmO3k2MPl2TDDhSEy8Zc/WdUpo6RP4Nt/FWI8Y+G41yFOdvEqi92Dgb
         EgPT2M0RcPnjea/ILT1IN319C7mijHRrOuFeqiQ9nDO5NF49uA0SnaykFz4+nUssnWSO
         wxE5aZxcOJTDkUIY/pC33mCRJ+ojM0wF9HwTwuqxrvROq04vnejqzUaHuv9bGrqwI03m
         43apPmjwOqTdLuzOoTUE7riKZkRrkJbNLHqiQhDFCC/O9HpheMv3BLX7K9bh8w8lrE6a
         ybamS1oecAf8r09UblqhDKwv7LLUZ0yDrnWxf7joMnVkYPFY+2SqDHqsN52Jxmr12Gd3
         dtng==
X-Gm-Message-State: AJIora+0trVOX3QxbTmj0Kxb+EetlTVLGzcYB03RxE2fMtX5trPsGSUC
        fvBDecbHtkLWNps/po/a2vQtVY5c3gY=
X-Google-Smtp-Source: AGRyM1traIaED89XLbg3jOn6kj8ZjP4W8rPjIpqX9fCfEFoh8/H/QDTAFqwCW0WTPQegbIrkxs4sPA==
X-Received: by 2002:a1c:19c3:0:b0:39c:6479:3ca with SMTP id 186-20020a1c19c3000000b0039c647903camr6332385wmz.27.1657385784974;
        Sat, 09 Jul 2022 09:56:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i25-20020a1c5419000000b003a2cfb9f5basm5336949wmb.16.2022.07.09.09.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 09:56:24 -0700 (PDT)
Message-Id: <32777cae24de91b0fb873ea04a802630ab85aafe.1657385781.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 Jul 2022 16:56:19 +0000
Subject: [PATCH 2/4] glossary: add commit graph description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Philip Oakley <philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.email>

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 Documentation/glossary-content.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index f3342a5ab69..a9e69949a4e 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -75,6 +75,13 @@ state in the Git history, by creating a new commit representing the current
 state of the <<def_index,index>> and advancing <<def_HEAD,HEAD>>
 to point at the new commit.
 
+[[def_commit_graph]]commit graph::
+	The commit-graph file is a supplemental data structure that
+	accelerates commit graph walks. The existing Object Data Base (ODB)
+	is the definitive commit graph. The "commit-graph" file is stored
+	either in the .git/objects/info directory or in the info directory
+	of an alternate object database.
+
 [[def_commit_object]]commit object::
 	An <<def_object,object>> which contains the information about a
 	particular <<def_revision,revision>>, such as <<def_parent,parents>>, committer,
-- 
gitgitgadget

