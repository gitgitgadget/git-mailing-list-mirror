Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AA871F405
	for <e@80x24.org>; Thu,  9 Aug 2018 09:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbeHIMFM (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 08:05:12 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:47034 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbeHIMFM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 08:05:12 -0400
Received: by mail-pf1-f174.google.com with SMTP id u24-v6so2571028pfn.13
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 02:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=131hk6RzFEvjpFxfczYCJF1hq1ZGnUpWpux7y9gWLtE=;
        b=JGKsXlBgBMV3OArXwOoBVlttI3hcptmFP0GSe4rTEaxaxY2tjjZ8cyYL1ZK4IhCYiw
         OCPC/Nn1TaYI2i65tRYUlGu4UPvWJuxU9B80l3Rd0BOMI9bd4RC9jlBeJBH68IribZEt
         p+Buj7hHr5TH6dR6CfsbTZurXo58YYbaKU7g4KKG8njarU2XaxRDeXPofaleALJK3R3r
         wMw90/fLHVl1+/k2AxhbGvmIBNa0pkECQ9lZu/DrXyxOntg7QdrwrpYRSotsqZZHJTbN
         JYGHHeNCddwKfaf4Qp7rA389a5menSw/lKik5oMe5pV7TbtQJyxm2FgGeKWDhyie3bww
         Mbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=131hk6RzFEvjpFxfczYCJF1hq1ZGnUpWpux7y9gWLtE=;
        b=OEYZL4+W+4biErtIxTfnC7Zdos/a4j0bLtrLf5yRZyzRbqrSEk7Yhi95UyZluShm+u
         Fmjub/VVsI2+mLT8g3BtiTAqhULAITs4WBpyeMX3tDwwFt/D+ZiBw6Btqh8EOGiJDnZN
         NFyMqno+YwaXC/136JE2o4jC2GTOJ6gOsHgvvbJy6mDl2ISjGZXWTNwIcfpHzEckbcTT
         SFqkG4Q1TnVyI0bEN4FnwPAu4arOXigtyDJNcQ20yXerXVIP5N7DGO5tpszC5RPNkc2P
         fxe8KcPcIz3TQkpzTxPmCwEGuneJLpGEloGcdDdAzZY7GvOCIJcheW3fR/FXjY6ACdAx
         S5QQ==
X-Gm-Message-State: AOUpUlEO4PzBrKH7Iyt0LCXk75lTbeDsTBCpO64oKk+Aip7BpLCvoXvq
        hPdi5M+ccXKTe3qj4HBrVL7TiFvO
X-Google-Smtp-Source: AA+uWPyKxIYDKMUEWk5IKzU3PEz1PYbMs8ToxFUQd6lYDJYKmoSHt6LAWqMOrx3/qAl06x5DipnqXQ==
X-Received: by 2002:a62:c60e:: with SMTP id m14-v6mr1645706pfg.40.1533807669375;
        Thu, 09 Aug 2018 02:41:09 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id z20-v6sm15981993pfd.99.2018.08.09.02.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 02:41:08 -0700 (PDT)
Date:   Thu, 09 Aug 2018 02:41:08 -0700 (PDT)
X-Google-Original-Date: Thu, 09 Aug 2018 09:41:04 GMT
Message-Id: <pull.13.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.13.v2.git.gitgitgadget@gmail.com>
References: <pull.13.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/2] Make git rebase work with --rebase-merges and --exec
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

Fix this issue by using a correct implementation instead, that even takes
into account merge commands in the --rebase-merges mode.

Changes since v1:

 * Replaced the "look-ahead" design by a "keep looking" one: instead of
   having a nested loop that looks for the end of the fixup/squash chain, we
   continue the loop, delaying the insertion until we know where the
   fixup/squash chain ends, if any.

Johannes Schindelin (2):
  t3430: demonstrate what -r, --autosquash & --exec should do
  rebase --exec: make it work with --rebase-merges

 sequencer.c              | 42 +++++++++++++++++++++++++++++-----------
 t/t3430-rebase-merges.sh | 17 ++++++++++++++++
 2 files changed, 48 insertions(+), 11 deletions(-)


base-commit: 1d89318c48d233d52f1db230cf622935ac3c69fa
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-13%2Fdscho%2Frebase-merges-and-exec-commands-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-13/dscho/rebase-merges-and-exec-commands-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/13

Range-diff vs v2:

 1:  1d82eb450 = 1:  1d82eb450 t3430: demonstrate what -r, --autosquash & --exec should do
 2:  7ca441a89 ! 2:  b436f67ba rebase --exec: make it work with --rebase-merges
     @@ -22,6 +22,11 @@
          `pick` lines, skip any fixup/squash chains, and then insert the `exec`
          line. Lather, rinse, repeat.
      
     +    Note: we take pains to insert *before* comment lines whenever possible,
     +    as empty commits are represented by commented-out pick lines (and we
     +    want to insert a preceding pick's exec line *before* such a line, not
     +    afterward).
     +
          While at it, also add `exec` lines after `merge` commands, because they
          are similar in spirit to `pick` commands: they add new commits.
      
     @@ -81,9 +86,13 @@
      +			insert = i + 1;
       	}
       
     - 	/* append final <commands> */
     +-	/* append final <commands> */
      -	strbuf_add(buf, commands, commands_len);
     -+	if (insert >= 0 || !offset)
     ++	/* insert or append final <commands> */
     ++	if (insert >= 0 && insert < todo_list.nr)
     ++		strbuf_insert(buf, todo_list.items[insert].offset_in_buf +
     ++			      offset, commands, commands_len);
     ++	else if (insert >= 0 || !offset)
      +		strbuf_add(buf, commands, commands_len);
       
       	i = write_message(buf->buf, buf->len, todo_file, 0);

-- 
gitgitgadget
