From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Regression and failure to clone/fetch with new code Re: git-svn performance
Date: Tue, 28 Oct 2014 23:33:34 +0000
Message-ID: <1414539214.3654.YahooMailBasic@web172306.mail.ir2.yahoo.com>
References: <1414474807.30075.YahooMailBasic@web172303.mail.ir2.yahoo.com>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Wed Oct 29 00:33:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjGGi-0001Da-VR
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 00:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbaJ1Xdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 19:33:37 -0400
Received: from nm20-vm7.bullet.mail.ir2.yahoo.com ([212.82.96.249]:49837 "EHLO
	nm20-vm7.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932091AbaJ1Xdg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 19:33:36 -0400
Received: from [212.82.98.60] by nm20.bullet.mail.ir2.yahoo.com with NNFMP; 28 Oct 2014 23:33:35 -0000
Received: from [212.82.98.102] by tm13.bullet.mail.ir2.yahoo.com with NNFMP; 28 Oct 2014 23:33:35 -0000
Received: from [127.0.0.1] by omp1039.mail.ir2.yahoo.com with NNFMP; 28 Oct 2014 23:33:34 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 992681.84143.bm@omp1039.mail.ir2.yahoo.com
Received: (qmail 46305 invoked by uid 60001); 28 Oct 2014 23:33:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1414539214; bh=xLHCQwfRgJt9uB4LjB9HwU0XmSVXpGrvgfvmO49HIJg=; h=Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=4N/e93uA30SDsjTFCigCqmZJhIdZFWL2F3DAvorJwa5PAZyh9qGkaKfP3CsemJjLFeRIly0zT5/3bFi7HfSNXtNoP08QKMl32Zs1Pd9qg/7VdR27HU5zyEMMd3UhcIEpZOqi11lOiaOm4x5bnH3dT+13xT+eIJUo2kv4QMtTC9g=
X-YMail-OSG: 2SKMpV0VM1kFor0PulPj._gXvgjqAj1.iV5P_eaD7o1EmYH
 PzoTQQQGLOFPsCgyvjW9PxRs6DJgEZ9xvPvuvJIXiT7VtRigV8jFhPC2HT8U
 fF9vJobe6pxLm0CSon1a7q4CsIrEZhaKssY0w0Hi.CFC_8tx9m4eZv3KNweg
 hm4ur8kB8c.qAmYPNHLMzFrPvCFqk8Gaqrv9TPvJt8FBdn1fpIzGLF_NiZ9T
 RhNqZAmCK99uvpopi.RV_VNwVPhekF13vreiyxxuidRwdU5qfcyAABEEmy6O
 N3RVOOJixj.zqfVUShrtvt1BtL5Qzk8S2Za9.3oBfhDmDKLloPlEqoAImJQB
 KZdBfpZjh3pQLK8lSH4Emui4_dZ5Ahsy4Xxvw_y6jgSbNhfWHbTqKDzh_p6R
 uvr6riOH.zXQpQWbCeEp6EpjECBU2msRyAeiSmSTAj3g_AAccPFc.GCtKqja
 qFMI1oeLcfRmHsmDXC9KHX0yaH3aeYX1lysO28lb300JASaKc__tNemzbk9x
 JQH9s5UFFGRdwc7dBSbfMDF57yGQsjMUvsPR.f_i2aaPN0j.cuz4o_Z2x4ft
 a.c08yzVZhAQUWqYULOHBwEssgXegOHEZdfLOQ5hAkbKQ8f3p89nnzNoG_8D
 BFMB2FC012tInaD0G8Y4yxksmacSqK.ny3JRaBjItU2MxUNOFM2e0uNzDxA-
 -
Received: from [86.30.137.134] by web172306.mail.ir2.yahoo.com via HTTP; Tue, 28 Oct 2014 23:33:34 GMT
X-Rocket-MIMEInfo: 002.001,SGksIEkgcGF0Y2hlZCBteSBzeXN0ZW0gZ2l0IHdpdGggdGhlIHJlY2VudCBnaXQtc3ZuIGltcHJvdmVtZW50cywgYW5kIGp1c3QgdXNlDQppdCBmb3IgZ2VuZXJhbCB1c2U7IHNvIHRoZXNlcyBhcmUgdGhlIHBhdGNoZXMsIGFnYWluc3QgMi4xLjAuDQoNCjAwMDEtZ2l0LXN2bi1vbmx5LWxvb2stYXQtdGhlLW5ldy1wYXJ0cy1vZi1zdm4tbWVyZ2VpbmZvLnBhdGNoDQowMDAyLWdpdC1zdm4tb25seS1sb29rLWF0LXRoZS1yb290LXBhdGgtZm9yLXN2bi1tZXJnZWluZm8ucGF0Y2gNCjAwMDMtZ2l0LXN2bi1yZWQBMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/810 YahooMailWebService/0.8.203.733
In-Reply-To: <1414474807.30075.YahooMailBasic@web172303.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, I patched my system git with the recent git-svn improvements, and just use
it for general use; so theses are the patches, against 2.1.0.

0001-git-svn-only-look-at-the-new-parts-of-svn-mergeinfo.patch
0002-git-svn-only-look-at-the-root-path-for-svn-mergeinfo.patch
0003-git-svn-reduce-check_cherry_pick-cache-overhead.patch
0004-git-svn-cache-only-mergeinfo-revisions.patch
0005-git-svn-remove-mergeinfo-rev-caching.patch
0006-git-svn.txt-advertise-pushurl-with-dcommit.patch
0007-git-svn-reload-RA-every-log-window-size.patch
0008-git-svn-remove-unnecessary-DESTROY-override.patch
0009-git-svn-save-a-little-memory-as-fetch-progresses.patch
0010-git-svn-disable-_rev_list-memoization.patch

trying to do this:
git svn clone http://www.virtualbox.org/svn/vbox/trunk vbox

(there is no publicly visible branches, so it is just a straight-forward single-branch clone).

aborts with 

---------------
	M	src/VBox/Main/HostImpl.cpp
Incorrect parameters given: Could not convert '%ld' into a number at /usr/share/perl5/vendor_perl/Git/SVN.pm line 1711.

$ git svn fetch --all
Index mismatch: d6c75bc195b1daad647322e2cc025bd31265c6b9 != 3927d05f6ab037fcf2b4d964c9633efade037d1b
rereading a65b5fc0077c2fa80a344833b65ac19ff4ae88b6
	M	src/VBox/Main/HostImpl.cpp
Incorrect parameters given: Could not convert '%ld' into a number at /usr/share/perl5/vendor_perl/Git/SVN.pm line 1711.
----------------

I have never seen such behavior before, and seeing as the lines indicated are in
a routine called "mergeinfo_changes", and recently added/changed by
quite a few of the patches, I started reverting from the back in this order: #5, #4, #2, #1 
and tried again between each revert. And it finally allows me to fetch again after
reverting #1.

I don't see any %ld close by, but presumably this is enough information for somebody else
to try. The platform is linux x86_64. (mostly fedora 20 but with a lot of additional
changes like a newer gnome than shipped, etc so probably not really fc20) 
