Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D47C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 18:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbhLPSTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 13:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240597AbhLPSTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 13:19:09 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA895C06173F
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 10:19:08 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u17so45769886wrt.3
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 10:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0vya9O40knFzZOacAZBIpormBNWO8oEVHVQ+Zul+k4w=;
        b=ltG0NgBhdYd4FUBnaPZsR0Szi+T1sYz7SCvt1wF5e+BATCWN08JqeEVUJ+QTKFD4cW
         fIRXYYTdLo3VW4DM+mr1eITqp1fCOvCukpvAwmcppVn+iCz4UkFipJn6AvoibZ4IGnqX
         P75Cj7trBDuo7z4ya4NAUKz3/ypupzyfZh3i3NmJUdsL2RG7YTFYzJ7hUZN2EhLfL7rI
         I+xCtihDiJ+cPHGI8aJRKe4Vx4+RieZJSDe4wMLZ/Y/jTg5ZRcLcuE3yjck0cVmoBN05
         IgiJUleTDLiUySeh3H07Sma4FhbByA0A22JHoyJM73nU5PbKSrrlfvmJDBDYgqUdb7Q6
         y3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0vya9O40knFzZOacAZBIpormBNWO8oEVHVQ+Zul+k4w=;
        b=NMK57gapPfgksr6MypnMOHEeZPooIl7yvcenBJK4E7YPT2qUUpEMEqTJAct1eZ/5px
         /T6cwcnOXwP96uhTy5fjFEvehXymvQxIQiO28bqWkbjkzo2jdhcgWWM2G8e3k8xC/9bd
         xUnirpujnP6Ew5wXfQgMH0plXzFk1bJyYFdeK0ceUPagXoncvzpeDeUOisxCRgDC7yLE
         mW//AkrzYz+vz+reyei3VPiDdB8/RbcqOjl58Iu8EPmm43OlaqZlsfDZBQ/ALhl/gcME
         7AXygkBPcfTBb9Z4HDfc2tD2rYdFF/XeLuDAkfu+l22zm9Hjk/Cq4lCI7+AUwCdTx7dB
         TWQA==
X-Gm-Message-State: AOAM531pqi5DcQnTir1s7gkPJLwVZSwbUiXEWHoonD+Xt5QI1d2qK+b3
        FHdFwOHW9NuFxykMhAafC1UdeC0AaL0=
X-Google-Smtp-Source: ABdhPJzFCULOrb7/poGaw/57QpA+iIyQK8ZOwYgWnFICJLQiobyG3WF5LqB2kQFdx/TvmFpr2DmdHg==
X-Received: by 2002:a5d:58f2:: with SMTP id f18mr8292475wrd.98.1639678747064;
        Thu, 16 Dec 2021 10:19:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9sm3039565wrb.84.2021.12.16.10.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 10:19:06 -0800 (PST)
Message-Id: <4a70e569f8a292ef37d8e928f279d0b999b3982d.1639678739.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1166.v3.git.git.1639678734.gitgitgadget@gmail.com>
References: <pull.1166.v2.git.git.1639609138813.gitgitgadget@gmail.com>
        <pull.1166.v3.git.git.1639678734.gitgitgadget@gmail.com>
From:   "Kashav Madan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Dec 2021 18:18:53 +0000
Subject: [PATCH v3 3/4] add-patch: normalize format string of yes/no prompt
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

Move the question mark in the prompt before the choices to be more
consistent with other similar prompts.

Signed-off-by: Kashav Madan <kshvmdn@gmail.com>
---
 add-patch.c | 4 ++--
 po/bg.po    | 2 +-
 po/ca.po    | 4 ++--
 po/de.po    | 4 ++--
 po/el.po    | 4 ++--
 po/es.po    | 6 +++---
 po/fr.po    | 4 ++--
 po/git.pot  | 2 +-
 po/id.po    | 4 ++--
 po/it.po    | 4 ++--
 po/ko.po    | 4 ++--
 po/pl.po    | 4 ++--
 po/pt_PT.po | 4 ++--
 po/ru.po    | 4 ++--
 po/sv.po    | 6 +++---
 po/tr.po    | 4 ++--
 po/vi.po    | 4 ++--
 po/zh_CN.po | 4 ++--
 po/zh_TW.po | 4 ++--
 19 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 8c41cdfe39b..9ff2d4f1749 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1245,8 +1245,8 @@ static int edit_hunk_loop(struct add_p_state *s,
 		 * of the word "no" does not start with n.
 		 */
 		res = prompt_yesno(s, _("Your edited hunk does not apply. "
-					"Edit again (saying \"no\" discards!) "
-					"[y/n]? "));
+					"Edit again (saying \"no\" discards!)? "
+					"[y/n] "));
 		if (res < 1)
 			return -1;
 	}
