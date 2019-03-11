Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A987E20248
	for <e@80x24.org>; Mon, 11 Mar 2019 20:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfCKULC (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 16:11:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34213 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbfCKULA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 16:11:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id a16so396049edn.1
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 13:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yjvZW4zjNjpprqqBWQYdbkUICUiCWKFyNMx8crEo1qU=;
        b=YxLj3K2wgW+Z06mI9bl+g7F1LxXBCzVmhIHglsOs14Qgx5g1/uqHZgvsVgAqYZthSn
         wzojSx1s8OuacxV4tVXlVnxH8IVBM/42alg6CPyp8y3sPSRBAmu3h4YHYDoT3wdGIQOb
         co8hj6xGaT0QspRx//yG+FQb2flH+7q4f5I6oxoEOVkAt4phqGhZjFQcI6SUC0aoO8LJ
         t3wf1iXqrOP6xRPYDybeWOdAktyl9zyCmTllenqgejErlugm00VM8Zt+Yzqa53zjtbMx
         imaNjQjrTWXMT2FdmIiMiJq4Dn+U6nTW7q+c8FZx76ck29jXeSD9spHc3UsplIikWFof
         1cSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yjvZW4zjNjpprqqBWQYdbkUICUiCWKFyNMx8crEo1qU=;
        b=AQnuB+RUoukZG9ZFEAJF4hHpElrui8PsoGJkNG/pnJ6JG8n8RM4T40MYkta9WKqz6X
         l4oFeYU6wFjKyCCZjYfH7yrR+otgbpZ99eg1rG1VvJtuhLSB2KZNf6PWYUgWSen8KCyI
         pdOTwi5sPknYRiOIRSCweKKj6LxtKAHdE8vruC5RNS3KW5LcQbwX8YmZIs11kkQOjR0+
         597JzX3nPWqv9nyUhFNdL2sAHoiKANzmtwQUwemRRneKTCOQCV2z+4EZsjuwujFH+pUQ
         T36o0lRitJ1/4M75WcvI6WVNMjMn9i38Z+SOcO/NbF/ESp1xv2ZcdjygI17VyV25nZyO
         YP/Q==
X-Gm-Message-State: APjAAAW6AdeOONnoCb9z7pxg3olQ+MPsVr2AT0gKupK1cJr2hY+/VUoB
        t59kmjiPvmlI1oRqvNRaqWm5miTm
X-Google-Smtp-Source: APXvYqzBpu1Hhm3F2RWQ5fPzK1JSYd+ghtGXjEwBR41ZMDKaG585jKsHhDUkb2aZS1xa6GbWHdRT/A==
X-Received: by 2002:a50:9908:: with SMTP id k8mr388933edb.246.1552335058376;
        Mon, 11 Mar 2019 13:10:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n38sm5050912edn.95.2019.03.11.13.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 13:10:57 -0700 (PDT)
Date:   Mon, 11 Mar 2019 13:10:57 -0700 (PDT)
X-Google-Original-Date: Mon, 11 Mar 2019 20:10:56 GMT
Message-Id: <pull.131.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.131.git.gitgitgadget@gmail.com>
References: <pull.131.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] Fix git init with core.hidedotfiles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes an regression that was not present in Git for Windows's original 
core.hideDotFiles patch, but in the shape of the core.hideDotFiles patch
that made it into git.git.

We fixed it in one big hurry in Git for Windows, and I simply forgot to
upstream this right away.

Changes since v1:

 * Clarified in the code comment that our intention is to pick up 
   core.hidedotfiles in the first git_config() call.
 * Explained in the commit message why we cannot remove the 
   git_config(git_init_db_config, NULL) call from create_default_files(): it
   would cause a change of behavior with regard to the init.templatedir 
   setting.
 * Simplified the test case.

Johannes Schindelin (1):
  mingw: respect core.hidedotfiles = false in git-init again

 builtin/init-db.c |  7 +++++++
 t/t0001-init.sh   | 11 +++++++++++
 2 files changed, 18 insertions(+)


base-commit: e902e9bcae2010bc42648c80ab6adc6c5a16a4a5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-131%2Fdscho%2Funhidden-git-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-131/dscho/unhidden-git-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/131

Range-diff vs v1:

 1:  008e367d26 ! 1:  f187d0d247 mingw: respect core.hidedotfiles = false in git-init again
     @@ -12,6 +12,12 @@
          The fix is obvious: read the (limited, pre-init) config *before*
          creating the .git/ directory.
      
     +    Please note that we cannot remove the identical-looking `git_config()`
     +    call from `create_default_files()`: we create the `.git/` directory
     +    between those calls. If we removed it, and if the parent directory is
     +    in a Git worktree, and if that worktree's `.git/config` contained any
     +    `init.templatedir` setting, we would all of a sudden pick that up.
     +
          This fixes https://github.com/git-for-windows/git/issues/789
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     @@ -29,11 +35,19 @@
       	return 0;
       }
       
     +@@
     + 	struct strbuf err = STRBUF_INIT;
     + 
     + 	/* Just look for `init.templatedir` */
     ++	init_db_template_dir = NULL; /* re-set in case it was set before */
     + 	git_config(git_init_db_config, NULL);
     + 
     + 	/*
      @@
       	}
       	startup_info->have_repository = 1;
       
     -+	/* Just look for `init.templatedir` and `core.hidedotfiles` */
     ++	/* Just look for `core.hidedotfiles` */
      +	git_config(git_init_db_config, NULL);
      +
       	safe_create_dir(git_dir, 0);
     @@ -50,11 +64,10 @@
      +test_expect_success MINGW 'core.hidedotfiles = false' '
      +	git config --global core.hidedotfiles false &&
      +	rm -rf newdir &&
     ++	mkdir newdir &&
      +	(
      +		sane_unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
     -+		mkdir newdir &&
     -+		cd newdir &&
     -+		git init
     ++		git -C newdir init
      +	) &&
      +	! is_hidden newdir/.git
      +'

-- 
gitgitgadget
