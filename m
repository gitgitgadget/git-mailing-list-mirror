Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD58F1F407
	for <e@80x24.org>; Wed, 13 Dec 2017 15:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753036AbdLMPNz (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 10:13:55 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:41216 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbdLMPNy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 10:13:54 -0500
Received: by mail-wm0-f50.google.com with SMTP id g75so5743442wme.0
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 07:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M6kr2148Q4dY0q6GZnPRWXyp8fw6X4PSoA9ONklCZUM=;
        b=cuB1bSAKjVlonNanmToGM6WlpzJbBP/W5PfVwGpBqWfr45AyBZis+W4w3SZkgoSCK3
         8+AR/DDLrswUTeN95wVdTJGk8Be4p4di+p0ahiqpoU3E8mlq/VOlZ0Uzy0Chn6yvnwth
         +bcCrL4lQTHqslIAtzl8ItfRpIOvuWCZmafakAaaeALj4nQnTVCKVoXbYnScA/CQVPHV
         qVU09L0DbZRHTvyA822p4FJtd2S5HPRdmDbkKtyGw+7mQcLTEVyGuSlFwx2DIQfOvMi5
         LT22zIBAU/W7ywihPlAdA18yCh4kp7wz28aMI5jxOiOSmmZFi7r4Gof6TkCmnnluEPnI
         NIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M6kr2148Q4dY0q6GZnPRWXyp8fw6X4PSoA9ONklCZUM=;
        b=Z1Qry30w/cUTaCFlSMvHyVLthXKWJVfmmxeQMzoFWkfC17h7jhjiTyh8/ERCJVoc1x
         +EtxMFfb6PNlFy15L1brWIZVbxE7J7zJcDkplJhGZL2cKB6NfHnyhTu59Fyzu2jLwHbb
         UfmfKaqw15Pl2UnTv6zrrLS8HJFPcmn+DT3fc5TLd4BFPLvZbkUEsKdH0sBoLd5T2nd6
         hBzAuFu4zxapOQII7BEVcFa1PbX6w0vnxeyTy3uiDyliyt3q89ImWG3hMl/Dq0Ytas8/
         InTMoZoAUhbHDQM8hgEe381KjsxOMzhfYzb8s77aiSOecOSvGcusH6mBd5IflsKal15S
         8a5Q==
X-Gm-Message-State: AKGB3mIikEoOYVRB1hw0Tlo2kYnumMOpQW3LHadZV/EVB7nbMs7r/t4N
        ZBffUepbq5pcdsJPISoCyPq9hirz
X-Google-Smtp-Source: ACJfBouAFzXAunAqBsyTqsqV37o8N3LP3Cu5maHPipO8uGwc3vyrqofASsldALlMszv41rtePGUELw==
X-Received: by 10.80.241.19 with SMTP id w19mr8126700edl.123.1513178032657;
        Wed, 13 Dec 2017 07:13:52 -0800 (PST)
Received: from christian-Latitude-E6330.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id z56sm1552690edb.72.2017.12.13.07.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Dec 2017 07:13:51 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/8] Codespeed perf results
Date:   Wed, 13 Dec 2017 16:13:36 +0100
Message-Id: <20171213151344.2138-1-chriscool@tuxfamily.org>
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

I might try to work around this problem in the future.

Links
~~~~~

This patch series is available here:

https://github.com/chriscool/git/commits/codespeed

The cc/perf-run-config patch series was discussed here:

v1: https://public-inbox.org/git/20170713065050.19215-1-chriscool@tuxfamily.org/
v2: https://public-inbox.org/git/CAP8UFD2j-UFh+9awz91gtZ-jusq7EUOExMgURO59vpf29jXS4A@mail.gmail.com/

Christian Couder (8):
  perf/aggregate: fix checking ENV{GIT_PERF_SUBSECTION}
  perf/aggregate: refactor printing results
  perf/aggregate: implement codespeed JSON output
  perf/run: use $default_value instead of $4
  perf/run: add conf_opts argument to get_var_from_env_or_config()
  perf/run: learn about perf.codespeedOutput
  perf/run: learn to send output to codespeed server
  perf/run: read GIT_TEST_REPO_NAME from perf.repoName

 t/perf/aggregate.perl | 164 +++++++++++++++++++++++++++++++++++---------------
 t/perf/run            |  29 +++++++--
 2 files changed, 140 insertions(+), 53 deletions(-)

-- 
2.15.1.361.g8b07d831d0

