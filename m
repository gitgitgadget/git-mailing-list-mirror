Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A539329422
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644370; cv=none; b=Utz61B4jRcHQ1d/aroVjhOzEFGDRXU1iiEOL/Le77TeS6oTZ0oA5k4h0E4E2ASdv7Vjrr6UYC8ht98hwKcV1z8IcndQVxYodmyPM1VK+s45+eTTqTKgPZjip2QaJg2XiCaa/3shzXVujYImg6kNzOCiJId2zwN8/B+g1vEOrDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644370; c=relaxed/simple;
	bh=vEru1jUYFu1BXHk0qNQWAhhTN3WP3uHXYKLM4fLMz+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+GwxY1gX73mDcLsQgCTiBwmFvKPGm9uZokCw/BYq7YiObir57cUOE0hd8E2blQ4MKbxXiycr/lS1+gVWs/q4RZTf71Qoo7btlO63hyaaokrmve4CixINoUtDNYcq6Dd/9UN/FGZAfJIpaLfQk7dSyYsPDgyfgw0tX1bIJV3pXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=i3qZQBh7; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="i3qZQBh7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729644364;
	bh=vEru1jUYFu1BXHk0qNQWAhhTN3WP3uHXYKLM4fLMz+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=i3qZQBh75Y2AItwj1EDahIxQ4zV7AnwX9TavNCsn0KyDHZ4CPl2Oy+mBTD+7z2VES
	 0AI7ocGxBFlhbnfc+Uas/VgYNqgV2apMeRX6yYoH4aAL8YevmDI7KxMHkf/m2FheX8
	 xaJErrEh1ko2ivGCZ7J7RTzpNO5GkNDWGtLcvwTGYW0YdZJzfbfDiSbDEMk7sH4oNy
	 IP3D9tyiBFZxULbY4M7gj6ARBFGyBUnCgqKbmKEntTFzD7FzYIkB5YXhvU81dciV+x
	 PnLfNCUOI6TEtvtohxHLtSO0bzLSOdZdLaO9FqNY+O7pHd6tZO8UHBBv0ZDt5Pxana
	 oCgvz0Qej32WPUzhSajViLt/Rso9zDa/nr/vVKkYCKVWTlXGNE21sq51pv43gVQUNl
	 0mIy+IK/AAFDzI+qGeDHmC5I3EcbtPusLGPOQFy2fxCqDhKYM4ODuWoaPGgUqhaVix
	 Vla9mpGFE4pTZt4ygfV3gI/6RjSWnFFdsKlKHEiJ3D5Xjc3rj1S
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8D355200C5;
	Wed, 23 Oct 2024 00:46:04 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 11/12] Require Perl 5.26.0
Date: Wed, 23 Oct 2024 00:45:59 +0000
Message-ID: <20241023004600.1645313-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20241023004600.1645313-1-sandals@crustytoothpaste.net>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241023004600.1645313-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our platform support policy states that we require "versions of
dependencies which are generally accepted as stable and supportable,
e.g., in line with the version used by other long-term-support
distributions".  Of Debian, Ubuntu, RHEL, and SLES, the four most common
distributions that provide LTS versions, the version with mainstream
long-term security support with the oldest Perl is 5.26.0 in SLES 15.6.

This is a major upgrade, since Perl 5.8.1, according to the Perl
documentation, was released in September of 2003.  It brings a lot of
new features that we can choose to use, such as s///r to return the
modified string, the postderef functionality, and subroutine signatures,
although the latter was still considered experimental until 5.36.

This change was made with the following one-liner, which intentionally
excludes modifying the vendored modules we include to avoid conflicts:

    git grep -l 'use 5.008001' | grep -v 'LoadCPAN/' | xargs perl -pi -e 's/use 5.008001/require v5.26/'

Use require instead of use to avoid changing the behavior as the latter
enables features and the former does not.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 INSTALL                                 | 2 +-
 contrib/diff-highlight/DiffHighlight.pm | 2 +-
 contrib/mw-to-git/Git/Mediawiki.pm      | 2 +-
 git-archimport.perl                     | 2 +-
 git-cvsexportcommit.perl                | 2 +-
 git-cvsimport.perl                      | 2 +-
 git-cvsserver.perl                      | 2 +-
 git-send-email.perl                     | 2 +-
 git-svn.perl                            | 2 +-
 gitweb/gitweb.perl                      | 2 +-
 perl/Git.pm                             | 2 +-
 perl/Git/I18N.pm                        | 2 +-
 perl/Git/LoadCPAN.pm                    | 2 +-
 perl/Git/Packet.pm                      | 2 +-
 t/t0202/test.pl                         | 2 +-
 t/t5562/invoke-with-content-length.pl   | 2 +-
 t/t9700/test.pl                         | 2 +-
 t/test-terminal.perl                    | 2 +-
 18 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/INSTALL b/INSTALL
index 6e0321ff0e..54d7528f9e 100644
--- a/INSTALL
+++ b/INSTALL
@@ -119,7 +119,7 @@ Issues of note:
 	- A POSIX-compliant shell is required to run some scripts needed
 	  for everyday use (e.g. "bisect", "request-pull").
 
