Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0B4D1FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 09:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbcHIJet (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 05:34:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33847 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270AbcHIJes (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 05:34:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so1961128wma.1
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 02:34:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dZCB0LMpz6qfxHM2Jj5d2aPLm64gBuZy8IRlyJy4th8=;
        b=O6AsCOxUmCsQJZeAwIr0Hp/cmmbthWMBXJmHysv5Sj4c4nHjfBcCQv82avTfBxqpj/
         LAjsS/QsmySBmLporFN4R9BpQxVVInU3xpe422GiFjVaYByAR1DJWRVpzF4+WmSkgQY+
         eYY0qP9hDVohVOpZmbvW8LdNXwosCDmK97L9WCP6JVRegUcyKub2fcIvdgHJ0nUoHtXZ
         6boQukj4ThTRYShmKGXGoNutnBUwTGlfYnzgMLrzXtxhkmyyXC63Ha57wTG07uDN5E0T
         pZRMH1/uUgWK6kaNXL0PE05fJhoGm6OMaiHXCs7SArS83NEJI948y6igjJEAZGCFPGNI
         bNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dZCB0LMpz6qfxHM2Jj5d2aPLm64gBuZy8IRlyJy4th8=;
        b=LiqnDEg2cJ1QkkicWMZk5tqRaRglt/Ufkx5OUiPFsJcrsm8crG7sAMtXsYuGH1i0k/
         UGMFw+BC/jrsPk8jHUh6BHiIRCX5EJ0RiSwTPIMOstvMXH4FrDejo4jgr2Fe5aMFlsCp
         RA80TRXXxNyMX/yO8evWt5E3yrqK9YwJwRnQsw/oo2p4njjf/D1oPsVQoxXdgnXUHlrP
         aMPDkvuHcSWRbNaKBWFcZAmZkPfVUvl/zLs97BsYXG300YWHkFqpGLa2CMxttjGI4oHD
         Cmj1nfmzFqHnUDUmnde5ozs3AMyG5et1xRv3iLIifjwjA5TARy01XsraOvQ4K+Yy2/Gv
         SFRQ==
X-Gm-Message-State: AEkooussyVMMHmuUWzCe/zn8vzDKrnLZdYBW/3mls24xbRNeKCCS9cQZfZ++S/rB1C0fIA==
X-Received: by 10.46.9.145 with SMTP id 139mr26786099ljj.2.1470735286961;
        Tue, 09 Aug 2016 02:34:46 -0700 (PDT)
Received: from viper.dy.fi (dtpyyyyyyyyyyyyybpcbt-3.rev.dnainternet.fi. [2001:14ba:8300::1:6083])
        by smtp.gmail.com with ESMTPSA id d15sm6359810lfg.0.2016.08.09.02.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Aug 2016 02:34:45 -0700 (PDT)
From:	=?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To:	git@vger.kernel.org
Cc:	remi.galan-alfonso@ensimag.grenoble-inp.fr
Subject: [PATCH v2] completion: complete --delete, --move, and --remotes for git branch
Date:	Tue,  9 Aug 2016 12:34:44 +0300
Message-Id: <1470735284-5686-1-git-send-email-ville.skytta@iki.fi>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1120818262.376555.1465290963431.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1120818262.376555.1465290963431.JavaMail.zimbra@ensimag.grenoble-inp.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6a187bc..76abbd1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1008,8 +1008,8 @@ _git_branch ()
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
 		case "$i" in
-		-d|-m)	only_local_ref="y" ;;
-		-r)	has_r="y" ;;
+		-d|--delete|-m|--move)	only_local_ref="y" ;;
+		-r|--remotes)		has_r="y" ;;
 		esac
 		((c++))
 	done
@@ -1023,7 +1023,7 @@ _git_branch ()
 			--color --no-color --verbose --abbrev= --no-abbrev
 			--track --no-track --contains --merged --no-merged
 			--set-upstream-to= --edit-description --list
-			--unset-upstream
+			--unset-upstream --delete --move --remotes
 			"
 		;;
 	*)
-- 
2.5.5

