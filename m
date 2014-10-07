From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: git svn's performance issue and strange pauses, and other thing
Date: Tue, 7 Oct 2014 19:20:46 +0100
Message-ID: <1412706046.90413.YahooMailBasic@web172303.mail.ir2.yahoo.com>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, stoklund@2pi.dk, sam@vilain.net,
	stevenrwalter@gmail.com, waste.manager@gmx.de, amyrick@apple.com
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Tue Oct 07 20:27:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbZTV-0001nw-NZ
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 20:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbaJGS1A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Oct 2014 14:27:00 -0400
Received: from nm40-vm7.bullet.mail.ir2.yahoo.com ([212.82.97.175]:36132 "EHLO
	nm40-vm7.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932110AbaJGS07 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Oct 2014 14:26:59 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Oct 2014 14:26:59 EDT
Received: from [212.82.98.62] by nm40.bullet.mail.ir2.yahoo.com with NNFMP; 07 Oct 2014 18:20:47 -0000
Received: from [212.82.98.86] by tm15.bullet.mail.ir2.yahoo.com with NNFMP; 07 Oct 2014 18:20:46 -0000
Received: from [127.0.0.1] by omp1023.mail.ir2.yahoo.com with NNFMP; 07 Oct 2014 18:20:46 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 927059.15878.bm@omp1023.mail.ir2.yahoo.com
Received: (qmail 35830 invoked by uid 60001); 7 Oct 2014 18:20:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1412706046; bh=1hYSQahCuMElk1mOUQjGF8EeiSQ5huTPyJXN5bk+kzs=; h=Message-ID:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=ohWc7sh3iIf9UHk9nAyG7R6stERq92gSBnPpCyQbUIJgK9aZlZC6WQyOCdw5H1OnYnJKehpmfMn2CNOyDjx+on6iVHlv9I7zbhwXBwDasObnPsd5WExUZh3CLEWnU4+yEt2n4dABfrqPuPrEKY8Yvi/qc6Z1aHTCveGXEL5CJXA=
X-YMail-OSG: PODJflsVM1kSDN03v1wlLVJ3nI93wlkXtYA5kElzJG3EZF_
 TK3Av5mGaAx0X2Rab5.kLCB2c7Gd4fahlgGJDfebptWE.8NSF1cWPuqYDwxV
 gq.dlucHQyYDll9hEMt7JbVdbRErC4rON4Zqf_Wjf11h7LDvM5Rc.jIQPKNu
 DqsTpU5d8Gxtmsie6FzaERv0YJpjYstGYkxldbWJpdwFquWAsax2D4V26L7q
 cOZsqWkisWcEb0AFmTmHLrhVTRf7SqIGaodXnSKGqotaBYB4LOBtXmIq4jH2
 5z2D5jmbZjViRu8c44bFbHABOp.CYc3m03f73r0nhvR2yMUi0tDbm.LL5ApC
 NbjEr9UzRxFPcCtbT0uVQPm3.2s6rGHjSLKokQnqpumKQ0_oJgyKQc1TgAmZ
 ItFpyJdMZIN0mBcauE__tshvYgkDnP4e_xnpH_I2Kvw6dO3A1uISCDHs9MJF
 cYT9nbkONLEbxNRIxLe2lE8Ock4KvBlBMaLfWc1Nkg_JabdzD4lEjQFBvNk7
 CSoXQEKfbMoZEDsz6Yr0xjzcU7Wiqm9.6kxllEgO0n5tvTA.eaBxOzkiN6v9
 Uuxd5ODFuHSA7PcLuPq6baSHNJzbPcLi2cFeLcvKECWdszE9BDdIZ8uEg7v6
 CU53vH7bV0Mi82qxTYo5y7NPZOSSZxwPjeJt.mLp0xp_1tNY-
Received: from [86.30.137.134] by web172303.mail.ir2.yahoo.com via HTTP; Tue, 07 Oct 2014 19:20:46 BST
X-Rocket-MIMEInfo: 002.001,LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpPbiBUdWUsIE9jdCA3LCAyMDE0IDAwOjUxIEJTVCBIaW4tVGFrIExldW5nIHdyb3RlOg0KDQo.LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo.T24gU3VuLCBPY3QgNSwgMjAxNCAwMjowMiBCU1QgRXJpYyBXb25nIHdyb3RlOg0KDQo8c25pcHBlZD4NCj4.SGluLVRhazogaGF2ZSB5b3UgdHJpZWQgSmFrb2IncyBwYXRjaGVzP8KgIEkndmUgdGFrZW4gYW5vdGhlciBsb29rLA0KPj5zaWduZWQtb2ZmIGFuZCBwdXNoZWQgdG8gbXkgbWFzdGVyLg0BMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/799 YahooMailWebService/0.8.203.696
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

------------------------------
On Tue, Oct 7, 2014 00:51 BST Hin-Tak Leung wrote:

>------------------------------
>On Sun, Oct 5, 2014 02:02 BST Eric Wong wrote:

<snipped>
>>Hin-Tak: have you tried Jakob's patches?=A0 I've taken another look,
>>signed-off and pushed to my master.

=2E.. Then
>I changed my mind, and decided what the hell, let's clone the whole
>thing again :-). So I made a new directory, run 'git init', just copy
>.git/config from the old reop and am doing 'git svn fetch --all' in th=
e new empty
>directory again.
>
>So far it seems to be good. But I am only at revision 35700-ish at the=
 moment,
