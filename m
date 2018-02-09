Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0934D1F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeBILEo (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:04:44 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:35936 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbeBILEn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:04:43 -0500
Received: by mail-it0-f65.google.com with SMTP id n206so10201187itg.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+D7Eg599TjFBnvZ1alze/Rh70E7XSagcxseHhXsuOI=;
        b=tuE57HbUbk3X2q+f08GBCTWLRI7UDgsv7Qhwu7fWnL3z4HCNqp0uGLAeIIoEZnmkUS
         AB0IMx9BLmBkfVtvOthvfJb0FAMeWrs7PDYBGmsB53jsK5Oif891f3KrDsb/+OxMhO7N
         5vB1ZxCjcEaqDbxFqeTAlxi1KC+uW5u3on8scFFaz+rCq+S5aA3d9dwR0Lv5aiz6ymAU
         9AMCLsaoNfBXifXCLWYsIerdDWIpyc+m6+naZTV+m+AIgvt43ulYJyBVObof/PNFthHY
         Pf2cKrDOSmv8ygiwaZuvzyUKKt7UGxv7LKk7GWUxWbBvoW0C1Z9KVvji3vS+9HhxhpVl
         LAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3+D7Eg599TjFBnvZ1alze/Rh70E7XSagcxseHhXsuOI=;
        b=tNxpZbGuStPGGGsdrG3udxjZ4J1q+lDsiFlML9xmOdhB/psD8DPP4waBW0G5I1DRiq
         8c3FspToDCDSTKzx1BtVaQz81jb96EDSoxgrRIbDoNCUblccWQXb/M4NPPGH5Q3+aM+Q
         EqzRhZSGo8XI6Rt9K7ZY+OdOzNrqKky5LrD9KoNsksneacrFEf/7H4geTQOR0+0i93jr
         PyyARukT6TXRR3YawCteVMZsliIBlUR866T29iANYtwhz9SH+5a00E4ABk95df31Ms/0
         fPJy1Jon/fuLdYhNuhi7PZOxpDNP1pKGUKU3RPaoylwWA+rYQN+K62kYwaoSIpQpq+y/
         fCFg==
X-Gm-Message-State: APf1xPAFgDHZRRkIBCzWlWvM1uqvlCD3yhWpQz4wmG0dFPzdUMOiF8EL
        jE0ubupREO5InhSfznvvF8BnhQ==
X-Google-Smtp-Source: AH8x225YUQ5uzbTli0ev/vK+63yqzylaTHOAH0r7ZFr9BMLQcURhxK81pxcQE8a7h3G27NnovoaSmA==
X-Received: by 10.36.172.6 with SMTP id s6mr2948330ite.88.1518174282526;
        Fri, 09 Feb 2018 03:04:42 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id m10sm2139195ioe.40.2018.02.09.03.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:04:42 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:04:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 23/42] completion: use __gitcomp_builtin in _git_ls_files
Date:   Fri,  9 Feb 2018 18:02:02 +0700
Message-Id: <20180209110221.27224-24-pclouds@gmail.com>
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

The new completable options are:

--debug
--empty-directory
--eol
--recurse-submodules
--resolve-undo

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 36ed502ed0..1ea06b6e17 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1616,13 +1616,7 @@ _git_ls_files ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--cached --deleted --modified --others --ignored
-			--stage --directory --no-empty-directory --unmerged
-			--killed --exclude= --exclude-from=
-			--exclude-per-directory= --exclude-standard
-			--error-unmatch --with-tree= --full-name
-			--abbrev --ignored --exclude-per-directory
-			"
+		__gitcomp_builtin ls-files "--no-empty-directory"
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

