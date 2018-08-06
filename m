Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADA69208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 09:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbeHFMBK (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 08:01:10 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:44526 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeHFMBK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 08:01:10 -0400
Received: by mail-pl0-f51.google.com with SMTP id ba4-v6so5442897plb.11
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 02:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iCURyeJH4E1kS7CMOYEkn2cPqDSqZTHB+suOoeu5Xmg=;
        b=ITqjGKQyph4Sb8HzlMLHC8uh9AIdPb/uBx6zUR/NNgeX4Ln8OD+tai+FiTTfF7suTJ
         /T/9CB7uMkUBrng1dQauFYDWbZZ1jF4rOThU/TWAfXgr3B4+klZX2oEAA9gALWzVKLng
         EAI7ykeHJOf/mPNA+niNhGSjdKJSnNCXmYzY9teTnKzJgVXofsGNh0JbjN7aZNwd9iky
         XsQCToHx+3kl2AHwB8F92p3VYsOCoKEqeVot20iMlr9Mpbrxjy/5X/sBPC6GuM25BygI
         hU5XVjyqcRXIAYK0cr86WdCCS+dGTGm+a8rXsHshBCvt78vICxi1V7Yf+64lTm6VkBdb
         XwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iCURyeJH4E1kS7CMOYEkn2cPqDSqZTHB+suOoeu5Xmg=;
        b=rT00CIp3mxsH0gvmWSlvkXODvE9HM94mh1hxHbsOatA4o5iJDdapsA2OLA/mBMjBl+
         MQ5yXFYBw4l8eWJXqXun95AXBGUng+XBL+gstaoil9Y3oDf85GXE4GujPEmoR2G8bQvc
         hc6T2Rizav1Sn0Yry0z12MO9Md7sJX3LVglaqsXCjr0pCNJJWXTozf2d0dT08SsD1deH
         I++kCBCQcD8UoEAG2c0SJ9v4v8ifBxATSk3Omj5oz7siv+1KaR55vZj5vx6xAqDJ/fWa
         xDN1GkZZ7U6A6FiK89uPdRGEFnuOTPKuLxvLjI1nsk1gZ1l8RZhcWYUhsI9rSYba6B2J
         UebQ==
X-Gm-Message-State: AOUpUlE/4ahJB3YagxFf1zUefAmZt3wybDW/xdbxWZrAH/l0ia+AqCFu
        neRjr9daQ3lPUfq6UyxxI2Df028H
X-Google-Smtp-Source: AAOMgpf5kwv8oGv3ReBfMaQJ9lZkmWiZaE10aKhPZeLfHmqDdgN8RjNbxIrVqx7QMWoDsF+dpP/EhA==
X-Received: by 2002:a17:902:d88d:: with SMTP id b13-v6mr13415334plz.314.1533549171986;
        Mon, 06 Aug 2018 02:52:51 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id s85-v6sm21504620pfa.116.2018.08.06.02.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 02:52:51 -0700 (PDT)
Date:   Mon, 06 Aug 2018 02:52:51 -0700 (PDT)
X-Google-Original-Date: Mon, 06 Aug 2018 09:52:47 GMT
Message-Id: <pull.13.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.13.git.gitgitgadget@gmail.com>
References: <pull.13.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/2] Make git rebase work with --rebase-merges and --exec
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

It was reported via IRC that the exec lines are inserted in the wrong spots
when using --rebase-merges.

The reason is that we used a simple, incorrect implementation that happened
to work as long as the generated todo list only contains pick, fixup and 
squash commands. Which is not the case with--rebase-merges.

Fix this issue by using a correct, if longer and slightly more complex
implementation instead.

Johannes Schindelin (2):
  t3430: demonstrate what -r, --autosquash & --exec should do
  rebase --exec: make it work with --rebase-merges

 sequencer.c              | 37 +++++++++++++++++++++++++++----------
 t/t3430-rebase-merges.sh | 17 +++++++++++++++++
 2 files changed, 44 insertions(+), 10 deletions(-)


base-commit: 1d89318c48d233d52f1db230cf622935ac3c69fa
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-13%2Fdscho%2Frebase-merges-and-exec-commands-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-13/dscho/rebase-merges-and-exec-commands-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/13

Range-diff vs v1:

 1:  1d82eb450 = 1:  1d82eb450 t3430: demonstrate what -r, --autosquash & --exec should do
 2:  b29c4d979 ! 2:  7ca441a89 rebase --exec: make it work with --rebase-merges
     @@ -38,7 +38,7 @@
       	struct strbuf *buf = &todo_list.buf;
       	size_t offset = 0, commands_len = strlen(commands);
      -	int i, first;
     -+	int i, insert_final_commands;
     ++	int i, insert;
       
       	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
       		return error(_("could not read '%s'."), todo_file);
     @@ -52,59 +52,38 @@
      -		if (item->command == TODO_PICK && !first) {
      -			strbuf_insert(buf, item->offset_in_buf + offset,
      -				      commands, commands_len);
     --			offset += commands_len;
      +	/*
      +	 * Insert <commands> after every pick. Here, fixup/squash chains
      +	 * are considered part of the pick, so we insert the commands *after*
      +	 * those chains if there are any.
      +	 */
     -+	insert_final_commands = 1;
     -+	for (i = 0; i < todo_list.nr; ) {
     ++	insert = -1;
     ++	for (i = 0; i < todo_list.nr; i++) {
      +		enum todo_command command = todo_list.items[i].command;
     -+		int j = 0;
      +
     -+		if (command != TODO_PICK && command != TODO_MERGE) {
     -+			i++;
     -+			continue;
     -+		}
     -+
     -+		/* skip fixup/squash chain, if any */
     -+		for (i++; i < todo_list.nr; i++, j = 0) {
     -+			command = todo_list.items[i].command;
     -+
     -+			if (is_fixup(command))
     ++		if (insert >= 0) {
     ++			/* skip fixup/squash chains */
     ++			if (command == TODO_COMMENT)
      +				continue;
     -+
     -+			if (command != TODO_COMMENT)
     -+				break;
     -+
     -+			/* skip comment if followed by any fixup/squash */
     -+			for (j = i + 1; j < todo_list.nr; j++)
     -+				if (todo_list.items[j].command != TODO_COMMENT)
     -+					break;
     -+			if (j < todo_list.nr &&
     -+			    is_fixup(todo_list.items[j].command)) {
     -+				i = j;
     ++			else if (is_fixup(command)) {
     ++				insert = i + 1;
      +				continue;
      +			}
     -+			break;
     ++			strbuf_insert(buf,
     ++				      todo_list.items[insert].offset_in_buf +
     ++				      offset, commands, commands_len);
     + 			offset += commands_len;
     ++			insert = -1;
       		}
      -		first = 0;
      +
     -+		if (i >= todo_list.nr) {
     -+			insert_final_commands = 1;
     -+			break;
     -+		}
     -+
     -+		strbuf_insert(buf, todo_list.items[i].offset_in_buf + offset,
     -+			      commands, commands_len);
     -+		offset += commands_len;
     -+		insert_final_commands = 0;
     ++		if (command == TODO_PICK || command == TODO_MERGE)
     ++			insert = i + 1;
       	}
       
       	/* append final <commands> */
      -	strbuf_add(buf, commands, commands_len);
     -+	if (insert_final_commands)
     ++	if (insert >= 0 || !offset)
      +		strbuf_add(buf, commands, commands_len);
       
       	i = write_message(buf->buf, buf->len, todo_file, 0);

-- 
gitgitgadget
