Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65DCE1F404
	for <e@80x24.org>; Sun,  7 Jan 2018 16:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754133AbeAGQ5o (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 11:57:44 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:43091 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754057AbeAGQ5n (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 11:57:43 -0500
Received: by mail-qt0-f172.google.com with SMTP id w10so11142137qtb.10
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 08:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pv6eXeDpr7sGhLFR1vKSPgQfLhnEmYuqw4b64/oNEAo=;
        b=NKBl2cW1SmgEAW9NaNMwi9Sv0xVcgJp9TFZRA7EA7q+bzH3kHINfmp8rHFPpWjBCGe
         wffB8K+GL2+CjGO/LtOE8493XywvY0jgKg67ty4sgjRK1pqB6yhiUH3bEdw9tQ9t2EVw
         kCUzkhpOc+yQuGGqo+u/SxYsV4DNLlgN1CMYGhncuKCHUiKLiks6cqAKmaosMUuoKJy8
         rWBwLFqhwP5b8RfBmqGlTaF9jPlTQU0AQJKF1NwqNeBXJOeXkU9XYVM6yJx3X+/zqy8J
         +i4IyF+ZvcLvAjm1z5yNsxF/5oovOodyQ5mQAwtqaXDLUQf4pPe61LMrdH7bCmwgJ2sM
         4Chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pv6eXeDpr7sGhLFR1vKSPgQfLhnEmYuqw4b64/oNEAo=;
        b=YmdCNri6vCqDEd9UVjpedmSASSOsT0wm9uKM576Yqcu8dOb4LC/AfQhtBZvv49Elhg
         TwGF//QxQ6uoBxovYtmr7p6G+yEJuWnfnNvcLA4Zqf/mzEKYafTzM4mYgKuyzMwm3OYb
         Sv10gH8fKPLyzogDLi0kMCzFWaC/oKV1aVdjPPNoHzBJ95WDkEm3xBt9EtDY3V8idlR1
         UR49w2TT2MIqaCS0Lqp7Fvub+uGY6kHQSu67v517vCI/X8du64Atj9e3dn/cpvN45+1m
         IBGIfO+qllZ8teBeaV7GHrSyZoTe0Gz6oPAjYGuW5KzLJCvaRVfjPO3GNPCeiBkaK+pL
         5NnQ==
X-Gm-Message-State: AKwxytdLmX2uBkH0O6w3IMKZPf0RTM/JkT3uUc28awcp6Xx+XgIImMag
        Vg1GftpmyNG5fNDvEcDqkArXqGmqPug=
X-Google-Smtp-Source: ACJfBouofoHhSJHZl7pQPGPF7WSskCzmU0LlCW981nVEa2RsUTwwTqlSW1TthJeQ6CxAzNw2mcolFA==
X-Received: by 10.200.27.116 with SMTP id p49mr12376626qtk.254.1515344261710;
        Sun, 07 Jan 2018 08:57:41 -0800 (PST)
Received: from localhost.localdomain (ip-35-41-54-196.montreal.ca.northamericancoax.com. [196.54.41.35])
        by smtp.gmail.com with ESMTPSA id l52sm6421164qtc.43.2018.01.07.08.57.39
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 08:57:40 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org
Cc:     Dan Jacques <dnj@google.com>, avarab@gmail.com,
        Johannes.Schindelin@gmx.de, gitster@pobox.com
Subject: [PATCH v5 0/3] RUNTIME_PREFIX relocatable Git
Date:   Sun,  7 Jan 2018 11:56:10 -0500
Message-Id: <20180107165613.78434-1-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch set expands support for the RUNTIME_PREFIX configuration flag,
currently only used on Windows builds, to include Linux, Darwin, and
FreeBSD. When Git is built with RUNTIME_PREFIX enabled, it resolves its
ancillary paths relative to the runtime location of its executable
rather than hard-coding them at compile-time, allowing a Git
installation to be deployed to a path other than the one in which it
was built/installed.

Note that RUNTIME_PREFIX is not currently used outside of Windows.
This patch set should not have an impact on default Git builds.

I'm uploading an updated patch set now that avarab@'s Perl Makefile
simplification patch set has advanced and seems to be stable. Please take
a look and let me know what you think!

Previous threads:
v1: https://public-inbox.org/git/20171116170523.28696-1-dnj@google.com/
v2: https://public-inbox.org/git/20171119173141.4896-1-dnj@google.com/
v3: https://public-inbox.org/git/20171127164055.93283-1-dnj@google.com/
v4: https://public-inbox.org/git/20171129223807.91343-1-dnj@google.com/

Changes in v5 from v4:

- Rebase on top of "next", notably incorporating the
  "ab/simplify-perl-makefile" branch.
- Cleaner Makefile relative path enforcement.
- Update Perl header template path now that the "perl/" directory has
  fewer build-related files in it.
- Update Perl runtime prefix header to use a general system path resolution
  function.
- Implemented the injection of the locale directory into Perl's
  "Git/I18N.pm" module from the runtime prefix Perl script header.
- Updated Perl's "Git/I18N.pm" module to accept injected locale directory.
- Added more content to some comments.

=== Testing ===

The latest patch set is available for testing on my GitHub fork, including
"travis.ci" testing. The "runtime-prefix" branch includes a "config.mak"
commit that enables runtime prefix for the Travis build; the
"runtime-prefix-no-config" omits this file, testing this patch without
runtime prefix enabled:
- https://github.com/danjacques/git/tree/runtime-prefix
- https://travis-ci.org/danjacques/git/branches

Built/tested locally using this "config.mak" w/ autoconf:

=== Example config.mak ===

## (BEGIN config.mak)

RUNTIME_PREFIX = YesPlease
RUNTIME_PREFIX_PERL = YesPlease
gitexecdir = libexec/git-core
template_dir = share/git-core/templates
sysconfdir = etc

## (END config.mak)

=== Revision History ===

Changes in v4 from v3:

- Incorporated some quoting and Makefile dependency fixes, courtesy of
  <johannes.schindelin@gmx.de>.

Changes in v3 from v2:

- Broken into multiple patches now that Perl is isolated in its own
  RUNTIME_PREFIX_PERL flag.
- Working with avarab@, several changes to Perl script runtime prefix
  support:
  - Moved Perl header body content from Makefile into external template
    file(s).
  - Added generic "perllibdir" variable to override Perl installation
    path.
  - RUNTIME_PREFIX_PERL generated script header is more descriptive and
    consistent with how the C version operates.
  - Fixed Generated Perl header Makefile dependency, should rebuild
    when dependent files and flags change.
- Changed some of the new RUNTIME_PREFIX trace strings to use consistent
  formatting and terminology.

Changes in v2 from v1:

- Added comments and formatting to improve readability of
  platform-sepecific executable path resolution sleds in
  `git_get_exec_path`.
- Consolidated "cached_exec_path" and "argv_exec_path" globals
  into "exec_path_value".
- Use `strbuf_realpath` instead of `realpath` for procfs resolution.
- Removed new environment variable exports. Git with RUNTIME_PREFIX no
  longer exports or consumes any additional environment information.
- Updated Perl script resolution strategy: rather than having Git export
  the relative executable path to the Perl scripts, they now resolve
  it independently when RUNTIME_PREFIX_PERL is enabled.
- Updated resolution strategy for "gettext()": use system_path() instead
  of special environment variable.
- Added `sysctl` executable resolution support for BSDs that don't
  mount "procfs" by default (most of them).

Dan Jacques (3):
  Makefile: generate Perl header from template file
  Makefile: add Perl runtime prefix support
  exec_cmd: RUNTIME_PREFIX on some POSIX systems

 .gitignore                                       |   1 +
 Makefile                                         | 114 +++++++++--
 cache.h                                          |   1 +
 common-main.c                                    |   4 +-
 config.mak.uname                                 |   7 +
 exec_cmd.c                                       | 241 ++++++++++++++++++++---
 exec_cmd.h                                       |   4 +-
 gettext.c                                        |   8 +-
 git.c                                            |   2 +-
 perl/Git/I18N.pm                                 |   2 +-
 perl/header_templates/fixed_prefix.template.pl   |   1 +
 perl/header_templates/runtime_prefix.template.pl |  32 +++
 12 files changed, 364 insertions(+), 53 deletions(-)
 create mode 100644 perl/header_templates/fixed_prefix.template.pl
 create mode 100644 perl/header_templates/runtime_prefix.template.pl

-- 
2.15.0.chromium12

