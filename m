Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 348861F454
	for <e@80x24.org>; Thu,  7 Nov 2019 18:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfKGSvU (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 13:51:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34541 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfKGSvU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 13:51:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id n13so3164291pff.1
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 10:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iLa+BVUhpJJ7qHpMNRLfL7sd0GcFpBG1jGe3qbJsgs4=;
        b=Qmml3b+JF8HSR64PHDYYvjqSa5DZpXjwg3yuwKiXsbtP249YjyvxM/wLLVbTx3rW2w
         4Ir9t1bcY97C+GTFfChiKvg+IdbtKFcSKTWbUQS+gW871Q9rI1CXvUhbxvkKNuFgvAj8
         1gYmuFHQ5oPpCZnSFPpPqRpzRsHpuXuWgtHzq7z4jKJO48NGokYRbUhiIpSUv0COFvlq
         4id84oIVoCFQK/Nv5yqyMrmiz7+c+Ul1xEs7b5Kjb1HW/xGzxIobLisY4/KAsbJ42PCp
         Fz1GREgNs4Tx63rmbpUZ7T0QQnCcqPINPkB6mJ649q6t1FRPqEycsGCgXHnY79fcb0eG
         ABeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iLa+BVUhpJJ7qHpMNRLfL7sd0GcFpBG1jGe3qbJsgs4=;
        b=cUkMpc2K+H0lV0MNXU1b1FgIf6Nc7J5jzL4FCmb5sxw+Gwey0CvT+txHTqjZ5rBC+C
         y6r3gT95jUtCUKZlD42fqlxA5xBbXFcytnmUFAYl2scOmtJvjGPmwJmCWe7xR3abeoFA
         In8eHXl2bqGGSVFA1eQuLuP2yV2puDBL5Dih3WIkpV1pm4BUvFeiXyOafwe4dcx3xXTJ
         CLVofOuj5urYIqDfricTG9wRw1SF8dwTZ5E7HWOGQNsyLz8xTzwNErTi590JIQP1QGQK
         tgtFwI+8jng291uLSgBpCoz53+/lfQiZAgnE/Fg+ws2R0Qh1BTN5Uqu8oMD8BEzRFlUA
         sH2w==
X-Gm-Message-State: APjAAAVFtfA9PejVgLRTX9Y8iFZzlYBjUlQ5FfJalT1KC6oz5DnrL8iP
        bcsbDQwgsqxVkVjQKvd1/ntKNlpG
X-Google-Smtp-Source: APXvYqx86BYJ+PjgueQol75Mn+8c9GUSw1LkxuAozZyQHSUj9lZUY9+u0zuAJ0cVnOhTDSDsWQ4NGg==
X-Received: by 2002:a62:b616:: with SMTP id j22mr5885946pff.35.1573152678842;
        Thu, 07 Nov 2019 10:51:18 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id d8sm3027463pfo.47.2019.11.07.10.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 10:51:17 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:51:15 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 00/14] t5520: various test cleanup
Message-ID: <cover.1573152598.git.liu.denton@gmail.com>
References: <cover.1571739459.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571739459.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all, since this is general cleanup that shouldn't be too
controversial, I'm looking for some positive acks for this changeset.


Like earlier patchsets, I want to implement a feature that involves
modifications to the test suite. Since that feature will probably take a
while to polish up, however, let's clean up the test suite in a separate
patchset first so it's not blocked by the feature work.

1/15 is a general improvement to test_rev_cmp() that will be used later
in the series.

Changes since v3:

* Rebased and tested on top of v2.24.0

Changes since v2:

* Drop 't7408: replace `test_must_fail test_path_is_file`' since it's
  not a rabbit hole we want to go into right now

* Fix the output of `test_cmp_rev !` when revs are actually equal

* Rebase against the latest master since this topic hasn't been picked
  up yet

Changes since v1:

* Incorporate Eric's feedback

Denton Liu (14):
  t: teach test_cmp_rev to accept ! for not-equals
  t5520: improve test style
  t5520: use sq for test case names
  t5520: let sed open its own input
  t5520: replace test -f with test-lib functions
  t5520: remove spaces after redirect operator
  t5520: use test_line_count where possible
  t5520: replace test -{n,z} with test-lib functions
  t5520: use test_cmp_rev where possible
  t5520: test single-line files by git with test_cmp
  t5520: don't put git in upstream of pipe
  t5520: replace subshell cat comparison with test_cmp
  t5520: remove redundant lines in test cases
  t5520: replace `! git` with `test_must_fail git`

 t/t2400-worktree-add.sh             |   4 +-
 t/t3400-rebase.sh                   |   2 +-
 t/t3421-rebase-topology-linear.sh   |   6 +-
 t/t3430-rebase-merges.sh            |   2 +-
 t/t3432-rebase-fast-forward.sh      |   2 +-
 t/t3501-revert-cherry-pick.sh       |   2 +-
 t/t3508-cherry-pick-many-commits.sh |   2 +-
 t/t5520-pull.sh                     | 343 +++++++++++++++++-----------
 t/test-lib-functions.sh             |  22 +-
 9 files changed, 234 insertions(+), 151 deletions(-)

Range-diff against v3:
 1:  9a96f113e7 =  1:  0d0696f310 t: teach test_cmp_rev to accept ! for not-equals
 2:  dfc86a8d9b =  2:  b1dbe78f5d t5520: improve test style
 3:  a1071038f5 =  3:  ea06a1db3d t5520: use sq for test case names
 4:  0af3f5027b =  4:  d09b591250 t5520: let sed open its own input
 5:  b696ff0a67 =  5:  2af85e3913 t5520: replace test -f with test-lib functions
 6:  d2e49fd990 =  6:  280cfa0adc t5520: remove spaces after redirect operator
 7:  fcfc3226f8 =  7:  1e8ecb80a4 t5520: use test_line_count where possible
 8:  86dafc7b54 =  8:  f31142c683 t5520: replace test -{n,z} with test-lib functions
 9:  bf9b5023a3 =  9:  fdde875363 t5520: use test_cmp_rev where possible
10:  bfabf8ceff = 10:  6cb78bce40 t5520: test single-line files by git with test_cmp
11:  56bcbf3047 = 11:  acbfc39cb0 t5520: don't put git in upstream of pipe
12:  e9d50b8bb0 = 12:  bb529ad84a t5520: replace subshell cat comparison with test_cmp
13:  9db0fc2156 = 13:  d08e34b021 t5520: remove redundant lines in test cases
14:  a721d5f119 = 14:  70698bd902 t5520: replace `! git` with `test_must_fail git`
-- 
2.24.0.rc2.262.g2d07a97ef5

