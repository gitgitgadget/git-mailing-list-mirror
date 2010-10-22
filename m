From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v2 2/3] Documentation: complete config list from other manpages
Date: Fri, 22 Oct 2010 16:31:52 +0200
Message-ID: <201010221631.55580.jnareb@gmail.com>
References: <cover.1287690696.git.trast@student.ethz.ch> <8145782bddf60325909f328337cb76d25c4402cf.1287690696.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 22 16:32:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9IfP-0000AY-8I
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 16:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757200Ab0JVOcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 10:32:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38585 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169Ab0JVOcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 10:32:16 -0400
Received: by fxm16 with SMTP id 16so691773fxm.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 07:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=l85WuToOZOm8Ra3NFiKDCyxjNfY+4pDpYWv0ZNMdDqg=;
        b=k6J4Rov/D/BUodhjCTw8cQ7YdOvwJs+aY3XunMHHXHRLjSuTFX/04BkK/fZfiTjauw
         3CIEArj76NIXEHPS5MJdvSHAy5N3AznD/UyYrtK8jGrcrC6qsqiQthOEyHojkkpXGnQl
         EPfdxlyGxOv1juLlQkjv3LfOrivqVxYX1fl6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jYkZJhlG5EPU3OXdA4AouhRBEI3CB/1qULKMd20WjAFAIq0JAOLIkhaPf1pvR43+M/
         NY9RREubM56Rgf6oX5zL5dxKLOhtJ/6DfohXJmH9YrohTsa7F/9ZrRYBnnLte9nnW9DC
         1QfXzbW4Fqnll1hyOJTpjkR7bLyUznJ29aWX4=
Received: by 10.204.120.194 with SMTP id e2mr1997482bkr.200.1287757934658;
        Fri, 22 Oct 2010 07:32:14 -0700 (PDT)
Received: from [192.168.1.13] (abwn200.neoplus.adsl.tpnet.pl [83.8.237.200])
        by mx.google.com with ESMTPS id r21sm2182699bkj.22.2010.10.22.07.32.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 07:32:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <8145782bddf60325909f328337cb76d25c4402cf.1287690696.git.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159690>

On Fri, 22 Oct 2010 07:02, Thomas Rast wrote:

> Add an autogeneration script that inserts links to other manpages
> describing config variables, as follows:
>
> * parse config-vars-src.txt (as it now needs to be renamed) to find
>   out its current contents
> 
> * parse each manpage source (following includes) for config variable
>   headers (the blocks are ignored)
> 
> * assemble a new config-vars.txt that completes the original list with
>   "See linkgit:git-foo[1]" entries for all variables that were not in
>   it.

So is this script about automatically managing links from git-config
manpage to manpages of individual commands?  Does it mean that for 
something like the following in Documentation/config-vars-src.txt

  foo.bar::
  	Lorem ipsum dolor sit amet, consectetur adipisicing elit,
  	sed do eiusmod tempor incididunt ut labore et dolore magna
  	aliqua.

and if `foo.bar` is referenced in Documentation/git-foo.txt in some way
(from reading source of mentioned autogeneration script it considers
only 'foo.bar::', like in Documentation/git-send-email.txt), then it
adds

  See linkgit:git-foo[1]

at the end of description of variable in Documentation/config-vars-src.txt
(taking into account continuation blocks)?  What about config variables
mentioned in different ways, e.g. '`foo.bar`', like in git-update-index
documentation?  Does it checks that 'See linkgit:git-foo[1]' already
exists, e.g. in extended form 'See linkgit:git-foo[1].  True by default.'?
 
Or is it about automatically creating and updating blocks like this:

  sendemail.aliasesfile::
  sendemail.aliasfiletype::
  sendemail.bcc::
  sendemail.cc::
  [...]
  sendemail.thread::
  sendemail.validate::
  	See linkgit:git-send-email[1] for description.


See also comments below, where I realized what this scipt does...
This really should be in commit message.

> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  Documentation/Makefile              |    9 +-
>  Documentation/config-vars-src.txt   | 1747 +++++++++++++++++++++++++++++++++++
>  Documentation/config-vars.txt       | 1747 -----------------------------------
>  Documentation/make-config-list.perl |  131 +++
>  4 files changed, 1886 insertions(+), 1748 deletions(-)
>  create mode 100644 Documentation/config-vars-src.txt
>  delete mode 100644 Documentation/config-vars.txt
>  create mode 100755 Documentation/make-config-list.perl

