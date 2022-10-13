Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED27AC433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 17:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiJMRnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 13:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMRnx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 13:43:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659CCFA03F
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 10:43:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f11so3960850wrm.6
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 10:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yx2VL1pQAWdAYF6OjyqJDNRMgrcdxQ+NRs863lSh80A=;
        b=IcJJdOifxvWBhhtl1V1Sv3ng7W8rZNh9TEg8QWe7o98ye5pA/3Gr4JFXxxcWLCVnMh
         IuAedsl2WYSsSr4mq1316BNS+RzojFG+iV3ymZkyiXo9drdqqHXsA/fYZrCxvdjPcSJx
         A9IB0iFSHSV4IXKAZu5uqqhYOnmNTDIGM885k461ID4Bpf/O5qBzt7Ite5XIFPbypn0d
         xRFmOje4XICpHz289JIdrYwnskZaoPhMHZVVUmn3mDymzXfoc6nBpqjfq7EfqL+QKEyi
         0s8fOwxxbGsEj2LhQBBL2ocEyNSw0nKE9YhANp4WBIbDajRA2nj9vvvHNVKBSCyLH2rR
         niMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yx2VL1pQAWdAYF6OjyqJDNRMgrcdxQ+NRs863lSh80A=;
        b=lvwVBRxfE8/1iRONZ3DoRxDjQT/MJU3ZTUNmRFEUUi5ac4tgUMh3ohj7jcJv9RERRi
         gqUy+Nh7iZJt9/EKSHbueHoxThhSweSTfdu6owu1pR9blZKTqWdP1bR3ilv+TI4qiiC+
         U1rz7WlomFfNXuWm0SJ7g/BZ6BrsOiCFXo+2IjwpCQhIrzJd7Ps3Om115TVpknBZIvT0
         axN6Qv2WgjdZkUs21kmmk01608Q0lopRVP7sbBTEqGJu94ZGLhVnkE3iKwloyYqaf2fU
         5Ia0L+KPZv2QHekB5SfI52QoOYC9P4y8c90pJ8tZHesk1OpSfbJ5U0K98g8kJMQZLUBO
         rN0w==
X-Gm-Message-State: ACrzQf0lsL/Z0FFfvLBaMBuEJefh6CWgye9kE/P6c/ICrlDftN8kiPyO
        uRk4GBNAufEnMg1a3yo4KmmUZ2krnpc=
X-Google-Smtp-Source: AMsMyM75WUmQ0N2zn/iSCusyGUzRlv3/gc0AT7lZ+zQDKQoxNT9kMPLuDXOdAwtNSJgTTTFXDPVknw==
X-Received: by 2002:adf:ec03:0:b0:22e:4d3:bb37 with SMTP id x3-20020adfec03000000b0022e04d3bb37mr726884wrn.665.1665683029640;
        Thu, 13 Oct 2022 10:43:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c47c900b003c3a1d8c8e6sm113591wmo.19.2022.10.13.10.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 10:43:49 -0700 (PDT)
Message-Id: <pull.1360.v2.git.git.1665683027912.gitgitgadget@gmail.com>
In-Reply-To: <pull.1360.git.git.1665603814.gitgitgadget@gmail.com>
References: <pull.1360.git.git.1665603814.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Oct 2022 17:43:47 +0000
Subject: [PATCH v2] config: respect includes in protected config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Protected config is implemented by reading a fixed set of paths,
which ignores config [include]-s. Replace this implementation with a
call to config_with_options(), which handles [include]-s and saves us
from duplicating the logic of 1) identifying which paths to read and 2)
reading command line config.

As a result, git_configset_add_parameters() is unused, so remove it. It
was introduced alongside protected config in 5b3c650777 (config: learn
`git_protected_config()`, 2022-07-14) as a way to handle command line
config.

