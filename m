From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Anomaly with the new code - Re: git-svn performance
Date: Fri, 24 Oct 2014 08:06:26 +0100
Message-ID: <1414134386.28852.YahooMailBasic@web172306.mail.ir2.yahoo.com>
References: <1413999510.36832.YahooMailBasic@web172305.mail.ir2.yahoo.com>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: fabian.schmied@gmail.com, git@vger.kernel.org, sam@vilain.net,
	stevenrwalter@gmail.com, waste.manager@gmx.de, amyrick@apple.com
To: normalperson@yhbt.net, stoklund@2pi.dk
X-From: git-owner@vger.kernel.org Fri Oct 24 09:06:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhYxG-0002hi-Pr
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 09:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbaJXHGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 03:06:30 -0400
Received: from nm20-vm6.bullet.mail.ir2.yahoo.com ([212.82.96.248]:36554 "EHLO
	nm20-vm6.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750720AbaJXHG3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2014 03:06:29 -0400
Received: from [212.82.98.63] by nm20.bullet.mail.ir2.yahoo.com with NNFMP; 24 Oct 2014 07:06:27 -0000
Received: from [212.82.98.94] by tm16.bullet.mail.ir2.yahoo.com with NNFMP; 24 Oct 2014 07:06:27 -0000
Received: from [127.0.0.1] by omp1031.mail.ir2.yahoo.com with NNFMP; 24 Oct 2014 07:06:27 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 117507.85376.bm@omp1031.mail.ir2.yahoo.com
Received: (qmail 5490 invoked by uid 60001); 24 Oct 2014 07:06:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1414134386; bh=umpnp42N8fiUjFyGxTTzfJIziXa4NxpKJTJyzWuJmoQ=; h=Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=FVTdXxDk7+cZzdTnyL6Xycnogkt3Z8WikKGC6UWuE5qo5zIXtOzcGx4fDVgv4KdaqMnTxWew+aPVhbxSDeRrEsmqbDBu+x67ysZCt2OL01RqWUw/D9CXWvzEcCs/zdr0dATVhCa9lyPlzI5GFgvOguX5jkuGN1fyvYv/iud+I/8=
X-YMail-OSG: tQe4yTEVM1lrIKCTES29Tz9tzcym7vA0LmsonTyV_SlJ3tW
 XvkLtecYYyMqyktyMvgd5qhpQzEsk4J1dA8y2OO01RHjXk3F97nw2dPGNPA0
 BNyXpZIg76Ft9QivJYHOSy7gS3nfm7pxLBTeFs6x_YTLnFcd4IHrv4RvRGRB
 UurCpBpmXogwoL.4d928h124rPyXsz_2_9TZ7zUOQBmhFtZ35heuZn42EE.B
 yVD2S6THQtb0G_m4LtUwp2JC0zcqjP.FVqQcFQBJhLoQIJJaT6wJhwul_UJ_
 VOsPZJzt5p7IWV2qSHBSmtqHWWsyxFCYKRGZaWnSxjyE3K8wE2F.EqNweS7v
 uSUosPkriztypqKJKD9LrWsONhK5j7YQtl1icRdBwOn44kdNko4jwfKeXwtn
 6xzfOB0NWyyEAjzWoHg3rXLXyCKzo51Wt_.NPoKvmeelfAvp9BLV_ZmvjTCi
 J90L2sArQRBUdw2NfVZj8aWo12Y4d3d6Dbt.TUjmPAIXD.hvlaBm6Gm673hT
 FZmC1biAV5tmYXcm2cpaY9oVumoJrruC4oQPv2aV6X.nDEMoDGkKzgzt7OB7
 Y_MBL
Received: from [86.30.137.134] by web172306.mail.ir2.yahoo.com via HTTP; Fri, 24 Oct 2014 08:06:26 BST
X-Rocket-MIMEInfo: 002.001,SSBrZWVwIHRhYnMgb2YgYSBwYXJ0aWN1bGFyIHN2biByZXBvc2l0b3J5IG92ZXIgbWFueSB5ZWFycw0KYW5kIHJ1biAiZ2l0IHN2biBmZXRjaCAtLWFsbCIgZXZlcnkgZmV3IGRheXMuIFNvIHRoYXQncyB0aGUgb2xkIGNsb25lLg0KU2luY2UgdGhpcyBkaXNjdXNzaW9uIHN0YXJ0ZWQsIEkgbWFkZSBhIG5ldyBvbmUgd2l0aCBnaXQgMi4xLjAgcGF0Y2hlZA0Kd2l0aCB0aGUgZmlyc3QgdHdvIHBhdGNoZXMgYmVsb3csIGEgY291cGxlIG9mIHdlZWtzIGFnby4gQW5kIEkgcmFuDQonZ2l0IHN2biBmZXRjaCAtLWEBMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/810 YahooMailWebService/0.8.203.733
In-Reply-To: <1413999510.36832.YahooMailBasic@web172305.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I keep tabs of a particular svn repository over many years
and run "git svn fetch --all" every few days. So that's the old clone.
Since this discussion started, I made a new one with git 2.1.0 patched
with the first two patches below, a couple of weeks ago. And I ran
'git svn fetch --all' on both every few days since.

I have added a few more patches, so the whole list is the 6
below against 2.1.0. The latest fetch is really strange - the fetch against
the new clone took almost twice as long and uses almost twice
as much memory, vs against the old. 17 min, 800 MB vs 10 min 400MB.
Details below. Maybe this is a performance issue about how the clones
were made?

0001-git-svn-only-look-at-the-new-parts-of-svn-mergeinfo.patch    
0002-git-svn-only-look-at-the-root-path-for-svn-mergeinfo.patch   
0003-git-svn-reduce-check_cherry_pick-cache-overhead.patch        
0004-git-svn-cache-only-mergeinfo-revisions.patch                 
0006-git-svn-clear-global-SVN-pool-between-get_log-invoca.patch   
0007-git-svn-remove-mergeinfo-rev-caching.patch 

(I dropped #5 because it doesn't seem interesting?)

<---
$ /usr/bin/time -v git svn fetch --all
...
	Command being timed: "git svn fetch --all"
	User time (seconds): 622.20
	System time (seconds): 12.52
	Percent of CPU this job got: 98%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 10:42.21
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 399588
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 320
	Minor (reclaiming a frame) page faults: 383987
	Voluntary context switches: 2088
	Involuntary context switches: 68304
	Swaps: 0
	File system inputs: 168288
	File system outputs: 148960
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
[Hin-Tak@localhost R]$ cd ../R-2/
[Hin-Tak@localhost R-2]$ /usr/bin/time -v git svn fetch --all
	M	src/library/stats/R/hclust.R
	M	src/library/stats/R/dendrogram.R
r66853 = 7c18b2e4084529d5912cf789c045f2eab7d4083c (refs/remotes/trunk)
	M	doc/manual/R-exts.texi
r66854 = bc7b131e34eaf04859fede1ecedb796c0a33be02 (refs/remotes/trunk)
	M	doc/manual/R-exts.texi
Checking svn:mergeinfo changes since r66844: 6 sources, 1 changed
W:svn cherry-pick ignored (/trunk:66824,66854) - missing 1084 commit(s) (eg 6453a2d844e27f2963ba87142028b023c50385ef)
r66855 = de5daf8db948732fa96c3d5b32077d8057e2a7e7 (refs/remotes/R-3-1-branch)
	M	src/modules/internet/internet.c
r66856 = a1e9300c6dd49ec4c3dd11f861bca0dbe3ca65b4 (refs/remotes/trunk)
	M	doc/manual/R-admin.texi
r66857 = eb5f3175e67a806482c39def71246f5d18bf8660 (refs/remotes/trunk)
	M	doc/manual/R-admin.texi
Checking svn:mergeinfo changes since r66855: 6 sources, 1 changed
W:svn cherry-pick ignored (/trunk:66854,66857) - missing 1086 commit(s) (eg e8cc0c31ddeeea3f8fa1ad47105d09a2c19e1a98)
r66858 = 10c8013f103d57c8a717b738e2a51c8d397c88f0 (refs/remotes/R-3-1-branch)
	M	VERSION
r66859 = 0f865f247da3191431bb17bcc3c307e8735dbd97 (refs/remotes/R-3-1-branch)
	Command being timed: "git svn fetch --all"
	User time (seconds): 1023.06
	System time (seconds): 15.30
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 17:27.65
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 785332
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 884
	Minor (reclaiming a frame) page faults: 527668
	Voluntary context switches: 2792
	Involuntary context switches: 107718
	Swaps: 0
	File system inputs: 194704
	File system outputs: 170032
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0

--->
