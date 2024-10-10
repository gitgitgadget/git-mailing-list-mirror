Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA64F1E9068
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 23:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604600; cv=none; b=EtrEigoW2CRvt3iiOIWiH47hBKIt55bUjAAC20cLonwJoTnEqew6/jJfZ4Mc9etCB0o2zRVgGNhEDkwjH1H46Lpm+0b5C31zN5DTTQEVXGLex9dbfMKiGIwoasBLMJ8vy5NcM1ZmQqaF8FBhW+IwxUmkmcm4kveLWXJdX6kAkA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604600; c=relaxed/simple;
	bh=fQMu6H2F671dMG3E6eFxHnH0fphsCRtRNbQ5FKxOthk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAX28Z3UUUYmZXFWwjqhNXVdLSOekkrU/GEtD7cUmG1T1WkU1+Fnd3wcONwe11p336/F7u/mfF8Aar33WFxgWCJpgvLEZU/uVJ69LMDOPEC2MJ8/bkQ0ISp1/ubcLDaw8No3EcS5f0zxScg89h1Kk5p4L4khV8w6c3lan1aPKVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=YIBPa32n; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YIBPa32n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728604594;
	bh=fQMu6H2F671dMG3E6eFxHnH0fphsCRtRNbQ5FKxOthk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=YIBPa32nTXjlmiMJuji5OagxJGLh1tu9IPTrfKtSAu7DnyZWpo+Nqh3DgpaMYeUxg
	 rpJRdtTzFRlrFelThOa/ogtZDLjE04PblQPTgoKAY+raG6cwL4YUMg50W0SOJyzTzt
	 WVrb5BZhmMWlLo1g1QecQzeNVXMFwc/ESKHNqm0Q3rOcSJNquipKQ0RI/k9gAT1kpc
	 iVSTsAf1SeH3oOTDLws3TRqOqU7FXeevB/l2+WTCr/XoPNgyaX0k/ANSENmCkFyGAE
	 JgnCfX8KRJ0VdICIZ3PWobpbDQcBTr8xlamVL4ypmjhJxZU9/u0GEzPLCh01RictVX
	 aGEA7Odpi0prIebhrhoGP1lv32DwoBvP/OTWbi8vuFccFiTnxbmASbG4Jeea3CW857
	 zg3ShKqMiXRqLspdG0TJLqFjAn+0PFIdXJVFC14/+HwZB404Ktbyfmu3TEym8jne6o
	 9cqn/Y/Xe8WKWPGnFeWaFxH7R3OtanWAMUGtP771p7jAPAAHvKf
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6F390200C1;
	Thu, 10 Oct 2024 23:56:34 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 11/13] Require Perl 5.26.0
Date: Thu, 10 Oct 2024 23:56:19 +0000
Message-ID: <20241010235621.738239-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20241010235621.738239-1-sandals@crustytoothpaste.net>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
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

    git grep -l 'use 5.008001' | grep -v 'LoadCPAN/' | xargs perl -pi -e 's/use 5.008001/use 5.026000/'

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
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
 17 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
index 636add6968..15be2a49a2 100644
--- a/contrib/diff-highlight/DiffHighlight.pm
+++ b/contrib/diff-highlight/DiffHighlight.pm
@@ -1,6 +1,6 @@
 package DiffHighlight;
 
-use 5.008001;
+use 5.026000;
 use warnings FATAL => 'all';
 use strict;
 
diff --git a/contrib/mw-to-git/Git/Mediawiki.pm b/contrib/mw-to-git/Git/Mediawiki.pm
index ff7811225e..0c0df63d54 100644
--- a/contrib/mw-to-git/Git/Mediawiki.pm
+++ b/contrib/mw-to-git/Git/Mediawiki.pm
@@ -1,6 +1,6 @@
 package Git::Mediawiki;
 
-use 5.008001;
+use 5.026000;
 use strict;
 use POSIX;
 use Git;
diff --git a/git-archimport.perl b/git-archimport.perl
index f5a317b899..0a1e08f6c3 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -54,7 +54,7 @@ =head1 Devel Notes
 
 =cut
 
