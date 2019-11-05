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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4A81F454
	for <e@80x24.org>; Tue,  5 Nov 2019 15:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389706AbfKEP12 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 10:27:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39871 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfKEP12 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 10:27:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id a11so21871194wra.6
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 07:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kUYe3Bk4FNebzYQ5GOCWkCRygPd2Uu92nCGJ3Emtx1Q=;
        b=WEbSgLQ12h4RvAkHH6JPWZIfK9S7kbj1viRc1njbtdyE6RUL/+MEybvJRZlteL8/hL
         xvNhTJtUEWmddMFvwhrhPV1YQUwGcfJFbnqAjrx07HQwMyXbGJCtW0sKAIoM9tRVvK7C
         RVE6DDGv8KYLGRYvwq/C7W65Ud8SCvTKGVg0G35pURmSysFT1Upm3PpwJcch/XlhAfa0
         /U+tr4ARvFC7RYJguM4fcX1s3feMAfH+6Tg8H91fUrpNIKrGTA3Oz1Q7NFpd3+64HnnJ
         OofNczF6pnqQjwyFq8PvmwmuPbLyvu2UyfGDFbf9ghIY6Ea1BkBoJssrBOitgynwC4Zp
         6dGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kUYe3Bk4FNebzYQ5GOCWkCRygPd2Uu92nCGJ3Emtx1Q=;
        b=BDqR9gI77Y7HqDEeh5gTOwxJbUFBgRtYxwmBNaT3RgiYSwLgVzOZGVsNNh8zTmt6x5
         G58gKI6QrCrnNfkOHAMQjM2c1u2XJAQbiPF1lLf93zjdPdB0KnZ4/EJwwwKNsCf56xb2
         MNTCcEhLNmyeLlx/pUFV0BayRn6/DihDLgSvnMCGmv+CyQYbeH7P/TkRwM9wIgoJmjRO
         Czk89MRceKkzPCL5Frr+Q5P69/6sf4PxbnmzsEw6G0Aa2UMz/+iTtK9rS41/t21KGp5c
         fBkT/4cczNvFbeOJ6DHKeaUCS51No/QhbyQu20459Ld0GoSZMFCjNIIvpq66P0h45vQ+
         hqMQ==
X-Gm-Message-State: APjAAAWPZTNW4lbk7g5jYqwrEzRgk3gN06UFoXtTsGOGILhKWxvZEQI0
        6h1caNhGO0qbboc8JBXroTAM27x6
X-Google-Smtp-Source: APXvYqwM7MLUcqZcow8Z16YNsg5v48fCVvR3plZpcqMxlupI22vNIpQOcqsOQsCiS8GS0uUPWrmEbA==
X-Received: by 2002:a5d:6104:: with SMTP id v4mr27319121wrt.36.1572967645412;
        Tue, 05 Nov 2019 07:27:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e15sm20389413wrx.58.2019.11.05.07.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 07:27:24 -0800 (PST)
Message-Id: <pull.424.v2.git.1572967644.gitgitgadget@gmail.com>
In-Reply-To: <pull.424.git.1572017008.gitgitgadget@gmail.com>
References: <pull.424.git.1572017008.gitgitgadget@gmail.com>
From:   "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 15:27:22 +0000
Subject: [PATCH v2 0/1] unpack-trees: skip stat on fsmonitor-valid files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Utsav Shah <ukshah2@illinois.edu>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The index might be aware that a file hasn't modified via fsmonitor, but
unpack-trees did not pay attention to it and checked via ie_match_stat which
can be inefficient on certain filesystems. This significantly slows down
commands that run oneway_merge, like checkout and reset --hard.

This patch makes oneway_merge check whether a file is considered unchanged
through fsmonitor and skips ie_match_stat on it. unpack-trees also now
correctly copies over fsmonitor validity state from the source index.
Finally, for correctness, we force a refresh of fsmonitor state in
tweak_fsmonitor.

After this change, commands like stash (that use reset --hard internally) go
from 8s or more to ~2s on a 250k file repository on a mac.

Signed-off-by: Utsav Shah utsav@dropbox.com [utsav@dropbox.com]

Utsav Shah (1):
  unpack-trees: skip stat on fsmonitor-valid files

 fsmonitor.c                       | 20 +++++++++++---------
 t/t7113-post-index-change-hook.sh |  3 ---
 t/t7519-status-fsmonitor.sh       |  9 +++++++--
 unpack-trees.c                    |  6 +++++-
 4 files changed, 23 insertions(+), 15 deletions(-)


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-424%2FUtsav2%2Fskip-lstat-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-424/Utsav2/skip-lstat-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/424

