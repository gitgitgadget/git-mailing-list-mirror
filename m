From: Hin-Tak Leung <hintak_leung@yahoo.co.uk>
Subject: Re: git svn's performance issue and strange pauses, and other thing
Date: Sun, 19 Oct 2014 15:04:51 +0100
Message-ID: <1413727491.1339.BPMail_high_carrier@web172302.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, stoklund@2pi.dk, sam@vilain.net,
	stevenrwalter@gmail.com, waste.manager@gmx.de, amyrick@apple.com
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Sun Oct 19 16:05:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xfr6c-0001kj-TI
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 16:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbaJSOEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2014 10:04:54 -0400
Received: from nm10-vm3.bullet.mail.ir2.yahoo.com ([212.82.96.155]:47689 "EHLO
	nm10-vm3.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751916AbaJSOEx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2014 10:04:53 -0400
Received: from [212.82.98.50] by nm10.bullet.mail.ir2.yahoo.com with NNFMP; 19 Oct 2014 14:04:51 -0000
Received: from [212.82.98.101] by tm3.bullet.mail.ir2.yahoo.com with NNFMP; 19 Oct 2014 14:04:51 -0000
Received: from [127.0.0.1] by omp1038.mail.ir2.yahoo.com with NNFMP; 19 Oct 2014 14:04:51 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 563015.50871.bm@omp1038.mail.ir2.yahoo.com
Received: (qmail 34860 invoked by uid 60001); 19 Oct 2014 14:04:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.co.uk; s=s1024; t=1413727491; bh=GK4+dMja/KE5dwZKa7DrfwB+3+uumI3gor/sfd/dD+A=; h=Message-ID:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=me55Q2kEnDWlCFi6wp0frNXwruxuRWxyFjDKSMR8mM6SvDvGQMTumlAL23XP4XvyTH+bDrrPRtxkeKennh8DtZz2AOjClPG+ggvR2Jt2O6hZ7o0VIYVM6VnHC0kz719iXUVKtNDibTo5r/efH6HeWApnY17WenytDfHnsxv3EKE=
X-YMail-OSG: YpsFuWAVM1k9i_UmxwCXBmnRhl1BrhqCv0inwrAVUjBerVZ
 DX0b4Wxq1YLN7KutZiRNqGrJrPfKCeyNmL7RSlNfNFvyS31U2QqdTT2S1WyV
 NYwzx_MzCfg._Atc0dra_JFMyq6Rz210SQxx6K1NuYVvd1qNCd7x61v86WgL
 dsfMhWHYa344qx1FdxOz_jmIpPoKStTzixOKgIIDWBzkBImqOv6czOZhe6SE
 VvStuw2tO8w8J45T3opBchtVVhC5Z6egFdvQBRxoJPaG0qAd4cBdOUwiszvf
 xQkZ4mXq8i.7zB6TREEwH8kYs072iShjgt8VVCXDTLwJWY0UUGu9ZcBqR833
 2QfVWTOgvcSqFAxxzuF3svntcUjcF3lnpXWVHisuO3vT4ESH31S52FxKJl_n
 w_KIbNSETW7gT2ZRqglfwzUJEIoIWSAKbZqUIoBDPN5KQfPrtev1k7k4iFD9
 sv0G5tPrmZvbsw654Sgm.9jmHqTM2cQVB4woTfs0gFYrYXvVLiFPdN.2G9Gq
 hjcZWdHIWYSMiGXgnuaCET7YCJixNqGsZZ2mmh7wLwB6Y9K0uWwu_QPAdg.K
 zT2gvkozQMJiAnwkUUSu1klC3BxApDC9s4DQF0yb.qXYwZCGEiFr55w--
Received: from [86.30.137.134] by web172302.mail.ir2.yahoo.com via HTTP; Sun, 19 Oct 2014 15:04:51 BST
X-Rocket-MIMEInfo: 002.001,Cg0KDQoNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpPbiBTdW4sIE9jdCAxOSwgMjAxNCAwNToxMiBCU1QgRXJpYyBXb25nIHdyb3RlOg0KDQo.SGluLVRhayBMZXVuZyA8aHRsMTBAdXNlcnMuc291cmNlZm9yZ2UubmV0PiB3cm90ZToNCj4gVGhlIG5ldyBjbG9uZSBoYXM6DQo.IA0KPiA8LS0NCj4gJCBscyAtbHRyIC5naXQvc3ZuLy5jYWNoZXMvDQo.IHRvdGFsIDE0NDc4OA0KPiAtcnctcnctci0tLiAxIEhpbi1UYWsgSGluLVRhayAgMTE2NjEzOCBPY3QgIDcgMTM6NDQgbG9va3VwX3N2bl8BMAEBAQE-
X-Mailer: YahooMailWebService/0.8.203.696
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org






------------------------------
On Sun, Oct 19, 2014 05:12 BST Eric Wong wrote:

>Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> The new clone has:
> 
> <--
> $ ls -ltr .git/svn/.caches/
> total 144788
> -rw-rw-r--. 1 Hin-Tak Hin-Tak  1166138 Oct  7 13:44 lookup_svn_merge.yaml
> -rw-rw-r--. 1 Hin-Tak Hin-Tak 72849741 Oct  7 13:48 check_cherry_pick.yaml
> -rw-rw-r--. 1 Hin-Tak Hin-Tak  1133855 Oct  7 13:49 has_no_changes.yaml
> -rw-rw-r--. 1 Hin-Tak Hin-Tak 73109005 Oct  7 13:53 _rev_list.yaml
> -->
> 
> The old clone has:
>
><snip>
> -rw-rw-r--. 1 Hin-Tak Hin-Tak  40241189 Oct  5 16:42 lookup_svn_merge.yaml
> -rw-rw-r--. 1 Hin-Tak Hin-Tak 225323456 Oct  5 16:49 check_cherry_pick.yaml
> -rw-rw-r--. 1 Hin-Tak Hin-Tak    242547 Oct  5 16:49 has_no_changes.yaml
> -rw-rw-r--. 1 Hin-Tak Hin-Tak  24120007 Oct  5 16:50 _rev_list.yaml
> -->
> 
> I had to suspend somewhat around r59000 - but it is interesting to see
> that the max memory consumption of the later part is almost double?
> and it also runs at 100% rather than 60% overall; I don't know what
> to make of that - probably just smaller changes versus
> larger ones, or different time of day and network loads (yes,
> I guess it is just bandwidth-limited?, since the bulk of CPU time is in system
> rather than user).
>
>git-svn memory usage is insane, and we need to reduce it.
>(on Linux, fork() performance is reduced as memory size of the parent
> grows, and I don't think we can easily call vfork() from Perl)
>
> I am somwhat worry about the dramatic difference between the two .svn/.caches -
> check_cherry_pick.yaml is 225MB in one and 73MB in the other, and also
> _rev_list.yaml is opposite - 24MB vs 73MB. How do I reconcile that?
>
>Calling patterns changed, and it looks like Jakob's changes avoided some
>calls.  The main thing to care about:
>	Does the repository history look right?
>
>The check_cherry_pick cache can be made smaller, too:
>----------------------- 8< -----------------------------
>From: Eric Wong <normalperson@yhbt.net>
>Subject: [PATCH] git-svn: reduce check_cherry_pick cache overhead
>
>We do not need to store entire lists of commits, only the
>number of incomplete and the first commit for reference.
>This reduces the amount of data we need to store in memory
>and on disk stores.
>
>Signed-off-by: Eric Wong <normalperson@yhbt.net>
>---
> perl/Git/SVN.pm | 28 +++++++++++++++-------------
> 1 file changed, 15 insertions(+), 13 deletions(-)
>
>diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
>index 25dbcd5..b2d37cb 100644
>--- a/perl/Git/SVN.pm
>+++ b/perl/Git/SVN.pm
>@@ -1537,7 +1537,7 @@ sub _rev_list {
> 	@rv;
> }
> 
>-sub check_cherry_pick {
>+sub check_cherry_pick2 {
> 	my $base = shift;
> 	my $tip = shift;
> 	my $parents = shift;
>@@ -1552,7 +1552,8 @@ sub check_cherry_pick {
> 			delete $commits{$commit};
> 		}
> 	}
>-	return (keys %commits);
>+	my @k = (keys %commits);
>+	return (scalar @k, $k[0]);
> }
> 
> sub has_no_changes {
>@@ -1597,7 +1598,7 @@ sub tie_for_persistent_memoization {
> 		mkpath([$cache_path]) unless -d $cache_path;
> 
> 		my %lookup_svn_merge_cache;
>-		my %check_cherry_pick_cache;
>+		my %check_cherry_pick2_cache;
> 		my %has_no_changes_cache;
> 		my %_rev_list_cache;
> 
>@@ -1608,11 +1609,11 @@ sub tie_for_persistent_memoization {
> 			LIST_CACHE => ['HASH' => \%lookup_svn_merge_cache],
> 		;
> 
>-		tie_for_persistent_memoization(\%check_cherry_pick_cache,
>-		    "$cache_path/check_cherry_pick");
>-		memoize 'check_cherry_pick',
>+		tie_for_persistent_memoization(\%check_cherry_pick2_cache,
>+		    "$cache_path/check_cherry_pick2");
>+		memoize 'check_cherry_pick2',
> 			SCALAR_CACHE => 'FAULT',
>-			LIST_CACHE => ['HASH' => \%check_cherry_pick_cache],
>+			LIST_CACHE => ['HASH' => \%check_cherry_pick2_cache],
> 		;
> 
> 		tie_for_persistent_memoization(\%has_no_changes_cache,
>@@ -1636,7 +1637,7 @@ sub tie_for_persistent_memoization {
> 		$memoized = 0;
> 
> 		Memoize::unmemoize 'lookup_svn_merge';
>-		Memoize::unmemoize 'check_cherry_pick';
>+		Memoize::unmemoize 'check_cherry_pick2';
> 		Memoize::unmemoize 'has_no_changes';
> 		Memoize::unmemoize '_rev_list';
> 	}
>@@ -1648,7 +1649,8 @@ sub tie_for_persistent_memoization {
> 		return unless -d $cache_path;
> 
> 		for my $cache_file (("$cache_path/lookup_svn_merge",
>-				     "$cache_path/check_cherry_pick",
>+				     "$cache_path/check_cherry_pick", # old
>+				     "$cache_path/check_cherry_pick2",
> 				     "$cache_path/has_no_changes")) {
> 			for my $suffix (qw(yaml db)) {
> 				my $file = "$cache_file.$suffix";
>@@ -1817,15 +1819,15 @@ sub find_extra_svn_parents {
> 		}
> 
> 		# double check that there are no missing non-merge commits
>-		my (@incomplete) = check_cherry_pick(
>+		my ($ninc, $ifirst) = check_cherry_pick2(
> 			$merge_base, $merge_tip,
> 			$parents,
> 			@all_ranges,
> 		       );
> 
>-		if ( @incomplete ) {
>-			warn "W:svn cherry-pick ignored ($spec) - missing "
>-				.@incomplete." commit(s) (eg $incomplete[0])\n";
>+		if ($ninc) {
>+			warn "W:svn cherry-pick ignored ($spec) - missing " .
>+				"$ninc commit(s) (eg $ifirst)\n";
> 		} else {
> 			warn
> 				"Found merge parent ($spec): ",
>-- 
>EW
