From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Sat, 17 Dec 2011 15:41:06 +0530
Message-ID: <20111217101106.GB19248@sita-lt.atc.tcs.com>
References: <jbvj5o$skt$1@dough.gmane.org>
 <20111217101009.GA19248@sita-lt.atc.tcs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Cc: git@vger.kernel.org
To: Gelonida N <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 17 11:11:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbrEf-0008Vd-0d
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 11:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832Ab1LQKLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 05:11:17 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56698 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab1LQKLP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 05:11:15 -0500
Received: by iaeh11 with SMTP id h11so5664306iae.19
        for <git@vger.kernel.org>; Sat, 17 Dec 2011 02:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ha53fdMU8/qllo9XdNKzeDElqoxFHnJxp1GzBgiDTJc=;
        b=IVKLNdN5OP+Ad2UNcRyb/Xpjc9rDz38V2GLEs2vrBlABJXtwxG0SfV4rHo0LUwPRgF
         cg1dHQJKMva/i7zCWkozK8hpyRpQ3NuIo3oeKPlIlHKtMgiDryYfMv4FnTwWgJdrzVIG
         YttWck0tmb/+o4CLkz0KlZoRKlA2fWgJIDCx8=
Received: by 10.50.173.74 with SMTP id bi10mr14063336igc.4.1324116674544;
        Sat, 17 Dec 2011 02:11:14 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([117.195.189.63])
        by mx.google.com with ESMTPS id yg2sm7563938igb.1.2011.12.17.02.11.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 02:11:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111217101009.GA19248@sita-lt.atc.tcs.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187366>


--LwW0XdcUbUexiWVK
Content-Type: multipart/mixed; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

oops; forgot the program...

On Sat, Dec 17, 2011 at 03:40:09PM +0530, Sitaram Chamarty wrote:
> On Sat, Dec 10, 2011 at 01:26:32PM +0100, Gelonida N wrote:
> > Hi,
> >=20
> > What is the best way to fastforward all fastforwardable tracking
> > branches after a git fetch?
>=20
> I know this is a somewhat closed topic, but I took some time to
> clean up a program I have been using for a while, including some
> changes based upon ideas elsewhere in this thread.  The program
> "git-branch-check" is attached, and requires perl > 5.10.0.
>=20
> Note that this does a lot more than just fast-forward all
> branches, although it can do that as well.
>=20
> I alias it (in ~/.gitconfig) to 'bc', so I just run "git bc".
> Running with "-h" shows usage:
>=20
>     Usage: /home/sitaram/bin/git-branch-check [options] [branches]
>=20
>     Check or fast forward branches.  Default: act upon all local branches=
 if no
>     arguments supplied, or just the current branch if '-c' is passed.
>             -c      act upon current branch only
>             -ff     don't just check, try to fast forward also
>             -md     max diff (default 100; see below for details)
>             -h      help
>     'max diff':
>         hide output for two branches different by more than so many commi=
ts
>=20
> My usual usage is just "git bc -c", which may give me:
>=20
>        1        pu...origin/pu
>        1        pu...github/pu
>       13        pu...master
>            5    pu...q
>            7    pu...vrs
>=20
> This quickly tells me my 'pu' is one ahead of both my own
> gitolite server as well as github's copy, and that it is 13
> commits ahead of master.  The (unreleased and frequently
> rebased) feature branches 'q' and 'vrs' are ahead of pu, which
> means a rebase is not pending.  Without the "-c" I may see the
> status of master versus its own upstream and other remotes,
> etc., also.
>=20
> The purpose of the max diff limit (default 100) is to hide, for
> example, the pair 'master' and 'man' from the git.git repo.
> Otherwise you'd see something like:
>=20
>     27249 973    master...man
>=20
> which is pretty meaningless.  The sum of those two numbers
> should be less than the max.
>=20
> "git bc -ff" will attempt to fast forward all selected branches
> that are ancestors of their respective upstreams.  The current
> branch will not be ff-ed if the tree is dirty, since you can't
> do this by 'git branch -f'; it has to be an actual merge
> command.
>=20
> The output is not (currently) pipable to other programs because
> I use colors (obtained from 'git config --get-color') and
> currently it is not conditional on STDOUT being a tty.



