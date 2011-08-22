From: Jason Gross <jgross@MIT.EDU>
Subject: Re: [PATCH] git-svn: Destroy the cache when we fail to read it
Date: Mon, 22 Aug 2011 00:04:09 -0400
Message-ID: <CAKObCao5KwTptvJG_2F8SkM2hA=GrhC2HC0hFrDSDw3_PVb-PA@mail.gmail.com>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jason Gross <jgross@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 22 06:04:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvLkl-0005gL-7G
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 06:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806Ab1HVEEm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Aug 2011 00:04:42 -0400
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:50293 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750733Ab1HVEEl convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 00:04:41 -0400
X-AuditID: 12074424-b7bcaae000000a05-94-4e51d584921f
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id B9.08.02565.485D15E4; Mon, 22 Aug 2011 00:05:24 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id p7M44eHY022730
	for <git@vger.kernel.org>; Mon, 22 Aug 2011 00:04:40 -0400
Received: from mail-iy0-f170.google.com (mail-iy0-f170.google.com [209.85.210.170])
	(authenticated bits=0)
        (User authenticated as jgross@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p7M44dw5002437
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Mon, 22 Aug 2011 00:04:40 -0400 (EDT)
Received: by iye16 with SMTP id 16so9606261iye.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 21:04:39 -0700 (PDT)
Received: by 10.43.133.201 with SMTP id hz9mr2219215icc.58.1313985879101; Sun,
 21 Aug 2011 21:04:39 -0700 (PDT)
Received: by 10.42.73.135 with HTTP; Sun, 21 Aug 2011 21:04:09 -0700 (PDT)
In-Reply-To: <1313979422-21286-1-git-send-email-jgross@mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixCmqrNtyNdDPoO2UoEXXlW4mB0aPz5vk
	AhijuGxSUnMyy1KL9O0SuDJeXFUvOKFf8XDmEcYGxo+qXYycHBICJhJts84yQthiEhfurWfr
	YuTiEBLYxygxt+UaE4RzilGib+d2VgjnCZPE1e8XWUFahASqJH7/XMkCYRdKPGvezgZi8woI
	Spyc+QQq7iXR3X4XzOYUsJc48OIPI0TcTmL60U9MIDabgJLE7Y2LwOIsAqoSjS/bGCHmBEjc
	vr2OGcQWFnCXmNuwHmyOiIC4xNvjM9lBbGYBN4k5O1YxQdg6Eu/6HjBD2NoSyxa+Zp7AKDwL
	yUmzkJTNQlK2gJF5FaNsSm6Vbm5iZk5xarJucXJiXl5qka65Xm5miV5qSukmRlBos7uo7GBs
	PqR0iFGAg1GJh/eBSaCfEGtiWXFl7iFGSQ4mJVHey5eBQnxJ+SmVGYnFGfFFpTmpxYcYJTiY
	lUR4e1YC5XhTEiurUovyYVLSHCxK4rw2Ox38hATSE0tSs1NTC1KLYLIyHBxKErxdV4AaBYtS
	01Mr0jJzShDSTBycIMN5gIZ/BFnMW1yQmFucmQ6RP8VoyXHs1YljjByT34HIZetPH2MUYsnL
	z0uVEufNBRkqANKQUZoHNxOWql4xigO9KMzrCVLFA0xzcFNfAS1kAlo4YWUAyMKSRISUVANj
	jMrZmJAr5VeVEk/E3KncrHpAWcX85qtZRfni60u8zj9/0Oimu7HhPuufsm2Wr7fGrN3ba6fw
	6qlS8YzL+RrX7/8UYnyw9eVanmvhHtyprBxX9zXmrClt4d577Yhl2MKHR/Kv7dze 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179839>

Oops, the bug numbers I gave were debian=A0bug ids, not git bug ids.
The "This fixes bug ..." sentence should either be removed from the
commit message before this commit is merged, or the numbers should be
replaced with the appropriate git bug numbers.

-Jason

On Sun, Aug 21, 2011 at 10:17 PM, Jason Gross <jgross@mit.edu> wrote:
>
> Previously, we would fail fatally when trying to fetch changes with
> mergeinfo on a 32 bit machine, when the repository previously had
> fetched changes with mergeinfo on a 64 bit machine.
>
> This fixes bug 618875 (which is also 587650, 635097). =A0Much of the =
code
> was written by Jonathan Nieder <jrnieder@gmail.com> with suggestions
> from Steffen Mueller <smueller@cpan.org> (see
> http://lists.debian.org/debian-perl/2011/05/msg00023.html and
> http://lists.debian.org/debian-perl/2011/05/msg00026.html).
>
> Signed-off-by: Jason Gross <jgross@mit.edu>
> Cc: Jonathan Nieder <jrnieder@gmail.com>
> ---
> =A0git-svn.perl | =A0 59 +++++++++++++++++++++++++++++++++++---------=
-------------
> =A01 files changed, 36 insertions(+), 23 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 89f83fd..78ccdc8 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1680,7 +1680,7 @@ use vars qw/$default_repo_id $default_ref_id $_=
no_metadata $_follow_parent
> =A0 =A0 =A0 =A0 =A0 =A0 $_use_svnsync_props $no_reuse_existing $_mini=
mize_url
> =A0 =A0 =A0 =A0 =A0 =A0$_use_log_author $_add_author_from $_localtime=
/;
> =A0use Carp qw/croak/;
> -use File::Path qw/mkpath/;
> +use File::Path qw/mkpath rmtree/;
> =A0use File::Copy qw/copy/;
> =A0use IPC::Open3;
> =A0use Memoize; =A0# core since 5.8.0, Jul 2002
> @@ -3198,28 +3198,41 @@ sub has_no_changes {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$memoized =3D 1;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0my $cache_path =3D "$ENV{GIT_DIR}/svn/=
=2Ecaches/";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mkpath([$cache_path]) unless -d $cache_=
path;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tie my %lookup_svn_merge_cache =3D> 'Me=
moize::Storable',
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "$cache_path/lookup_svn_merge.d=
b", 'nstore';
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 memoize 'lookup_svn_merge',
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SCALAR_CACHE =3D> 'FAUL=
T',
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LIST_CACHE =3D> ['HASH'=
 =3D> \%lookup_svn_merge_cache],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tie my %check_cherry_pick_cache =3D> 'M=
emoize::Storable',
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "$cache_path/check_cherry_pick.=
db", 'nstore';
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 memoize 'check_cherry_pick',
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SCALAR_CACHE =3D> 'FAUL=
T',
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LIST_CACHE =3D> ['HASH'=
 =3D> \%check_cherry_pick_cache],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tie my %has_no_changes_cache =3D> 'Memo=
ize::Storable',
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "$cache_path/has_no_changes.db"=
, 'nstore';
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 memoize 'has_no_changes',
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SCALAR_CACHE =3D> ['HAS=
H' =3D> \%has_no_changes_cache],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LIST_CACHE =3D> 'FAULT'=
,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $do_memoization =3D sub {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mkpath([$cache_path]) u=
nless -d $cache_path;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tie my %lookup_svn_merg=
e_cache =3D> 'Memoize::Storable',
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "$cache_path/lo=
okup_svn_merge.db", 'nstore';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memoize 'lookup_svn_mer=
ge',
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SCALAR_=
CACHE =3D> 'FAULT',
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LIST_CA=
CHE =3D> ['HASH' =3D> \%lookup_svn_merge_cache],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tie my %check_cherry_pi=
ck_cache =3D> 'Memoize::Storable',
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "$cache_path/ch=
eck_cherry_pick.db", 'nstore';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memoize 'check_cherry_p=
ick',
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SCALAR_=
CACHE =3D> 'FAULT',
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LIST_CA=
CHE =3D> ['HASH' =3D> \%check_cherry_pick_cache],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tie my %has_no_changes_=
cache =3D> 'Memoize::Storable',
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "$cache_path/ha=
s_no_changes.db", 'nstore';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memoize 'has_no_changes=
',
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SCALAR_=
CACHE =3D> ['HASH' =3D> \%has_no_changes_cache],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LIST_CA=
CHE =3D> 'FAULT',
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (not eval {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $do_memoization->();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $err =3D $@ || "Zomb=
ie error"; # "Zombie error" to catch clobbered $@ in buggy destructors
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die $err unless -d $cac=
he_path;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print STDERR "Discardin=
g cache and trying again ($@)\n";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rmtree([$cache_path]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $do_memoization->();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0sub unmemoize_svn_mergeinfo_functions {
> --
> 1.7.2.3
>
