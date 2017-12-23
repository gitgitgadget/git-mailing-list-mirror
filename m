Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B29E1F404
	for <e@80x24.org>; Sat, 23 Dec 2017 17:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756963AbdLWRoR (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 12:44:17 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33670 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754345AbdLWRoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 12:44:16 -0500
Received: by mail-wm0-f48.google.com with SMTP id g130so28523605wme.0
        for <git@vger.kernel.org>; Sat, 23 Dec 2017 09:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=78hLA1QBqCGkKmRdA+RjEcbZFCh70QZvmB7CPSnUUmc=;
        b=d0zZmg0JTr4LuVwzfwU70HEPXCb2xmr68+ivjefWj2SAduspQCxdenx4uqU0f2k+Ve
         nbv1LA5tZS8+tW8sRtdTERkIqAi/ml03in9VimacaVOVHqC1bx4bALEQ5GIMjLdW4DdC
         WmV92nZmSHPioxdTX/TkGAeJ2j3WslSLc/bGIIEbcT1sUZmR21Ddgmj3HRFlWRX8eYU2
         ZC8YxKxJxE9xzYjroqLBjfHpkcw0oFwHcbShmsxZ3pEJTQIyzYvf7VgqcSyMI5pb0EYl
         h8fC+/gacZUCFl2AHbC2Sdps2CXO8IN8mgCCX/d+fIODdVbjgvcJCLX/IIvh91GDPogk
         xG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=78hLA1QBqCGkKmRdA+RjEcbZFCh70QZvmB7CPSnUUmc=;
        b=G4X2F3m/XF7wL7sPP8PkD9qEUavFD3EgeMhUeeOXi51Zf6OM9ow1xhhj6qsuirTsKB
         53u1XmdYKX3DKZ3+JjG7+QJRJf9iOXsVe1Cu8hu2FExB3RjB8+BjbXquJwhEc72xpVr0
         7dV02GANFWwVyxnhIPVpuca/zxWRJgGanhVQ+Jgsl5e2rlGoKloVUm7Ma/U2WvCuXbE7
         /PsnyLLuRX9ux+v66WSgXYGTKdLulhvq3FJk7ADSEiIWNeZy9ENYT8U+LBgl7zk8fEfr
         AAtdq3DkOFoLGjf9IFeMplK5Dsmw/lbMg2lDun7+GgixhmF1fE1f42E1xre2GCmWv8E4
         iF2A==
X-Gm-Message-State: AKGB3mLE4vvWqr+AdTn5xYtCmE0M/A0NWVwR5sc5gnmIN+mZQc0HCspJ
        pKBZDtjRbVmoRJVkakigRCwxv5wJ
X-Google-Smtp-Source: ACJfBoso70AyL+S6ib1sU6OnZ6YUfR2eW5hcB3X/HBvL91A/tL5hi2al5lX1Dbe7EWB+FCRs6lAIuw==
X-Received: by 10.80.179.187 with SMTP id s56mr19539165edd.87.1514051054384;
        Sat, 23 Dec 2017 09:44:14 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q3sm21161956edd.61.2017.12.23.09.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Dec 2017 09:44:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>, Jakub Narebski <jnareb@gmail.com>,
        Petr Baudis <pasky@suse.cz>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH] perl: bump the required Perl version to 5.10.0 from 5.8.0
Date:   Sat, 23 Dec 2017 17:44:00 +0000
Message-Id: <20171223174400.26668-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In late 2010 I bumped our perl version dependency from 5.6.* to
5.8.0[1]. Git had been failing for a while on <5.8, and it was
suspected that nobody cared enough to keep using it, which turned out
to be true.

Follow that up with bumping the dependency to 5.10.0. The 5.8.0
release was released in 2002, and the 5.10.0 release just turned 10
years old[2].

This is similar to Jeff King's jk/drop-ancient-curl series in that
we're dropping perl releases that are rarely tested anymore, however
unlike those patches git still works on e.g. 5.8.8 (I couldn't build
anything older).

