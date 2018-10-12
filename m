Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE1811F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 17:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeJMBHv (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 21:07:51 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:45449 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJMBHv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 21:07:51 -0400
Received: by mail-pl1-f176.google.com with SMTP id y15-v6so6244087plr.12
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 10:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/Q0kH/lG3pF9nwpSSuheTiHrbnwv7rEbNrgwtkuf5bs=;
        b=qBdfdSeIGl8ycamLJrXy2l6fX4TMHJIyPwK7E+g45GOEbSwF21VVs1nQ+a0KwOgwVS
         DcU6ydIFCLnypsZg1pOORDfw3KdCpRwS6QstKhW44b6mWiDFrAolIXh2MQqnKRzLEXkk
         j7Zesew9cJ+QbAb1HHHDuScFzuKaTJ2qpMc0oTg5a48OGSRPVrS2lKYpOokMs2HkKBzy
         51+D/1erdWFw3dzQu5xDqi6p974Zm644AA3jtPzk84tOCqcuIsZdiem9r1j2Mmqd/9AW
         CA7IGAY2h9P7p5unNF4cTgc9rTNWbOGnEBF2tIy44iWkPx6DFu06J+ot38b/dX/zUdSv
         dp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/Q0kH/lG3pF9nwpSSuheTiHrbnwv7rEbNrgwtkuf5bs=;
        b=TypruFwECU7zYHWbgFZqizDMILD+pxBOPLXokQ8hNzYQvDprzounv+UiMmBN7lgFXS
         9inqZInHTDzkFSxhs/Vt4MylPyPqPX/Q7EFQly3CakrwFEurnc9YmI8bclgCsTuepqtG
         FAza3BNuuJxECstn6M25ZFoVIQK55NiuZGgbxxLzhvA2gyGjslH18z5RN3H+lmxRmpvc
         LNgmGza+8boMBZ2M1IEGWFJrdztQwcQC5sfhlISK8zGsNxZnzcl+dBV+mm+8ASm1AG8m
         OCbcPPwXZ9kX8Ylz7wYNxnQhTAeED4GoXKoecOvl8NvgAvHHORmmc2BGt25qQ2wSKkSm
         RSGQ==
X-Gm-Message-State: ABuFfohhYO6XpmfZPdy7cWvU0Vt1ilvE+ckwzQYr5KQfJOzwyjAw/Zql
        WJabl7DZg6H8qwq7iJ0IjiCl74R8
X-Google-Smtp-Source: ACcGV62jbSiO1eQPaf+KeYUG6zrAGX/kxZi573P8hRCioO+tUCd8AsWrpcyA4y54yKsdAEBXy8xMjQ==
X-Received: by 2002:a17:902:d808:: with SMTP id a8-v6mr6949004plz.306.1539365657037;
        Fri, 12 Oct 2018 10:34:17 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id h6-v6sm4466717pfc.6.2018.10.12.10.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 10:34:16 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:34:16 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Oct 2018 17:34:11 GMT
Message-Id: <pull.27.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.27.git.gitgitgadget@gmail.com>
References: <pull.27.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/3] Add GIT_TEST_MULTI_PACK_INDEX environment variable
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

To increase coverage of the multi-pack-index feature, add a
GIT_TEST_MULTI_PACK_INDEX environment variable similar to other GIT_TEST_*
variables.

After creating the environment variable and running the test suite with it
enabled, I found a few bugs in the multi-pack-index implementation. These
are handled by the first two patches.

I have set up a CI build on Azure Pipelines [1] that runs the test suite
with a few optional features enabled, including GIT_TEST_MULTI_PACK_INDEX
and GIT_TEST_COMMIT_GRAPH. I'll use this to watch the features and ensure
they work well with the rest of the ongoing work. Eventually, we can add
these variables to the Travis CI scripts.

[1] https://git.visualstudio.com/git/_build?definitionId=4

Derrick Stolee (3):
  midx: fix broken free() in close_midx()
  midx: close multi-pack-index on repack
  multi-pack-index: define GIT_TEST_MULTI_PACK_INDEX

 builtin/repack.c            |  7 +++++--
 midx.c                      | 26 ++++++++++++++++++++------
 midx.h                      |  6 +++++-
 t/README                    |  4 ++++
 t/t5310-pack-bitmaps.sh     |  1 +
 t/t5319-multi-pack-index.sh |  2 +-
 t/t9300-fast-import.sh      |  2 +-
 7 files changed, 37 insertions(+), 11 deletions(-)


base-commit: 5a0cc8aca797dbd7d2be3b67458ff880ed45cddf
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-27%2Fderrickstolee%2Fmidx-test%2Fupstream-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-27/derrickstolee/midx-test/upstream-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/27

Range-diff vs v1:

 1:  9fcbbe336d = 1:  8bd672fe26 midx: fix broken free() in close_midx()
 2:  725ebadc92 ! 2:  2d8f26679d midx: close multi-pack-index on repack
     @@ -15,16 +15,15 @@
      --- a/builtin/repack.c
      +++ b/builtin/repack.c
      @@
     + 			char *fname, *fname_old;
       
       			if (!midx_cleared) {
     - 				/* if we move a packfile, it will invalidated the midx */
     -+				if (the_repository->objects) {
     -+					close_midx(the_repository->objects->multi_pack_index);
     -+					the_repository->objects->multi_pack_index = NULL;
     -+				}
     - 				clear_midx_file(get_object_directory());
     +-				/* if we move a packfile, it will invalidated the midx */
     +-				clear_midx_file(get_object_directory());
     ++				clear_midx_file(the_repository);
       				midx_cleared = 1;
       			}
     + 
      
      diff --git a/midx.c b/midx.c
      --- a/midx.c
     @@ -44,13 +43,34 @@
       	munmap((unsigned char *)m->data, m->data_len);
       	close(m->fd);
       	m->fd = -1;
     +@@
     + 	return 0;
     + }
     + 
     +-void clear_midx_file(const char *object_dir)
     ++void clear_midx_file(struct repository *r)
     + {
     +-	char *midx = get_midx_filename(object_dir);
     ++	char *midx = get_midx_filename(r->objects->objectdir);
     ++
     ++	if (r->objects && r->objects->multi_pack_index) {
     ++		close_midx(r->objects->multi_pack_index);
     ++		r->objects->multi_pack_index = NULL;
     ++	}
     + 
     + 	if (remove_path(midx)) {
     + 		UNLEAK(midx);
      
      diff --git a/midx.h b/midx.h
      --- a/midx.h
      +++ b/midx.h
      @@
     + int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
     + 
       int write_midx_file(const char *object_dir);
     - void clear_midx_file(const char *object_dir);
     +-void clear_midx_file(const char *object_dir);
     ++void clear_midx_file(struct repository *r);
     + int verify_midx_file(const char *object_dir);
       
      +void close_midx(struct multi_pack_index *m);
      +
 3:  04e3e91082 = 3:  57c64e814c multi-pack-index: define GIT_TEST_MULTI_PACK_INDEX

-- 
gitgitgadget
