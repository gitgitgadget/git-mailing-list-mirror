From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sun, 18 Mar 2007 11:53:58 +0100
Organization: Dewire
Message-ID: <200703181153.59768.robin.rosenberg.lists@dewire.com>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org> <alpine.LFD.0.83.0703172228220.18328@xanadu.home> <Pine.LNX.4.64.0703172013340.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 11:51:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSszQ-0003hN-Fz
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 11:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbXCRKvu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 18 Mar 2007 06:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbXCRKvu
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 06:51:50 -0400
Received: from [83.140.172.130] ([83.140.172.130]:4515 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932309AbXCRKvt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Mar 2007 06:51:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9E6AA802855;
	Sun, 18 Mar 2007 11:46:28 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12771-03; Sun, 18 Mar 2007 11:46:28 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 411DB802664;
	Sun, 18 Mar 2007 11:46:26 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <Pine.LNX.4.64.0703172013340.6730@woody.linux-foundation.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42488>

s=F6ndag 18 mars 2007 04:31 skrev Linus Torvalds:
> I'd still like to see the KDE repo, that thing went quiet after it wa=
s=20
> supposed to hit sneaker-net..
>=20
> If it was 30 seconds before to do a "git log" for some individual fil=
e,=20
> after the recent optimizations it should hopefully be down to 10. And=
 I=20
> agree that I might be more motivated to try to get it down further if=
 I=20
> could just find a repository where it's that much.=20

I don't have the KDE repo, but I do have an Eclipse import. Without you=
r
patches I get (hot cache)

# time git log -- org.eclipse.core.resources/src/org/eclipse/core/resou=
rces/ >/dev/null
65.10user 0.50system 1:12.44elapsed 90%CPU (0avgtext+0avgdata 0maxresid=
ent)k
0inputs+0outputs (0major+80242minor)pagefaults 0swaps

With patch 1&2 (hot cache)

# time ~/SW/GIT/git-log -- org.eclipse.core.resources/src/org/eclipse/c=
ore/resources/ >/dev/null
27.51user 0.21system 0:28.23elapsed 98%CPU (0avgtext+0avgdata 0maxresid=
ent)k
0inputs+0outputs (0major+80266minor)pagefaults 0swaps

That's quite an improvement The eclipse repo is about 140k commits in t=
he master branch and=20
has a 3GB pack file (fromcvs import).=20

-- robin
