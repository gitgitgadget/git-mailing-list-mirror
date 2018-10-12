Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3054F1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 13:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbeJLUqu (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 16:46:50 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:40688 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbeJLUqt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 16:46:49 -0400
Received: by mail-pf1-f182.google.com with SMTP id s5-v6so6189498pfj.7
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 06:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=emi+1pVIxPB/X03Gr/+MdJOenKDume5GgbU72ObEnnY=;
        b=UwXFpQbDFEvRQRIVGO22mvu6L1vzJmg9yguZAmEwyJuuXjeCjfg6Gkj23hnORgeS9a
         9JivULjozy9PwP598WePYnIiBysXAd+9+s4ntAIRLgBCQdXK4tgMR4ukkaNOo38+9Lne
         vsYEO9CNXTwbNus7zqLHPwQ2jgVndz39D6ntdXGzmOMKBrW2mVYaARfM1RywSwCRQBao
         eQZeh8A2i+vB7KdUIFzrzHKY73MasvA4xxfwdzueh4WZFXJOMr+lpiiPG1Vq66g9+Lrk
         6JGVgnkbNScklDvrTYh7BD1qtaIqLH3LeDCLXLl8ETtFc2lyVlQUPANZdtKBdJtZUHnu
         Co7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=emi+1pVIxPB/X03Gr/+MdJOenKDume5GgbU72ObEnnY=;
        b=kmSLeriHdt9QSHqYDWB9Qn0EtYSgkQJeacViNqY+43Nec1LNSK560Gacx2oyvHU9ob
         HpK4w7jqp7JMBs1c8rp9n/z+pNS0do9T4mbhqWFBzYAvGlE9A1SMMavcPmO8LvIcj/+D
         HjawWLWsr2eLlmANGw6lDcKMcMU2j+LzlLfXPUwzc5KBDs+0poXXs60ArOxwkKLxIAyg
         8SoFSsLvhoB+0XZJJSoBGt2TI5K3GhMvsEVdK6NBSs6lcJ6pfs6TTgdU3CFT4QgBqCpj
         HglsenJxmHxLtxELK+k6NkxnHO9R/3haueXx5QirC81+UH12kwcOaT8cTkDxW1A0MLZJ
         voMw==
X-Gm-Message-State: ABuFfogARFdA41safgrEYnQskkjzxtj4SOlI+TRDrOhTmrNv/hT5Hf88
        HEHNFh6dXY5rs8Y7DZPWwciGRF7l
X-Google-Smtp-Source: ACcGV63FCcDcm0u9+6xw6ikkvjcaHJSk1iPS6RlG9Erxl8Mp89Lz7tCpwNbf4CwBSyXcs37Z67WRlw==
X-Received: by 2002:a63:fb09:: with SMTP id o9-v6mr5528644pgh.333.1539350064314;
        Fri, 12 Oct 2018 06:14:24 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id l83-v6sm4075034pfi.172.2018.10.12.06.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 06:14:23 -0700 (PDT)
Date:   Fri, 12 Oct 2018 06:14:23 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Oct 2018 13:14:19 GMT
Message-Id: <pull.43.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.43.v2.git.gitgitgadget@gmail.com>
References: <pull.43.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/2] rebase -i: introduce the 'break' command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan asked a while back
[https://public-inbox.org/git/20180118183618.39853-3-sbeller@google.com/] 
for a todo command in interactive rebases that would essentially perform the
"stop" part of the edit command, but without the "pick" part: interrupt the
interactive rebase, with exit code 0, letting the user do things and stuff
and look around, with the idea of continuing the rebase later (using git
rebase --continue).

This patch introduces that, based on ag/rebase-i-in-c.

Changes since v2:

 * Fixed two typos.
 * When interrupting the rebase, break now outputs a message.

Changes since v1:

 * Wrapped the commit message correctly.
 * Added a preparatory patch to mention what happens in case an exec fails.
 * Mentioned the break command in the git-rebase(1) documentation.

Cc: Stefan Beller sbeller@google.com [sbeller@google.com]Cc: Eric Sunshine 
sunshine@sunshineco.com [sunshine@sunshineco.com]

Johannes Schindelin (2):
  rebase -i: clarify what happens on a failed `exec`
  rebase -i: introduce the 'break' command

 Documentation/git-rebase.txt |  6 +++++-
 rebase-interactive.c         |  1 +
 sequencer.c                  | 24 +++++++++++++++++++++++-
 t/lib-rebase.sh              |  2 +-
 t/t3418-rebase-continue.sh   |  9 +++++++++
 5 files changed, 39 insertions(+), 3 deletions(-)


base-commit: 34b47315d9721a576b9536492cca0c11588113a2
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-43%2Fdscho%2Frebase-i-break-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-43/dscho/rebase-i-break-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/43

Range-diff vs v2:

 1:  2eefdb4874 ! 1:  92512a82d2 rebase -i: clarify what happens on a failed `exec`
     @@ -15,8 +15,8 @@
       	Append "exec <cmd>" after each line creating a commit in the
       	final history. <cmd> will be interpreted as one or more shell
      -	commands.
     -+	commands. Anz command that fails will interrupt the rebase,
     -+	withe exit code 1.
     ++	commands. Any command that fails will interrupt the rebase,
     ++	with exit code 1.
       +
       You may execute several commands by either using one instance of `--exec`
       with several commands:
 2:  c74e02c4b6 ! 2:  d44b425709 rebase -i: introduce the 'break' command
     @@ -71,13 +71,37 @@
       		if (bol != eol)
       			return error(_("%s does not accept arguments: '%s'"),
       				     command_to_string(item->command), bol);
     +@@
     + 	return update_ref(NULL, "ORIG_HEAD", &oid, NULL, 0, UPDATE_REFS_MSG_ON_ERR);
     + }
     + 
     ++static int stopped_at_head(void)
     ++{
     ++	struct object_id head;
     ++	struct commit *commit;
     ++	struct commit_message message;
     ++
     ++	if (get_oid("HEAD", &head) || !(commit = lookup_commit(&head)) ||
     ++	    parse_commit(commit) || get_message(commit, &message))
     ++		fprintf(stderr, _("Stopped at HEAD\n"));
     ++	else {
     ++		fprintf(stderr, _("Stopped at %s\n"), message.label);
     ++		free_message(commit, &message);
     ++	}
     ++	return 0;
     ++
     ++}
     ++
     + static const char rescheduled_advice[] =
     + N_("Could not execute the todo command\n"
     + "\n"
      @@
       			unlink(rebase_path_stopped_sha());
       			unlink(rebase_path_amend());
       			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
      +
      +			if (item->command == TODO_BREAK)
     -+				break;
     ++				return stopped_at_head();
       		}
       		if (item->command <= TODO_SQUASH) {
       			if (is_rebase_i(opts))

-- 
gitgitgadget
