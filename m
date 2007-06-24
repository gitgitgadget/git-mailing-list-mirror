From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: 100%
Date: Mon, 25 Jun 2007 00:23:23 +0200
Message-ID: <467EEEDB.9030301@lsrfire.ath.cx>
References: <20070621030622.GD8477@spearce.org> <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org> <Pine.LNX.4.64.0706211248420.4059@racer.site> <20070621131915.GD4487@coredump.intra.peff.net> <Pine.LNX.4.64.0706220214250.4059@racer.site> <467B777D.C47BFE0E@eudaptics.com> <Pine.LNX.4.64.0706221122200.4059@racer.site> <86ps3oi7ma.fsf_-_@lola.quinscape.zz> <Pine.LNX.4.64.0706221347480.4059@racer.site> <86abusi1fw.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706230222330.4059@racer.site> <467CF380.6060603@lsrfire.ath.cx> <Pine.LNX.4.64.0706231154300.4059@racer.site> <467D06D4.9050203@lsrfire.ath.cx> <Pine.LNX.4.64.0706231259021.4059@racer.site> <467D0DE8.6030104@lsrfire.ath.cx> <Pine.LNX.4.64.0706231318180.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 25 00:23:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2aUe-0003db-Jp
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 00:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbXFXWXj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 24 Jun 2007 18:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbXFXWXj
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 18:23:39 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:40536
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751692AbXFXWXi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jun 2007 18:23:38 -0400
Received: from [10.0.1.201] (p508E4382.dip.t-dialin.net [80.142.67.130])
	by neapel230.server4you.de (Postfix) with ESMTP id 949797049;
	Mon, 25 Jun 2007 00:23:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
In-Reply-To: <Pine.LNX.4.64.0706231318180.4059@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50833>

Johannes Schindelin schrieb:
> Hi,
>=20
> On Sat, 23 Jun 2007, Ren=E9 Scharfe wrote:
>=20
>> As I already hinted at, the common result of comparing two files, as=
=20
>> done by e.g. cmp(1), is one bit that indicates equality.  This=20
>> information is lost when using up/down rounding, but it is retained =
when=20
>> rounding down.  It's _not_ common to be unable to determine equality=
=20
>> from the result of a file compare.
>=20
> And as _I_ already hinted, this does not matter. The whole purpose to=
 have=20
> a number here instead of a bit is to have a larger range. In practice=
, I=20
> bet that the 100% are really uninteresting. At least here, they are.

You would lose your bet since both David and me expressed interest in
that pure 100% thing.

Rounding down instead of up/down doesn't affect the size of neither the
input nor the output range.  It affects the boundary of the input range=
,
 (-0.499 .. 100.499 versus 0.000 .. 100.999), but I can't find a proble=
m
with that.

> For example, if you move a Java class from one package into another, =
you=20
> have to change the package name in the file. Guess what, I am perfect=
ly=20
> okay if the rename detector says "100% similarity" here. Because if i=
t is=20
> closer to 100% than to 99%, dammit, I want to see 100%, not 99%.

That uses a side effect of rounding and won't work for small files.  An=
d
of course (if the file is large enough) there could be other changes
"hidden" in a similarity index value of 100% that was rounded up.

> Nuff said about this subject.

Yes, let's advance this topic to the coding stage.

Ren=E9
