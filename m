Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 634CC2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 21:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbdHGVTQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 17:19:16 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37069 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbdHGVTP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 17:19:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id p13so1446017pfd.4
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 14:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XdT/ZyF0ohHY3BcprReND2EMZtPAZoFQEMX0D6A8RJM=;
        b=bKhHBPCytjskST0HDNslHW+KKM3alF44OU7cYtC6tLrsO6LK6NsGZBaCfRZCaPVla7
         jy/OjKZBZHPWEYhmmLF3B+0yh+8j+hV0yi6YT9YKGOYSx/ilaIkgOqmSBZsOl6561VMf
         KPIF/zRppuRdfswq/rqVWgF4cTkoPTOPRkjwY+kd4yKRAbOMtYjCUEU8/CizDkQEe2pK
         WLjUJ1iQ1RTeTNlA/Ock0VazH3rDKiUAkpek9pqM2tF6ypBEJqI5ACkLuVJFq0XaSUZt
         X90oag5CozSyRa/weubjRNSJuUPfa7KShkXUdblCE4yo2YrMYMNe/pFv3uTXqeNj5Nul
         XQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XdT/ZyF0ohHY3BcprReND2EMZtPAZoFQEMX0D6A8RJM=;
        b=kgIrpu5BmrHP8LVRwn7SjvZw+aS9kMP0UvSQqr/NQMhlkEIrfLBtNMRx8tiaAiKNlm
         9lSoWkes9OAtCaL8plSdngySbotIYLIQs6mXn7rCpruyHTM04aXBPxKWQmEOTsvxsv+N
         zbsHCs2kW6h0IeUpGYGcSRtXZCiVosY1HwTbTN+mgtpcuuzb6QsqDBle0wCOIYnHktxJ
         vQHiZVP/JFZseaAV+/NQAIGLiZXIw0bS+Jq3kjOzLnP4dgano3szu0NfGZ802kJycfSs
         dFRXMm10GQ0pgwd8W5zPLGsy1EbPNTHOrJCgDVqj5pZTRvB127CMF+CMQ0dUcRsrX2ZW
         kZug==
X-Gm-Message-State: AHYfb5j9v8XUTO45yMZZd0rJA0oOqhtXJ7eU7TrBDZLE+ueQVsAWn4qV
        kuSM2tw5KqN+2kHX1pY=
X-Received: by 10.98.83.130 with SMTP id h124mr1982216pfb.13.1502140754055;
        Mon, 07 Aug 2017 14:19:14 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:6016:3285:fd77:5453:49e2:f3b5])
        by smtp.gmail.com with ESMTPSA id z127sm15141084pfb.64.2017.08.07.14.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 14:19:13 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 00/13] Update: Week-12
Date:   Tue,  8 Aug 2017 02:48:47 +0530
Message-Id: <20170807211900.15001-1-pc44800@gmail.com>
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
  submodule subcommands:
  - deinit
  - summary
  - foreach

* summary: the function print_submodule_summary() is split-up
  into two separate functions: generate_submodule_summary()
  and print_summary().

* porting of submodule subcommand 'add' is completed and I have
  started with debugging ported function. Currently, the
  entire function cmd_add() is ported to the function
  module_add() in C. Soon, its first patch will be floated
  here as well once debugging is completed. Its progress can be
  viewed at [2].

* displaypath: Last week, there was some confusion produced
  with the way, the value of displaypath is being generated,
  which led to some discussion, which is available at: [3].

PLAN FOR WEEK-13 (8 August 2017 to 14 August 2017):

* patches: IMO, the patches till deinit are reviewed many times,
  and hence will try to get at least these patches merged.

* add: As this subcommand is widely used in the test suite, there
  are many tests this ported function is failing at. Hence,
  debugging the subcommand would be another task for the next week.

* deinit: A bug was identified by Stefan in the last patch-series.
  its details are available at: [4]
  Currenlty, the bug was handled by adding a NEEDSWORK tagged
  comment as suggest. If possible, I will also start working
  on debugging the issue asap.

A complete build report of these series of patches is available at: [5].
Build #151
Branch: week-12

The work is pushed on Github and is available at: [6].

[1]: https://docs.google.com/document/d/1krxVLooWl--75Pot3dazhfygR3wCUUWZWzTXtK1L-xU/
[2]: https://github.com/pratham-pc/git/commits/sub-add
[3]: https://public-inbox.org/git/CAME+mvXsh53kLJ4se4uKY=SJcvSbHtEZQ6K2CgAPs=1wxUxk1A@mail.gmail.com/
[4]: https://public-inbox.org/git/CAGZ79kbyyR54me_+wQDZRrikqKTp_a98yozVfr8P85QHfyyy=Q@mail.gmail.com/
[5]: https://travis-ci.org/pratham-pc/git/builds/
[6]: https://github.com/pratham-pc/git/commits/week-12

Prathamesh Chavan (13):
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
 builtin/submodule--helper.c     | 1190 ++++++++++++++++++++++++++++++++++++++-
 diff.c                          |    2 +-
 diff.h                          |    1 +
 git-submodule.sh                |  396 +------------
 t/t7407-submodule-foreach.sh    |   38 +-
 6 files changed, 1222 insertions(+), 420 deletions(-)

-- 
2.13.0

