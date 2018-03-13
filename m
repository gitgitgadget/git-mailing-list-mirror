Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B99E1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 03:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932534AbeCMDgr (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 23:36:47 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36454 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932523AbeCMDgq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 23:36:46 -0400
Received: by mail-qt0-f178.google.com with SMTP id c7so21296059qtn.3
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 20:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=eCIp8Niq7djdGIh51l0G8/zVyslUpeeLqMgYgrjp9u0=;
        b=Cx4Ejhhjf+goQibLu95QhIWPOe/xvnUQxTiAwtB2KL9rOvbNCVpXUMCW+xl8OKv4ev
         0dMMqo/gleQMUw3PZFE/dh7mml4rqFnVLwNr3c2SBhyof1ArV/COFzahlKFlDe24OKLE
         XCz4hapIkYiZrCguEU2XMZ2b62dMf6KwyME5PysSJdac4XsbiGWGlU8BwIKmklPskYyz
         MmPkTbfCQGqH/DY1ewatFEO/lEMJOkbRMcNaFpjaYivqb3qTCLEqUefMAw9YqmH2oeyV
         xhPHv19MC+LHGPPXR7zhN9T6K9IC+iGEfroww31Ij2d8IN9x+6XWozlqjaEvbqj5v870
         riHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=eCIp8Niq7djdGIh51l0G8/zVyslUpeeLqMgYgrjp9u0=;
        b=fnyIt4jgiCM22vM7AqwquQPfOha3knrLMTcKSKe7kc9n4K8nPF86IJZBnK3/SvymbM
         bjYo3z8b8d4FuWq+UtiMJtMKOPg7JqGL8qF4bMcAuoIunrsUVF63bU+lr+Zp2SuVM2Jx
         Up/7//KJ3oyHYxt4CsVAUFRL81TfW9D2GQ0cWB52a0PTltoBj1Jd7XrmpNaMcFyblr3Y
         lBoammdg8UtbQLdn2q/H6+VFtQYZuxOg+VQPwwerHcLMyw/b8BK/RVbFkxrcRJV5ZJtc
         nenkBrGLWFSuujZJkQVajA+sBlJBMJmTAz3wzfv6apXeBU8DNR2RPeujWa01aUc1zPQa
         G9oA==
X-Gm-Message-State: AElRT7FznrywL1ysIVBVdfR+X9XzeH/PWRLvvxRxMpz+Aaum4pEerbqO
        m4az7ZeVQiANhbOrQQncHClpVh34
X-Google-Smtp-Source: AG47ELvaOtRty1qZyqMpPUt4EaJafzlv70VVxX8BHe6pmNpDTdF+JZJrPTfMFBdRDC8X0c2Su6M61Q==
X-Received: by 10.237.36.167 with SMTP id t36mr6499097qtc.136.1520912205160;
        Mon, 12 Mar 2018 20:36:45 -0700 (PDT)
Received: from viet-VPCEA32EG.hsd1.pa.comcast.net ([2601:4a:c102:100d:3c68:450:1413:42aa])
        by smtp.gmail.com with ESMTPSA id p19sm6348387qtk.74.2018.03.12.20.36.44
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Mar 2018 20:36:44 -0700 (PDT)
From:   Viet Hung Tran <viethtran1620@gmail.com>
To:     Git List <git@vger.kernel.org>
Subject: [GSoC][PATCH] git-ci: use pylint to analyze the git-p4 code
Date:   Mon, 12 Mar 2018 23:36:43 -0400
Message-Id: <20180313033643.7686-1-viethtran1620@gmail.com>
X-Mailer: git-send-email 2.16.2.440.gc6284da
In-Reply-To: <CC42B5EC-6594-45CB-9821-E1C0ECED354E@gmail.com>
References: <CC42B5EC-6594-45CB-9821-E1C0ECED354E@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Mr. Schneider,

Here is my link for the passed CI build I tested on my fork: 
https://travis-ci.org/VietHTran/git/builds/352103333

In order to test .travis.yml configuration alone, I used a sample python 
script call "test.py" that is already successfully tested on my computer
instead of using the git-p4.py like in the patch I submitted since the 
git-p4.py file still reports a lot of errors when running pylint.

It is possible to fix all the git-p4.py errors. However, I think it would
be best to fix each error separately with multiple commits (each should 
fix a specific problem such as indentication, variable naming, etc.)
since there are a lot of changes needed to be made in the codes. Since the
microproject requires that I submit one patch, I decided to submit a patch
that includes changes in .travis.yml only. If you like, I can also submit the
patches addressing changes on the git-p4.py that fix the pylint errors.

Thank you for feedback,

Viet

Signed-off-by: Viet Hung Tran <viethtran1620@gmail.com>
---
 .travis.yml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 5f5ee4f3b..581d75319 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -46,6 +46,16 @@ matrix:
         - docker
       before_install:
       script: ci/run-linux32-docker.sh
+    - env: jobname=Pylint
+      compiler:
+      addons:
+        apt:
+          packages:
+          - python
+      before_install:
+      install: pip install --user pylint
+      script: pylint git-p4.py
+      after_failure:
     - env: jobname=StaticAnalysis
       os: linux
       compiler:
-- 
2.16.2.440.gc6284da

