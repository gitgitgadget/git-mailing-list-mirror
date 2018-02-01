Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187011F404
	for <e@80x24.org>; Thu,  1 Feb 2018 13:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeBANCx (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 08:02:53 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34070 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbeBANCw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 08:02:52 -0500
Received: by mail-wm0-f44.google.com with SMTP id j21so2732029wmh.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 05:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version;
        bh=logLCiirjGMfxYoh3UH5UlT4fVlQ6CcwinHMsLbRMNQ=;
        b=WJeqciEMzRjslrD8TImIsC+NWUbIPecXyJZ4cNbBVQwXtQDTJ6oNHoJrYr76LMK3Hp
         eFZpFi07GCT/z/ie1pFUgCRA6bFGLVVhyvNJHfts4ZrrIcXmu5IIpYOGmB5o4L43sZ01
         EVcSeEwKVNxlJ9WrGOtipKMYP3ueSHPKs860T6XWBnXQWOlmFM7i7xKkbHN1Vx52loPf
         /AqTUt9SwXRFiZgG9+b8VYZFCmguwfd9uQJCYMJM8be/S6MrXF4oa+eEsZe7JIqF1d7s
         ETEGyJMpMF5CrHaACKX6o+nzWRG6so2Bg4mxzlchZmG6huiMUI6uX5APK9aRUdnezvMU
         qB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version;
        bh=logLCiirjGMfxYoh3UH5UlT4fVlQ6CcwinHMsLbRMNQ=;
        b=hLzGBGnlneYMRgCe36HTpvdGOUMWWhZ6JMiHh1XH8NYwnRAcaRgYhBhjSyA0H8BLOc
         2wMkIO2o/CcIPex2iE4BQoScynE+GgSZyb5zzS3hTM9pqQ3FY4SGzZBiraTSa5S98Lkr
         w7UlQTvQViYlYVAf3CXbF9qariCvzQchaygh82mi9GKM4kpajAke22UBfpqmp/ZmTTLi
         Kt1T6N3DTvuDwiGq6MqRv/y8NLAwMxHSxBOSW283VABKwtftpjU58UiIMv8V+pFZG+Gb
         XbZU15UxbWp15eUPZg4JE7qzUfCuDF0j3LIMXNLNHluDqMvcBmO0F0dgepHFSQMjSjaj
         a8Sw==
X-Gm-Message-State: AKwxytc2xntckMJFzHc5RPYOYadE/oI7FY6ld0JQS7vNTDZ0Cv3b/Ebi
        d3eD7YEiWDrtA6GtO67mXAS2Idmf
X-Google-Smtp-Source: AH8x2259l8ToKmUu3UMr9lWzD8vcPxE2UfkekITI2BCXXZfcw+voupthlX89lid33q/ttIeimuCsNA==
X-Received: by 10.80.151.198 with SMTP id f6mr63260911edb.106.1517490171148;
        Thu, 01 Feb 2018 05:02:51 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id h9sm6503956edi.79.2018.02.01.05.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Feb 2018 05:02:49 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: t3404.6 breaks on master under GIT_FSMONITOR_TEST
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
Date:   Thu, 01 Feb 2018 14:02:49 +0100
Message-ID: <87k1vwn9qe.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The GIT_FSMONITOR_TEST variable allows you to roundtrip the fsmonitor
codpath in the whole test suite. On both Debian & CentOS this breaks for
me:

    (cd t && GIT_FSMONITOR_TEST=$PWD/t7519/fsmonitor-all ./t3404-rebase-interactive.sh -i)

Whereas this works:

    (cd t && GIT_FSMONITOR_TEST=$PWD/t7519/fsmonitor-all GIT_SKIP_TESTS=t3404.6 ./t3404-rebase-interactive.sh -i)

The entirety of the rest of the test suite still passes with
GIT_FSMONITOR_TEST.

This has been failing ever since GIT_FSMONITOR_TEST was introduced in
883e248b8a ("fsmonitor: teach git to optionally utilize a file system
monitor to speed up detecting new or changed files.", 2017-09-22). Under
-v -x -i:

    + echo test_must_fail: command succeeded: env FAKE_LINES=exec_echo_foo_>file1 1 git rebase -i HEAD^
    test_must_fail: command succeeded: env FAKE_LINES=exec_echo_foo_>file1 1 git rebase -i HEAD^
    + return 1
    error: last command exited with $?=1
    not ok 6 - rebase -i with the exec command checks tree cleanness
    #
    #               git checkout master &&
    #               set_fake_editor &&
    #               test_must_fail env FAKE_LINES="exec_echo_foo_>file1 1" git rebase -i HEAD^ &&

Maybe once this is fixed running the test suite under GIT_FSMONITOR_TEST
would be a useful Travis target, but I don't know the current status of
adding new options to Travis.
