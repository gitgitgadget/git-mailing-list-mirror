Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFCDC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 13:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJQNeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJQNeW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 09:34:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2129F11A
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:34:19 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r14so16065226edc.7
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Am0QZ8H1HMy87/2sBW4szj7udwqOCMtiWGbK9gVh2iQ=;
        b=Gt7sOx/FiDZO3oRwwT32CLBBeoB6s38ErDQSwQJBO5YAMpFa32nzJtwIFJk7bq0593
         h49I3Gbi9xy/Rwre1OgCl1t+f1FzVzbLEVLs7G4p3vXVmzQHhQbGHfnqv3yAaar16Q+I
         PA0K56aKg6iKmT/2RU0SLwJhcHdUjmIn6H+GUe/bTRzpxPFLocutAPQ+JkPqmLtXMRbP
         xCxCeuu3wIM5wJj/pyv6831sJbl9keC6DMdeo43svH/we6xu8X0XAXz3a+qVvdWiuaeW
         HLvVyPzngKU2o9FaF0N2g348grxct9aFUi5lWMslld1gWdouIJrNNvHIlWLliJfYOGz3
         94wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Am0QZ8H1HMy87/2sBW4szj7udwqOCMtiWGbK9gVh2iQ=;
        b=qns6NZNhRs/QIM5D8UVqq65wb2RpTDvqvakmbUgnOsZ+ujHF8K54xNsWMquum+e/W8
         O8tbZVoKMFSJfzn5eJYMFruhActKNDwfuduo5xzG4fgqZDQs3GHo+2+RdlljeCvU0Ql5
         yLEc7SjHhiJCPCR5bC3jqcS/4F+z34pJGqUUyzf/P02l3WqkiW5NfRNstR3EwQzewLxi
         6+e+aJgrRFFd92pFwa0QUFMj5VT0HOOXsNR71RcrrWreKaPTnSCRKS5pCSm2e4P5ms/r
         DIGpXhFImyE1Sb25IA5IFXML4FD4rUaqvijgh5XisRt84Xd+Qo692OEgEh05/o18VR0e
         /8Yw==
X-Gm-Message-State: ACrzQf1TFPmIll3+/f965Yjr5nAT6Vff8Ye8qR5EPSVkDpQSBS+tAQ/8
        mFecsmA65BGdYaBtjHRFW4c=
X-Google-Smtp-Source: AMsMyM4pkrwSN7EnvS0vuSKWQAlSAeKhDSpgNDifu9GOIeYW0DbF2IBh4LiDaiTNI2xqL/McA/qLJg==
X-Received: by 2002:a05:6402:5291:b0:45c:3f6a:d4bc with SMTP id en17-20020a056402529100b0045c3f6ad4bcmr10262842edb.285.1666013657594;
        Mon, 17 Oct 2022 06:34:17 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id p11-20020a170906604b00b0078df3b4464fsm6303853ejj.19.2022.10.17.06.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 06:34:17 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <b8e2be95-0d42-aaae-4d9f-1825b62707ba@dunelm.org.uk>
Date:   Mon, 17 Oct 2022 14:34:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 3/9] tree: increase test coverage for tree.c
Content-Language: en-US
To:     Heather Lapointe via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
 <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
 <9a07c6932f4c7ef844df1fc4f5b6b9feb1810135.1665973401.git.gitgitgadget@gmail.com>
In-Reply-To: <9a07c6932f4c7ef844df1fc4f5b6b9feb1810135.1665973401.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Heather

On 17/10/2022 03:23, Heather Lapointe via GitGitGadget wrote:
> From: Heather Lapointe <alpha@alphaservcomputing.solutions>
> 
> This highlights some buggy behavior from read_tree for submodules that
> was not being executed.

The commit message should explain the reason behind the change being 
made. In this case it would be helpful to give an overview of what the 
bug is you're testing for. Given the description I was expecting to see 
some failing tests that are fixed by a later patch but that doesn't seem 
to be the case, so I'm wondering what these tests do.

> This introduces a test-tool tree-read-tree-at command
> (the complex name is because it is not related to the read-tree command).

It would also be helpful to explain why we cannot reproduce the bug with 
"git read-tree --recurse-submodules"

Best Wishes

Phillip

