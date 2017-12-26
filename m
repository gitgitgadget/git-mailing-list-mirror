Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 412941F404
	for <e@80x24.org>; Tue, 26 Dec 2017 21:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbdLZV7N (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 16:59:13 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37890 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdLZV7M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 16:59:12 -0500
Received: by mail-wm0-f47.google.com with SMTP id 64so36613102wme.3
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 13:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=V2/BMX9uV0DRaZOVQfHTVRuY4Ylg9yY1N99AJlmg5o4=;
        b=aDj3KJLIwKh2tO+oKKoTAS+BTMC8Bxhe+qVfccwusJTUSDibuMEOZk0WOL05xJBUsJ
         IBdjiOuGA9yxtNyXW2lnMaGZ+nvFJUHg75b4qeA65K5N3U6sNpOwoD9Ewb7U7rFEmQ8m
         9PNQS1PBcUNxJ1eW7grKlceV2i93M+9PEaruHtXFEAK5+vBUetdYP+Qs/2PXVvhDL/wQ
         QeGHx2NlBowo2WJg0c+UiN9qC9j/f9rm/O9Evllj7SvPtKlcLGuLqV7xKhG4u5YsN0cP
         bW/jR2FtHrCRXk50F1+UDeEQxrpkUaH90PClCayleolIa8YxZqXEJqwr/lcz8qHmvFB4
         Da0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V2/BMX9uV0DRaZOVQfHTVRuY4Ylg9yY1N99AJlmg5o4=;
        b=ncY8zQqkl4ILmp6L+KQZnf66RB4OKP+wCTWhY1PnRUrFfTcKlh5oNhTFhipEIKC+ts
         i4zMLFjoEDTd/sXZRDUp/ZLaciYKME/NiM0SZUNPQzkkQw9IT6KLUgWWWt4z5OKL+Fyy
         X7FPNyFa3E7T8xVzuLS/rWg7+SKl1Cfa7xpGcLCnP6agdSnNLWUAm4y6kVfrSFa4uRU/
         mXs524jwfrJz0l4Ij8gUhUIVz6Fxtc8IR9Mmjva9H6Ej3R0FYnvWvx0UrwCX6b6VsaBX
         NP+eJzXgi2Df7DCbEV6Y5QaMOiwZQ+YDhg7rBlS1aM4GZX8EZHFnQUFhComm4ooreaQe
         nS2A==
X-Gm-Message-State: AKGB3mJ3fSbJAC8l308XAdikBY+0r5ejTF4igzVQcWPOlGGlX9k3sSdU
        hazlNrY+KROsjoMyD2FVFY/Fny3l
X-Google-Smtp-Source: ACJfBosE2uX3fL6XcD0mXIKYSpINwv6xmz/TeD5yrFTSqinSqGtVBBg0ch2WumvgDhHss/m7n+1U9Q==
X-Received: by 10.28.232.208 with SMTP id f77mr20463317wmi.155.1514325550741;
        Tue, 26 Dec 2017 13:59:10 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id d71sm24516204wma.7.2017.12.26.13.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Dec 2017 13:59:10 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 0/7] Codespeed perf results
Date:   Tue, 26 Dec 2017 22:59:01 +0100
Message-Id: <20171226215908.425-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
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

For now one has to create the "Git repo" environment in the Codespeed
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

  - Fixed the way the 'executable' field sent to Codespeed is set in
    `perf/aggregate.perl` in patch 3/7. We now use `uname -s -m` to
    which we concatenate the perf.repoName config value if it is set,
    as suggested by Junio and Eric.

  - Fixed the name of the GIT_PERF_REPO_NAME variable in patches 3/7
    and 7/7. It was GIT_TEST_REPO_NAME in some places.

  - Fixed how the conf_opt argument is added to the
    get_var_from_env_or_config() function in patch 4/7. It was added
    as the last, so fifth, argument, but it is simpler and makes more
    sense to keep the default value argument as the last argument, so
    now the conf_opt argument is added as the fourth argument.

  - What patch 4/7 did was previously done in 2 patches in the
    previous version (patches 4/8 and 5/8), but as we are not doing
    exactly the same thing (see the above item) it is simpler to do it
    in only one patch instead of two.

  - We now use the --int type specifier when getting the
    perf.repeatCount config variable in patch 4/7.

Links
~~~~~

This patch series:

https://github.com/chriscool/git/commits/codespeed

Previous version (v1):

https://github.com/chriscool/git/commits/codespeed1

Discussions about v1:

https://public-inbox.org/git/CAP8UFD3Q4h-aYBDABSPOW948LQYVydWZ1hLPAD+kr9ZpXVZiaQ@mail.gmail.com/

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
  perf/run: read GIT_TEST_REPO_NAME from perf.repoName

 t/perf/aggregate.perl | 163 +++++++++++++++++++++++++++++++++++---------------
 t/perf/run            |  31 ++++++++--
 2 files changed, 140 insertions(+), 54 deletions(-)

-- 
2.15.1.361.g8b07d831d0

