From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: [PATCH v3 3/6] t9001: shorten send-email's output
Date: Tue,  7 Jun 2016 16:01:45 +0200
Message-ID: <20160607140148.23242-4-tom.russello@grenoble-inp.org>
References: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
 <20160607140148.23242-1-tom.russello@grenoble-inp.org>
Cc: erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, matthieu.moy@grenoble-inp.fr,
	e@80x24.org, aaron@schrab.com, gitster@pobox.com,
	Tom RUSSELLO <tom.russello@grenoble-inp.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 16:02:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAHaW-0005VW-AN
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 16:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408AbcFGOCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 10:02:24 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:59900 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780AbcFGOCV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 10:02:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 3CD5E20B3;
	Tue,  7 Jun 2016 16:02:19 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nLn9vDU4sBQA; Tue,  7 Jun 2016 16:02:19 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 2BA0620AF;
	Tue,  7 Jun 2016 16:02:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 2742D2066;
	Tue,  7 Jun 2016 16:02:19 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id inbQdtu3PfWL; Tue,  7 Jun 2016 16:02:19 +0200 (CEST)
Received: from ux-305.grenet.fr (eduroam-033003.grenet.fr [130.190.33.3])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 0E6042064;
	Tue,  7 Jun 2016 16:02:19 +0200 (CEST)
X-Mailer: git-send-email 2.9.0.rc0.40.g1232aeb.dirty
In-Reply-To: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296683>

Messages displayed by `send-email` should be shortened to avoid displaying
unnecesseray informations.

Signed-off-by: Samuel GROOT <samuel.groot@grenoble-inp.org>
Signed-off-by: Tom RUSSELLO <tom.russello@grenoble-inp.org>
Signed-off-by: Matthieu MOY <matthieu.moy@grenoble-inp.fr>
---
 git-send-email.perl   | 22 +++++++++----------
 t/t9001-send-email.sh | 58 +++++++++++++++++++++++++--------------------------
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 6958785..4822f41 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1478,14 +1478,14 @@ foreach my $t (@files) {
 				$sauthor = sanitize_address($author);
 				next if $suppress_cc{'author'};
 				next if $suppress_cc{'self'} and $sauthor eq $sender;
-				printf("(mbox) Adding cc: %s from line '%s'\n",
-					$1, $_) unless $quiet;
+				printf("Adding cc: %s from From: header\n",
+					$1) unless $quiet;
 				push @cc, $1;
 			}
 			elsif (/^To:\s+(.*)$/i) {
 				foreach my $addr (parse_address_line($1)) {
-					printf("(mbox) Adding to: %s from line '%s'\n",
-						$addr, $_) unless $quiet;
+					printf("Adding to: %s from To: header\n",
+						$addr) unless $quiet;
 					push @to, $addr;
 				}
 			}
@@ -1498,8 +1498,8 @@ foreach my $t (@files) {
 					} else {
 						next if ($suppress_cc{'cc'});
 					}
-					printf("(mbox) Adding cc: %s from line '%s'\n",
-						$addr, $_) unless $quiet;
+					printf("Adding cc: %s from Cc: header\n",
+						$addr) unless $quiet;
 					push @cc, $addr;
 				}
 			}
@@ -1532,8 +1532,8 @@ foreach my $t (@files) {
 			# So let's support that, too.
 			$input_format = 'lots';
 			if (@cc == 0 && !$suppress_cc{'cc'}) {
-				printf("(non-mbox) Adding cc: %s from line '%s'\n",
-					$_, $_) unless $quiet;
+				printf("Adding cc: %s from Cc: header\n",
+					$_) unless $quiet;
 				push @cc, $_;
 			} elsif (!defined $subject) {
 				$subject = $_;
@@ -1555,8 +1555,8 @@ foreach my $t (@files) {
 				next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
 			}
 			push @cc, $c;
-			printf("(body) Adding cc: %s from line '%s'\n",
-				$c, $_) unless $quiet;
+			printf("Adding cc: %s from Signed-off-by trailer\n",
+				$c) unless $quiet;
 		}
 	}
 	close $fh;
