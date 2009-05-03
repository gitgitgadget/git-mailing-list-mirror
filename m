From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 8/6] Fix zero context insert and delete hunk headers to match CGit
Date: Sun, 3 May 2009 11:24:07 +0200
Message-ID: <200905031124.08113.robin.rosenberg.lists@dewire.com>
References: <20090503000540.GN23604@spearce.org> <200905031025.53084.robin.rosenberg.lists@dewire.com> <49FD5662.9070004@pelagic.nl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miles Bader <miles@gnu.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Sun May 03 11:26:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0Xxp-0007v1-LN
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 11:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbZECJYP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 May 2009 05:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbZECJYP
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 05:24:15 -0400
Received: from mail.dewire.com ([83.140.172.130]:4586 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730AbZECJYO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 May 2009 05:24:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C6FC780027D;
	Sun,  3 May 2009 11:24:10 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kd2ZIBTzRLDt; Sun,  3 May 2009 11:24:10 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id 077FA800277;
	Sun,  3 May 2009 11:24:09 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <49FD5662.9070004@pelagic.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118171>

s=F6ndag 03 maj 2009 10:31:30 skrev "Ferry Huberts (Pelagic)" <ferry.hu=
berts@pelagic.nl>:
> > 3) We should have a convention like C Git for marking known breakag=
es.
> > One option is FIXME, another it so go JUnit 4 and abuse the expecte=
d exception=20
> > annotation (using it for declaring OK exceptions is pretty bad use =
anyway I think,
> > so we might use it for something better), or perhaps the @Ignore an=
notation which
> > is meant specifically for this and other cases. A FIXME can be impl=
emented right
> > away.
>=20
> standard pratice for junit would be to write a test case on what you =
would=20
> expect to be _correct_ behaviour. obviously that test would then fail=
=2E
> it would be a know failure in the test suite. do not go ignoring it. =
it's=20
> better to keep being reminded that stuff doesn't work :-)

What I've see so far is that people start ignoring almost any failure, =
including new ones, when the test suites contains fails with "known" fa=
ilues. The assumption is that the failed tests were the same as before.

Worse, automated tests have a hard time telling the difference. Current=
ly I ran
the jgit tests as part of the Eclipse plugin build and I want it to sto=
p if there is a problem that we don't know of.=20

"Annotation" of different kinds can be "grepped" for so we can find the=
 broken
cases separately and even refuse completion of release builds if we dec=
ide
on that.=20

Our primary UI right now is the Eclipse JUnit tests runner and I don't =
want
to be remined of Shawn's or whoever's bugs when trying to make sure I d=
on't
break anything. Red =3D *I* broke something or found something new.=20

TestNG has a nice way of classifying tests so, we could mark failures a=
s "known failures" and specifically exclude/include them when invoking =
the
JUnit tests.

Best is to fix before we apply the patches as happened this time. So th=
is problem still remains theoretical :)

-- robin


-- robin
