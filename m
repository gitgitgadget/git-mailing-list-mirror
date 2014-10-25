From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: Anomaly with the new code - Re: git-svn performance
Date: Sat, 25 Oct 2014 06:29:45 +0100
Message-ID: <1414214985.98758.BPMail_high_carrier@web172306.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Sat Oct 25 22:44:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xi8Bq-0006YP-C1
	for gcvg-git-2@plane.gmane.org; Sat, 25 Oct 2014 22:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbaJYUny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2014 16:43:54 -0400
Received: from nm2-vm3.bullet.mail.ir2.yahoo.com ([212.82.96.83]:45435 "EHLO
	nm2-vm3.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751019AbaJYUny convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2014 16:43:54 -0400
Received: from [212.82.98.53] by nm2.bullet.mail.ir2.yahoo.com with NNFMP; 25 Oct 2014 05:29:45 -0000
Received: from [212.82.98.75] by tm6.bullet.mail.ir2.yahoo.com with NNFMP; 25 Oct 2014 05:29:45 -0000
Received: from [127.0.0.1] by omp1012.mail.ir2.yahoo.com with NNFMP; 25 Oct 2014 05:29:45 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 662556.73224.bm@omp1012.mail.ir2.yahoo.com
Received: (qmail 14258 invoked by uid 60001); 25 Oct 2014 05:29:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1414214985; bh=K1/+tWl1VT0CEclT++nG6SSvrBKnSVD1T9onpsnhuac=; h=Message-ID:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=moszOYwdLog3hgpLHfgalpusWKp18My9nfZXIZhYcRqMFIbfwK/1DFlQN0Hm81vXdkL108yB1X3L8LykESHJGNV1qnmFqeUl1Ak7f+J20h9UXDJ8G1B6g/395EoGwWc1kNGTYS6JcXcmwPbksJJ60cVdCP7WLDPGhjw3+WoaXgI=
X-YMail-OSG: z54cfXsVM1kHIwtnMq3_uj4ZvVRvrEFrvadglSgyP.j2LWY
 JPj7AcQgMTUN6PopqidAYhTrfIEI9oprkjIOZHUh2uye7cvtfJ6t_AvyzhMu
 UQjmry9PYWrZtIujqCKqebpDjjjImvMh9n7nq7Nl3XCREqgy6BIzi9E8283B
 TTbn9ltebCzo5vgkokSfq.QV.x7kdD8e7uOl9V_4peBUYhU5G8EjNomnyT2I
 bJTkEyh745dpNDCPaT_pM2BRFs8LmWlH.fSwomMHKl_KObxoWH2WiKR9_1KG
 Sbal3573bweDV2H11BcXRHmp5ddlakzqNj_jsJVj6ygUIu3IQ1DEdC17TnKt
 jxoOg0AKTlbhb6lNg7EL3q7m_lflJO2JKXLkYfI2pMH6CEmXVs0KDmxpJ8lX
 1hnxNiK_lvF.hiI0mimIeskxPYIg7a.NNRUpNujvbu_2ZDU0aLognzXsT9jI
 S5eUyXZBHf1Ox83R5MCYIZqR4rWFUvg6PRh0X_xujrkOXkYN_pVy5MKFdmT6
 mpHd0sag2uCo3Yhmo_RZN7DDMQKu8HZh.bMKq06PB4oGIZhk.A6hypm4i3H6
 RMAxyHNAyTS0s4Rt2aXBJVBi8Fa1F1ll7SCDA8PZPlFpMIX95LptKYuR9xax
 ufSxWpqCzX.5r6hvPPKqX8ASAYZ4GHs4166U8YKZpjpOqSk869tkpz55LnHk
 -
Received: from [86.30.137.134] by web172306.mail.ir2.yahoo.com via HTTP; Sat, 25 Oct 2014 06:29:45 BST
X-Rocket-MIMEInfo: 002.001,Cg0KDQoNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpPbiBTYXQsIE9jdCAyNSwgMjAxNCAwMDozNCBCU1QgRXJpYyBXb25nIHdyb3RlOg0KDQo.SGluLVRhayBMZXVuZyA8aHRsMTBAdXNlcnMuc291cmNlZm9yZ2UubmV0PiB3cm90ZToNCj4.IEkga2VlcCB0YWJzIG9mIGEgcGFydGljdWxhciBzdm4gcmVwb3NpdG9yeSBvdmVyIG1hbnkgeWVhcnMNCj4.IGFuZCBydW4gImdpdCBzdm4gZmV0Y2ggLS1hbGwiIGV2ZXJ5IGZldyBkYXlzLiBTbyB0aGF0J3MgdGhlIG9sZCBjbG9uZS4NCj4.IFNpbmMBMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailWebService/0.8.203.733
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org






------------------------------
On Sat, Oct 25, 2014 00:34 BST Eric Wong wrote:

>Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
>> I keep tabs of a particular svn repository over many years
>> and run "git svn fetch --all" every few days. So that's the old clone.
>> Since this discussion started, I made a new one with git 2.1.0 patched
>> with the first two patches below, a couple of weeks ago. And I ran
>> 'git svn fetch --all' on both every few days since.
>> 
>> I have added a few more patches, so the whole list is the 6
>> below against 2.1.0. The latest fetch is really strange - the fetch against
>> the new clone took almost twice as long and uses almost twice
>> as much memory, vs against the old. 17 min, 800 MB vs 10 min 400MB.
>> Details below. Maybe this is a performance issue about how the clones
>> were made?
>
>Memory usage seems to grow with the amount of revisions fetched,
>see below.  And higher memory means slower fork() on Linux systems.
>

but this is fetching the same number of revisions, and same revisions to keep the two clone in sync. So the issue is about how distant history is stored and used/searched, i think.

>> 0001-git-svn-only-look-at-the-new-parts-of-svn-mergeinfo.patch    
>> 0002-git-svn-only-look-at-the-root-path-for-svn-mergeinfo.patch   
>> 0003-git-svn-reduce-check_cherry_pick-cache-overhead.patch        
>> 0004-git-svn-cache-only-mergeinfo-revisions.patch                 
>
>> 0006-git-svn-clear-global-SVN-pool-between-get_log-invoca.patch   
>
>0006 is insufficient and incompatible with older SVN.
>I pushed "git-svn: reload RA every log-window-size"
>(commit dfa72fdb96befbd790f623bb2909a347176753c2) instead
>which saves much more memory:
>

it is fetching against the new clone taking twice as long and consuming twice as much memory.

>http://mid.gmane.org/20141024225352.GB31716@dcvr.yhbt.net
>
>But there still seems to be some slow growth with many revisions
>which is not mergeinfo-related.
>
>> 0007-git-svn-remove-mergeinfo-rev-caching.patch 
>
>I think it is also safe to remove the _rev_list memoization since
>it uses a lot of memory.  The remaining caches should be tiny
>(but useful, I think).