[...]

> diff --git a/Documentation/make-config-list.perl b/Documentation/make-config-list.perl
> new file mode 100755
> index 0000000..f086867
> --- /dev/null
> +++ b/Documentation/make-config-list.perl
> @@ -0,0 +1,131 @@
> +#!/usr/bin/perl

While other helper scripts do not include comments describing them, it
would be nice to have here description what script does and for what it
is used.

Comments in code would also be nice.


The code lacks consistency:

> +	open my $fh, "<", $file or die "cannot open $file: $!";
vs
> +	my $fp;
> +	open $fp, '<', $name or die "open $name failed: $!";

> +	close $fh or die "eh? close failed: $!";
vs
> +	close $fp or die "close $name failed: $!";


> +
> +use strict;
> +use warnings;
> +use Getopt::Long;
> +
> +my %ignore;
> +
> +my $rc = GetOptions(
> +	"mainlist=s" => \my $mainlistfile,
> +	"ignore=s" => sub { $ignore{$_[1]} = 1 },
> +	"no-sort" => \my $no_sort,
> +	);
> +
> +if (!$rc or (!-r $mainlistfile)) {
> +	print "$0 --mainlist=<mainlist> [--ignore=<ignore>...] <asciidoc_manpage>...\n";
> +	exit 1;
> +}

The names <mainlist> (which is file with list of configuration variables
to modify), <ignore> (which is about ignoring some asciidoc_manpage files,
but only when recursing / following linkgit links) doesn't tell us much
by themselves.  It really needs either better names, or comment describing
what they mean, or both.

> +

It would be good to have comment what this subroutine does.  It reads
and parses file with list of config variables and their description,
and returns reference to list of variables, in the order they were in
file, and reference to hash with contents:
  variable => [ lines of description of variable ]

> +sub read_varlist {
> +	my ($file) = @_;
> +
> +	open my $fh, "<", $file or die "cannot open $file: $!";
> +	my (%mainlist, @mainvars);
> +
> +	my ($v, $last_v);
> +	my $in_block = 0;
> +	while (<$fh>) {
> +		if (/^(\S+)::/) {
> +			$v = lc $1;
> +			$in_block = 0;
> +			push @{$mainlist{$v}}, $_;
> +			push @mainvars, $v;

O.K., that is easy to understand (if one remembers about autovivification
in Perl).  But shouldn't we check if we are not in literal block, just
in case?

> +		} elsif (/^$/ && !$in_block) {
> +			if (defined $last_v && !$#{$mainlist{$last_v}}) {
> +				$mainlist{$last_v} = $mainlist{$v};
> +			}
> +			$last_v = $v;

What is this branch / this code about?

> +		} elsif (defined $v) {
> +			push @{$mainlist{$v}}, $_;
> +			$in_block = !$in_block if /^--$/;

O.K., easy to understand.

> +		}
> +	}
> +
> +	close $fh or die "eh? close failed: $!";
> +
> +	return \%mainlist, \@mainvars;
> +}
> +

It would be nice to have description what those variables should contain
(what structure would they have).

> +my %vars;
> +my %sections;
> +

It would be good to have comment what this subroutine does; better name
than 'read_file' would also be good.

This subroutine does *two* things: finds _manual_ section that manpage
belongs to, to create correct link (e.g. 1 for git-send-email(1), 5 for
gitattributes(5), 7 for gitcli(7)), and finds all manpages that refer
to config variable using '^foo.bar::': $vars{'foo.bar'} = [ 'git-foo', ... ]

It would also automatically follow includes, excluding ignored files
from following 'include::<filename>[]' links.

