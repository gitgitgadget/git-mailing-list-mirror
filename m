Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70BF51F462
	for <e@80x24.org>; Tue, 28 May 2019 12:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfE1MI5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 08:08:57 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:27569 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1MI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 08:08:57 -0400
Received: from localhost.localdomain ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id VauUh2dGYWIpcVauUh6wip; Tue, 28 May 2019 13:08:54 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=W6NGqiek c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=xtxXYLxNAAAA:8 a=aulWLQ49AAAA:20
 a=bt3WUTiwAAAA:8 a=bMbd_MaA56Wz9_IoiEkA:9 a=_Qo28uX402cA:10
 a=xts0dhWdiJbonKbuqhAr:22 a=OXx4ngWzwLx9h_IvVXMu:22
From:   Philip Oakley <philipoakley@iee.org>
To:     GitList <git@vger.kernel.org>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] compat/vcbuild/README: clean/update 'vcpkg' env for Visual Studio updates
Date:   Tue, 28 May 2019 13:08:46 +0100
Message-Id: <20190528120846.1056-1-philipoakley@iee.org>
X-Mailer: git-send-email 2.22.0.rc1.windows.1.33.gc7da05f206
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCdUkiduSiB+HGzPresshz+VbhIeRDD6S2JYY99RhiBscJUdR0y9d0mDrjyh8rpB4xh7tX3MWrm7WXcxmW60V6THR+L5Ck+7JJ452VWMUwGCjEaTe60M
 O53TG2d8Vth/dOdRaCygfF2zA59DIHqig60PoNhViKJ+dCpEPpiPMM+afPjN1IDz771OaBSlPyqOG0Y5FrLn150x1p5IQgJCiZ+Gw8Z7jPubUL36cSo+c9Yd
 ht+b1rGSBPvphPc7gc57YA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the user installs an updated version of Visual Studio, the previously
generated MSVC-DEFS-GEN will need to be deleted to allow updating.

Alternatively the whole vcpkg download may be cleaned allowing it to be
reloaded, though this may take much longer on slower connections.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

In response to discussions at:
https://github.com/git-for-windows/git/issues/2186

cc: Jeff Hostetler <git@jeffhostetler.com>
cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>

 compat/vcbuild/README | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/compat/vcbuild/README b/compat/vcbuild/README
index 81da36a93b..40695fc1cc 100644
--- a/compat/vcbuild/README
+++ b/compat/vcbuild/README
@@ -18,6 +18,13 @@ The Steps to Build Git with VS2015 or VS2017 from the command line.
    Makefile:
       <repo_root>/compat/vcbuild/MSVC-DEFS-GEN
 
+   - If you update your Visual Studio version, then delete the MSVC-DEFS-GEN
+   file so that fresh environment variables can be discovered.
+
+   Or clean the "vcpkg" environment with:
+
+   $ make MSVC=1 clean
+
 2. OPTIONALLY copy the third-party *.dll and *.pdb files into the repo
    root to make it easier to run and debug git.exe without having to
    manipulate your PATH.  This is especially true for debug sessions in
-- 
2.22.0.rc1.windows.1

