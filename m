Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 421C720305
	for <e@80x24.org>; Wed, 17 Apr 2019 14:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbfDQOc7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 10:32:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33488 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbfDQOc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 10:32:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id q1so32301186wrp.0
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=Hksq55gLcaOS/NlTqUSUVdIRKzDMaDzmtEtnkelthFk=;
        b=lSeezFZj0XmQaAvXm84MHsXaZHP4YNyEf23EDUlDFI5SVFry1aeeZRJBQj8RpWkDhe
         TvRUPppsh98hFoo3tHjp6IaGgo9vR+QxOzU41bvVJ6ZCF4ctyf/l1kfgUslE3olHVe/r
         xTpg4Mu7hGes5jweZdkWhG/joXuBOhf5Pso7LKPtJaihf+AqAhCu943U3/9W7s0PxszG
         joMnJe2mi6lbGWA3M39aNnQPM9dzkm1thJuJ+ta7dw0WF2gXFTYI6DtzWfsN6gpeZJ03
         L0AEB1BlGZD7joIXCRlwSg47Pxshy0srP/Mtf0fIe2glnpIsQV0EC1/0CODcJleKCkS6
         AI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=Hksq55gLcaOS/NlTqUSUVdIRKzDMaDzmtEtnkelthFk=;
        b=dGEPcrRrKCE6IZVgU1xpvpmNv7GayOC/9XWyj2Wbhd+nR+Iv/pxJt3KOb8q4vlrHLj
         HoVUg3Wg1BrgKkamohO+ylvzB8WYbH0baTxu6eoCiCIZMNqsmTyWrvLdYP3B9Hx+binv
         wWv0dJ8f8DIzfhbN8xOemlbNJAhJVunvYU2YxZdhipY2GRGzs5qrxNl4/Ov41iCo2Aou
         rXh+zZaazmiXVsL2nf0sBmc8mb41Q+1TGCTwlBw6M9sBjSPCm8Y43fyccMWC7Deco2sJ
         3NfZ7dxLRYIKD782L7c0LgyMJ3g6c/JYv0LAu6k6JpBEArhww2dcdgDjXWk4Dx2kE41n
         oWvA==
X-Gm-Message-State: APjAAAUxcCC/H51Mdj1VxNlR7JIfKNNudqrsZcfF+3L1PHBUjTfG1WpF
        Cpl4GMJt2+7MTi4czLNzqDQoVLsfzAk=
X-Google-Smtp-Source: APXvYqyzodNNL74bun1y7rkiyiiOf8mOeg0cVNCkBkhUx51n/zqQT0ii/AwbFOGVicwwzTBmjy/luA==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr53989952wrs.155.1555511576675;
        Wed, 17 Apr 2019 07:32:56 -0700 (PDT)
Received: from localhost.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id t17sm52127726wrr.26.2019.04.17.07.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 07:32:56 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 00/12] Run rebase -i without forking rebase--interactive
Date:   Wed, 17 Apr 2019 15:30:32 +0100
Message-Id: <20190417143044.17655-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319190317.6632-1-phillip.wood123@gmail.com>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks for the feedback on the last version. I've updated the final
commit message to mention the speed up reported by Ævar. I've also
removed the translation of the trace strings. Apart from that this
series is unchanged. There shouldn't be any merge conflicts with the
updated dl/merge-cleanup-scissors-fix I posted earlier. (There are
conflicts with other series but they are already resolved in pu)

