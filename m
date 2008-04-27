From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [updated PATCH] Fix whitespace
Date: Sun, 27 Apr 2008 19:32:46 +0200
Message-ID: <20080427173246.10023.83500.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 19:33:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqAkx-0005Ea-1V
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 19:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757068AbYD0Rcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 13:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757210AbYD0Rcy
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 13:32:54 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:43458 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894AbYD0Rcv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 13:32:51 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 767B45461; Sun, 27 Apr 2008 19:32:46 +0200 (CEST)
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80462>

git-cvsimport uses real tabs whenever possible, a few cases had real
spaces instead of tabs, fixed.

Signed-off-by: Stephen R. van den Berg <srb@cuci.nl>
---

 git-cvsimport.perl |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)


diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 73109d6..4af60b8 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -36,7 +36,7 @@ sub usage(;$) {
 	my $msg = shift;
 	print(STDERR "Error: $msg\n") if $msg;
 	print STDERR <<END;
-Usage: ${\basename $0}     # fetch/update GIT from CVS
+Usage: ${\basename $0}	   # fetch/update GIT from CVS
        [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT] [-A author-conv-file]
        [-p opts-for-cvsps] [-P file] [-C GIT_repository] [-z fuzz] [-i] [-k]
        [-u] [-s subst] [-a] [-m] [-M regex] [-S regex] [-L commitlimit]
@@ -99,13 +99,13 @@ sub read_repo_config {
 		my $arg = 'git config';
 		$arg .= ' --bool' if ($o !~ /:$/);
 
-        chomp(my $tmp = `$arg --get cvsimport.$key`);
+	chomp(my $tmp = `$arg --get cvsimport.$key`);
 		if ($tmp && !($arg =~ /--bool/ && $tmp eq 'false')) {
-            no strict 'refs';
-            my $opt_name = "opt_" . $key;
-            if (!$$opt_name) {
-                $$opt_name = $tmp;
-            }
+	    no strict 'refs';
+	    my $opt_name = "opt_" . $key;
+	    if (!$$opt_name) {
+		$$opt_name = $tmp;
+	    }
 		}
 	}
 }
@@ -264,8 +264,8 @@ sub conn {
 			$s = IO::Socket::INET->new(PeerHost => $proxyhost, PeerPort => $proxyport);
 			die "Socket to $proxyhost: $!\n" unless defined $s;
 			$s->write("CONNECT $serv:$port HTTP/1.1\r\nHost: $serv:$port\r\n\r\n")
-	                        or die "Write to $proxyhost: $!\n";
-	                $s->flush();
+				or die "Write to $proxyhost: $!\n";
+			$s->flush();
 
 			$rep = <$s>;
 
@@ -591,11 +591,11 @@ unless (-d $git_dir) {
 		$branch_date{$head} = $1;
 	}
 	close(H);
-        if (!exists $branch_date{$opt_o}) {
+	if (!exists $branch_date{$opt_o}) {
 		die "Branch '$opt_o' does not exist.\n".
 		       "Either use the correct '-o branch' option,\n".
 		       "or import to a new repository.\n";
-        }
+	}
 }
 
 -d $git_dir
@@ -624,7 +624,7 @@ unless ($opt_P) {
 		my @opt;
 		@opt = split(/,/,$opt_p) if defined $opt_p;
 		unshift @opt, '-z', $opt_z if defined $opt_z;
-		unshift @opt, '-q'         unless defined $opt_v;
+		unshift @opt, '-q'	   unless defined $opt_v;
 		unless (defined($opt_p) && $opt_p =~ m/--no-cvs-direct/) {
 			push @opt, '--cvs-direct';
 		}
@@ -718,7 +718,7 @@ sub commit {
 		die "read-tree failed: $?\n" if $?;
 	    }
 	}
-        $ENV{GIT_INDEX_FILE} = $index{$branch};
+	$ENV{GIT_INDEX_FILE} = $index{$branch};
 
 	update_index(@old, @new);
 	@old = @new = ();
@@ -776,7 +776,7 @@ sub commit {
 		or die "Cannot write branch $branch for update: $!\n";
 
 	if ($tag) {
-	        my ($xtag) = $tag;
+		my ($xtag) = $tag;
 		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
 		$xtag =~ tr/_/\./ if ( $opt_u );
 		$xtag =~ s/[\/]/$opt_s/g;
