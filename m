From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not call built-in aliases from scripts
Date: Thu, 27 Jun 2013 09:11:12 -0700
Message-ID: <7vzjubtty7.fsf@alter.siamese.dyndns.org>
References: <CAHGBnuNUjaWH2UDsa6jGjf32M+b8-iezw4pKXR985mROFSLOKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,  msysGit Mailinglist <msysgit@googlegroups.com>,  Thomas Braun <thomas.braun@virtuell-zuhause.de>,  Pat Thoyts <patthoyts@users.sourceforge.net>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBJGIWGHAKGQE7OXOXSQ@googlegroups.com Thu Jun 27 18:11:19 2013
Return-path: <msysgit+bncBCG77UMM3EJRBJGIWGHAKGQE7OXOXSQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gh0-f185.google.com ([209.85.160.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBJGIWGHAKGQE7OXOXSQ@googlegroups.com>)
	id 1UsEn0-0006Og-BS
	for gcvm-msysgit@m.gmane.org; Thu, 27 Jun 2013 18:11:18 +0200
Received: by mail-gh0-f185.google.com with SMTP id g22sf316435ghb.12
        for <gcvm-msysgit@m.gmane.org>; Thu, 27 Jun 2013 09:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=2pi+8paUm98C+d8II5BXHzXRGyOQgwikeJnrj404jnU=;
        b=Uey6TsSgWT7A3D3XrqyyhR9Lb16hOsPmDwBx6Szv25cV4BCqyjclJ0DM1ZX2omLqv4
         KXHgGzYy0+Ca7i5v526OH3FhNP/n7OHhEuP6aqVVZZKGekoeYI98srFMPt7n5TkCETiW
         uiH+0n7DUt0gCp3Xfqk78UHzpscL0IvCziiZOmEAqPfDSEbelTnDEWYrN/IljBkJ2qEs
         pP9tQ4ftqr+q+OLzhTXcBRAKsrg5jGa+OlXvcBwGE/PADBqO/rB+Sw0Bet7liExIpze0
         0RPf1i/6CvJf9d1G2aLbCdV2RLq9tKaXw1SCeZf1DDPmX+ddtRfdAd3blxpjEEiMYBRr
         z+ 
X-Received: by 10.49.63.195 with SMTP id i3mr238053qes.29.1372349477519;
        Thu, 27 Jun 2013 09:11:17 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.71.210 with SMTP id x18ls882386qeu.85.gmail; Thu, 27 Jun
 2013 09:11:16 -0700 (PDT)
X-Received: by 10.58.205.238 with SMTP id lj14mr1082645vec.31.1372349476606;
        Thu, 27 Jun 2013 09:11:16 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id zg9si183405vdb.1.2013.06.27.09.11.16
        for <msysgit@googlegroups.com>;
        Thu, 27 Jun 2013 09:11:16 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D63652973A;
	Thu, 27 Jun 2013 16:11:15 +0000 (UTC)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7F2329738;
	Thu, 27 Jun 2013 16:11:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A2222972F;
	Thu, 27 Jun 2013 16:11:14 +0000 (UTC)
In-Reply-To: <CAHGBnuNUjaWH2UDsa6jGjf32M+b8-iezw4pKXR985mROFSLOKQ@mail.gmail.com>
	(Sebastian Schuberth's message of "Thu, 27 Jun 2013 14:47:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 30D344E6-DF44-11E2-BE67-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com
 designates 208.72.237.35 as permitted sender) smtp.mail=junio@b-sasl-quonix.pobox.com;
       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229114>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Call built-in commands via the main executable (non-dashed form) without
> relying on the aliases (dashed form) to be present. On some platforms,
> e.g. those that do not properly support file system links, it is
> inconvenient to ship the built-in aliases, so do not depend on their
> presence.

In principle I have no problem with this change, if nothing other
than for consistency reasons.  We tell users to write "git foo", and
we tell users to say PATH=$(git --exec-path):$PATH if they want to
write "git-foo", but we do tell them we prefer 'git foo' form.  We
should do so ourselves where it is reasonable.

I vaguely recall that some people may have argued that git-foo is
one less exec(2) when we left these in our scripted Porcelains,
though, so on a platform with poorly performing fork/exec, this
change may be seen as detrimental.  I do not know it matters that
much.

Having said all that, I do have a huge issue with the justification
in the proposed log message.  If your plan is to make this:

	$(git --exec-path)/git-ls-files

not to work with your port of Git, that implementation is _broken_
and is not a Git anymore.

Git can evolve over time, and if that is really your plan, the first
step you have to take is to revive the old discussion we had after
v1.6.0:

  http://thread.gmane.org/gmane.comp.version-control.git/93511/focus=93825

and see if it is now a good idea.  It could be in year 2014.  It was
not in 2008.

I cannot apply this exact patch for an obvious and unrelated reason;
it seems to have changes, e.g. "git am" option help, that do not
have anything to do with the topic.

For a future reroll of this patch with only "git-foo -> 'git foo'",
I would appreciate an independent review by at least one set of
eyes.  It is very easy to blindly do this conversion with sed/perl
and fail to spot misconversion before sending it out.


> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  git-am.sh                |  6 ++---
>  git-archimport.perl      | 68 ++++++++++++++++++++++++------------------------
>  git-cvsexportcommit.perl | 18 ++++++-------
>  git-cvsserver.perl       | 50 +++++++++++++++++------------------
>  git-merge-octopus.sh     |  2 +-
>  git-merge-one-file.sh    |  8 +++---
>  git-merge-resolve.sh     |  2 +-
>  git-parse-remote.sh      |  2 +-
>  git-pull.sh              |  2 +-
>  git-stash.sh             |  2 +-
>  git-submodule.sh         |  8 +++---
>  11 files changed, 84 insertions(+), 84 deletions(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index 9f44509..ad67194 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -16,8 +16,8 @@ s,signoff       add a Signed-off-by line to the commit message
>  u,utf8          recode into utf8 (default)
>  k,keep          pass -k flag to git-mailinfo
>  keep-non-patch  pass -b flag to git-mailinfo
> -keep-cr         pass --keep-cr flag to git-mailsplit for mbox format
> -no-keep-cr      do not pass --keep-cr flag to git-mailsplit
> independent of am.keepcr
> +keep-cr         pass --keep-cr flag to git mailsplit for mbox format
> +no-keep-cr      do not pass --keep-cr flag to git mailsplit
> independent of am.keepcr
>  c,scissors      strip everything before a scissors line
>  whitespace=     pass it through git-apply
>  ignore-space-change pass it through git-apply
> @@ -174,7 +174,7 @@ It does not apply to blobs recorded in its index.")"
>      then
>  	    GIT_MERGE_VERBOSITY=0 && export GIT_MERGE_VERBOSITY
>      fi
> -    git-merge-recursive $orig_tree -- HEAD $his_tree || {
> +    git merge-recursive $orig_tree -- HEAD $his_tree || {
>  	    git rerere $allow_rerere_autoupdate
>  	    die "$(gettext "Failed to merge in the changes.")"
>      }
> diff --git a/git-archimport.perl b/git-archimport.perl
> index 9cb123a..ed2c741 100755
> --- a/git-archimport.perl
> +++ b/git-archimport.perl
> @@ -343,10 +343,10 @@ sub process_patchset_accurate {
>
>      # switch to that branch if we're not already in that branch:
>      if (-e "$git_dir/refs/heads/$ps->{branch}") {
> -       system('git-checkout','-f',$ps->{branch}) == 0 or die "$! $?\n";
> +       system('git','checkout','-f',$ps->{branch}) == 0 or die "$! $?\n";
>
>         # remove any old stuff that got leftover:
> -       my $rm = safe_pipe_capture('git-ls-files','--others','-z');
> +       my $rm = safe_pipe_capture('git','ls-files','--others','-z');
>         rmtree(split(/\0/,$rm)) if $rm;
>      }
>
> @@ -367,7 +367,7 @@ sub process_patchset_accurate {
>
>              # find where we are supposed to branch from
>  	    if (! -e "$git_dir/refs/heads/$ps->{branch}") {
> -		system('git-branch',$ps->{branch},$branchpoint) == 0 or die "$! $?\n";
> +		system('git','branch',$ps->{branch},$branchpoint) == 0 or die "$! $?\n";
>
>  		# We trust Arch with the fact that this is just a tag,
>  		# and it does not affect the state of the tree, so
> @@ -378,10 +378,10 @@ sub process_patchset_accurate {
>  		ptag($ps->{id}, $branchpoint);
>  		print " * Tagged $ps->{id} at $branchpoint\n";
>  	    }
> -	    system('git-checkout','-f',$ps->{branch}) == 0 or die "$! $?\n";
> +	    system('git','checkout','-f',$ps->{branch}) == 0 or die "$! $?\n";
>
>              # remove any old stuff that got leftover:
> -            my $rm = safe_pipe_capture('git-ls-files','--others','-z');
> +            my $rm = safe_pipe_capture('git','ls-files','--others','-z');
>              rmtree(split(/\0/,$rm)) if $rm;
>              return 0;
>          } else {
> @@ -392,10 +392,10 @@ sub process_patchset_accurate {
>      }
>
>      # update the index with all the changes we got
> -    system('git-diff-files --name-only -z | '.
> -            'git-update-index --remove -z --stdin') == 0 or die "$! $?\n";
> -    system('git-ls-files --others -z | '.
> -            'git-update-index --add -z --stdin') == 0 or die "$! $?\n";
> +    system('git diff-files --name-only -z | '.
> +            'git update-index --remove -z --stdin') == 0 or die "$! $?\n";
> +    system('git ls-files --others -z | '.
> +            'git update-index --add -z --stdin') == 0 or die "$! $?\n";
>      return 1;
>  }
>
> @@ -413,7 +413,7 @@ sub process_patchset_fast {
>      unless ($import) { # skip for import
>          if ( -e "$git_dir/refs/heads/$ps->{branch}") {
>              # we know about this branch
> -            system('git-checkout',$ps->{branch});
> +            system('git','checkout',$ps->{branch});
>          } else {
>              # new branch! we need to verify a few things
>              die "Branch on a non-tag!" unless $ps->{type} eq 't';
> @@ -423,7 +423,7 @@ sub process_patchset_fast {
>
>              # find where we are supposed to branch from
>  	    if (! -e "$git_dir/refs/heads/$ps->{branch}") {
> -		system('git-branch',$ps->{branch},$branchpoint) == 0 or die "$! $?\n";
> +		system('git','branch',$ps->{branch},$branchpoint) == 0 or die "$! $?\n";
>
>  		# We trust Arch with the fact that this is just a tag,
>  		# and it does not affect the state of the tree, so
> @@ -434,7 +434,7 @@ sub process_patchset_fast {
>  		ptag($ps->{id}, $branchpoint);
>  		print " * Tagged $ps->{id} at $branchpoint\n";
>              }
> -            system('git-checkout',$ps->{branch}) == 0 or die "$! $?\n";
> +            system('git','checkout',$ps->{branch}) == 0 or die "$! $?\n";
>              return 0;
>          }
>          die $! if $?;
> @@ -465,10 +465,10 @@ sub process_patchset_fast {
>      # imports don't give us good info
>      # on added files. Shame on them
>      if ($ps->{type} eq 'i' || $ps->{type} eq 't') {
> -        system('git-ls-files --deleted -z | '.
> -                'git-update-index --remove -z --stdin') == 0 or die "$! $?\n";
> -        system('git-ls-files --others -z | '.
> -                'git-update-index --add -z --stdin') == 0 or die "$! $?\n";
> +        system('git ls-files --deleted -z | '.
> +                'git update-index --remove -z --stdin') == 0 or die "$! $?\n";
> +        system('git ls-files --others -z | '.
> +                'git update-index --add -z --stdin') == 0 or die "$! $?\n";
>      }
>
>      # TODO: handle removed_directories and renamed_directories:
> @@ -477,8 +477,8 @@ sub process_patchset_fast {
>          unlink @$del;
>          while (@$del) {
>              my @slice = splice(@$del, 0, 100);
> -            system('git-update-index','--remove','--',@slice) == 0 or
> -                            die "Error in git-update-index --remove: $! $?\n";
> +            system('git update-index','--remove','--',@slice) == 0 or
> +                            die "Error in git update-index --remove: $! $?\n";
>          }
>      }
>
> @@ -496,25 +496,25 @@ sub process_patchset_fast {
>              }
>              # print "moving $from $to";
>              rename($from, $to) or die "Error renaming '$from' '$to': $!\n";
> -            system('git-update-index','--remove','--',$from) == 0 or
> -                            die "Error in git-update-index --remove: $! $?\n";
> -            system('git-update-index','--add','--',$to) == 0 or
> -                            die "Error in git-update-index --add: $! $?\n";
> +            system('git update-index','--remove','--',$from) == 0 or
> +                            die "Error in git update-index --remove: $! $?\n";
> +            system('git update-index','--add','--',$to) == 0 or
> +                            die "Error in git update-index --add: $! $?\n";
>          }
>      }
>
>      if (my $add = $ps->{new_files}) {
>          while (@$add) {
>              my @slice = splice(@$add, 0, 100);
> -            system('git-update-index','--add','--',@slice) == 0 or
> -                            die "Error in git-update-index --add: $! $?\n";
> +            system('git update-index','--add','--',@slice) == 0 or
> +                            die "Error in git update-index --add: $! $?\n";
>          }
>      }
>
>      if (my $mod = $ps->{modified_files}) {
>          while (@$mod) {
>              my @slice = splice(@$mod, 0, 100);
> -            system('git-update-index','--',@slice) == 0 or
> +            system('git update-index','--',@slice) == 0 or
>                              die "Error in git-update-index: $! $?\n";
>          }
>      }
> @@ -593,7 +593,7 @@ foreach my $ps (@psets) {
>      $ENV{GIT_COMMITTER_EMAIL} = $ps->{email};
>      $ENV{GIT_COMMITTER_DATE}  = $ps->{date};
>
> -    my $pid = open2(*READER, *WRITER,'git-commit-tree',$tree,@par)
> +    my $pid = open2(*READER, *WRITER,'git','commit-tree',$tree,@par)
>          or die $!;
>      print WRITER $ps->{summary},"\n\n";
>
> @@ -620,7 +620,7 @@ foreach my $ps (@psets) {
>      open  HEAD, ">","$git_dir/refs/heads/$ps->{branch}";
>      print HEAD $commitid;
>      close HEAD;
> -    system('git-update-ref', 'HEAD', "$ps->{branch}");
> +    system('git', 'update-ref', 'HEAD', "$ps->{branch}");
>
>      # tag accordingly
>      ptag($ps->{id}, $commitid); # private tag
> @@ -945,7 +945,7 @@ sub find_parents {
>      #
>      # Identify what branches are merging into me
>      # and whether we are fully merged
> -    # git-merge-base <headsha> <headsha> should tell
> +    # git merge-base <headsha> <headsha> should tell
>      # me what the base of the merge should be
>      #
>      my $ps = shift;
> @@ -983,7 +983,7 @@ sub find_parents {
>  	# check that we actually know about the branch
>  	next unless -e "$git_dir/refs/heads/$branch";
>
> -	my $mergebase = `git-merge-base $branch $ps->{branch}`;
> +	my $mergebase = `git merge-base $branch $ps->{branch}`;
>  	if ($?) {
>  	    # Don't die here, Arch supports one-way cherry-picking
>  	    # between branches with no common base (or any relationship
> @@ -995,7 +995,7 @@ sub find_parents {
>
>  	# now walk up to the mergepoint collecting what patches we have
>  	my $branchtip = git_rev_parse($ps->{branch});
> -	my @ancestors = `git-rev-list --topo-order $branchtip ^$mergebase`;
> +	my @ancestors = `git rev-list --topo-order $branchtip ^$mergebase`;
>  	my %have; # collected merges this branch has
>  	foreach my $merge (@{$ps->{merges}}) {
>  	    $have{$merge} = 1;
> @@ -1018,11 +1018,11 @@ sub find_parents {
>  	# see what the remote branch has - these are the merges we
>  	# will want to have in a consecutive series from the mergebase
>  	my $otherbranchtip = git_rev_parse($branch);
> -	my @needraw = `git-rev-list --topo-order $otherbranchtip ^$mergebase`;
> +	my @needraw = `git rev-list --topo-order $otherbranchtip ^$mergebase`;
>  	my @need;
>  	foreach my $needps (@needraw) { 	# get the psets
>  	    $needps = commitid2pset($needps);
> -	    # git-rev-list will also
> +	    # git rev-list will also
>  	    # list commits merged in via earlier
>  	    # merges. we are only interested in commits
>  	    # from the branch we're looking at
> @@ -1074,8 +1074,8 @@ sub find_parents {
>
>  sub git_rev_parse {
>      my $name = shift;
> -    my $val  = `git-rev-parse $name`;
> -    die "Error: git-rev-parse $name" if $?;
> +    my $val  = `git rev-parse $name`;
> +    die "Error: git rev-parse $name" if $?;
>      chomp $val;
>      return $val;
>  }
> diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
> index d13f02d..6718bad 100755
> --- a/git-cvsexportcommit.perl
> +++ b/git-cvsexportcommit.perl
> @@ -18,7 +18,7 @@ $opt_h && usage();
>
>  die "Need at least one commit identifier!" unless @ARGV;
>
> -# Get git-config settings
> +# Get git config settings
>  my $repo = Git->repository();
>  $opt_w = $repo->config('cvsexportcommit.cvsdir') unless defined $opt_w;
>
> @@ -26,7 +26,7 @@ if ($opt_w || $opt_W) {
>  	# Remember where GIT_DIR is before changing to CVS checkout
>  	unless ($ENV{GIT_DIR}) {
>  		# No GIT_DIR set. Figure it out for ourselves
> -		my $gd =`git-rev-parse --git-dir`;
> +		my $gd =`git rev-parse --git-dir`;
>  		chomp($gd);
>  		$ENV{GIT_DIR} = $gd;
>  	}
> @@ -62,7 +62,7 @@ if ($opt_d) {
>  # resolve target commit
>  my $commit;
>  $commit = pop @ARGV;
> -$commit = safe_pipe_capture('git-rev-parse', '--verify', "$commit^0");
> +$commit = safe_pipe_capture('git', 'rev-parse', '--verify', "$commit^0");
>  chomp $commit;
>  if ($?) {
>      die "The commit reference $commit did not resolve!";
> @@ -72,7 +72,7 @@ if ($?) {
>  my $parent;
>  if (@ARGV) {
>      $parent = pop @ARGV;
> -    $parent =  safe_pipe_capture('git-rev-parse', '--verify', "$parent^0");
> +    $parent =  safe_pipe_capture('git', 'rev-parse', '--verify', "$parent^0");
>      chomp $parent;
>      if ($?) {
>  	die "The parent reference did not resolve!";
> @@ -80,7 +80,7 @@ if (@ARGV) {
>  }
>
>  # find parents from the commit itself
> -my @commit  = safe_pipe_capture('git-cat-file', 'commit', $commit);
> +my @commit  = safe_pipe_capture('git', 'cat-file', 'commit', $commit);
>  my @parents;
>  my $committer;
>  my $author;
> @@ -158,9 +158,9 @@ if ($opt_a) {
>  close MSG;
>
>  if ($parent eq $noparent) {
> -    `git-diff-tree --binary -p --root $commit
>>.cvsexportcommit.diff`;# || die "Cannot diff";
> +    `git diff-tree --binary -p --root $commit
>>.cvsexportcommit.diff`;# || die "Cannot diff";
>  } else {
> -    `git-diff-tree --binary -p $parent $commit
>>.cvsexportcommit.diff`;# || die "Cannot diff";
> +    `git diff-tree --binary -p $parent $commit
>>.cvsexportcommit.diff`;# || die "Cannot diff";
>  }
>
>  ## apply non-binary changes
> @@ -174,7 +174,7 @@ my $context = $opt_p ? '' : '-C1';
>  print "Checking if patch will apply\n";
>
>  my @stat;
> -open APPLY, "GIT_DIR= git-apply $context --summary
> --numstat<.cvsexportcommit.diff|" || die "cannot patch";
> +open APPLY, "GIT_DIR= git apply $context --summary
> --numstat<.cvsexportcommit.diff|" || die "cannot patch";
>  @stat=<APPLY>;
>  close APPLY || die "Cannot patch";
>  my (@bfiles,@files,@afiles,@dfiles);
> @@ -329,7 +329,7 @@ print "Applying\n";
>  if ($opt_W) {
>      system("git checkout -q $commit^0") && die "cannot patch";
>  } else {
> -    `GIT_DIR= git-apply $context --summary --numstat --apply
> <.cvsexportcommit.diff` || die "cannot patch";
> +    `GIT_DIR= git apply $context --summary --numstat --apply
> <.cvsexportcommit.diff` || die "cannot patch";
>  }
>
>  print "Patch applied successfully. Adding new files and directories to CVS\n";
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index a0d796e..53c136f 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -358,10 +358,10 @@ sub req_Root
>
>      my @gitvars = `git config -l`;
>      if ($?) {
> -       print "E problems executing git-config on the server -- this
> is not a git repository or the PATH is not set correctly.\n";
> +        print "E problems executing git config on the server -- this
> is not a git repository or the PATH is not set correctly.\n";
>          print "E \n";
>          print "error 1 - problem executing git-config\n";
> -       return 0;
> +        return 0;
>      }
>      foreach my $line ( @gitvars )
>      {
> @@ -1626,7 +1626,7 @@ sub req_ci
>          if ($wrev) {
>              system('git', 'checkout-index', '-f', '-u', $filename);
>              unless ($? == 0) {
> -                die "Error running git-checkout-index -f -u $filename : $!";
> +                die "Error running git checkout-index -f -u $filename : $!";
>              }
>          }
>
> @@ -1716,7 +1716,7 @@ sub req_ci
>          exit;
>      }
>
> -	### Emulate git-receive-pack by running hooks/update
> +	### Emulate git receive-pack by running hooks/update
>  	my @hook = ( $ENV{GIT_DIR}.'hooks/update', $branchRef,
>  			$parenthash, $commithash );
>  	if( -x $hook[0] ) {
> @@ -1738,7 +1738,7 @@ sub req_ci
>  		exit;
>  	}
>
> -	### Emulate git-receive-pack by running hooks/post-receive
> +	### Emulate git receive-pack by running hooks/post-receive
>  	my $hook = $ENV{GIT_DIR}.'hooks/post-receive';
>  	if( -x $hook ) {
>  		open(my $pipe, "| $hook") || die "can't fork $!";
> @@ -2328,7 +2328,7 @@ sub req_annotate
>  	system("git", "read-tree", $lastseenin);
>  	unless ($? == 0)
>  	{
> -	    print "E error running git-read-tree $lastseenin
> $ENV{GIT_INDEX_FILE} $!\n";
> +	    print "E error running git read-tree $lastseenin
> $ENV{GIT_INDEX_FILE} $!\n";
>  	    return;
>  	}
>  	$log->info("Created index '$ENV{GIT_INDEX_FILE}' with commit
> $lastseenin - exit status $?");
> @@ -2336,7 +2336,7 @@ sub req_annotate
>          # do a checkout of the file
>          system('git', 'checkout-index', '-f', '-u', $filename);
>          unless ($? == 0) {
> -            print "E error running git-checkout-index -f -u $filename : $!\n";
> +            print "E error running git checkout-index -f -u $filename : $!\n";
>              return;
>          }
>
> @@ -2886,7 +2886,7 @@ sub transmitfile
>          }
>          close $fh or die ("Couldn't close filehandle for transmitfile(): $!");
>      } else {
> -        die("Couldn't execute git-cat-file");
> +        die("Couldn't execute git cat-file");
>      }
>  }
>
> @@ -3008,8 +3008,8 @@ sub setupWorkTree
>          system("git","read-tree",$ver);
>          unless ($? == 0)
>          {
> -            $log->warn("Error running git-read-tree");
> -            die "Error running git-read-tree $ver in $work->{workDir} $!\n";
> +            $log->warn("Error running git read-tree");
> +            die "Error running git read-tree $ver in $work->{workDir} $!\n";
>          }
>      }
>      # else # req_annotate reads tree for each file
> @@ -3062,7 +3062,7 @@ sub ensureWorkTree
>      system("git","read-tree",$ver);
>      unless ($? == 0)
>      {
> -        die "Error running git-read-tree $ver $!\n";
> +        die "Error running git read-tree $ver $!\n";
>      }
>  }
>
> @@ -3829,7 +3829,7 @@ sub update
>      } else {
>          push @git_log_params, $self->{module};
>      }
> -    # git-rev-list is the backend / plumbing version of git-log
> +    # git rev-list is the backend / plumbing version of git-log
>      open(my $gitLogPipe, '-|', 'git', 'rev-list', @git_log_params)
>                  or die "Cannot call git-rev-list: $!";
>      my @commits=readCommits($gitLogPipe);
> @@ -3878,7 +3878,7 @@ sub update
>                      if ($parent eq $lastpicked) {
>                          next;
>                      }
> -                    # git-merge-base can potentially (but rarely) throw
> +                    # git merge-base can potentially (but rarely) throw
>                      # several candidate merge bases. let's assume
>                      # that the first one is the best one.
>  		    my $base = eval {
> @@ -3936,14 +3936,14 @@ sub update
>
>          if ( defined ( $lastpicked ) )
>          {
> -            my $filepipe = open(FILELIST, '-|', 'git', 'diff-tree',
> '-z', '-r', $lastpicked, $commit->{hash}) or die("Cannot call
> git-diff-tree : $!");
> +            my $filepipe = open(FILELIST, '-|', 'git', 'diff-tree',
> '-z', '-r', $lastpicked, $commit->{hash}) or die("Cannot call git
> diff-tree : $!");
>  	    local ($/) = "\0";
>              while ( <FILELIST> )
>              {
>  		chomp;
>                  unless (
> /^:\d{6}\s+([0-7]{6})\s+[a-f0-9]{40}\s+([a-f0-9]{40})\s+(\w)$/o )
>                  {
> -                    die("Couldn't process git-diff-tree line : $_");
> +                    die("Couldn't process git diff-tree line : $_");
>                  }
>  		my ($mode, $hash, $change) = ($1, $2, $3);
>  		my $name = <FILELIST>;
> @@ -4006,14 +4006,14 @@ sub update
>              # this is used to detect files removed from the repo
>              my $seen_files = {};
>
> -            my $filepipe = open(FILELIST, '-|', 'git', 'ls-tree',
> '-z', '-r', $commit->{hash}) or die("Cannot call git-ls-tree : $!");
> +            my $filepipe = open(FILELIST, '-|', 'git', 'ls-tree',
> '-z', '-r', $commit->{hash}) or die("Cannot call git ls-tree : $!");
>  	    local $/ = "\0";
>              while ( <FILELIST> )
>              {
>  		chomp;
>                  unless ( /^(\d+)\s+(\w+)\s+([a-zA-Z0-9]+)\t(.*)$/o )
>                  {
> -                    die("Couldn't process git-ls-tree line : $_");
> +                    die("Couldn't process git ls-tree line : $_");
>                  }
>
>                  my ( $mode, $git_type, $git_hash, $git_filename ) = (
> $1, $2, $3, $4 );
> @@ -4312,7 +4312,7 @@ sub getAnyHead
>      my @files;
>      {
>          open(my $filePipe, '-|', 'git', 'ls-tree', '-z', '-r', $hash)
> -                or die("Cannot call git-ls-tree : $!");
> +                or die("Cannot call git ls-tree : $!");
>          local $/ = "\0";
>          @files=<$filePipe>;
>          close $filePipe;
> @@ -4325,7 +4325,7 @@ sub getAnyHead
>          $line=~s/\0$//;
>          unless ( $line=~/^(\d+)\s+(\w+)\s+([a-zA-Z0-9]+)\t(.*)$/o )
>          {
> -            die("Couldn't process git-ls-tree line : $_");
> +            die("Couldn't process git ls-tree line : $_");
>          }
>
>          my($mode, $git_type, $git_hash, $git_filename) = ($1, $2, $3, $4);
> @@ -4391,14 +4391,14 @@ sub getRevisionDirMap
>          }
>
>          open(my $filePipe, '-|', 'git', 'ls-tree', '-z', '-r', $hash)
> -                or die("Cannot call git-ls-tree : $!");
> +                or die("Cannot call git ls-tree : $!");
>          local $/ = "\0";
>          while ( <$filePipe> )
>          {
>              chomp;
>              unless ( /^(\d+)\s+(\w+)\s+([a-zA-Z0-9]+)\t(.*)$/o )
>              {
> -                die("Couldn't process git-ls-tree line : $_");
> +                die("Couldn't process git ls-tree line : $_");
>              }
>
>              my($mode, $git_type, $git_hash, $git_filename) = ($1, $2, $3, $4);
> @@ -4692,7 +4692,7 @@ sub getMetaFromCommithash
>
>      # NOTE: This function doesn't scale well (lots of forks), especially
>      #   if you have many files that have not been modified for many commits
> -    #   (each git-rev-parse redoes a lot of work for each file
> +    #   (each git rev-parse redoes a lot of work for each file
>      #   that theoretically could be done in parallel by smarter
>      #   graph traversal).
>      #
> @@ -4796,20 +4796,20 @@ sub getMetaFromCommithash
>      # meta data about $filename:
>      open(my $filePipe, '-|', 'git', 'ls-tree', '-z',
>                  $commit->{hash}, '--', $filename)
> -            or die("Cannot call git-ls-tree : $!");
> +            or die("Cannot call git ls-tree : $!");
>      local $/ = "\0";
>      my $line;
>      $line=<$filePipe>;
>      if(defined(<$filePipe>))
>      {
> -        die "Expected only a single file for git-ls-tree $filename\n";
> +        die "Expected only a single file for git ls-tree $filename\n";
>      }
>      close $filePipe;
>
>      chomp $line;
>      unless ( $line=~m/^(\d+)\s+(\w+)\s+([a-zA-Z0-9]+)\t(.*)$/o )
>      {
> -        die("Couldn't process git-ls-tree line : $line\n");
> +        die("Couldn't process git ls-tree line : $line\n");
>      }
>      my ( $mode, $git_type, $git_hash, $git_filename ) = ( $1, $2, $3, $4 );
>
> diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
> index 8643f74..ec1d65b 100755
> --- a/git-merge-octopus.sh
> +++ b/git-merge-octopus.sh
> @@ -97,7 +97,7 @@ do
>  	if test $? -ne 0
>  	then
>  		echo "Simple merge did not work, trying automatic merge."
> -		git-merge-index -o git-merge-one-file -a ||
> +		git merge-index -o git-merge-one-file -a ||
>  		OCTOPUS_FAILURE=1
>  		next=$(git write-tree 2>/dev/null)
>  	fi
> diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
> index 07dfeb8..b6d6297 100755
> --- a/git-merge-one-file.sh
> +++ b/git-merge-one-file.sh
> @@ -107,17 +107,17 @@ case "${1:-.}${2:-.}${3:-.}" in
>  		;;
>  	esac
>
> -	src1=$(git-unpack-file $2)
> -	src2=$(git-unpack-file $3)
> +	src1=$(git unpack-file $2)
> +	src2=$(git unpack-file $3)
>  	case "$1" in
>  	'')
>  		echo "Added $4 in both, but differently."
> -		orig=$(git-unpack-file $2)
> +		orig=$(git unpack-file $2)
>  		create_virtual_base "$orig" "$src2"
>  		;;
>  	*)
>  		echo "Auto-merging $4"
> -		orig=$(git-unpack-file $1)
> +		orig=$(git unpack-file $1)
>  		;;
>  	esac
>
> diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
> index c9da747..343fe7b 100755
> --- a/git-merge-resolve.sh
> +++ b/git-merge-resolve.sh
> @@ -45,7 +45,7 @@ then
>  	exit 0
>  else
>  	echo "Simple merge failed, trying Automatic merge."
> -	if git-merge-index -o git-merge-one-file -a
> +	if git merge-index -o git-merge-one-file -a
>  	then
>  		exit 0
>  	else
> diff --git a/git-parse-remote.sh b/git-parse-remote.sh
> index 0e87e09..baf3041 100644
> --- a/git-parse-remote.sh
> +++ b/git-parse-remote.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>
> -# git-ls-remote could be called from outside a git managed repository;
> +# git ls-remote could be called from outside a git managed repository;
>  # this would fail in that case and would issue an error message.
>  GIT_DIR=$(git rev-parse -q --git-dir) || :;
>
> diff --git a/git-pull.sh b/git-pull.sh
> index 638aabb..a7c837b 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -289,7 +289,7 @@ true)
>  	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
>  	;;
>  *)
> -	eval="git-merge $diffstat $no_commit $verify_signatures $edit
> $squash $no_ff $ff_only"
> +	eval="git merge $diffstat $no_commit $verify_signatures $edit
> $squash $no_ff $ff_only"
>  	eval="$eval  $log_arg $strategy_args $merge_args $verbosity $progress"
>  	eval="$eval \"\$merge_name\" HEAD $merge_head"
>  	;;
> diff --git a/git-stash.sh b/git-stash.sh
> index bbefdf6..26a699b 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -429,7 +429,7 @@ apply_stash () {
>
>  	if test -n "$u_tree"
>  	then
> -		GIT_INDEX_FILE="$TMPindex" git-read-tree "$u_tree" &&
> +		GIT_INDEX_FILE="$TMPindex" git read-tree "$u_tree" &&
>  		GIT_INDEX_FILE="$TMPindex" git checkout-index --all &&
>  		rm -f "$TMPindex" ||
>  		die 'Could not restore untracked files from stash'
> diff --git a/git-submodule.sh b/git-submodule.sh
> index eb58c8e..a9392cf 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -162,7 +162,7 @@ die_if_unmatched ()
>  # $2 = option name
>  # $3 = default value
>  #
> -# Checks in the usual git-config places first (for overrides),
> +# Checks in the usual git config places first (for overrides),
>  # otherwise it falls back on .gitmodules.  This allows you to
>  # distribute project-wide defaults in .gitmodules, while still
>  # customizing individual repositories if necessary.  If the option is
> @@ -951,7 +951,7 @@ cmd_summary() {
>  			# Always show modules deleted or type-changed (blob<->module)
>  			test $status = D -o $status = T && echo "$name" && continue
>  			# Also show added or modified modules which are checked out
> -			GIT_DIR="$name/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
> +			GIT_DIR="$name/.git" git rev-parse --git-dir >/dev/null 2>&1 &&
>  			echo "$name"
>  		done
>  	)
> @@ -985,11 +985,11 @@ cmd_summary() {
>  		missing_dst=
>
>  		test $mod_src = 160000 &&
> -		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 >/dev/null &&
> +		! GIT_DIR="$name/.git" git rev-parse -q --verify $sha1_src^0 >/dev/null &&
>  		missing_src=t
>
>  		test $mod_dst = 160000 &&
> -		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_dst^0 >/dev/null &&
> +		! GIT_DIR="$name/.git" git rev-parse -q --verify $sha1_dst^0 >/dev/null &&
>  		missing_dst=t
>
>  		total_commits=

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
