Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE4221F463
	for <e@80x24.org>; Mon, 23 Sep 2019 08:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404845AbfIWI2h (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 04:28:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42728 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392172AbfIWI2h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 04:28:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id n14so12849555wrw.9
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=CQBYS6+aj3t2CcUJVdcAtk7VaTe2uPZjluqgccCFpqw=;
        b=nnjsbi7nyrda3j41X0GJUbx6luPBTOTesBApFvr/OnMnA+Hcql6xd5tXftzYOg9C9O
         korcSi6Om52U/QlO/lPrzOXJ9N3S0viPcCg9upn/XF9LnhlhB2GxlEGLub7E54dRQI8Z
         5CUdFqDjWGxNcriIBtIED0Z+mwPZttwhPzSHfYSqSlaEZs162woeXudnVymOc66fEdxX
         ZwjfkMxLm9N2Fgy4rwoebvGflVWonz9nD8wAbOsp0kE9kdGl3jLgq6AUI+fXfxzsPmFu
         pgMmNPL/Fzvh9iMaBFoF6Vt/OPy5br4pNYqJiBWM4sQoS/me5tE64QGbaoM8MsD+B+33
         KDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CQBYS6+aj3t2CcUJVdcAtk7VaTe2uPZjluqgccCFpqw=;
        b=pSILmGoEpyzcSsAT1X0qJCnso2Wd5+D9j/5OZ7OVORQjolUBjDqD7vTRitIbe3rpxO
         yvXOK4sWazENuJoy8pe1ToLTEt+qWQ3HPHWtCQMI/ae5Z2ahM4jm+R+PQ5go+iyOW90f
         YhU/9h+9ytXKIAqwxys4EEoMPQPf4sB0UZ3BuMsmPRAlFCw9rvknIcCz2l9FC3oC8GuY
         ZUq/u3ecuaZDe6oGf5mU6MN9vvR4ENlwPgKNspWtoGyngMnRbISp7gFCGBeuXv1E7LR6
         iNp4Mts0s1oQvNQ/PG438K+RZkhgvtLRimQk07idBq0USQo3DmvBCoK8Ph9MyHPq+j/A
         aS7w==
X-Gm-Message-State: APjAAAVTuuIQbfO+ZmgYlgcjA2t43QxHi0JMqH5mtO0CDuttmWzK5B1B
        iPZWRk/rAtOn00PwvimcepWj0eGQ
X-Google-Smtp-Source: APXvYqwwTJ3kZaNqJwWk4TYoZFpmxHaTx00DNrBH4resraKK8yg6BeIhjCA0SwmhG+V51s4miGFQnA==
X-Received: by 2002:a5d:458b:: with SMTP id p11mr549777wrq.160.1569227315163;
        Mon, 23 Sep 2019 01:28:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d78sm13633493wmd.47.2019.09.23.01.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 01:28:34 -0700 (PDT)
Date:   Mon, 23 Sep 2019 01:28:34 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Sep 2019 08:28:32 GMT
Message-Id: <pull.348.git.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] contrib/buildsystems: fix Visual Studio Debug configuration
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

Even though Debug configuration builds, the resulting build is incorrect in
a subtle way: it mixes up Debug and Release binaries, which in turn causes
hard-to-predict bugs.

In my case, when git calls iconv library, iconv sets 'errno' and git then
tests it, but in Debug and Release CRT those 'errno' are different memory
locations.

This patch addresses 3 connected bugs: 1) Typo in '(Configuration)'. As a
result, Debug configuration condition is always false and Release path is
taken instead. 2) Regexp that replaced 'zlib.lib' with 'zlibd.lib' was only
affecting the first occurrence. However, some projects have it listed twice.
Previously this bug was hidden, because Debug path was never taken. I
decided that avoiding double -lz in makefile is fragile and I'd better
replace all occurrences instead. 3) In Debug, 'libcurl-d.lib' should be used
instead of 'libcurl.lib'. Previously this bug was hidden, because Debug path
was never taken.

Signed-off-by: Alexandr Miloslavskiy alexandr.miloslavskiy@syntevo.com
[alexandr.miloslavskiy@syntevo.com]

Alexandr Miloslavskiy (1):
  contrib/buildsystems: fix Visual Studio Debug configuration

 contrib/buildsystems/Generators/Vcxproj.pm | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)


base-commit: 4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-348%2FSyntevoAlex%2F%230188_VisualStudio_Debug_build_fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-348/SyntevoAlex/#0188_VisualStudio_Debug_build_fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/348
-- 
gitgitgadget