@@ -1660,7 +1660,7 @@ sub recipients_cmd {
 		$address = sanitize_address($address);
 		next if ($address eq $sender and $suppress_cc{'self'});
 		push @addresses, $address;
-		printf("($prefix) Adding %s: %s from: '%s'\n",
+		printf("Adding %s: %s from: '%s'\n",
 		       $what, $address, $cmd) unless $quiet;
 		}
 	close $fh
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 7fdc876..9b1e56f 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -150,9 +150,9 @@ test_expect_success $PREREQ 'Verify commandline' '
 test_expect_success $PREREQ 'setup expect' "
 cat >expected-show-all-headers <<\EOF
 0001-Second.patch
-(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
-(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
-(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
+Adding cc: A <author@example.com> from From: header
+Adding cc: One <one@example.com> from Cc: header
+Adding cc: two@example.com from Cc: header
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
@@ -503,9 +503,9 @@ test_expect_success $PREREQ 'second message is patch' '
 test_expect_success $PREREQ 'setup expect' "
 cat >expected-suppress-sob <<\EOF
 0001-Second.patch
-(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
-(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
-(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
+Adding cc: A <author@example.com> from From: header
+Adding cc: One <one@example.com> from Cc: header
+Adding cc: two@example.com from Cc: header
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
@@ -555,9 +555,9 @@ test_expect_success $PREREQ 'sendemail.cc set' '
 test_expect_success $PREREQ 'setup expect' "
 cat >expected-suppress-sob <<\EOF
 0001-Second.patch
-(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
-(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
-(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
+Adding cc: A <author@example.com> from From: header
+Adding cc: One <one@example.com> from Cc: header
+Adding cc: two@example.com from Cc: header
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
@@ -587,10 +587,10 @@ test_expect_success $PREREQ 'sendemail.cc unset' '
 test_expect_success $PREREQ 'setup expect' "
 cat >expected-suppress-cccmd <<\EOF
 0001-Second.patch
-(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
-(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
-(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
-(body) Adding cc: C O Mitter <committer@example.com> from line 'Signed-off-by: C O Mitter <committer@example.com>'
+Adding cc: A <author@example.com> from From: header
+Adding cc: One <one@example.com> from Cc: header
+Adding cc: two@example.com from Cc: header
+Adding cc: C O Mitter <committer@example.com> from Signed-off-by: trailer
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
@@ -647,10 +647,10 @@ test_expect_success $PREREQ '--suppress-cc=all' '
 test_expect_success $PREREQ 'setup expect' "
 cat >expected-suppress-body <<\EOF
 0001-Second.patch
-(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
-(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
-(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
-(cc-cmd) Adding cc: cc-cmd@example.com from: './cccmd'
+Adding cc: A <author@example.com> from From: header
+Adding cc: One <one@example.com> from Cc: header
+Adding cc: two@example.com from Cc: header
+Adding cc: cc-cmd@example.com from: './cccmd'
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
@@ -681,9 +681,9 @@ test_expect_success $PREREQ '--suppress-cc=body' '
 test_expect_success $PREREQ 'setup expect' "
 cat >expected-suppress-body-cccmd <<\EOF
 0001-Second.patch
-(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
-(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
-(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
+Adding cc: A <author@example.com> from From: header
+Adding cc: One <one@example.com> from Cc: header
+Adding cc: two@example.com from Cc: header
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
@@ -712,9 +712,9 @@ test_expect_success $PREREQ '--suppress-cc=body --suppress-cc=cccmd' '
 test_expect_success $PREREQ 'setup expect' "
 cat >expected-suppress-sob <<\EOF
 0001-Second.patch
-(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
-(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
-(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
+Adding cc: A <author@example.com> from From: header
+Adding cc: One <one@example.com> from Cc: header
+Adding cc: two@example.com from Cc: header
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
@@ -744,10 +744,10 @@ test_expect_success $PREREQ '--suppress-cc=sob' '
 test_expect_success $PREREQ 'setup expect' "
 cat >expected-suppress-bodycc <<\EOF
 0001-Second.patch
-(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
-(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
-(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
-(body) Adding cc: C O Mitter <committer@example.com> from line 'Signed-off-by: C O Mitter <committer@example.com>'
+Adding cc: A <author@example.com> from From: header
+Adding cc: One <one@example.com> from Cc: header
+Adding cc: two@example.com from Cc: header
+Adding cc: C O Mitter <committer@example.com> from Signed-off-by: trailer
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
@@ -778,8 +778,8 @@ test_expect_success $PREREQ '--suppress-cc=bodycc' '
 test_expect_success $PREREQ 'setup expect' "
 cat >expected-suppress-cc <<\EOF
 0001-Second.patch
-(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
-(body) Adding cc: C O Mitter <committer@example.com> from line 'Signed-off-by: C O Mitter <committer@example.com>'
+Adding cc: A <author@example.com> from From: header
+Adding cc: C O Mitter <committer@example.com> from Signed-off-by: trailer
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
-- 
2.8.3
