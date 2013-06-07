From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v2 02/22] git-remote-mediawiki: Use the Readonly module instead of the constant pragma
Date: Fri,  7 Jun 2013 23:42:03 +0200
Message-ID: <1370641344-4253-3-git-send-email-celestin.matte@ensimag.fr>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 23:44:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4SH-0000Qt-NV
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 23:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756375Ab3FGVnE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 17:43:04 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55283 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755977Ab3FGVnC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 17:43:02 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r57Lgusk003234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 23:42:56 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r57Lgx01029553;
	Fri, 7 Jun 2013 23:42:59 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r57LgqRd019409;
	Fri, 7 Jun 2013 23:42:59 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 07 Jun 2013 23:42:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r57Lgusk003234
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371246177.85423@vSRTezwKrGNb+yMVjTcGOw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226737>

=46ollow ValuesAndExpressions::ProhibitConstantPragma

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |   26 +++++++++++++------=
-------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 4893442..e60793a 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -26,21 +26,21 @@ use IPC::Open2;
 use Readonly;
=20
 # Mediawiki filenames can contain forward slashes. This variable decid=
es by which pattern they should be replaced
-use constant SLASH_REPLACEMENT =3D> "%2F";
+Readonly my $SLASH_REPLACEMENT =3D> "%2F";
=20
 # It's not always possible to delete pages (may require some
 # privileges). Deleted pages are replaced with this content.
-use constant DELETED_CONTENT =3D> "[[Category:Deleted]]\n";
+Readonly my $DELETED_CONTENT =3D> "[[Category:Deleted]]\n";
=20
 # It's not possible to create empty pages. New empty files in Git are
 # sent with this content instead.
-use constant EMPTY_CONTENT =3D> "<!-- empty page -->\n";
+Readonly my $EMPTY_CONTENT =3D> "<!-- empty page -->\n";
=20
 # used to reflect file creation or deletion in diff.
-use constant NULL_SHA1 =3D> "0000000000000000000000000000000000000000"=
;
+Readonly my $NULL_SHA1 =3D> "0000000000000000000000000000000000000000"=
;
=20
 # Used on Git's side to reflect empty edit messages on the wiki
-use constant EMPTY_MESSAGE =3D> '*Empty MediaWiki Message*';
+Readonly my $EMPTY_MESSAGE =3D> '*Empty MediaWiki Message*';
=20
 if (@ARGV !=3D 2) {
 	exit_error_usage();
@@ -538,7 +538,7 @@ sub mediawiki_clean {
 	$string =3D~ s/\s+$//;
 	if ($string eq "" && $page_created) {
 		# Creating empty pages is forbidden.
-		$string =3D EMPTY_CONTENT;
+		$string =3D $EMPTY_CONTENT;
 	}
 	return $string."\n";
 }
@@ -546,7 +546,7 @@ sub mediawiki_clean {
 # Filter applied on MediaWiki data before adding them to Git
 sub mediawiki_smudge {
 	my $string =3D shift;
-	if ($string eq EMPTY_CONTENT) {
+	if ($string eq $EMPTY_CONTENT) {
 		$string =3D "";
 	}
 	# This \n is important. This is due to mediawiki's way to handle end =
of files.
@@ -707,7 +707,7 @@ sub import_file_revision {
 	if (!$full_import && $n =3D=3D 1) {
 		print STDOUT "from refs/mediawiki/$remotename/master^0\n";
 	}
-	if ($content ne DELETED_CONTENT) {
+	if ($content ne $DELETED_CONTENT) {
 		print STDOUT "M 644 inline " .
 		    fe_escape_path($title . ".mw") . "\n";
 		literal_data($content);
@@ -888,7 +888,7 @@ sub mw_import_revids {
=20
 		my %commit;
 		$commit{author} =3D $rev->{user} || 'Anonymous';
-		$commit{comment} =3D $rev->{comment} || EMPTY_MESSAGE;
+		$commit{comment} =3D $rev->{comment} || $EMPTY_MESSAGE;
 		$commit{title} =3D mediawiki_smudge_filename($page_title);
 		$commit{mw_revision} =3D $rev->{revid};
 		$commit{content} =3D mediawiki_smudge($rev->{'*'});
@@ -1006,14 +1006,14 @@ sub mw_push_file {
 	my $oldrevid =3D shift;
 	my $newrevid;
=20
-	if ($summary eq EMPTY_MESSAGE) {
+	if ($summary eq $EMPTY_MESSAGE) {
 		$summary =3D '';
 	}
=20
 	my $new_sha1 =3D $diff_info_split[3];
 	my $old_sha1 =3D $diff_info_split[2];
-	my $page_created =3D ($old_sha1 eq NULL_SHA1);
-	my $page_deleted =3D ($new_sha1 eq NULL_SHA1);
+	my $page_created =3D ($old_sha1 eq $NULL_SHA1);
+	my $page_deleted =3D ($new_sha1 eq $NULL_SHA1);
 	$complete_file_name =3D mediawiki_clean_filename($complete_file_name)=
;
=20
 	my ($title, $extension) =3D $complete_file_name =3D~ /^(.*)\.([^\.]*)=
$/;
@@ -1032,7 +1032,7 @@ sub mw_push_file {
 			# special privileges. A common
 			# convention is to replace the page
 			# with this content instead:
-			$file_content =3D DELETED_CONTENT;
+			$file_content =3D $DELETED_CONTENT;
 		} else {
 			$file_content =3D run_git("cat-file blob $new_sha1");
 		}
--=20
1.7.9.5
