Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3ABC4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 12:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiK2MBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 07:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiK2MAl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 07:00:41 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B804D5BD77
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 04:00:24 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bx10so9628602wrb.0
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 04:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qe1ZaBOekAFJNa9cLeKTbCGM+f6sgpW7IzdhWmkMyuw=;
        b=qwrgl2IhRk/Cii85SAski/u9xZVq4c/6ppCMJMpecdqWe2noG5L5LbZLkZQr3RCIKH
         0nqa3V66IxlPjL8U+Mb7LYM7v7BgIEPWoibCLQyLP2rr7yKtKAf+AnKi9t4+xA/MIQAL
         Wi7/W0Xx7wPI8mU5RG23fAFY0Nyr9GmhufWm/iI1Y8XnV5zbhG3zvKn/EDajrUCvJUg2
         INTA/BKJBmEU+JSogK0BBB1r+pth3F3WUc3/ZPkw9bPJm2DBr3GpqzOfCVhxc5bLQ1d7
         rD4h97+TBY12dM2mt9rs4Mj/XPACb4PXY8q29hPHaoyiv0/G66ILCjfPuuJ6o9zwv08L
         Xy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qe1ZaBOekAFJNa9cLeKTbCGM+f6sgpW7IzdhWmkMyuw=;
        b=4P582HhvDKNey3H5YS5tOWsm2t+4zx4FrOCb48VL8bnpR0a3O+tHBVqeO2iwPB+mBH
         TGtgskYVC0vXhvMUc2oyVnDCH0I/O6Yor64htSv/CmFIJ3hU1bHLDbm/ee9WUYVdYyRp
         T21i/zMV/EyOWi/a9O1WPXxhfYNkMdJjt7hFR21CASqd5gjGYcHYSfkMm1zRxvoDq8uT
         0T39pEKCCBVg9ZotSNgPqJ9Ip46t3xwwxdca7a7x7e9D+Y8w46csGVLyWteAsoxS9PqF
         4zLHlhXuuNcIP0x0q7x6WeZE/ZdMZiAH0Rpj+xHoYW+63Iy+R5YmysIEoxTlXUE8I3kr
         qmqA==
X-Gm-Message-State: ANoB5pk0rX35UR93DQYJyeZtJ1+YizU2uxvnXBQqh7oKuNwxNHjYDycc
        bhNjHD6Ska9YM2DHyC9DBnAqvfXCED0=
X-Google-Smtp-Source: AA0mqf44xbu/kipAsDcPXvvFHzFHk7hSW9CNX6csbx2uY7BJUSMVkh19O0WZThNuulIhMTZQ+qrNrw==
X-Received: by 2002:adf:db87:0:b0:242:2719:5784 with SMTP id u7-20020adfdb87000000b0024227195784mr411890wri.130.1669723222958;
        Tue, 29 Nov 2022 04:00:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s9-20020a5d5109000000b00241f467f888sm13404493wrt.74.2022.11.29.04.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 04:00:22 -0800 (PST)
Message-Id: <pull.1398.v3.git.1669723221.gitgitgadget@gmail.com>
In-Reply-To: <pull.1398.v2.git.1669344333627.gitgitgadget@gmail.com>
References: <pull.1398.v2.git.1669344333627.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Nov 2022 12:00:19 +0000
Subject: [PATCH v3 0/2] [RFC] diff: introduce scope option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In [1], we discovered that users working on different sparse-checkout
specification may download unnecessary blobs from each other's specification
in collaboration. In [2] Junio suggested that maybe we can restrict some git
command's filespec in sparse-checkout specification to elegantly solve this
problem above. In [3]: Newren and Derrick Stolee prefer to name the option
--scope={sparse, all}.

So this patch is attempt to do this thing on git diff:

v1:

 1. add --restrict option to git diff, which restrict diff filespec in
    sparse-checkout specification. [4]

v2.

 1. rename --restrict to --scope={sparse, all}, support --no-scope.
 2. add config: diff.scope={sparse,all}.

v3.

 1. with the help of newren's review, fix the wrong --scope behavior, its
    previous meaning was misrepresented as sparse patterns, and now it is
    fixed to match sparse specification. [5]
 2. remove wrong diff.scope config.
 3. apply --scope to git diff, git diff-index, git diff-tree.

v4.

 1. create a OPT_SPARSE_SCOPE macro for easier add --scope option to other
    git commands later.
 2. introduce --scope option to "git grep ".

Since I split --scope into a separate option, this option will not be
directly inherited by git commands such as git log, git format-patch, etc.
If necessary, we can add it to git log or other commands in a similar way
later.

Global scope config haven’t implement yet... Since we haven't decided on an
appropriate name for scope config. [6]

Note why I don't add --scope to "git grep --cached", because we can't use ""
with "--cached", whether we use --scope=sparse or not , the resulting set of
files it gets is the same.

[1]:
https://lore.kernel.org/git/CAOLTT8SHo66kGbvWr=+LQ9UVd1NHgqGGEYK2qq6==QgRCgLZqQ@mail.gmail.com/
[2]: https://lore.kernel.org/git/xmqqzgeqw0sy.fsf@gitster.g/ [3]:
https://lore.kernel.org/git/07a25d48-e364-0d9b-6ffa-41a5984eb5db@github.com/
[4]:
https://lore.kernel.org/git/pull.1368.git.1664036052741.gitgitgadget@gmail.com/
[5]:
https://lore.kernel.org/git/CAOLTT8TceM-NpV2_hUCZj2Dx=W30f_9SHW8CcRH-pw32BRd-oA@mail.gmail.com/
[6]:
https://lore.kernel.org/git/CABPp-BGHMsMxP6e7p0HAZA=ugk+GY3XW6_EaTN=HzaLQYAzQYA@mail.gmail.com/

ZheNing Hu (2):
  [RFC] diff: introduce --scope option
  [RPC] grep: introduce --scope option

 Documentation/diff-options.txt   |  33 ++++
 Documentation/git-grep.txt       |  24 +++
 builtin/diff-index.c             |  24 ++-
 builtin/diff-tree.c              |  11 ++
 builtin/diff.c                   |  23 ++-
 builtin/grep.c                   |  10 +
 cache.h                          |   5 +
 diff-lib.c                       |  43 +++++
 diff.c                           |   2 +
 diff.h                           |   7 +
 dir.c                            |  52 ++++++
 dir.h                            |   4 +
 grep.h                           |   2 +
 parse-options.h                  |   7 +
 t/t1090-sparse-checkout-scope.sh | 303 +++++++++++++++++++++++++++++++
 tree-diff.c                      |   7 +
 16 files changed, 551 insertions(+), 6 deletions(-)


base-commit: 815c1e82021edbd99a2c423cf27f28863f28cef3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1398%2Fadlternative%2Fzh%2Fdiff-scope-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1398/adlternative/zh/diff-scope-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1398

Contributor requested no range-diff. You can review it using these commands:
   git fetch https://github.com/gitgitgadget/git c000d916 1d1b6618
   git range-diff <options> c000d916..471a0691 083e0127..1d1b6618
-- 
gitgitgadget
