From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib: remove continuous/ and patches/
Date: Sun, 02 Jun 2013 15:42:19 -0700
Message-ID: <7v61xwm8xg.fsf@alter.siamese.dyndns.org>
References: <1370204047-25582-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 00:42:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjGyq-0005He-6X
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 00:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181Ab3FBWmY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Jun 2013 18:42:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49920 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754841Ab3FBWmX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jun 2013 18:42:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 825FF24BD4;
	Sun,  2 Jun 2013 22:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=U1FIdO4schVp
	ZPHXIYlpVBtLWjg=; b=B/+cJY+wGe+jw7rIEgBwAr/zBVUnP3NjB3+ZdPVrUlCC
	H5X1y51guxamL8M/oskwYbUUTjEn38WEISfbJLqMVYDnN62MTM6UQeKr8oRSthV9
	bRoxEsQ1QBFxX8pKBIr1ifszbxqMn5zuCFIGM+/PxUYTZ0FDycKhHTwF8z7EogU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=u6uEDD
	tFuCXnrtJsDjhMlv+rWyFXd5qX2D3ZCbt0S5Q8Pttcxymo6VNzffV90LYjLHnE1W
	B99v3Tkb2VOOxRpnPBvmBaGHU5oREXCq+KMBe6ZXFKMb4GkLGAJbqYr1V1wIHhXy
	4jN0BFsc5sqjyals0Tizf2SBGubHmXJpB0RT0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7193324BD3;
	Sun,  2 Jun 2013 22:42:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2506124BCF;
	Sun,  2 Jun 2013 22:42:21 +0000 (UTC)
In-Reply-To: <1370204047-25582-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Mon, 3 Jun 2013 01:44:07 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AFBFFFA6-CBD5-11E2-9977-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226189>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> They haven't been touched in six years.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Another candidates for removal: contrib/blameview (6 years); anoyone
>  using this?

This is in line with contrib/README "removal of disused and inactive
ones", I think.  If somebody is using the continuous stuff happily,
please raise your hand.

xsl-manpages patch is against 1.73.0 and it seems at least 1.75.1
(2009) has read-character-map so I do not think anybody would get
hurt.

I'll queue the removal on 'pu' and advance it to 'next' to see if
anybody screams.  Back when Git was young and exotic, it made sense
to have third-party tools in our tree to give them more visibility
and convenience to download, but now the Git ecosystem is mature
enough (with easy to use hosting site that makes it easy for users
and developers to meet) that the third-party tools should have lives
of their own, even the ones that are only relevant in the context of
using Git (like blameview that was suggested for removal).

Thanks.

