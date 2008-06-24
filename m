From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 00/10] Support writing pack index version 2
Date: Wed, 25 Jun 2008 00:48:29 +0200
Message-ID: <200806250048.29892.robin.rosenberg.lists@dewire.com>
References: <1214273408-70793-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 00:53:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBHOA-0000Za-K6
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 00:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691AbYFXWwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 18:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754636AbYFXWwb
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 18:52:31 -0400
Received: from av9-1-sn3.vrr.skanova.net ([81.228.9.185]:38748 "EHLO
	av9-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622AbYFXWwa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 18:52:30 -0400
Received: by av9-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id B921E38061; Wed, 25 Jun 2008 00:52:28 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av9-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 909DD3803F; Wed, 25 Jun 2008 00:52:28 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 7442937E42;
	Wed, 25 Jun 2008 00:52:28 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1214273408-70793-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86172>


Ocular review looks fine, but nevertheless some tests break.

-- robin

org.spearce.jgit--All-Tests
org.spearce.jgit.lib.PackIndexV2Test
testIteratorMethodsContract(org.spearce.jgit.lib.PackIndexV2Test)
java.io.IOException: Unreadable pack index: /home/me/SW/EGIT.contrib/org.spearce.jgit.test/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2
	at org.spearce.jgit.lib.PackIndex.open(PackIndex.java:95)
	at org.spearce.jgit.lib.PackIndexTest.setUp(PackIndexTest.java:54)
	at junit.framework.TestCase.runBare(TestCase.java:128)
	at junit.framework.TestResult$1.protect(TestResult.java:106)
	at junit.framework.TestResult.runProtected(TestResult.java:124)
	at junit.framework.TestResult.run(TestResult.java:109)
	at junit.framework.TestCase.run(TestCase.java:120)
	at junit.framework.TestSuite.runTest(TestSuite.java:230)
	at junit.framework.TestSuite.run(TestSuite.java:225)
	at org.eclipse.jdt.internal.junit.runner.junit3.JUnit3TestReference.run(JUnit3TestReference.java:130)
	at org.eclipse.jdt.internal.junit.runner.TestExecution.run(TestExecution.java:38)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.runTests(RemoteTestRunner.java:460)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.runTests(RemoteTestRunner.java:673)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.run(RemoteTestRunner.java:386)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.main(RemoteTestRunner.java:196)
Caused by: java.io.EOFException: Short read of block.
	at org.spearce.jgit.util.NB.readFully(NB.java:67)
	at org.spearce.jgit.lib.PackIndexV1.<init>(PackIndexV1.java:75)
	at org.spearce.jgit.lib.PackIndex.open(PackIndex.java:91)
	... 14 more

testIteratorReturnedValues1(org.spearce.jgit.lib.PackIndexV2Test) 
	same trace

testCompareEntriesOffsetsWithFindOffsets(org.spearce.jgit.lib.PackIndexV2Test)
	same trace

testIteratorReturnedValues2(org.spearce.jgit.lib.PackIndexV2Test)
	same trace

Together with Marek's packwrite patches the list gets even longer (his patches alone are "green"). I'm
not including them here.

-- robin
