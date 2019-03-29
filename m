Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84FE320248
	for <e@80x24.org>; Fri, 29 Mar 2019 12:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfC2Mfm (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 08:35:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37431 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbfC2Mfj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 08:35:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so2414191wrm.4
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 05:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O0kSda6j0RB+hnnaInE22M7p+sKAjaxBMDm+ptFLgFQ=;
        b=iS4LYPaHtnuf412145Uo2rl7wo2R2Nh7ABpJIDG816DQiFIsELrUc4ybUAU3UQF3XX
         DuYsTZ20PGe6Z7NR7LHxNTy7s87bczBcdf8NKTQVxDHM2lAx2gD3IE/bZM09NBFOwIck
         05uP3v34Xy03Gs0I8KkYwjH16/kv79ELSPl4qg5E6e9itjJwsAc0TjWilzpw4ccWnEjN
         e8LuiUQVwun1uwSfRv4jqWgiUYsnqq4bv7jpfdvVZQtnU2bEiR+DAyyWhc94Oi545fpG
         MncnDjdC02b3hyxuP2ch0tjpIO0e0Pl6/Yr9VU3uL1NYAjHt78pmSOKr/9N/RJsrWSBA
         gZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O0kSda6j0RB+hnnaInE22M7p+sKAjaxBMDm+ptFLgFQ=;
        b=SlgYcualbcXXBjLh4D+pTH6XDIMuoVOzC5C1u+TN5xbfSDkxfWekjK7d2gukgEP7lR
         xvS23a7UFrH00txiWwmh8mFGnq2xBgnLgxDQQKkQr4EhVkKMOlZv8+53O8FvfCqMK2DI
         LXezAybuYLknBcCC98sruUP7BLLA4Z0z/i0ZaoxzFNnGbNKeH9MYXdUJN9XRzcY9PRaA
         P6ldEuckIUiNwquPRt/PjCh0OF4OQMv1wmIH4zxUxyZfK+61oGsUbfn+g7UL7NO1/Rup
         JyE/jT0jg88m+dUJ6CQrXdyOpf0UNdiAfrLB41dSfXPYNqQTlklMWP6PMy3c+7YY6me5
         v7dw==
X-Gm-Message-State: APjAAAWVBU8f2Ke0Nh5Sw08rXzfoX0+pEepYYhM4B7t62+DqpBXqALzD
        B48nUxvSU4NwqP3XslGlNEc=
X-Google-Smtp-Source: APXvYqwVMDajo8PsE4W7UjU27mBJ8cjieXBzg3S5rLh+o5xo/ZclzrK4LKVC1xthJuqiCwTjw5nSdQ==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr25564583wrn.148.1553862937791;
        Fri, 29 Mar 2019 05:35:37 -0700 (PDT)
Received: from localhost.localdomain (x4dbd3bb2.dyn.telefonica.de. [77.189.59.178])
        by smtp.gmail.com with ESMTPSA id 61sm7341781wre.50.2019.03.29.05.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Mar 2019 05:35:37 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 6/6] ci: fix AsciiDoc/Asciidoctor stderr check in the documentation build job
Date:   Fri, 29 Mar 2019 13:35:20 +0100
Message-Id: <20190329123520.27549-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190329123520.27549-1-szeder.dev@gmail.com>
References: <20190324215534.9495-1-szeder.dev@gmail.com>
 <20190329123520.27549-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 'ci/test-documentation.sh' we save the standard error of 'make
doc', and, in an attempt to make sure that neither AsciiDoc nor
Asciidoctor printed any warnings, we check the emptiness of the
resulting file with '! test -s stderr.log'.  This check has never
actually worked, because in our 'ci/*' build scripts we rely on 'set
-e' aborting the build job when a command exits with error, and,
unfortunately, the combination of the two doesn't work as intended.
According to POSIX [1]:

  "The -e setting shall be ignored when executing [...] a pipeline
  beginning with the ! reserved word" [2]

