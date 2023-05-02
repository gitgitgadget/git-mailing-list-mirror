Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90EAC77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 11:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjEBLXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 07:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjEBLXf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 07:23:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FA81BC7
        for <git@vger.kernel.org>; Tue,  2 May 2023 04:23:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f1950f5676so37474815e9.3
        for <git@vger.kernel.org>; Tue, 02 May 2023 04:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683026612; x=1685618612;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G34D0fRyuD7GLUbx1cJ7sP7v1SV28yR4VMZujnyIIJ0=;
        b=JpjCCeoYo9Xl6NsPSyETgCR28yhXDYAprohRaTWhADyl53griRNzAGJzdSzaZV+Goz
         hZLSIjcO0TYSf08r51CNyXxUb66k141CkBNt8xU8iigGZjo+jCP2C///jMaMg9RB0D3n
         lv22rus99bqaifHjYKkOoyamVdWdKE/7sF/EHz6D+i9xDjKKzuwGyl5dzZqU8DKZRHVe
         dT3ObuMtDHM6VF8X3JhJ45S6pD96sCaL0F/1JcBm/+zGJIUPRw4L9YbDma67DC5tgh8u
         hygVHmHyfm/GghpRF6NWtnTqGyFK6YaNl4d9iZnjkLc6GQSL1wz6j5YruqIirdERKNUN
         tAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683026612; x=1685618612;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G34D0fRyuD7GLUbx1cJ7sP7v1SV28yR4VMZujnyIIJ0=;
        b=UeO2tiS+Sqz8h2SE8rztEGhS2VMgdXd8pjvq8cPV4cVrNSdumYlj8ZC71cwAzltixY
         8axFcjP6kCV8LfhvnG+PJLG04rIwD+zvG6CbovSeQMDs83hpDD2p7fCGr7n7K/NAXv1/
         Zks2HXfzaZqeggfWM5QJrF3u/MckriRhUKPIKreyNNilgJ0s4SXxlpnAQdRlKOtKGF3f
         YZxDTQyeR5YrbwBxekIbk521eM0FB0mn3WD+i4bvK5po2DK9AjxvhRlVwscuxa1ueFvo
         8AyI9hLLI5iJdaf1UI5raK4VHKihoKWWCAXC6Lrqnj11oEGA31YwB7cicUYbBFsSmGF4
         C/6A==
X-Gm-Message-State: AC+VfDwFsJRQRvXEqVYd3eZ/bXUDq6Y4NFgHevZ8jDCbzMPzHN7f+N5g
        863x5pmqUw3SfNeFRHjzekqXMVIbSvw=
X-Google-Smtp-Source: ACHHUZ4gdr5/z99PDEjpi+BzFuWUdSuer68OIfypL98Dny1Q+ysZU2yL8GMwmd7NVE/TfJLk/gFZGA==
X-Received: by 2002:a7b:cd82:0:b0:3f3:3cba:2f1e with SMTP id y2-20020a7bcd82000000b003f33cba2f1emr4150612wmj.23.1683026611798;
        Tue, 02 May 2023 04:23:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c21-20020a7bc855000000b003f17300c7dcsm34976235wml.48.2023.05.02.04.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 04:23:31 -0700 (PDT)
Message-Id: <pull.1498.git.git.1683026610718.gitgitgadget@gmail.com>
From:   "Basile Burg via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 May 2023 11:23:30 +0000
Subject: [PATCH] =?UTF-8?q?l10n:=20about=20box,=20use=20`=C2=A9`=20directl?=
 =?UTF-8?q?y=20instead=20of=20the=20escape?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Basile Burg <basile.b@gmx.com>, Basile Burg <basile.b@gmx.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Basile Burg <basile.b@gmx.com>

the former is not substitued at all

Signed-off-by: Basile Burg <basile.b@gmx.com>
---
    l10n: about box, use © directly instead of the escape
    
    the former is not substitued at all
    
    cp-sym
    [https://user-images.githubusercontent.com/102113538/233641969-52d9849e-4bf7-4cbe-8bff-e0c555b76d2f.png]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1498%2FSixthDot%2Ffix-cp-sym-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1498/SixthDot/fix-cp-sym-v1
Pull-Request: https://github.com/git/git/pull/1498

 gitk-git/po/de.po | 2 +-
 gitk-git/po/es.po | 2 +-
 gitk-git/po/fr.po | 2 +-
 gitk-git/po/hu.po | 2 +-
 gitk-git/po/it.po | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/gitk-git/po/de.po b/gitk-git/po/de.po
index 5db38248289..6d90bcaafb7 100644
--- a/gitk-git/po/de.po
+++ b/gitk-git/po/de.po
@@ -370,7 +370,7 @@ msgstr ""
 "\n"
 "Gitk - eine Visualisierung der Git-Historie\n"
 "\n"
-"Copyright \\u00a9 2005-2016 Paul Mackerras\n"
+"Copyright © 2005-2016 Paul Mackerras\n"
 "\n"
 "Benutzung und Weiterverbreitung gemäß den Bedingungen der GNU General Public "
 "License"
diff --git a/gitk-git/po/es.po b/gitk-git/po/es.po
index fef3bbafeea..4466fee5e9a 100644
--- a/gitk-git/po/es.po
+++ b/gitk-git/po/es.po
@@ -377,7 +377,7 @@ msgstr ""
 "\n"
 "Gitk - un visualizador de revisiones para git\n"
 "\n"
-"Copyright \\u00a9 2005-2016 Paul Mackerras\n"
+"Copyright © 2005-2016 Paul Mackerras\n"
 "\n"
 "Uso y redistribución permitidos según los términos de la Licencia Pública "
 "General de GNU (GNU GPL)"
diff --git a/gitk-git/po/fr.po b/gitk-git/po/fr.po
index e4fac932e5b..41511ccc9de 100644
--- a/gitk-git/po/fr.po
+++ b/gitk-git/po/fr.po
@@ -379,7 +379,7 @@ msgstr ""
 "\n"
 "Gitk - visualisateur de commit pour git\n"
 "\n"
-"Copyright \\u00a9 2005-2016 Paul Mackerras\n"
+"Copyright © 2005-2016 Paul Mackerras\n"
 "\n"
 "Utilisation et redistribution soumises aux termes de la GNU General Public License"
 
diff --git a/gitk-git/po/hu.po b/gitk-git/po/hu.po
index 79ec5a56567..417cb741f2e 100644
--- a/gitk-git/po/hu.po
+++ b/gitk-git/po/hu.po
@@ -373,7 +373,7 @@ msgstr ""
 "\n"
 "Gitk - commit nézegető a githez\n"
 "\n"
-"Szerzői jog \\u00a9 2005-2016 Paul Mackerras\n"
+"Szerzői jog © 2005-2016 Paul Mackerras\n"
 "\n"
 "Használd és terjeszd a GNU General Public License feltételei mellett"
 
diff --git a/gitk-git/po/it.po b/gitk-git/po/it.po
index b58d23eb2b9..e2108c0807d 100644
--- a/gitk-git/po/it.po
+++ b/gitk-git/po/it.po
@@ -374,7 +374,7 @@ msgstr ""
 "\n"
 "Gitk - un visualizzatore di revisioni per git\n"
 "\n"
-"Copyright \\u00a9 2005-2016 Paul Mackerras\n"
+"Copyright © 2005-2016 Paul Mackerras\n"
 "\n"
 "Utilizzo e redistribuzione permessi sotto i termini della GNU General Public "
 "License"

base-commit: 9c6990cca24301ae8f82bf6291049667a0aef14b
-- 
gitgitgadget
