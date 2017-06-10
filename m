Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EAFE1F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 06:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbdFJGHE (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 02:07:04 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34562 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbdFJGHD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 02:07:03 -0400
Received: by mail-pf0-f171.google.com with SMTP id 15so7450211pfc.1
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 23:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=dJrJxD6wABNsMmJstg3el68uDi1kG5H5gpQV7mYHx8k=;
        b=o47G/c7nA1NHao6RPtMG/f+knpLYSSi4tnCWpyLIKgz7GPUZ5hRLDrQt6CrX1Bmqxf
         mtOZOuI1xnogbEq0LURuWIzndGg/bqV4QPoX8d2JeHbPRPoun+cMysaiHuW9FXOpvvGD
         kRzHvDW+8St80kpJOsc0L8Vb0BCgAyL+Y+AnK/QS6lcJD/fJOOtKLctUpXloMY2D7MMJ
         9VUBAwh4rObpJMl1u7UubXqt8pPH9kaySHIceAA6bQItFbkyE6EppZZI5eBKyuYI3Gu+
         19YwpZ8g5yQhw/bxqCYHyUyGd+q/A75MmkvumKpwP7jw6k96e3mdLw2hmB6kd+rjS1oB
         0Tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=dJrJxD6wABNsMmJstg3el68uDi1kG5H5gpQV7mYHx8k=;
        b=PI9I+p7Ad724xg+WLemc6T7DoHUMPw/h+YgdMs1OZMhxfDBWNlLtrDgCvj6SoYCvMx
         vKqRE+W+rq/5BHKCLwb5jTDLeIBEdrw+8u+UeGj0fVpc+mFhF9xHy9IFYmmvHV/z8AST
         nbihljYCTokrcQfZkyag9dKGe9vHYFCBMh7SFBmjlHz3Mt78Y6xGjKVWYDul0i6aQp3Q
         CiIyraPHOC5fXDAzseYVOZCW2aBSBS4UusorRnTkcxH9Cbl2yoidwBFtH6wpa85yPyKs
         HF05YjPAQe028OFvc+APxwLKfgtyMtFr2rldsBI1pa73l1sUvSppdxy3KV4sTmCeiNqD
         BQbw==
X-Gm-Message-State: AODbwcBoVN1wHw0cEJ8wh9jGdZesSF9vMR/L91Hf1ZNe1apeA74Wz2fO
        QfbgN6GXfdVJ8Iz+mfo=
X-Received: by 10.101.86.76 with SMTP id m12mr30420773pgs.137.1497074822516;
        Fri, 09 Jun 2017 23:07:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d192:93c8:4f75:5879])
        by smtp.gmail.com with ESMTPSA id t13sm5991362pfa.126.2017.06.09.23.07.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 23:07:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: 'pu' broken at t5304 tonight
Date:   Sat, 10 Jun 2017 15:07:01 +0900
Message-ID: <xmqq4lvo2x6i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I didn't check where it goes wrong.  Here is a list of suspects,
taken by

    $ git shortlog --no-merges pu@{8.hours}..pu

i.e. patches that weren't in pu before today's integration cycle.

Andreas Heiduk (1):
      doc: describe git svn init --ignore-refs

Brandon Williams (32):
      config: create config.h
      config: remove git_config_iter
      config: don't include config.h by default
      config: don't implicitly use gitdir
      setup: don't perform lazy initialization of repository state
      environment: remove namespace_len variable
      repository: introduce the repository object
      environment: place key repository state in the_repository
      environment: store worktree in the_repository
      setup: add comment indicating a hack
      config: read config from a repository object
      repository: add index_state to struct repo
      submodule-config: store the_submodule_cache in the_repository
      submodule: add repo_read_gitmodules
      submodule: convert is_submodule_initialized to work on a repository
      convert: convert get_cached_convert_stats_ascii to take an index
      convert: convert crlf_to_git to take an index
      convert: convert convert_to_git_filter_fd to take an index
      convert: convert convert_to_git to take an index
      convert: convert renormalize_buffer to take an index
      tree: convert read_tree to take an index parameter
      ls-files: convert overlay_tree_on_cache to take an index
      ls-files: convert write_eolinfo to take an index
      ls-files: convert show_killed_files to take an index
      ls-files: convert show_other_files to take an index
      ls-files: convert show_ru_info to take an index
      ls-files: convert ce_excluded to take an index
      ls-files: convert prune_cache to take an index
      ls-files: convert show_files to take an index
      ls-files: factor out debug info into a function
      ls-files: factor out tag calculation
      ls-files: use repository object

Jeff King (1):
      date: use localtime() for "-local" time formats

Johannes Schindelin (8):
      discover_git_directory(): avoid setting invalid git_dir
      config: report correct line number upon error
      help: use early config when autocorrecting aliases
      read_early_config(): optionally return the worktree's top-level directory
      t1308: relax the test verifying that empty alias values are disallowed
      t7006: demonstrate a problem with aliases in subdirectories
      alias_lookup(): optionally return top-level directory
      Use the early config machinery to expand aliases

Junio C Hamano (1):
      ### match next

Prathamesh Chavan (1):
      dir: create function count_slashes

SZEDER Gábor (5):
      revision.h: turn rev_info.early_output back into an unsigned int
      revision.c: stricter parsing of '--no-{min,max}-parents'
      revision.c: stricter parsing of '--early-output'
      revision.c: use skip_prefix() in handle_revision_opt()
      revision.c: use skip_prefix() in handle_revision_pseudo_opt()

Stefan Beller (1):
      t4005: modernize style and drop hard coded sha1

