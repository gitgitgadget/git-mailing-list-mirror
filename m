Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D724AC07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 21:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiIZVzx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 17:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiIZVzw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 17:55:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695ACA404F
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 14:55:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c11so12190461wrp.11
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 14:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=pbVFSLzVeWQ0uCIJMrLQxuUHggjPSIelc7wSxZbeiiU=;
        b=U0bRSjzE8FRc3HxXeP5dApARCzck8dsPyFxy5Qqed2yFlv5sKQH37ag3U98iofofHd
         mpAv0PTcglOhdNDumXVhBExYlG2ZkHr7lsukgH97yNhkf3iGZfqQt5Xlsp5ONof1J+CW
         lCyLaD/W9i8QebC1xFIk5QMNhwTQt1JaU+IvwPbkwX3PuaFoyxNk3GmWI5p3B38yX9vQ
         cPg+xsoooSdHriV8UHwSSEqQ1tkTh3arLxyVSQJ/LpdB6o5vCjAtz1RblXVEbbX7VSkf
         hBBTQi2btX0QBaNGuwTHKJTN99SOQKF2EM9CobvC178iJZgTi6tWhyKbn+MRMLEXkV7F
         6z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pbVFSLzVeWQ0uCIJMrLQxuUHggjPSIelc7wSxZbeiiU=;
        b=SRInh9vOmuxIXsGYIeK2llrQnLM/ivQd8j7wh/iWOSpiDRCJY/jjvAvLEZuCnPEbkg
         aV2g3PK2ZGHO/Vm7Wqkcs5R1cXICg3K79BeduMSIcW/KmCfCV4kK/qtN4F9FQ2xcsEV/
         SlLjq+nPIwls7zSzloWWQrcaKabGEW8OwcW8fvVXieIUug/nktUgPZ1Nmu55dNbwKUkS
         xsWeMIJKQSL36uHlyZbITAqlBXSJa/ky462suIVv5xFWHhJ6vEEfhXZz0TvSaNiMYEMk
         rEV8x9z1SCuoRPTv+SjyIe6wv7oonxDgNxl7gEy7nZCLy71tc8oQsz+u6Vj72KQp5lXD
         0qYg==
X-Gm-Message-State: ACrzQf35BPbgotWAC3w+06i3EecnEISpuoahkeTH11APHmd9DhSB3Xh0
        f1CRJC2EjgQAVhTS4JsgxZvGyoOZGLg=
X-Google-Smtp-Source: AMsMyM5DRphdVu8SBCZ4+dZdO5pZnWRH1CXbkKn+xgQ9zEcqioHZ3Wucg+QqUys90AcAVnYHU3WY4A==
X-Received: by 2002:a5d:6d09:0:b0:228:d897:af3c with SMTP id e9-20020a5d6d09000000b00228d897af3cmr15193347wrq.78.1664229349619;
        Mon, 26 Sep 2022 14:55:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t2-20020adfe102000000b0022917d58603sm15693957wrz.32.2022.09.26.14.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 14:55:49 -0700 (PDT)
Message-Id: <pull.1362.v4.git.1664229348.gitgitgadget@gmail.com>
In-Reply-To: <pull.1362.v3.git.1663875999939.gitgitgadget@gmail.com>
References: <pull.1362.v3.git.1663875999939.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Sep 2022 21:55:46 +0000
Subject: [PATCH v4 0/2] merge-tree: fix segmentation fault in read-only repositories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turns out that the segmentation fault reported by Taylor
[https://lore.kernel.org/git/YyopQD+LvPucnz3w@nand.local/] happened while
testing merge-ort in a read-only repository, and that the upstream version
of git merge-tree is as affected as GitHub's internal version.

Changes since v3:

 * I now consistently use the pattern int ret = 0; ... if (...) ret = -1.
 * I added a commit to properly propagate write failures through the
   handle_content_merge() call path, even if it is not really critical (it
   just fails sooner, but the merge would have failed just the same without
   this patch).

Changes since v2:

 * Completely changed the approach by no longer touching
   builtin/merge-tree.c but instead fixing the underlying merge-ort layer:
   we no longer ignore the return value of write_tree() and
   write_object_file().

Changes since v1:

 * Using the SANITY prereq now
 * If the merge was aborted due to a write error, exit with a non-zero code
   even if the (potentially partial) merge is clean
 * The test case now also verifies that the git merge-tree command fails in
   a read-only repository even if the merge would have succeeded

Johannes Schindelin (2):
  merge-ort: fix segmentation fault in read-only repositories
  merge-ort: return early when failing to write a blob

 merge-ort.c                      | 94 ++++++++++++++++++++------------
 t/t4301-merge-tree-write-tree.sh |  9 +++
 2 files changed, 69 insertions(+), 34 deletions(-)


base-commit: dda7228a83e2e9ff584bf6adbf55910565b41e14
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1362%2Fdscho%2Fmerge-tree-in-read-only-repos-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1362/dscho/merge-tree-in-read-only-repos-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1362

Range-diff vs v3:

 1:  198ff455f90 ! 1:  ab6df092eba merge-ort: fix segmentation fault in read-only repositories
     @@ merge-ort.c: static int tree_entry_order(const void *a_, const void *b_)
       	unsigned int nr;
       	struct strbuf buf = STRBUF_INIT;
      -	int i;
     -+	int i, ret;
     ++	int i, ret = 0;
       
       	assert(offset <= versions->nr);
       	nr = versions->nr - offset;
     @@ merge-ort.c: static void write_tree(struct object_id *result_oid,
       
       	/* Write this object file out, and record in result_oid */
      -	write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid);
     -+	ret = write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid);
     ++	if (write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid))
     ++		ret = -1;
       	strbuf_release(&buf);
      +	return ret;
       }
     @@ merge-ort.c: static void process_entries(struct merge_options *opt,
       	struct directory_versions dir_metadata = { STRING_LIST_INIT_NODUP,
       						   STRING_LIST_INIT_NODUP,
       						   NULL, 0 };
     -+	int ret;
     ++	int ret = 0;
       
       	trace2_region_enter("merge", "process_entries setup", opt->repo);
       	if (strmap_empty(&opt->priv->paths)) {
     @@ merge-ort.c: static void process_entries(struct merge_options *opt,
       	}
      -	write_tree(result_oid, &dir_metadata.versions, 0,
      -		   opt->repo->hash_algo->rawsz);
     -+	ret = write_tree(result_oid, &dir_metadata.versions, 0,
     -+			 opt->repo->hash_algo->rawsz);
     ++	if (write_tree(result_oid, &dir_metadata.versions, 0,
     ++		       opt->repo->hash_algo->rawsz) < 0)
     ++		ret = -1;
      +cleanup:
       	string_list_clear(&plist, 0);
       	string_list_clear(&dir_metadata.versions, 0);
 -:  ----------- > 2:  087207ae0b0 merge-ort: return early when failing to write a blob

-- 
gitgitgadget