The reason to do this is to be able to use features released with perl
in the last decade, 5.10 was a major feature release including things
like new regex features, state variables, the defined-or operator
etc.[3]

I expect this to be more controversial as since the 5.8 release stayed
along for longer in various distributions, e.g. it's the version
shipped with RHEL 5, replaced by 5.10 in RHEL 6 released in late 2010,
similarly the first Debian release to include 5.10 was 5.0 (Lenny)
released in early 2009. The release history for other distributions
can be seen on CPAN's "Perl Binaries" page[3].

1. d48b284183 ("perl: bump the required Perl version to 5.8 from
   5.6.[21]", 2010-09-24)

2. "perldoc perlhist" (https://metacpan.org/pod/distribution/perl/pod/perlhist.pod)

3. "perldoc perl5100delta" (https://metacpan.org/pod/distribution/perl/pod/perl5100delta.pod)

3. http://www.cpan.org/ports/binaries.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

RFC because this'll need to be adjusted for my cooking Makefile.PL
changes, and because the patch is obviously "correct", so the question
is "do we want to do this". Discuss.

 contrib/diff-highlight/DiffHighlight.pm | 2 +-
 contrib/examples/git-difftool.perl      | 2 +-
 contrib/mw-to-git/Git/Mediawiki.pm      | 2 +-
 git-add--interactive.perl               | 2 +-
 git-archimport.perl                     | 2 +-
 git-cvsexportcommit.perl                | 2 +-
 git-cvsimport.perl                      | 2 +-
 git-cvsserver.perl                      | 2 +-
 git-send-email.perl                     | 2 +-
 git-svn.perl                            | 2 +-
 gitweb/gitweb.perl                      | 2 +-
 perl/Git.pm                             | 2 +-
 perl/Git/I18N.pm                        | 2 +-
 perl/Git/Packet.pm                      | 2 +-
 t/t0021/rot13-filter.pl                 | 2 +-
 t/t0202/test.pl                         | 2 +-
 t/t9000/test.pl                         | 2 +-
 t/t9700/test.pl                         | 2 +-
 t/test-terminal.perl                    | 2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
index 663992e530..21fe5d424f 100644
--- a/contrib/diff-highlight/DiffHighlight.pm
+++ b/contrib/diff-highlight/DiffHighlight.pm
@@ -1,6 +1,6 @@
 package DiffHighlight;
 
-use 5.008;
+use v5.10.0;
 use warnings FATAL => 'all';
 use strict;
 
diff --git a/contrib/examples/git-difftool.perl b/contrib/examples/git-difftool.perl
index df59bdfe97..13c44846a8 100755
--- a/contrib/examples/git-difftool.perl
+++ b/contrib/examples/git-difftool.perl
@@ -10,7 +10,7 @@
 #
 # Any arguments that are unknown to this script are forwarded to 'git diff'.
 
-use 5.008;
+use v5.10.0;
 use strict;
 use warnings;
 use Error qw(:try);
diff --git a/contrib/mw-to-git/Git/Mediawiki.pm b/contrib/mw-to-git/Git/Mediawiki.pm
index 917d9e2d32..5b620b8425 100644
--- a/contrib/mw-to-git/Git/Mediawiki.pm
+++ b/contrib/mw-to-git/Git/Mediawiki.pm
@@ -1,6 +1,6 @@
 package Git::Mediawiki;
 
-use 5.008;
+use v5.10.0;
 use strict;
 use POSIX;
 use Git;
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 28b325d754..b59c9eaf30 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1,6 +1,6 @@
 #!/usr/bin/perl
 
-use 5.008;
+use v5.10.0;
 use strict;
 use warnings;
 use Git qw(unquote_path);
diff --git a/git-archimport.perl b/git-archimport.perl
index b7c173c345..7d13f7ef16 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -54,7 +54,7 @@ and can contain multiple, unrelated branches.
 
 =cut
 
-use 5.008;
+use v5.10.0;
 use strict;
 use warnings;
 use Getopt::Std;
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index d13f02da95..c50d981208 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -1,6 +1,6 @@
 #!/usr/bin/perl
 
-use 5.008;
+use v5.10.0;
 use strict;
 use warnings;
 use Getopt::Std;
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 36929921ea..7d4dd07d35 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -13,7 +13,7 @@
 # The head revision is on branch "origin" by default.
 # You can change that with the '-o' option.
 
-use 5.008;
+use v5.10.0;
 use strict;
 use warnings;
 use Getopt::Long;
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index ae1044273d..ddb423dbc2 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -15,7 +15,7 @@
 ####
 ####
 
-use 5.008;
+use v5.10.0;
 use strict;
 use warnings;
 use bytes;
diff --git a/git-send-email.perl b/git-send-email.perl
index edcc6d3469..3f162b6bae 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -16,7 +16,7 @@
 #    and second line is the subject of the message.
 #
 
-use 5.008;
+use v5.10.0;
 use strict;
 use warnings;
 use POSIX qw/strftime/;
diff --git a/git-svn.perl b/git-svn.perl
index d2404184ba..c50ceab533 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 # Copyright (C) 2006, Eric Wong <normalperson@yhbt.net>
 # License: GPL v2 or later
-use 5.008;
+use v5.10.0;
 use warnings;
 use strict;
 use vars qw/	$AUTHOR $VERSION
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2417057f2b..25178a31f7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7,7 +7,7 @@
 #
 # This program is licensed under the GPLv2
 
-use 5.008;
+use v5.10.0;
 use strict;
 use warnings;
 # handle ACL in file access tests
diff --git a/perl/Git.pm b/perl/Git.pm
index ffa09ace92..768653f2a6 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -7,7 +7,7 @@ Git - Perl interface to the Git version control system
 
 package Git;
 
-use 5.008;
+use v5.10.0;
 use strict;
 
 
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index 836a5c2382..1d4dce687f 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -1,5 +1,5 @@
 package Git::I18N;
-use 5.008;
+use v5.10.0;
 use strict;
 use warnings;
 BEGIN {
diff --git a/perl/Git/Packet.pm b/perl/Git/Packet.pm
index b75738bed4..4a1491a1dd 100644
--- a/perl/Git/Packet.pm
+++ b/perl/Git/Packet.pm
@@ -1,5 +1,5 @@
 package Git::Packet;
-use 5.008;
+use v5.10.0;
 use strict;
 use warnings;
 BEGIN {
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index f1678851de..be6177f564 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -30,7 +30,7 @@
 #     to the "list_available_blobs" response.
 #
 
-use 5.008;
+use v5.10.0;
 use lib (split(/:/, $ENV{GITPERLLIB}));
 use strict;
 use warnings;
diff --git a/t/t0202/test.pl b/t/t0202/test.pl
index 2cbf7b9590..3c122ccec0 100755
--- a/t/t0202/test.pl
+++ b/t/t0202/test.pl
@@ -1,5 +1,5 @@
 #!/usr/bin/perl
-use 5.008;
+use v5.10.0;
 use lib (split(/:/, $ENV{GITPERLLIB}));
 use strict;
 use warnings;
diff --git a/t/t9000/test.pl b/t/t9000/test.pl
index dfeaa9c655..1ac3566c1f 100755
--- a/t/t9000/test.pl
+++ b/t/t9000/test.pl
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 use lib (split(/:/, $ENV{GITPERLLIB}));
 
-use 5.008;
+use v5.10.0;
 use warnings;
 use strict;
 
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 34cd01366f..f1d46465b5 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 use lib (split(/:/, $ENV{GITPERLLIB}));
 
-use 5.008;
+use v5.10.0;
 use warnings;
 use strict;
 
diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index 46bf618479..fab093a957 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -1,5 +1,5 @@
 #!/usr/bin/perl
-use 5.008;
+use v5.10.0;
 use strict;
 use warnings;
 use IO::Pty;
-- 
2.15.1.424.g9478a66081

