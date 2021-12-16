Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57038C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 18:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbhLPSTM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 13:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbhLPSTK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 13:19:10 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADBBC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 10:19:09 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so2370455wmj.5
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 10:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Bd5zcQ0tB4MoVC7esQscDmBUgSzlvXAu+8/54goUD7s=;
        b=Ux0aKzN3UiX7qu4+gyhgCD8B/9F10dGHag/NvQloC6OC8mqS8C560au+g82H8q36Uo
         VO3Z5izVkQ4PbF6/ZrtyNXbgwkNkHzWm2tXdXxIblifMr3UhI3geMX/gKC+ySXozkz6k
         Kdi6BZILQsCqKAtzhwP5zc/So0S5hHpAlXGPwQyf30z0Xv94t7RvYgEIuDFmYhTgmIF7
         GN1w/8yydjKv5W6CcuhtdWjK57UN92yGsYaA3VvDl7qJioW57rVk3w1yMvo5BfhoYwqD
         5hvcgojOpHUp8YGMxZ2UcekyGeaLko3lF5VINmiUHPCBCXTe6mtCd3la7lkPBEKGBEp5
         9gaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Bd5zcQ0tB4MoVC7esQscDmBUgSzlvXAu+8/54goUD7s=;
        b=v8lJAKHbMDGyGB/Hmg/2/AOMeQ/ohL1BN+GLU9vGXC0gbKctBANJOn2ROBdI2uH7HS
         JQzStaP7ZqbOY0SqG6/H/Y/Y67XlM6XgKLS9Xc41uTPAo/DaGe73fD8kN2/pyeJHxTWu
         uCdQOTMraL08Lrjp3xvTLqHXGTpU+FRv89VQLtqE2RqbjBaHzoo0RNZmCj4LtRPUiFba
         ciVI5zh3byIsPvnbfYGOVk46QxChiBzoVPtmAvf0Vy4IBY6AkYLcQzUIEPyU5teoTLeZ
         0HwzaRZyUmS9hOZ6o2x/f0JOFycMjdcLqeUxdvkVoVxsz5oJ3hD8YuG8svyBYn8tGqrJ
         xvoQ==
X-Gm-Message-State: AOAM5302VLa73sTlu0+0e3F/87308PVoQr1YoE7d6xrKyNzVI0eVc4l+
        SmQYw6FGX8cuHMoYG+YJb8uQXVHuFP0=
X-Google-Smtp-Source: ABdhPJyCWxfjl1r+OnGcEsVdFXwsnZkV9GZ80e4d/k+TQi9N/2QdPYlYxM0xtvmDP74FyuwmCCmULg==
X-Received: by 2002:a1c:1b15:: with SMTP id b21mr6257280wmb.174.1639678748040;
        Thu, 16 Dec 2021 10:19:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c12sm6336775wrr.108.2021.12.16.10.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 10:19:07 -0800 (PST)
Message-Id: <fc913ef31fbd2cc57c915926d04c9ce8cbcec4ef.1639678742.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1166.v3.git.git.1639678734.gitgitgadget@gmail.com>
References: <pull.1166.v2.git.git.1639609138813.gitgitgadget@gmail.com>
        <pull.1166.v3.git.git.1639678734.gitgitgadget@gmail.com>
From:   "Kashav Madan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Dec 2021 18:18:54 +0000
Subject: [PATCH v3 4/4] help: make auto-correction prompt more consistent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Altmanninger <aclopte@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kashav madan <kshvmdn@gmail.com>,
        Kashav Madan <kshvmdn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kashav Madan <kshvmdn@gmail.com>

There are three callsites of git_prompt() that ask the user for "yes/no"
confirmation, but the one in help.c, used for auto-correction, is
formatted differently from the others. Update that format string to make
the prompt look more consistent, by adding a space after the prompt and
enclosing the choices in [] instead of ().

