Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A35C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 19:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiKUTT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 14:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiKUTTy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 14:19:54 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6908555A6
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 11:19:51 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l14so2437803wrw.13
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 11:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ec+zWqmpELa2iMv8WozQTjerXJtTJk6sRieqRuaWFVY=;
        b=buc6fJ4x5tHzJMrX0tVa0ierHxARgBQhQPMf5Ak0niDoD+LBoHHC942qjNkN+DD+tO
         GbHg2CPc+0m4CGmDXqim6FFTI0l/ulLcuJmulRsSmoZtID/Np86Hl5xISO7vMrTib/b6
         E6CAjWcGTIqZc3oy1rh8z4y71X8JLueQeM6vIRO9gOfhXQCiDBYvVdB7P7T3DAwp6R4y
         ndrEgMEaJDx5yHkgFaoeOctAFfBV+0W28wT/naDW/uD70CQ/Lx7jhd8Kls5Gyy2vZz3G
         xv4k7pVWkEBJC4UMxdLyQhEmG9TrJdFCPhZzFy7k3qjSCGgmcNiDfgbISiDocm/1L+w3
         mG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ec+zWqmpELa2iMv8WozQTjerXJtTJk6sRieqRuaWFVY=;
        b=2tN5iap+tf+LvFWlU3/jJfCmoeHNlbNbbwnXXfldfB1EiJAH8VBkrLQPgdAPyv6k9d
         tqfosjinOCwl8Bt3X4KX4RnU4X02yvos3if7c0yDbbWfSaioOnpMEkObQXdNq03NnRfJ
         fJWQz4PA02woN7eL8Bizu5T1//3oS/DlUi4sfJgBg9yvfkqudktvnyNxtuh0ZFewoaQl
         +I80WrGqBw+OlvogJgJCbFiXpmQwpFHDjy+2qOkM6d2YN45PUrzHCv/yxKS4Bqm6+AJ0
         Uj9JXfpTi5s9+f9Z9xEPJbI2yi4au7jDAR2dzTmceJ2lF9FFsIBx59gNBoiI7sC6/NW2
         3CMA==
X-Gm-Message-State: ANoB5pkhELlGzg3M3oXFUe8yOS5s7GzLXFw3/dNw7/Dh/ZKnpKRcTVnh
        v6pZlq1QRDFBMxMtSvgfJ/JNTtVLh0I=
X-Google-Smtp-Source: AA0mqf4PekO8W4uw+x2ZSc4oWg+ooIs1aQaQx9C46NAWWX1FBupclza65kvPiU3pklhSEUwIPdl38g==
X-Received: by 2002:a5d:4612:0:b0:22c:95bc:c70e with SMTP id t18-20020a5d4612000000b0022c95bcc70emr11676902wrq.248.1669058389638;
        Mon, 21 Nov 2022 11:19:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b003b95ed78275sm15670828wmn.20.2022.11.21.11.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 11:19:49 -0800 (PST)
Message-Id: <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com>
In-Reply-To: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Nov 2022 19:19:48 +0000
Subject: [PATCH v2] config: introduce an Operating System-specific `includeIf`
 condition
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is relatively common for users to maintain identical `~/.gitconfig`
files across all of their setups, using the `includeIf` construct
liberally to adjust the settings to the respective setup as needed.

In case of Operating System-specific adjustments, Git currently offers
no support to the users and they typically use a work-around like this:

	[includeIf "gitdir:/home/"]
		path = ~/.gitconfig-linux
	[includeIf "gitdir:/Users/"]
		path = ~/.gitconfig-mac
	[includeIf "gitdir:C:"]
		path = ~/.gitconfig-windows

However, this is fragile, as it would not even allow to discern between
Operating Systems that happen to host their home directories in
`/home/`, such as Linux and the BSDs.

Let's introduce a new condition: `os:<uname-s>` where `<uname-s>` is the
system name, i.e. the output of `uname -s`.

