Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5CDA1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 11:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfBHLVc (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 06:21:32 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34440 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfBHLVc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 06:21:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id j18so1543438pfe.1
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 03:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DFZENMtGuzmAV7kZTBr2oM8uubuin3VxWAc/z4Tw6UM=;
        b=qunQmBqK8aXFGIkbLJ2Puz2Smago0Q3bMGZAIcy79rCnGMvgoq+lYrtkS9yW4ySbF9
         H1Pa3ZpSYxMdSQx0z4nW8jz4aMfwHh0LZAkJ3+u1IYCKdXEsjKBipSf45MBKFdLJN+Q5
         n9cGkEBTJ1PYwbSuDzoXGEnUuU5CkSsNChC5rQ8R454xDVOpzvHnxB+9sEJqd/LQ7AyR
         s403YNZWJbvK9FA3NDnJ3Y1Iae3+fuFRNgUDKtuPVf3D662Y0fL0zCkfQUr+/mMlIh4Y
         XT1nmiT1QVI8TAI2aluIy2lwLxH1Nr0Y/CvoP1Ic7fYz6hxrtEIezC8/u+KwAVE/Sa1K
         4Eow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DFZENMtGuzmAV7kZTBr2oM8uubuin3VxWAc/z4Tw6UM=;
        b=VcVoK8vmp79MDB8+RGUlXUr9Dt6lGrTrIS/opytWtoJjS4vRBfjmSZF88W3ntJoZma
         1k5IHy8TIlmesu/51tlO6v+94u5ML9EQMc2D8Vi3FKt+DMDyLYeUDq7xx4ArG0nzlqID
         Hz5HkPXiryXpQy6Xj/hwWLruutIRvmzbQnRZLMtvXlot4JL8GhB9lEOMgFgr7QX+IbPv
         RCaW0EmxkR072B2BOiLzpMELrLXiIqSTWL2yRgyVBNKGQ52FlJ/1ok098AYH4q7j1ZjS
         ZRKx9WQEuEGsPko6S+mkce5S3dby+9EyE09GZgrFGfNZU5nn4ui37hfww9ZNPEt6aaBA
         +xRQ==
X-Gm-Message-State: AHQUAuYjXMH+vl2NVzRHzkWtCuaf8GhGF4azXuJURKw8/kY0YHOHfeK1
        JGWqiN8k6lnySplqtAil1YEK8Lz3
X-Google-Smtp-Source: AHgI3IbW09UhhkRppk24osVseT+NKnebQKzasLDhkQL8mGZxfI2qGjiHCc69PrmYcgUFGGYfbIr56g==
X-Received: by 2002:a62:81c1:: with SMTP id t184mr22210661pfd.40.1549624891372;
        Fri, 08 Feb 2019 03:21:31 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id t90sm2586414pfj.23.2019.02.08.03.21.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 03:21:30 -0800 (PST)
Date:   Fri, 8 Feb 2019 03:21:28 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v4 1/3] git-submodule.txt: "--branch <branch>" option
 defaults to 'master'
Message-ID: <2ba8751212b634dd18e16011b1714588e43502e1.1549624679.git.liu.denton@gmail.com>
References: <cover.1549534460.git.liu.denton@gmail.com>
 <cover.1549624679.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549624679.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This behavior is mentioned in gitmodules.txt but not in
git-submodule.txt so we copy the information over so that it is not
missed.

Also, add the missed argument to the -b/--branch option.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-submodule.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index ba3c4df550..4150148fa3 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -255,13 +255,14 @@ OPTIONS
 	This option is only valid for the deinit command. Unregister all
 	submodules in the working tree.
 
--b::
---branch::
+-b <branch>::
+--branch <branch>::
 	Branch of repository to add as submodule.
 	The name of the branch is recorded as `submodule.<name>.branch` in
 	`.gitmodules` for `update --remote`.  A special value of `.` is used to
 	indicate that the name of the branch in the submodule should be the
-	same name as the current branch in the current repository.
+	same name as the current branch in the current repository.  If the
+	option is not specified, it defaults to 'master'.
 
 -f::
 --force::
-- 
2.20.1.522.g5f42c252e9

