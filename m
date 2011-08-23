From: Jason Gross <jgross@MIT.EDU>
Subject: Re: [PATCH] git-svn: Destroy the cache when we fail to read it
Date: Tue, 23 Aug 2011 01:51:50 -0400
Message-ID: <CAKObCaoj+jwkCW3DOA=N-EtOmn-Ckwevi3fHPqans+_cd8ZC8A@mail.gmail.com>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu> <20110823022717.GA4623@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 07:52:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvjuW-0006PM-O6
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 07:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078Ab1HWFwY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Aug 2011 01:52:24 -0400
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:54469 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751094Ab1HWFwX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 01:52:23 -0400
X-AuditID: 12074425-b7b15ae000000f71-7d-4e533fdaed8d
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 29.DE.03953.ADF335E4; Tue, 23 Aug 2011 01:51:23 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id p7N5qLlu023922
	for <git@vger.kernel.org>; Tue, 23 Aug 2011 01:52:21 -0400
Received: from mail-iy0-f170.google.com (mail-iy0-f170.google.com [209.85.210.170])
	(authenticated bits=0)
        (User authenticated as jgross@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p7N5qK5W010369
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 23 Aug 2011 01:52:21 -0400 (EDT)
Received: by iye16 with SMTP id 16so11525546iye.1
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 22:52:20 -0700 (PDT)
Received: by 10.42.159.199 with SMTP id m7mr3397014icx.326.1314078740127; Mon,
 22 Aug 2011 22:52:20 -0700 (PDT)
Received: by 10.42.73.135 with HTTP; Mon, 22 Aug 2011 22:51:50 -0700 (PDT)
In-Reply-To: <20110823022717.GA4623@elie.gateway.2wire.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixCmqrHvbPtjPYLWxRdeVbiYHRo/Pm+QC
	GKO4bFJSczLLUov07RK4Mia9mcxe0KlY8XbTbtYGxhapLkZODgkBE4nJxzsYIWwxiQv31rOB
	2EIC+xglNr5M6WLkArJPMUrcvnqCFcJ5wiTR8vcfM0RVtcTvLZtYIOxCiY5/t8Am8QoISpyc
	+QQq7iXRuPMqmM0pYC2x/NhBdoh4rsSL5Y/B5rAJKEnc3rgIrJdFQFViw6orbBBzAiR2PloK
	ViMs4C4xt2E92BwRAQ2J55++gdUwC1hJXD6wgxHC1pF41/eAGcLWlli28DXzBEbhWUhOmoWk
	bBaSsgWMzKsYZVNyq3RzEzNzilOTdYuTE/PyUot0LfRyM0v0UlNKNzGCApvdRXUH44RDSocY
	BTgYlXh4fx0I8hNiTSwrrsw9xCjJwaQkylsIjAshvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrwL
	7wCV86YkVlalFuXDpKQ5WJTEeV/vcPATEkhPLEnNTk0tSC2CycpwcChJ8NqCDBUsSk1PrUjL
	zClBSDNxcIIM5wEangxSw1tckJhbnJkOkT/FaMlx7NWJY4wck9+ByGXrTx9jFGLJy89LlRLn
	9QJpEABpyCjNg5sJS1SvGMWBXhTmTQWp4gEmObipr4AWMgEt5PgF8k1xSSJCSqqBUdbtm49R
	SvWCVA/5ld3e5lvTp7+XXLLh05w1Z1fXVMc92nHtjVx0223rcMZ50y7lPb0RmeZ8qWDWfGmB
	48s37zdZc+8Ds8HFnthUj8h5BvaXDKx4MicWHr5ctFPTU+L/cfP1tuFzf4uZpbMc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179921>

1) Sure.  I'm not sure whether I should make $cache_path toplevel, or
a parameter of do_memoization.  I'm thinking the latter, just in case
$ENV{GIT_DIR} changes between calls to
memoize_svn_mergeinfo_functions?

