Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDAB720958
	for <e@80x24.org>; Thu, 23 Mar 2017 12:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbdCWMJu (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 08:09:50 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32875 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752036AbdCWMJu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 08:09:50 -0400
Received: by mail-wr0-f193.google.com with SMTP id 20so2863255wrx.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 05:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sIu5VLa8/UKm0m+KTQ+e+mmrZwZhSLVVUTmf1AsPdIQ=;
        b=Kghi97kPNxDuXMtZR0jRL+XR3bCcFHlY2DFCRteWwREtzK3e0FI6qyZqnwNU9ljCn6
         xPheKRGYsdNdQ8fDyC3nIvAYi/A2lOfRCqKj/mpxORd2ARYA9WLeKKR/0mTbN0o8r9D5
         +Mgj+n8dq1X78C/EFRV1n6MANLsQxCWh2kehyejQHY/XpkZ8sxFyhAoY30L6sNt7ibAy
         SbOXogKpIAlXOGaG3SwNS4cw9EbEOvncqNTm66/tT/wGEM6GgEuCgKLzOMlX1G3OOudS
         +HfwD73TYLYkDsxawGbghwwFqc976WOgBtVecL78Y7K9mDFkIFD6YvQeV4l+OoXmUqw9
         bnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sIu5VLa8/UKm0m+KTQ+e+mmrZwZhSLVVUTmf1AsPdIQ=;
        b=jvjg1pOUagYGYPilzH3KlKxCSeIU6VrwaO6E1AT0JwVg6SDWMRgXcIcOF4HqHPe33s
         qZLFbnGQ8WEfM26iyk3K2tljxOcs0ppkBt7qlsBaI1lsDfj4Nycaw7ZD8cPkQqA9V3yq
         GjE5jeC4ahA3Rw/OaxcMSF9wqRVgbgzKTNmwq6k+xkyixncnumKWIrnRmlQa1swQ4WaK
         76ta7xb8quuoAzF0PM2LfmPtxKwkOUHt45eDsbdWW2EzrLlsHaa5H5KoQazmChhNUvms
         3h+VCta8IRaer75f/i7AH+HoS5URUkJVR02rU2fWPNdwB2ge3CNKyVxgdwfD0ZWA4lca
         CJfw==
X-Gm-Message-State: AFeK/H3kl0XATQ7NhnqyIRFSm/+QudVWyBMCtn3rDC3mAKNaeP2etJtzw46Adv/Azz4bKQ==
X-Received: by 10.223.161.78 with SMTP id r14mr2286786wrr.101.1490270618929;
        Thu, 23 Mar 2017 05:03:38 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v186sm4053638wmv.2.2017.03.23.05.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 05:03:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] branch doc: Change `git branch <pattern>` to use `<branchname>`
Date:   Thu, 23 Mar 2017 12:03:26 +0000
Message-Id: <20170323120326.19051-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change an example for `git branch <pattern>` to say `git branch
<branchname>` to be consistent with the synopsis. This changes
documentation added in d8d33736b5 ("branch: allow pattern arguments",
2011-08-28).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-branch.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 092f1bcf9f..e65e5c0dee 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -142,7 +142,7 @@ This option is only applicable in non-verbose mode.
 	List both remote-tracking branches and local branches.
 
 --list::
-	Activate the list mode. `git branch <pattern>` would try to create a branch,
+	Activate the list mode. `git branch <branchname>` would try to create a branch,
 	use `git branch --list <pattern>` to list matching branches.
 
 -v::
-- 
2.11.0

