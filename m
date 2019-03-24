Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85DCD20248
	for <e@80x24.org>; Sun, 24 Mar 2019 21:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfCXVz5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 17:55:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46547 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXVzz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 17:55:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id o1so7899438wrs.13
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 14:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MMLvC1uZVjQr8OgCVrMlTI1GzeNJ2EienoSOqWQZ7AI=;
        b=ENOC1flsfyhM+rao83YdCiAX5kL4sl5AMi3U53+no25NsmCQh5AmPEoc+DMnZN0x/7
         K/8Mdewf/D8hhZMCqzYlS/yMPOpfXcAc7UqB0gpyHfVZ3EQHR2Yla+1Kmhv2n550XfqQ
         kAmcneaqeh0J2K4wvLv6xFbPWGb9VONhgnH3ffOPXqOj95aQAFXFiZm/z6PQEbgKq64v
         ew0gNSsICkCVr7Q/YmPpto6xhD6mGC4bbOPMw64abGb8S9peDsVDvXIH+L7cM+7fHH5d
         3Fy2yJLjVTMDuCalruFCAcOXvkZlcHNQyYeJ4oP+aCLnT2ti8OyyWFTsMzzhWMT+wM8M
         cfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MMLvC1uZVjQr8OgCVrMlTI1GzeNJ2EienoSOqWQZ7AI=;
        b=QVOTZ+9ecrSowNGWiMYO7jgL7HAq+h5lv1ZnFV3NDAo6JbyZvc0pra2VZ+VyeTiEmD
         XD3TAh7/8b0OxIjOJrooZiuXAPH1xCPLOXIzCV7cvX6l9BsTdUyxX/snOvXDv5Yqo820
         CMPHXgnf/qlfX9BMjV2+DJkqvJ6MI+u2pZnqMh+0HqgnBS2sTbfuLVRJp+ST++35CSQH
         OimyRKbiHvtz3MZ5FNwLXqBT3ji95HmgJvGgKynybB6CfhAerS3zCKzdf0yLtEcdH71I
         bE1OninS21wdvWj68PwwLhliNagzkl2UqA/AAQlejEnMPJZ4HveXBqUUQMV4oHapSXQb
         0FlA==
X-Gm-Message-State: APjAAAVsnIM9UA/jj5dB1fSX8G/KfTW/1fLGvzch4DHD+8ud9DQN+VKY
        2T3vKiELLCLo5wchc6xYH5gJgYE5
X-Google-Smtp-Source: APXvYqztoDS7QP15pONMIAuEOvpY4PEaNnR0A+dRTrrhG02OVE8AZ725+A/xTCkgtr1L22yTrJQZnQ==
X-Received: by 2002:a5d:4606:: with SMTP id t6mr13300429wrq.43.1553464553864;
        Sun, 24 Mar 2019 14:55:53 -0700 (PDT)
Received: from localhost.localdomain (x4d0c479e.dyn.telefonica.de. [77.12.71.158])
        by smtp.gmail.com with ESMTPSA id o17sm15023530wrw.73.2019.03.24.14.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Mar 2019 14:55:53 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 6/6] ci: fix AsciiDoc/Asciidoctor stderr check in the documentation build job
Date:   Sun, 24 Mar 2019 22:55:34 +0100
Message-Id: <20190324215534.9495-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190324215534.9495-1-szeder.dev@gmail.com>
References: <20190324155219.2284-1-szeder.dev@gmail.com>
 <20190324215534.9495-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In our 'ci/*' build scripts we rely on 'set -e' aborting the build job
when a command exits with error, while in 'ci/test-documentation.sh'
we tried to check the emptiness of AsciiDoc's and Asciidoctor's
standard error with '! test -s stderr.log'.  Unfortunately, the
combination of the two doesn't work as intended, because, according to
POSIX [1]:

  "The -e setting shall be ignored when executing [...] a pipeline
  beginning with the ! reserved word" [2]

Watch and learn:

  $ cat e.sh
  #!/bin/sh
  set -ex
  echo unexpected >file
  ! test -s file
  test ! -s file
  echo "should not reach this"
  $ ./e.sh
  + echo unexpected
  + test -s file
  + test ! -s file
  $

This is why we haven't noticed the warnings from Asciidoctor that were
fixed in the first patches of this patch series, though some of them
were already there in the build of v2.18.0-rc0 [3].

Check the emptiness of that file with 'test ! -s' instead, which works
properly with 'set -e'.  Furthermore, dump the contents of that file
to the log for our convenience, so if it were to unexpectedly end up
being non-empty, then we wouldn't have to scroll through all that long
build log looking for warnings, but could see them right away near the
end of the log.

And one more thing: we build the docs with Asciidoctor right after a
'make clean', meaning that 'make doc' starts with running
'GIT-VERSION-GEN', which in turn prints the version to its standard
error.  This version then goes to 'stderr.log' as well, and a 'sed'
command is supposed to remove it to prevent it from interfering with
that (previously defunct) emptiness check.  Alas, this command doesn't
work as intended, either, because it leaves the file to be checked
intact, but the defunct emptiness check hid this issue, too...  This
patch deals with this as well.

[1] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#set

[2] POSIX doesn't discuss the meaning of '! cmd' in case of simple
    commands, but it defines that "A pipeline is a sequence of one or
    more commands separated by the control operator '|'", so
    apparently a simple command is considered as pipeline as well.

    http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_02

[3] https://travis-ci.org/git/git/jobs/385932007#L1463

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/test-documentation.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index 8f91f48c81..bd4a65e933 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -10,7 +10,8 @@ make check-docs
 
 # Build docs with AsciiDoc
 make doc > >(tee stdout.log) 2> >(tee stderr.log >&2)
-! test -s stderr.log
+cat stderr.log
+test ! -s stderr.log
 test -s Documentation/git.html
 test -s Documentation/git.xml
 test -s Documentation/git.1
@@ -21,13 +22,14 @@ check_unignored_build_artifacts
 
 # Build docs with AsciiDoctor
 make clean
-make USE_ASCIIDOCTOR=1 doc > >(tee stdout.log) 2> >(tee stderr.log >&2)
-sed '/^GIT_VERSION = / d' stderr.log
-! test -s stderr.log
+make USE_ASCIIDOCTOR=1 doc > >(tee stdout.log) 2> >(tee stderr.raw >&2)
+sed '/^GIT_VERSION = / d' stderr.raw >stderr.log
+cat stderr.log
+test ! -s stderr.log
 test -s Documentation/git.html
 grep '<meta name="generator" content="Asciidoctor ' Documentation/git.html
 
-rm -f stdout.log stderr.log
+rm -f stdout.log stderr.log stderr.raw
 check_unignored_build_artifacts
 
 save_good_tree
-- 
2.21.0.539.g07239c3a71.dirty

