Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6922047F
	for <e@80x24.org>; Sat, 29 Jul 2017 22:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbdG2WZK (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jul 2017 18:25:10 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34776 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752758AbdG2WZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2017 18:25:09 -0400
Received: by mail-pg0-f65.google.com with SMTP id v190so26935939pgv.1
        for <git@vger.kernel.org>; Sat, 29 Jul 2017 15:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+vCL24wLCczY7m58QNnjr7qiyYlwKak+CydqdQz3OiY=;
        b=DtuyNlz6R+70/CsMUMH8r3TB0GACvWBHEKLwK3828LMSRQNbdRDjx266/BfPE8/SrS
         GXPixcqrZN6nTesejhI/mebe6rT7XmI3YQ2WTKzOrMvHNRRSMivQphgnAGyctmBQBHHV
         wwPJAtoqrbqfKzeWWNueK7CGc46Pn8wHIEO3dKr5JTY1+MSMvZj92J6T9ofwUKsrkMK7
         UWuKQA+EnzMtSZT9jFGe1DUgpbo5SJtoTJhw2p61ZFGzlX0OS6j6SvQ9EgoDK+15hik2
         z0weADJ9o712RHxR0EnESXWzySWaDJCYFcn7CXMuKTvxv2OpliKJDX2d1ofIh0Vj2sSL
         BRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+vCL24wLCczY7m58QNnjr7qiyYlwKak+CydqdQz3OiY=;
        b=HBNpEY3Xc/cJZ/EKtvW+2e6vSMCdgzxgIcUPHPsbNsda67plsHnUJ5NirJeLSaffXE
         vnq6ZRh26PqbP9LXYaQrylqReKDr2T9PdpIsc19NW8++LeIzNBpSRbBMPYopa0bZbnko
         es9sffhwVBJN/R185r0w17CXf6fUoNbxcCHH7LxOsrGi3TGzVFRmYwvza2MRsmZTcyNh
         SovRc7cCfavSVChcKEfHVBgQ1BVS5egBBQJT/qRVxaSVotc1U1PKY3SQH7uOR64ApUJX
         Ln0jqmyccEJQ7Ikf/vARdnfuPJj+DZ93LOa4G7eLIBA1fvhKDos4W8R2oKxZtCPxmG33
         YJ/Q==
X-Gm-Message-State: AIVw113//7GOVBvkeVeOMQSGiQJgv7g28pz2uu2sTND7U5k2FDy26j6f
        uqbj1KDSrOcK4jXG2aM=
X-Received: by 10.84.209.231 with SMTP id y94mr12218807plh.392.1501367108991;
        Sat, 29 Jul 2017 15:25:08 -0700 (PDT)
Received: from localhost.localdomain ([47.11.7.4])
        by smtp.gmail.com with ESMTPSA id w125sm43476409pfb.117.2017.07.29.15.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Jul 2017 15:25:08 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, bmwill@google.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH v2 11/13] submodule foreach: clarify the '$toplevel' variable documentation
Date:   Sun, 30 Jul 2017 03:53:59 +0530
Message-Id: <20170729222401.12381-12-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170729222401.12381-1-pc44800@gmail.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
 <20170729222401.12381-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It does not contain the topmost superproject as the author assumed,
but the direct superproject, such that $toplevel/$sm_path is the
actual absolute path of the submodule.

Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 Documentation/git-submodule.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index a23baef62..8e7930ebc 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -188,7 +188,8 @@ foreach [--recursive] <command>::
 	$name is the name of the relevant submodule section in `.gitmodules`,
 	$sm_path is the path of the submodule as recorded in the superproject,
 	$sha1 is the commit as recorded in the superproject, and
-	$toplevel is the absolute path to the top-level of the superproject.
+	$toplevel is the absolute path to its superproject, such that
+	$toplevel/$sm_path is the absolute path of the submodule.
 	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
 	variable is now a deprecated synonym of '$sm_path' variable.
 	Any submodules defined in the superproject but not checked out are
-- 
2.13.0

