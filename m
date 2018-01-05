Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 353281F406
	for <e@80x24.org>; Fri,  5 Jan 2018 09:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbeAEJM4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 04:12:56 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:46571 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751261AbeAEJMx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 04:12:53 -0500
Received: by mail-wm0-f53.google.com with SMTP id r78so1192412wme.5
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 01:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eKWxTPJ8ySiw4Mg5WCqpHROMwJIlyrK/OCBD0n+gFJ4=;
        b=AMWeE//i2bHHysa4PNw5jswsjI9Gq9lkW2SJ3kKvfzd/fZf9h41ExTa0kXZzDHgxsx
         uaDCH2dCPFNCzMHBfUtRGxpP2niBQFReuVEh2p5zj33BS/hWl96QomsNepjbmpzbtD1s
         Tc8MnwzSmDy5OBTsjlrYMIhhDA6tgUzn9wT2cNpDByMQgogBwvmKjMm6jg8Bh0sjqPzV
         /OBJ/E+JIjrynhYBWko4pd2Ow/NXSK9iBAR2mG3q72La61fM0tTfETd0THTM+lLDWjHP
         l1G8XqCWSWjHw0uc2ZW7RFdSgLc5YeCD6GPEuOQncSql/9n41fCtuV/8/06C8UPxEjQc
         u9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eKWxTPJ8ySiw4Mg5WCqpHROMwJIlyrK/OCBD0n+gFJ4=;
        b=s4sUS2wqJz0hWa9+wntE1nP3XmelZbQH9dePNZcbWpNcnlyXW87QPDNThg/05hrzfE
         0JmKbhB4hPafa63c+CDktR4RNTBa1bxPxEvkpO63z0orVT1RparcLfzQRdgrPk+6gz76
         OQsoEWiVP8R2yA24BbZL8YH8so+Vajyx8y/3c4QlZSQiw00jp1iDCFWJTKdgw1xdsVH/
         LMc+ZL5tKZTZbtC+MYSR3scHjLTjy7sEz7cZPq4e8athCEDD4HbbOspe5f2Xe5IavkN9
         ZG6YqFyG4n45n26GVqT2TE7aWmWqOkz5CTTg3C0O1eU/yIVfhmXjDQAjucKSUX1lSRAL
         H1Fw==
X-Gm-Message-State: AKGB3mIREmj5urRbf3gm/jU+U19KZed7/pbiCcTwSz6ptfIfadlCQmkd
        SM5yKddnrK2Og3MpVpxrcyl32nM9
X-Google-Smtp-Source: ACJfBoufTeF/KtnwZjnkJEHKHypCynb+grz8OFs1GF15oNuAnJP3vzoYQmRZSzfk4lSngOn9ejB1+g==
X-Received: by 10.28.133.148 with SMTP id h142mr1524972wmd.110.1515143571428;
        Fri, 05 Jan 2018 01:12:51 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id y42sm7903531wrc.96.2018.01.05.01.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jan 2018 01:12:49 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 0/7] Codespeed perf results
Date:   Fri,  5 Jan 2018 10:12:19 +0100
Message-Id: <20180105091226.16083-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.40.gbe5e688583
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is built on top of cc/perf-run-config which recently
graduated to master.

It makes it possible to send perf results to a Codespeed server. See
https://github.com/tobami/codespeed/ and web sites like
http://speed.pypy.org/ which are using Codespeed.

The end goal would be to have such a server always available to track
how the different git commands perform over time on different kind of
repos (small, medium, large, ...) with different optimizations on and
off (split-index, libpcre2, BLK_SHA1, ...)

With this series and a config file like:

$ cat perf.conf
[perf]
        dirsOrRevs = v2.12.0 v2.13.0
        repeatCount = 10
        sendToCodespeed = http://localhost:8000
        repoName = Git repo
[perf "with libpcre"]
        makeOpts = "DEVELOPER=1 USE_LIBPCRE=YesPlease"
[perf "without libpcre"]
        makeOpts = "DEVELOPER=1"

One should be able to just launch:

$ ./run --config perf.conf p7810-grep.sh

and then get nice graphs in a Codespeed instance running on
http://localhost:8000.

Caveat
~~~~~~

For now one has to create the "Git repo" environment (in fact all the
values of the "environment" field sent to Codespeed) in the Codespeed
admin interface. (We send the perf.repoName config variable in the
"environment" Codespeed field.) This is because Codespeed requires the
environment fields to be created and does not provide a simple way to
create these fields programmatically.

There are discussions on a Codespeed issue
(https://github.com/tobami/codespeed/issues/232) about creating a
proper API for Codespeed that could address this problem in the
future.

Changes since previous version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There are very few changes compared to v2:

  - In patch 1/7 commit message has been improved following a comment
    by Junio.

  - In patch 3/7 some debugging comments were removed and 'use JSON;'
    was moved to the top of aggregate.perl as suggested by Junio.

The diff is the following:

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 34d74fc015..5c439f6bc2 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -3,6 +3,7 @@
 use lib '../../perl/blib/lib';
 use strict;
 use warnings;
+use JSON;
 use Git;
 
 sub get_times {
@@ -226,10 +227,6 @@ sub print_codespeed_results {
                }
        }
 
-       #use Data::Dumper qw/ Dumper /;
-       #print Dumper(\@data);
-
-       use JSON;
        print to_json(\@data, {utf8 => 1, pretty => 1}), "\n";
 }

Links
~~~~~

This patch series:

https://github.com/chriscool/git/commits/codespeed

Previous versions:

v1: https://github.com/chriscool/git/commits/codespeed1
v2: https://github.com/chriscool/git/commits/codespeed10

Discussions:

v1: https://public-inbox.org/git/CAP8UFD3Q4h-aYBDABSPOW948LQYVydWZ1hLPAD+kr9ZpXVZiaQ@mail.gmail.com/
v2: https://public-inbox.org/git/20171226215908.425-1-chriscool@tuxfamily.org/

Discussions about the cc/perf-run-config patch series:

v1: https://public-inbox.org/git/20170713065050.19215-1-chriscool@tuxfamily.org/
v2: https://public-inbox.org/git/CAP8UFD2j-UFh+9awz91gtZ-jusq7EUOExMgURO59vpf29jXS4A@mail.gmail.com/


Christian Couder (7):
  perf/aggregate: fix checking ENV{GIT_PERF_SUBSECTION}
  perf/aggregate: refactor printing results
  perf/aggregate: implement codespeed JSON output
  perf/run: add conf_opts argument to get_var_from_env_or_config()
  perf/run: learn about perf.codespeedOutput
  perf/run: learn to send output to codespeed server
  perf/run: read GIT_PERF_REPO_NAME from perf.repoName

 t/perf/aggregate.perl | 160 +++++++++++++++++++++++++++++++++++---------------
 t/perf/run            |  31 ++++++++--
 2 files changed, 137 insertions(+), 54 deletions(-)

-- 
2.16.0.rc0.40.gbe5e688583

