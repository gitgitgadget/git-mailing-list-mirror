From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v5 13/31] git-remote-mediawiki: Add newline in the end of die() error messages
Date: Wed, 12 Jun 2013 17:43:30 +0200
Message-ID: <1371051828-12866-14-git-send-email-celestin.matte@ensimag.fr>
References: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 17:45:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmnFE-0008DS-KE
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 17:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757210Ab3FLPps convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 11:45:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47541 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756844Ab3FLPoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 11:44:16 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5CFiCMV015661
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 17:44:12 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5CFiEqP015034;
	Wed, 12 Jun 2013 17:44:14 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5CFhu5w014096;
	Wed, 12 Jun 2013 17:44:13 +0200
X-Mailer: git-send-email 1.8.3.rc3.18.g21a7b2c
In-Reply-To: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 12 Jun 2013 17:44:12 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227645>

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 26 +++++++++++++--------=
-----
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 86229a1..44c5e0e 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -135,16 +135,16 @@ while (<STDIN>) {
 	if (defined($cmd[0])) {
 		# Line not blank
 		if ($cmd[0] eq "capabilities") {
-			die("Too many arguments for capabilities") unless (!defined($cmd[1]=
));
+			die("Too many arguments for capabilities\n") unless (!defined($cmd[=
1]));
 			mw_capabilities();
 		} elsif ($cmd[0] eq "list") {
-			die("Too many arguments for list") unless (!defined($cmd[2]));
+			die("Too many arguments for list\n") unless (!defined($cmd[2]));
 			mw_list($cmd[1]);
 		} elsif ($cmd[0] eq "import") {
-			die("Invalid arguments for import") unless ($cmd[1] ne "" && !defin=
ed($cmd[2]));
+			die("Invalid arguments for import\n") unless ($cmd[1] ne "" && !def=
ined($cmd[2]));
 			mw_import($cmd[1]);
 		} elsif ($cmd[0] eq "option") {
-			die("Too many arguments for option") unless ($cmd[1] ne "" && $cmd[=
2] ne "" && !defined($cmd[3]));
+			die("Too many arguments for option\n") unless ($cmd[1] ne "" && $cm=
d[2] ne "" && !defined($cmd[3]));
 			mw_option($cmd[1],$cmd[2]);
 		} elsif ($cmd[0] eq "push") {
 			mw_push($cmd[1]);
@@ -241,7 +241,7 @@ sub get_mw_tracked_categories {
 			cmtitle =3D> $category,
 			cmlimit =3D> 'max' } )
 			|| die $mediawiki->{error}->{code} . ': '
-				. $mediawiki->{error}->{details};
+				. $mediawiki->{error}->{details} . "\n";
 		foreach my $page (@{$mw_pages}) {
 			$pages->{$page->{title}} =3D $page;
 		}
@@ -766,7 +766,7 @@ sub get_more_refs {
 		} elsif ($line eq "\n") {
 			return @refs;
 		} else {
-			die("Invalid command in a '$cmd' batch: ". $_);
+			die("Invalid command in a '$cmd' batch: $_\n");
 		}
 	}
 	return;
@@ -878,7 +878,7 @@ sub mw_import_revids {
 		my $result =3D $mediawiki->api($query);
=20
 		if (!$result) {
-			die "Failed to retrieve modified page for revision $pagerevid";
+			die "Failed to retrieve modified page for revision $pagerevid\n";
 		}
=20
 		if (defined($result->{query}->{badrevids}->{$pagerevid})) {
@@ -887,7 +887,7 @@ sub mw_import_revids {
 		}
=20
 		if (!defined($result->{query}->{pages})) {
-			die "Invalid revision $pagerevid.";
+			die "Invalid revision $pagerevid.\n";
 		}
=20
 		my @result_pages =3D values(%{$result->{query}->{pages}});
@@ -998,7 +998,7 @@ sub mw_upload_file {
 			}, {
 				skip_encoding =3D> 1
 			} ) || die $mediawiki->{error}->{code} . ':'
-				 . $mediawiki->{error}->{details};
+				 . $mediawiki->{error}->{details} . "\n";
 			my $last_file_page =3D $mediawiki->get_page({title =3D> $path});
 			$newrevid =3D $last_file_page->{revid};
 			print STDERR "Pushed file: $new_sha1 - $complete_file_name.\n";
@@ -1078,7 +1078,7 @@ sub mw_push_file {
 				# Other errors. Shouldn't happen =3D> just die()
 				die 'Fatal: Error ' .
 				    $mediawiki->{error}->{code} .
-				    ' from mediwiki: ' . $mediawiki->{error}->{details};
+				    ' from mediwiki: ' . $mediawiki->{error}->{details} . "\n";
 			}
 		}
 		$newrevid =3D $result->{edit}->{newrevid};
@@ -1100,7 +1100,7 @@ sub mw_push {
 	my $pushed;
 	for my $refspec (@refsspecs) {
 		my ($force, $local, $remote) =3D $refspec =3D~ /^(\+)?([^:]*):([^:]*=
)$/
-		    or die("Invalid refspec for push. Expected <src>:<dst> or +<src>=
:<dst>");
+		    or die("Invalid refspec for push. Expected <src>:<dst> or +<src>=
:<dst>\n");
 		if ($force) {
 			print STDERR "Warning: forced push not allowed on a MediaWiki.\n";
 		}
@@ -1172,7 +1172,7 @@ sub mw_push_revision {
 					$local_ancestry{$parent} =3D $child;
 				}
 			} elsif (!$line =3D~ /^([a-f0-9]+)/) {
-				die "Unexpected output from git rev-list: $line";
+				die "Unexpected output from git rev-list: $line\n";
 			}
 		}
 		while ($parsed_sha1 ne $HEAD_sha1) {
@@ -1226,7 +1226,7 @@ sub mw_push_revision {
 				return error_non_fast_forward($remote);
 			}
 			if ($status ne "ok") {
-				die("Unknown error from mw_push_file()");
+				die("Unknown error from mw_push_file()\n");
 			}
 		}
 		unless ($dumb_push) {
--=20
1.8.3.rc3.18.g21a7b2c
