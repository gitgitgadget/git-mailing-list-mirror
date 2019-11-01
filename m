Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
	SPF_NONE shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 123A21F4C0
	for <e@80x24.org>; Fri,  1 Nov 2019 14:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfKAOBO (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 10:01:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45501 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbfKAOBO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 10:01:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id z4so1108294pfn.12
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 07:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=preqmydAb74E/9C+bgx+xGfyuBlyFPvOw7BxVnQBaU4=;
        b=u9/o3mbT8GWHxjiQo9VilgzEjVSNtzFIj4gs2ViwtowXb8uRcJP6ol47RlenIVH7zG
         naumU1U+PsUMKvUb3banfCFUW9MTGI3FaPc3g+O5QQDbVjbaD0tRzeJJ/ZKv8lkfcNyG
         QRHEV6f4Xl0iZMhqGhYFuKBKnhzm+Z8lMoToOIdQsL7HoybCvWg904Lwmlv/b0RnGyJl
         v/f4H5uzELyjL3cEVu3klmFiP5FHdT2qFP5qpmNEjcr3XG64/bvEs8jrFI4S8N1xJFdm
         7J+Qo9J4uVbo0667hX793T+5rzZWgfdljXG2x0B/GSaneo4YyDHdeCj9oEMr6Wr70t3U
         L7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=preqmydAb74E/9C+bgx+xGfyuBlyFPvOw7BxVnQBaU4=;
        b=Gw1czioT8FGoRpceBlzQReHsJxfQdI9urTlT9PKZF/fFkXW/f7i2YMjh3GBMPhceny
         KnTLD3GC0o06yX3mJtXvkcoKL1tqeAk6G7jobnmZDot8A4kI7Agu7DW2a2WEp07k9Dph
         1SdBR7HeeQ8ciVCV1DbIptDIoAzust7OaHoUEjm/iRfVgCcz8Yx7bwwuTce8485r68iY
         NroJO9umNSD6n0+l/wX3qzM+1p8LMiyeM03fuOkfmAweKgT5sm6cUw2keXDYweOlmUFc
         8fQJWxVHqyZTfZMHKloOBF8I+8wXZZA/uP02+wzLIqZT5gpsG9PFEK3PGipFjpSGweVU
         YxwA==
X-Gm-Message-State: APjAAAWt8IBjUYS3wHWIxF9bq7mftDkMzY9OG6wAMrqUSCOF/b1RztDy
        CDclZPvjkBcZ/MO2rSeQvZbJoICaRmQ=
X-Google-Smtp-Source: APXvYqw3MnMXA/xtk2JN7XS2JwHp07xQzUdysoVvGnbNEduIBh3kY9Xnold+EMnJ1QG/hMGXHptYrg==
X-Received: by 2002:a63:d308:: with SMTP id b8mr13701941pgg.246.1572616869419;
        Fri, 01 Nov 2019 07:01:09 -0700 (PDT)
Received: from ar135.mshome.net ([103.37.200.214])
        by smtp.gmail.com with ESMTPSA id z4sm7806816pjt.20.2019.11.01.07.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 07:01:07 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [PATCH v5 0/6] rebase -i: support more options
Date:   Fri,  1 Nov 2019 19:29:57 +0530
Message-Id: <20191101140003.13960-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Everyone

I got really busy lately, posting the patch now.
 - Now handles the combination of --ignore-date and
   --committer-date-is-author-date properly.
 - Improved code coverage
 - addressed the compatibility of --rebase-merges with --strategy

Thanks
Rohit

Rohit Ashiwal (6):
  rebase -i: add --ignore-whitespace flag
  sequencer: allow callers of read_author_script() to ignore fields
  rebase -i: support --committer-date-is-author-date
  sequencer: rename amend_author to author_to_rename
  rebase -i: support --ignore-date
  rebase: add --reset-author-date

 Documentation/git-rebase.txt            |  25 ++++-
 builtin/rebase.c                        |  48 ++++++--
 sequencer.c                             | 141 ++++++++++++++++++++++--
 sequencer.h                             |   2 +
 t/t3422-rebase-incompatible-options.sh  |   2 -
 t/t3433-rebase-options-compatibility.sh | 131 ++++++++++++++++++++++
 6 files changed, 321 insertions(+), 28 deletions(-)
 create mode 100755 t/t3433-rebase-options-compatibility.sh

Range-diff:
  2:  77af1d66db ! 491:  e155af5a39 rebase -i: add --ignore-whitespace flag
    @@ -16,7 +16,7 @@
      --- a/Documentation/git-rebase.txt
      +++ b/Documentation/git-rebase.txt
     @@
    - default is `--no-fork-point`, otherwise the default is `--fork-point`.
    + with `--keep-base` in order to drop those commits from your branch.
      
      --ignore-whitespace::
     +	Behaves differently depending on which backend is selected.
    @@ -46,9 +46,8 @@
       * --preserve-merges and --signoff
       * --preserve-merges and --rebase-merges
     + * --preserve-merges and --ignore-whitespace
    -+ * --rebase-merges and --ignore-whitespace
    -  * --rebase-merges and --strategy
    -  * --rebase-merges and --strategy-option
    +  * --keep-base and --onto
    +  * --keep-base and --root
      
     
      diff --git a/builtin/rebase.c b/builtin/rebase.c
    @@ -124,16 +123,6 @@
      		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
      				  N_("action"), N_("passed to 'git apply'"), 0),
      		OPT_BIT('f', "force-rebase", &options.flags,
    -@@
    - 	}
    - 
    - 	if (options.rebase_merges) {
    -+		if (options.ignore_whitespace)
    -+			die(_("cannot combine '--rebase-merges' with "
    -+			      "'--ignore-whitespace'"));
    - 		if (strategy_options.nr)
    - 			die(_("cannot combine '--rebase-merges' with "
    - 			      "'--strategy-option'"));
     
      diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
      --- a/t/t3422-rebase-incompatible-options.sh
  3:  1f7f1407b2 = 492:  7ec673ebcb sequencer: allow callers of read_author_script() to ignore fields
  4:  cc1614154e ! 493:  5af0d628de rebase -i: support --committer-date-is-author-date
    @@ -40,9 +40,9 @@
       * --preserve-merges and --rebase-merges
       * --preserve-merges and --ignore-whitespace
     + * --preserve-merges and --committer-date-is-author-date
    -  * --rebase-merges and --ignore-whitespace
    -  * --rebase-merges and --strategy
    -  * --rebase-merges and --strategy-option
    +  * --keep-base and --onto
    +  * --keep-base and --root
    + 
     
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
    @@ -173,10 +173,14 @@
     +		struct ident_split ident;
     +		struct strbuf date = STRBUF_INIT;
     +
    -+		if (split_ident_line(&ident, author, len) < 0)
    -+			return error(_("malformed ident line"));
    -+		if (!ident.date_begin)
    -+			return error(_("corrupted author without date information"));
    ++		if (split_ident_line(&ident, author, len) < 0) {
    ++			res = error(_("malformed ident line"));
    ++			goto out;
    ++		}
    ++		if (!ident.date_begin) {
    ++			res = error(_("corrupted author without date information"));
    ++			goto out;
    ++		}
     +
     +		strbuf_addf(&date, "@%.*s %.*s",
     +			    (int)(ident.date_end - ident.date_begin), ident.date_begin,
    @@ -296,7 +300,7 @@
     +
     +test_expect_success '--committer-date-is-author-date works with rebase -r' '
     +	git checkout side &&
    -+	git merge commit3 &&
    ++	git merge --no-ff commit3 &&
     +	git rebase -r --root --committer-date-is-author-date &&
     +	git rev-list HEAD >rev_list &&
     +	while read HASH
  5:  9e92c79bda = 494:  c7846945dd sequencer: rename amend_author to author_to_rename
  6:  fc68e55e78 ! 495:  02f797b84d rebase -i: support --ignore-date
    @@ -17,8 +17,8 @@
      --ignore-date::
     -	This flag is passed to 'git am' to change the author date
     -	of each rebased commit (see linkgit:git-am[1]).
    -+	Instead of using the given author date, reset it to the value
    -+	same as the current time. This implies --force-rebase.
    ++	Instead of using the given author date, reset it to the
    ++	current time. This implies --force-rebase.
      +
      See also INCOMPATIBLE OPTIONS below.
      
    @@ -35,9 +35,9 @@
       * --preserve-merges and --ignore-whitespace
       * --preserve-merges and --committer-date-is-author-date
     + * --preserve-merges and --ignore-date
    -  * --rebase-merges and --ignore-whitespace
    -  * --rebase-merges and --strategy
    -  * --rebase-merges and --strategy-option
    +  * --keep-base and --onto
    +  * --keep-base and --root
    + 
     
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
    @@ -83,10 +83,6 @@
      	}
      
     -	if (options.committer_date_is_author_date)
    -+	if (options.ignore_date) {
    -+		options.committer_date_is_author_date = 0;
    -+		setenv("GIT_COMMITTER_DATE", "", 1);
    -+	}
     +	if (options.committer_date_is_author_date ||
     +	    options.ignore_date)
      		options.flags |= REBASE_FORCE;
    @@ -128,35 +124,56 @@
     +	}
     +	len = ident.mail_end - ident.name_begin + 1;
     +
    -+	strbuf_addf(&new_author, "%.*s ", len, author);
    ++	strbuf_addf(&new_author, "%.*s ", len, ident.name_begin);
     +	datestamp(&new_author);
     +	return strbuf_detach(&new_author, NULL);
     +}
     +
    -+static void push_dates(struct child_process *child)
    ++static void push_dates(struct child_process *child, int change_committer_date)
     +{
     +	time_t now = time(NULL);
     +	struct strbuf date = STRBUF_INIT;
     +
     +	strbuf_addf(&date, "@%"PRIuMAX, (uintmax_t)now);
     +	argv_array_pushf(&child->env_array, "GIT_AUTHOR_DATE=%s", date.buf);
    -+	argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
    ++	if (change_committer_date)
    ++		argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
     +	strbuf_release(&date);
     +}
     +
      static const char staged_changes_advice[] =
      N_("you have staged changes in your working tree\n"
      "If these changes are meant to be squashed into the previous commit, run:\n"
    +@@
    + 	                return -1;
    + 
    + 	        strbuf_addf(&datebuf, "@%s", date);
    +-	        res = setenv("GIT_COMMITTER_DATE", datebuf.buf, 1);
    ++		res = setenv("GIT_COMMITTER_DATE",
    ++			     opts->ignore_date ? "" : datebuf.buf, 1);
    + 
    + 		strbuf_release(&datebuf);
    + 	        free(date);
     @@
      		argv_array_push(&cmd.args, "--amend");
      	if (opts->gpg_sign)
      		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
     +	if (opts->ignore_date)
    -+		push_dates(&cmd);
    ++		push_dates(&cmd, opts->committer_date_is_author_date);
      	if (defmsg)
      		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
      	else if (!(flags & EDIT_MSG))
     @@
    + 		strbuf_addf(&date, "@%.*s %.*s",
    + 			    (int)(ident.date_end - ident.date_begin), ident.date_begin,
    + 			    (int)(ident.tz_end - ident.tz_begin), ident.tz_begin);
    +-		res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
    ++		res = setenv("GIT_COMMITTER_DATE",
    ++			     opts->ignore_date ? "" : date.buf, 1);
    + 		strbuf_release(&date);
    + 
    + 		if (res)
    +@@
      
      	reset_ident_date();
      
    @@ -198,7 +215,7 @@
      		if (opts->gpg_sign)
      			argv_array_push(&cmd.args, opts->gpg_sign);
     +		if (opts->ignore_date)
    -+			push_dates(&cmd);
    ++			push_dates(&cmd, opts->committer_date_is_author_date);
      
      		/* Add the tips to be merged */
      		for (j = to_merge; j; j = j->next)
    @@ -239,31 +256,25 @@
     +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
     +	git rebase --ignore-date HEAD^ &&
     +	git show HEAD --pretty="format:%ai" >authortime &&
    -+	git show HEAD --pretty="format:%ci" >committertime &&
    -+	grep "+0000" authortime &&
    -+	grep "+0000" committertime
    ++	grep "+0000" authortime
     +'
     +
     +test_expect_success '--ignore-date works with interactive backend' '
     +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
     +	git rebase --ignore-date -i HEAD^ &&
     +	git show HEAD --pretty="format:%ai" >authortime &&
    -+	git show HEAD --pretty="format:%ci" >committertime &&
    -+	grep "+0000" authortime &&
    -+	grep "+0000" committertime
    ++	grep "+0000" authortime
     +'
     +
     +test_expect_success '--ignore-date works with rebase -r' '
     +	git checkout side &&
    -+	git merge commit3 &&
    ++	git merge --no-ff commit3 &&
     +	git rebase -r --root --ignore-date &&
     +	git rev-list HEAD >rev_list &&
     +	while read HASH
     +	do
     +		git show $HASH --pretty="format:%ai" >authortime
    -+		git show $HASH --pretty="format:%ci" >committertime
     +		grep "+0000" authortime
    -+		grep "+0000" committertime
     +	done <rev_list
     +'
     +
  7:  396d5f16eb ! 496:  7a9fe1e612 rebase: add --reset-author-date
    @@ -17,8 +17,8 @@
      
      --ignore-date::
     +--reset-author-date::
    - 	Instead of using the given author date, reset it to the value
    - 	same as the current time. This implies --force-rebase.
    + 	Instead of using the given author date, reset it to the
    + 	current time. This implies --force-rebase.
      +
     
      diff --git a/builtin/rebase.c b/builtin/rebase.c
-- 
2.21.0