diff --git a/po/bg.po b/po/bg.po
index 10ba01d2817..5f768a72102 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -826,7 +826,7 @@ msgstr "неуспешно изпълнение на „git apply --cached“"
 #. of the word "no" does not start with n.
 #: add-patch.c:1247 git-add--interactive.perl:1242
 msgid ""
-"Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? "
+"Your edited hunk does not apply. Edit again (saying \"no\" discards!)? [y/n] "
 msgstr ""
 "Редактираното парче не може да се приложи.  Да се продължи ли с "
 "редактирането? (текущите редакции ще се отменят при отказ!): „y“ (да)/ "
diff --git a/po/ca.po b/po/ca.po
index d9798fd530e..8419c7fe04f 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -689,11 +689,11 @@ msgstr "«git apply --cached» ha fallat"
 #. of the word "no" does not start with n.
 #: add-patch.c:1247 git-add--interactive.perl:1242
 msgid ""
-"Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]?"
+"Your edited hunk does not apply. Edit again (saying \"no\" discards!)? [y/n]"
 " "
 msgstr ""
 "El tros editat no s'aplica. Editeu-lo de nou (si responeu «no» es "
-"descartarà) [y/n]? "
+"descartarà)? [y/n] "
 
 #: add-patch.c:1290
 msgid "The selected hunks do not apply to the index!"
diff --git a/po/de.po b/po/de.po
index 442627f3448..367cd73c5a4 100644
--- a/po/de.po
+++ b/po/de.po
@@ -654,10 +654,10 @@ msgstr "'git apply --cached' schlug fehl."
 #. of the word "no" does not start with n.
 #: add-patch.c:1247 git-add--interactive.perl:1242
 msgid ""
-"Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? "
+"Your edited hunk does not apply. Edit again (saying \"no\" discards!)? [y/n] "
 msgstr ""
 "Ihr bearbeiteter Patch-Block kann nicht angewendet werden.\n"
-"Erneut bearbeiten? (\"n\" verwirft Bearbeitung!) [y/n]?"
+"Erneut bearbeiten? (\"n\" verwirft Bearbeitung!)? [y/n] "
 
 #: add-patch.c:1290
 msgid "The selected hunks do not apply to the index!"
diff --git a/po/el.po b/po/el.po
index b826b73d460..f5a7936b4a6 100644
--- a/po/el.po
+++ b/po/el.po
@@ -20795,10 +20795,10 @@ msgstr ""
 #. of the word "no" does not start with n.
 #: git-add--interactive.perl:1213
 msgid ""
-"Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? "
+"Your edited hunk does not apply. Edit again (saying \"no\" discards!)? [y/n] "
 msgstr ""
 "Η επεξεργασμένη αλλαγή σας δεν εφαρμόζεται. Να γίνει επεξεργασία πάλι (με \"n"
-"\" απορρίπτεται!) [y/n];"
+"\" απορρίπτεται!); [y/n] "
 
 #: git-add--interactive.perl:1222
 msgid ""
diff --git a/po/es.po b/po/es.po
index 8e9143131d0..3877b1351e6 100644
--- a/po/es.po
+++ b/po/es.po
@@ -644,10 +644,10 @@ msgstr "falló 'git apply --cached'"
 #. of the word "no" does not start with n.
 #: add-patch.c:1247 git-add--interactive.perl:1242
 msgid ""
-"Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? "
+"Your edited hunk does not apply. Edit again (saying \"no\" discards!)? [y/n] "
 msgstr ""
-"Tu hunk editado no aplica. ¿Editar nuevamente (¡decir \"no\" descarta!) [y/"
-"n]? "
+"Tu hunk editado no aplica. ¿Editar nuevamente (¡decir \"no\" descarta!)? [y/"
+"n] "
 
 #: add-patch.c:1290
 msgid "The selected hunks do not apply to the index!"
diff --git a/po/fr.po b/po/fr.po
index ebb5b73ce3b..11b83570f71 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -714,10 +714,10 @@ msgstr "'git apply --cached' a échoué"
 #. of the word "no" does not start with n.
 #: add-patch.c:1247 git-add--interactive.perl:1242
 msgid ""
-"Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? "
+"Your edited hunk does not apply. Edit again (saying \"no\" discards!)? [y/n] "
 msgstr ""
 "Votre section éditée ne s'applique pas. L'éditer à nouveau (\"no\" "
-"l'élimine !) [y|n] ? "
+"l'élimine !) ? [y|n] "
 
 #: add-patch.c:1290
 msgid "The selected hunks do not apply to the index!"
