Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A993C433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 18:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbiAVSf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 13:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiAVSf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 13:35:57 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7625C06173B
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 10:35:56 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i67so69830wma.0
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 10:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=xHi5hSU7RgAb9F+OFANqaP4/N6lLAt53mN9QU8d0CeA=;
        b=nHn/0qRhKavkVMsmCt9nlHJFyFTiD/hfhAC559zYusEtINsEVOeF4Em/fdQNmuZPAR
         xj3/xTIkoLGY+j3Pb86Mx00xTL21UgBLu87D42hl48HkVPKiojwQyDPeFdlEAwUqYnw6
         eklnflCVo9DVcSfLyqycKjy/HC91nxtQR4zPYfTet9F53ITZTb66TLhkq4ADE7ohVKr6
         PwJSLKfjxlDyBUbFqxzb/9Uzo8mq7hsxdwju4aMHcKb363mGfnaAGfevf3LgtmpUd2L0
         ltIY/ablnWLLgiJD//WVVQkHdRGJvk4NKxdwc2bOPzfUK5C907wAr5YX313gTOKr9Sy0
         NnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=xHi5hSU7RgAb9F+OFANqaP4/N6lLAt53mN9QU8d0CeA=;
        b=oU9j38YjLnomDvVdE2Fm7EAVXQAisSX6R18NYw8sqZGa8Ihshnsf/C1NZQV/0EHRkl
         MDzcsgjMo/T8iEw6peTKXwjRCZrG9/IFhoFdBLHKPZLYn+Lf0NhxZX271dV5XkCjbDsx
         2WEyxnowks0x/mDOyxhc8OteclIYOlqDsMB2vr+2NRasO8zHFcejPXlWfPCgWhlk/2Z1
         M73WovZiKW2v4zpgM7biLYGENKPjjaYinqkGhtDiz5pLAWmUf2QgqjGj3U4ckpfoiaGX
         W5w2cztHS2bKj/QGQeA0riZ1gp8G2gISbqzsSptjVvVmv5qUCQQO2DQTKEBN1m+Tvh9f
         6KMA==
X-Gm-Message-State: AOAM533ig9y9Nlq93Iexces7LknFBupcF7uf6MZS3+UGJMH0QL6OzgHx
        RjEkhKPI3MX2jiaHXoaezDff/HWL+jY=
X-Google-Smtp-Source: ABdhPJwO7iPBRyGGHK73LuguIsQVUIoUQugXFbs0ZH7TDhnGgO4yZSA2lSPEOmj1tvianjHsXHA5Aw==
X-Received: by 2002:a1c:1f04:: with SMTP id f4mr5300450wmf.161.1642876555122;
        Sat, 22 Jan 2022 10:35:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x4sm10178150wrp.13.2022.01.22.10.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 10:35:54 -0800 (PST)
Message-Id: <pull.1123.git.1642876553.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sat, 22 Jan 2022 18:35:49 +0000
Subject: [PATCH 0/4] Factorize i18n
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a small series of i18n factorizations. Again the idea is to:

 * reduce the number of strings to translate
 * make life easier for translators by removing constant parts of the
   strings to translate
 * uniformize the UI by using a type of message for the a given type of
   condition.

Jean-Noël Avila (4):
  i18n: factorize more 'incompatible options' messages
  i18n: factorize "invalid value" messages
  i18n: remove from i18n strings that do not hold translatable parts
  i18n: transfer variables into placeholders in command synopsis

 archive.c                                 |  2 +-
 builtin/am.c                              |  7 ++--
 builtin/bisect--helper.c                  |  6 ++--
 builtin/blame.c                           |  6 ++--
 builtin/commit.c                          | 39 ++++++++++++++---------
 builtin/count-objects.c                   |  2 +-
 builtin/difftool.c                        | 18 +++++++++--
 builtin/fast-export.c                     |  2 +-
 builtin/fetch.c                           |  4 +--
 builtin/grep.c                            |  4 +--
 builtin/hash-object.c                     |  2 +-
 builtin/help.c                            |  4 +--
 builtin/log.c                             | 20 ++++++++++--
 builtin/merge-base.c                      |  4 +--
 builtin/mktag.c                           |  2 +-
 builtin/mktree.c                          |  2 +-
 builtin/notes.c                           |  6 ++--
 builtin/pack-objects.c                    |  2 +-
 builtin/prune-packed.c                    |  2 +-
 builtin/pull.c                            |  6 ++--
 builtin/push.c                            |  2 +-
 builtin/rebase.c                          |  2 +-
 builtin/reflog.c                          |  6 ++--
 builtin/remote.c                          |  2 +-
 builtin/replace.c                         |  2 +-
 builtin/rev-list.c                        |  2 +-
 builtin/send-pack.c                       |  2 +-
 builtin/sparse-checkout.c                 |  8 ++---
 builtin/stripspace.c                      |  4 +--
 builtin/submodule--helper.c               |  2 +-
 builtin/update-server-info.c              |  2 +-
 diff-merges.c                             |  2 +-
 gpg-interface.c                           |  4 +--
 ls-refs.c                                 |  2 +-
 parallel-checkout.c                       |  3 +-
 sequencer.c                               |  2 +-
 setup.c                                   |  2 +-
 submodule-config.c                        |  2 +-
 t/t4150-am.sh                             |  2 +-
 t/t7500-commit-template-squash-signoff.sh |  2 +-
 40 files changed, 118 insertions(+), 77 deletions(-)


base-commit: 90d242d36e248acfae0033274b524bfa55a947fd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1123%2Fjnavila%2Ffactorize_i18n-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1123/jnavila/factorize_i18n-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1123
-- 
gitgitgadget