This series still based on a merge of master [e902e9bcae ("The second
batch", 2019-03-11)] and ag/sequencer-reduce-rewriting-todo ed35d18841
("rebase--interactive: move transform_todo_file()", 2019-03-05). It
can be fetched from the tag rebase-i-no-fork/v1 at
https://github.com/phillipwood/git.git

Phillip Wood (12):
  sequencer: always discard index after checkout
  rebase: don't translate trace strings
  rebase: rename write_basic_state()
  rebase: use OPT_RERERE_AUTOUPDATE()
  rebase -i: combine rebase--interactive.c with rebase.c
  rebase -i: remove duplication
  rebase -i: use struct commit when parsing options
  rebase -i: use struct object_id for squash_onto
  rebase -i: use struct rebase_options to parse args
  rebase -i: use struct rebase_options in do_interactive_rebase()
  rebase: use a common action enum
  rebase -i: run without forking rebase--interactive

 Makefile                      |   1 -
 builtin/rebase--interactive.c | 377 --------------------
 builtin/rebase.c              | 624 ++++++++++++++++++++++++++--------
 parse-options-cb.c            |  34 ++
 parse-options.h               |   4 +
 sequencer.c                   |  42 ++-
 sequencer.h                   |   7 +-
 7 files changed, 555 insertions(+), 534 deletions(-)
 delete mode 100644 builtin/rebase--interactive.c

Range-diff to rfc
 1:  549d45dc63 =  1:  fe51202dfb sequencer: always discard index after checkout
 -:  ---------- >  2:  2598165c0f rebase: don't translate trace strings
 2:  d896a3c76f =  3:  48801ccdd5 rebase: rename write_basic_state()
 3:  253de33871 =  4:  66972f0f7d rebase: use OPT_RERERE_AUTOUPDATE()
 4:  0aaeaf7c09 =  5:  c18aa58305 rebase -i: combine rebase--interactive.c with rebase.c
 5:  ff539c37d1 =  6:  27982630d1 rebase -i: remove duplication
 6:  71559a38db =  7:  f28e8df52a rebase -i: use struct commit when parsing options
 7:  34c9e4ae96 =  8:  1ae13b5a7d rebase -i: use struct object_id for squash_onto
 8:  4fe81c9e81 !  9:  efcc32d8e3 rebase -i: use struct rebase_options to parse args
    @@ -65,9 +65,9 @@
     +{
     +	struct replay_opts replay = REPLAY_OPTS_INIT;
     +
    -+	sequencer_init_config(&replay);
    -+
     +	replay.action = REPLAY_INTERACTIVE_REBASE;
    ++	sequencer_init_config(&replay);
    ++
     +	replay.signoff = opts->signoff;
     +	replay.allow_ff = !(opts->flags & REBASE_FORCE);
     +	if (opts->allow_rerere_autoupdate)
 9:  09343e540f = 10:  c89d815ad4 rebase -i: use struct rebase_options in do_interactive_rebase()
10:  9ad1482d7f ! 11:  fda591f006 rebase: use a common action enum
    @@ -38,14 +30,13 @@
     +	ACTION_ADD_EXEC
     +};
     +
    -+static const char *action_names[] = { N_("undefined"),
    -+				      N_("continue"),
    -+				      N_("skip"),
    -+				      N_("abort"),
    -+				      N_("quit"),
    -+				      N_("edit_todo"),
    -+				      N_("show_current_patch"),
    -+				      NULL };
    ++static const char *action_names[] = { "undefined",
    ++				      "continue",
    ++				      "skip",
    ++				      "abort",
    ++				      "quit",
    ++				      "edit_todo",
    ++				      "show_current_patch" };
     +
      static int add_exec_commands(struct string_list *commands)
      {
    @@ -173,14 +164,13 @@
     -		ACTION_EDIT_TODO,
     -		ACTION_SHOW_CURRENT_PATCH,
     -	} action = NO_ACTION;
    --	static const char *action_names[] = { N_("undefined"),
    --					      N_("continue"),
    --					      N_("skip"),
    --					      N_("abort"),
    --					      N_("quit"),
    --					      N_("edit_todo"),
    --					      N_("show_current_patch"),
    --					      NULL };
    +-	static const char *action_names[] = { "undefined",
    +-					      "continue",
    +-					      "skip",
    +-					      "abort",
    +-					      "quit",
    +-					      "edit_todo",
    +-					      "show_current_patch" };
     +	enum action action = ACTION_NONE;
      	const char *gpg_sign = NULL;
      	struct string_list exec = STRING_LIST_INIT_NODUP;
11:  ebfd7f80d9 ! 12:  d921226d32 rebase -i: run without forking rebase--interactive
    @@ -7,10 +7,18 @@
         `rebase--interactive`. Separate the option parsing in
         cmd_rebase__interactive() from the business logic to allow interactive
         rebases can be run without forking `rebase__interactive` by calling
    -    run_rebase_interactive() directly. This makes it easy to debug the
    -    sequencer without worrying about attaching to child processes. It also
    -    makes it easy to remove cmd_rebase__interactive() in the future when
    -    git-legacy-rebase.sh and git-rebase--preserve-merges.sh are retired.
    +    run_rebase_interactive() directly.
    +
    +    Starting interactive rebases without forking makes it easy to debug
    +    the sequencer without worrying about attaching to child
    +    processes. Ævar has also reported that some of the rebase perf tests
    +    are 30% faster [1].
    +
    +    This patch also makes it easy to remove cmd_rebase__interactive() in
    +    the future when git-legacy-rebase.sh and
    +    git-rebase--preserve-merges.sh are retired.
    +
    +    [1] https://public-inbox.org/git/87y359cfjj.fsf@evledraar.gmail.com/

         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>

--
2.21.0