diff --git a/po/git.pot b/po/git.pot
index 4ef2f39b950..0fe5805d8ec 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -567,7 +567,7 @@ msgstr ""
 #. of the word "no" does not start with n.
 #: add-patch.c:1247 git-add--interactive.perl:1242
 msgid ""
-"Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? "
+"Your edited hunk does not apply. Edit again (saying \"no\" discards!)? [y/n] "
 msgstr ""
 
 #: add-patch.c:1290
diff --git a/po/id.po b/po/id.po
index b41e290c94a..3a9f703a106 100644
--- a/po/id.po
+++ b/po/id.po
@@ -631,10 +631,10 @@ msgstr "'git apply --cached' gagal"
 #. of the word "no" does not start with n.
 #: add-patch.c:1247 git-add--interactive.perl:1242
 msgid ""
-"Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? "
+"Your edited hunk does not apply. Edit again (saying \"no\" discards!)? [y/n] "
 msgstr ""
 "Bingkah Anda tak diterapkan. Sunting lagi (bilang \"n\" untuk \"tidak\" "
-"buang!) [y/n]?"
+"buang!)? [y/n] "
 
 #: add-patch.c:1290
 msgid "The selected hunks do not apply to the index!"
diff --git a/po/it.po b/po/it.po
index b4322699060..c077320c697 100644
--- a/po/it.po
+++ b/po/it.po
@@ -660,10 +660,10 @@ msgstr "'git apply --cached' non riuscito"
 #. of the word "no" does not start with n.
 #: add-patch.c:1241 git-add--interactive.perl:1244
 msgid ""
-"Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? "
+"Your edited hunk does not apply. Edit again (saying \"no\" discards!)? [y/n] "
 msgstr ""
 "L'hunk modificato non può essere applicato senza problemi. Modificarlo di "
-"nuovo (se rispondi \"no\", sarà eliminato!) [y/n]? "
+"nuovo (se rispondi \"no\", sarà eliminato!)? [y/n] "
 
 #: add-patch.c:1284
 msgid "The selected hunks do not apply to the index!"
diff --git a/po/ko.po b/po/ko.po
index 29c7a6896fd..1ae95afe670 100644
--- a/po/ko.po
+++ b/po/ko.po
@@ -17274,10 +17274,10 @@ msgstr "부분 편집 파일을 읽기용으로 여는데 실패: '%s'"
 #. of the word "no" does not start with n.
 #: git-add--interactive.perl:1213
 msgid ""
-"Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? "
+"Your edited hunk does not apply. Edit again (saying \"no\" discards!)? [y/n] "
 msgstr ""
 "편집한 부분이 적용되지 않습니다. 다시 편집하시겠습니까 (\"no\"라고 하면 버립"
-"니다!) [y/n]? "
+"니다!)? [y/n] "
 
 #: git-add--interactive.perl:1222
 msgid ""
diff --git a/po/pl.po b/po/pl.po
index 4d79160a15b..f9b6bc59dde 100644
--- a/po/pl.po
+++ b/po/pl.po
@@ -689,10 +689,10 @@ msgstr "„git apply --cached” nie powiodło się"
 #. of the word "no" does not start with n.
 #: add-patch.c:1247 git-add--interactive.perl:1242
 msgid ""
-"Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? "
+"Your edited hunk does not apply. Edit again (saying \"no\" discards!)? [y/n] "
 msgstr ""
 "Zmieniony skrawek się nie stosuje.  Edytować ponownie (odpowiedź „nie” go "
-"porzuci!) [y/n]? "
+"porzuci!)? [y/n] "
 
 #: add-patch.c:1290
 msgid "The selected hunks do not apply to the index!"
diff --git a/po/pt_PT.po b/po/pt_PT.po
index 06da638e981..8cabcf9729c 100644
--- a/po/pt_PT.po
+++ b/po/pt_PT.po
@@ -844,10 +844,10 @@ msgstr "'git apply --cached' falhou"
 #. of the word "no" does not start with n.
 #: add-patch.c:1247 git-add--interactive.perl:1242
 msgid ""
-"Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? "
+"Your edited hunk does not apply. Edit again (saying \"no\" discards!)? [y/n] "
 msgstr ""
 "Problema na submissão de pedaço editado. Editar de novo (responder \"n\" "
-"para \"não\" descarta!) [y/n]? "
+"para \"não\" descarta!)? [y/n] "
 
 #: add-patch.c:1290
 msgid "The selected hunks do not apply to the index!"