> +sub read_file {
> +	my ($name, $main_name) = @_;

$name is name of current file, $main_name is name of file that included
it, isn't it?

> +	if (!defined $main_name) {
> +		$main_name = $name;
> +	}
> +	my $manpage_name = $main_name;
> +	$manpage_name =~ s/\.txt//;
> +	my $fp;
> +	open $fp, '<', $name or die "open $name failed: $!";
> +	while (<$fp>) {
> +		if ($. < 5 && /^$manpage_name\((\d+)\)/) {
> +			$sections{$manpage_name} = $1;
> +		}

Shouldn't it be always first line of manpage?

> +		if (/^([a-z0-9]+\.[a-z<>0-9.]+)::/) {
> +			push @{$vars{$1}}, $manpage_name;
> +		}
> +		if (/^include::\s*(\S+)\s*\[\]/
> +		    && !exists $ignore{$1}) {
> +			read_file($1, $main_name);
> +		}
> +	}
> +	close $fp or die "close $name failed: $!";
> +}
> +
> +foreach my $name (@ARGV) {
> +	read_file($name);
> +}
> +
> +my ($mainlist, $mainvars) = read_varlist($mainlistfile);
> +
> +my @all_keys = @$mainvars;
> +foreach my $k (keys %vars) {
> +	if (!exists $mainlist->{$k}) {
> +		push @all_keys, $k;
> +	}

Nice, so it would detect config variables which are missing from
config-vars-src.txt

> +}
> +
> +@all_keys = sort @all_keys unless $no_sort;
> +
> +my %out;
> +foreach my $k (@all_keys) {
> +	if (exists $mainlist->{$k}) {
> +		push @{$out{$k}}, @{$mainlist->{$k}}, "\n";

Ah, so it doesn't add 'See linkgit:git-foo[1]' if 'foo.bar' is present
in config-vars-src.txt, but only generate notice about config variable
in git-config manpage, refering to the page where it is defined and
described.

This should be make more clear in commit message.


> +	} elsif (exists $vars{$k}) {
> +		push @{$out{$k}}, $k . "::\n";
> +		push @{$out{$k}}, "\tSee ";

Wouldn't this result in something like

  sendemail.aliasesfile::
  	See linkgit:git-send-email[1]

  sendemail.aliasfiletype::
  	See linkgit:git-send-email[1]

instead of

  sendemail.aliasesfile::
  sendemail.aliasfiletype::
  	See linkgit:git-send-email[1]

in the case where config-vars-src.txt is missing some variable?
Ah, I see that it is collapsed later.

> +		my $sep = " ";

Not $sep = "", or "\tSee"?  Otherwise you would get "\tSee  linkgit:git-foo[1]"
with double space.

> +		foreach my $p (sort @{$vars{$k}}) {
> +			next if ($p =~ /$mainlistfile/);

> +			if (!exists $sections{$p}) {
> +				warn "section for $p unknown";
> +				$sections{$p} = 1;
> +			}
> +			push @{$out{$k}}, $sep . "linkgit:" . $p . "[" . $sections{$p} . "]";

A bit of possible (but perhaps not necessary) refactoring:

  +			push @{$out{$k}}, $sep . gen_linkgit($p);

(or something like that).


Besides wouldn't it be better to do collapsing based on data, not on 
formatted string?

> +			$sep = ", ";
> +		}
> +		push @{$out{$k}}, ".\n\n";
> +	} else {
> +		die "can't happen: $k not in any source";
> +	}
> +}
> +


A comment what this loop does would be nice.

Note that we don't really have to do this collapsing for existing 
contents; only for contents that was generated by this script.

> +for (my $i = 0; $i < $#all_keys; $i++) {

> +	next if $#{$out{$all_keys[$i]}} != $#{$out{$all_keys[$i+1]}};
> +	my $same = 1;
> +	for (my $j = 1; $j <= $#{$out{$all_keys[$i]}}; $j++) {
> +		if ($out{$all_keys[$i]}[$j] ne $out{$all_keys[$i+1]}[$j]) {
> +			$same = 0;
> +			last;
> +		}
> +	}

A bit of possible (but perhaps not necessary) refactoring:

  +	next unless eq_deeply($out{$all_keys[$i]}, $out{$all_keys[$i+1]});

(or eq_deeply_arr).

> +	if ($same) {
> +		$out{$all_keys[$i]} = [$out{$all_keys[$i]}[0]];
> +	}
> +}

I really think that we can do this in an easier, more elegant, and not
that convoluted way.

First, we don't really need to store 'foo.bar::' as first element in
$out{'foo.bar'}.  Second, then compacting is just grouping hash by value.

> +
> +foreach my $k (@all_keys) {
> +	print @{$out{$k}};
> +}
> -- 
> 1.7.3.1.281.g5da0b
> 
> 

-- 
Jakub Narebski
Poland
