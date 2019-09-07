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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C0F61F461
	for <e@80x24.org>; Sat,  7 Sep 2019 11:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732712AbfIGLu5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 07:50:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40196 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbfIGLu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 07:50:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so5040504pgj.7
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 04:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dktu/hjuPvfQhJUN4UkGMFaa3aS8/Wu6Ub86FIoyIss=;
        b=OWCG41hPOXAWY87PmmMwvn+ULbd9NeGXwhX/HP/fdtgkN+YYlxD87dyywJfYEXiG8v
         rpF3GtMnd0tJ0z6FA/D/YBdYNSVpVKttpM3GFvVnFJARxeg/wvIr6M5Yw8mFra/y/40r
         gwlIGEOs0/5QXXM5TLrMubYvP4WipgeVq2tiElyc+se5IbBCM2KIQ+fpDvG+h0Bcu2tL
         VH9XlVuaqlKfQOY5YuR6J+BHXBtMnB4bDXTE6YNGL0j7qgKGDOAs05S3XGfsaAWDfElb
         3CMoqDgeH6nHbTacdWV6t1IgxJ0O3/X7g6oQxazj8wdZrm1cB5X/ms7KWkOqlEDdJZ7a
         IlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dktu/hjuPvfQhJUN4UkGMFaa3aS8/Wu6Ub86FIoyIss=;
        b=GZAv4XnZKnuWZ/F1ukbHXb7BceBFbRNWPra8xjlfLtHcelztt93vA27PhH5O9ei1ES
         DZ9lTl73JMOm20MJdB8P9ZVknd4hdFWWrGKkxiTy3VCF8AgiHLFJ9z1BuSXUkpN2DHie
         tjCTp1aZjX7tDkMaIZyzeCm3szvMpwsq/AFsxe2Tl5tyIRRAH3f4H3TgcW78GTXd6mzf
         beV+Oa2pr8nz0CBl09+mv0q6FOWkvrWTIoGP9DrVg4kAF61B2Va+J95B/Q1PCZii06NX
         UZxzHgJ2hPknt1Uf/qF4jxOvR5TiCj738zIlnDpRXUlISpp5/3soi8BNPAB9vQUGXIbL
         JYeQ==
X-Gm-Message-State: APjAAAW40CEjTJItINLD98iPRdaSjppTuivS9qTw2wMmt5I3+D1R94gz
        XkoIyMqKM1EOx3Y3hsylFNs=
X-Google-Smtp-Source: APXvYqyNjsSU4uHQfVFqGKoOrmfv0IcGeDUMGYP+GDOWVc428W3kTK3NygVVVXVdBJozS0UvrZWOUA==
X-Received: by 2002:a63:2043:: with SMTP id r3mr12315012pgm.311.1567857056012;
        Sat, 07 Sep 2019 04:50:56 -0700 (PDT)
Received: from ar135.mshome.net ([103.37.200.225])
        by smtp.gmail.com with ESMTPSA id a11sm18134792pfg.94.2019.09.07.04.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 04:50:54 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [PATCH v4 0/6] rebase -i: support more options
Date:   Sat,  7 Sep 2019 17:20:28 +0530
Message-Id: <20190907115034.14933-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following the suggestion of Phillip I've rebased my patch on master (745f681289)
and cherry-picking b0a3186140.

Base: 745f6812895b31c02b29bdfe4ae8e5498f776c26
      with cherry-picked b0a3186140dbc7bd64cbc6ef733386a0f1eb6a4d

