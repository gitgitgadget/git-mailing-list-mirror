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
	by dcvr.yhbt.net (Postfix) with ESMTP id DA7551F454
	for <e@80x24.org>; Wed,  6 Nov 2019 04:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbfKFEyU (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 23:54:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41111 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfKFEyT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 23:54:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so24088821wrm.8
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 20:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=buchIvQHyRehdpHtX5rv0hPfVngWLulOZGC5CIQKcLw=;
        b=aPwLmQHfBFju7ubyWUJjxQRE2QTNIQVBZFCKgzMkqHwIrVIuhgWZaIoxNO/6Smkwu1
         nCuF9fXwtW1qPZkfXtmiU91r5M2LP93JcU85MA7NPe2+StYlf+6s9KTADZxerEfhUCjL
         NFlJfL5JUsG19uAPpAewd0U3EpcBxOFODiXg9GnqD4FU3YBweATn5XiSkKUJtd2RwMAr
         F+RbE4gQ1CQJ9qGLs15VoD7+WInjdV+UA66Scsi2fgx2tQ3lQWCuXTrb8dewx1+33O/A
         Z83ryshGZn4ljjEOlTYCB7HUzDQHMLw+dIixMtLAjYg+gI2AL69aupIQRKL3cNizWpkv
         Zk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=buchIvQHyRehdpHtX5rv0hPfVngWLulOZGC5CIQKcLw=;
        b=k6VABY8hUDUMZfK2SKK/u0WSBR2Ced2LVVyNoze/kXc2Hdn/L1DR0pnLjBJKCURQ/1
         BpcFOyqimDqtZpd7apm7OxTWre2INFqGNsPLIIJbudCrv2txfX6nLhKUH3Qp51YzjguG
         APLTZ0sVd9iCb8APT9JOVm9O+J2ntDTREBwYtzPha+a2M1h1Yq6q33j3wNqpH4d/RMdo
         TUrsGz1rzjEVJ7vmppcpRBui/bstK6lWzXhBuC8SUhf5r0R3HAjzDBR8aky+2/i6fyDb
         0HtmNG0n6tt3ZVHmO7AzKtcQ8Nsck/hqlIy2qKR65a4GDijT4Uyxph/Nfuj6sxicGWwE
         FWHg==
X-Gm-Message-State: APjAAAXNF4hU3wQDw55XuuSrIlnJF62IpIzy+3jV8ce0tuXTWpEUqXcl
        nalZlSKVfRamoooyHQGYm/WcUToV
X-Google-Smtp-Source: APXvYqyvxA2fadd1Fs4V4ssW7ons9tMypBu7xksz5DWO3tdeagxEQgVl+FnfTiPR2iGAZMI01Kfs1w==
X-Received: by 2002:adf:e585:: with SMTP id l5mr704047wrm.156.1573016056699;
        Tue, 05 Nov 2019 20:54:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d11sm27530541wrf.80.2019.11.05.20.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 20:54:16 -0800 (PST)
Message-Id: <pull.424.v3.git.1573016055.gitgitgadget@gmail.com>
In-Reply-To: <pull.424.v2.git.1572967644.gitgitgadget@gmail.com>
References: <pull.424.v2.git.1572967644.gitgitgadget@gmail.com>
From:   "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 04:54:14 +0000
Subject: [PATCH v3 0/1] unpack-trees: skip stat on fsmonitor-valid files
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

 fsmonitor.c                 | 39 ++++++++++++++++++++++++-------------
 t/t7519-status-fsmonitor.sh |  9 +++++++--
 unpack-trees.c              |  6 +++++-
 3 files changed, 37 insertions(+), 17 deletions(-)


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-424%2FUtsav2%2Fskip-lstat-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-424/Utsav2/skip-lstat-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/424

Range-diff vs v2:

 1:  f76ba554ed ! 1:  4bea7075cf unpack-trees: skip stat on fsmonitor-valid files
     @@ -23,6 +23,15 @@
       --- a/fsmonitor.c
       +++ b/fsmonitor.c
      @@
     + 
     + 	if (pos >= istate->cache_nr)
     + 		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" >= %u)",
     +-		    (uintmax_t)pos, istate->cache_nr);
     ++			(uintmax_t)pos, istate->cache_nr);
     + 
     + 	ce = istate->cache[pos];
     + 	ce->ce_flags &= ~CE_FSMONITOR_VALID;
     +@@
       	}
       	istate->fsmonitor_dirty = fsmonitor_dirty;
       
     @@ -31,7 +40,7 @@
      -		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
      +	if (!istate->split_index && istate->fsmonitor_dirty->bit_size > istate->cache_nr)
      +		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
     -+		    (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
     ++			(uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
      +
       
       	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
     @@ -45,7 +54,7 @@
      -		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
      +	if (!istate->split_index && istate->fsmonitor_dirty->bit_size > istate->cache_nr)
      +		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
     -+		    (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
     ++			(uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
       
       	put_be32(&hdr_version, INDEX_EXTENSION_VERSION);
       	strbuf_add(sb, &hdr_version, sizeof(uint32_t));
     @@ -57,10 +66,33 @@
      +		if (istate->untracked)
      +			istate->untracked->use_fsmonitor = 1;
       	} else {
     ++
     ++		/* We only want to run the post index changed hook if we've actually changed entries, so keep track
     ++		 * if we actually changed entries or not */
     ++		int is_cache_changed = 0;
       		/* Mark all entries invalid */
     - 		for (i = 0; i < istate->cache_nr; i++)
     +-		for (i = 0; i < istate->cache_nr; i++)
     +-			istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
     ++		for (i = 0; i < istate->cache_nr; i++) {
     ++			if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) {
     ++				is_cache_changed = 1;
     ++				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
     ++			}
     ++		}
     + 
     + 		/* If we're going to check every file, ensure we save the results */
     +-		istate->cache_changed |= FSMONITOR_CHANGED;
     ++		if (is_cache_changed)
     ++			istate->cache_changed |= FSMONITOR_CHANGED;
     + 
     + 		if (istate->untracked)
     + 			istate->untracked->use_fsmonitor = 0;
      @@
     - 				    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
     + 			/* Mark all previously saved entries as dirty */
     + 			if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
     + 				BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
     +-				    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
     ++					(uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
       			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
       
      -			/* Now mark the untracked cache for fsmonitor usage */
     @@ -71,20 +103,6 @@
       
       		ewah_free(istate->fsmonitor_dirty);
      
     - diff --git a/t/t7113-post-index-change-hook.sh b/t/t7113-post-index-change-hook.sh
     - --- a/t/t7113-post-index-change-hook.sh
     - +++ b/t/t7113-post-index-change-hook.sh
     -@@
     - 	git checkout -- dir1/file1.txt &&
     - 	test_path_is_file testsuccess && rm -f testsuccess &&
     - 	test_path_is_missing testfailure &&
     --	git update-index &&
     --	test_path_is_missing testsuccess &&
     --	test_path_is_missing testfailure &&
     - 	git reset --soft &&
     - 	test_path_is_missing testsuccess &&
     - 	test_path_is_missing testfailure
     -
       diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
       --- a/t/t7519-status-fsmonitor.sh
       +++ b/t/t7519-status-fsmonitor.sh
     @@ -113,8 +131,8 @@
      -	write_script .git/hooks/fsmonitor-test<<-\EOF &&
      -	EOF
       	clean_repo &&
     -+	write_integration_script &&
       	dirty_repo &&
     ++	write_integration_script &&
       	git add . &&
      +	write_script .git/hooks/fsmonitor-test<<-\EOF &&
      +	EOF

-- 
gitgitgadget
