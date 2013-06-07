From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v2 16/22] git-remote-mediawiki: Modify strings for a better coding-style
Date: Fri,  7 Jun 2013 23:42:17 +0200
Message-ID: <1370641344-4253-17-git-send-email-celestin.matte@ensimag.fr>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 23:43:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4Rl-0008Pr-Rs
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 23:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756810Ab3FGVnb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 17:43:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55311 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756553Ab3FGVnX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 17:43:23 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r57Lh9vQ003303
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 23:43:09 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r57LhCif029620;
	Fri, 7 Jun 2013 23:43:12 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r57LgqRr019409;
	Fri, 7 Jun 2013 23:43:11 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 07 Jun 2013 23:43:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r57Lh9vQ003303
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371246193.00105@TGM9tuRyHTl/5zvzfzFM1g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226730>

- strings which don't need interpolation are single-quoted for more cla=
rity and
slight gain of performance
- interpolation is preferred over concatenation in many cases, for more=
 clarity
- variables are always used with the ${} operator inside strings
- strings including double-quotes are written with qq() so that the quo=
tes do
not have to be escaped

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>

Conflicts:

	contrib/mw-to-git/git-remote-mediawiki.perl
---
 contrib/mw-to-git/git-remote-mediawiki.perl |  244 +++++++++++++------=
--------
 1 file changed, 121 insertions(+), 123 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index f37488b..2d4ea1d 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -18,14 +18,14 @@ use DateTime::Format::ISO8601;
 use warnings;
=20
 # By default, use UTF-8 to communicate with Git and the user
-binmode STDERR, ":encoding(UTF-8)";
-binmode STDOUT, ":encoding(UTF-8)";
+binmode STDERR, ':encoding(UTF-8)';
+binmode STDOUT, ':encoding(UTF-8)';
=20
 use URI::Escape;
 use Readonly;
=20
 # Mediawiki filenames can contain forward slashes. This variable decid=
es by which pattern they should be replaced
-Readonly my $SLASH_REPLACEMENT =3D> "%2F";
+Readonly my $SLASH_REPLACEMENT =3D> '%2F';
=20
 # It's not always possible to delete pages (may require some
 # privileges). Deleted pages are replaced with this content.
@@ -36,7 +36,7 @@ Readonly my $DELETED_CONTENT =3D> "[[Category:Deleted=
]]\n";
 Readonly my $EMPTY_CONTENT =3D> "<!-- empty page -->\n";
=20
 # used to reflect file creation or deletion in diff.
-Readonly my $NULL_SHA1 =3D> "0000000000000000000000000000000000000000"=
;
+Readonly my $NULL_SHA1 =3D> '0000000000000000000000000000000000000000'=
;
=20
 # Used on Git's side to reflect empty edit messages on the wiki
 Readonly my $EMPTY_MESSAGE =3D> '*Empty MediaWiki Message*';
@@ -50,35 +50,35 @@ my $url =3D $ARGV[1];
=20
 # Accept both space-separated and multiple keys in config file.
 # Spaces should be written as _ anyway because we'll use chomp.