2) I'm not sure if there's a clean/robust way to detect cache
corruption; if it's completely corrupted, Storable complains about not
finding the right magic number, but I could imagine things being
corrupted in more subtle ways that give rise to other Storable errors.
As for your worry: I don't know the code well enough to have git-svn
recover from some other error in memoization; if there's an error,
that means that it can't read the cache correctly (either in tieing
the hashes, or in memoizing the functions).  The other alternative
that I see is to die.  Is this preferable to repeatedly discarding the
cache?

3) Will fix.

4) Will do.

I'll send a new patch in once I hear back from you about 1 and 2.

-Jason

On Mon, Aug 22, 2011 at 10:27 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>
> (+cc: Eric Wong)
> Hi Jason,
>
> Jason Gross wrote:
>
> [This patch teaches "git svn" to invalidate caches when they
> =A0fail to load, for example because the endianness or size of
> =A0some type changed, which is common in the perl 5.6 -> 5.8
> =A0upgrade.]
>
> > http://lists.debian.org/debian-perl/2011/05/msg00023.html and
> > http://lists.debian.org/debian-perl/2011/05/msg00026.html).
> [...]
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -1680,7 +1680,7 @@ use vars qw/$default_repo_id $default_ref_id =
$_no_metadata $_follow_parent
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0$_use_svnsync_props $no_reuse_existing $=
_minimize_url
> > =A0 =A0 =A0 =A0 =A0 $_use_log_author $_add_author_from $_localtime/=
;
> > =A0use Carp qw/croak/;
> > -use File::Path qw/mkpath/;
> > +use File::Path qw/mkpath rmtree/;
> > =A0use File::Copy qw/copy/;
> > =A0use IPC::Open3;
> > =A0use Memoize; =A0# core since 5.8.0, Jul 2002
> > @@ -3198,28 +3198,41 @@ sub has_no_changes {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 $memoized =3D 1;
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $cache_path =3D "$ENV{GIT_DIR}/svn/.=
caches/";
> > - =A0 =A0 =A0 =A0 =A0 =A0 mkpath([$cache_path]) unless -d $cache_pa=
th;
> > -
> > - =A0 =A0 =A0 =A0 =A0 =A0 tie my %lookup_svn_merge_cache =3D> 'Memo=
ize::Storable',
> [...]
> > - =A0 =A0 =A0 =A0 =A0 =A0 ;
> > + =A0 =A0 =A0 =A0 =A0 =A0 my $do_memoization =3D sub {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mkpath([$cache_path]) unl=
ess -d $cache_path;
> [...]
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> > + =A0 =A0 =A0 =A0 =A0 =A0 };
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 if (not eval {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $do_memoization->();
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 }) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $err =3D $@ || "Zombie=
 error"; # "Zombie error" to catch clobbered $@ in buggy destructors
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die $err unless -d $cache=
_path;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print STDERR "Discarding =
cache and trying again ($@)\n";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rmtree([$cache_path]);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $do_memoization->();
> > + =A0 =A0 =A0 =A0 =A0 =A0 }
>
> Thank you thank you thank you.
>
> Okay, time for nitpicks:
>
> =A01) Would it be possible to lift this do_memoization() to a topleve=
l sub?
> =A0 =A0I suspect that could make the code a little easier to read.
>
> =A02) Is it important to discard the cache for _all_ errors, instead
> =A0 =A0of just corruption and "is not compatible" errors? =A0Rebuildi=
ng the
> =A0 =A0cache is not cheap, and I am afraid of effects like repeatedly
> =A0 =A0discarding the cache only to rebuild it again due to a typo in
> =A0 =A0git-svn.perl or an out-of-memory condition.
>
> =A03) The line with "Zombie error" is very long --- I guess putting t=
he
> =A0 =A0comment on the line before would help.
>
> =A04) The series would be clearer imho as a single patch that include=
s
> =A0 =A0both the fix and tests.
>
> Eric, what do you think?
>
> Thanks again, :)
> Jonathan