--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=git-branch-check

#!/usr/bin/perl -s
use 5.10.0;
use strict;
use warnings;

# ----------------------------------------------------------------------

# bare-minimum subset of 'Tsh' (see github.com/sitaramc/tsh)
{
    my($rc, $text);
    sub rc { return $rc || 0; }
    sub text { return $text || ''; }
    sub lines { return split /\n/, $text; }
    sub try {
        my $cmd = shift; die "try: expects only one argument" if @_;
        $text = `( $cmd ) 2>&1; echo -n RC=\$?`;
        if ($text =~ s/RC=(\d+)$//) {
            $rc = $1;
            return (not $rc);
        }
        die "couldnt find RC= in result; this should not happen:\n$text\n\n...\n";
    }
}

# ----------------------------------------------------------------------

# options; the "-s" above sets one or more of these
# (the format of the lines below is special; it is used by usage() to generate
# help text for the options)
# BEGIN OPTIONS
    our $c;     # act upon current branch only
    our $ff;    # don't just check, try to fast forward also
    our $md;    # max diff (default 100; see below for details)
    our $h;     # help
# END OPTIONS
    $md ||= 100;

# get this over with; usage() exits so don't worry
    usage() if $h;

# get current branch
    my $current = '';
    try "git symbolic-ref HEAD" or die "DETACHED HEAD or no repo";
    ($current = (lines)[0]) =~ s(refs/heads/)();

# get branch names
    # first, all local branches as keys of a hash with upstream name if any, as the value
    my %upstream;
    try "git for-each-ref --perl '--format=\$upstream{%(refname:short)} = %(upstream:short);' refs/heads"
        or die "for-each-ref 1 failed";
    eval text;

    # local branches as a list; keep $current at the top, and the rest sorted
    my @local = ($current, grep { $_ ne $current } sort keys %upstream);

    # remote branches as a list
    try "git for-each-ref '--format=%(refname:short)' refs/remotes"
        or die "for-each-ref 2 failed";
    my @remote = lines;

# decide what branches to act upon.  Default: all local branches.  If any
# arguments are given, then those.  If '-c' is passed, only current branch.
    my @branches = @local;
    @branches = @ARGV if @ARGV;
    @branches = ($current) if $c;

# ----------------------------------------------------------------------

# show the tree state if it's dirty
    print "dirty:\n", text if dirty();

# process selected branches
    for my $b (@branches) {
        # attempt a fast-forward if -ff is passed
        ff($b, $upstream{$b}, $current) if ($ff);
        # check against its own upstream
        check($b, $upstream{$b});
        # then against all remote branches of the same name (I typically have
        # my own gitolite server as 'upstream' but also have github and google
        # code as additional remotes that I push my branches to)
        check($b, grep(m(^[^/]+/$b$), @remote));
    }
    # ...then against all local branches.  We do this in a separate loop
    # so their output is kept separate from the remote compares above.
    for my $b (@branches) {
        check($b, @local);
    }

# DONE...

# ----------------------------------------------------------------------
# subroutines
# ----------------------------------------------------------------------

sub ff {
    # b=branch, u=upstream, c=current
    my ($b, $u, $c) = @_;

    unless ($u) {
        say "$b does not have an upstream";
        return;
    }

    if ($b eq $c and dirty()) {
        say "working tree is dirty; skipping ff for (current branch) $b";
        return;
    }

    # $l = number of commits "l"eft side has over the "r"ight (similarly $r...)
    my($l, $r) = compare($b, $u);
    if ($r and not $l) {
        # there is something to update, and ff is possible
        if ($b eq $c) {
            # current branch; needs an actual merge
            try("git merge --ff-only $u") or die "$b: 'git merge --ff-only $u' failed:\n" .  text;
        } else {
            # other branches can be forced
            try("git branch -f $b $u") or die "$b: 'git branch -f $b $u' failed:\n" .  text;
        }
    }
}

