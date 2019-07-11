Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 828A01F461
	for <e@80x24.org>; Thu, 11 Jul 2019 08:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfGKIXn (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 04:23:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54634 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfGKIXn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 04:23:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so4714606wme.4
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 01:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J29JloeoslyfQfK7MhRsRwEmwZKs7LSKWIeFIM6gEf8=;
        b=sKPO79QuzY2iYHKuqVy5Dc4WHP+u4GeZN9j+2s60ihugCmUgrE088XBdY6G1KjnaDS
         wD0NVdztSakrEo4wGiJJTO0294BuhzOpJQEt/K6rLH6z65mHeL4camUkWd1n0bPJ3+Yj
         bocjBxWyu4UKS7OgHbnTFDYvHX4LUGYSrT9/YOEBWIYJUcfw/XtHCyLgOZbLoZtqMmYA
         eCxtCofeKgQCsLUaa8eNnBJ5df+pm92Nn2SMgSpWwZ25VRkCPEtERkUssz3E4tJs7zxi
         ucn+dICI6Q1e/L19s3WGhclv9M/Fw/uPN7IPLyz+a5K7egmamXJ8GdPjmY4xn0sGvC+v
         4Dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J29JloeoslyfQfK7MhRsRwEmwZKs7LSKWIeFIM6gEf8=;
        b=a88UJ6qM6C6JqINZCeMcnya0IC8VUZbbkJS1OwrRk33nTRZrYFsoDd6ove4GOGNEPi
         B8GXYwYQg26SFGFKNekNt0uZ6eb3u22i9QK2Pt6swhQ++J6z4A82Mqf3kDJOAyC6jNGv
         co+adJ1RssJe0Ww0WUc98EhNrI2xQOY7Io2oWClPPs+rczHMgDR7mKYoCf2bDvcj9dmr
         tlznSplLilUzCV6Sju3HP0BO3jVwfxPK6s9j+oEx6skuPYYKZ6uW9taXPCmEeZj9mptX
         kT4MNWEPr7MFqhu2U/k4cuxtTqzsb1LVrPD9CSUZbxLFjbfoQrgP3U4QYzwmrDfmofWA
         rOlA==
X-Gm-Message-State: APjAAAV1Pii4WLyOxhjJNU1Rb8ILFT6qHyIzmBg2DWVs6tHLMJ0HhgZF
        DZHRmW+1bLkoxtYzD7J5mCwwJXV9
X-Google-Smtp-Source: APXvYqx0ZBaQxlMFJpf3XG2rLO/Gleua4nIY6SJV+mH+4p5KPC6IlZwo7EHyzt9wyOWGwWLGLRw1ng==
X-Received: by 2002:a1c:7606:: with SMTP id r6mr2682760wmc.118.1562833421013;
        Thu, 11 Jul 2019 01:23:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g12sm6152842wrv.9.2019.07.11.01.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 01:23:40 -0700 (PDT)
Date:   Thu, 11 Jul 2019 01:23:40 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Jul 2019 08:23:38 GMT
Message-Id: <pull.213.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.213.git.gitgitgadget@gmail.com>
References: <pull.213.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] diff: release all handles before running external diff
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

On Windows, it is not possible to overwrite a file as long as any process
holds a read handle to it. Even keeping regions memory-mapped prevents that.

When git difftool calls git diff, it might be the user's intention to write
the file(s) via the diff tool, so let's make sure that they are not
memory-mapped at that stage.

Changes since v1:

 * Clarified in the commit message that even mapped regions block
   writes/deletes.
 * The diff file pair is now released unconditionally, not only when it is
   mapped, for consistency (the CI build did not fail, and a cursory
   inspection of the code paths indicates that this should be safe, as from
   this point on only the external command accesses the file pair's
   contents, and they had to be written out to disk to that end).

Johannes Schindelin (1):
  diff: munmap() file contents before running external diff

 diff.c | 2 ++
 1 file changed, 2 insertions(+)


base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-213%2Fdscho%2Fmunmap-before-ext-diff-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-213/dscho/munmap-before-ext-diff-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/213

Range-diff vs v1:

 1:  bef83fc20b ! 1:  8a0213291b diff: munmap() file contents before running external diff
     @@ -5,11 +5,15 @@
          When running an external diff from, say, a diff tool, it is safe to
          assume that we want to write the files in question. On Windows, that
          means that there cannot be any other process holding an open handle to
     -    said files.
     +    said files, or even just a mapped region.
      
          So let's make sure that `git diff` itself is not holding any open handle
          to the files in question.
      
     +    In fact, we will just release the file pair right away, as the external
     +    diff uses the files we just wrote, so we do not need to hold the file
     +    contents in memory anymore.
     +
          This fixes https://github.com/git-for-windows/git/issues/1315
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     @@ -21,10 +25,8 @@
       	argv_array_pushf(&env, "GIT_DIFF_PATH_COUNTER=%d", ++o->diff_path_counter);
       	argv_array_pushf(&env, "GIT_DIFF_PATH_TOTAL=%d", q->nr);
       
     -+	if (one && one->should_munmap)
     -+		diff_free_filespec_data(one);
     -+	if (two && two->should_munmap)
     -+		diff_free_filespec_data(two);
     ++	diff_free_filespec_data(one);
     ++	diff_free_filespec_data(two);
       	if (run_command_v_opt_cd_env(argv.argv, RUN_USING_SHELL, NULL, env.argv))
       		die(_("external diff died, stopping at %s"), name);
       

-- 
gitgitgadget
