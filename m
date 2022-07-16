Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F4EC43334
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 20:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiGPUNz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 16:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiGPUNw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 16:13:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C61617D
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 13:13:47 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a5so11424908wrx.12
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=hkcQRwDFxsWnBFIW9Ly+US4dfD9gKyX9q6bdZIRD1JQ=;
        b=kUMxjslBehB0vHz4ZqQ9CnO+ii7maylynYRH8UuDQqD7PvYq7BYhndn1ytfulPcUB5
         djYhFzc/6aZUP9h9/UbCWtG4xYeApdI+wzRSsaWlzz6iFyqEW7QV9NDhshaunUeoLXcS
         jwQLqOtbO9YBFlw5L0a5KqJnmNeYN3eJaG3bOP6pKENpUHvY9+YJ9LT0LFfhHd68Mitx
         Hr0td3uytqz+EH9eIBalUzzexwLZ9N8/0LWeEUlClop4uF7XiRWflCNIKFuCKTnzrxdW
         2yk6ELPRErFIDfFNY+jU+cy4TGtDUPB+nwv3kuUWluY9fuQlbOVLsTBaZ0yeW+UiaxLm
         kLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=hkcQRwDFxsWnBFIW9Ly+US4dfD9gKyX9q6bdZIRD1JQ=;
        b=c8vKZYE+RWWGHZLXLgxm8QGZy0xWGpX1D8LqFIwFfJtz28s6B8GaZ++lrE7zKjagsP
         7Gph2PsZybmjehmnaNeC2Xj2cN7vUReCmGyjeToH2sLgZLLx6wsFXzuBtI5jlpJmDUKf
         B9oRCTEeffsTEhjZPV8zuOWvrLXOcrfKrYg2C5LLIt8FHjxaWvuf0rRFoCP2C7B3BHJP
         b70myoiIBHQ6sWNvd9nmbKccxS2OtH0IW9oZkVrrVt/wNygiayonZwDyxdGoVpeA+CbF
         yb+hqOdZqEcP0d5vLIeEOKzMaeY7R3FmVIgkfkRYlTR6P6ySTiRnShL+HqDtbwyDLDTc
         sZfA==
X-Gm-Message-State: AJIora9pgVA879JiYHeHA+9CkLDO/DfMxRas5I+5TB+oVlcto5j7YlmN
        ndbUjBkBf6bN/roT7ZEnr9bjDA0lzT4=
X-Google-Smtp-Source: AGRyM1sWUM/qWqiXKTxAbU4xUSNfTXqmp9meJKLx8hq3+v+GdFFTLzK5aK46h01NHq8rnHbbXKNHMw==
X-Received: by 2002:a5d:5445:0:b0:21d:a63c:85ee with SMTP id w5-20020a5d5445000000b0021da63c85eemr18220090wrv.294.1658002425709;
        Sat, 16 Jul 2022 13:13:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r3-20020adfe683000000b0021004d7d75asm6845267wrm.84.2022.07.16.13.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 13:13:44 -0700 (PDT)
Message-Id: <pull.1285.v2.git.1658002423864.gitgitgadget@gmail.com>
In-Reply-To: <pull.1285.git.1657738937049.gitgitgadget@gmail.com>
References: <pull.1285.git.1657738937049.gitgitgadget@gmail.com>
From:   "Manuel Boni via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 16 Jul 2022 20:13:43 +0000
Subject: [PATCH v2] config.txt: document include, includeIf
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Manuel Boni <ziosombrero@gmail.com>,
        Manuel Boni <ziosombrero@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Manuel Boni <ziosombrero@gmail.com>

Git config's tab completion does not yet know about the "include"
and "includeIf" sections, nor the related "path" variable.

Add a description for these two sections in
'Documentation/config/includeif.txt', which points to git-config's
documentation, specifically the "Includes" and "Conditional Includes"
subsections.

As a side effect, tab completion can successfully complete the
'include', 'includeIf', and 'include.add' expressions.
This effect is tested by two new ad-hoc tests.
Variable completion only works for "include" for now.

Credit for the ideas behind this patch goes to
Ævar Arnfjörð Bjarmason.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Manuel Boni <ziosombrero@gmail.com>
---
    config.txt: add completion for include, includeIf
    
    CC: Ævar Arnfjörð Bjarmason avarab@gmail.com cc: Jeff King peff@peff.net
    
    Update 2022-07-16: I addressed the suggestions by Jeff King and Junio C.
    Hamano by integrating their fixes and by rewording the commit message,
    so that emphasis is put on the documentation enhancement and mentioning
    the improved tab completion as a beneficial side effect.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1285%2Fziosombrero%2Fcomp-config-include-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1285/ziosombrero/comp-config-include-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1285

