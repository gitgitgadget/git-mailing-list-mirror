Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68041F5A2
	for <e@80x24.org>; Fri, 15 Nov 2019 01:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKOBAe (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:00:34 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:44433 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfKOBAe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:00:34 -0500
Received: by mail-pg1-f172.google.com with SMTP id f19so4875501pgk.11
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Oie5vSAMWkIPg5+bXMtiSkiob/K7xy6Tw3j920JJeUM=;
        b=fLgrHAKzKiAk3bPaelljdMvk+FVCansVvcyMYesyMjZWgGzXe1k6YkLzXAekmuSFkF
         DxjBoOQ5glsd5eMmsTCawE2qCTYhqpC2sRw+VKoI0dQ+LZZzWjUUG3KPphq6VBkjUdph
         V6HvInvpNdusGpUALd8njW8HJMv66hq5zCmVNxVlbJ4wlRlaJVuv3gf8OCbV2/CJKryg
         N0HHr8rqFyz/1IGXXbOKb4q7LeCtBvsIr3dGAa+MEif+MY+HMKRmuUDhhMVjGQrQeqGD
         5CqVR+ihhXgMlsi2oBkWTRJIHG4B6czMwwdoooiBO/c6ze+21Irhtf/YA2wFTOEgqpt8
         fpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Oie5vSAMWkIPg5+bXMtiSkiob/K7xy6Tw3j920JJeUM=;
        b=ImisoF3/0tTNNvMdufpUMwzPlL3iEyCCx7GT720lIgvtSU/UP9MdsAezpk/fwnadPd
         kzJXCN5+n/CD2os6rPrfZgbRXXbrEcizPDhrt3B7bLafWt7nEyYm8Rd4dLgJGms3bqgt
         TDmHdIRHmYFAegKWWp+VCGHG3ClhU6fKmR4AUFhPMlVm7ZH+xQC+VgpELyabr+sG6Bjb
         FSReIaOaTt3OL+b4hfQ3DrI+kztiAQ6/Eb0050kGmM+13zhVvzTqfrYFoDkobS9L2wLT
         e0TzcdY/Qhm9Rd9TJUC5lavZAb8Buo8uFLncRvS7VcihJIQPnzAlclXobdzo8nQvtwyB
         vmuw==
X-Gm-Message-State: APjAAAVLEmBcMVOdFuZZdk8/Xx05UNLGu5XVpEvbzx6zzSw2h3dzXtvL
        rjBR7UEBGBUR9pw/HfWLm8fcsTwk
X-Google-Smtp-Source: APXvYqy93b6jognUKbOgNdrTrAn8g+3JUWRHidVwJh4ezJ8LbN+6lxLTbD50LCjleyW9ev8FszSTMQ==
X-Received: by 2002:a62:82c1:: with SMTP id w184mr14354363pfd.134.1573779633209;
        Thu, 14 Nov 2019 17:00:33 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id q20sm7468294pff.134.2019.11.14.17.00.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:00:32 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:00:29 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 00/27] t: general test cleanup + `set -o pipefail`
Message-ID: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patches 1-20 perform some general test cleanup to modernise the style.
They should be relatively uncontroversial and can be merged earlier (or
as a separate series) if desired. The reason these tests were identified
for cleanup was because they failed under `set -o pipefail`.

Patches 21-27 should be considered RFC. In an attempt to catch git
commands failing in the upstream of a pipe, we enable `set -o pipefail`
on Bash. This may result in some funny-looking shell script constructs
(e.g. needing to wrap `grep` since it may "fail") but overall, I think it
is an improvement since we catch failure in more cases.

This change should be backwards compatible with shells that don't
support pipefail since tests that pass under pipefail should be a subset
of tests that can pass without pipefail.

I've tested these patches on Linux, MacOS and Travis[1], although I skipped
CVS, SVN, Apache2 tests (and maybe others?). I'd appreciate help testing
these patches on that regard.

[1]: https://travis-ci.org/Denton-L/git/builds/612133448

Denton Liu (27):
  lib-bash.sh: move `then` onto its own line
  t0014: remove git command upstream of pipe
  t0090: stop losing return codes of git commands
  t3301: stop losing return codes of git commands
  t3600: use test_line_count() where possible
  t3600: stop losing return codes of git commands
  t3600: comment on inducing SIGPIPE in `git rm`
  t4015: stop losing return codes of git commands
  t4015: use test_write_lines()
  t4138: stop losing return codes of git commands
  t5317: stop losing return codes of git commands
  t5317: use ! grep to check for no matching lines
  t5703: stop losing return codes of git commands
  t7501: remove spaces after redirect operators
  t7501: stop losing return codes of git commands
  t7700: drop redirections to /dev/null
  t7700: remove spaces after redirect operators
  t7700: move keywords onto their own line
  t7700: s/test -f/test_path_is_file/
  t7700: stop losing return codes of git commands
  t: define test_grep_return_success()
  t0090: mask failing grep status
  t3600: mark git command as failing
  t5004: ignore SIGPIPE in zipinfo
  t5703: mask failing grep status
  t9902: disable pipefail
  t: run tests with `set -o pipefail` on Bash

 t/README                               |   4 +
 t/lib-bash.sh                          |   3 +-
 t/t0014-alias.sh                       |   4 +-
 t/t0090-cache-tree.sh                  |   5 +-
 t/t3301-notes.sh                       | 230 ++++++++++++++++++-------
 t/t3600-rm.sh                          |  16 +-
 t/t4015-diff-whitespace.sh             | 123 +++++++------
 t/t4138-apply-ws-expansion.sh          |  16 +-
 t/t5004-archive-corner-cases.sh        |   4 +-
 t/t5317-pack-objects-filter-objects.sh |  34 ++--
 t/t5703-upload-pack-ref-in-want.sh     |  52 ++++--
 t/t7501-commit-basic-functionality.sh  |  83 +++++----
 t/t7700-repack.sh                      | 125 ++++++++------
 t/t9902-completion.sh                  |   6 +
 t/test-lib-functions.sh                |   5 +
 t/test-lib.sh                          |  12 ++
 16 files changed, 458 insertions(+), 264 deletions(-)

-- 
2.24.0.399.gf8350c9437

