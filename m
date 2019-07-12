Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 319AB1F461
	for <e@80x24.org>; Fri, 12 Jul 2019 18:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfGLS4o (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 14:56:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33016 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfGLS4o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 14:56:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so4698873pfq.0
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 11:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=peGKA2WHVQbWg3qQsH3wXisqbnUOvnHvFTI7YyQnC3U=;
        b=YHkH8FsE8EFtwuOf0KQHlNWeyilUijCGbHB7DqaIGEXJBm26TSotp1ED9FGB/dCy/o
         poaygbcitALXDYgY5+31GwPrZBYvEDcDhfgRMdBcggLJu6cqs1Yax23BZd3yvAihs7S+
         A2aB8X97ABNAuUg9IQFomL219XG26kndhSe1hxtusuYKVDKjLWYlB+5WKP1/GQhKTVS5
         lbPyeT4whWCOK6eErkWgJz/rnvW+EponmyFxEHvmphk/5zZk9DMgP5Opi22evEEnBIAx
         fOaKij6kUAOSyWV/80fKKp20ueSxGMr4a3JoADghWs8vyOrDRM0I5uXQzp6AbvYX33z6
         drKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=peGKA2WHVQbWg3qQsH3wXisqbnUOvnHvFTI7YyQnC3U=;
        b=Tz6Qo+dA75w4L834DOBFoKrXdHQFjuSeHNX+RgSUKBVD85fBWuK28n1NviF+5+9LZD
         DKlDxKmBeOaXD46Bm8ALK2iVR//dyP7+jHYR0ApAddxA6qqjzB3rOlDgRLi3cF2YuuH9
         jamIjovdJ3+X/1HsPYGohVXeI9sZ+5CcbwViG6lOmqkXX1p8hMMFTODdxs2s08N+MPtJ
         8RSAdXl8aTPlodDgXmxeFS8JkYwir89iO8WSBPRsLoLefHTn0YN6Vld/m5IraualgvnI
         243EBfy6SoBO7IhmpVri34TZqBAe7zH0BMlSQj7WI9IqiWwkx7QsO0o0uIdqJPfBqG9z
         5nbQ==
X-Gm-Message-State: APjAAAWNcxi4gOWvjedGm1kJIkFaExF4OZsK3NC2zcJNVi+dKn1rTUaO
        lE+kydfZBLAMEZtuf9g6e56MQUdvHPw=
X-Google-Smtp-Source: APXvYqxYYk1UPkoZoraec/hgzRiw2+/tsLXzKvEIEdcEMeKTSdsfSB7z9whOf7EbK5fbcFpcxv3Clw==
X-Received: by 2002:a17:90a:9bca:: with SMTP id b10mr13817408pjw.90.1562957802816;
        Fri, 12 Jul 2019 11:56:42 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.218])
        by smtp.gmail.com with ESMTPSA id m11sm1431207pgl.8.2019.07.12.11.56.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 11:56:42 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     phillip.wood123@gmail.com, martin.agren@gmail.com,
        Johannes.Schindelin@gmx.de, newren@gmail.com, t.gummerer@gmail.com,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: [GSoC][PATCH 0/2] rebase -i: support --committer-date-is-author-date
Date:   Sat, 13 Jul 2019 00:23:55 +0530
Message-Id: <20190712185357.21211-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190712185015.20585-1-rohit.ashiwal265@gmail.com>
References: <20190712185015.20585-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rebase am already has this flag to "lie" about the committer date, i.e., by
changing it to the author date. Let's add the same for interactive machinery.
This will get us a step closer to the ultimate aim of achieving consistency
between sequencer commands.

NB: To reduce merge conflicts on the reviewer's part, I've based this patch
series on my previous patch series[1].

[1]: https://public-inbox.org/git/20190712185015.20585-1-rohit.ashiwal265@gmail.com/

Rohit Ashiwal (2):
  sequencer: add NULL checks under read_author_script
  rebase -i: support --committer-date-is-author-date

 Documentation/git-rebase.txt            |  7 ++-
 builtin/rebase.c                        | 23 +++++++--
 sequencer.c                             | 62 +++++++++++++++++++++++--
 sequencer.h                             |  1 +
 t/t3422-rebase-incompatible-options.sh  |  1 -
 t/t3431-rebase-options-compatibility.sh | 15 ++++++
 6 files changed, 97 insertions(+), 12 deletions(-)

-- 
2.21.0

