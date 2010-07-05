From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Print last time and committer a file was touched by for a whole  repo
Date: Mon, 5 Jul 2010 11:53:22 +0200
Message-ID: <201007051153.23956.jnareb@gmail.com>
References: <AANLkTikRElk07ZqK0TOM2WD31t-H5RVngvHNU9KM7e9D@mail.gmail.com> <AANLkTil2Riz3_iKEREjsERVsBkSZdZ9wa9ujOahxjs4Y@mail.gmail.com> <201007031113.33231.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TuaMM8yV2oHq2gU"
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 05 11:53:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OViMy-0007zO-O1
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 11:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781Ab0GEJxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 05:53:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53070 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab0GEJxi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 05:53:38 -0400
Received: by fxm14 with SMTP id 14so3487906fxm.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 02:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :message-id;
        bh=ZaWgJYY06DmgQrcFaHM6yaW27r97sCyOZBY7P0A6a80=;
        b=Xl9bSsNW9Kaiit1CwsJTelZi+LYy+HTLp4egKZFRr0CWj6EDSzcmhhRbVEPrsy06SC
         0mudURkYKBjifNgZEE8aCnp91Jdak3+gqaqyQ1MRWT6VjsvxVHc2fBevLRBA8ecOVLZr
         Gb/vBGqZkExXVDWcCBX+aBAaC2nsxxwUekB8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:message-id;
        b=J8vpA3k67uYdpJVTtYoi6vVcZzx2XUlZAB47yq/CxF4U4wtU1wwfeW46UyW6A/cOsm
         14WjXBis2dgIcMlU6iV4PioXt11eIDFyFte22HbEdqd8WWG00SOSP5PJZw3soBDPTexV
         hQv4p1xJPhXeRXH8jvAHbeb+wifCkZVa7lsYU=
Received: by 10.223.115.18 with SMTP id g18mr2061723faq.11.1278323615103;
        Mon, 05 Jul 2010 02:53:35 -0700 (PDT)
Received: from [192.168.1.15] (abvy158.neoplus.adsl.tpnet.pl [83.8.222.158])
        by mx.google.com with ESMTPS id 20sm8744945fax.32.2010.07.05.02.53.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Jul 2010 02:53:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201007031113.33231.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150254>