diff --git a/po/ru.po b/po/ru.po
index cc886655cfd..d8bc1acd810 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -577,9 +577,9 @@ msgstr ""
 #. of the word "no" does not start with n.
 #: add-patch.c:1246 git-add--interactive.perl:1242
 msgid ""
-"Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]?"
+"Your edited hunk does not apply. Edit again (saying \"no\" discards!)? [y/n]"
 " "
-msgstr "Изменённый вами блок не применяется. Редактировать снова (ответ «y» означает «нет»!) [y/n]? "
+msgstr "Изменённый вами блок не применяется. Редактировать снова (ответ «y» означает «нет»!)? [y/n] "
 
 #: add-patch.c:1289
 msgid "The selected hunks do not apply to the index!"
diff --git a/po/sv.po b/po/sv.po
index ea9fe33cf9e..685294c8bac 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -632,10 +632,10 @@ msgstr "\"git apply --cached\" misslyckades"
 #. of the word "no" does not start with n.
 #: add-patch.c:1247 git-add--interactive.perl:1242
 msgid ""
-"Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? "
+"Your edited hunk does not apply. Edit again (saying \"no\" discards!)? [y/n] "
 msgstr ""
-"Ditt redigerade stycke kan inte appliceras. Redigera igen (\"nej\" kastar!) "
-"[y/n]? "
+"Ditt redigerade stycke kan inte appliceras. Redigera igen (\"nej\" kastar!)? "
+"[y/n] "
 
 #: add-patch.c:1290
 msgid "The selected hunks do not apply to the index!"
diff --git a/po/tr.po b/po/tr.po
index 46a1ae5a8d2..4c7cea44183 100644
--- a/po/tr.po
+++ b/po/tr.po
@@ -716,10 +716,10 @@ msgstr "'git apply --cached' başarısız oldu"
 #. of the word "no" does not start with n.
 #: add-patch.c:1247 git-add--interactive.perl:1242
 msgid ""
-"Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? "
+"Your edited hunk does not apply. Edit again (saying \"no\" discards!)? [y/n] "
 msgstr ""
 "Düzenlediğiniz parça uygulanamıyor. Yeniden düzenlensin mi (\"n (hayır)\" "
-"ıskartaya çıkarır!) [y/n]? "
+"ıskartaya çıkarır!)? [y/n] "
 
 #: add-patch.c:1290
 msgid "The selected hunks do not apply to the index!"
diff --git a/po/vi.po b/po/vi.po
index d9c0130af2b..0aed6d2d0a4 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -641,10 +641,10 @@ msgstr "“git apply --cached” gặp lỗi"
 #. of the word "no" does not start with n.
 #: add-patch.c:1247 git-add--interactive.perl:1242
 msgid ""
-"Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? "
+"Your edited hunk does not apply. Edit again (saying \"no\" discards!)? [y/n] "
 msgstr ""
 "Hunk đã sửa của bạn không được áp dụng. Sửa lại lần nữa (nói \"n\" để loại "
-"bỏ!) [y/n]? "
+"bỏ!)? [y/n] "
 
 #: add-patch.c:1290
 msgid "The selected hunks do not apply to the index!"
diff --git a/po/zh_CN.po b/po/zh_CN.po
index a51c81bfc4a..e785a8156ae 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -754,8 +754,8 @@ msgstr "'git apply --cached' 失败"
 #. of the word "no" does not start with n.
 #: add-patch.c:1247 git-add--interactive.perl:1242
 msgid ""
-"Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? "
-msgstr "您的编辑块不能被应用。重新编辑（选择 \"no\" 丢弃！） [y/n]? "
+"Your edited hunk does not apply. Edit again (saying \"no\" discards!)? [y/n] "
+msgstr "您的编辑块不能被应用。重新编辑（选择 \"no\" 丢弃！）? [y/n] "
 
 #: add-patch.c:1290
 msgid "The selected hunks do not apply to the index!"
diff --git a/po/zh_TW.po b/po/zh_TW.po
index c5b5f756f33..a1fb6b5267a 100644
--- a/po/zh_TW.po
+++ b/po/zh_TW.po
@@ -637,8 +637,8 @@ msgstr "「git apply --cached」失敗"
 #. of the word "no" does not start with n.
 #: add-patch.c:1247 git-add--interactive.perl:1242
 msgid ""
-"Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? "
-msgstr "未套用編輯區塊。是否重新編輯（輸入 “no” 捨棄！） [y/n]? "
+"Your edited hunk does not apply. Edit again (saying \"no\" discards!)? [y/n] "
+msgstr "未套用編輯區塊。是否重新編輯（輸入 “no” 捨棄！）? [y/n] "
 
 #: add-patch.c:1290
 msgid "The selected hunks do not apply to the index!"
-- 
gitgitgadget

