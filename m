From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v6 04/31] git-remote-mediawiki: Always end a subroutine with a return
Date: Fri, 14 Jun 2013 15:50:12 +0200
Message-ID: <1371217839-23017-5-git-send-email-celestin.matte@ensimag.fr>
References: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 14 15:51:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnUP8-00014e-Ag
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914Ab3FNNu6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 09:50:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33242 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752867Ab3FNNu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:50:56 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5EDorLi011131
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Jun 2013 15:50:53 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5EDosS0013328;
	Fri, 14 Jun 2013 15:50:54 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5EDoqfu016142;
	Fri, 14 Jun 2013 15:50:54 +0200
X-Mailer: git-send-email 1.8.3.1.491.g8a51f1c
In-Reply-To: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 14 Jun 2013 15:50:53 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227835>

=46rom: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>

=46ollow Subroutines::RequireFinalReturn

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 57f2238..aaaf759 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -187,6 +187,7 @@ sub mw_connect_maybe {
 			exit 1;
 		}
 	}
+	return;
 }
=20
 sub fatal_mw_error {
@@ -209,6 +210,7 @@ sub fatal_mw_error {
 sub get_mw_tracked_pages {
 	my $pages =3D shift;
 	get_mw_page_list(\@tracked_pages, $pages);
+	return;
 }
=20
 sub get_mw_page_list {
@@ -224,6 +226,7 @@ sub get_mw_page_list {
 		get_mw_first_pages(\@slice, $pages);
 		@some_pages =3D @some_pages[51..$#some_pages];
 	}
+	return;
 }
=20
 sub get_mw_tracked_categories {
@@ -246,6 +249,7 @@ sub get_mw_tracked_categories {
 			$pages->{$page->{title}} =3D $page;
 		}
 	}
+	return;
 }
=20
 sub get_mw_all_pages {
@@ -262,6 +266,7 @@ sub get_mw_all_pages {
 	foreach my $page (@{$mw_pages}) {
 		$pages->{$page->{title}} =3D $page;
 	}
+	return;
 }
=20
 # queries the wiki for a set of pages. Meant to be used within a loop
@@ -289,6 +294,7 @@ sub get_mw_first_pages {
 			$pages->{$page->{title}} =3D $page;
 		}
 	}
+	return;
 }
=20
 # Get the list of pages to be fetched according to configuration.
@@ -357,6 +363,7 @@ sub get_all_mediafiles {
 	foreach my $page (@{$mw_pages}) {
 		$pages->{$page->{title}} =3D $page;
 	}
+	return;
 }
=20
 sub get_linked_mediafiles {
@@ -403,6 +410,7 @@ sub get_linked_mediafiles {
=20
 		@titles =3D @titles[($batch+1)..$#titles];
 	}
+	return;
 }
=20
 sub get_mw_mediafile_for_page_revision {
@@ -578,6 +586,7 @@ sub mediawiki_smudge_filename {
 sub literal_data {
 	my ($content) =3D @_;
 	print STDOUT "data ", bytes::length($content), "\n", $content;
+	return;
 }
=20
 sub literal_data_raw {
@@ -588,6 +597,7 @@ sub literal_data_raw {
 	binmode STDOUT, ":raw";
 	print STDOUT "data ", bytes::length($content), "\n", $content;
 	binmode STDOUT, ":encoding(UTF-8)";
+	return;
 }
=20
 sub mw_capabilities {
@@ -599,6 +609,7 @@ sub mw_capabilities {
 	print STDOUT "list\n";
 	print STDOUT "push\n";
 	print STDOUT "\n";
+	return;
 }
=20
 sub mw_list {
@@ -607,11 +618,13 @@ sub mw_list {
 	print STDOUT "? refs/heads/master\n";
 	print STDOUT "\@refs/heads/master HEAD\n";
 	print STDOUT "\n";
+	return;
 }
=20
 sub mw_option {
 	print STDERR "remote-helper command 'option $_[0]' not yet implemente=
d\n";
 	print STDOUT "unsupported\n";
+	return;
 }
=20
 sub fetch_mw_revisions_for_page {
@@ -733,6 +746,7 @@ sub import_file_revision {
 	print STDOUT "N inline :$n\n";
 	literal_data("mediawiki_revision: " . $commit{mw_revision});
 	print STDOUT "\n\n";
+	return;
 }
=20
 # parse a sequence of
@@ -753,6 +767,7 @@ sub get_more_refs {
 			die("Invalid command in a '$cmd' batch: ". $_);
 		}
 	}
+	return;
 }
=20
 sub mw_import {
@@ -762,6 +777,7 @@ sub mw_import {
 		mw_import_ref($ref);
 	}
 	print STDOUT "done\n";
+	return;
 }
=20
 sub mw_import_ref {
@@ -805,6 +821,7 @@ sub mw_import_ref {
 		# thrown saying that HEAD is referring to unknown object 00000000000=
00000000
 		# and the clone fails.
 	}
+	return;
 }
=20
 sub mw_import_ref_by_pages {
@@ -1111,6 +1128,7 @@ sub mw_push {
 		print STDERR "  git pull --rebase\n";
 		print STDERR "\n";
 	}
+	return;
 }
=20
 sub mw_push_revision {
--=20
1.8.3.rc3.49.g4e74807
