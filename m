Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D87C20248
	for <e@80x24.org>; Wed, 13 Mar 2019 10:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfCMKpo (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 06:45:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37711 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCMKpn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 06:45:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id x10so1323892wmg.2
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 03:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LB/rVIoAowBPLpOk+XppLAxrfkTKYvuiGf7XKMWzrxE=;
        b=IfDXw5nyjeJxIZeJOEAJEak7qbmkVgDEdRuU4/qDd6zW0hDoI+pVw7UvatGTZx1RmZ
         wq69bvgr/zAqBhy0HL9i+RpqKNgXGApOyiPQ0caX1yGgJ3Ic1JlsyQCZcqUqyVB3FZDm
         DJ/KH5MjXu2b8e0pYnxE1k32TKBBPxQoP9D6EDTooFEhel0zGol/Qgw9NKshBf5ZwIB8
         HpWigRo85hqs50QAO3i4xDVHhSDGxn7VQjicMZFLiFFLsP7R5aydmWTzCyGRCXBICaZ3
         r4TomPNYzMOIi8vy2cHLEylu1nf7X9uVbHwiYyNwx6wCUZyhlbHtaupu6NdYR5136/Bv
         eefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LB/rVIoAowBPLpOk+XppLAxrfkTKYvuiGf7XKMWzrxE=;
        b=eguLUqlVKOi2BS47R2/VERR0bE+ReO5KiSBoxF13/K5aEAQihTbNpQga8bAG+XuuY4
         KxwNl44Gb8WAUiWmSGhmmwEKSpUEdFvUYvLMl5kabey8VN2ojKfVgkez7VUQ9SXqTkbC
         nakscaS/GTVZKTr/gLLpeW9iXw/c0GNTTH+Hi6DSGZGFeDXyFhb08yNJx+m1oqh6mmdb
         tJuJfAuM4BoCR0r/gsWlpeDE0CO0Ha3V0sJTSLPO0Zt2OGbhniiXnQkaCvtT0Eq4gCiW
         5XTh3fPX4KC90PTGqqFRKutgKU4du6zh8CoAmpc/0HtNSXAkQK6GX68xq5KpiPa3gc4z
         xxlg==
X-Gm-Message-State: APjAAAWC5Jz/XY+WMJZXFt6mXaA6h73tXcuLQsG2s0crAPNDxm0T1qbV
        SS10H9Yv9QK3he+gNhiWFDc=
X-Google-Smtp-Source: APXvYqz1b4bvC31AVlGiyoYFXw5BvtC2FxAOhmMVcbETbrZqHLMjDyYnrsf/9K3ogxaCxc1TFbArJA==
X-Received: by 2002:a1c:3543:: with SMTP id c64mr1812648wma.75.1552473941057;
        Wed, 13 Mar 2019 03:45:41 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-186-210.as13285.net. [89.242.186.210])
        by smtp.gmail.com with ESMTPSA id u13sm8897833wmf.3.2019.03.13.03.45.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 03:45:40 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 00/18] sequencer: refactor functions working on a
 todo_list
To:     Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <20190210132648.12821-1-alban.gruin@gmail.com>
 <20190305191805.13561-1-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <133c90ed-b170-a65c-67cd-1e8d53d2fbe9@gmail.com>
Date:   Wed, 13 Mar 2019 10:45:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190305191805.13561-1-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

Thanks for working on this. The range and inter diffs look fine, I think 
this is ready for next now.

Best Wishes

Phillip

