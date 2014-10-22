From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: git-svn performance
Date: Wed, 22 Oct 2014 18:38:30 +0100
Message-ID: <1413999510.36832.YahooMailBasic@web172305.mail.ir2.yahoo.com>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: fabian.schmied@gmail.com, git@vger.kernel.org, sam@vilain.net,
	stevenrwalter@gmail.com, waste.manager@gmx.de, amyrick@apple.com
To: normalperson@yhbt.net, stoklund@2pi.dk
X-From: git-owner@vger.kernel.org Wed Oct 22 19:38:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgzrr-0006dr-2P
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 19:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbaJVRif convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Oct 2014 13:38:35 -0400
Received: from nm31-vm5.bullet.mail.ir2.yahoo.com ([212.82.97.92]:41358 "EHLO
	nm31-vm5.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753975AbaJVRid convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2014 13:38:33 -0400
Received: from [212.82.98.54] by nm31.bullet.mail.ir2.yahoo.com with NNFMP; 22 Oct 2014 17:38:30 -0000
Received: from [212.82.98.65] by tm7.bullet.mail.ir2.yahoo.com with NNFMP; 22 Oct 2014 17:38:30 -0000
Received: from [127.0.0.1] by omp1002.mail.ir2.yahoo.com with NNFMP; 22 Oct 2014 17:38:30 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 590249.32845.bm@omp1002.mail.ir2.yahoo.com
Received: (qmail 56423 invoked by uid 60001); 22 Oct 2014 17:38:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1413999510; bh=DIndlVyomgmUB0pgrUibhGphFiz0LOZEwxxo/FFIDDU=; h=Message-ID:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=2iuewAWKnSgI1AGr7orhKIXPLCzWQmvjpozKKRN8WI6PJsaUJaORFEw0wHEvCCSa+nZOXoInONi9HDLWjhvR/TSUHK7O2btVOXRebRA52z232PWV/jC2KILGEOHtT8V6oVP0/l6JEw0MXPfcgxm0IBbZBJrJTdpwuvuhdc/SiCQ=
X-YMail-OSG: pcq1z2MVM1lQWIo1PualrmQL.cx23Uugma5sL.rXxQqaZWI
 GW2ZfXwI3QBLfvtvs6J0oZi0sBGtEg9jRi6rzUiVZ7L1L5e7CHoSpmSEdJiw
 M9voiMeQ0zbXJ4PN7k17dubZ22a0wkqSHxKrkqR.b6LZHwhES5dL_DlxvCpy
 eFN8wQttB10WStbnPuTVh_hmKsrnh4zcatDlXFexuyKaVL20r9NTHrPA0Udd
 m5QmOZ32Psqx3weaEx.Mu5IJ5ILP34AbqS..ZGePjzj1pM2983p1GQgIdljS
 6vxn4llsY2h3LoR2dF4nP8GSmRJak0mHZy3B5nX58a0oBUv1qfViFBAh7SoG
 27QrhqVHX62RoCkbWqwPETxGsjGeif1AsrTdYek156SdJgQgKeq9Sw0udTZE
 UXYDiB.4mVQ.WSdTdtmyKuyDwRbQdTwsExGv9kByW7wPdjs0fK7PNAtFuIfU
 OZTg2s9g7wTE.SCAq_yHGGim7rlc_A0TpFWzm4ERgghxo3mhY1Uhc8w2I4qC
 MREOQ2M3Rtj2M6kuxBjKHsvL7Mw_DXSwzjzEf3v.L.VhigXaCSbCyPabsala
 W9DQo_ObI1qtssn50pfzdLknfVJoPsy8ELfhO8yFISBnfX1IR9U3_7WJV0rG
 DmmRAGB.3lJRIO9vAhrzKQR06frnp0vVnjjCiMS_prk4jiPq2PYRI55RdqWq
 k7lj.CNWnqYYbnoqeaoUK2Ms6CS9NV9hJAJc_6wmsNllA03DnXwEYnnBPg9F
 N__LD65cjgXFOpEL..ufkkF4FXg--
Received: from [86.30.137.134] by web172305.mail.ir2.yahoo.com via HTTP; Wed, 22 Oct 2014 18:38:30 BST
X-Rocket-MIMEInfo: 002.001,LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpPbiBUdWUsIE9jdCAyMSwgMjAxNCAxMDowMCBCU1QgRXJpYyBXb25nIHdyb3RlOg0KDQo.SmFrb2IgU3Rva2x1bmQgT2xlc2VuIDxzdG9rbHVuZEAycGkuZGs.IHdyb3RlOg0KPj4gWWVzLCBidXQgSSB0aGluayB5b3UgY2FuIHJlbW92ZSBjYWNoZWRfbWVyZ2VpbmZvX3JldiB0b28uIA0KPg0KPlRoYW5rcywgcHVzaGVkIHRoZSBwYXRjaCBhdCB0aGUgYm90dG9tLCB0b28uDQo.QWxzbyBzdGFydGVkIHdvcmtpbmcgb24gc29tZSBtZW1vcnkgcmVkdWN0aW8BMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/810 YahooMailWebService/0.8.203.733
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

------------------------------
On Tue, Oct 21, 2014 10:00 BST Eric Wong wrote:

>Jakob Stoklund Olesen <stoklund@2pi.dk> wrote:
>> Yes, but I think you can remove cached_mergeinfo_rev too.=20
>
>Thanks, pushed the patch at the bottom, too.
>Also started working on some memory reductions here:
> http://mid.gmane.org/20141021033912.GA27462@dcvr.yhbt.net
>But there seem to be more problems :<
>
>----------------------------8<-----------------------------
>From: Eric Wong <normalperson@yhbt.net>
>Date: Tue, 21 Oct 2014 06:23:22 +0000
>Subject: [PATCH] git-svn: remove mergeinfo rev caching
>
>This should further reduce memory usage from the new mergeinfo
>speedups without hurting performance too much, assuming
>reasonable latency to the SVN server.
>
>Cc: Hin-Tak Leung <htl10@users.sourceforge.net>
>Suggested-by: Jakob Stoklund Olesen <stoklund@2pi.dk>
>Signed-off-by: Eric Wong <normalperson@yhbt.net>
>---
> perl/Git/SVN.pm | 30 +++++++++---------------------
> 1 file changed, 9 insertions(+), 21 deletions(-)
>
>diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
>index f8a75b1..4364506 100644
>--- a/perl/Git/SVN.pm
>+++ b/perl/Git/SVN.pm
>@@ -1710,32 +1710,20 @@ sub mergeinfo_changes {
> =A0=A0=A0 my %minfo =3D map {split ":", $_ } split "\n", $mergeinfo_p=
rop;
> =A0=A0=A0 my $old_minfo =3D {};
>=20
>-=A0=A0=A0 # Initialize cache on the first call.
>-=A0=A0=A0 unless (defined $self->{cached_mergeinfo_rev}) {
>-=A0=A0=A0 =A0=A0=A0 $self->{cached_mergeinfo_rev} =3D {};
>-=A0=A0=A0 }
>-
>-=A0=A0=A0 my $cached_rev =3D $self->{cached_mergeinfo_rev}{$old_path}=
;
>-=A0=A0=A0 unless (defined $cached_rev && $cached_rev =3D=3D $old_rev)=
 {
>-=A0=A0=A0 =A0=A0=A0 my $ra =3D $self->ra;
>-=A0=A0=A0 =A0=A0=A0 # Give up if $old_path isn't in the repo.
>-=A0=A0=A0 =A0=A0=A0 # This is probably a merge on a subtree.
>-=A0=A0=A0 =A0=A0=A0 if ($ra->check_path($old_path, $old_rev) !=3D $SV=
N::Node::dir) {
>-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 warn "W: ignoring svn:mergeinfo on $old=
_path, ",
>-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 "directory didn't exist in r$=
old_rev\n";
>-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return {};
>-=A0=A0=A0 =A0=A0=A0 }
>-=A0=A0=A0 }
>-=A0=A0=A0 my (undef, undef, $props) =3D $self->ra->get_dir($old_path,=
 $old_rev);
>+=A0=A0=A0 my $ra =3D $self->ra;
>+=A0=A0=A0 # Give up if $old_path isn't in the repo.
>+=A0=A0=A0 # This is probably a merge on a subtree.
>+=A0=A0=A0 if ($ra->check_path($old_path, $old_rev) !=3D $SVN::Node::d=
ir) {
>+=A0=A0=A0 =A0=A0=A0 warn "W: ignoring svn:mergeinfo on $old_path, ",
>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 "directory didn't exist in r$old_rev\n"=
;
>+=A0=A0=A0 =A0=A0=A0 return {};
>+=A0=A0=A0 }
>+=A0=A0=A0 my (undef, undef, $props) =3D $ra->get_dir($old_path, $old_=
rev);
> =A0=A0=A0 if (defined $props->{"svn:mergeinfo"}) {
> =A0=A0=A0 =A0=A0=A0 my %omi =3D map {split ":", $_ } split "\n",
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 $props->{"svn:mergeinfo"};
> =A0=A0=A0 =A0=A0=A0 $old_minfo =3D \%omi;
> =A0=A0=A0 }
>-=A0=A0=A0 $self->{cached_mergeinfo_rev}{$old_path} =3D $old_rev;
>-
>-=A0=A0=A0 # Cache the new mergeinfo.
>-=A0=A0=A0 $self->{cached_mergeinfo_rev}{$path} =3D $rev;
>=20
> =A0=A0=A0 my %changes =3D ();
> =A0=A0=A0 foreach my $p (keys %minfo) {
>--=20
>EW

I'll have a look at the new changes at some point - I am still keeping =
the old
clone and the new clone and just fetching from time to time to keep the=
m
in sync. I just tried that and fetching the same 50 commits on the old =
clone=20
took 1.7 GB memory vs 1.0 GB memory on the new. Details below.
This is just with the 2 earliest patches - I'll put the new 3 in at som=
e point.
So I see some needs for retrospectively fixing old clones (maybe as par=
t
of garbage collection?), since most would simply use an old clone throu=
gh
the ages...=20

Comparing trunk of old and new, I see one difference -  One short
commit message is missing in the *old* (the "Add checkPoFiles etc." par=
t)
and so all the sha1 afterwards differed. Is that an old bug that's fixe=
d
and therefore I should throw away the old clone?=20

Date:   Wed Apr 25 18:21:29 2012 +0000
    Add checkPoFiles etc.
        git-svn-id: https://svn.r-project.org/R/trunk@59188=20

Here is the details of fetching old and new:

<---
$ /usr/bin/time -v git svn fetch --all
	M	doc/manual/R-admin.texi
r66784 =3D fc20374f26f8e03bb88c00933982e29138a6f929 (refs/remotes/trunk=
)
=2E..
	M	configure
r66834 =3D d8d1876f6aa71b3fe3773cd28a760ff945d30bdf (refs/remotes/R-3-1=
-branch)
	Command being timed: "git svn fetch --all"
	User time (seconds): 1520.77
	System time (seconds): 156.32
	Percent of CPU this job got: 98%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 28:15.82
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 1738276
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 613
	Minor (reclaiming a frame) page faults: 2039305
	Voluntary context switches: 11243
	Involuntary context switches: 181507
	Swaps: 0
	File system inputs: 658328
	File system outputs: 754688
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0

$ cd ../R-2/
[Hin-Tak@localhost R-2]$ /usr/bin/time -v git svn fetch --all
	M	doc/manual/R-admin.texi
r66784 =3D 6a08d94b456d33d85add914a1b780a972689443a (refs/remotes/trunk=
)
=2E..
	M	configure
r66834 =3D 370a6484c2a65be78dfae184b50d8f08685d389c (refs/remotes/R-3-1=
-branch)
	Command being timed: "git svn fetch --all"
	User time (seconds): 1507.89
	System time (seconds): 134.25
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 27:38.49
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 1026656
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 1110
	Minor (reclaiming a frame) page faults: 1630150
	Voluntary context switches: 10280
	Involuntary context switches: 176444
	Swaps: 0
	File system inputs: 361472
	File system outputs: 477912
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
---->
