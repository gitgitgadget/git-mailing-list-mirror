From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH 4/6] Remove whitespace breakage from perl, tcl and python
 files
Date: Sun, 20 May 2007 12:28:44 +0200
Message-ID: <465022DC.6070900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 12:29:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpiet-000643-Dh
	for gcvg-git@gmane.org; Sun, 20 May 2007 12:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759163AbXETK24 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 06:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759137AbXETK24
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 06:28:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:40027 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757449AbXETK2z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 06:28:55 -0400
Received: by ug-out-1314.google.com with SMTP id 44so893365uga
        for <git@vger.kernel.org>; Sun, 20 May 2007 03:28:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=sGkci86e6vbWUOWTdYdUtIxkuqy5kgqYdJyYcG39p8MDotmh0FDBU0gsTVFy7/l/dxQpBrkRF+i6oGwSQPBMhL+M0p40pioTE2M9qAK2H5UhGyZvAU2YOXa42mqqGjPHUEXL3mMgmsR8OhLeOH6S01kiNQfxjSTQVtGU+xuyox8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=pd/4M9wcFB/j9j5yPM2NrcTN0OKNmEpH5nMdubM7gkrzn0eRzg/Mb2R4MxFg45NG0zdSHBoiBZ4n7izgH9SBpVXVZRzccqzFe0f9Pa/EH5ExN7DuxCZQkGPihBYFWUrILUH6nEeMvc+aO9tcCxthk56SjSMjPpJK8rZZpVJDLaw=
Received: by 10.67.30.6 with SMTP id h6mr2543677ugj.1179656930195;
        Sun, 20 May 2007 03:28:50 -0700 (PDT)
Received: from ?10.0.0.13? ( [151.70.107.76])
        by mx.google.com with ESMTP id 13sm3735937ugb.2007.05.20.03.28.46;
        Sun, 20 May 2007 03:28:48 -0700 (PDT)
User-Agent: Thunderbird 2.0b2 (X11/20070313)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47817>

Using 'git apply --whitespace=strip'

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
  contrib/gitview/gitview  |    2 -
  git-archimport.perl      |  175 +++++++++++++++++++++++-----------------------
  git-cvsexportcommit.perl |    2 +-
  git-cvsimport.perl       |   12 ++--
  git-gui/lib/class.tcl    |    1 -
  git-p4import.py          |    1 -
  git-svnimport.perl       |    4 +-
  gitk                     |    2 +-
  8 files changed, 97 insertions(+), 102 deletions(-)

diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 2d80e2b..3dc1ef5 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -1277,5 +1277,3 @@ if __name__ == "__main__":

  	view = GitView( without_diff != 1)
  	view.run(sys.argv[without_diff:])
-
-
diff --git a/git-archimport.perl b/git-archimport.perl
index c1e7c1d..b210772 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -3,19 +3,19 @@
  # This tool is copyright (c) 2005, Martin Langhoff.
  # It is released under the Gnu Public License, version 2.
  #
-# The basic idea is to walk the output of tla abrowse,
-# fetch the changesets and apply them.
+# The basic idea is to walk the output of tla abrowse,
+# fetch the changesets and apply them.
  #

  =head1 Invocation

-    git-archimport [ -h ] [ -v ] [ -o ] [ -a ] [ -f ] [ -T ]
-    	[ -D depth] [ -t tempdir ] <archive>/<branch> [ <archive>/<branch> ]
+    git-archimport [ -h ] [ -v ] [ -o ] [ -a ] [ -f ] [ -T ]
+	[ -D depth] [ -t tempdir ] <archive>/<branch> [ <archive>/<branch> ]

  Imports a project from one or more Arch repositories. It will follow branches
  and repositories within the namespaces defined by the <archive/branch>
  parameters supplied. If it cannot find the remote branch a merge comes from
-it will just import it as a regular commit. If it can find it, it will mark it
+it will just import it as a regular commit. If it can find it, it will mark it
  as a merge whenever possible.

  See man (1) git-archimport for more details.