On 05/03/2019 19:17, Alban Gruin wrote:
> At the center of the "interactive" part of the interactive rebase lies
> the todo list.  When the user starts an interactive rebase, a todo list
> is generated, presented to the user (who then edits it using a text
> editor), read back, and then is checked and processed before the actual
> rebase takes place.
> 
> Some of this processing includes adding execs commands, reordering
> fixup! and squash! commits, and checking if no commits were accidentally
> dropped by the user.
> 
> Before I converted the interactive rebase in C, these functions were
> called by git-rebase--interactive.sh through git-rebase--helper.  Since
> the only way to pass around a large amount of data between a shell
> script and a C program is to use a file (or any declination of a file),
> the functions that checked and processed the todo list were directly
> working on a file, the same file that the user edited.
> 
> During the conversion, I did not address this issue, which lead to a
> complete_action() that reads the todo list file, does some computation
> based on its content, and writes it back to the disk, several times in
> the same function.
> 
> As it is not an efficient way to handle a data structure, this patch
> series refactor the functions that processes the todo list to work on a
> todo_list structure instead of reading it from the disk.
> 
> Some commits consists in modifying edit_todo_list() (initially used by
> --edit-todo) to handle the initial edition of the todo list, to increase
> code sharing.
> 
> This is based on nd/the-index (cde555480b, "Merge branch
> 'nd/the-index'").
> 
> Changes since v7:
> 
>   - Add some comments to clarify some assumptions.
> 
>   - Use `string_list_remove_empty_items()` instead of `--commands.nr` to
>     remove empty commands.
> 
>   - Split the last commit ("rebase--interactive: move several functions
>     to rebase--interactive.c") into three, one for each function.
> 
> The tip of this series is tagged as "refactor-todo-list-v8" in
> https://github.com/agrn/git.
> 
> The range diff is included below.
> 
> Alban Gruin (18):
>    sequencer: changes in parse_insn_buffer()
>    sequencer: make the todo_list structure public
>    sequencer: remove the 'arg' field from todo_item
>    sequencer: refactor transform_todos() to work on a todo_list
>    sequencer: introduce todo_list_write_to_file()
>    sequencer: refactor check_todo_list() to work on a todo_list
>    sequencer: refactor sequencer_add_exec_commands() to work on a
>      todo_list
>    sequencer: refactor rearrange_squash() to work on a todo_list
>    sequencer: make sequencer_make_script() write its script to a strbuf
>    sequencer: change complete_action() to use the refactored functions
>    rebase--interactive: move sequencer_add_exec_commands()
>    rebase--interactive: move rearrange_squash_in_todo_file()
>    sequencer: refactor skip_unnecessary_picks() to work on a todo_list
>    rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
>    rebase-interactive: append_todo_help() changes
>    rebase-interactive: rewrite edit_todo_list() to handle the initial
>      edit
>    sequencer: use edit_todo_list() in complete_action()
>    rebase--interactive: move transform_todo_file()
> 
>   builtin/rebase--interactive.c | 144 ++++++--
>   rebase-interactive.c          | 146 ++++++--
>   rebase-interactive.h          |   9 +-
>   sequencer.c                   | 655 ++++++++++++----------------------
>   sequencer.h                   |  81 ++++-
>   5 files changed, 553 insertions(+), 482 deletions(-)
> 
> Range-diff against v7:
>   1:  0bc5f714e5 =  1:  0bc5f714e5 sequencer: changes in parse_insn_buffer()
>   2:  34d149ff25 =  2:  34d149ff25 sequencer: make the todo_list structure public
>   3:  8200f7a6be =  3:  8200f7a6be sequencer: remove the 'arg' field from todo_item
>   4:  ce8ca23ee0 =  4:  ce8ca23ee0 sequencer: refactor transform_todos() to work on a todo_list
>   5:  67ebea475e =  5:  67ebea475e sequencer: introduce todo_list_write_to_file()
>   6:  370c153ebe =  6:  370c153ebe sequencer: refactor check_todo_list() to work on a todo_list
>   7:  66e7b65509 !  7:  95ae0f36d2 sequencer: refactor sequencer_add_exec_commands() to work on a todo_list
>      @@ -60,7 +60,10 @@
>        
>       +	if (cmd && *cmd) {
>       +		string_list_split(&commands, cmd, '\n', -1);
>      -+		--commands.nr;
>      ++
>      ++		/* rebase.c adds a new line to cmd after every command,
>      ++		 * so here the last command is always empty */
>      ++		string_list_remove_empty_items(&commands, 0);
>       +	}
>       +
>        	switch (command) {
>      @@ -86,7 +89,7 @@
>        		BUG("invalid command '%d'", command);
>        	}
>        
>      -+	string_list_clear(&commands, 1);
>      ++	string_list_clear(&commands, 0);
>        	return !!ret;
>        }
>       
>      @@ -133,9 +136,16 @@
>        	}
>        
>        	/*
>      -@@
>      + 	 * Insert <commands> after every pick. Here, fixup/squash chains
>        	 * are considered part of the pick, so we insert the commands *after*
>        	 * those chains if there are any.
>      ++	 *
>      ++	 * As we insert the exec commands immediatly after rearranging
>      ++	 * any fixups and before the user edits the list, a fixup chain
>      ++	 * can never contain comments (any comments are empty picks that
>      ++	 * have been commented out because the user did not specify
>      ++	 * --keep-empty).  So, it is safe to insert an exec command
>      ++	 * without looking at the command following a comment.
>        	 */
>       -	insert = -1;
>       -	for (i = 0; i < todo_list.nr; i++) {
>      @@ -165,12 +175,11 @@
>       +			insert = 0;
>        		}
>        
>      --		if (command == TODO_PICK || command == TODO_MERGE)
>      --			insert = i + 1;
>       +		ALLOC_GROW(items, nr + 1, alloc);
>       +		items[nr++] = todo_list->items[i];
>       +
>      -+		if (command == TODO_PICK || command == TODO_MERGE || is_fixup(command))
>      + 		if (command == TODO_PICK || command == TODO_MERGE)
>      +-			insert = i + 1;
>       +			insert = 1;
>        	}
>        
>      @@ -192,8 +201,7 @@
>       +	todo_list->nr = nr;
>       +	todo_list->alloc = alloc;
>       +}
>      -
>      --	i = write_message(buf->buf, buf->len, todo_file, 0);
>      ++
>       +int sequencer_add_exec_commands(struct repository *r,
>       +				struct string_list *commands)
>       +{
>      @@ -203,7 +211,8 @@
>       +
>       +	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
>       +		return error_errno(_("could not read '%s'."), todo_file);
>      -+
>      +
>      +-	i = write_message(buf->buf, buf->len, todo_file, 0);
>       +	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
>       +		todo_list_release(&todo_list);
>       +		return error(_("unusable todo list: '%s'"), todo_file);
>   8:  640cb7aa54 =  8:  144eb32743 sequencer: refactor rearrange_squash() to work on a todo_list
>   9:  bef1970c88 =  9:  1501c26317 sequencer: make sequencer_make_script() write its script to a strbuf
> 10:  48ee37a32a = 10:  121b270c4d sequencer: change complete_action() to use the refactored functions
> 16:  f57a7405d0 ! 11:  a3763ecb0e rebase--interactive: move several functions to rebase--interactive.c
>      @@ -1,13 +1,12 @@
>       Author: Alban Gruin <alban.gruin@gmail.com>
>       
>      -    rebase--interactive: move several functions to rebase--interactive.c
>      +    rebase--interactive: move sequencer_add_exec_commands()
>       
>      -    As sequencer_add_exec_commands(), rearrange_squash_in_todo_file(), and
>      -    transform_todo_file() are only needed inside of rebase--interactive.c
>      -    for rebase -p, they are moved there from sequencer.c.
>      +    As sequencer_add_exec_commands() is only needed inside of
>      +    rebase--interactive.c for `rebase -p', it is moved there from
>      +    sequencer.c.
>       
>      -    The parameter r (repository) is dropped from them, and the error
>      -    handling of rearrange_squash_in_todo_file() is slightly improved.
>      +    The parameter r (repository) is dropped along the way.
>       
>           Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>       
>      @@ -43,72 +42,11 @@
>       +	return 0;
>       +}
>       +
>      -+static int rearrange_squash_in_todo_file(void)
>      -+{
>      -+	const char *todo_file = rebase_path_todo();
>      -+	struct todo_list todo_list = TODO_LIST_INIT;
>      -+	int res = 0;
>      -+
>      -+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
>      -+		return error_errno(_("could not read '%s'."), todo_file);
>      -+	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
>      -+					&todo_list)) {
>      -+		todo_list_release(&todo_list);
>      -+		return error(_("unusable todo list: '%s'"), todo_file);
>      -+	}
>      -+
>      -+	res = todo_list_rearrange_squash(&todo_list);
>      -+	if (!res)
>      -+		res = todo_list_write_to_file(the_repository, &todo_list,
>      -+					      todo_file, NULL, NULL, -1, 0);
>      -+
>      -+	todo_list_release(&todo_list);
>      -+
>      -+	if (res)
>      -+		return error_errno(_("could not write '%s'."), todo_file);
>      -+	return 0;
>      -+}
>      -+
>      -+static int transform_todo_file(unsigned flags)
>      -+{
>      -+	const char *todo_file = rebase_path_todo();
>      -+	struct todo_list todo_list = TODO_LIST_INIT;
>      -+	int res;
>      -+
>      -+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
>      -+		return error_errno(_("could not read '%s'."), todo_file);
>      -+
>      -+	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
>      -+					&todo_list)) {
>      -+		todo_list_release(&todo_list);
>      -+		return error(_("unusable todo list: '%s'"), todo_file);
>      -+	}
>      -+
>      -+	res = todo_list_write_to_file(the_repository, &todo_list, todo_file,
>      -+				      NULL, NULL, -1, flags);
>      -+	todo_list_release(&todo_list);
>      -+
>      -+	if (res)
>      -+		return error_errno(_("could not write '%s'."), todo_file);
>      -+	return 0;
>      -+}
>      -+
>      - static int edit_todo_file(unsigned flags)
>      - {
>      - 	const char *todo_file = rebase_path_todo();
>      + static int get_revision_ranges(const char *upstream, const char *onto,
>      + 			       const char **head_hash,
>      + 			       char **revisions, char **shortrevisions)
>       @@
>      - 	}
>      - 	case SHORTEN_OIDS:
>      - 	case EXPAND_OIDS:
>      --		ret = transform_todo_file(the_repository, flags);
>      -+		ret = transform_todo_file(flags);
>      - 		break;
>      - 	case CHECK_TODO_LIST:
>      - 		ret = check_todo_list_from_file(the_repository);
>      - 		break;
>      - 	case REARRANGE_SQUASH:
>      --		ret = rearrange_squash_in_todo_file(the_repository);
>      -+		ret = rearrange_squash_in_todo_file();
>      + 		ret = rearrange_squash_in_todo_file(the_repository);
>        		break;
>        	case ADD_EXEC:
>       -		ret = sequencer_add_exec_commands(the_repository, &commands);
>      @@ -162,82 +100,6 @@
>        static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_list,
>        				struct strbuf *buf, int num, unsigned flags)
>        {
>      -@@
>      - 	return res;
>      - }
>      -
>      --int transform_todo_file(struct repository *r, unsigned flags)
>      --{
>      --	const char *todo_file = rebase_path_todo();
>      --	struct todo_list todo_list = TODO_LIST_INIT;
>      --	int res;
>      --
>      --	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
>      --		return error_errno(_("could not read '%s'."), todo_file);
>      --
>      --	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
>      --		todo_list_release(&todo_list);
>      --		return error(_("unusable todo list: '%s'"), todo_file);
>      --	}
>      --
>      --	res = todo_list_write_to_file(r, &todo_list, todo_file,
>      --				      NULL, NULL, -1, flags);
>      --	todo_list_release(&todo_list);
>      --
>      --	if (res)
>      --		return error_errno(_("could not write '%s'."), todo_file);
>      --	return 0;
>      --}
>      --
>      - static const char edit_todo_list_advice[] =
>      - N_("You can fix this with 'git rebase --edit-todo' "
>      - "and then run 'git rebase --continue'.\n"
>      -@@
>      - 	return 0;
>      - }
>      -
>      --static int todo_list_rearrange_squash(struct todo_list *todo_list);
>      --
>      - int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
>      - 		    const char *shortrevisions, const char *onto_name,
>      - 		    const char *onto, const char *orig_head, struct string_list *commands,
>      -@@
>      -  * message will have to be retrieved from the commit (as the oneline in the
>      -  * script cannot be trusted) in order to normalize the autosquash arrangement.
>      -  */
>      --static int todo_list_rearrange_squash(struct todo_list *todo_list)
>      -+int todo_list_rearrange_squash(struct todo_list *todo_list)
>      - {
>      - 	struct hashmap subject2item;
>      - 	int rearranged = 0, *next, *tail, i, nr = 0, alloc = 0;
>      -@@
>      -
>      - 	return 0;
>      - }
>      --
>      --int rearrange_squash_in_todo_file(struct repository *r)
>      --{
>      --	const char *todo_file = rebase_path_todo();
>      --	struct todo_list todo_list = TODO_LIST_INIT;
>      --	int res = 0;
>      --
>      --	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
>      --		return -1;
>      --	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
>      --		todo_list_release(&todo_list);
>      --		return -1;
>      --	}
>      --
>      --	res = todo_list_rearrange_squash(&todo_list);
>      --	if (!res)
>      --		res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1, 0);
>      --
>      --	todo_list_release(&todo_list);
>      --
>      --	if (res)
>      --		return error_errno(_("could not write '%s'."), todo_file);
>      --	return 0;
>      --}
>       
>        diff --git a/sequencer.h b/sequencer.h
>        --- a/sequencer.h
>      @@ -248,16 +110,9 @@
>        
>       -int sequencer_add_exec_commands(struct repository *r,
>       -				struct string_list *commands);
>      --int transform_todo_file(struct repository *r, unsigned flags);
>      + int transform_todo_file(struct repository *r, unsigned flags);
>       +void todo_list_add_exec_commands(struct todo_list *todo_list,
>       +				 struct string_list *commands);
>        int check_todo_list_from_file(struct repository *r);
>        int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
>        		    const char *shortrevisions, const char *onto_name,
>      - 		    const char *onto, const char *orig_head, struct string_list *commands,
>      - 		    unsigned autosquash, struct todo_list *todo_list);
>      --int rearrange_squash_in_todo_file(struct repository *r);
>      -+int todo_list_rearrange_squash(struct todo_list *todo_list);
>      -
>      - extern const char sign_off_header[];
>      -
>   -:  ---------- > 12:  e03663ed04 rebase--interactive: move rearrange_squash_in_todo_file()
> 11:  bc89fbfea6 = 13:  d9cf3d7d2f sequencer: refactor skip_unnecessary_picks() to work on a todo_list
> 12:  a754d0da96 = 14:  bf6cc5978c rebase-interactive: use todo_list_write_to_file() in edit_todo_list()
> 13:  031e4de856 = 15:  1c9d1cb3c9 rebase-interactive: append_todo_help() changes
> 14:  268998924b ! 16:  b98b07dae0 rebase-interactive: rewrite edit_todo_list() to handle the initial edit
>      @@ -16,8 +16,8 @@
>        --- a/builtin/rebase--interactive.c
>        +++ b/builtin/rebase--interactive.c
>       @@
>      - static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
>      - static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
>      + 	return 0;
>      + }
>        
>       +static int edit_todo_file(unsigned flags)
>       +{
>      @@ -87,6 +87,9 @@
>       -		todo_list_release(&todo_list);
>       -		return -1;
>       -	}
>      ++	/* If the user is editing the todo list, we first try to parse
>      ++	 * it.  If there is an error, we do not return, because the user
>      ++	 * might want to fix it in the first place. */
>       +	if (!initial)
>       +		todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
>        
>      @@ -110,6 +113,8 @@
>       +	if (initial && new_todo->buf.len == 0)
>       +		return -3;
>       +
>      ++	/* For the initial edit, the todo list gets parsed in
>      ++	 * complete_action(). */
>       +	if (!initial)
>       +		return todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo);
>       +
> 15:  6f1274a33c = 17:  406e971e56 sequencer: use edit_todo_list() in complete_action()
>   -:  ---------- > 18:  51d44a8200 rebase--interactive: move transform_todo_file()
> 