This addresses https://github.com/git-for-windows/git/issues/4125

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    config: introduce an Operating System-specific includeIf condition
    
    I was about to write up guidelines how to write this patch, but it
    turned out that it was much faster to write the patch instead.
    
    Changes since v1:
    
     * The documentation now avoids mentioning uname -s and clarifies what
       it means by offering examples.
     * Replaced a double space in the test case with a single one.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1429%2Fdscho%2Finclude-if-os-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1429/dscho/include-if-os-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1429

Range-diff vs v1:

 1:  a7eb4a9d438 ! 1:  45231533883 config: introduce an Operating System-specific `includeIf` condition
     @@ Documentation/config.txt: As for the naming of this keyword, it is for forwards
       
      +`os`::
      +	The data that follows this keyword is taken as the name of an
     -+	Operating System; If it matches the output of `uname -s`, the
     -+	include condition is met.
     ++	Operating System, e.g. `Linux` or `Windows`; If it matches the
     ++	current Operating System, the include condition is met.
      +
       A few more notes on matching via `gitdir` and `gitdir/i`:
       
     @@ t/t1309-early-config.sh: test_expect_success 'onbranch config outside of git rep
      +		uname_s="$(uname -s)"
      +	fi &&
      +	test_config "includeIf.os:not-$uname_s.path" xyz &&
     -+	test 0 = "$(git  config x.y)" &&
     ++	test 0 = "$(git config x.y)" &&
      +	test_config "includeIf.os:$uname_s.path" xyz &&
      +	test z = "$(git config x.y)"
      +'


 Documentation/config.txt |  5 +++++
 config.c                 | 11 +++++++++++
 t/t1309-early-config.sh  | 16 ++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e376d547ce0..b90bcd8ecfe 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -186,6 +186,11 @@ As for the naming of this keyword, it is for forwards compatibiliy with
 a naming scheme that supports more variable-based include conditions,
 but currently Git only supports the exact keyword described above.
 
+`os`::
+	The data that follows this keyword is taken as the name of an
+	Operating System, e.g. `Linux` or `Windows`; If it matches the
+	current Operating System, the include condition is met.
+
 A few more notes on matching via `gitdir` and `gitdir/i`:
 
  * Symlinks in `$GIT_DIR` are not resolved before matching.
diff --git a/config.c b/config.c
index 9b0e9c93285..9ab311ae99b 100644
--- a/config.c
+++ b/config.c
@@ -394,6 +394,15 @@ static int include_by_remote_url(struct config_include_data *inc,
 					     inc->remote_urls);
 }
 
+static int include_by_os(const char *cond, size_t cond_len)
+{
+	struct utsname uname_info;
+
+	return !uname(&uname_info) &&
+		!strncasecmp(uname_info.sysname, cond, cond_len) &&
+		!uname_info.sysname[cond_len];
+}
+
 static int include_condition_is_true(struct config_include_data *inc,
 				     const char *cond, size_t cond_len)
 {
@@ -408,6 +417,8 @@ static int include_condition_is_true(struct config_include_data *inc,
 	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
 				   &cond_len))
 		return include_by_remote_url(inc, cond, cond_len);
+	else if (skip_prefix_mem(cond, cond_len, "os:", &cond, &cond_len))
+		return include_by_os(cond, cond_len);
 
 	/* unknown conditionals are always false */
 	return 0;
diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index 537435b90ae..b36afe1a528 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -100,4 +100,20 @@ test_expect_success 'onbranch config outside of git repo' '
 	nongit git help
 '
 
+test_expect_success '[includeIf "os:..."]' '
+	test_config x.y 0 &&
+	echo "[x] y = z" >.git/xyz &&
+
+	if test_have_prereq MINGW
+	then
+		uname_s=Windows
+	else
+		uname_s="$(uname -s)"
+	fi &&
+	test_config "includeIf.os:not-$uname_s.path" xyz &&
+	test 0 = "$(git config x.y)" &&
+	test_config "includeIf.os:$uname_s.path" xyz &&
+	test z = "$(git config x.y)"
+'
+
 test_done

base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
-- 
gitgitgadget
