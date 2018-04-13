Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1164C1F424
	for <e@80x24.org>; Fri, 13 Apr 2018 10:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753784AbeDMKDm (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 06:03:42 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:36956 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbeDMKDl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 06:03:41 -0400
Received: from [192.168.2.201] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id 6vYPfXnCdLjjA6vYPfUH4i; Fri, 13 Apr 2018 11:03:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1523613819;
        bh=Z1H6743YFTOBvbQajDq6mQnhjRfkUHX56t/x4ILf5e8=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=a4jQkNoPiFy9OKgK8IJPzO1C123sh9ppdyo5dwmi+CTqkSC3vMSGXLPMWkkveAgI7
         xDeYWCu1lcmgtSNIWNBqyNwEE2IpdQSWXxsuRmUcOWCP0xMdM0IE00k3aY0BGNyBCQ
         i4yieubwaqc37cQEcBxK/kLhTPwu7evHnyOtIOBk=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=LZYSFAXi c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=c6JxbGO7SjSxshBe0QUA:9 a=_Bwb3uRwRrITFT10:21 a=JV6XiMRsvAl1fF1m:21
 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 04/15] sequencer: introduce new commands to reset the
 revision
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
 <cover.1523362469.git.johannes.schindelin@gmx.de>
 <fb797f32b7385317b9dc18524e3863ba627f6c98.1523362469.git.johannes.schindelin@gmx.de>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <2bec489c-521e-0277-3a15-00b39126e652@talktalk.net>
Date:   Fri, 13 Apr 2018 11:03:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <fb797f32b7385317b9dc18524e3863ba627f6c98.1523362469.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMdFWgjmcym7bzXqaCS4CXQFjf8iDmfoiZ6ABIXUhJ/jPAjwAbLA10bQlxACl04ZEnq3p7L5qOa1cp9pg9ZpsbSzFnZFEQZ85J2GFAj/JAwR88FNzWcJ
 PCjgAUhg3cPQC28MB6x57hlbmk55AeSXYReURD6cq08TCQA3GlNlsggtbrjWOD8dczLTgsfrz4X/8Z6JaBIRj0kVnKTPZMlN68UIO+agAtsvj3mP6N0vCCOu
 oKb1bRMqvWAV81iNr9lclQLy8UvVnXE6X04/XBYrHf8lgjZrV/cn3OGy2tLURvVFPdlVuH2+yFdkG6J4PUrHrhoiRyUyVaL6fATdr4cobqBHuUNPzI99dZAM
 jlA8wi3G4IoegvfA+kx/zrFHd8hG89cHILlVoSH9Ty7aH3k1ck2r7TF6OzvRBNMkY3qjh+pPRV4GCKnsmv6wc1Gi5KvyCsszkNIMC56fthVh5hZIM8oizsj5
 3MHJW+4KYaSHR26m635pvUcdXkpwNjz8k6gmMg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/04/18 13:29, Johannes Schindelin wrote:
> In the upcoming commits, we will teach the sequencer to rebase merges.
> This will be done in a very different way from the unfortunate design of
> `git rebase --preserve-merges` (which does not allow for reordering
> commits, or changing the branch topology).
> 
> The main idea is to introduce new todo list commands, to support
> labeling the current revision with a given name, resetting the current
> revision to a previous state, and  merging labeled revisions.
> 
> This idea was developed in Git for Windows' Git garden shears (that are
> used to maintain Git for Windows' "thicket of branches" on top of
> upstream Git), and this patch is part of the effort to make it available
> to a wider audience, as well as to make the entire process more robust
> (by implementing it in a safe and portable language rather than a Unix
> shell script).
> 
> This commit implements the commands to label, and to reset to, given
> revisions. The syntax is:
> 
> 	label <name>
> 	reset <name>
> 
> Internally, the `label <name>` command creates the ref
> `refs/rewritten/<name>`. This makes it possible to work with the labeled
> revisions interactively, or in a scripted fashion (e.g. via the todo
> list command `exec`).
> 
> These temporary refs are removed upon sequencer_remove_state(), so that
> even a `git rebase --abort` cleans them up.
> 
> We disallow '#' as label because that character will be used as separator
> in the upcoming `merge` command.
> 
> Later in this patch series, we will mark the `refs/rewritten/` refs as
> worktree-local, to allow for interactive rebases to be run in parallel in
> worktrees linked to the same repository.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

If a label or reset command fails it is likely to be due to a
typo. Rescheduling the command would make it easier for the user to fix
the problem as they can just run 'git rebase --edit-todo'. It also
ensures that the problem has actually been fixed when the rebase
continues. I think you could do it like this

--->8---
From: Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] fixup! sequencer: introduce new commands to reset the revision

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 809df1ce48..e1b9be7327 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3029,6 +3029,13 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		} else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
+		if (res < 0 && (item->command == TODO_LABEL ||
+				item->command == TODO_RESET)) {
+			/* Reschedule */
+			todo_list->current--;
+			save_todo(todo_list, opts);
+			return res;
+		}
 		todo_list->current++;
 		if (res)
 			return res;
-- 
2.17.0