Signed-off-by: Glen Choo <chooglen@google.com>
---
    [2.38 regression] config: respect includes in protected config
    
    Thanks for the quick response, all :)
    
    Changes in v2:
    
     * Squash patches together (per Junio's comments)
     * Use <<-\EOF (per Ævar's comments)
    
    Cc: Derrick Stolee derrickstolee@github.com Cc: Taylor Blau
    me@ttaylorr.com Cc: Johannes Schindelin Johannes.Schindelin@gmx.de Cc:
    Junio C Hamano gitster@pobox.com Cc: Ævar Arnfjörð Bjarmason
    avarab@gmail.com
    
    [1]
    https://lore.kernel.org/git/CAPWNY8W_Tr-WoD-GXBddD5Y8w5Y4w+gDNYQdOAJ1uBwVHuRrsQ@mail.gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1360%2Fchooglen%2Fprotected-config%2Frespect-includes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1360/chooglen/protected-config/respect-includes-v2
Pull-Request: https://github.com/git/git/pull/1360

Range-diff vs v1:

 1:  8c0f40aed7e < -:  ----------- t0033, t0035: test for included config
 2:  0ff5b5741a5 ! 1:  5c398a7f72a config: respect includes in protected config
     @@ t/t0033-safe-directory.sh: test_expect_success 'safe.directory=*, but is reset'
       	expect_rejected_dir
       '
       
     --test_expect_failure 'safe.directory in included file' '
      +test_expect_success 'safe.directory in included file' '
     - 	cat >gitconfig-include <<-EOF &&
     - 	[safe]
     - 		directory = "$(pwd)"
     ++	cat >gitconfig-include <<-EOF &&
     ++	[safe]
     ++		directory = "$(pwd)"
     ++	EOF
     ++	git config --global --add include.path "$(pwd)/gitconfig-include" &&
     ++	git status
     ++'
     ++
     + test_done
      
       ## t/t0035-safe-bare-repository.sh ##
      @@ t/t0035-safe-bare-repository.sh: test_expect_success 'safe.bareRepository on the command line' '
       		-c safe.bareRepository=all
       '
       
     --test_expect_failure 'safe.bareRepository in included file' '
      +test_expect_success 'safe.bareRepository in included file' '
     - 	cat >gitconfig-include <<-EOF &&
     - 	[safe]
     - 		bareRepository = explicit
     ++	cat >gitconfig-include <<-\EOF &&
     ++	[safe]
     ++		bareRepository = explicit
     ++	EOF
     ++	git config --global --add include.path "$(pwd)/gitconfig-include" &&
     ++	expect_rejected -C outer-repo/bare-repo
     ++'
     ++
     + test_done


 config.c                        | 30 ++++++++----------------------
 t/t0033-safe-directory.sh       |  9 +++++++++
 t/t0035-safe-bare-repository.sh |  9 +++++++++
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/config.c b/config.c
index cbb5a3bab74..c157fb5ae3f 100644
--- a/config.c
+++ b/config.c
@@ -2392,11 +2392,6 @@ int git_configset_add_file(struct config_set *cs, const char *filename)
 	return git_config_from_file(config_set_callback, filename, cs);
 }
 
-int git_configset_add_parameters(struct config_set *cs)
-{
-	return git_config_from_parameters(config_set_callback, cs);
-}
-
 int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
 {
 	const struct string_list *values = NULL;
@@ -2641,24 +2636,15 @@ int repo_config_get_pathname(struct repository *repo,
 /* Read values into protected_config. */
 static void read_protected_config(void)
 {
-	char *xdg_config = NULL, *user_config = NULL, *system_config = NULL;
-
+	struct config_options opts = {
+		.respect_includes = 1,
+		.ignore_repo = 1,
+		.ignore_worktree = 1,
+		.system_gently = 1,
+	};
 	git_configset_init(&protected_config);
-
-	system_config = git_system_config();
-	git_global_config(&user_config, &xdg_config);
-
-	if (system_config)
-		git_configset_add_file(&protected_config, system_config);
-	if (xdg_config)
-		git_configset_add_file(&protected_config, xdg_config);
-	if (user_config)
-		git_configset_add_file(&protected_config, user_config);
-	git_configset_add_parameters(&protected_config);
-
-	free(system_config);
-	free(xdg_config);
-	free(user_config);
+	config_with_options(config_set_callback, &protected_config,
+			    NULL, &opts);
 }
 
 void git_protected_config(config_fn_t fn, void *data)
diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index aecb308cf66..dc3496897ab 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -71,4 +71,13 @@ test_expect_success 'safe.directory=*, but is reset' '
 	expect_rejected_dir
 '
 
+test_expect_success 'safe.directory in included file' '
+	cat >gitconfig-include <<-EOF &&
+	[safe]
+		directory = "$(pwd)"
+	EOF
+	git config --global --add include.path "$(pwd)/gitconfig-include" &&
+	git status
+'
+
 test_done
diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-repository.sh
index ecbdc8238db..11c15a48aab 100755
--- a/t/t0035-safe-bare-repository.sh
+++ b/t/t0035-safe-bare-repository.sh
@@ -51,4 +51,13 @@ test_expect_success 'safe.bareRepository on the command line' '
 		-c safe.bareRepository=all
 '
 
+test_expect_success 'safe.bareRepository in included file' '
+	cat >gitconfig-include <<-\EOF &&
+	[safe]
+		bareRepository = explicit
+	EOF
+	git config --global --add include.path "$(pwd)/gitconfig-include" &&
+	expect_rejected -C outer-repo/bare-repo
+'
+
 test_done

base-commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
-- 
gitgitgadget
