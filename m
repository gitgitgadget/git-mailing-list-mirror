Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91F431F516
	for <e@80x24.org>; Thu, 28 Jun 2018 12:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbeF1MxU (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 08:53:20 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:38688 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753642AbeF1MxT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 08:53:19 -0400
Received: by mail-pf0-f179.google.com with SMTP id j17-v6so2559809pfn.5
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 05:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+THSYcURokkgYeruaMQgO7fTDZjHJdwJh1IOEmBVgUg=;
        b=YE0rPRGBHY5z4o9Vqpip/lc111kGsI2fSoQ/RUveJ/DLIf9HTNgMzWWxqCxPakUyTs
         SJMvBeiQyJrkyMgc+TnhlQn0fMdQ3xbpzTI87/Eki93PvYLc+yQ3EeCGI4oM3WaepvVb
         NIRquHw30sRd01iu2ZW6pyGaY5NmRbAqHdFP6e9LSpvrdnx5oFCI1ZsEzmQUp9xDyeDZ
         94PaQxmBxlA5VPE8ff+owCSW1Kty2MctiP6EW3nr1oK6eDSJS0zh1iFMwF+rzjmhmlqA
         aVXY7hehjAUYxFSFJV29+Z05FEyDQhBpvDG86TRFMYELptq2FxuTeToH3AZm4tYE3rdj
         LMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+THSYcURokkgYeruaMQgO7fTDZjHJdwJh1IOEmBVgUg=;
        b=KYe2UGgXoLyeqjWAxCK2SZEXr/sUDMu2k8EHAGBfQ+8BzcdSPEfQW+SjomKv5gaDw9
         e8eQtwE2V+E/KY+pv7YGsVU93v30Li3f8koAenMOc8jIJYDYXX0A11NKKtpUizOI9lh5
         AjS3tAhmqbhe5+8z2GZRmwmLHfPcMT5h9BaXsUW3fxMBVn0bYbgEXh9Yocxf5SOCZWbx
         5rmGAQbsnciHCHBAaeGvDjxhrZ3vkwEiV/PX3dx8CdjkUm6ablNsb3bBsCLuTx+Eqy/v
         UBsnpCag/xnSgpluURKhSAjZQDWlfsCOZk4j6wnmulojroQX39opS6fyrgtbSuvsYlOr
         h7Yg==
X-Gm-Message-State: APt69E3thL3lJMn6oIAii8lcvEwmmO5r8RwWWeC05529fZiOSttg3l7t
        2iweiaOoWh9YcuqNDte8ggWaEg==
X-Google-Smtp-Source: ADUXVKK9oRWWyrF9MQ4nzubz8c1R3jZK0cxkSGZ95zK0g61TkUYtPaeuJ3tFlGTsFFhThnz9WdP84g==
X-Received: by 2002:a65:64d3:: with SMTP id t19-v6mr8757641pgv.148.1530190398414;
        Thu, 28 Jun 2018 05:53:18 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id b65-v6sm12405052pfg.34.2018.06.28.05.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 05:53:17 -0700 (PDT)
Message-Id: <pull.7.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Jun 2018 12:53:15 +0000
Subject: [PATCH 0/1] Makefile: fix the "built from commit" code
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

In ed32b788c06 (version --build-options: report commit, too, if
possible, 2017-12-15), we introduced code to let `git version
--build-options` report the current commit from which the binaries were
built, if any.

To prevent erroneous commits from being reported (e.g. when unpacking
Git's source code from a .tar.gz file into a subdirectory of a different
Git project, as e.g. git_osx_installer does), we painstakingly set
GIT_CEILING_DIRECTORIES when trying to determine the current commit.

Except that we got the quoting wrong, and that variable therefore does
not have the desired effect.

Let's fix that quoting, and while at it, also suppress the unhelpful
message

fatal: not a git repository (or any of the parent directories): .git

that gets printed to stderr if no current commit could be determined,
and might scare the occasional developer who simply tries to build Git
from scratch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks for taking the time to contribute to Git! Please be advised that the
Git community does not use github.com for their contributions. Instead, we use
a mailing list (git@vger.kernel.org) for code submissions, code reviews, and
bug reports. Nevertheless, you can use submitGit to conveniently send your Pull
Requests commits to our mailing list.

Please read the "guidelines for contributing" linked above!

Johannes Schindelin (1):
  Makefile: fix the "built from commit" code

 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: ed843436dd4924c10669820cc73daf50f0b4dabd
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-7/dscho/fix-build-options-commit-info-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-7/dscho/fix-build-options-commit-info-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/7
-- 
gitgitgadget