Signed-off-by: Kashav Madan <kshvmdn@gmail.com>
---
 help.c      | 2 +-
 po/bg.po    | 4 ++--
 po/ca.po    | 4 ++--
 po/de.po    | 4 ++--
 po/es.po    | 4 ++--
 po/fr.po    | 4 ++--
 po/git.pot  | 2 +-
 po/id.po    | 2 +-
 po/pl.po    | 4 ++--
 po/sv.po    | 4 ++--
 po/tr.po    | 4 ++--
 po/vi.po    | 4 ++--
 po/zh_CN.po | 4 ++--
 po/zh_TW.po | 4 ++--
 14 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/help.c b/help.c
index 973e47cdc30..2cd08b199c2 100644
--- a/help.c
+++ b/help.c
@@ -643,7 +643,7 @@ const char *help_unknown_cmd(const char *cmd)
 		else if (autocorrect == AUTOCORRECT_PROMPT) {
 			char *answer;
 			struct strbuf msg = STRBUF_INIT;
-			strbuf_addf(&msg, _("Run '%s' instead? (y/N)"), assumed);
+			strbuf_addf(&msg, _("Run '%s' instead? [y/N] "), assumed);
 			answer = git_prompt(msg.buf, PROMPT_ECHO);
 			strbuf_release(&msg);
 			if (!(starts_with(answer, "y") ||
diff --git a/po/bg.po b/po/bg.po
index 5f768a72102..5933ea51b06 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -4800,8 +4800,8 @@ msgstr ""
 
 #: help.c:646
 #, c-format
-msgid "Run '%s' instead? (y/N)"
-msgstr "Да се изпълни „%s“ вместо това? (y/N)"
+msgid "Run '%s' instead? [y/N] "
+msgstr "Да се изпълни „%s“ вместо това? [y/N] "
 
 #: help.c:654
 #, c-format
diff --git a/po/ca.po b/po/ca.po
index 8419c7fe04f..0c1084d8733 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -4665,8 +4665,8 @@ msgstr "El procés continuarà, pressuposant que volíeu dir «%s»."
 
 #: help.c:646
 #, c-format, fuzzy
-msgid "Run '%s' instead? (y/N)"
-msgstr "Voleu executar «%s»? (s/N)"
+msgid "Run '%s' instead? [y/N] "
+msgstr "Voleu executar «%s»? [s/N] "
 
 #: help.c:654
 #, c-format
diff --git a/po/de.po b/po/de.po
index 367cd73c5a4..4afe6f94325 100644
--- a/po/de.po
+++ b/po/de.po
@@ -4620,8 +4620,8 @@ msgstr "Setze fort unter der Annahme, dass Sie '%s' meinten."
 
 #: help.c:646
 #, c-format
-msgid "Run '%s' instead? (y/N)"
-msgstr "Stattdessen '%s' ausführen? (y/N)"
+msgid "Run '%s' instead? [y/N] "
+msgstr "Stattdessen '%s' ausführen? [y/N] "
 
 #: help.c:654
 #, c-format
diff --git a/po/es.po b/po/es.po
index 3877b1351e6..472a633a8f2 100644
--- a/po/es.po
+++ b/po/es.po
@@ -4565,8 +4565,8 @@ msgstr "Continuando asumiendo que quisiste decir '%s'."
 
 #: help.c:646
 #, c-format
-msgid "Run '%s' instead? (y/N)"
-msgstr "Ejecutar '%s' en su lugar? (y/N)"
+msgid "Run '%s' instead? [y/N] "
+msgstr "Ejecutar '%s' en su lugar? [y/N] "
 
 #: help.c:654
 #, c-format
diff --git a/po/fr.po b/po/fr.po
index 11b83570f71..b9c111c096b 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -4698,8 +4698,8 @@ msgstr "Continuons en supposant que vous avez voulu dire '%s'."
 
 #: help.c:646
 #, c-format
-msgid "Run '%s' instead? (y/N)"
-msgstr "Lancer '%s' à la place ? (y/N)"
+msgid "Run '%s' instead? [y/N] "
+msgstr "Lancer '%s' à la place ? [y/N] "
 
 #: help.c:654
 #, c-format
diff --git a/po/git.pot b/po/git.pot
index 0fe5805d8ec..c4ff320187a 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -4246,7 +4246,7 @@ msgstr ""
 
 #: help.c:646
 #, c-format
-msgid "Run '%s' instead? (y/N)"
+msgid "Run '%s' instead? [y/N] "
 msgstr ""
 
 #: help.c:654
diff --git a/po/id.po b/po/id.po
index 3a9f703a106..4ffe1005120 100644
--- a/po/id.po
+++ b/po/id.po
@@ -4415,7 +4415,7 @@ msgstr "Melanjutkan di bawah asumsi bahwa maksud Anda '%s'."
 
 #: help.c:646
 #, c-format
-msgid "Run '%s' instead? (y/N)"
+msgid "Run '%s' instead? [y/N] "
 msgstr ""
 
 #: help.c:654
diff --git a/po/pl.po b/po/pl.po
index f9b6bc59dde..bfbb2be5ca2 100644
--- a/po/pl.po
+++ b/po/pl.po
@@ -4591,8 +4591,8 @@ msgstr "Zakładam dalej, że chodziło o „%s”."
 
 #: help.c:646
 #, c-format
-msgid "Run '%s' instead? (y/N)"
-msgstr "Wykonać zamiast tego „%s”? (y/N)"
+msgid "Run '%s' instead? [y/N] "
+msgstr "Wykonać zamiast tego „%s”? [y/N] "
 
 #: help.c:654
 #, c-format
diff --git a/po/sv.po b/po/sv.po
index 685294c8bac..a43e1072b53 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -4528,8 +4528,8 @@ msgstr "Fortsätter under förutsättningen att du menade \"%s\"."
 
 #: help.c:646
 #, c-format
-msgid "Run '%s' instead? (y/N)"
-msgstr "Köra \"%s\" istället? (j/N)"
+msgid "Run '%s' instead? [y/N] "
+msgstr "Köra \"%s\" istället? [j/N] "
 
 #: help.c:654
 #, c-format
diff --git a/po/tr.po b/po/tr.po
index 4c7cea44183..40d5ec8d703 100644
--- a/po/tr.po
+++ b/po/tr.po
@@ -4597,8 +4597,8 @@ msgstr "'%s' demek istediğiniz varsayılarak sürdürülüyor."
 
 #: help.c:646
 #, c-format
-msgid "Run '%s' instead? (y/N)"
-msgstr "Bunun yerine '%s' çalıştır? (y/N)"
+msgid "Run '%s' instead? [y/N] "
+msgstr "Bunun yerine '%s' çalıştır? [y/N] "
 
 #: help.c:654
 #, c-format
diff --git a/po/vi.po b/po/vi.po
index 0aed6d2d0a4..b8500e04f99 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -4535,8 +4535,8 @@ msgstr "Tiếp tục và coi rằng ý bạn là “%s”."
 
 #: help.c:646
 #, c-format
-msgid "Run '%s' instead? (y/N)"
-msgstr "Chạy “%s” để thay thế? (y/N)"
+msgid "Run '%s' instead? [y/N] "
+msgstr "Chạy “%s” để thay thế? [y/N] "
 
 #: help.c:654
 #, c-format
diff --git a/po/zh_CN.po b/po/zh_CN.po
index e785a8156ae..475c43f0ea2 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -4546,8 +4546,8 @@ msgstr "假定您想要的是 '%s' 并继续。"
 
 #: help.c:646
 #, c-format
-msgid "Run '%s' instead? (y/N)"
-msgstr "取而代之运行 '%s' ？ (y/N)"
+msgid "Run '%s' instead? [y/N] "
+msgstr "取而代之运行 '%s' ？ [y/N] "
 
 #: help.c:654
 #, c-format
diff --git a/po/zh_TW.po b/po/zh_TW.po
index a1fb6b5267a..8727a72e182 100644
--- a/po/zh_TW.po
+++ b/po/zh_TW.po
@@ -4411,8 +4411,8 @@ msgstr "假定你想要的是 '%s' 並繼續。"
 
 #: help.c:646
 #, c-format
-msgid "Run '%s' instead? (y/N)"
-msgstr "改執行「%s」？(y/N)"
+msgid "Run '%s' instead? [y/N] "
+msgstr "改執行「%s」？[y/N] "
 
 #: help.c:654
 #, c-format
-- 
gitgitgadget