--Boundary-00=_TuaMM8yV2oHq2gU
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Sat, 3 July 2010, Jakub Narebski wrote:
> On Fri, 2 July 2010, Tim Visher wrote:
>> On Thu, Jul 1, 2010 at 4:12 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>> Tim Visher <tim.visher@gmail.com> writes:
>>>
>>>> I need to get a listing of the entire contents of my current repo (as
>>>> in, I don't need deleted files or anything like that, just the current
>>>> snapshot) with the time the file was committed and who committed it.
>>>>
>>>> Thoughts on how to do that?
>>>
>>> There does not exist a single git command that would do what you want.
>>> You would need to use 'git log -1 --follow' for each file in current
>>> snapshot ('git ls-tree -r HEAD').  IIRC there is some example how to
>>> do that in GitFaq or GitTips on git wiki (http://git.wiki.kernel.org).
>>>
>>> Perhaps in the future 'git blame <directory>' would provide such
>>> output, or its equivalent (tree blame).
>> 
>> That'd be cool.
> 
> I am currently working on prototype in Perl, using 'git cat-file --batch'
> and 'git diff-tree --stdin', as I don't know git C code/API enought to
> write it in C; it is planned to be converted to C after proof of concept
> works.

And it even works[1]... but only for a top directory, because of bug in
--relative=<path> implementation for --raw / git-diff-tree output, see
http://permalink.gmane.org/gmane.comp.version-control.git/150248

[1] But I have not tested it very extensively.
[2] It is also missing some features.

-- 
Jakub Narebski
Poland

--Boundary-00=_TuaMM8yV2oHq2gU
Content-Type: text/plain;
  charset="utf-8";
  name="tree_blame_PoC_test.perl"
Content-Transfer-Encoding: 8bit
Content-Description: "git blame <directory>" proof of concept in Perl
Content-Disposition: inline;
	filename="tree_blame_PoC_test.perl"

#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

use Encode;
use Fcntl ':mode';
use List::Compare::Functional qw(:originals);
use List::MoreUtils qw(uniq pairwise);

use constant DEBUG => 0;

# ----------------------------------------------------------------------
{
package Git::Repo;

use strict;
use warnings;

use IPC::Open2 qw(open2);
use IO::Handle;

use base qw(Exporter);

our @EXPORT = qw();
our @EXPORT_OK = qw();

# Auxiliary subroutines

sub _assert_opts {
	die "must have an even number of arguments for named options"
		unless $#_ % 2;
}

sub _assert_sha1 {
	my $sha1 = shift;
	die "'$sha1' is not a SHA1 (need to use get_sha1?)"
		unless $sha1 && $sha1 =~ /^[a-f0-9]{40}$/;
}

sub new {
	my $class = shift;
	_assert_opts @_;
	my $self = {@_};
	bless $self, $class;
	die 'no repo_dir given' unless $self->{repo_dir};
	return $self;
}

# Return the first items of the git command line, for instance
# qw(/usr/bin/git --git-dir=/path/to/repo.git).
sub _git_cmd {
	my $self = shift;
	return ($self->{git_binary} || 'git', '--git-dir=' . $self->{repo_dir});
}

sub get_sha1 {
	my ($self, $object_id) = @_;

	die 'no object identifier given' unless $object_id;
	die 'object identifier must not contain newlines' if $object_id =~ /\n/;

	unless ($self->{sha1_stdout}) {
		# Open bidi pipe the first time get_sha1 is called.
		# open2 raises an exception on error, no need to 'or die'.
		$self->{sha1_pid} =
			open2($self->{sha1_stdout}, $self->{sha1_stdin},
			      $self->_git_cmd, 'cat-file', '--batch-check');
	}
	$self->{sha1_stdin}->printflush("$object_id\n")
		or die "cannot write to pipe: $!";
	my $output = $self->{sha1_stdout}->getline()
		or die "cannot read from pipe: $!";
	chomp $output;
	return if $output =~ /missing$/;
	my ($sha1, $type, $size) =
		($output =~ /^([0-9a-f]{40}) ([a-z]+) ([0-9]+)$/)
		or die "invalid response: $output";
	return wantarray ? ($sha1, $type, $size) : $sha1;
}


sub get_object {
	my ($self, $object_id) = @_;

	unless ($self->{object_stdout}) {
		# Open bidi pipe the first time get_object is called.
		# open2 raises an exception on error, no need to 'or die'.
		$self->{object_pid} =
			open2($self->{object_stdout}, $self->{object_stdin},
			      $self->_git_cmd, 'cat-file', '--batch');
	}
	$self->{object_stdin}->printflush("$object_id\n")
		or die "get_object: cannot write to pipe: $!";
	my ($sha1, $type, $size) =
		split ' ', $self->{object_stdout}->getline()
		or die "get_object: cannot read from pipe: $!";
	die "'$object_id' not found in repository"
		if $type eq 'missing';
	$self->{object_stdout}->read(my $content, $size);
	$self->{object_stdout}->getline();  # eat trailing newline
	return wantarray ? ($sha1, $type, $size, $content) : $content;
}

sub get_commit_difftree {
	my ($self, $commit_id, $parent_id, $path) = @_;

	unless ($self->{difftree_stdout}) {
		# Open bidi pipe the first time get_object is called.
		# open2 raises an exception on error, no need to 'or die'.
		$self->{difftree_pid} =
			open2($self->{difftree_stdout}, $self->{difftree_stdin},
			      $self->_git_cmd, 'diff-tree', '--stdin', '--raw', '--no-commit-id',
			                       '--root', '--no-renames',
			#                       defined $path ? ('--', $path) : ());
			                       defined $path ? ("--relative=$path") : ());
	}
	# the additional LF ("\n") is to able to detect end of difftree
	$self->{difftree_stdin}->printflush("$commit_id $parent_id\n\n")
		or die "get_commit_difftree: cannot write to pipe: $!";

	my @difftree_lines;
	while (my $line = $self->{difftree_stdout}->getline()) {
		chomp $line;
		last unless $line;

		push @difftree_lines, $line;
	}
	return wantarray ? @difftree_lines : \@difftree_lines;
}


sub DESTROY {
	my $self = shift;

	if (exists $self->{object_stdout}) {
		close $self->{object_stdout}
			or die "Closing stdout of git-cat-file --batch failed: $!";
	}
	if (exists $self->{object_stdin}) {
		close $self->{object_stdin}
			or die "Closing stdin of git-cat-file --batch  failed: $!";
	}
	if (exists $self->{object_pid}) {
		waitpid $self->{object_pid}, 0
			or die "Waiting for pid=$self->{object_pid} failed: $!";
	}

	if (exists $self->{sha1_stdout}) {
		close $self->{sha1_stdout}
			or die "Closing stdout of git-cat-file --batch-check failed: $!";
	}
	if (exists $self->{sha1_stdin}) {
		close $self->{sha1_stdin}
			or die "Closing stdin of git-cat-file --batch-check failed: $!";
	}
	if (exists $self->{sha1_pid}) {
		waitpid $self->{sha1_pid}, 0
			or die "Waiting for pid=$self->{sha1_pid} failed: $!";
	}

	if (exists $self->{difftree_stdout}) {
		close $self->{difftree_stdout}
			or die "Closing stdout of git-cat-file --batch-check failed: $!";
	}
	if (exists $self->{difftree_stdin}) {
		close $self->{difftree_stdin}
			or die "Closing stdin of git-cat-file --batch-check failed: $!";
	}
	if (exists $self->{difftree_pid}) {
		waitpid $self->{difftree_pid}, 0
			or die "Waiting for pid=$self->{difftree_pid} failed: $!";
	}
}

} # end package Git::Repo;

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

sub set_signals {
	my $pid = shift;

	$SIG{'PIPE'} = 'IGNORE';
	$SIG{'CHLD'} = 'IGNORE';

	$SIG{'CHLD'} = sub {
		print "REAPER: status $? on $pid\n" 
			if waitpid($pid, 0) > 0;
	};
}

sub cat_file_gitrepo {
	my ($repo, $object_name) = @_;

	my ($ret_sha1, $type, $size, $content) =
		$repo->get_object($object_name);
	return wantarray ? ("$ret_sha1 $type $size", $content) : $content;
}

# ----------------------------------------------------------------------

my $fallback_encoding = 'latin1';
# decode sequences of octets in utf8 into Perl's internal form,
# which is utf-8 with utf8 flag set if needed.  gitweb writes out
# in utf-8 thanks to "binmode STDOUT, ':utf8'" at beginning
sub to_utf8 {
	my $str = shift;
	if (utf8::valid($str)) {
		utf8::decode($str);
		return $str;
	} else {
		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
	}
}

sub parse_commit {
	my ($commit_text) = @_;
	my @commit_lines = split '\n', $commit_text;
	my %co;

	if (! @commit_lines) {
		return;
	}

	my @parents;
 HEADER:
	while (my $line = shift @commit_lines) {
		last if $line eq "\n";
		if ($line =~ m/^tree ([0-9a-fA-F]{40})$/) {
			$co{'tree'} = $1;
		} elsif ($line =~ m/^parent ([0-9a-fA-F]{40})$/) {
			push @parents, $1;
		} elsif ($line =~ m/^author (.*) ([0-9]+) (.*)$/) {
			$co{'author'} = to_utf8($1);
			$co{'author_epoch'} = $2;
			$co{'author_tz'} = $3;
			if ($co{'author'} =~ m/^([^<]+) <([^>]*)>/) {
				$co{'author_name'}  = $1;
				$co{'author_email'} = $2;
			} else {
				$co{'author_name'} = $co{'author'};
			}
		} elsif ($line =~ m/^committer (.*) ([0-9]+) (.*)$/) {
			$co{'committer'} = to_utf8($1);
			$co{'committer_epoch'} = $2;
			$co{'committer_tz'} = $3;
			if ($co{'committer'} =~ m/^([^<]+) <([^>]*)>/) {
				$co{'committer_name'}  = $1;
				$co{'committer_email'} = $2;
			} else {
				$co{'committer_name'} = $co{'committer'};
			}
		}
	}
	if (!defined $co{'tree'}) {
		return;
	};
	$co{'parents'} = \@parents;
	$co{'parent'}  =  $parents[0];

	$co{'comment'} = \@commit_lines;

	return wantarray ? %co : \%co;
}

sub unquote { return $_[0] }

# parse line of git-ls-tree output
sub parse_ls_tree_line {
	my $line = shift;
	my %opts = @_;
	my %res;

	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/s;

	$res{'mode'} = $1;
	$res{'type'} = $2;
	$res{'hash'} = $3;
	if ($opts{'-z'}) {
		$res{'name'} = $4;
	} else {
		$res{'name'} = unquote($4);
	}

	return wantarray ? %res : \%res;
}

# parse line of git-diff-tree "raw" output
sub parse_difftree_raw_line {
	my $line = shift;
	my %res;

	# ':100644 100644 03b218260e99b78c6df0ed378e59ed9205ccc96d 3b93d5e7cc7f7dd4ebed13a5cc1a4ad976fc94d8 M	ls-files.c'
	# ':100644 100644 7f9281985086971d3877aca27704f2aaf9c448ce bc190ebc71bbd923f2b728e505408f5e54bd073a M	rev-tree.c'
	if ($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/) {
		$res{'from_mode'} = $1;
		$res{'to_mode'} = $2;
		$res{'from_id'} = $3;
		$res{'to_id'} = $4;
		$res{'status'} = $5;
		$res{'similarity'} = $6;
		if ($res{'status'} eq 'R' || $res{'status'} eq 'C') { # renamed or copied
			($res{'from_file'}, $res{'to_file'}) = map { unquote($_) } split("\t", $7);
		} else {
			$res{'from_file'} = $res{'to_file'} = $res{'file'} = unquote($7);
		}
	}
	# '::100755 100755 100755 60e79ca1b01bc8b057abe17ddab484699a7f5fdb 94067cc5f73388f33722d52ae02f44692bc07490 94067cc5f73388f33722d52ae02f44692bc07490 MR	git-gui/git-gui.sh'
	# combined diff (for merge commit)
	elsif ($line =~ s/^(::+)((?:[0-7]{6} )+)((?:[0-9a-fA-F]{40} )+)([a-zA-Z]+)\t(.*)$//) {
		$res{'nparents'}  = length($1);
		$res{'from_mode'} = [ split(' ', $2) ];
		$res{'to_mode'} = pop @{$res{'from_mode'}};
		$res{'from_id'} = [ split(' ', $3) ];
		$res{'to_id'} = pop @{$res{'from_id'}};
		$res{'status'} = [ split('', $4) ];
		$res{'to_file'} = unquote($5);
	}
	# 'c512b523472485aef4fff9e57b229d9d243c967f'
	elsif ($line =~ m/^([0-9a-fA-F]{40})$/) {
		$res{'commit'} = $1;
	}

	return wantarray ? %res : \%res;
}

# ......................................................................

# parse one entry of raw 'tree' object output (from 'git cat-file --batch')
sub decode_tree_entry {
	my $buf = shift;
	#use bytes;

	$buf =~ s/^([0-7]+) //;
	my ($mode_str) = $1;
	my ($filename, $sha1_str) = unpack('Z*H[40]', $buf);

	return ($mode_str, $filename, $sha1_str);
}

sub tree_entry_len {
	my ($mode_str, $filename) = @_;
	#use bytes;

	# length of mode string + separator + 20 bytes of SHA-1
	# + length of filename (in bytes) + terminating NUL ('\0')
	length($mode_str)+1 + length($filename)+1 + 20;
}

use constant {
	S_IFINVALID => 0030000,
	S_IFGITLINK => 0160000,
};

# submodule/subproject, a commit object reference
sub S_ISGITLINK {
	my $mode = shift;

	return (($mode & S_IFMT) == S_IFGITLINK)
}

sub type_from_mode {
	my $mode = oct shift;

	if (S_ISGITLINK($mode)) {
		return "commit";
	} elsif (S_ISDIR($mode & S_IFMT)) {
		return "tree";
	}
		return "blob";
}

# ......................................................................

sub decode_tree {
	my $contents = shift;
	#use bytes;

	my @result;

	while (my @entry = decode_tree_entry($contents)) {
		#print join(' ', @entry)."\n";
		#printf("%06d %s\t%s\n", $entry[0], $entry[2], $entry[1]);

		push @result,
			{ 'mode' => $entry[0],
			  'type' => type_from_mode($entry[0]),
			  'name' => $entry[1],
			  'hash' => $entry[2] };

		my $len = tree_entry_len(@entry);
		#print substr($contents, 0, $len)."\n";
		$contents = substr($contents, $len);
		last unless $contents;
	}

	return wantarray ? @result : \@result;
}

sub tree_entry_eq {
	my ($a, $b) = @_;

	return
		$a->{'mode'} == $b->{'mode'} &&
		$a->{'type'} eq $b->{'type'} &&
		$a->{'name'} eq $b->{'name'} &&
		$a->{'hash'} eq $b->{'hash'};
}

# ......................................................................

sub print_parsed_tree {
	my $tree = shift;

	foreach my $tree_entry (@$tree) {
		print format_tree_entry($tree_entry)."\n";
	}
}

sub print_tree_blame {
	my ($tree, $tree_blame) = @_;

	foreach my $tree_entry (@$tree) {
		#print format_tree_blame_entry($tree_blame->{$tree_entry->{'hash'}})."\n";
		print format_tree_blame_entry($tree_entry)."\n";
	}
}

sub format_tree_entry {
	my $tree_entry = shift;

	return sprintf("%06d %s %s\t%s",
		$tree_entry->{'mode'}, $tree_entry->{'type'},
		$tree_entry->{'hash'}, $tree_entry->{'name'});
}

sub format_tree_blame_entry {
	my $tree_entry = shift;

	#my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday)
	#	= gmtime($tree_entry->{'author_epoch'});
	#return sprintf("%06d %s %.8s %.8s %.15s %02d-%02d-%04d\t%s",
	#	$tree_entry->{'mode'}, $tree_entry->{'type'},
	#	$tree_entry->{'hash'}, $tree_entry->{'commit'},
	#	$tree_entry->{'author_name'}, $mday, $mon, 1900 + $year,
	#	$tree_entry->{'name'});
	return sprintf("%06d %s %.8s %.8s\t%.10s\t%s",
		$tree_entry->{'mode'}, $tree_entry->{'type'},
		$tree_entry->{'hash'}, $tree_entry->{'commit'},
		$tree_entry->{'name'}, $tree_entry->{'summary'});
}

# ======================================================================

sub tree_blame_commit {
	my ($repo, $commit_id, $tree_blame, $path) = @_;

	my ($commit_sha1, undef, undef, $commit_text) =
		$repo->get_object($commit_id);
	my %commit = parse_commit($commit_text);

	my $nunblamed = scalar grep { !exists $_->{'commit'} } @$tree_blame;
	printf("processing %6s (%1d parents, %d unblamed): %s\n",
	       substr($commit_sha1,0,6), scalar @{$commit{'parents'}},
	       $nunblamed, $commit{'comment'}[0])
		if DEBUG >= 1;
	print Dumper($tree_blame)
		if DEBUG >= 2;
	return unless $nunblamed > 0;

	foreach my $parent (@{$commit{'parents'}}) {
		my @difftree = $repo->get_commit_difftree($commit_sha1, $parent, $path);
		@difftree = map { { parse_difftree_raw_line($_) } } @difftree;

		printf("processing %6s: parent %6s has %d in difftree\n",
		       substr($commit_sha1,0,6), substr($parent,0,6),
		       scalar @difftree)
			if DEBUG >= 1;

		no warnings 'recursion';

		# mark entries from @difftree
		#mark_changed($tree_blame, \@difftree, [ $commit_sha1 ]);
		mark_changed($tree_blame, \@difftree, \$commit_sha1);
		# pass blame to parent
		tree_blame_commit($repo, $parent, $tree_blame, $path);
		# remove marks
		#remove_marks($tree_blame, [ $commit_sha1 ]);
		remove_marks($tree_blame, \$commit_sha1);
	}

	my $nblames_this = 0;
	foreach my $tree_entry (@$tree_blame) {
		if (!exists $tree_entry->{'commit'}) {
			$tree_entry->{'commit'}  = $commit_sha1;
			$tree_entry->{'summary'} = $commit{'comment'}[0];
			$tree_entry->{'author_name'} = $commit{'author_name'};
			if ($commit{'author_email'} &&
			    $commit{'author_email'} =~ /^([^@]+)@/) {
				$tree_entry->{'author_user'} = $1;
			}
			$tree_entry->{'author_epoch'} = $commit{'author_epoch'};

			my @difftree = $repo->get_commit_difftree($commit_sha1, '-m', $path);
			@difftree = map { { parse_difftree_raw_line($_) } } @difftree;
			$tree_entry->{'difftree'} =
				[ grep { $_->{'to_id'} eq $tree_entry->{'hash'} } @difftree ];

			$nblames_this++;
		}
	}

	printf("done %6s (got blamed by %1d, %d unblamed left)\n",
	       substr($commit_sha1,0,6), $nblames_this,
	       scalar grep { !exists $_->{'commit'} } @$tree_blame)
		if DEBUG >= 1;
}

sub mark_changed {
	my ($tree_blame, $difftree, $value) = @_;

	my @blame_sha1    = map { $_->{'hash'} }  @$tree_blame;
	my @difftree_sha1 = map { $_->{'to_id'} } @$difftree;
	# not optimized: both @$tree_blame and @$difftree are sorted by filename
	my @common_sha1 = get_intersection('--unsorted', [ \@blame_sha1, \@difftree_sha1 ]);

	my %tree_blame = map { $_->{'hash'} => $_ } @$tree_blame;
	map { $_->{'commit'} = $value unless exists $_->{'commit'} }
		@tree_blame{@common_sha1};
	@$tree_blame = values %tree_blame;

	return @$tree_blame;
}

sub remove_marks {
	my ($tree_blame, $value) = @_;

	map { 
		delete($_->{'commit'})
			#if (ref($_->{'commit'}) && ($_->{'commit'}->[0] eq $value->[0]))
			if (ref($_->{'commit'}) && (${$_->{'commit'}} eq $$value))
	}	@$tree_blame;

	return @$tree_blame;
}

# ======================================================================
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ----------------------------------------------------------------------
# MAIN

my $git_dir = "/home/jnareb/git/gitweb/test/.git";
#my $tree_path    = "sub";
my $tree_path    = "";
my $start_commit = "HEAD";

#my $git_dir = "/home/jnareb/git/.git";
#my $tree_path = "contrib";
#my $start_commit = "HEAD";
#my $tree_path    = '';
#my $start_commit = "todo";

my $repo = Git::Repo->new(repo_dir=>$git_dir);

my ($sha1, $type, $size, $obj_data) =
	$repo->get_object("$start_commit:$tree_path");
my @tree_blame = decode_tree($obj_data);

tree_blame_commit($repo, $start_commit, \@tree_blame, $tree_path);

print Dumper(\@tree_blame)
	if DEBUG >= 2;

print_tree_blame(\@tree_blame)
	if DEBUG < 2;

#print Dumper(\@tree_blame);
#print Dumper($tree_blame[0]);

__END__
# ----------------------------------------------------------------------
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ======================================================================

#http://git.or.cz/gitwiki/ExampleScripts#Findingwhichcommitslasttouchedthefiles
#http://gist.github.com/247395

my %attributions = ();
my @files = ();

open IN, "git ls-tree -r --full-name HEAD |" or die;
while (<IN>) {
	if (/^\S+\s+blob \S+\s+(\S+)$/) {
		$files[$#files + 1] = $1;
		$attributions{$1} = -1;
	}
}
close IN;

my $remaining = $#files + 1;

open IN, "git log -r --root --raw --no-abbrev --pretty=format:%h~%an~%ad~ |" or die;
while (<IN>) {
	if (/^([^:~]+)~(.*)~([^~]+)~$/) {
		($commit, $author, $date) = ($1, $2, $3);
	} elsif (/^:\S+\s+1\S+\s+\S+\s+\S+\s+\S\s+(.*)$/) {
		if ($attributions{$1} == -1) {
			$attributions{$1} = "$author, $date ($commit)";
			$remaining--;
			if ($remaining <= 0) {
				break;
			}
		}
	}
}
close IN;

for $f (@files) {
	print "$f	$attributions{$f}\n";
}

--Boundary-00=_TuaMM8yV2oHq2gU--
