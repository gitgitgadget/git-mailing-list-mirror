From: David Brown <git@davidb.org>
Subject: Re: Cherry picking instead of merges.
Date: Thu, 3 Jul 2008 21:40:32 -0700
Message-ID: <20080704044032.GA4445@old.davidb.org>
References: <20080703182650.GA11166@old.davidb.org> <alpine.LFD.1.10.0807031403380.2815@woody.linux-foundation.org> <20080703223949.GA23092@old.davidb.org> <20080704001003.GA19053@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 04 06:41:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEd70-0000Gv-AX
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 06:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbYGDEki convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jul 2008 00:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbYGDEkh
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 00:40:37 -0400
Received: from mail.davidb.org ([66.93.32.219]:58318 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162AbYGDEkh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 00:40:37 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1KEd61-0002t5-0K; Thu, 03 Jul 2008 21:40:33 -0700
Content-Disposition: inline
In-Reply-To: <20080704001003.GA19053@atjola.homenet>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87360>

On Fri, Jul 04, 2008 at 02:10:03AM +0200, Bj=F6rn Steinbrink wrote:

>The other one is merging:
>
>  A---B---C---M
>   \         /
>    D---E---/
>
>Of course, you should end up with the same tree either way. It's just =
a
>different way of getting towards that final state. So commit E' and
>commit M, while different commits, would point to the same tree object=
=2E

Ok.  I guess I need to explain a little further.  The advice I've gotte=
n is
good, BTW.

After we've resolved the merge and committed it, we've then discovered =
that
it doesn't work.  However, there are around 100 commits on both branche=
s of
the merges and it would be nice to come up with some way of doing somet=
hing
like a bisect.

The trick is that the branch being merged in doesn't actually work on o=
ur
platform, so I can't just test the alternate branch.

But, git-bisect isn't being all that helpful here.  The problem is that=
 the
only conflicts we resolved is how the two trees were put together.  Pic=
king
points in the middle seem to generate lots of similar, but not quite th=
e
same conflicts.

A cherry-picked tree would allow for an easy bisect, since all of the
intermediary versions would work.  If I somehow knew magical points wit=
hin
the other tree I could do some number of merges and the bisect would st=
ill
work.  I suppose I could do the merges one at a time, but it would make=
 the
history rather verbose.

Thanks,
David