@@ -25,14 +25,14 @@ See man (1) git-archimport for more details.
   - create tag objects instead of ref tags
   - audit shell-escaping of filenames
   - hide our private tags somewhere smarter
- - find a way to make "cat *patches | patch" safe even when patchfiles are missing newlines
+ - find a way to make "cat *patches | patch" safe even when patchfiles are missing newlines
   - sort and apply patches by graphing ancestry relations instead of just
     relying in dates supplied in the changeset itself.
     tla ancestry-graph -m could be helpful here...

  =head1 Devel tricks

-Add print in front of the shell commands invoked via backticks.
+Add print in front of the shell commands invoked via backticks.

  =head1 Devel Notes

@@ -126,16 +126,16 @@ sub do_abrowse {
      my $stage = shift;
      while (my ($limit, $level) = each %arch_branches) {
          next unless $level == $stage;
-
-	open ABROWSE, "$TLA abrowse -fkD --merges $limit |"
+
+	open ABROWSE, "$TLA abrowse -fkD --merges $limit |"
                                  or die "Problems with tla abrowse: $!";
-
+
          my %ps        = ();         # the current one
          my $lastseen  = '';
-
+
          while (<ABROWSE>) {
              chomp;
-
+
              # first record padded w 8 spaces
              if (s/^\s{8}\b//) {
                  my ($id, $type) = split(m/\s+/, $_, 2);
@@ -147,13 +147,13 @@ sub do_abrowse {
                      push (@psets, \%last_ps);
                      $psets{ $last_ps{id} } = \%last_ps;
                  }
-
+
                  my $branch = extract_versionname($id);
                  %ps = ( id => $id, branch => $branch );
                  if (%last_ps && ($last_ps{branch} eq $branch)) {
                      $ps{parent_id} = $last_ps{id};
                  }
-
+
                  $arch_branches{$branch} = 1;
                  $lastseen = 'id';

@@ -166,16 +166,16 @@ sub do_abrowse {
                      $ps{type} = 't';
                      # read which revision we've tagged when we parse the log
                      $ps{tag}  = $1;
-                } else {
+                } else {
                      warn "Unknown type $type";
                  }

                  $arch_branches{$branch} = 1;
                  $lastseen = 'id';
-            } elsif (s/^\s{10}//) {
-                # 10 leading spaces or more
+            } elsif (s/^\s{10}//) {
+                # 10 leading spaces or more
                  # indicate commit metadata
-
+
                  # date
                  if ($lastseen eq 'id' && m/^(\d{4}-\d\d-\d\d \d\d:\d\d:\d\d)/){
                      $ps{date}   = $1;
@@ -186,12 +186,12 @@ sub do_abrowse {
                  } elsif ($lastseen eq 'merges' && s/^\s{2}//) {
                      my $id = $_;
                      push (@{$ps{merges}}, $id);
-
+
                      # aggressive branch finding:
                      if ($opt_D) {
                          my $branch = extract_versionname($id);
                          my $repo = extract_reponame($branch);
-
+
                          if (archive_reachable($repo) &&
                                  !defined $arch_branches{$branch}) {
                              $arch_branches{$branch} = $stage + 1;
@@ -208,10 +208,10 @@ sub do_abrowse {
              if (@psets && $psets[$#psets]{branch} eq $ps{branch}) {
                  $temp{parent_id} = $psets[$#psets]{id};
              }
-            push (@psets, \%temp);
+            push (@psets, \%temp);
              $psets{ $temp{id} } = \%temp;
-        }
-
+        }
+
          close ABROWSE or die "$TLA abrowse failed on $limit\n";
      }
  }                               # end foreach $root
@@ -253,7 +253,7 @@ unless (-d $git_dir) { # initial import
      while (my $file = readdir(DIR)) {
          # skip non-interesting-files
          next unless -f "$ptag_dir/$file";
-
+
          # convert first '--' to '/' from old git-archimport to use
          # as an archivename/c--b--v private tag
          if ($file !~ m!,!) {
@@ -275,7 +275,7 @@ sub extract_reponame {
      my $fq_cvbr = shift; # archivename/[[[[category]branch]version]revision]
      return (split(/\//, $fq_cvbr))[0];
  }
-
+
  sub extract_versionname {
      my $name = shift;
      $name =~ s/--(?:patch|version(?:fix)?|base)-\d+$//;
@@ -283,7 +283,7 @@ sub extract_versionname {
  }

  # convert a fully-qualified revision or version to a unique dirname:
-#   normalperson@yhbt.net-05/mpd--uclinux--1--patch-2
+#   normalperson@yhbt.net-05/mpd--uclinux--1--patch-2
  # becomes: normalperson@yhbt.net-05,mpd--uclinux--1
  #
  # the git notion of a branch is closer to
@@ -339,7 +339,7 @@ sub git_branchname {

  sub process_patchset_accurate {
      my $ps = shift;
-
+
      # switch to that branch if we're not already in that branch:
      if (-e "$git_dir/refs/heads/$ps->{branch}") {
         system('git-checkout','-f',$ps->{branch}) == 0 or die "$! $?\n";
@@ -348,7 +348,7 @@ sub process_patchset_accurate {
         my $rm = safe_pipe_capture('git-ls-files','--others','-z');
         rmtree(split(/\0/,$rm)) if $rm;
      }
-
+
      # Apply the import/changeset/merge into the working tree
      my $dir = sync_to_ps($ps);
      # read the new log entry:
@@ -361,9 +361,9 @@ sub process_patchset_accurate {
      parselog($ps, \@commitlog);

      if ($ps->{id} =~ /--base-0$/ && $ps->{id} ne $psets[0]{id}) {
-        # this should work when importing continuations
+        # this should work when importing continuations
          if ($ps->{tag} && (my $branchpoint = eval { ptag($ps->{tag}) })) {
-
+
              # find where we are supposed to branch from
  	    if (! -e "$git_dir/refs/heads/$ps->{branch}") {
  		system('git-branch',$ps->{branch},$branchpoint) == 0 or die "$! $?\n";
@@ -388,8 +388,8 @@ sub process_patchset_accurate {
          }
          # allow multiple bases/imports here since Arch supports cherry-picks
          # from unrelated trees
-    }
-
+    }
+
      # update the index with all the changes we got
      system('git-diff-files --name-only -z | '.
              'git-update-index --remove -z --stdin') == 0 or die "$! $?\n";
@@ -402,7 +402,7 @@ sub process_patchset_accurate {
  # does not handle permissions or any renames involving directories
  sub process_patchset_fast {
      my $ps = shift;
-    #
+    #
      # create the branch if needed
      #
      if ($ps->{type} eq 'i' && !$import) {
@@ -417,9 +417,9 @@ sub process_patchset_fast {
              # new branch! we need to verify a few things
              die "Branch on a non-tag!" unless $ps->{type} eq 't';
              my $branchpoint = ptag($ps->{tag});
-            die "Tagging from unknown id unsupported: $ps->{tag}"
+            die "Tagging from unknown id unsupported: $ps->{tag}"
                  unless $branchpoint;
-
+
              # find where we are supposed to branch from
  	    if (! -e "$git_dir/refs/heads/$ps->{branch}") {
  		system('git-branch',$ps->{branch},$branchpoint) == 0 or die "$! $?\n";
@@ -435,13 +435,13 @@ sub process_patchset_fast {
              }
              system('git-checkout',$ps->{branch}) == 0 or die "$! $?\n";
              return 0;
-        }
+        }
          die $! if $?;
-    }
+    }

      #
      # Apply the import/changeset/merge into the working tree
-    #
+    #
      if ($ps->{type} eq 'i' || $ps->{type} eq 't') {
          apply_import($ps) or die $!;
          $stats{import_or_tag}++;
@@ -455,10 +455,10 @@ sub process_patchset_fast {
      # prepare update git's index, based on what arch knows
      # about the pset, resolve parents, etc
      #
-
-    my @commitlog = safe_pipe_capture($TLA,'cat-archive-log',$ps->{id});
+
+    my @commitlog = safe_pipe_capture($TLA,'cat-archive-log',$ps->{id});
      die "Error in cat-archive-log: $!" if $?;
-
+
      parselog($ps,\@commitlog);

      # imports don't give us good info
@@ -485,10 +485,10 @@ sub process_patchset_fast {
          if (@$ren % 2) {
              die "Odd number of entries in rename!?";
          }
-
+
          while (@$ren) {
              my $from = shift @$ren;
-            my $to   = shift @$ren;
+            my $to   = shift @$ren;

              unless (-d dirname($to)) {
                  mkpath(dirname($to)); # will die on err
@@ -529,20 +529,20 @@ if ($opt_f) {
              "Things may be a bit slow\n";
      *process_patchset = *process_patchset_accurate;
  }
-
+
  foreach my $ps (@psets) {
      # process patchsets
      $ps->{branch} = git_branchname($ps->{id});

      #
-    # ensure we have a clean state
-    #
+    # ensure we have a clean state
+    #
      if (my $dirty = `git-diff-files`) {
          die "Unclean tree when about to process $ps->{id} " .
              " - did we fail to commit cleanly before?\n$dirty";
      }
      die $! if $?;
-
+
      #
      # skip commits already in repo
      #
@@ -559,7 +559,7 @@ foreach my $ps (@psets) {
      my $tree = `git-write-tree`;
      die "cannot write tree $!" if $?;
      chomp $tree;
-
+
      #
      # Who's your daddy?
      #
@@ -570,18 +570,18 @@ foreach my $ps (@psets) {
              close HEAD;
              chomp $p;
              push @par, '-p', $p;
-        } else {
+        } else {
              if ($ps->{type} eq 's') {
                  warn "Could not find the right head for the branch $ps->{branch}";
              }
          }
      }
-
+
      if ($ps->{merges}) {
          push @par, find_parents($ps);
      }

-    #
+    #
      # Commit, tag and clean state
      #
      $ENV{TZ}                  = 'GMT';
@@ -592,14 +592,14 @@ foreach my $ps (@psets) {
      $ENV{GIT_COMMITTER_EMAIL} = $ps->{email};
      $ENV{GIT_COMMITTER_DATE}  = $ps->{date};

-    my $pid = open2(*READER, *WRITER,'git-commit-tree',$tree,@par)
+    my $pid = open2(*READER, *WRITER,'git-commit-tree',$tree,@par)
          or die $!;
      print WRITER $ps->{summary},"\n\n";
      print WRITER $ps->{message},"\n";
-
+
      # make it easy to backtrack and figure out which Arch revision this was:
      print WRITER 'git-archimport-id: ',$ps->{id},"\n";
-
+
      close WRITER;
      my $commitid = <READER>;    # read
      chomp $commitid;
@@ -611,7 +611,7 @@ foreach my $ps (@psets) {
      }
      #
      # Update the branch
-    #
+    #
      open  HEAD, ">","$git_dir/refs/heads/$ps->{branch}";
      print HEAD $commitid;
      close HEAD;
@@ -640,7 +640,7 @@ exit 0;
  sub sync_to_ps {
      my $ps = shift;
      my $tree_dir = $tmp.'/'.tree_dirname($ps->{id});
-
+
      $opt_v && print "sync_to_ps($ps->{id}) method: ";

      if (-d $tree_dir) {
@@ -674,7 +674,7 @@ sub sync_to_ps {
          safe_pipe_capture($TLA,'get','--no-pristine',$ps->{id},$tree_dir);
          $stats{get_new}++;
      }
-
+
      # added -I flag to rsync since we're going to fast! AIEEEEE!!!!
      system('rsync','-aI','--delete','--exclude',$git_dir,
  #               '--exclude','.arch-inventory',
@@ -691,15 +691,15 @@ sub apply_import {
      mkpath($tmp);

      safe_pipe_capture($TLA,'get','-s','--no-pristine',$ps->{id},"$tmp/import");
-    die "Cannot get import: $!" if $?;
+    die "Cannot get import: $!" if $?;
      system('rsync','-aI','--delete', '--exclude',$git_dir,
  		'--exclude','.arch-ids','--exclude','{arch}',
  		"$tmp/import/", './');
      die "Cannot rsync import:$!" if $?;
-
+
      rmtree("$tmp/import");
      die "Cannot remove tempdir: $!" if $?;
-
+

      return 1;
  }
@@ -712,13 +712,13 @@ sub apply_cset {
      # get the changeset
      safe_pipe_capture($TLA,'get-changeset',$ps->{id},"$tmp/changeset");
      die "Cannot get changeset: $!" if $?;
-
+
      # apply patches
      if (`find $tmp/changeset/patches -type f -name '*.patch'`) {
          # this can be sped up considerably by doing
          #    (find | xargs cat) | patch
          # but that can get mucked up by patches
-        # with missing trailing newlines or the standard
+        # with missing trailing newlines or the standard
          # 'missing newline' flag in the patch - possibly
          # produced with an old/buggy diff.
          # slow and safe, we invoke patch once per patchfile
@@ -741,7 +741,7 @@ sub apply_cset {

      # bring in new files
      system('rsync','-aI','--exclude',$git_dir,
-    		'--exclude','.arch-ids',
+		'--exclude','.arch-ids',
  		'--exclude', '{arch}',
  		"$tmp/changeset/new-files-archive/",'./');

@@ -789,7 +789,7 @@ sub parselog {
          removed_files => 1,
          removed_directories => 1,
      );
-
+
      chomp (@$log);
      while ($_ = shift @$log) {
          if (/^Continuation-of:\s*(.*)/) {
@@ -828,7 +828,7 @@ sub parselog {
              }
          }
      }
-
+
      # drop leading empty lines from the log message
      while (@$log && $log->[0] eq '') {
  	shift @$log;
@@ -842,7 +842,7 @@ sub parselog {
  	$ps->{summary} = $log->[0] . '...';
      }
      $ps->{message} = join("\n",@$log);
-
+
      # skip Arch control files, unescape pika-escaped files
      foreach my $k (keys %want_headers) {
          next unless (defined $ps->{$k});
@@ -867,7 +867,7 @@ sub parselog {
  # write/read a tag
  sub tag {
      my ($tag, $commit) = @_;
-
+
      if ($opt_o) {
          $tag =~ s|/|--|g;
      } else {
@@ -875,7 +875,7 @@ sub tag {
  	$patchname =~ s/.*--//;
          $tag = git_branchname ($tag) . '--' . $patchname;
      }
-
+
      if ($commit) {
          open(C,">","$git_dir/refs/tags/$tag")
              or die "Cannot create tag $tag: $!\n";
@@ -902,8 +902,8 @@ sub ptag {
      my ($tag, $commit) = @_;

      # don't use subdirs for tags yet, it could screw up other porcelains
-    $tag =~ s|/|,|g;
-
+    $tag =~ s|/|,|g;
+
      my $tag_file = "$ptag_dir/$tag";
      my $tag_branch_dir = dirname($tag_file);
      mkpath($tag_branch_dir) unless (-d $tag_branch_dir);
@@ -915,7 +915,7 @@ sub ptag {
              or die "Cannot write tag $tag: $!\n";
          close(C)
              or die "Cannot write tag $tag: $!\n";
-	$rptags{$commit} = $tag
+	$rptags{$commit} = $tag
  	    unless $tag =~ m/--base-0$/;
      } else {                    # read
          # if the tag isn't there, return 0
@@ -941,7 +941,7 @@ sub find_parents {
      # Identify what branches are merging into me
      # and whether we are fully merged
      # git-merge-base <headsha> <headsha> should tell
-    # me what the base of the merge should be
+    # me what the base of the merge should be
      #
      my $ps = shift;

@@ -963,14 +963,14 @@ sub find_parents {
      }

      #
-    # foreach branch find a merge base and walk it to the
+    # foreach branch find a merge base and walk it to the
      # head where we are, collecting the merged patchsets that
      # Arch has recorded. Keep that in @have
      # Compare that with the commits on the other branch
      # between merge-base and the tip of the branch (@need)
      # and see if we have a series of consecutive patches
      # starting from the merge base. The tip of the series
-    # of consecutive patches merged is our new parent for
+    # of consecutive patches merged is our new parent for
      # that branch.
      #
      foreach my $branch (keys %branches) {
@@ -979,13 +979,13 @@ sub find_parents {
  	next unless -e "$git_dir/refs/heads/$branch";

  	my $mergebase = `git-merge-base $branch $ps->{branch}`;
- 	if ($?) {
- 	    # Don't die here, Arch supports one-way cherry-picking
- 	    # between branches with no common base (or any relationship
- 	    # at all beforehand)
- 	    warn "Cannot find merge base for $branch and $ps->{branch}";
- 	    next;
- 	}
+	if ($?) {
+	    # Don't die here, Arch supports one-way cherry-picking
+	    # between branches with no common base (or any relationship
+	    # at all beforehand)
+	    warn "Cannot find merge base for $branch and $ps->{branch}";
+	    next;
+	}
  	chomp $mergebase;

  	# now walk up to the mergepoint collecting what patches we have
@@ -1010,7 +1010,7 @@ sub find_parents {
  	# merge what we have with what ancestors have
  	%have = (%have, %ancestorshave);

-	# see what the remote branch has - these are the merges we
+	# see what the remote branch has - these are the merges we
  	# will want to have in a consecutive series from the mergebase
  	my $otherbranchtip = git_rev_parse($branch);
  	my @needraw = `git-rev-list --topo-order $otherbranchtip ^$mergebase`;
@@ -1018,7 +1018,7 @@ sub find_parents {
  	foreach my $needps (@needraw) { 	# get the psets
  	    $needps = commitid2pset($needps);
  	    # git-rev-list will also
-	    # list commits merged in via earlier
+	    # list commits merged in via earlier
  	    # merges. we are only interested in commits
  	    # from the branch we're looking at
  	    if ($branch eq $needps->{branch}) {
@@ -1054,7 +1054,7 @@ sub find_parents {
  	next unless ref    $psets{$p}{merges};
  	my @merges = @{$psets{$p}{merges}};
  	foreach my $merge (@merges) {
-	    if ($parents{$merge}) {
+	    if ($parents{$merge}) {
  		delete $parents{$merge};
  	    }
  	}
@@ -1079,10 +1079,10 @@ sub git_rev_parse {
  sub commitid2pset {
      my $commitid = shift;
      chomp $commitid;
-    my $name = $rptags{$commitid}
+    my $name = $rptags{$commitid}
  	|| die "Cannot find reverse tag mapping for $commitid";
      $name =~ s|,|/|;
-    my $ps   = $psets{$name}
+    my $ps   = $psets{$name}
  	|| (print Dumper(sort keys %psets)) && die "Cannot find patchset for $name";
      return $ps;
  }
@@ -1112,7 +1112,7 @@ sub archive_reachable {
      my $archive = shift;
      return 1 if $reachable{$archive};
      return 0 if $unreachable{$archive};
-
+
      if (system "$TLA whereis-archive $archive >/dev/null") {
          if ($opt_a && (system($TLA,'register-archive',
                        "http://mirrors.sourcecontrol.net/$archive") == 0)) {
@@ -1127,4 +1127,3 @@ sub archive_reachable {
          return 1;
      }
  }
-
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index d6ae99b..f95e369 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -193,7 +193,7 @@ if (@canstatusfiles) {
  # ... validate new files,
  foreach my $f (@afiles) {
      if (defined ($cvsstat{$f}) and $cvsstat{$f} ne "Unknown") {
- 	$dirty = 1;
+	$dirty = 1;
  	warn "File $f is already known in your CVS checkout -- perhaps it has been added by another user. Or this may 
indicate that it exists on a different branch. If this is the case, use -f to force the merge.\n";
  	warn "Status was: $cvsstat{$f}\n";
      }
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index ac74bc5..d41eace 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -145,7 +145,7 @@ my $cvs_tree;
  if ($#ARGV == 0) {
  	$cvs_tree = $ARGV[0];
  } elsif (-f 'CVS/Repository') {
-	open my $f, '<', 'CVS/Repository' or
+	open my $f, '<', 'CVS/Repository' or
  	    die 'Failed to open CVS/Repository';
  	$cvs_tree = <$f>;
  	chomp $cvs_tree;
@@ -434,7 +434,7 @@ sub file {
  	my ($self,$fn,$rev) = @_;
  	my $res;

-	my ($fh, $name) = tempfile('gitcvs.XXXXXX',
+	my ($fh, $name) = tempfile('gitcvs.XXXXXX',
  		    DIR => File::Spec->tmpdir(), UNLINK => 1);

  	$self->_file($fn,$rev) and $res = $self->_line($fh);
@@ -520,8 +520,8 @@ sub is_sha1 {

  sub get_headref ($$) {
      my $name    = shift;
-    my $git_dir = shift;
-
+    my $git_dir = shift;
+
      my $f = "$git_dir/refs/heads/$name";
      if (open(my $fh, $f)) {
  	    chomp(my $r = <$fh>);
@@ -771,7 +771,7 @@ sub commit {
  		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
  		$xtag =~ tr/_/\./ if ( $opt_u );
  		$xtag =~ s/[\/]/$opt_s/g;
-		
+
  		my $pid = open2($in, $out, 'git-mktag');
  		print $out "object $cid\n".
  		    "type commit\n".
@@ -788,7 +788,7 @@ sub commit {
  		     $? != 0 or $tagobj !~ /^[0123456789abcdef]{40}$/ ) {
  		    die "Cannot create tag object $xtag: $!\n";
  	        }
-		
+

  		open(C,">$git_dir/refs/tags/$xtag")
  			or die "Cannot create tag $xtag: $!\n";
diff --git a/git-gui/lib/class.tcl b/git-gui/lib/class.tcl
index 88b0565..72494c1 100644
--- a/git-gui/lib/class.tcl
+++ b/git-gui/lib/class.tcl
@@ -151,4 +151,3 @@ auto_mkindex_parser::command constructor {name args} {
  		[format { [list source [file join $dir %s]]} \
  		[file split $scriptFile]] "\n"
  }
-
diff --git a/git-p4import.py b/git-p4import.py
index 60a758b..0f3d97b 100644
--- a/git-p4import.py
+++ b/git-p4import.py
@@ -358,4 +358,3 @@ for id in changes:
      if stitch == 1:
          git.clean_directories()
          stitch = 0
-
diff --git a/git-svnimport.perl b/git-svnimport.perl
index 3af8c7e..f459762 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -542,7 +542,7 @@ sub copy_path($$$$$$$$) {
  	if ($node_kind eq $SVN::Node::dir) {
  		$srcpath =~ s#/*$#/#;
  	}
-	
+
  	my $pid = open my $f,'-|';
  	die $! unless defined $pid;
  	if (!$pid) {
@@ -560,7 +560,7 @@ sub copy_path($$$$$$$$) {
  		} else {
  			$p = $path;
  		}
-		push(@$new,[$mode,$sha1,$p]);	
+		push(@$new,[$mode,$sha1,$p]);
  	}
  	close($f) or
  		print STDERR "$newrev:$newbranch: could not list files in $oldpath \@ $rev\n";
diff --git a/gitk b/gitk
index a57e84c..87c3690 100755
--- a/gitk
+++ b/gitk
@@ -337,7 +337,7 @@ proc readrefs {} {
  		    set tagids($name) $commit
  		    lappend idtags($commit) $name
  		}
-	    }		
+	    }
  	    catch {
  	        set tagcontents($name) [exec git cat-file tag $id]
  	    }
-- 
1.5.2.rc3.90.gf33e-dirty