Watch and learn:

  $ echo unexpected >file
  $ ( set -e; ! test -s file ; echo "should not reach this" ) ; echo $?
  should not reach this
  0

This is why we haven't noticed the warnings from Asciidoctor that were
fixed in the first patches of this patch series, though some of them
were already there in the build of v2.18.0-rc0 [3].

Check the emptiness of that file with 'test ! -s' instead, which works
properly with 'set -e':

  $ ( set -e; test ! -s file ; echo "should not reach this" ) ; echo $?
  1

Furthermore, dump the contents of that file to the log for our
convenience, so if it were to unexpectedly end up being non-empty,
then we wouldn't have to scroll through all that long build log
looking for warnings, but could see them right away near the end of
the log.

Note that we are only really interested in the standard error of
AsciiDoc and Asciidoctor, but by saving the stderr of 'make doc' we
also save any error output from the make rules.  Currently there is
only one such line: we build the docs with Asciidoctor right after a
'make clean', meaning that 'make USE_ASCIIDOCTOR=1 doc' always starts
with running 'GIT-VERSION-GEN', which in turn prints the version to
stderr.  A 'sed' command was supposed to remove this version line to
prevent it from triggering that (previously defunct) emptiness check,
but, unfortunately, this command doesn't work as intended, either,
because it leaves the file to be checked intact, but that defunct
emptiness check hid this issue, too...  Furthermore, in the near
future there will be an other line on stderr, because commit
9a71722b4d (Doc: auto-detect changed build flags, 2019-03-17) in the
currently cooking branch 'ma/doc-diff-doc-vs-doctor-comparison' will
print "* new asciidoc flags" at the beginning of both 'make doc'
invokations.

Extend that 'sed' command to remove this line, too, wrap it in a
helper function so the output of both 'make doc' is filtered the same
way, and change its invokation to actually write the logfile to be
checked.

[1] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#set

[2] POSIX doesn't discuss the meaning of '! cmd' in case of simple
    commands, but it defines that "A pipeline is a sequence of one or
    more commands separated by the control operator '|'", so
    apparently a simple command is considered as pipeline as well.

    http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_02

[3] https://travis-ci.org/git/git/jobs/385932007#L1463

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/test-documentation.sh | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index 8f91f48c81..d49089832d 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -5,29 +5,38 @@
 
 . ${0%/*}/lib.sh
 
+filter_log () {
+	sed -e '/^GIT_VERSION = /d' \
+	    -e '/^    \* new asciidoc flags$/d' \
+	    "$1"
+}
+
 make check-builtins
 make check-docs
 
 # Build docs with AsciiDoc
-make doc > >(tee stdout.log) 2> >(tee stderr.log >&2)
-! test -s stderr.log
+make doc > >(tee stdout.log) 2> >(tee stderr.raw >&2)
+cat stderr.raw
+filter_log stderr.raw >stderr.log
+test ! -s stderr.log
 test -s Documentation/git.html
 test -s Documentation/git.xml
 test -s Documentation/git.1
 grep '<meta name="generator" content="AsciiDoc ' Documentation/git.html
 
-rm -f stdout.log stderr.log
+rm -f stdout.log stderr.log stderr.raw
 check_unignored_build_artifacts
 
 # Build docs with AsciiDoctor
 make clean
-make USE_ASCIIDOCTOR=1 doc > >(tee stdout.log) 2> >(tee stderr.log >&2)
-sed '/^GIT_VERSION = / d' stderr.log
-! test -s stderr.log
+make USE_ASCIIDOCTOR=1 doc > >(tee stdout.log) 2> >(tee stderr.raw >&2)
+cat stderr.raw
+filter_log stderr.raw >stderr.log
+test ! -s stderr.log
 test -s Documentation/git.html
 grep '<meta name="generator" content="Asciidoctor ' Documentation/git.html
 
-rm -f stdout.log stderr.log
+rm -f stdout.log stderr.log stderr.raw
 check_unignored_build_artifacts
 
 save_good_tree
-- 
2.21.0.539.g07239c3a71.dirty