Outline:
  2/6:
      - Change commit message and description
  3/6:
      - add test for rebase -r
      - add strict bounds while pushing ident date
  5/6:
      - bug fix: (following am's code) if --ignore-date is provided,
                 we should setenv GIT_COMMITTER_DATE to "".
      - catch error when ident line is malformed
      - push GIT_AUTHOR_DATE instead of providing it with --date so
        that "git merge" can also use push_dates function
      - add test for rebase -r


Rohit Ashiwal (6):
  rebase -i: add --ignore-whitespace flag
  sequencer: allow callers of read_author_script() to ignore fields
  rebase -i: support --committer-date-is-author-date
  sequencer: rename amend_author to author_to_rename
  rebase -i: support --ignore-date
  rebase: add --reset-author-date

 Documentation/git-rebase.txt            |  26 +++--
 builtin/rebase.c                        |  55 +++++++---
 sequencer.c                             | 134 +++++++++++++++++++++--
 sequencer.h                             |   2 +
 t/t3422-rebase-incompatible-options.sh  |   2 -
 t/t3433-rebase-options-compatibility.sh | 137 ++++++++++++++++++++++++
 6 files changed, 328 insertions(+), 28 deletions(-)
 create mode 100755 t/t3433-rebase-options-compatibility.sh

Range-diff:
--- snip ---
 1:  e82ed8cad5 = 49:  77af1d66db rebase -i: add --ignore-whitespace flag
 2:  209057b361 ! 50:  1f7f1407b2 sequencer: add NULL checks under read_author_script
    @@ -1,19 +1,14 @@
     Author: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
     
    -    sequencer: add NULL checks under read_author_script
    +    sequencer: allow callers of read_author_script() to ignore fields
     
    -    read_author_script reads name, email and author date from the author
    -    script. However, it does not check if the arguments are NULL. Adding
    -    NULL checks will allow us to selectively get the required value, for
    -    example:
    +    The current callers of the read_author_script() function read name,
    +    email and date from the author script.  Allow callers to signal that
    +    they are not interested in some among these three fields by passing
    +    NULL.
     
    -        char *date;
    -        if (read_author_script(_path_, NULL, NULL, &date, _int_))
    -                die(_("failed to read author date"));
    -        /* needs to be free()'d */
    -        return date;
    -
    -    Add NULL checks for better control over the information retrieved.
    +    Note that fields that are ignored still must exist and be formatted
    +    correctly in the author script.
     
         Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
     
 3:  a4e6644ef8 ! 51:  cc1614154e rebase -i: support --committer-date-is-author-date
    @@ -128,35 +128,34 @@
     +	return date;
     +}
     +
    - /* Read author-script and return an ident line (author <email> timestamp) */
    - static const char *read_author_ident(struct strbuf *buf)
    - {
    + static const char staged_changes_advice[] =
    + N_("you have staged changes in your working tree\n"
    + "If these changes are meant to be squashed into the previous commit, run:\n"
     @@
    - {
    - 	struct child_process cmd = CHILD_PROCESS_INIT;
      
    -+	if (opts->committer_date_is_author_date) {
    -+		size_t len;
    -+		int res = -1;
    -+		struct strbuf datebuf = STRBUF_INIT;
    -+		char *date = read_author_date_or_null();
    + 	cmd.git_cmd = 1;
    + 
    ++        if (opts->committer_date_is_author_date) {
    ++	        int res = -1;
    ++	        struct strbuf datebuf = STRBUF_INIT;
    ++	        char *date = read_author_date_or_null();
     +
    -+		if (!date)
    -+			return -1;
    ++	        if (!date)
    ++	                return -1;
     +
    -+		strbuf_addf(&datebuf, "@%s", date);
    -+		free(date);
    ++	        strbuf_addf(&datebuf, "@%s", date);
    ++	        res = setenv("GIT_COMMITTER_DATE", datebuf.buf, 1);
     +
    -+		date = strbuf_detach(&datebuf, &len);
    -+		res = setenv("GIT_COMMITTER_DATE", date, 1);
    -+		free(date);
    ++		strbuf_release(&datebuf);
    ++	        free(date);
     +
    -+		if (res)
    -+			return -1;
    -+	}
    - 	if ((flags & CREATE_ROOT_COMMIT) && !(flags & AMEND_MSG)) {
    - 		struct strbuf msg = STRBUF_INIT, script = STRBUF_INIT;
    - 		const char *author = NULL;
    ++	        if (res)
    ++	                return -1;
    ++        }
    ++
    + 	if (is_rebase_i(opts) && read_env_script(&cmd.env_array)) {
    + 		const char *gpg_opt = gpg_sign_opt_quoted(opts);
    + 
     @@
      
      	if (parse_head(r, &current_head))
    @@ -174,14 +173,19 @@
     +		struct ident_split ident;
     +		struct strbuf date = STRBUF_INIT;
     +
    -+		split_ident_line(&ident, author, len);
    -+
    ++		if (split_ident_line(&ident, author, len) < 0)
    ++			return error(_("malformed ident line"));
     +		if (!ident.date_begin)
     +			return error(_("corrupted author without date information"));
     +
    -+		strbuf_addf(&date, "@%s", ident.date_begin);
    -+		setenv("GIT_COMMITTER_DATE", date.buf, 1);
    ++		strbuf_addf(&date, "@%.*s %.*s",
    ++			    (int)(ident.date_end - ident.date_begin), ident.date_begin,
    ++			    (int)(ident.tz_end - ident.tz_begin), ident.tz_begin);
    ++		res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
     +		strbuf_release(&date);
    ++
    ++		if (res)
    ++			goto out;
     +	}
     +
      	if (write_index_as_tree(&tree, r->index, r->index_file, 0, NULL)) {
    @@ -256,6 +260,20 @@
      # This is a special case in which both am and interactive backends
      # provide the same output. It was done intentionally because
      # both the backends fall short of optimal behaviour.
    +@@
    + 	EOF
    + 	git commit -am "update file" &&
    + 	git tag side &&
    ++	test_commit commit1 foo foo1 &&
    ++	test_commit commit2 foo foo2 &&
    ++	test_commit commit3 foo foo3 &&
    + 
    + 	git checkout --orphan master &&
    ++	git rm --cached foo &&
    ++	rm foo &&
    + 	sed -e "s/^|//" >file <<-\EOF &&
    + 	|line 1
    + 	|        line 2
     @@
      	test_cmp expect file
      '
    @@ -275,5 +293,18 @@
     +	git show HEAD --pretty="format:%ci" >committertime &&
     +	test_cmp authortime committertime
     +'
    ++
    ++test_expect_success '--committer-date-is-author-date works with rebase -r' '
    ++	git checkout side &&
    ++	git merge commit3 &&
    ++	git rebase -r --root --committer-date-is-author-date &&
    ++	git rev-list HEAD >rev_list &&
    ++	while read HASH
    ++	do
    ++		git show $HASH --pretty="format:%ai" >authortime
    ++		git show $HASH --pretty="format:%ci" >committertime
    ++		test_cmp authortime committertime
    ++	done <rev_list
    ++'
     +
      test_done
 4:  6ac1885c54 = 52:  9e92c79bda sequencer: rename amend_author to author_to_rename
 5:  a69749dd67 ! 53:  fc68e55e78 rebase -i: support --ignore-date
    @@ -83,8 +83,10 @@
      	}
      
     -	if (options.committer_date_is_author_date)
    -+	if (options.ignore_date)
    ++	if (options.ignore_date) {
     +		options.committer_date_is_author_date = 0;
    ++		setenv("GIT_COMMITTER_DATE", "", 1);
    ++	}
     +	if (options.committer_date_is_author_date ||
     +	    options.ignore_date)
      		options.flags |= REBASE_FORCE;
    @@ -110,7 +112,7 @@
      static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
      static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
     @@
    - 	return buf->buf;
    + 	return date;
      }
      
     +/* Construct a free()able author string with current time as the author date */
    @@ -120,7 +122,10 @@
     +	struct ident_split ident;
     +	struct strbuf new_author = STRBUF_INIT;
     +
    -+	split_ident_line(&ident, author, len);
    ++	if (split_ident_line(&ident, author, len) < 0) {
    ++		error(_("malformed ident line"));
    ++		return NULL;
    ++	}
     +	len = ident.mail_end - ident.name_begin + 1;
     +
     +	strbuf_addf(&new_author, "%.*s ", len, author);
    @@ -134,7 +139,7 @@
     +	struct strbuf date = STRBUF_INIT;
     +
     +	strbuf_addf(&date, "@%"PRIuMAX, (uintmax_t)now);
    -+	argv_array_pushf(&child->args, "--date=%s", date.buf);
    ++	argv_array_pushf(&child->env_array, "GIT_AUTHOR_DATE=%s", date.buf);
     +	argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
     +	strbuf_release(&date);
     +}
    @@ -143,28 +148,6 @@
      N_("you have staged changes in your working tree\n"
      "If these changes are meant to be squashed into the previous commit, run:\n"
     @@
    - 
    - 		if (res <= 0)
    - 			res = error_errno(_("could not read '%s'"), defmsg);
    --		else
    -+		else {
    -+			if (opts->ignore_date) {
    -+				char *new_author = ignore_author_date(author);
    -+				if (!author)
    -+					BUG("ignore-date can only be used with "
    -+					    "rebase, which must set the author "
    -+					    "before committing the tree");
    -+				free((void *)author);
    -+				author = new_author;
    -+			}
    - 			res = commit_tree(msg.buf, msg.len, cache_tree_oid,
    - 					  NULL, &root_commit, author,
    - 					  opts->gpg_sign);
    -+		}
    - 
    - 		strbuf_release(&msg);
    - 		strbuf_release(&script);
    -@@
      		argv_array_push(&cmd.args, "--amend");
      	if (opts->gpg_sign)
      		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
    @@ -179,6 +162,10 @@
      
     +	if (opts->ignore_date) {
     +		author = ignore_author_date(author);
    ++		if (!author) {
    ++			res = -1;
    ++			goto out;
    ++		}
     +		free(author_to_free);
     +		author_to_free = (char *)author;
     +	}
    @@ -242,7 +229,7 @@
      --- a/t/t3433-rebase-options-compatibility.sh
      +++ b/t/t3433-rebase-options-compatibility.sh
     @@
    - 	test_cmp authortime committertime
    + 	done <rev_list
      '
      
     +# Checking for +0000 in author time is enough since default
    @@ -252,13 +239,32 @@
     +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
     +	git rebase --ignore-date HEAD^ &&
     +	git show HEAD --pretty="format:%ai" >authortime &&
    -+	grep "+0000" authortime
    ++	git show HEAD --pretty="format:%ci" >committertime &&
    ++	grep "+0000" authortime &&
    ++	grep "+0000" committertime
     +'
     +
     +test_expect_success '--ignore-date works with interactive backend' '
     +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
     +	git rebase --ignore-date -i HEAD^ &&
     +	git show HEAD --pretty="format:%ai" >authortime &&
    -+	grep "+0000" authortime
    ++	git show HEAD --pretty="format:%ci" >committertime &&
    ++	grep "+0000" authortime &&
    ++	grep "+0000" committertime
     +'
    ++
    ++test_expect_success '--ignore-date works with rebase -r' '
    ++	git checkout side &&
    ++	git merge commit3 &&
    ++	git rebase -r --root --ignore-date &&
    ++	git rev-list HEAD >rev_list &&
    ++	while read HASH
    ++	do
    ++		git show $HASH --pretty="format:%ai" >authortime
    ++		git show $HASH --pretty="format:%ci" >committertime
    ++		grep "+0000" authortime
    ++		grep "+0000" committertime
    ++	done <rev_list
    ++'
    ++
      test_done
 6:  210d15cca0 = 54:  396d5f16eb rebase: add --reset-author-date
-- 
2.21.0