-use 5.008001;
+use 5.026000;
 use strict;
 use warnings;
 use Getopt::Std;
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 1e03ba94d1..c4fbb4bef3 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -1,6 +1,6 @@
 #!/usr/bin/perl
 
-use 5.008001;
+use 5.026000;
 use strict;
 use warnings;
 use Getopt::Std;
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 211ec8459a..d7229679cf 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -13,7 +13,7 @@
 # The head revision is on branch "origin" by default.
 # You can change that with the '-o' option.
 
-use 5.008001;
+use 5.026000;
 use strict;
 use warnings;
 use Getopt::Long;
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 124f598bdc..145e12cb3e 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -15,7 +15,7 @@
 ####
 ####
 
-use 5.008001;
+use 5.026000;
 use strict;
 use warnings;
 use bytes;
diff --git a/git-send-email.perl b/git-send-email.perl
index c835d4c11a..166d6635bc 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -16,7 +16,7 @@
 #    and second line is the subject of the message.
 #
 
-use 5.008001;
+use 5.026000;
 use strict;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use Getopt::Long;
diff --git a/git-svn.perl b/git-svn.perl
index 01e7a70de1..d1e969feb9 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 # Copyright (C) 2006, Eric Wong <normalperson@yhbt.net>
 # License: GPL v2 or later
-use 5.008001;
+use 5.026000;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 use strict;
 use vars qw/	$AUTHOR $VERSION
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b09a8d0523..c4f92386eb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7,7 +7,7 @@
 #
 # This program is licensed under the GPLv2
 
-use 5.008001;
+use 5.026000;
 use strict;
 use warnings;
 # handle ACL in file access tests
diff --git a/perl/Git.pm b/perl/Git.pm
index 667152c6c6..b6312e6156 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -7,7 +7,7 @@ =head1 NAME
 
 package Git;
 
-use 5.008001;
+use 5.026000;
 use strict;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index 475e90a6df..cdffe19a59 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -1,5 +1,5 @@
 package Git::I18N;
-use 5.008001;
+use 5.026000;
 use strict;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 BEGIN {
diff --git a/perl/Git/LoadCPAN.pm b/perl/Git/LoadCPAN.pm
index 8c7fa805f9..c2bbcdc957 100644
--- a/perl/Git/LoadCPAN.pm
+++ b/perl/Git/LoadCPAN.pm
@@ -1,5 +1,5 @@
 package Git::LoadCPAN;
-use 5.008001;
+use 5.026000;
 use strict;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 
diff --git a/perl/Git/Packet.pm b/perl/Git/Packet.pm
index d896e69523..9ffe3a17c5 100644
--- a/perl/Git/Packet.pm
+++ b/perl/Git/Packet.pm
@@ -1,5 +1,5 @@
 package Git::Packet;
-use 5.008001;
+use 5.026000;
 use strict;
 use warnings $ENV{GIT_PERL_FATAL_WARNINGS} ? qw(FATAL all) : ();
 BEGIN {
diff --git a/t/t0202/test.pl b/t/t0202/test.pl
index 47d96a2a13..853f3ddc47 100755
--- a/t/t0202/test.pl
+++ b/t/t0202/test.pl
@@ -1,5 +1,5 @@
 #!/usr/bin/perl
-use 5.008001;
+use 5.026000;
 use lib (split(/:/, $ENV{GITPERLLIB}));
 use strict;
 use warnings;
diff --git a/t/t5562/invoke-with-content-length.pl b/t/t5562/invoke-with-content-length.pl
index 9babb9a375..ef9671ca51 100644
--- a/t/t5562/invoke-with-content-length.pl
+++ b/t/t5562/invoke-with-content-length.pl
@@ -1,4 +1,4 @@
-use 5.008001;
+use 5.026000;
 use strict;
 use warnings;
 
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 2e1d50d4d1..7572c638bf 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 use lib (split(/:/, $ENV{GITPERLLIB}));
 
-use 5.008001;
+use 5.026000;
 use warnings;
 use strict;
 
diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index b8fd6a4f13..77e79db553 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -1,5 +1,5 @@
 #!/usr/bin/perl
-use 5.008001;
+use 5.026000;
 use strict;
 use warnings;
 use IO::Pty;