sub check {
    my ($b, @list) = @_;
    state %seen;

    for my $u (@list) {
        next unless $u;
        next if $b eq $u or $seen{$b}{$u};
        # seeing a...b is as good as seeing b...a also
        $seen{$b}{$u} = 1;
        $seen{$u}{$b} = 1;

        my ($l, $r) = compare($b, $u);

        my $abs = $l + $r; next unless $abs;    # if they're equal, don't show it
        next if $abs >= $md;                    # if they're too far apart, don't show it

        print spacepad(4, $l) . color('green') . ($l || ' ');
        print spacepad(4, $r) . color('red')   . ($r || ' ');
        say color('reset') . "    $b...$u";
    }
}

sub compare {
    my ($b, $u) = @_;

    try("git rev-list $u..$b") or die "'git rev-list $u..$b' failed:\n" .  text;
    my $l = lines;

    try("git rev-list $b..$u") or die "'git rev-list $b..$u' failed:\n" .  text;
    my $r = lines;

    return($l, $r);
}

sub dirty {
    try "git status -s -uno | cut -c1-2 | sort | uniq -c; /./";
}

sub color {
    my $color = shift;
    return `git config --get-color "" $color`;
}

sub spacepad {
    return " " x ($_[0] - length($_[1]));
}

sub usage {
    print "
Usage: $0 [options] [branches]

Check or fast forward branches.  Default: act upon all local branches if no
arguments supplied, or just the current branch if '-c' is passed.
";
    @ARGV=($0);
    for ( grep { /BEGIN OPTIONS/../END OPTIONS/ and not /OPTION/ } <> ) {
        s/our \$/\t-/;
        s/; *#/\t/;
        print;
    }
    say "\'max diff':\n    hide output for two branches different by more than so many commits";
    exit 1;
}

--TRYliJ5NKNqkz5bu--

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO7Gq6AAoJEKRCkIUIgjelvNUP/R6Le5IuZXS0agTxAAHULcI3
VWGGyfWTDSRzglaTZCojtzPUXaz98h3eU1L9j9gCujHC1gsIt/3V2RMgGrLZrvLG
XzR624KKZl1yTV3rmiW1KX7zFHcMxlOiAtdOwSBknbaSk/oY/AnT7gsnx69Gq1lh
DkkaTiMfvzwHTovbMCiD5J2cSELnXAJK05yG0ADyaxikOC5BAvliQfg19WvmAglP
FizjMudkFD4apoyegAk1W0n64Id0fKxzrzhlYCJSiDqZuAdirkixDqV3ImQqlklJ
A6oF/Y0fAnaj8fjqzbq9+jU11/gnZH2eU5Xmx9lmoUyB9VIH8LemUsao2BcjAzJz
mMJ5nqrJCcYsJ6zwq3h+79DgGRTZ/RdPKYLyujIEG8IDf72G98sV4qKrmlzTIVAB
HHij4H+7LDQnzso/V+F0JBmesBwmcJxXGgtkZL8ViOXioZzwVWrp1FeU/4LvFU1x
Tl8J1ZbyIqut3K56Bmmt8GYqi9cbaLZPqXyY0Zj8Qi7xzWCjHvSkJ/nIkzEVzqGC
mCXN6ig67SYwLu73ddUO3Z9hTdycleykyLG1XwczgSvEZsRwEa29Me3URBH3KdU2
kz/B6tyVpzqgXHKz9FU80pbJcO0pPAqyGuwN3/iHsaLcbIlwPyCC32IHlNEH7gmw
OBWFYYg66ndp/AVd+srI
=ipZI
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
