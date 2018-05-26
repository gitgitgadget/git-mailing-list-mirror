Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6B81F42D
	for <e@80x24.org>; Sat, 26 May 2018 13:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754717AbeEZNzx (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 09:55:53 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:47088 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754521AbeEZNzu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 09:55:50 -0400
Received: by mail-wr0-f193.google.com with SMTP id v13-v6so1823027wrp.13
        for <git@vger.kernel.org>; Sat, 26 May 2018 06:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q50WsWaWFIJ4O6c1mufdICqPPEgjK0KCGVOHH6XbvE4=;
        b=tc2RHAeVaXCU1H3pBInjBOMTg0JRrL34pEf2m4yKJmV+5ahuaLXwGMJsEragIoCFlj
         8gqX99esILOkuqb6+k3Su2nHDlLvsdQ6nBOjRtsjgLy51v5OU6Uyjc7DPCmO30DmKF9W
         8vQg6K34ECp92sK47XWgST3uY0pegcaW5Yu4m4aGVc7jsMoBKQ0enFEy9FgHSTlJCYPg
         rIoCdh244M08iUJyxQKUmROHbcAme0KrnZgZHbSeJKvtI8yTXG94i+W7/EeSFSr+X21I
         qYtZ4liEg3NT3R/TAauj4hLETPkWOmqYKYHM7+1cThNuGx/X7y+e99TiLYfJSk275CJE
         yiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q50WsWaWFIJ4O6c1mufdICqPPEgjK0KCGVOHH6XbvE4=;
        b=rG8s+WfnOyjNZK1LD2/2L1XFKj6Tpv5p1b+hZw/ftNEHtJ33WPJLd+u1oRvpLdufvd
         6GrzCDHzHKuPCu/Zz2Ie6OwT+eQBdSqt0Yf1RwpEYSwFBXK6HZMilg8Z13HMLBvRRco/
         mJM9d0oJriU/l7LHN1t1yPmAvGNrVY+FcdKdWhm8ab7AmmKS1qJ7kouBuMZbubeWw8s+
         6opjvjlLWz/PKiZJjSAL2wxyOLHtC0o7GsHRfqI7UZoTEBHDbSu/Da/lekDLvbz4OnSl
         0ci2fscPpf0RPZZd0Dr4z2YewoIS3PPhx7ogi3wSDtZEoN798ktB/LOxvE7J/FMrw3BH
         +eHQ==
X-Gm-Message-State: ALKqPwf2uhOZQmSd+zbU0mfr9eyDVfdP1H9QSaeidoirYdsKJF55Cl4i
        0eNDFmmwksGVpRF4LQldZ/Y=
X-Google-Smtp-Source: ADUXVKJ+P0wnKY2iGJNu1sZoO/7gxYGuMDqxYraHlgaJreMNJW69fq140+xyZdtjaLDYkwwLbtXb+g==
X-Received: by 2002:a19:1003:: with SMTP id f3-v6mr3719580lfi.114.1527342949497;
        Sat, 26 May 2018 06:55:49 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z4-v6sm4941431lji.14.2018.05.26.06.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 06:55:48 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 09/11] completion: keep other config var completion in camelCase
Date:   Sat, 26 May 2018 15:55:29 +0200
Message-Id: <20180526135531.4516-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180526135531.4516-1-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com>
 <20180526135531.4516-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last patch makes "git config <tab>" shows camelCase names because
that's what's in the source: config.txt. There are still a couple
manual var completion in this code. Let's make them follow the naming
convention as well.

In theory we could automate this part too because we have the
information. But let's stick to one step at a time and leave this for
later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1b0c30ed9a..efc930c9d1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2249,20 +2249,20 @@ _git_config ()
 		;;
 	branch.*.*)
 		local pfx="${cur%.*}." cur_="${cur##*.}"
-		__gitcomp "remote pushremote merge mergeoptions rebase" "$pfx" "$cur_"
+		__gitcomp "remote pushRemote merge mergeOptions rebase" "$pfx" "$cur_"
 		return
 		;;
 	branch.*)
 		local pfx="${cur%.*}." cur_="${cur#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl_append $'autosetupmerge\nautosetuprebase\n' "$pfx" "$cur_"
+		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_"
 		return
 		;;
 	guitool.*.*)
 		local pfx="${cur%.*}." cur_="${cur##*.}"
 		__gitcomp "
-			argprompt cmd confirm needsfile noconsole norescan
-			prompt revprompt revunmerged title
+			argPrompt cmd confirm needsFile noConsole noRescan
+			prompt revPrompt revUnmerged title
 			" "$pfx" "$cur_"
 		return
 		;;
@@ -2291,14 +2291,14 @@ _git_config ()
 		local pfx="${cur%.*}." cur_="${cur##*.}"
 		__gitcomp "
 			url proxy fetch push mirror skipDefaultUpdate
-			receivepack uploadpack tagopt pushurl
+			receivepack uploadpack tagOpt pushurl
 			" "$pfx" "$cur_"
 		return
 		;;
 	remote.*)
 		local pfx="${cur%.*}." cur_="${cur#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl_append "pushdefault" "$pfx" "$cur_"
+		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_"
 		return
 		;;
 	url.*.*)
-- 
2.17.0.705.g3525833791

