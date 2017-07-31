Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64F811F991
	for <e@80x24.org>; Mon, 31 Jul 2017 20:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbdGaU4p (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 16:56:45 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37092 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbdGaU4m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 16:56:42 -0400
Received: by mail-pg0-f68.google.com with SMTP id 83so510686pgb.4
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 13:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9/n5v6zIDGSGD9UI2JuRfzhXvrZncEEMoAV7pCIaOl4=;
        b=L3QDjSEjEmVjMqwn3OYel0IyqV2xek9qhL37d8xc+TEGNHxQO0A751bxfLagCKj7AO
         JKYP+hweM2lwJJcyW8sodfrPeZVV23Krb7Rs+wP0WszL0avcQKry6wNGrHztPhyENsBe
         KhRsNoZlnZz+tj5skXB745TK8weI9zuF8hRsG3XpSf41aqS88Uw2iH0ROrWnNcM2VAZl
         XtXZJcvlLXmzY7wUEAcgit/ONK0IMSh/o9YBlrszg1HXp4x5i9hSMH7StN8fk00Sdt7R
         IeEp06lykXzzOcstocYP7YfOOWOaxZgOmC+IDGi7N9Yxgoa+CX8ijrc3lZ+HxvbAAA82
         qXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9/n5v6zIDGSGD9UI2JuRfzhXvrZncEEMoAV7pCIaOl4=;
        b=Tb/kGq3bAdsgXgLsTEr3BhzINLmAs1werGJGxS3iWkzYiBeSF4doYN44+zZgFMc5W1
         TkshWnZKNTxOwybWwoOMKgl75hHJHaL9qeml6Bwq1GZqFnrwW7ojA64slpIs97UhTLob
         L16Q+aVc5cE4gqMUmY0WDVr9zKln5wJhDmIyuJwuMZtkAtLMlcfMkPu3ZK41v4r13qCN
         5bo7rhuwXuyOMn1dFozXy84PVLXrsKeERuy+vBTGFpROPyPct78pHpJNWjyhWQmxcOoU
         lFxG1VzCSiL5K2DCF0cQYrVm+lwO9huOZzhWx+b+czTCyKlxRBLWgkLQW0HntwUCSgiv
         Bs4w==
X-Gm-Message-State: AIVw113Ezqjf404FfarFiAe6WZnD1AclBvcqZxb7wKAmPE2wms8gLLH7
        6Ya6yLdl+TugaRq9GWke4A==
X-Received: by 10.84.209.170 with SMTP id y39mr18184352plh.194.1501534601305;
        Mon, 31 Jul 2017 13:56:41 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:6182:3b53:5da6:3508:cb8e:5545])
        by smtp.gmail.com with ESMTPSA id 16sm52881007pfq.151.2017.07.31.13.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Jul 2017 13:56:40 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 00/13] Update: Week-11
Date:   Tue,  1 Aug 2017 02:26:08 +0530
Message-Id: <20170731205621.24305-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SUMMARY OF MY PROJECT:

Git submodule subcommands are currently implemented by using shell script
'git-submodule.sh'. There are several reasons why we'll prefer not to
use the shell script. My project intends to convert the subcommands into
C code, thus making them builtins. This will increase Git's portability
and hence the efficiency of working with the git-submodule commands.
Link to the complete proposal: [1]

Mentors:
Stefan Beller <sbeller@google.com>
Christian Couder <christian.couder@gmail.com>

UPDATES:

Following are the updates about my ongoing project:

* Following patches were updated after the previous reviews:
  - set_name_rev()
  submodule subcommands:
  - status
  - sync
  - deinit
  - summary
  - foreach

* Reviews from both Christian Couder <christian.couder@gmail.com> and
  Brandon Williams <bmwill@google.com> helped in improvising these patches
  and their suggestions were implemented.

* Porting of submodule subcommand add is still underway. Its progess can be
  viewed at [2].

PLAN FOR WEEK-12 (1 August 2017 to 7 August 2017):

* summary: One of the problems pointed out by Brandon this week was that
  the function print_submodule_summary() was too big to keep track of
  all the things that are happening. Hence, I will be splitting the
  function into smaller functions.

* displaypath: There is some confusion produced with the way the
  value of displaypath is being generated, using super-prefix. [3]
  Via having discussion on this, I'll try to resolve the issues
  regarding it. In the patches following the update, I have addressed
  this issue as well.

* add: Porting of this subcommand is still underway and will be working
  on to completely port this subcommand.

A complete build report of these series of patches is available at: [4].
Build #145
Branch: week-11

The work is push on github and is available at: [5].

[1]: https://docs.google.com/document/d/1krxVLooWl--75Pot3dazhfygR3wCUUWZWzTXtK1    L-xU/
[2]: https://github.com/pratham-pc/git/commits/sub-add
[3]: https://public-inbox.org/git/20170724213028.GB92874@google.com/
[4]: https://travis-ci.org/pratham-pc/git/builds/
[5]: https://github.com/pratham-pc/git/commits/week-11

  submodule--helper: introduce get_submodule_displaypath()
  submodule--helper: introduce for_each_submodule_list()
  submodule: port set_name_rev() from shell to C
  submodule: port submodule subcommand 'status' from shell to C
  submodule: port submodule subcommand 'sync' from shell to C
  submodule: port submodule subcommand 'deinit' from shell to C
  diff: change scope of the function count_lines()
  submodule: port submodule subcommand 'summary' from shell to C
  submodule foreach: correct '$path' in nested submodules from a
    subdirectory
  submodule foreach: document '$sm_path' instead of '$path'
  submodule foreach: clarify the '$toplevel' variable documentation
  submodule foreach: document variable '$displaypath'
  submodule: port submodule subcommand 'foreach' from shell to C

 Documentation/git-submodule.txt |   15 +-
 builtin/submodule--helper.c     | 1175 ++++++++++++++++++++++++++++++++++++++-
 diff.c                          |    2 +-
 diff.h                          |    1 +
 git-submodule.sh                |  394 +------------
 t/t7407-submodule-foreach.sh    |   38 +-
 6 files changed, 1207 insertions(+), 418 deletions(-)

-- 
2.13.0

