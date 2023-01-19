Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB7AC004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 17:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjASReb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 12:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjASRea (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 12:34:30 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BFBF5
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 09:34:28 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l8so2122780wms.3
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 09:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HB7ytbwch4Pd7zmvtDX1x1vjiKcle29ao/t6LE6CloM=;
        b=nwKsUc2/ADmnvdoO8K9dsANIs8NvXyj6Ucc4yRmmCL6hKyPndi4XNh+i7YW36jNZwL
         Qpbsi/HMzoU1HsBwxbt1D30x8uEE8e7lp6VFOG6ueLtWsNAqsquPWf+yxvCEbxX3XFi2
         kG7UtnE4EbUDTlHARxWMtGO/TAcDH9dIp7zdbSaL9xG0/CtYTn1wrq0wRZ1yzq5aEaW2
         A9kYuuTE9ETL1omfFxMSmDFmlDoN3w6P5Z26lmYtP+VzND57zrsuw29g7taX9qaJwldQ
         cOpZnkkQjxzkiyMbxBu+ioE3va9Gw+HTDV92baoc4FDyeUZWaCR0PJ3NLT9YBnSjyxdn
         q/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HB7ytbwch4Pd7zmvtDX1x1vjiKcle29ao/t6LE6CloM=;
        b=BJIuHqjYkNZgOb63JEphkRZb26vv4Bfc+OI4zwaYxPNT//wOLTX1OS4+9sYG4h+WCP
         pPyvRyDTWx+pCFmTVyVRNSTmFu60mSqmqSt9tZ8mgJOXGd6TQw9DnErcKK9sEQ9VVaOq
         IMsaJjm3EBYHJT0oViVRx73jdNIJMA66kIUvoLbFIV2v38F7BRg71zFm3ikoZ94mNTYF
         WJ1U/47Tr0CM0twWG4pQczCB4OeXZIUyCwPHNukBVDacFlATHz34y48t7vrkKxqaD06V
         HrHCM4Iy5AY+TgtXThmxKC9MTHFU3LEZhGT765nVYydYDZSgxnHfxI49LLBfuEugoP20
         q3TA==
X-Gm-Message-State: AFqh2kq+4iYUMjdSzqJrHUq/ljtLlu8vNJnSNduP5J7Pw8HH5zXyGjtz
        t7IOGh1ocac8vNCc1BoFKrEnLSrUQLA=
X-Google-Smtp-Source: AMrXdXueZQYUYTkrLM9RIEgNkX+Pn/A3Hm5b7Z28AkOIAGv3E2yrhlD35pXGHe60Im+X8a+Ga3ZG1w==
X-Received: by 2002:a05:600c:1d8e:b0:3d9:f9ef:3d23 with SMTP id p14-20020a05600c1d8e00b003d9f9ef3d23mr11412826wms.23.1674149667235;
        Thu, 19 Jan 2023 09:34:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x23-20020a1c7c17000000b003d974076f13sm5279074wmc.3.2023.01.19.09.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:34:26 -0800 (PST)
Message-Id: <pull.1458.v2.git.1674149666.gitgitgadget@gmail.com>
In-Reply-To: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
References: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Jan 2023 17:34:23 +0000
Subject: [PATCH v2 0/2] ls-files: add %(skipworktree) atom to format option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a %(skipworktree) atom git ls-files --format to indicate whether the
file in the index match the sparse specification.

v1: add %(skipworktree) atom to git ls-files format option. v2:

 1. no longer mentioned git ls-files -t.
 2. change %(skipworktree) output from "true"/"false" to "1"/"".
 3. fix the sparse-checkout docs link.

ZheNing Hu (2):
  docs: fix sparse-checkout docs link
  ls-files: add %(skipworktree) atom to format option

 Documentation/Makefile                      |  1 +
 Documentation/git-ls-files.txt              |  5 +++
 Documentation/technical/sparse-checkout.txt | 43 ++++++++++++++-------
 builtin/ls-files.c                          |  3 ++
 t/t3013-ls-files-format.sh                  | 23 +++++++++++
 5 files changed, 61 insertions(+), 14 deletions(-)


base-commit: a7caae2729742fc80147bca1c02ae848cb55921a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1458%2Fadlternative%2Fzh%2Fls-file-format-skipworktree-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1458/adlternative/zh/ls-file-format-skipworktree-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1458

Range-diff vs v1:

 -:  ----------- > 1:  cde4827da13 docs: fix sparse-checkout docs link
 1:  c4cd5b3a32f ! 2:  9ebd6b77a69 ls-files: add %(skipworktree) atom to format option
     @@ Commit message
          ls-files: add %(skipworktree) atom to format option
      
          Because sometimes we want to check if the files in the
     -    index match the sparse specification by using
     -    `git ls-files -t`, but `-t` option have semi-deprecated,
     -
     -    So introduce "%(skipworktree)" atom to git ls-files
     -    `--format` option. When we use this option, if the file
     -    match the sparse specification and removed from working
     -    tree, it will output "yes", othewise, output "no".
     +    index match the sparse specification, so introduce
     +    "%(skipworktree)" atom to git ls-files `--format` option.
     +    When we use this option, if the file match the sparse
     +    specification, it will output "1", otherwise, output
     +    empty string "".
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
     @@ Documentation/git-ls-files.txt: eolattr::
       	The pathname of the file which is recorded in the index.
      +skipworktree::
      +	If the file in the index marked with SKIP_WORKTREE bit.
     -+	It means the file do not match the sparse specification
     -+	and removed from working tree.
     ++	It means the file do not match the sparse specification.
      +	See link:technical/sparse-checkout.txt[sparse-checkout]
      +	for more information.
       
     @@ builtin/ls-files.c: static size_t expand_show_index(struct strbuf *sb, const cha
       		write_name_to_buf(sb, data->pathname);
      +	else if (skip_prefix(start, "(skipworktree)", &p))
      +		strbuf_addstr(sb, ce_skip_worktree(data->ce) ?
     -+			      "true" : "false");
     ++			      "1" : "");
       	else
       		die(_("bad ls-files format: %%%.*s"), (int)len, start);
       
     @@ t/t3013-ls-files-format.sh: test_expect_success 'git ls-files --format with --de
       '
       
      +test_expect_success 'git ls-files --format with skipworktree' '
     ++	test_when_finished "git sparse-checkout disable" &&
      +	mkdir dir1 dir2 &&
      +	echo "file1" >dir1/file1.txt &&
      +	echo "file2" >dir2/file2.txt &&
      +	git add dir1 dir2 &&
      +	git commit -m skipworktree &&
      +	git sparse-checkout set dir1 &&
     -+	git ls-files --format="%(path) %(skipworktree)" >actual &&
     ++	git ls-files --format="%(path)%(skipworktree)" >actual &&
      +	cat >expect <<-\EOF &&
     -+	dir1/file1.txt false
     -+	dir2/file2.txt true
     -+	o1.txt false
     -+	o2.txt false
     -+	o3.txt false
     -+	o4.txt false
     -+	o5.txt false
     -+	o6.txt false
     -+	o7.txt false
     ++	dir1/file1.txt
     ++	dir2/file2.txt1
     ++	o1.txt
     ++	o2.txt
     ++	o3.txt
     ++	o4.txt
     ++	o5.txt
     ++	o6.txt
     ++	o7.txt
      +	EOF
      +	test_cmp expect actual
      +'

-- 
gitgitgadget