>and the whole thing is 66700-ish. Oh, I forgot to mention that the str=
ange
>pauses seem to be followed by messages like these:
>
>W:svn cherry-pick ignored (/branches/R-2-12-branch:52939,54476,55265) =
- missing 492 commit(s) (eg 9bf20dca6a8b05dff28e6486b1613f10825972c9)
>W:svn cherry-pick ignored (/branches/R-2-13-branch:55265,55432) - miss=
ing 231 commit(s) (eg 9290cf6ce2d7f6cca168cf326eed6e9fe760895f)
>W:svn cherry-pick ignored (/branches/R-2-15-branch:58894,59717) - miss=
ing 405 commit(s) (eg ed84a373b33f728949edf3371829fc3414c343a8)
>W:svn cherry-pick ignored (/branches/R-3-0-branch:62497) - missing 154=
 commit(s) (eg 9e4742d201771c9658417c2d2f83838e550e3162)
>W:svn cherry-pick ignored (/trunk:
>
>So presumably I'd only see interesting behavior when there are a numbe=
r of branches.
>It seems the first branches are around revision 48000-ish, so I might =
have
>to wait a bit.
>
>So far, the new clone hasn't created ".git/svn/.caches/" yet; and memo=
ry consumption seems
>okay also.

The changes definitely improve, as far as my impression goes. There was=
 only one notable pause around
r50651, and it is probably because the rather large "Checking svn:merge=
info changes since r15413"
from r15413? That took about 12 minutes. Other instances of "W:svn cher=
ry-pick ignored"
though do take a while, are in the seconds region - before the code cha=
nges they could
be minutes, if memory serves.

<--
	M	src/library/tools/R/toHTML.R
r50650 =3D bed91d435c535f2643cf0d48623fecf86d264bd9 (refs/remotes/trunk=
)
	M	src/modules/X11/rotated.c
	M	src/modules/X11/dataentry.c
Checking svn:mergeinfo changes since r15413: 1 sources, 1 changed
W:svn cherry-pick ignored (/trunk:28840) - missing 9372 commit(s) (eg c=
ea6142c76300539a0d0c9c743738e31a9f7d523)
r50651 =3D ad139a5bf91f9ad6690ff5fb4a3f71cea591a944 (refs/remotes/R-uth=
reads)
-->

The new clone has:

<--
$ ls -ltr .git/svn/.caches/
total 144788
-rw-rw-r--. 1 Hin-Tak Hin-Tak  1166138 Oct  7 13:44 lookup_svn_merge.ya=
ml
-rw-rw-r--. 1 Hin-Tak Hin-Tak 72849741 Oct  7 13:48 check_cherry_pick.y=
aml
-rw-rw-r--. 1 Hin-Tak Hin-Tak  1133855 Oct  7 13:49 has_no_changes.yaml
-rw-rw-r--. 1 Hin-Tak Hin-Tak 73109005 Oct  7 13:53 _rev_list.yaml
-->

The old clone has:

<---
$ ls -ltr .git/svn/.caches/
total 318824
-rw-rw-r--. 1 Hin-Tak Hin-Tak   5711724 Jul 24  2012 lookup_svn_merge.d=
b
-rw-rw-r--. 1 Hin-Tak Hin-Tak  30523628 Jul 24  2012 check_cherry_pick.=
db
-rw-rw-r--. 1 Hin-Tak Hin-Tak    296592 Jul 24  2012 has_no_changes.db
-rw-rw-r--. 1 Hin-Tak Hin-Tak  40241189 Oct  5 16:42 lookup_svn_merge.y=
aml
-rw-rw-r--. 1 Hin-Tak Hin-Tak 225323456 Oct  5 16:49 check_cherry_pick.=
yaml
-rw-rw-r--. 1 Hin-Tak Hin-Tak    242547 Oct  5 16:49 has_no_changes.yam=
l
-rw-rw-r--. 1 Hin-Tak Hin-Tak  24120007 Oct  5 16:50 _rev_list.yaml
-->

I had to suspend somewhat around r59000 - but it is interesting to see
that the max memory consumption of the later part is almost double?
and it also runs at 100% rather than 60% overall; I don't know what
to make of that - probably just smaller changes versus
larger ones, or different time of day and network loads (yes,
I guess it is just bandwidth-limited?, since the bulk of CPU time is in=
 system
rather than user).

I am somwhat worry about the dramatic difference between the two .svn/.=
caches -
check_cherry_pick.yaml is 225MB in one and 73MB in the other, and also
_rev_list.yaml is opposite - 24MB vs 73MB. How do I reconcile that?

<--
	M	src/main/dotcode.c
	M	doc/NEWS.Rd
r59140 =3D b6014a226aebf9e016c89c0bd1aca1979796a057 (refs/remotes/trunk=
)
	M	src/main/dotcode.c
	M	doc/NEWS.Rd
Checking svn:mergeinfo changes since r59138: 4 sources, 1 changed
W:svn cherry-pick ignored (/trunk:59137,59140) - missing 369 commit(s) =
(eg 8a2a36083ba39be27fc9940acc3f51eab6a7a0c3)
r59141 =3D 38c6d05f164d34e4b5cc545bda387be9d910f748 (refs/remotes/R-2-1=
5-branch)
Connection timed out: Connection timed out at /usr/share/perl5/vendor_p=
erl/Git/SVN/Ra.pm line 290.

Command exited with non-zero status 1
	Command being timed: "git svn fetch --all"
	User time (seconds): 5642.19
	System time (seconds): 23552.44
	Percent of CPU this job got: 57%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 14:06:58
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 349324
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 39
	Minor (reclaiming a frame) page faults: 744713614
	Voluntary context switches: 4761489
	Involuntary context switches: 8595950
	Swaps: 0
	File system inputs: 7712
	File system outputs: 121404296
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 1
-->
<--
	M	src/include/Defn.h
r66719 =3D 1e3288d3ae4cfb15f6e4e4116f18d38b3efc5bb5 (refs/remotes/trunk=
)
	M	doc/NEWS.Rd
r66720 =3D 1c184e5fc2b71a27767215a45a1270f3edbc616f (refs/remotes/trunk=
)
Checked out HEAD:
  https://svn.r-project.org/R/trunk r66720
creating empty directory: tests/Pkgs/exNSS4/man
	Command being timed: "git svn fetch --all"
	User time (seconds): 2126.00
	System time (seconds): 7852.44
	Percent of CPU this job got: 96%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 2:52:38
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 755256
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 6
	Minor (reclaiming a frame) page faults: 142730534
	Voluntary context switches: 898725
	Involuntary context switches: 1842056
	Swaps: 0
	File system inputs: 1800
	File system outputs: 28606392
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
-->
