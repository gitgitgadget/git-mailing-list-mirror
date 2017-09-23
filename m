Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63B7F20281
	for <e@80x24.org>; Sat, 23 Sep 2017 19:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbdIWTjE (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 15:39:04 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:52845 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbdIWTjD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 15:39:03 -0400
Received: by mail-it0-f47.google.com with SMTP id c195so3823631itb.1
        for <git@vger.kernel.org>; Sat, 23 Sep 2017 12:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9H6KmIPEPZWt72VuzOB4tEnFPL4HF3Ae5UqulyxSOfI=;
        b=aRdXHdb+HKKMlAde/chfsYtxKqvMQ+hhHGreAwFGQJovg0O5c7fEjLoIUAocO/5qR+
         s6Cx6+eP2LjHwNq0lcyhL2Iya3BXsW8U1gOrumtq8fBZQRDllcOHRQ/mPnUbgN2sBcma
         WaBuDlN2pGCZ5Fd/dzhxjSqsZDUtnnEmMoIJJ+UXpHtUmwkmuZA2zkgWlvsCSF3XvnmU
         EsA3dYwe75HVoXD2FtxAyTZUHc1MxIytryYT/EU+58wi1dR4rJ7y5mzHvXXUjjEPSNqZ
         JWxteizoEYD/9/MIX7tMQm/QowL7MOsomuycA9tQXT6gBWYFrYujHYL4gjsTcIcsGzOU
         FCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9H6KmIPEPZWt72VuzOB4tEnFPL4HF3Ae5UqulyxSOfI=;
        b=FvTwEdythRK1hH61keN80w92P8ZSUX8DgVhpPTEvwuZX88LmfltmDnuSa442Wb2/8P
         1YSxGTXAEZwFrpSdtm67pG9AFo9kLiqrFEc9EupNvZNbdI+LTQ3T3Mpo1vpbwI4QCuSR
         blSnpAyzfqbnsxxi8jH+Kj97KDe/Yl8oPVlt07OdI+BZVVT+ais1QIZMBmjPs9+G97+a
         1BFFxFvo/6+FBV5EaTVKn0NEGYoWu4e+TIZ45ZyMUeINyuC5T2Vg8LhE2wEPj4zUF+k+
         vQtZ9D8/PF/8crlu0hYDQ7Is0Yx0pH7e8Y93F0SanfiKtNJU4sYNrAPz5bNP+3j9Ct45
         ws4g==
X-Gm-Message-State: AHPjjUizJNbC5MVYsDk6cEqOlLg6T5SStD01ItncrGDid0QHbeiIi89q
        5NMlh+8jPxnx8XiZ4Km23lAqQxnIW43ZPn8KYjvfjQ==
X-Google-Smtp-Source: AOwi7QAcLZDjVKCF0nnpUiqFPEvIUvAj52nQr+goNqzW3ALMltld7Y1sPMHHAz+Z2w1qzfL1Vtw8TDTJGjXH8xZLQOo=
X-Received: by 10.36.5.84 with SMTP id 81mr11263903itl.96.1506195542657; Sat,
 23 Sep 2017 12:39:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.107.136 with HTTP; Sat, 23 Sep 2017 12:39:02 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 23 Sep 2017 21:39:02 +0200
Message-ID: <CAP8UFD2j-UFh+9awz91gtZ-jusq7EUOExMgURO59vpf29jXS4A@mail.gmail.com>
Subject: [PATCH v2 0/9] Teach 'run' perf script to read config files
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(It looks like smtp.gmail.com isn't working anymore for me, so I am
trying to send this using Gmail for the cover letter and Submitgit for
the patches.)

Goal
~~~~

Using many long environment variables to give parameters to the 'run'
script is error prone and tiring.

We want to make it possible to store the parameters to the 'run'
script in a config file. This makes it easier to store, reuse,
share and compare parameters.

It also makes it easy to run series of tests.

Design
~~~~~~

We use the same config format as the ".git/config" file as Git users
and developers are familiar with this nice format and have great tools
to change, query and manage it.

We use values from the config file to set the environment variables
that are used by the scripts if they are not already set.

We want to make it possible to run series of tests by passing only a
config file to the 'run' script.

For example a config file like the following can be used to run perf
tests with Git compiled both with and without libpcre:

[perf]
        dirsOrRevs = v2.12.0 v2.13.0
        repeatCount = 10
[perf "with libpcre"]
        makeOpts = "DEVELOPER=1 USE_LIBPCRE=YesPlease"
[perf "without libpcre"]
        makeOpts = "DEVELOPER=1"

This makes it easy to see what changes between the different runs.

It's also possible (though maybe not so useful) to just separate tests
from different versions like this:

[perf]
        repeatCount = 2
        makeOpts = "DEVELOPER=1 USE_LIBPCRE=YesPlease"

[perf "with v2.12.0 and v2.13.1"]
        dirsOrRevs = v2.12.0 v2.13.1
[perf "with v2.11.0 and v2.12.1"]
        dirsOrRevs = v2.11.0 v2.12.1

Highlevel view of the patches in the series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - Patches 1/9 to 4/9 were already in v1 and haven't changed.

Patch 1/9 teaches the '--config <configfile>' option to the 'run'
script, but <configfile> is just put into the GIT_PERF_CONFIG_FILE
variable which is not used yet.

Patch 2/9 add the get_var_from_env_or_config() function to read config
options from the <configfile> and set values to some variables from
these config options or from default values.

Patch 3/9 and 4/9 use the get_var_from_env_or_config() function to
make it possible to set parameters used by the 'run' script.

  - Patches 5/9 to 9/9 are new.

Patch 5/9 introduce a function to deal with subsections in the config
file.

Patch 6/9 improves the get_var_from_env_or_config() function so that
it can handle subsections.

Patch 7/9 adds the run_subsection() function to run the tests for a
subsection.

Patch 8/9 improves the output when building a rev.

Patch 9/9 stores subsection results into subdirectories of test-results
so that results from previous subsections is not overwritten.

Future work
~~~~~~~~~~~

In the future I may work on the following:

  - improving aggregate.perl so that it can aggregates the results in
    different ways and formats, especially so that the results can be
    used by Codespeed (https://github.com/tobami/codespeed)
  - making it possible to configure more things in the config file
  - improving how GIT-BUILD-OPTIONS is handled

Though I think the series does not need the above improvements to be
already valuable.

Links
~~~~~

This patch series is also available here:

  https://github.com/chriscool/git/commits/perf-conf

Links to the previous version of this series are:

v1:
  https://github.com/chriscool/git/commits/perf-conf5
  https://public-inbox.org/git/20170713065050.19215-1-chriscool@tuxfamily.org/

Christian Couder (9):
  perf/run: add '--config' option to the 'run' script
  perf/run: add get_var_from_env_or_config()
  perf/run: add GIT_PERF_DIRS_OR_REVS
  perf/run: add calls to get_var_from_env_or_config()
  perf/run: add get_subsections()
  perf/run: update get_var_from_env_or_config() for subsections
  perf/run: add run_subsection()
  perf/run: show name of rev being built
  perf: store subsection results in "test-results/$GIT_PERF_SUBSECTION/"

 t/perf/aggregate.perl | 11 +++++--
 t/perf/perf-lib.sh    |  4 +--
 t/perf/run            | 89 +++++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 89 insertions(+), 15 deletions(-)

-- 
2.14.1.767.g2dbbf9317b