>  contrib/continuous/cidaemon                        | 503 -----------=
----------
>  contrib/continuous/post-receive-cinotify           | 104 -----
>  contrib/patches/docbook-xsl-manpages-charmap.patch |  21 -
>  3 files changed, 628 deletions(-)
>  delete mode 100644 contrib/continuous/cidaemon
>  delete mode 100644 contrib/continuous/post-receive-cinotify
>  delete mode 100644 contrib/patches/docbook-xsl-manpages-charmap.patc=
h
>
> diff --git a/contrib/continuous/cidaemon b/contrib/continuous/cidaemo=
n
> deleted file mode 100644
> index 4009a15..0000000
> --- a/contrib/continuous/cidaemon
> +++ /dev/null
> @@ -1,503 +0,0 @@
> -#!/usr/bin/perl
> -#
> -# A daemon that waits for update events sent by its companion
> -# post-receive-cinotify hook, checks out a new copy of source,
> -# compiles it, and emails the guilty parties if the compile
> -# (and optionally test suite) fails.
> -#
> -# To use this daemon, configure it and run it.  It will disconnect
> -# from your terminal and fork into the background.  The daemon must
> -# have local filesystem access to the source repositories, as it
> -# uses objects/info/alternates to avoid copying objects.
> -#
> -# Add its companion post-receive-cinotify hook as the post-receive
> -# hook to each repository that the daemon should monitor.  Yes, a
> -# single daemon can monitor more than one repository.
> -#
> -# To use multiple daemons on the same system, give them each a
> -# unique queue file and tmpdir.
> -#
> -# Global Config
> -# -------------
> -# Reads from a Git style configuration file.  This will be
> -# ~/.gitconfig by default but can be overridden by setting
> -# the GIT_CONFIG_FILE environment variable before starting.
> -#
> -# cidaemon.smtpHost
> -#   Hostname of the SMTP server the daemon will send email
> -#   through.  Defaults to 'localhost'.
> -#
> -# cidaemon.smtpUser
> -#   Username to authenticate to the SMTP server as.  This
> -#   variable is optional; if it is not supplied then no
> -#   authentication will be performed.
> -#
> -# cidaemon.smtpPassword
> -#   Password to authenticate to the SMTP server as.  This
> -#   variable is optional.  If not supplied but smtpUser was,
> -#   the daemon prompts for the password before forking into
> -#   the background.
> -#
> -# cidaemon.smtpAuth
> -#   Type of authentication to perform with the SMTP server.
> -#   If set to 'login' and smtpUser was defined, this will
> -#   use the AUTH LOGIN command, which is suitable for use
> -#   with at least one version of Microsoft Exchange Server.
> -#   If not set the daemon will use whatever auth methods
> -#   are supported by your version of Net::SMTP.
> -#
> -# cidaemon.email
> -#   Email address that daemon generated emails will be sent
> -#   from.  This should be a useful email address within your
> -#   organization.  Required.
> -#
> -# cidaemon.name
> -#   Human friendly name that the daemon will send emails as.
> -#   Defaults to 'cidaemon'.
> -#
> -# cidaemon.scanDelay
> -#   Number of seconds to sleep between polls of the queue file.
> -#   Defaults to 60.
> -#
> -# cidaemon.recentCache
> -#   Number of recent commit SHA-1s per repository to cache and
> -#   skip building if they appear again.  This is useful to avoid
> -#   rebuilding the same commit multiple times just because it was
> -#   pushed into more than one branch.  Defaults to 100.
> -#
> -# cidaemon.tmpdir
> -#   Scratch directory to create the builds within.  The daemon
> -#   makes a new subdirectory for each build, then deletes it when
> -#   the build has finished.  The pid file is also placed here.
> -#   Defaults to '/tmp'.
> -#
> -# cidaemon.queue
> -#   Path to the queue file that the post-receive-cinotify hook
> -#   appends events to.  This file is polled by the daemon.  It
> -#   must not be on an NFS mount (uses flock).  Required.
> -#
> -# cidaemon.nocc
> -#   Perl regex patterns to match against author and committer
> -#   lines.  If a pattern matches, that author or committer will
> -#   not be notified of a build failure.
> -#
> -# Per Repository Config
> -# ----------------------
> -# Read from the source repository's config file.
> -#
> -# builder.command
> -#   Shell command to execute the build.  This command must
> -#   return 0 on "success" and non-zero on failure.  If you
> -#   also want to run a test suite, make sure your command
> -#   does that too.  Required.
> -#
> -# builder.queue
> -#   Queue file to notify the cidaemon through.  Should match
> -#   cidaemon.queue.  If not set the hook will not notify the
> -#   cidaemon.
> -#
> -# builder.skip
> -#   Perl regex patterns of refs that should not be sent to
> -#   cidaemon.  Updates of these refs will be ignored.
> -#
> -# builder.newBranchBase
> -#   Glob patterns of refs that should be used to form the
> -#   'old' revions of a newly created ref.  This should set
> -#   to be globs that match your 'mainline' branches.  This
> -#   way a build failure of a brand new topic branch does not
> -#   attempt to email everyone since the beginning of time;
> -#   instead it only emails those authors of commits not in
> -#   these 'mainline' branches.
> -
> -local $ENV{PATH} =3D join ':', qw(
> -	/opt/git/bin
> -	/usr/bin
> -	/bin
> -	);
> -
> -use strict;
> -use warnings;
> -use FindBin qw($RealBin);
> -use File::Spec;
> -use lib File::Spec->catfile($RealBin, '..', 'perl5');
> -use Storable qw(retrieve nstore);
> -use Fcntl ':flock';
> -use POSIX qw(strftime);
> -use Getopt::Long qw(:config no_auto_abbrev auto_help);
> -
> -sub git_config ($;$)
> -{
> -	my $var =3D shift;
> -	my $required =3D shift || 0;
> -	local *GIT;
> -	open GIT, '-|','git','config','--get',$var;
> -	my $r =3D <GIT>;
> -	chop $r if $r;
> -	close GIT;
> -	die "error: $var not set.\n" if ($required && !$r);
> -	return $r;
> -}
> -
> -package EXCHANGE_NET_SMTP;
> -
> -# Microsoft Exchange Server requires an 'AUTH LOGIN'
> -# style of authentication.  This is different from
> -# the default supported by Net::SMTP so we subclass
> -# and override the auth method to support that.
> -
> -use Net::SMTP;
> -use Net::Cmd;
> -use MIME::Base64 qw(encode_base64);
> -our @ISA =3D qw(Net::SMTP);
> -our $auth_type =3D ::git_config 'cidaemon.smtpAuth';
> -
> -sub new
> -{
> -	my $self =3D shift;
> -	my $type =3D ref($self) || $self;
> -	$type->SUPER::new(@_);
> -}
> -
> -sub auth
> -{
> -	my $self =3D shift;
> -	return $self->SUPER::auth(@_) unless $auth_type eq 'login';
> -
> -	my $user =3D encode_base64 shift, '';
> -	my $pass =3D encode_base64 shift, '';
> -	return 0 unless CMD_MORE =3D=3D $self->command("AUTH LOGIN")->respo=
nse;
> -	return 0 unless CMD_MORE =3D=3D $self->command($user)->response;
> -	CMD_OK =3D=3D $self->command($pass)->response;
> -}
> -
> -package main;
> -
> -my ($debug_flag, %recent);
> -
> -my $ex_host =3D git_config('cidaemon.smtpHost') || 'localhost';
> -my $ex_user =3D git_config('cidaemon.smtpUser');
> -my $ex_pass =3D git_config('cidaemon.smtpPassword');
> -
> -my $ex_from_addr =3D git_config('cidaemon.email', 1);
> -my $ex_from_name =3D git_config('cidaemon.name') || 'cidaemon';
> -
> -my $scan_delay =3D git_config('cidaemon.scanDelay') || 60;
> -my $recent_size =3D git_config('cidaemon.recentCache') || 100;
> -my $tmpdir =3D git_config('cidaemon.tmpdir') || '/tmp';
> -my $queue_name =3D git_config('cidaemon.queue', 1);
> -my $queue_lock =3D "$queue_name.lock";
> -
> -my @nocc_list;
> -open GIT,'git config --get-all cidaemon.nocc|';
> -while (<GIT>) {
> -	chop;
> -	push @nocc_list, $_;
> -}
> -close GIT;
> -
> -sub nocc_author ($)
> -{
> -	local $_ =3D shift;
> -	foreach my $pat (@nocc_list) {
> -		return 1 if /$pat/;
> -	}
> -	0;
> -}
> -
> -sub input_echo ($)
> -{
> -	my $prompt =3D shift;
> -
> -	local $| =3D 1;
> -	print $prompt;
> -	my $input =3D <STDIN>;
> -	chop $input;
> -	return $input;
> -}
> -
> -sub input_noecho ($)
> -{
> -	my $prompt =3D shift;
> -
> -	my $end =3D sub {system('stty','echo');print "\n";exit};
> -	local $SIG{TERM} =3D $end;
> -	local $SIG{INT} =3D $end;
> -	system('stty','-echo');
> -
> -	local $| =3D 1;
> -	print $prompt;
> -	my $input =3D <STDIN>;
> -	system('stty','echo');
> -	print "\n";
> -	chop $input;
> -	return $input;
> -}
> -
> -sub rfc2822_date ()
> -{
> -	 strftime("%a, %d %b %Y %H:%M:%S %Z", localtime);
> -}
> -
> -sub send_email ($$$)
> -{
> -	my ($subj, $body, $to) =3D @_;
> -	my $now =3D rfc2822_date;
> -	my $to_str =3D '';
> -	my @rcpt_to;
> -	foreach (@$to) {
> -		my $s =3D $_;
> -		$s =3D~ s/^/"/;
> -		$s =3D~ s/(\s+<)/"$1/;
> -		$to_str .=3D ', ' if $to_str;
> -		$to_str .=3D $s;
> -		push @rcpt_to, $1 if $s =3D~ /<(.*)>/;
> -	}
> -	die "Nobody to send to.\n" unless @rcpt_to;
> -	my $msg =3D <<EOF;
> -From: "$ex_from_name" <$ex_from_addr>
> -To: $to_str
> -Date: $now
> -Subject: $subj
> -
> -$body
> -EOF
> -
> -	my $smtp =3D EXCHANGE_NET_SMTP->new(Host =3D> $ex_host)
> -		or die "Cannot connect to $ex_host: $!\n";
> -	if ($ex_user && $ex_pass) {
> -		$smtp->auth($ex_user,$ex_pass)
> -			or die "$ex_host rejected $ex_user\n";
> -	}
> -	$smtp->mail($ex_from_addr)
> -		or die "$ex_host rejected $ex_from_addr\n";
> -	scalar($smtp->recipient(@rcpt_to, { SkipBad =3D> 1 }))
> -		or die "$ex_host did not accept any addresses.\n";
> -	$smtp->data($msg)
> -		or die "$ex_host rejected message data\n";
> -	$smtp->quit;
> -}
> -
> -sub pop_queue ()
> -{
> -	open LOCK, ">$queue_lock" or die "Can't open $queue_lock: $!";
> -	flock LOCK, LOCK_EX;
> -
> -	my $queue =3D -f $queue_name ? retrieve $queue_name : [];
> -	my $ent =3D shift @$queue;
> -	nstore $queue, $queue_name;
> -
> -	flock LOCK, LOCK_UN;
> -	close LOCK;
> -	$ent;
> -}
> -
> -sub git_exec (@)
> -{
> -	system('git',@_) =3D=3D 0 or die "Cannot git " . join(' ', @_) . "\=
n";
> -}
> -
> -sub git_val (@)
> -{
> -	open(C, '-|','git',@_);
> -	my $r =3D <C>;
> -	chop $r if $r;
> -	close C;
> -	$r;
> -}
> -
> -sub do_build ($$)
> -{
> -	my ($git_dir, $new) =3D @_;
> -
> -	my $tmp =3D File::Spec->catfile($tmpdir, "builder$$");
> -	system('rm','-rf',$tmp) =3D=3D 0 or die "Cannot clear $tmp\n";
> -	die "Cannot clear $tmp.\n" if -e $tmp;
> -
> -	my $result =3D 1;
> -	eval {
> -		my $command;
> -		{
> -			local $ENV{GIT_DIR} =3D $git_dir;
> -			$command =3D git_val 'config','builder.command';
> -		}
> -		die "No builder.command for $git_dir.\n" unless $command;
> -
> -		git_exec 'clone','-n','-l','-s',$git_dir,$tmp;
> -		chmod 0700, $tmp or die "Cannot lock $tmp\n";
> -		chdir $tmp or die "Cannot enter $tmp\n";
> -
> -		git_exec 'update-ref','HEAD',$new;
> -		git_exec 'read-tree','-m','-u','HEAD','HEAD';
> -		system $command;
> -		if ($? =3D=3D -1) {
> -			print STDERR "failed to execute '$command': $!\n";
> -			$result =3D 1;
> -		} elsif ($? & 127) {
> -			my $sig =3D $? & 127;
> -			print STDERR "'$command' died from signal $sig\n";
> -			$result =3D 1;
> -		} else {
> -			my $r =3D $? >> 8;
> -			print STDERR "'$command' exited with $r\n" if $r;
> -			$result =3D $r;
> -		}
> -	};
> -	if ($@) {
> -		$result =3D 2;
> -		print STDERR "$@\n";
> -	}
> -
> -	chdir '/';
> -	system('rm','-rf',$tmp);
> -	rmdir $tmp;
> -	$result;
> -}
> -
> -sub build_failed ($$$$$)
> -{
> -	my ($git_dir, $ref, $old, $new, $msg) =3D @_;
> -
> -	$git_dir =3D~ m,/([^/]+)$,;
> -	my $repo_name =3D $1;
> -	$ref =3D~ s,^refs/(heads|tags)/,,;
> -
> -	my %authors;
> -	my $shortlog;
> -	my $revstr;
> -	{
> -		local $ENV{GIT_DIR} =3D $git_dir;
> -		my @revs =3D ($new);
> -		push @revs, '--not', @$old if @$old;
> -		open LOG,'-|','git','rev-list','--pretty=3Draw',@revs;
> -		while (<LOG>) {
> -			if (s/^(author|committer) //) {
> -				chomp;
> -				s/>.*$/>/;
> -				$authors{$_} =3D 1 unless nocc_author $_;
> -			}
> -		}
> -		close LOG;
> -		open LOG,'-|','git','shortlog',@revs;
> -		$shortlog .=3D $_ while <LOG>;
> -		close LOG;
> -		$revstr =3D join(' ', @revs);
> -	}
> -
> -	my @to =3D sort keys %authors;
> -	unless (@to) {
> -		print STDERR "error: No authors in $revstr\n";
> -		return;
> -	}
> -
> -	my $subject =3D "[$repo_name] $ref : Build Failed";
> -	my $body =3D <<EOF;
> -Project: $git_dir
> -Branch:  $ref
> -Commits: $revstr
> -
> -$shortlog
> -Build Output:
> ---------------------------------------------------------------
> -$msg
> -EOF
> -	send_email($subject, $body, \@to);
> -}
> -
> -sub run_build ($$$$)
> -{
> -	my ($git_dir, $ref, $old, $new) =3D @_;
> -
> -	if ($debug_flag) {
> -		my @revs =3D ($new);
> -		push @revs, '--not', @$old if @$old;
> -		print "BUILDING $git_dir\n";
> -		print "  BRANCH: $ref\n";
> -		print "  COMMITS: ", join(' ', @revs), "\n";
> -	}
> -
> -	local(*R, *W);
> -	pipe R, W or die "cannot pipe builder: $!";
> -
> -	my $builder =3D fork();
> -	if (!defined $builder) {
> -		die "cannot fork builder: $!";
> -	} elsif (0 =3D=3D $builder) {
> -		close R;
> -		close STDIN;open(STDIN, '/dev/null');
> -		open(STDOUT, '>&W');
> -		open(STDERR, '>&W');
> -		exit do_build $git_dir, $new;
> -	} else {
> -		close W;
> -		my $out =3D '';
> -		$out .=3D $_ while <R>;
> -		close R;
> -		waitpid $builder, 0;
> -		build_failed $git_dir, $ref, $old, $new, $out if $?;
> -	}
> -
> -	print "DONE\n\n" if $debug_flag;
> -}
> -
> -sub daemon_loop ()
> -{
> -	my $run =3D 1;
> -	my $stop_sub =3D sub {$run =3D 0};
> -	$SIG{HUP} =3D $stop_sub;
> -	$SIG{INT} =3D $stop_sub;
> -	$SIG{TERM} =3D $stop_sub;
> -
> -	mkdir $tmpdir, 0755;
> -	my $pidfile =3D File::Spec->catfile($tmpdir, "cidaemon.pid");
> -	open(O, ">$pidfile"); print O "$$\n"; close O;
> -
> -	while ($run) {
> -		my $ent =3D pop_queue;
> -		if ($ent) {
> -			my ($git_dir, $ref, $old, $new) =3D @$ent;
> -
> -			$ent =3D $recent{$git_dir};
> -			$recent{$git_dir} =3D $ent =3D [[], {}] unless $ent;
> -			my ($rec_arr, $rec_hash) =3D @$ent;
> -			next if $rec_hash->{$new}++;
> -			while (@$rec_arr >=3D $recent_size) {
> -				my $to_kill =3D shift @$rec_arr;
> -				delete $rec_hash->{$to_kill};
> -			}
> -			push @$rec_arr, $new;
> -
> -			run_build $git_dir, $ref, $old, $new;
> -		} else {
> -			sleep $scan_delay;
> -		}
> -	}
> -
> -	unlink $pidfile;
> -}
> -
> -$debug_flag =3D 0;
> -GetOptions(
> -	'debug|d' =3D> \$debug_flag,
> -	'smtp-user=3Ds' =3D> \$ex_user,
> -) or die "usage: $0 [--debug] [--smtp-user=3Duser]\n";
> -
> -$ex_pass =3D input_noecho("$ex_user SMTP password: ")
> -	if ($ex_user && !$ex_pass);
> -
> -if ($debug_flag) {
> -	daemon_loop;
> -	exit 0;
> -}
> -
> -my $daemon =3D fork();
> -if (!defined $daemon) {
> -	die "cannot fork daemon: $!";
> -} elsif (0 =3D=3D $daemon) {
> -	close STDIN;open(STDIN, '/dev/null');
> -	close STDOUT;open(STDOUT, '>/dev/null');
> -	close STDERR;open(STDERR, '>/dev/null');
> -	daemon_loop;
> -	exit 0;
> -} else {
> -	print "Daemon $daemon running in the background.\n";
> -}
> diff --git a/contrib/continuous/post-receive-cinotify b/contrib/conti=
nuous/post-receive-cinotify
> deleted file mode 100644
> index b8f5a60..0000000
> --- a/contrib/continuous/post-receive-cinotify
> +++ /dev/null
> @@ -1,104 +0,0 @@
> -#!/usr/bin/perl
> -#
> -# A hook that notifies its companion cidaemon through a simple
> -# queue file that a ref has been updated via a push (actually
> -# by a receive-pack running on the server).
> -#
> -# See cidaemon for per-repository configuration details.
> -#
> -# To use this hook, add it as the post-receive hook, make it
> -# executable, and set its configuration options.
> -#
> -
> -local $ENV{PATH} =3D '/opt/git/bin';
> -
> -use strict;
> -use warnings;
> -use File::Spec;
> -use Storable qw(retrieve nstore);
> -use Fcntl ':flock';
> -
> -my $git_dir =3D File::Spec->rel2abs($ENV{GIT_DIR});
> -my $queue_name =3D `git config --get builder.queue`;chop $queue_name=
;
> -$queue_name =3D~ m,^([^\s]+)$,; $queue_name =3D $1; # untaint
> -unless ($queue_name) {
> -	1 while <STDIN>;
> -	print STDERR "\nerror: builder.queue not set.  Not enqueing.\n\n";
> -	exit;
> -}
> -my $queue_lock =3D "$queue_name.lock";
> -
> -my @skip;
> -open S, "git config --get-all builder.skip|";
> -while (<S>) {
> -	chop;
> -	push @skip, $_;
> -}
> -close S;
> -
> -my @new_branch_base;
> -open S, "git config --get-all builder.newBranchBase|";
> -while (<S>) {
> -	chop;
> -	push @new_branch_base, $_;
> -}
> -close S;
> -
> -sub skip ($)
> -{
> -	local $_ =3D shift;
> -	foreach my $p (@skip) {
> -		return 1 if /^$p/;
> -	}
> -	0;
> -}
> -
> -open LOCK, ">$queue_lock" or die "Can't open $queue_lock: $!";
> -flock LOCK, LOCK_EX;
> -
> -my $queue =3D -f $queue_name ? retrieve $queue_name : [];
> -my %existing;
> -foreach my $r (@$queue) {
> -	my ($gd, $ref) =3D @$r;
> -	$existing{$gd}{$ref} =3D $r;
> -}
> -
> -my @new_branch_commits;
> -my $loaded_new_branch_commits =3D 0;
> -
> -while (<STDIN>) {
> -	chop;
> -	my ($old, $new, $ref) =3D split / /, $_, 3;
> -
> -	next if $old eq $new;
> -	next if $new =3D~ /^0{40}$/;
> -	next if skip $ref;
> -
> -	my $r =3D $existing{$git_dir}{$ref};
> -	if ($r) {
> -		$r->[3] =3D $new;
> -	} else {
> -		if ($old =3D~ /^0{40}$/) {
> -			if (!$loaded_new_branch_commits && @new_branch_base) {
> -				open M,'-|','git','show-ref',@new_branch_base;
> -				while (<M>) {
> -					($_) =3D split / /, $_;
> -					push @new_branch_commits, $_;
> -				}
> -				close M;
> -				$loaded_new_branch_commits =3D 1;
> -			}
> -			$old =3D [@new_branch_commits];
> -		} else {
> -			$old =3D [$old];
> -		}
> -
> -		$r =3D [$git_dir, $ref, $old, $new];
> -		$existing{$git_dir}{$ref} =3D $r;
> -		push @$queue, $r;
> -	}
> -}
> -nstore $queue, $queue_name;
> -
> -flock LOCK, LOCK_UN;
> -close LOCK;
> diff --git a/contrib/patches/docbook-xsl-manpages-charmap.patch b/con=
trib/patches/docbook-xsl-manpages-charmap.patch
> deleted file mode 100644
> index f2b08b4..0000000
> --- a/contrib/patches/docbook-xsl-manpages-charmap.patch
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -From: Ismail D=C3=B6nmez <ismail@pardus.org.tr>
> -
> -Trying to build the documentation with docbook-xsl 1.73 may result i=
n
> -the following error.  This patch fixes it.
> -
> -$ xmlto -m callouts.xsl man git-add.xml
> -runtime error: file
> -file:///usr/share/sgml/docbook/xsl-stylesheets-1.73.0/manpages/other=
=2Exsl line
> -129 element call-template
> -The called template 'read-character-map' was not found.
> -
> ---- docbook-xsl-1.73.0/manpages/docbook.xsl.manpages-charmap	2007-07=
-23 16:24:23.000000000 +0100
> -+++ docbook-xsl-1.73.0/manpages/docbook.xsl	2007-07-23 16:25:16.0000=
00000 +0100
> -@@ -37,6 +37,7 @@
> -   <xsl:include href=3D"lists.xsl"/>
> -   <xsl:include href=3D"endnotes.xsl"/>
> -   <xsl:include href=3D"table.xsl"/>
> -+  <xsl:include href=3D"../common/charmap.xsl"/>
> -
> -   <!-- * we rename the following just to avoid using params with "m=
an" -->
> -   <!-- * prefixes in the table.xsl stylesheet (because that stylesh=
eet -->