-	- "Perl" version 5.8.1 or later is needed to use some of the
+	- "Perl" version 5.26.0 or later is needed to use some of the
 	  features (e.g. sending patches using "git send-email",
 	  interacting with svn repositories with "git svn").  If you can
 	  live without these, use NO_PERL.  Note that recent releases of
diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
index 636add6968..3d061bc0b7 100644
--- a/contrib/diff-highlight/DiffHighlight.pm
+++ b/contrib/diff-highlight/DiffHighlight.pm
@@ -1,6 +1,6 @@
 package DiffHighlight;
 
-use 5.008001;
+require v5.26;
 use warnings FATAL => 'all';
 use strict;
 
diff --git a/contrib/mw-to-git/Git/Mediawiki.pm b/contrib/mw-to-git/Git/Mediawiki.pm
index ff7811225e..629c0cea44 100644
--- a/contrib/mw-to-git/Git/Mediawiki.pm
+++ b/contrib/mw-to-git/Git/Mediawiki.pm
@@ -1,6 +1,6 @@
 package Git::Mediawiki;
 
-use 5.008001;
+require v5.26;
 use strict;
 use POSIX;
 use Git;
diff --git a/git-archimport.perl b/git-archimport.perl
index f5a317b899..6d0169cb6a 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -54,7 +54,7 @@ =head1 Devel Notes
 
 =cut
 
-use 5.008001;
+require v5.26;
 use strict;
 use warnings;
 use Getopt::Std;
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 1e03ba94d1..edf02f9964 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -1,6 +1,6 @@
 #!/usr/bin/perl
 
-use 5.008001;
+require v5.26;
 use strict;
 use warnings;
 use Getopt::Std;
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 211ec8459a..e10ad5334e 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -13,7 +13,7 @@
 # The head revision is on branch "origin" by default.
 # You can change that with the '-o' option.
 
-use 5.008001;
+require v5.26;
 use strict;
 use warnings;
 use Getopt::Long;
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 124f598bdc..a4ad9a5d2d 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -15,7 +15,7 @@
 ####
 ####
 
-use 5.008001;
+require v5.26;
 use strict;
 use warnings;
 use bytes;
diff --git a/git-send-email.perl b/git-send-email.perl
index c835d4c11a..c4d12bebc8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -16,7 +16,7 @@
 #    and second line is the subject of the message.
 #
 
-use 5.008001;
+require v5.26;
 use strict;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use Getopt::Long;
diff --git a/git-svn.perl b/git-svn.perl
index 01e7a70de1..9c7c629932 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 # Copyright (C) 2006, Eric Wong <normalperson@yhbt.net>
 # License: GPL v2 or later
-use 5.008001;
+require v5.26;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use strict;
 use vars qw/	$AUTHOR $VERSION
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b09a8d0523..da1486cab2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7,7 +7,7 @@
 #
 # This program is licensed under the GPLv2
 
-use 5.008001;
+require v5.26;
 use strict;
 use warnings;
 # handle ACL in file access tests
diff --git a/perl/Git.pm b/perl/Git.pm
index 667152c6c6..6f47d653ab 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -7,7 +7,7 @@ =head1 NAME
 
 package Git;
 
-use 5.008001;
+require v5.26;
 use strict;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index 475e90a6df..ab46edb608 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -1,5 +1,5 @@
 package Git::I18N;
-use 5.008001;
+require v5.26;
 use strict;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 BEGIN {
diff --git a/perl/Git/LoadCPAN.pm b/perl/Git/LoadCPAN.pm
index 8c7fa805f9..61254fddbb 100644
--- a/perl/Git/LoadCPAN.pm
+++ b/perl/Git/LoadCPAN.pm
@@ -1,5 +1,5 @@
 package Git::LoadCPAN;
-use 5.008001;
+require v5.26;
 use strict;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 
diff --git a/perl/Git/Packet.pm b/perl/Git/Packet.pm
index d896e69523..00fd9c484a 100644
--- a/perl/Git/Packet.pm
+++ b/perl/Git/Packet.pm
@@ -1,5 +1,5 @@
 package Git::Packet;
-use 5.008001;
+require v5.26;
 use strict;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 BEGIN {
diff --git a/t/t0202/test.pl b/t/t0202/test.pl
index 47d96a2a13..5085a0eda5 100755
--- a/t/t0202/test.pl
+++ b/t/t0202/test.pl
@@ -1,5 +1,5 @@
 #!/usr/bin/perl
-use 5.008001;
+require v5.26;
 use lib (split(/:/, $ENV{GITPERLLIB}));
 use strict;
 use warnings;
diff --git a/t/t5562/invoke-with-content-length.pl b/t/t5562/invoke-with-content-length.pl
index 9babb9a375..211e29fade 100644
--- a/t/t5562/invoke-with-content-length.pl
+++ b/t/t5562/invoke-with-content-length.pl
@@ -1,4 +1,4 @@
-use 5.008001;
+require v5.26;
 use strict;
 use warnings;
 
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 2e1d50d4d1..58a9b328d5 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 use lib (split(/:/, $ENV{GITPERLLIB}));
 
-use 5.008001;
+require v5.26;
 use warnings;
 use strict;
 
diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index b8fd6a4f13..862bb8f395 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -1,5 +1,5 @@
 #!/usr/bin/perl
-use 5.008001;
+require v5.26;
 use strict;
 use warnings;
 use IO::Pty;
