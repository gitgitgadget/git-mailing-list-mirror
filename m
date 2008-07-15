From: Mark Burton <markb@ordern.com>
Subject: Re: Git describe question
Date: Tue, 15 Jul 2008 07:40:00 +0100
Organization: Order N Ltd.
Message-ID: <20080715074000.110b896e@crow>
References: <20080714085557.246f52b9@crow>
	<7vvdz8hp3d.fsf@gitster.siamese.dyndns.org>
	<20080714092040.4090046b@crow>
	<487BD34F.4080201@gmx.ch>
	<7v1w1wf42n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jean-Luc Herren <jlh@gmx.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 08:42:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIeEs-0003HI-Ud
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 08:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561AbYGOGlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 02:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753355AbYGOGlU
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 02:41:20 -0400
Received: from c2beaomr07.btconnect.com ([213.123.26.185]:13130 "EHLO
	c2beaomr07.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbYGOGlT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 02:41:19 -0400
Received: from crow.ordern.com (host86-128-141-55.range86-128.btcentralplus.com [86.128.141.55])
	by c2beaomr07.btconnect.com (MOS 3.8.6-GA)
	with ESMTP id ANV35071;
	Tue, 15 Jul 2008 07:40:01 +0100 (BST)
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id C50EE190C93;
	Tue, 15 Jul 2008 07:40:00 +0100 (BST)
In-Reply-To: <7v1w1wf42n.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2beaomr07.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A09020A.487C4646.0133,ss=1,fgs=0,
	ip=86.128.141.55,
	so=2007-10-30 19:00:17,
	dmn=5.4.3/2008-02-01
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88532>

On Mon, 14 Jul 2008 16:17:52 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Jean-Luc Herren <jlh@gmx.ch> writes:
> 
> > Mark Burton wrote:
> > ...
> > I don't think people usually say "tag X is on branch Y", excepted
> > maybe if Y has never been merged anywhere.  Specifically, nobody
> > would say v1.5.6.3 is *on* branch master.  But it's part of its
> > history.  v1.5.6.3 is *on* maint, at best.
> 
> Actually I am somewhat sympathetic to Mark here.  Probably what he wants
> is to describe 10ce020 as v1.5.6-390-10ce020.
> 
> While that probably is doable by using the first-parent-only traversal, I
> do not think it is such a good idea.  It is not how branches in git are
> designed to work.  As Merlyn always says in #git at freenode, a branch is
> an illusion, and it is especially true in the presense of fast-forward
> merge (aka the upstream maintainer asking a subsystem lieutenant to do a
> merge for him).

Hi Guys,

Many thanks for the replies which make sense.

I guess the thing that prompted my original email was the fact that
when you look at output from gitk, the "distance" between 1.5.6.3 and
HEAD is only a few commits and that led me to expect that the output of
describe would show a smaller number than it does. I now understand why
it is how it is.

However, the git describe manual page does mention branches:

>With something like git.git current tree, I get:
>
>           [torvalds@g5 git]$ git-describe parent
>           v1.0.4-14-g2414721
>i.e. the current head of my "parent" branch is based on v1.0.4,
>but since it has a handful commits on top of that, describe has added
>the number of additional commits ("14") and an abbreviated object name
>for the commit itself ("2414721") at the end.

If you're a git newbie (like me) those words suggest that the commits
are "on" branch parent and you could measure the direct distance
between them by following the branch. Perhaps, the manual page should
contain a sentence similar to this:

Branches have no influence on the git describe long format output 
which is derived only from the number of commits in the chain from the
described tag to the committish.

Cheers,

Mark