-my @tracked_pages =3D split(/[ \n]/, run_git("config --get-all remote.=
". $remotename .".pages"));
+my @tracked_pages =3D split(/[ \n]/, run_git("config --get-all remote.=
${remotename}.pages"));
 chomp(@tracked_pages);
=20
 # Just like @tracked_pages, but for MediaWiki categories.
-my @tracked_categories =3D split(/[ \n]/, run_git("config --get-all re=
mote.". $remotename .".categories"));
+my @tracked_categories =3D split(/[ \n]/, run_git("config --get-all re=
mote.${remotename}.categories"));
 chomp(@tracked_categories);
=20
 # Import media files on pull
-my $import_media =3D run_git("config --get --bool remote.". $remotenam=
e .".mediaimport");
+my $import_media =3D run_git("config --get --bool remote.${remotename}=
=2Emediaimport");
 chomp($import_media);
-$import_media =3D ($import_media eq "true");
+$import_media =3D ($import_media eq 'true');
=20
 # Export media files on push
-my $export_media =3D run_git("config --get --bool remote.". $remotenam=
e .".mediaexport");
+my $export_media =3D run_git("config --get --bool remote.${remotename}=
=2Emediaexport");
 chomp($export_media);
-$export_media =3D !($export_media eq "false");
+$export_media =3D !($export_media eq 'false');
=20
-my $wiki_login =3D run_git("config --get remote.". $remotename .".mwLo=
gin");
+my $wiki_login =3D run_git("config --get remote.${remotename}.mwLogin"=
);
 # Note: mwPassword is discourraged. Use the credential system instead.
-my $wiki_passwd =3D run_git("config --get remote.". $remotename .".mwP=
assword");
-my $wiki_domain =3D run_git("config --get remote.". $remotename .".mwD=
omain");
+my $wiki_passwd =3D run_git("config --get remote.${remotename}.mwPassw=
ord");
+my $wiki_domain =3D run_git("config --get remote.${remotename}.mwDomai=
n");
 chomp($wiki_login);
 chomp($wiki_passwd);
 chomp($wiki_domain);
=20
 # Import only last revisions (both for clone and fetch)
-my $shallow_import =3D run_git("config --get --bool remote.". $remoten=
ame .".shallow");
+my $shallow_import =3D run_git("config --get --bool remote.${remotenam=
e}.shallow");
 chomp($shallow_import);
-$shallow_import =3D ($shallow_import eq "true");
+$shallow_import =3D ($shallow_import eq 'true');
=20
 # Fetch (clone and pull) by revisions instead of by pages. This behavi=
or
 # is more efficient when we have a wiki with lots of pages and we fetc=
h
@@ -86,13 +86,13 @@ $shallow_import =3D ($shallow_import eq "true");
 # Possible values:
 # - by_rev: perform one query per new revision on the remote wiki
 # - by_page: query each tracked page for new revision
-my $fetch_strategy =3D run_git("config --get remote.$remotename.fetchS=
trategy");
+my $fetch_strategy =3D run_git("config --get remote.${remotename}.fetc=
hStrategy");
 unless ($fetch_strategy) {
-	$fetch_strategy =3D run_git("config --get mediawiki.fetchStrategy");
+	$fetch_strategy =3D run_git('config --get mediawiki.fetchStrategy');
 }
 chomp($fetch_strategy);
 unless ($fetch_strategy) {
-	$fetch_strategy =3D "by_page";
+	$fetch_strategy =3D 'by_page';
 }
=20
 # Remember the timestamp corresponding to a revision id.
@@ -112,12 +112,12 @@ my %basetimestamps;
 # will get the history with information lost). If the import is
 # deterministic, this means everybody gets the same sha1 for each
 # MediaWiki revision.
-my $dumb_push =3D run_git("config --get --bool remote.$remotename.dumb=
Push");
+my $dumb_push =3D run_git("config --get --bool remote.${remotename}.du=
mbPush");
 unless ($dumb_push) {
-	$dumb_push =3D run_git("config --get --bool mediawiki.dumbPush");
+	$dumb_push =3D run_git('config --get --bool mediawiki.dumbPush');
 }
 chomp($dumb_push);
-$dumb_push =3D ($dumb_push eq "true");
+$dumb_push =3D ($dumb_push eq 'true');
=20
 my $wiki_name =3D $url;
 $wiki_name =3D~ s{[^/]*://}{};
@@ -154,22 +154,22 @@ sub exit_error_usage {
 }
=20
 sub parse_commands {
-	if ($cmd[0] eq "capabilities") {
+	if ($cmd[0] eq 'capabilities') {
 		die("Too many arguments for capabilities\n")
 		    if (defined($cmd[1]));
 		mw_capabilities();
-	} elsif ($cmd[0] eq "list") {
+	} elsif ($cmd[0] eq 'list') {
 		die("Too many arguments for list\n") if (defined($cmd[2]));
 		mw_list($cmd[1]);
-	} elsif ($cmd[0] eq "import") {
+	} elsif ($cmd[0] eq 'import') {
 		die("Invalid arguments for import\n")
 		    if ($cmd[1] eq "" || defined($cmd[2]));
 		mw_import($cmd[1]);
-	} elsif ($cmd[0] eq "option") {
+	} elsif ($cmd[0] eq 'option') {
 		die("Too many arguments for option\n")
 		    if ($cmd[1] eq "" || $cmd[2] eq "" || defined($cmd[3]));
 		mw_option($cmd[1],$cmd[2]);
-	} elsif ($cmd[0] eq "push") {
+	} elsif ($cmd[0] eq 'push') {
 		mw_push($cmd[1]);
 	} else {
 		print STDERR "Unknown command. Aborting...\n";
@@ -186,7 +186,7 @@ sub mw_connect_maybe {
 		return;
 	}
 	$mediawiki =3D MediaWiki::API->new;
-	$mediawiki->{config}->{api_url} =3D "$url/api.php";
+	$mediawiki->{config}->{api_url} =3D "${url}/api.php";
 	if ($wiki_login) {
 		my %credential =3D (
 			'url' =3D> $url,
@@ -199,10 +199,10 @@ sub mw_connect_maybe {
 			       lgdomain =3D> $wiki_domain};
 		if ($mediawiki->login($request)) {
 			Git::credential \%credential, 'approve';
-			print STDERR "Logged in mediawiki user \"$credential{username}\".\n=
";
+			print STDERR qq(Logged in mediawiki user "$credential{username}".\n=
);
 		} else {
-			print STDERR "Failed to log in mediawiki user \"$credential{usernam=
e}\" on $url\n";
-			print STDERR "  (error " .
+			print {*STDERR} qq(Failed to log in mediawiki user "$credential{use=
rname}" on ${url}\n);
+			print {*STDERR} '  (error ' .
 				$mediawiki->{error}->{code} . ': ' .
 				$mediawiki->{error}->{details} . ")\n";
 			Git::credential \%credential, 'reject';
@@ -242,7 +242,7 @@ sub get_mw_tracked_categories {
 			# Mediawiki requires the Category
 			# prefix, but let's not force the user
 			# to specify it.
-			$category =3D "Category:" . $category;
+			$category =3D "Category:${category}";
 		}
 		my $mw_pages =3D $mediawiki->list( {
 			action =3D> 'query',
@@ -268,8 +268,8 @@ sub get_mw_all_pages {
 	});
 	if (!defined($mw_pages)) {
 		print STDERR "fatal: could not get the list of wiki pages.\n";
-		print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
-		print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
+		print STDERR "fatal: '${url}' does not appear to be a mediawiki\n";
+		print STDERR "fatal: make sure '${url}/api.php' is a valid page.\n";
 		exit 1;
 	}
 	foreach my $page (@{$mw_pages}) {
@@ -295,8 +295,8 @@ sub get_mw_first_pages {
 	});
 	if (!defined($mw_pages)) {
 		print STDERR "fatal: could not query the list of wiki pages.\n";
-		print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
-		print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
+		print STDERR "fatal: '${url}' does not appear to be a mediawiki\n";
+		print STDERR "fatal: make sure '${url}/api.php' is a valid page.\n";
 		exit 1;
 	}
 	while (my ($id, $page) =3D each(%{$mw_pages->{query}->{pages}})) {
@@ -346,10 +346,10 @@ sub get_mw_pages {
 #        $out =3D run_git("command args", "raw"); # don't interpret ou=
tput as UTF-8.
 sub run_git {
 	my $args =3D shift;
-	my $encoding =3D (shift || "encoding(UTF-8)");
-	open(my $git, "-|:$encoding", "git " . $args)
-	    or die "Unable to open: $!\n";
-	my $res =3D do {=20
+	my $encoding =3D (shift || 'encoding(UTF-8)');
+	open(my $git, "-|:${encoding}", "git ${args}")
+	    or die "Unable to fork: $!\n";
+	my $res =3D do {
 		local $/ =3D undef;
 		<$git>
 	};
@@ -367,7 +367,7 @@ sub get_all_mediafiles {
 	my $mw_pages =3D $mediawiki->list({
 		action =3D> 'query',
 		list =3D> 'allpages',
-		apnamespace =3D> get_mw_namespace_id("File"),
+		apnamespace =3D> get_mw_namespace_id('File'),
 		aplimit =3D> 'max'
 	});
 	if (!defined($mw_pages)) {
@@ -404,7 +404,7 @@ sub get_linked_mediafiles {
 			action =3D> 'query',
 			prop =3D> 'links|images',
 			titles =3D> $mw_titles,
-			plnamespace =3D> get_mw_namespace_id("File"),
+			plnamespace =3D> get_mw_namespace_id('File'),
 			pllimit =3D> 'max'
 		};
 		my $result =3D $mediawiki->api($query);
@@ -442,7 +442,7 @@ sub get_mw_mediafile_for_page_revision {
 	my $query =3D {
 		action =3D> 'query',
 		prop =3D> 'imageinfo',
-		titles =3D> "File:" . $filename,
+		titles =3D> "File:${filename}",
 		iistart =3D> $timestamp,
 		iiend =3D> $timestamp,
 		iiprop =3D> 'timestamp|archivename|url',
@@ -473,27 +473,27 @@ sub download_mw_mediafile {
 	if ($response->code =3D=3D 200) {
 		return $response->decoded_content;
 	} else {
-		print STDERR "Error downloading mediafile from :\n";
-		print STDERR "URL: $download_url\n";
-		print STDERR "Server response: " . $response->code . " " . $response=
->message . "\n";
+		print {*STDERR} "Error downloading mediafile from :\n";
+		print {*STDERR} "URL: ${download_url}\n";
+		print {*STDERR} 'Server response: ' . $response->code . q{ } . $resp=
onse->message . "\n";
 		exit 1;
 	}
 }
=20
 sub get_last_local_revision {
 	# Get note regarding last mediawiki revision
-	my $note =3D run_git("notes --ref=3D$remotename/mediawiki show refs/m=
ediawiki/$remotename/master 2>/dev/null");
+	my $note =3D run_git("notes --ref=3D${remotename}/mediawiki show refs=
/mediawiki/${remotename}/master 2>/dev/null");
 	my @note_info =3D split(/ /, $note);
=20
 	my $lastrevision_number;
-	if (!(defined($note_info[0]) && $note_info[0] eq "mediawiki_revision:=
")) {
-		print STDERR "No previous mediawiki revision found";
+	if (!(defined($note_info[0]) && $note_info[0] eq 'mediawiki_revision:=
')) {
+		print STDERR 'No previous mediawiki revision found';
 		$lastrevision_number =3D 0;
 	} else {
 		# Notes are formatted : mediawiki_revision: #number
 		$lastrevision_number =3D $note_info[1];
 		chomp($lastrevision_number);
-		print STDERR "Last local mediawiki revision found is $lastrevision_n=
umber";
+		print STDERR "Last local mediawiki revision found is ${lastrevision_=
number}";
 	}
 	return $lastrevision_number;
 }
@@ -572,7 +572,7 @@ sub mediawiki_smudge {
 		$string =3D "";
 	}
 	# This \n is important. This is due to mediawiki's way to handle end =
of files.
-	return $string."\n";
+	return "${string}\n";
 }
=20
 sub mediawiki_clean_filename {
@@ -594,13 +594,13 @@ sub mediawiki_smudge_filename {
 	$filename =3D~ s{/}{$SLASH_REPLACEMENT}g;
 	$filename =3D~ s/ /_/g;
 	# Decode forbidden characters encoded in mediawiki_clean_filename
-	$filename =3D~ s/_%_([0-9a-fA-F][0-9a-fA-F])/sprintf("%c", hex($1))/g=
e;
+	$filename =3D~ s/_%_([0-9a-fA-F][0-9a-fA-F])/sprintf('%c', hex($1))/g=
e;
 	return $filename;
 }
=20
 sub literal_data {
 	my ($content) =3D @_;
-	print STDOUT "data ", bytes::length($content), "\n", $content;
+	print STDOUT 'data ', bytes::length($content), "\n", $content;
 	return;
 }
=20
@@ -619,7 +619,7 @@ sub mw_capabilities {
 	# Revisions are imported to the private namespace
 	# refs/mediawiki/$remotename/ by the helper and fetched into
 	# refs/remotes/$remotename later by fetch.
-	print STDOUT "refspec refs/heads/*:refs/mediawiki/$remotename/*\n";
+	print STDOUT "refspec refs/heads/*:refs/mediawiki/${remotename}/*\n";
 	print STDOUT "import\n";
 	print STDOUT "list\n";
 	print STDOUT "push\n";
@@ -678,7 +678,7 @@ sub fetch_mw_revisions_for_page {
 		@page_revs =3D sort {$b->{revid} <=3D> $a->{revid}} (@page_revs);
 		return $page_revs[0];
 	}
-	print STDERR "  Found ", $revnum, " revision(s).\n";
+	print STDERR "  Found ${revnum} revision(s).\n";
 	return @page_revs;
 }
=20
@@ -690,8 +690,7 @@ sub fetch_mw_revisions {
 	my $n =3D 1;
 	foreach my $page (@pages) {
 		my $id =3D $page->{pageid};
-
-		print STDERR "page $n/", scalar(@pages), ": ". $page->{title} ."\n";
+		print {*STDERR} "page ${n}/", scalar(@pages), ': ', $page->{title}, =
"\n";
 		$n++;
 		my @page_revs =3D fetch_mw_revisions_for_page($page, $id, $fetch_fro=
m);
 		@revisions =3D (@page_revs, @revisions);
@@ -705,7 +704,7 @@ sub fe_escape_path {
     $path =3D~ s/\\/\\\\/g;
     $path =3D~ s/"/\\"/g;
     $path =3D~ s/\n/\\n/g;
-    return '"' . $path . '"';
+    return qq("${path}");
 }
=20
 sub import_file_revision {
@@ -725,41 +724,41 @@ sub import_file_revision {
 	my $author =3D $commit{author};
 	my $date =3D $commit{date};
=20
-	print STDOUT "commit refs/mediawiki/$remotename/master\n";
-	print STDOUT "mark :$n\n";
-	print STDOUT "committer $author <$author\@$wiki_name> ", $date->epoch=
, " +0000\n";
+	print STDOUT "commit refs/mediawiki/${remotename}/master\n";
+	print STDOUT "mark :${n}\n";
+	print STDOUT "committer ${author} <${author}\@${wiki_name}> " . $date=
->epoch . " +0000\n";
 	literal_data($comment);
=20
 	# If it's not a clone, we need to know where to start from
 	if (!$full_import && $n =3D=3D 1) {
-		print STDOUT "from refs/mediawiki/$remotename/master^0\n";
+		print STDOUT "from refs/mediawiki/${remotename}/master^0\n";
 	}
 	if ($content ne $DELETED_CONTENT) {
-		print STDOUT "M 644 inline " .
-		    fe_escape_path($title . ".mw") . "\n";
+		print {*STDOUT} 'M 644 inline ' .
+		    fe_escape_path("${title}.mw") . "\n";
 		literal_data($content);
 		if (%mediafile) {
-			print STDOUT "M 644 inline "
+			print STDOUT 'M 644 inline '
 			    . fe_escape_path($mediafile{title}) . "\n";
 			literal_data_raw($mediafile{content});
 		}
 		print STDOUT "\n\n";
 	} else {
-		print STDOUT "D " . fe_escape_path($title . ".mw") . "\n";
+		print STDOUT 'D ' . fe_escape_path("${title}.mw") . "\n";
 	}
=20
 	# mediawiki revision number in the git note
 	if ($full_import && $n =3D=3D 1) {
-		print STDOUT "reset refs/notes/$remotename/mediawiki\n";
+		print STDOUT "reset refs/notes/${remotename}/mediawiki\n";
 	}
-	print STDOUT "commit refs/notes/$remotename/mediawiki\n";
-	print STDOUT "committer $author <$author\@$wiki_name> ", $date->epoch=
, " +0000\n";
-	literal_data("Note added by git-mediawiki during import");
+	print STDOUT "commit refs/notes/${remotename}/mediawiki\n";
+	print STDOUT "committer ${author} <${author}\@${wiki_name}> " . $date=
->epoch . " +0000\n";
+	literal_data('Note added by git-mediawiki during import');
 	if (!$full_import && $n =3D=3D 1) {
-		print STDOUT "from refs/notes/$remotename/mediawiki^0\n";
+		print STDOUT "from refs/notes/${remotename}/mediawiki^0\n";
 	}
-	print STDOUT "N inline :$n\n";
-	literal_data("mediawiki_revision: " . $commit{mw_revision});
+	print STDOUT "N inline :${n}\n";
+	literal_data("mediawiki_revision: $commit{mw_revision}");
 	print STDOUT "\n\n";
 	return;
 }
@@ -787,7 +786,7 @@ sub get_more_refs {
=20
 sub mw_import {
 	# multiple import commands can follow each other.
-	my @refs =3D (shift, get_more_refs("import"));
+	my @refs =3D (shift, get_more_refs('import'));
 	foreach my $ref (@refs) {
 		mw_import_ref($ref);
 	}
@@ -802,7 +801,7 @@ sub mw_import_ref {
 	# Since HEAD is a symbolic ref to master (by convention,
 	# followed by the output of the command "list" that we gave),
 	# we don't need to do anything in this case.
-	if ($ref eq "HEAD") {
+	if ($ref eq 'HEAD') {
 		return;
 	}
=20
@@ -818,15 +817,15 @@ sub mw_import_ref {
 	}
=20
 	my $n =3D 0;
-	if ($fetch_strategy eq "by_rev") {
+	if ($fetch_strategy eq 'by_rev') {
 		print STDERR "Fetching & writing export data by revs...\n";
 		$n =3D mw_import_ref_by_revs($fetch_from);
-	} elsif ($fetch_strategy eq "by_page") {
+	} elsif ($fetch_strategy eq 'by_page') {
 		print STDERR "Fetching & writing export data by pages...\n";
 		$n =3D mw_import_ref_by_pages($fetch_from);
 	} else {
-		print STDERR "fatal: invalid fetch strategy \"$fetch_strategy\".\n";
-		print STDERR "Check your configuration variables remote.$remotename.=
fetchStrategy and mediawiki.fetchStrategy\n";
+		print STDERR qq(fatal: invalid fetch strategy "${fetch_strategy}".\n=
);
+		print STDERR "Check your configuration variables remote.${remotename=
}.fetchStrategy and mediawiki.fetchStrategy\n";
 		exit 1;
 	}
=20
@@ -900,7 +899,7 @@ sub mw_import_revids {
 		}
=20
 		if (!defined($result->{query}->{pages})) {
-			die "Invalid revision $pagerevid.\n";
+			die "Invalid revision ${pagerevid}.\n";
 		}
=20
 		my @result_pages =3D values(%{$result->{query}->{pages}});
@@ -910,8 +909,8 @@ sub mw_import_revids {
 		my $page_title =3D $result_page->{title};
=20
 		if (!exists($pages->{$page_title})) {
-			print STDERR "$n/", scalar(@$revision_ids),
-				": Skipping revision #$rev->{revid} of $page_title\n";
+			print STDERR "${n}/", scalar(@$revision_ids),
+				": Skipping revision #$rev->{revid} of ${page_title}\n";
 			next;
 		}
=20
@@ -936,14 +935,14 @@ sub mw_import_revids {
 		my %mediafile;
 		if ($namespace) {
 			my $id =3D get_mw_namespace_id($namespace);
-			if ($id && $id =3D=3D get_mw_namespace_id("File")) {
+			if ($id && $id =3D=3D get_mw_namespace_id('File')) {
 				%mediafile =3D get_mw_mediafile_for_page_revision($filename, $rev-=
>{timestamp});
 			}
 		}
 		# If this is a revision of the media page for new version
 		# of a file do one common commit for both file and media page.
 		# Else do commit only for that page.
-		print STDERR "$n/", scalar(@$revision_ids), ": Revision #$rev->{revi=
d} of $commit{title}\n";
+		print STDERR "${n}/", scalar(@$revision_ids), ": Revision #$rev->{re=
vid} of $commit{title}\n";
 		import_file_revision(\%commit, ($fetch_from =3D=3D 1), $n_actual, \%=
mediafile);
 	}
=20
@@ -951,9 +950,9 @@ sub mw_import_revids {
 }
=20
 sub error_non_fast_forward {
-	my $advice =3D run_git("config --bool advice.pushNonFastForward");
+	my $advice =3D run_git('config --bool advice.pushNonFastForward');
 	chomp($advice);
-	if ($advice ne "false") {
+	if ($advice ne 'false') {
 		# Native git-push would show this after the summary.
 		# We can't ask it to display it cleanly, so print it
 		# ourselves before.
@@ -961,7 +960,7 @@ sub error_non_fast_forward {
 		print STDERR "Merge the remote changes (e.g. 'git pull') before push=
ing again. See the\n";
 		print STDERR "'Note about fast-forwards' section of 'git push --help=
' for details.\n";
 	}
-	print STDOUT "error $_[0] \"non-fast-forward\"\n";
+	print STDOUT qq(error $_[0] "non-fast-forward"\n);
 	return 0;
 }
=20
@@ -972,10 +971,10 @@ sub mw_upload_file {
 	my $file_deleted =3D shift;
 	my $summary =3D shift;
 	my $newrevid;
-	my $path =3D "File:" . $complete_file_name;
+	my $path =3D "File:${complete_file_name}";
 	my %hashFiles =3D get_allowed_file_extensions();
 	if (!exists($hashFiles{$extension})) {
-		print STDERR "$complete_file_name is not a permitted file on this wi=
ki.\n";
+		print STDERR "${complete_file_name} is not a permitted file on this =
wiki.\n";
 		print STDERR "Check the configuration of file uploads in your mediaw=
iki.\n";
 		return $newrevid;
 	}
@@ -995,11 +994,11 @@ sub mw_upload_file {
 		}
 	} else {
 		# Don't let perl try to interpret file content as UTF-8 =3D> use "ra=
w"
-		my $content =3D run_git("cat-file blob $new_sha1", "raw");
+		my $content =3D run_git("cat-file blob ${new_sha1}", 'raw');
 		if ($content ne "") {
 			mw_connect_maybe();
 			$mediawiki->{config}->{upload_url} =3D
-				"$url/index.php/Special:Upload";
+				"${url}/index.php/Special:Upload";
 			$mediawiki->edit({
 				action =3D> 'upload',
 				filename =3D> $complete_file_name,
@@ -1014,9 +1013,9 @@ sub mw_upload_file {
 				 . $mediawiki->{error}->{details} . "\n";
 			my $last_file_page =3D $mediawiki->get_page({title =3D> $path});
 			$newrevid =3D $last_file_page->{revid};
-			print STDERR "Pushed file: $new_sha1 - $complete_file_name.\n";
+			print STDERR "Pushed file: ${new_sha1} - ${complete_file_name}.\n";
 		} else {
-			print STDERR "Empty file $complete_file_name not pushed.\n";
+			print STDERR "Empty file ${complete_file_name} not pushed.\n";
 		}
 	}
 	return $newrevid;
@@ -1051,11 +1050,11 @@ sub mw_push_file {
 	if (!defined($extension)) {
 		$extension =3D "";
 	}
-	if ($extension eq "mw") {
+	if ($extension eq 'mw') {
 		my $ns =3D get_mw_namespace_id_for_page($complete_file_name);
-		if ($ns && $ns =3D=3D get_mw_namespace_id("File") && (!$export_media=
)) {
-			print STDERR "Ignoring media file related page: $complete_file_name=
\n";
-			return ($oldrevid, "ok");
+		if ($ns && $ns =3D=3D get_mw_namespace_id('File') && (!$export_media=
)) {
+			print STDERR "Ignoring media file related page: ${complete_file_nam=
e}\n";
+			return ($oldrevid, 'ok');
 		}
 		my $file_content;
 		if ($page_deleted) {
@@ -1065,7 +1064,7 @@ sub mw_push_file {
 			# with this content instead:
 			$file_content =3D $DELETED_CONTENT;
 		} else {
-			$file_content =3D run_git("cat-file blob $new_sha1");
+			$file_content =3D run_git("cat-file blob ${new_sha1}");
 		}
=20
 		mw_connect_maybe();
@@ -1086,7 +1085,7 @@ sub mw_push_file {
 				    $mediawiki->{error}->{code} .
 				    ' from mediwiki: ' . $mediawiki->{error}->{details} .
 				    ".\n";
-				return ($oldrevid, "non-fast-forward");
+				return ($oldrevid, 'non-fast-forward');
 			} else {
 				# Other errors. Shouldn't happen =3D> just die()
 				die 'Fatal: Error ' .
@@ -1095,21 +1094,21 @@ sub mw_push_file {
 			}
 		}
 		$newrevid =3D $result->{edit}->{newrevid};
-		print STDERR "Pushed file: $new_sha1 - $title\n";
+		print STDERR "Pushed file: ${new_sha1} - ${title}\n";
 	} elsif ($export_media) {
 		$newrevid =3D mw_upload_file($complete_file_name, $new_sha1,
 					   $extension, $page_deleted,
 					   $summary);
 	} else {
-		print STDERR "Ignoring media file $title\n";
+		print STDERR "Ignoring media file ${title}\n";
 	}
 	$newrevid =3D ($newrevid or $oldrevid);
-	return ($newrevid, "ok");
+	return ($newrevid, 'ok');
 }
=20
 sub mw_push {
 	# multiple push statements can follow each other
-	my @refsspecs =3D (shift, get_more_refs("push"));
+	my @refsspecs =3D (shift, get_more_refs('push'));
 	my $pushed;
 	for my $refspec (@refsspecs) {
 		my ($force, $local, $remote) =3D $refspec =3D~ /^(\+)?([^:]*):([^:]*=
)$/
@@ -1119,12 +1118,12 @@ sub mw_push {
 		}
 		if ($local eq "") {
 			print STDERR "Cannot delete remote branch on a MediaWiki\n";
-			print STDOUT "error $remote cannot delete\n";
+			print STDOUT "error ${remote} cannot delete\n";
 			next;
 		}
-		if ($remote ne "refs/heads/master") {
+		if ($remote ne 'refs/heads/master') {
 			print STDERR "Only push to the branch 'master' is supported on a Me=
diaWiki\n";
-			print STDOUT "error $remote only master allowed\n";
+			print STDOUT "error ${remote} only master allowed\n";
 			next;
 		}
 		if (mw_push_revision($local, $remote)) {
@@ -1155,9 +1154,10 @@ sub mw_push_revision {
 	my $mw_revision =3D $last_remote_revid;
=20
 	# Get sha1 of commit pointed by local HEAD
-	my $HEAD_sha1 =3D run_git("rev-parse $local 2>/dev/null"); chomp($HEA=
D_sha1);
+	my $HEAD_sha1 =3D run_git("rev-parse ${local} 2>/dev/null");
+	chomp($HEAD_sha1);
 	# Get sha1 of commit pointed by remotes/$remotename/master
-	my $remoteorigin_sha1 =3D run_git("rev-parse refs/remotes/$remotename=
/master 2>/dev/null");
+	my $remoteorigin_sha1 =3D run_git("rev-parse refs/remotes/${remotenam=
e}/master 2>/dev/null");
 	chomp($remoteorigin_sha1);
=20
 	if ($last_local_revid > 0 &&
@@ -1177,7 +1177,7 @@ sub mw_push_revision {
 		my $parsed_sha1 =3D $remoteorigin_sha1;
 		# Find a path from last MediaWiki commit to pushed commit
 		print STDERR "Computing path from local to remote ...\n";
-		my @local_ancestry =3D split(/\n/, run_git("rev-list --boundary --pa=
rents $local ^$parsed_sha1"));
+		my @local_ancestry =3D split(/\n/, run_git("rev-list --boundary --pa=
rents ${local} ^${parsed_sha1}"));
 		my %local_ancestry;
 		foreach my $line (@local_ancestry) {
 			if (my ($child, $parents) =3D $line =3D~ /^-?([a-f0-9]+) ([a-f0-9 ]=
+)/) {
@@ -1185,7 +1185,7 @@ sub mw_push_revision {
 					$local_ancestry{$parent} =3D $child;
 				}
 			} elsif (!$line =3D~ /^([a-f0-9]+)/) {
-				die "Unexpected output from git rev-list: $line\n";
+				die "Unexpected output from git rev-list: ${line}\n";
 			}
 		}
 		while ($parsed_sha1 ne $HEAD_sha1) {
@@ -1201,7 +1201,7 @@ sub mw_push_revision {
 		# No remote mediawiki revision. Export the whole
 		# history (linearized with --first-parent)
 		print STDERR "Warning: no common ancestor, pushing complete history\=
n";
-		my $history =3D run_git("rev-list --first-parent --children $local")=
;
+		my $history =3D run_git("rev-list --first-parent --children ${local}=
");
 		my @history =3D split(/\n/, $history);
 		@history =3D @history[1..$#history];
 		foreach my $line (reverse @history) {
@@ -1213,12 +1213,12 @@ sub mw_push_revision {
 	foreach my $commit_info_split (@commit_pairs) {
 		my $sha1_child =3D @{$commit_info_split}[0];
 		my $sha1_commit =3D @{$commit_info_split}[1];
-		my $diff_infos =3D run_git("diff-tree -r --raw -z $sha1_child $sha1_=
commit");
+		my $diff_infos =3D run_git("diff-tree -r --raw -z ${sha1_child} ${sh=
a1_commit}");
 		# TODO: we could detect rename, and encode them with a #redirect on =
the wiki.
 		# TODO: for now, it's just a delete+add
 		my @diff_info_list =3D split(/\0/, $diff_infos);
 		# Keep the subject line of the commit message as mediawiki comment f=
or the revision
-		my $commit_msg =3D run_git("log --no-walk --format=3D\"%s\" $sha1_co=
mmit");
+		my $commit_msg =3D run_git(qq(log --no-walk --format=3D"%s" ${sha1_c=
ommit}));
 		chomp($commit_msg);
 		# Push every blob
 		while (@diff_info_list) {
@@ -1230,7 +1230,7 @@ sub mw_push_revision {
 			my $info =3D shift(@diff_info_list);
 			my $file =3D shift(@diff_info_list);
 			($mw_revision, $status) =3D mw_push_file($info, $file, $commit_msg,=
 $mw_revision);
-			if ($status eq "non-fast-forward") {
+			if ($status eq 'non-fast-forward') {
 				# we may already have sent part of the
 				# commit to MediaWiki, but it's too
 				# late to cancel it. Stop the push in
@@ -1238,17 +1238,17 @@ sub mw_push_revision {
 				# accurate error message.
 				return error_non_fast_forward($remote);
 			}
-			if ($status ne "ok") {
+			if ($status ne 'ok') {
 				die("Unknown error from mw_push_file()\n");
 			}
 		}
 		unless ($dumb_push) {
-			run_git("notes --ref=3D$remotename/mediawiki add -f -m \"mediawiki_=
revision: $mw_revision\" $sha1_commit");
-			run_git("update-ref -m \"Git-MediaWiki push\" refs/mediawiki/$remot=
ename/master $sha1_commit $sha1_child");
+			run_git(qq(notes --ref=3D${remotename}/mediawiki add -f -m "mediawi=
ki_revision: ${mw_revision}" ${sha1_commit}));
+			run_git(qq(update-ref -m "Git-MediaWiki push" refs/mediawiki/${remo=
tename}/master ${sha1_commit} ${sha1_child}));
 		}
 	}
=20
-	print STDOUT "ok $remote\n";
+	print STDOUT "ok ${remote}\n";
 	return 1;
 }
=20
@@ -1284,8 +1284,7 @@ sub get_mw_namespace_id {
 		# Look at configuration file, if the record for that namespace is
 		# already cached. Namespaces are stored in form:
 		# "Name_of_namespace:Id_namespace", ex.: "File:6".
-		my @temp =3D split(/\n/, run_git("config --get-all remote."
-						. $remotename .".namespaceCache"));
+		my @temp =3D split(/\n/, run_git("config --get-all remote.${remotena=
me}.namespaceCache"));
 		chomp(@temp);
 		foreach my $ns (@temp) {
 			my ($n, $id) =3D split(/:/, $ns);
@@ -1299,7 +1298,7 @@ sub get_mw_namespace_id {
 	}
=20
 	if (!exists $namespace_id{$name}) {
-		print STDERR "Namespace $name not found in cache, querying the wiki =
=2E..\n";
+		print STDERR "Namespace ${name} not found in cache, querying the wik=
i ...\n";
 		# NS not found =3D> get namespace id from MW and store it in
 	        # configuration file.
 	        my $query =3D {
@@ -1324,7 +1323,7 @@ sub get_mw_namespace_id {
 	my $id;
=20
 	unless (defined $ns) {
-		print STDERR "No such namespace $name on MediaWiki.\n";
+		print STDERR "No such namespace ${name} on MediaWiki.\n";
 		$ns =3D {is_namespace =3D> 0};
 		$namespace_id{$name} =3D $ns;
 	}
@@ -1338,8 +1337,7 @@ sub get_mw_namespace_id {
=20
 	# Store explicitely requested namespaces on disk
 	if (!exists $cached_mw_namespace_id{$name}) {
-		run_git("config --add remote.". $remotename
-			.".namespaceCache \"". $name .":". $store_id ."\"");
+		run_git(qq(config --add remote.${remotename}.namespaceCache "${name}=
:${store_id}"));
 		$cached_mw_namespace_id{$name} =3D 1;
 	}
 	return $id;
--=20
1.7.9.5
