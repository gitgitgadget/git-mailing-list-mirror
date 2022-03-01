Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B4AC4332F
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbiCASpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237132AbiCASo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:57 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40C366620
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:44:01 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p4so8030482wmg.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=brC2wcOdkQh4a308InYtzfFjo3H8sjFwU5wYnZr4Ujk=;
        b=nF3Hmb/PbITKhBASpLZGWbL6ddOFJ44o26Z/yVkSkcHI95nY4oeM8Wg/8K7A17fR16
         g0pb3k14XLNGowLzK4cKpziqWw6iss1GjOtbDcIb5wmShiqbdFDh3KW33xslzDBmc0yY
         LMOk4ebkwnmm3aguCQOnIElXuBa7F1A9yaydZTTD+e2SbtdSC0io4bXoA4AhQIvpIz7s
         tjFvZ9n/LZsusHNoWQxQteE20LsNwvn1r3FThZk5cfmacA3CcFBngqC9Vmh02trvqwCC
         OHT3NcTk7qhR+GtKFioG1X/A2hsYFCsjiOH2lRO8K/thqhxfoIIBStumrCxAOuONWhVO
         +5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=brC2wcOdkQh4a308InYtzfFjo3H8sjFwU5wYnZr4Ujk=;
        b=i8QteqTjzrJIqD3avS1lSL7dsXorOsW93BBWNdIBbtfMu1P+V6VnDGNwPeCrYqpfFX
         7XVis5Z9g3NqODowDJDPBtLmwqIyAH7/uV+CbguF1dXc7+0hURsyub7jd8xaH335GUVc
         v82eibpIGgkDFg53KS9SqpEuOrrAhwE72MedgOUh5B0PUd854wEcZL6BX0MPDGw7cW5x
         pOh/6DXOck67RabENLKR44tC8O9b7W8X/7LDH2NGOdjzTQN9bLjoD6pGVvnApmgMqD+i
         sBheOTLrKezAJWIKnNdF5KOPnaBbprPzvTwNFv8+3lZw2D16jFFyTAQzSXN5ekPJuleY
         kTEw==
X-Gm-Message-State: AOAM53059LegZpbVR90KqObOKfvaaVY4VJlTiXlVtQrTpJQGZZQQ0Kd6
        BXe+3MUWZTQgOLr/ZTTBQuIzmEl+6pg=
X-Google-Smtp-Source: ABdhPJxNG/OVfA30nQ9qGzh1Ebk1zTUY2HuNoJXMnttTn7HPPNacNNYWeR9u+uStYRXRC0vJeJdzAg==
X-Received: by 2002:a05:600c:42d6:b0:380:ed47:43e8 with SMTP id j22-20020a05600c42d600b00380ed4743e8mr17969261wme.61.1646160240303;
        Tue, 01 Mar 2022 10:44:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c230600b0038115c73362sm3257353wmo.12.2022.03.01.10.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:59 -0800 (PST)
Message-Id: <b915b95cc2f82728e3f5f7135f041a709a74ce5d.1646160213.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:32 +0000
Subject: [PATCH v6 30/30] update-index: convert fsmonitor warnings to advise
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/update-index.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 876112abb21..d335f1ac72a 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1238,18 +1238,18 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	if (fsmonitor > 0) {
 		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
 		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
-			warning(_("core.fsmonitor is unset; "
-				"set it if you really want to "
-				"enable fsmonitor"));
+			advise(_("core.fsmonitor is unset; "
+				 "set it if you really want to "
+				 "enable fsmonitor"));
 		}
 		add_fsmonitor(&the_index);
 		report(_("fsmonitor enabled"));
 	} else if (!fsmonitor) {
 		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
 		if (fsm_mode > FSMONITOR_MODE_DISABLED)
-			warning(_("core.fsmonitor is set; "
-				"remove it if you really want to "
-				"disable fsmonitor"));
+			advise(_("core.fsmonitor is set; "
+				 "remove it if you really want to "
+				 "disable fsmonitor"));
 		remove_fsmonitor(&the_index);
 		report(_("fsmonitor disabled"));
 	}
-- 
gitgitgadget