Range-diff vs v1:

 1:  79d877bcd6c ! 1:  38b1860020f config.txt: add completion for include, includeIf
     @@ Metadata
      Author: Manuel Boni <ziosombrero@gmail.com>
      
       ## Commit message ##
     -    config.txt: add completion for include, includeIf
     +    config.txt: document include, includeIf
      
          Git config's tab completion does not yet know about the "include"
          and "includeIf" sections, nor the related "path" variable.
      
     -    Add tab completion support for the aforementioned items,
     -    along with two new tests, based on the existing ones,
     -    specifically for this completion. Variable completion only works
     -    for "include" for now.
     +    Add a description for these two sections in
     +    'Documentation/config/includeif.txt', which points to git-config's
     +    documentation, specifically the "Includes" and "Conditional Includes"
     +    subsections.
     +
     +    As a side effect, tab completion can successfully complete the
     +    'include', 'includeIf', and 'include.add' expressions.
     +    This effect is tested by two new ad-hoc tests.
     +    Variable completion only works for "include" for now.
      
          Credit for the ideas behind this patch goes to
          Ævar Arnfjörð Bjarmason.
      
     +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Manuel Boni <ziosombrero@gmail.com>
     -    Based-on-patch-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     +
     + ## Documentation/config.txt ##
     +@@ Documentation/config.txt: include::config/i18n.txt[]
     + 
     + include::config/imap.txt[]
     + 
     ++include::config/includeif.txt[]
     ++
     + include::config/index.txt[]
     + 
     + include::config/init.txt[]
      
       ## Documentation/config/includeif.txt (new) ##
      @@
      +include.path::
     -+
      +includeIf.<condition>.path::
      +	Special variables to include other configuration files. See
      +	the "CONFIGURATION FILE" section in the main
     -+	linkgit:git-config[1] documentation.
     ++	linkgit:git-config[1] documentation,
     ++	specifically the "Includes" and "Conditional Includes" subsections.
     ++	
      
       ## t/t9902-completion.sh ##
      @@ t/t9902-completion.sh: test_expect_success 'git config - section' '


 Documentation/config.txt           |  2 ++
 Documentation/config/includeif.txt |  7 +++++++
 t/t9902-completion.sh              | 13 +++++++++++++
 3 files changed, 22 insertions(+)
 create mode 100644 Documentation/config/includeif.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e376d547ce0..5b5b9765699 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -445,6 +445,8 @@ include::config/i18n.txt[]
 
 include::config/imap.txt[]
 
+include::config/includeif.txt[]
+
 include::config/index.txt[]
 
 include::config/init.txt[]
diff --git a/Documentation/config/includeif.txt b/Documentation/config/includeif.txt
new file mode 100644
index 00000000000..28b6a52d9f5
--- /dev/null
+++ b/Documentation/config/includeif.txt
@@ -0,0 +1,7 @@
+include.path::
+includeIf.<condition>.path::
+	Special variables to include other configuration files. See
+	the "CONFIGURATION FILE" section in the main
+	linkgit:git-config[1] documentation,
+	specifically the "Includes" and "Conditional Includes" subsections.
+	
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 31526e6b641..43de868b800 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2485,6 +2485,13 @@ test_expect_success 'git config - section' '
 	EOF
 '
 
+test_expect_success 'git config - section include, includeIf' '
+	test_completion "git config inclu" <<-\EOF
+	include.Z
+	includeIf.Z
+	EOF
+'
+
 test_expect_success 'git config - variable name' '
 	test_completion "git config log.d" <<-\EOF
 	log.date Z
@@ -2493,6 +2500,12 @@ test_expect_success 'git config - variable name' '
 	EOF
 '
 
+test_expect_success 'git config - variable name include' '
+	test_completion "git config include.p" <<-\EOF
+	include.path Z
+	EOF
+'
+
 test_expect_success 'git config - value' '
 	test_completion "git config color.pager " <<-\EOF
 	false Z

base-commit: 9dd64cb4d310986dd7b8ca7fff92f9b61e0bd21a
-- 
gitgitgadget