Range-diff vs v1:

 1:  609c7c5047 ! 1:  f76ba554ed unpack-trees: skip lstat based on fsmonitor
     @@ -1,24 +1,147 @@
      Author: Utsav Shah <utsav@dropbox.com>
      
     -    unpack-trees: skip lstat based on fsmonitor
     +    unpack-trees: skip stat on fsmonitor-valid files
      
     -    git stash runs git reset --hard as its final step, which can be fairly slow on a large repository.
     -    This change lets us skip that if fsmonitor thinks those files aren't modified.
     +    The index might be aware that a file hasn't modified via fsmonitor, but
     +    unpack-trees did not pay attention to it and checked via ie_match_stat
     +    which can be inefficient on certain filesystems. This significantly slows
     +    down commands that run oneway_merge, like checkout and reset --hard.
      
     -    git stash goes from ~8s -> 2s on my repository after this change.
     +    This patch makes oneway_merge check whether a file is considered
     +    unchanged through fsmonitor and skips ie_match_stat on it. unpack-trees
     +    also now correctly copies over fsmonitor validity state from the source
     +    index. Finally, for correctness, we force a refresh of fsmonitor state in
     +    tweak_fsmonitor.
     +
     +    After this change, commands like stash (that use reset --hard
     +    internally) go from 8s or more to ~2s on a 250k file repository on a
     +    mac.
      
          Signed-off-by: Utsav Shah <utsav@dropbox.com>
      
     + diff --git a/fsmonitor.c b/fsmonitor.c
     + --- a/fsmonitor.c
     + +++ b/fsmonitor.c
     +@@
     + 	}
     + 	istate->fsmonitor_dirty = fsmonitor_dirty;
     + 
     +-	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
     +-		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
     +-		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
     ++	if (!istate->split_index && istate->fsmonitor_dirty->bit_size > istate->cache_nr)
     ++		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
     ++		    (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
     ++
     + 
     + 	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
     + 	return 0;
     +@@
     + 	uint32_t ewah_size = 0;
     + 	int fixup = 0;
     + 
     +-	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
     +-		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
     +-		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
     ++	if (!istate->split_index && istate->fsmonitor_dirty->bit_size > istate->cache_nr)
     ++		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
     ++		    (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
     + 
     + 	put_be32(&hdr_version, INDEX_EXTENSION_VERSION);
     + 	strbuf_add(sb, &hdr_version, sizeof(uint32_t));
     +@@
     + 		}
     + 		if (bol < query_result.len)
     + 			fsmonitor_refresh_callback(istate, buf + bol);
     ++
     ++		if (istate->untracked)
     ++			istate->untracked->use_fsmonitor = 1;
     + 	} else {
     + 		/* Mark all entries invalid */
     + 		for (i = 0; i < istate->cache_nr; i++)
     +@@
     + 				    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
     + 			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
     + 
     +-			/* Now mark the untracked cache for fsmonitor usage */
     +-			if (istate->untracked)
     +-				istate->untracked->use_fsmonitor = 1;
     ++			refresh_fsmonitor(istate);
     + 		}
     + 
     + 		ewah_free(istate->fsmonitor_dirty);
     +
     + diff --git a/t/t7113-post-index-change-hook.sh b/t/t7113-post-index-change-hook.sh
     + --- a/t/t7113-post-index-change-hook.sh
     + +++ b/t/t7113-post-index-change-hook.sh
     +@@
     + 	git checkout -- dir1/file1.txt &&
     + 	test_path_is_file testsuccess && rm -f testsuccess &&
     + 	test_path_is_missing testfailure &&
     +-	git update-index &&
     +-	test_path_is_missing testsuccess &&
     +-	test_path_is_missing testfailure &&
     + 	git reset --soft &&
     + 	test_path_is_missing testsuccess &&
     + 	test_path_is_missing testfailure
     +
     + diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
     + --- a/t/t7519-status-fsmonitor.sh
     + +++ b/t/t7519-status-fsmonitor.sh
     +@@
     + 
     + # test that "update-index --fsmonitor-valid" sets the fsmonitor valid bit
     + test_expect_success 'update-index --fsmonitor-valid" sets the fsmonitor valid bit' '
     ++	write_script .git/hooks/fsmonitor-test<<-\EOF &&
     ++	EOF
     + 	git update-index --fsmonitor &&
     + 	git update-index --fsmonitor-valid dir1/modified &&
     + 	git update-index --fsmonitor-valid dir2/modified &&
     +@@
     + 
     + # test that newly added files are marked valid
     + test_expect_success 'newly added files are marked valid' '
     ++	write_script .git/hooks/fsmonitor-test<<-\EOF &&
     ++	EOF
     + 	git add new &&
     + 	git add dir1/new &&
     + 	git add dir2/new &&
     +@@
     + # Ensure commands that call refresh_index() to move the index back in time
     + # properly invalidate the fsmonitor cache
     + test_expect_success 'refresh_index() invalidates fsmonitor cache' '
     +-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
     +-	EOF
     + 	clean_repo &&
     ++	write_integration_script &&
     + 	dirty_repo &&
     + 	git add . &&
     ++	write_script .git/hooks/fsmonitor-test<<-\EOF &&
     ++	EOF
     + 	git commit -m "to reset" &&
     + 	git reset HEAD~1 &&
     + 	git status >actual &&
     +
       diff --git a/unpack-trees.c b/unpack-trees.c
       --- a/unpack-trees.c
       +++ b/unpack-trees.c
      @@
     + 	o->merge_size = len;
     + 	mark_all_ce_unused(o->src_index);
     + 
     ++	if (o->src_index->fsmonitor_last_update)
     ++		o->result.fsmonitor_last_update = o->src_index->fsmonitor_last_update;
     ++
     + 	/*
     + 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
     + 	 */
     +@@
       
       	if (old && same(old, a)) {
       		int update = 0;
      -		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old)) {
      +		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old) &&
     -+		    !(old->ce_flags & CE_FSMONITOR_VALID)) {
     ++			!(old->ce_flags & CE_FSMONITOR_VALID)) {
       			struct stat st;
       			if (lstat(old->name, &st) ||
       			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))

-- 
gitgitgadget
