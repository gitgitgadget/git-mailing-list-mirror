From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [PATCH] Fix whitespace
Date: Thu, 3 Apr 2008 12:07:39 +0200
Message-ID: <20080425234556.D12DF5460@aristoteles.cuci.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 01:47:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpXdF-0004lM-AY
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 01:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762172AbYDYXqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 19:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761770AbYDYXqE
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 19:46:04 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:56104 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760878AbYDYXp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 19:45:58 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id D12DF5460; Sat, 26 Apr 2008 01:45:56 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80358>

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
-- 
1.5.5.1.83.ge77a4.dirty
