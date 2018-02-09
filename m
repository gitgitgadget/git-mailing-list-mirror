Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFFB41FAE2
	for <e@80x24.org>; Fri,  9 Feb 2018 11:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeBILEE (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:04:04 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:39031 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeBILED (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:04:03 -0500
Received: by mail-it0-f67.google.com with SMTP id c80so10185901itb.4
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8KboauIgQmf+aG3FAUQ+oXYUpNQzb6I1BQHU9KX/79U=;
        b=PHRfkXm9xLcBsdxLWcoss4BWvSLhRaVy4/fC/G3Pxkbev4kKvBn72ZOcR84q09IJhH
         QDOS7TQAShK5SjDt7c9TCrb8ZPkG0wQEZWsghBo+aRGuDi8vkg+sSaRglqmnFBY0DnZd
         MLGS+gimtwWksmWXXBBNPFu21HS7V7eqc4YJhdXyqqxzEsFZOkb2OF+55pBD5Jp1GHMP
         /okwWnbZcvqR5K5Yi974iL3830kitFr1I4M7XnHb1qVUVuEihqOXW31dL0hxVKH6AkUM
         /bM2BseO5nK8Vs4QbqWGQX6lErWcTF8ZXL+KhX0gLDv9TxvSwgJY1y+j8VxEXSMypAA/
         NSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8KboauIgQmf+aG3FAUQ+oXYUpNQzb6I1BQHU9KX/79U=;
        b=olijKcR4H5FpnkbB3BNVlw/IKc7nipMFZAbW82jupre4UPX69QKIUTDcyZ5hkqFlkE
         PkBxTmNsct0eXaCA1IV2Y8licuV12XjeGKRxtMW+ZWk7hH4AU47h03hncfUpmjaHddaP
         dcbuO9DcRzU6jdW6aXrZmb0bgY7lh6ec/3BpZcHbu0c7akiTFqGgfXwBc1kYkRVARlhP
         pdFCeOwdIdq7n7aTjCy3tUevpmVhZp0lo5lMrtUIjc5/p1IgUJipixdRR5GAAKlQ6mTw
         j0EgI2QVahaduzT3uhNxGw9k0r3dsMGP5BhBzyhCMgkTLROgNlH2G1KfMeG6tl3PT5gZ
         n15w==
X-Gm-Message-State: APf1xPAtigbg0FC2cfS6xgoEqlWFgP8DEcb8HI6XmgP9FSmkXWAS3wpy
        BI8s5Y5eUujvlkcq5rYqtDqCig==
X-Google-Smtp-Source: AH8x226xaumGnFBo9xi2fMTjfTknZgE+fT9MbvP14+98Shs2hQrX8L2Oq0LH4+J3vfcKPqfqVte92w==
X-Received: by 10.36.167.67 with SMTP id s3mr3125231iti.66.1518174242644;
        Fri, 09 Feb 2018 03:04:02 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id n16sm2664656ion.1.2018.02.09.03.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:04:02 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:03:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 16/42] completion: use __gitcomp_builtin in _git_difftool
Date:   Fri,  9 Feb 2018 18:01:55 +0700
Message-Id: <20180209110221.27224-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <20180209110221.27224-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
 <20180209110221.27224-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we can't automatically extract diff options for completion yet,
difftool will take all options from $__git_diff_common_options. This
brings _a lot_ more completable options to difftool.

--ignore-submodules is added to $__git_diff_common_options to avoid
regression in difftool. But it's a good thing anyway even for other
diff commands.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7a98f01067..7763f88347 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1394,7 +1394,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--dirstat --dirstat= --dirstat-by-file
 			--dirstat-by-file= --cumulative
 			--diff-algorithm=
-			--submodule --submodule=
+			--submodule --submodule= --ignore-submodules
 "
 
 _git_diff ()
@@ -1435,11 +1435,11 @@ _git_difftool ()
 		return
 		;;
 	--*)
-		__gitcomp "--cached --staged --pickaxe-all --pickaxe-regex
-			--base --ours --theirs
-			--no-renames --diff-filter= --find-copies-harder
-			--relative --ignore-submodules
-			--tool="
+		__gitcomp_builtin difftool "$__git_diff_common_options
+					--base --cached --ours --theirs
+					--pickaxe-all --pickaxe-regex
+					--relative --staged
+					"
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

