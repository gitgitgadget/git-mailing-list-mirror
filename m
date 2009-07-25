From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH] Fix WindowCacheGetTest.testCache_TooSmallLimit failures
Date: Sun, 26 Jul 2009 01:25:31 +0200
Message-ID: <200907260125.32306.robin.rosenberg.lists@dewire.com>
References: <85647ef50907220623i2b7e50dal67650a638921ec0f@mail.gmail.com> <20090725194254.GC11191@spearce.org> <20090725200056.GD11191@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 26 01:25:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUqcf-0003EM-Ht
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 01:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbZGYXZj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Jul 2009 19:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752570AbZGYXZj
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 19:25:39 -0400
Received: from mail.dewire.com ([83.140.172.130]:25706 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbZGYXZi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jul 2009 19:25:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 216FE1481DBD;
	Sun, 26 Jul 2009 01:25:38 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YD7lQ2RrX3wb; Sun, 26 Jul 2009 01:25:35 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id E4A641481DB2;
	Sun, 26 Jul 2009 01:25:34 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <20090725200056.GD11191@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124096>

l=F6rdag 25 juli 2009 22:00:56 skrev "Shawn O. Pearce" <spearce@spearce=
=2Eorg>:
> Ever since 2d77d30b5f when I rewrote WindowCache we have been seeing
> random failures inside of the TooSmallLimit test case.
>=20
> These test failures have been occurring because the cache contained
> more open bytes than it was configured to permit.
>=20
> The cache was permitted to open more bytes than its configured limit
> because the eviction routine was always skipping the last bucket
> under some conditions.  If the cache table was sized the same as its
> evictBatch, which happens for any fairly small table, the eviction
> routine broke too early if it started at a non-zero position in the
> table and wrapped around during its search.  By breaking too early
> the routine did not actually perform an eviction, leaving windows
> open it should have closed.

We should have a test for that then.

-- robin
