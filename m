Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B70C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240291AbiF0ShD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbiF0Sg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:36:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19E218B1A
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s1so14247123wra.9
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9Y31p35ezdfjp7sTmTKzK5uLAuyh+W/Q9177MXY5dsc=;
        b=TpsX6emPUzA0zeti/w/EIMkytGuFZAxS0wY+Oi3ZUgaUVf71pQVCCbWosvjzO5f0je
         d8ycZ02wqTlR9bXqXx/7+L3ec35K2g3nh5jlofVpU3GGhT4Y7jh2oUvMAnsBmGMHWgOx
         AvOm/C9HP2+GZSk9VMWtnL9oCI4LDqEwNZjacj40GeTRW2Y4zmUbWp/XJG2OrRGECSRr
         K7mL+2lAQ8MMS+vR2f7sOKsxHs/wfx6K+Ck9pNki5q4ayoc1wuN7BK5M8atRSEGQIBG+
         Xn+6BgK98vBk4gQcOzQtelAm/PYf9cIMmw9tgXxN63fcU5i5wbcxWeg/FI2zYOSAZOl2
         xVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9Y31p35ezdfjp7sTmTKzK5uLAuyh+W/Q9177MXY5dsc=;
        b=ms7bajY8DNR4n9kwMmc/fG7T9IyAwSHZBkbhD95jeoxzNS7P4RWe0OTcPNleVpOnyU
         pp9XkwXIpOw+EgKJwpV9D2iYJ5vME37+ZByCqjUGvPjUSpthn2w5BXhwI3IjUp+H8Fzn
         SijFuvhzAI+ILIOByocXPYT02i/wUiXFzTf/ymZ1WJSNTJWhls2lRpc8du7ir0Ymwst4
         q8IKtaRQrSzmXmN/6uutC7kX9DXLBH3mn5XM4s8KJ/kdTL24klU7qReugWlAd0V7MM9j
         /hkC7TdqLsPDd+WfZT6KrdCXreLpVUBJePI/sUHYHg/cjiv05hHf4bd+YTT+S41V2jT2
         TOnQ==
X-Gm-Message-State: AJIora+2rOrrorkHl7ppdT2vd8ECpfE2GQ4ICrlUbmB/XPG5OxCiQfNN
        ChgxhnZ/R+JpZHpIPeLucHCu9IfXjmC3Vw==
X-Google-Smtp-Source: AGRyM1uh/fBOo1nWSdYal95fV8VAj2KoJtenRHk2XomThGEnSQvahtCKOSFZdelpP2FWi1M319nB2A==
X-Received: by 2002:a05:6000:901:b0:21a:a576:23cc with SMTP id bz1-20020a056000090100b0021aa57623ccmr13424168wrb.489.1656354692031;
        Mon, 27 Jun 2022 11:31:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2-20020adfea82000000b0021b90d7b2c9sm11188563wrm.24.2022.06.27.11.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:31:30 -0700 (PDT)
Message-Id: <87f53469a721cefe1dbfb9f1b7906f189ddf3632.1656354677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
        <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:31:11 +0000
Subject: [PATCH v4 10/16] bisect--helper: move the `BISECT_STATE` case to the
 end
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In preparation for replacing the command-mode parsing in
`bisect--helper` with an if/else if/else chain, let's move the one
command that will be implicit (i.e. what will become the final `else`
without any `if`) to the end.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1b1ce0941ff..22099b9ebe2 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1325,16 +1325,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_start(&terms, argv, argc);
 		break;
-	case BISECT_STATE:
-		set_terms(&terms, "bad", "good");
-		get_terms(&terms);
-		if (!cmdmode &&
-		    (!argc || check_and_set_terms(&terms, argv[0]))) {
-			char *msg = xstrfmt(_("unknown command: '%s'"), argv[0]);
-			usage_msg_opt(msg, git_bisect_helper_usage, options);
-		}
-		res = bisect_state(&terms, argv, argc);
-		break;
 	case BISECT_TERMS:
 		if (argc > 1)
 			return error(_("--bisect-terms requires 0 or 1 argument"));
@@ -1377,6 +1367,16 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_run(&terms, argv, argc);
 		break;
+	case BISECT_STATE:
+		set_terms(&terms, "bad", "good");
+		get_terms(&terms);
+		if (!cmdmode &&
+		    (!argc || check_and_set_terms(&terms, argv[0]))) {
+			char *msg = xstrfmt(_("unknown command: '%s'"), argv[0]);
+			usage_msg_opt(msg, git_bisect_helper_usage, options);
+		}
+		res = bisect_state(&terms, argv, argc);
+		break;
 	default:
 		BUG("unknown subcommand %d", cmdmode);
 	}
-- 
gitgitgadget

