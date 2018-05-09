Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95B661F42E
	for <e@80x24.org>; Wed,  9 May 2018 21:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965551AbeEIVmR (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 17:42:17 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54591 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964968AbeEIVmP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 17:42:15 -0400
Received: by mail-it0-f68.google.com with SMTP id z6-v6so715147iti.4
        for <git@vger.kernel.org>; Wed, 09 May 2018 14:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cb8+R7iaIfFgoRFFi9CFAJBxrhOeEi31ONbxk3f9iu4=;
        b=SFdGWwhR0eEmPsR9+rZcdQ4dTY1l8R5sAd8pd7pvwSPj1+zsFXc11f7AWc0Qyzqvb8
         GHV7iSZgIWyT61I2xll/Q0YQi3Gq/Wa3JoAbAl2d1BjoAF+dGwd8oObASdt0xtcdO1LE
         eSssHgnm2uNHIR8+4nzkqkMW/hQPYEagyx71PzrGsV4Kpo+0d88tLZeUQ4fwfWf3ZJ4B
         UGp/Xle+UL669IPfnG4gWy0fqHH0ResVeRvn+XA+7Iz6kqzosECAF8/wS8NZmNsYiewm
         f6sMrc9Omc6qm9bQyS9xNm3ItWGlUuxv0AAfPIfMC55ybV6c3mo6ImXCWmooDMU1EyRM
         li4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cb8+R7iaIfFgoRFFi9CFAJBxrhOeEi31ONbxk3f9iu4=;
        b=Bzd6qbnq/VkeLvGG0ncdZ+vItpeZ1K2e8qw+tPGDnWgtm4lubdEugZMlUnjmkqk3F1
         t1gvI6SXGvKnNCXZJpa/NZJ9qPUxxA1YYZ0CHgKkCQqCVXJkONPNgopS4j6PzomTuW7l
         IIeCb7tKOycXwQdMHgfru3ODLIutCsW4bt4D4vkcg57UUvya+8oeM3TM2i+cR6jp8A2w
         y1kt6SumTaq0005y5NwH2zsZlisHmiRl8XpHS2f9WnXavCwTv4ZJHYQQLwSDSXYleaFd
         RvqFXAxCJVp5Rsf5GicwmadYWe61moXM4nsme5g+psHDy7CcwKpTiWMaMeOs4n1TVGyL
         ZPxA==
X-Gm-Message-State: ALKqPweSmdUJy0SWuGIokoGn3Pz3cbykFDL4iMGR7cwbb0qx+2BrxMK4
        FOzDjtkRRq1021zI29mdFLA=
X-Google-Smtp-Source: AB8JxZrZEkKKjvROPH8y5diPYU0XzOtQJoS7vicXiZFj6lijwtLogLclykeDVJS8hsCFbpTG4HK2eg==
X-Received: by 2002:a24:ee4b:: with SMTP id b72-v6mr11612479iti.43.1525902134992;
        Wed, 09 May 2018 14:42:14 -0700 (PDT)
Received: from lmm-notebook.localdomain ([2607:fcc8:ab60:f900:a617:31ff:fe15:270b])
        by smtp.gmail.com with ESMTPSA id v37-v6sm14234961ioi.86.2018.05.09.14.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 14:42:14 -0700 (PDT)
Received: by lmm-notebook.localdomain (Postfix, from userid 1000)
        id 7D2101750000000137A8; Wed,  9 May 2018 17:39:09 -0400 (DST)
From:   Luis Marsano <luis.marsano@gmail.com>
To:     git@vger.kernel.org
Cc:     Luis Marsano <luis.marsano@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ted Zlatanov <tzz@lifelogs.com>
Subject: [PATCH 1/2] git-credential-netrc: adapt to test framework for git
Date:   Wed,  9 May 2018 17:36:33 -0400
Message-Id: <20180509213634.5198-2-luis.marsano@gmail.com>
X-Mailer: git-send-email 2.17.0.584.g3d5ba9c85
In-Reply-To: <20180509213634.5198-1-luis.marsano@gmail.com>
References: <20180509213634.5198-1-luis.marsano@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

until this change, git-credential-netrc did not test in a repository
this change reuses the main test framework, which provides such tests
specific changes
- switch to Test::More module
- use File::Basename & File::Spec::Functions

Signed-off-by: Luis Marsano <luis.marsano@gmail.com>
Acked-by: Ted Zlatanov <tzz@lifelogs.com>
---
 contrib/credential/netrc/Makefile             |  4 +-
 .../netrc/t-git-credential-netrc.sh           | 31 ++++++++
 contrib/credential/netrc/test.pl              | 73 ++++++++++++-------
 3 files changed, 78 insertions(+), 30 deletions(-)
 create mode 100755 contrib/credential/netrc/t-git-credential-netrc.sh

diff --git a/contrib/credential/netrc/Makefile b/contrib/credential/netrc/Makefile
index 51b76138a..0ffa40719 100644
--- a/contrib/credential/netrc/Makefile
+++ b/contrib/credential/netrc/Makefile
@@ -1,5 +1,5 @@
 test:
-	./test.pl
+	./t-git-credential-netrc.sh
 
 testverbose:
-	./test.pl -d -v
+	./t-git-credential-netrc.sh -d -v
diff --git a/contrib/credential/netrc/t-git-credential-netrc.sh b/contrib/credential/netrc/t-git-credential-netrc.sh
new file mode 100755
index 000000000..fa21ca240
--- /dev/null
+++ b/contrib/credential/netrc/t-git-credential-netrc.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+(
+	cd ../../../t
+	test_description='git-credential-netrc'
+	. ./test-lib.sh
+
+	if ! test_have_prereq PERL; then
+		skip_all='skipping perl interface tests, perl not available'
+		test_done
+	fi
+
+	perl -MTest::More -e 0 2>/dev/null || {
+		skip_all="Perl Test::More unavailable, skipping test"
+		test_done
+	}
+
+	# set up test repository
+
+	test_expect_success \
+    'set up test repository' \
+    ':'
+
+	# The external test will outputs its own plan
+	test_external_has_tap=1
+
+	test_external \
+    'git-credential-netrc' \
+    perl "$TEST_DIRECTORY"/../contrib/credential/netrc/test.pl
+
+	test_done
+)
diff --git a/contrib/credential/netrc/test.pl b/contrib/credential/netrc/test.pl
index 169b6463c..7211b4857 100755
--- a/contrib/credential/netrc/test.pl
+++ b/contrib/credential/netrc/test.pl
@@ -1,83 +1,100 @@
 #!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
 
 use warnings;
 use strict;
-use Test;
+use Test::More qw(no_plan);
+use File::Basename;
+use File::Spec::Functions qw(:DEFAULT rel2abs);
 use IPC::Open2;
 
-BEGIN { plan tests => 15 }
+BEGIN {
+	# t-git-credential-netrc.sh kicks off our testing, so we have to go from there.
+	Test::More->builder->current_test(1);
+	Test::More->builder->no_ending(1);
+}
 
 my @global_credential_args = @ARGV;
-my $netrc = './test.netrc';
-print "# Testing insecure file, nothing should be found\n";
+my $scriptDir = dirname rel2abs $0;
+my $netrc = catfile $scriptDir, 'test.netrc';
+my $netrcGpg = catfile $scriptDir, 'test.netrc.gpg';
+my $gcNetrc = catfile $scriptDir, 'git-credential-netrc';
+local $ENV{PATH} = join ':'
+                      , $scriptDir
+                      , $ENV{PATH}
+                      ? $ENV{PATH}
+                      : ();
+
+diag "Testing insecure file, nothing should be found\n";
 chmod 0644, $netrc;
 my $cred = run_credential(['-f', $netrc, 'get'],
 			  { host => 'github.com' });
 
-ok(scalar keys %$cred, 0, "Got 0 keys from insecure file");
+ok(scalar keys %$cred == 0, "Got 0 keys from insecure file");
 
-print "# Testing missing file, nothing should be found\n";
+diag "Testing missing file, nothing should be found\n";
 chmod 0644, $netrc;
 $cred = run_credential(['-f', '///nosuchfile///', 'get'],
 		       { host => 'github.com' });
 
-ok(scalar keys %$cred, 0, "Got 0 keys from missing file");
+ok(scalar keys %$cred == 0, "Got 0 keys from missing file");
 
 chmod 0600, $netrc;
 
-print "# Testing with invalid data\n";
+diag "Testing with invalid data\n";
 $cred = run_credential(['-f', $netrc, 'get'],
 		       "bad data");
-ok(scalar keys %$cred, 4, "Got first found keys with bad data");
+ok(scalar keys %$cred == 4, "Got first found keys with bad data");
 
-print "# Testing netrc file for a missing corovamilkbar entry\n";
+diag "Testing netrc file for a missing corovamilkbar entry\n";
 $cred = run_credential(['-f', $netrc, 'get'],
 		       { host => 'corovamilkbar' });
 
-ok(scalar keys %$cred, 0, "Got no corovamilkbar keys");
+ok(scalar keys %$cred == 0, "Got no corovamilkbar keys");
 
-print "# Testing netrc file for a github.com entry\n";
+diag "Testing netrc file for a github.com entry\n";
 $cred = run_credential(['-f', $netrc, 'get'],
 		       { host => 'github.com' });
 
-ok(scalar keys %$cred, 2, "Got 2 Github keys");
+ok(scalar keys %$cred == 2, "Got 2 Github keys");
 
-ok($cred->{password}, 'carolknows', "Got correct Github password");
-ok($cred->{username}, 'carol', "Got correct Github username");
+is($cred->{password}, 'carolknows', "Got correct Github password");
+is($cred->{username}, 'carol', "Got correct Github username");
 
-print "# Testing netrc file for a username-specific entry\n";
+diag "Testing netrc file for a username-specific entry\n";
 $cred = run_credential(['-f', $netrc, 'get'],
 		       { host => 'imap', username => 'bob' });
 
-ok(scalar keys %$cred, 2, "Got 2 username-specific keys");
+ok(scalar keys %$cred == 2, "Got 2 username-specific keys");
 
-ok($cred->{password}, 'bobwillknow', "Got correct user-specific password");
-ok($cred->{protocol}, 'imaps', "Got correct user-specific protocol");
+is($cred->{password}, 'bobwillknow', "Got correct user-specific password");
+is($cred->{protocol}, 'imaps', "Got correct user-specific protocol");
 
-print "# Testing netrc file for a host:port-specific entry\n";
+diag "Testing netrc file for a host:port-specific entry\n";
 $cred = run_credential(['-f', $netrc, 'get'],
 		       { host => 'imap2:1099' });
 
-ok(scalar keys %$cred, 2, "Got 2 host:port-specific keys");
+ok(scalar keys %$cred == 2, "Got 2 host:port-specific keys");
 
-ok($cred->{password}, 'tzzknow', "Got correct host:port-specific password");
-ok($cred->{username}, 'tzz', "Got correct host:port-specific username");
+is($cred->{password}, 'tzzknow', "Got correct host:port-specific password");
+is($cred->{username}, 'tzz', "Got correct host:port-specific username");
 
-print "# Testing netrc file that 'host:port kills host' entry\n";
+diag "Testing netrc file that 'host:port kills host' entry\n";
 $cred = run_credential(['-f', $netrc, 'get'],
 		       { host => 'imap2' });
 
-ok(scalar keys %$cred, 2, "Got 2 'host:port kills host' keys");
+ok(scalar keys %$cred == 2, "Got 2 'host:port kills host' keys");
+
+is($cred->{password}, 'bobwillknow', "Got correct 'host:port kills host' password");
+is($cred->{username}, 'bob', "Got correct 'host:port kills host' username");
 
-ok($cred->{password}, 'bobwillknow', "Got correct 'host:port kills host' password");
-ok($cred->{username}, 'bob', "Got correct 'host:port kills host' username");
 
 sub run_credential
 {
 	my $args = shift @_;
 	my $data = shift @_;
 	my $pid = open2(my $chld_out, my $chld_in,
-			'./git-credential-netrc', @global_credential_args,
+			$gcNetrc, @global_credential_args,
 			@$args);
 
 	die "Couldn't open pipe to netrc credential helper: $!" unless $pid;
-- 
2.17.0