> Signed-off-by: Heather Lapointe <alpha@alphaservcomputing.solutions>
> ---
>   Makefile                          |  1 +
>   t/helper/test-tool.c              |  1 +
>   t/helper/test-tool.h              |  1 +
>   t/helper/test-tree-read-tree-at.c | 40 +++++++++++++++++++
>   t/t1023-tree-read-tree-at.sh      | 65 +++++++++++++++++++++++++++++++
>   5 files changed, 108 insertions(+)
>   create mode 100644 t/helper/test-tree-read-tree-at.c
>   create mode 100755 t/t1023-tree-read-tree-at.sh
> 
> diff --git a/Makefile b/Makefile
> index 6bfb62cbe94..52d17ca7276 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -788,6 +788,7 @@ TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
>   TEST_BUILTINS_OBJS += test-submodule.o
>   TEST_BUILTINS_OBJS += test-subprocess.o
>   TEST_BUILTINS_OBJS += test-trace2.o
> +TEST_BUILTINS_OBJS += test-tree-read-tree-at.o
>   TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
>   TEST_BUILTINS_OBJS += test-userdiff.o
>   TEST_BUILTINS_OBJS += test-wildmatch.o
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index d1d013bcd92..a8a9bedec5f 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -82,6 +82,7 @@ static struct test_cmd cmds[] = {
>   	{ "submodule-nested-repo-config", cmd__submodule_nested_repo_config },
>   	{ "subprocess", cmd__subprocess },
>   	{ "trace2", cmd__trace2 },
> +	{ "tree-read-tree-at", cmd__tree_read_tree_at },
>   	{ "userdiff", cmd__userdiff },
>   	{ "urlmatch-normalization", cmd__urlmatch_normalization },
>   	{ "xml-encode", cmd__xml_encode },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index 6b46b6444b6..409fddfaeb8 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -76,6 +76,7 @@ int cmd__submodule_config(int argc, const char **argv);
>   int cmd__submodule_nested_repo_config(int argc, const char **argv);
>   int cmd__subprocess(int argc, const char **argv);
>   int cmd__trace2(int argc, const char **argv);
> +int cmd__tree_read_tree_at(int argc, const char **argv);
>   int cmd__userdiff(int argc, const char **argv);
>   int cmd__urlmatch_normalization(int argc, const char **argv);
>   int cmd__xml_encode(int argc, const char **argv);
> diff --git a/t/helper/test-tree-read-tree-at.c b/t/helper/test-tree-read-tree-at.c
> new file mode 100644
> index 00000000000..bba759bb264
> --- /dev/null
> +++ b/t/helper/test-tree-read-tree-at.c
> @@ -0,0 +1,40 @@
> +/* This tests tree.c's read_tree / read_tree_at.
> +We call it tree-read-tree-at to disambiguate with the read-tree tool.
> +*/
> +#include "cache.h"
> +#include "pathspec.h"
> +#include "test-tool.h"
> +#include "tree.h"
> +
> +static int test_handle_entry(const struct object_id *oid,
> +		struct strbuf *base, const char *filename,
> +		unsigned mode, void *context UNUSED) {
> +	printf("%i %s %s%s\n", mode, oid_to_hex(oid), base->buf, filename);
> +	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
> +		return READ_TREE_RECURSIVE;
> +	}
> +	return 0;
> +}
> +
> +int cmd__tree_read_tree_at(int argc UNUSED, const char **argv)
> +{
> +	struct pathspec pathspec;
> +	struct tree *tree;
> +	struct repository *repo;
> +	struct object_id oid;
> +
> +	setup_git_directory();
> +	repo = the_repository;
> +	assert(repo);
> +
> +	parse_pathspec(&pathspec, 0,
> +		       PATHSPEC_PREFER_FULL,
> +		       "", argv);
> +
> +	assert(repo_get_oid(repo, "HEAD", &oid) == 0);
> +	tree = repo_parse_tree_indirect(repo, &oid);
> +	assert(tree);
> +	pathspec.recurse_submodules = 1;
> +	read_tree(repo, tree, &pathspec, test_handle_entry, NULL);
> +	return 0;
> +}
> diff --git a/t/t1023-tree-read-tree-at.sh b/t/t1023-tree-read-tree-at.sh
> new file mode 100755
> index 00000000000..9e5ce3abb4b
> --- /dev/null
> +++ b/t/t1023-tree-read-tree-at.sh
> @@ -0,0 +1,65 @@
> +#!/bin/sh
> +
> +# tests for tree.c (not read-tree.c)
> +test_description='Test read_tree / read_tree_at'
> +. ./test-lib.sh
> +
> +test_expect_success 'read_tree basic' '
> +	rm -rf walk_tree_basic &&
> +	git init walk_tree_basic &&
> +	(
> +		cd walk_tree_basic &&
> +		set -x &&
> +
> +		mkdir -p dir1/dirA &&
> +		mkdir -p dir1/dirB &&
> +		mkdir -p dir2 &&
> +		echo "file1" > file1.txt &&
> +		echo "file2" > file2.txt &&
> +		# uncommitted
> +		echo "file3" > file3.txt &&
> +
> +		echo "file1A1" > dir1/dirA/file1.txt &&
> +		git add file1.txt file2.txt dir1/dirA/file1.txt &&
> +		git commit -m "initial commit" &&
> +
> +		test-tool tree-read-tree-at . > walk1.txt &&
> +		grep " file1.txt" walk1.txt &&
> +		! grep " file3.txt" walk1.txt &&
> +		! grep " dir1/dirB" walk1.txt &&
> +		grep " dir1/dirA/file1.txt" walk1.txt
> +	)
> +'
> +
> +test_expect_success 'read_tree submodules' '
> +	rm -rf walk_tree_submodules &&
> +	git init submodule1 &&
> +	(
> +		cd submodule1 &&
> +		mkdir -p dir1/dirA &&
> +		echo "dir2/sub1/file1.txt" > file1.txt &&
> +		echo "dir2/sub1/file1A1.txt" > dir1/dirA/file1.txt &&
> +		git add file1.txt dir1/dirA/file1.txt &&
> +		git commit -m "initial commit"
> +	) &&
> +	git init walk_tree_submodules &&
> +	(
> +		cd walk_tree_submodules &&
> +
> +		mkdir -p dir2 &&
> +		echo "file1" > file1.txt &&
> +		echo "dir2/file2" > dir2/file2.txt &&
> +		git add file1.txt dir2/file2.txt &&
> +		git commit -m "initial commit" &&
> +
> +		git submodule add ../submodule1 dir2/sub1 &&
> +		git commit -m "add submodule1" &&
> +
> +		test-tool tree-read-tree-at . > walk2.txt &&
> +		grep " file1.txt" walk2.txt &&
> +		grep " dir2/sub1/file1.txt" walk2.txt &&
> +		grep " dir2/sub1/dir1/dirA/file1.txt" walk2.txt
> +	)
> +'
> +
> +test_done
