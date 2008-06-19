From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git-rerere observations and feature suggestions
Date: Thu, 19 Jun 2008 10:21:56 +0200
Message-ID: <20080619082156.GB12727@diana.vm.bytemark.co.uk>
References: <20080616110113.GA22945@elte.hu> <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <20080616190911.GA7047@elte.hu> <20080618105731.GA9242@elte.hu> <m33anao11u.fsf@localhost.localdomain> <20080618223821.GJ29404@genesis.frugalware.org> <20080619072308.GA12727@diana.vm.bytemark.co.uk> <7v7iclx4nw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 10:23:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9FQb-0003JT-Rp
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 10:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbYFSIWi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 04:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756559AbYFSIWi
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 04:22:38 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4146 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbYFSIWg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 04:22:36 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K9FP3-0003Xu-00; Thu, 19 Jun 2008 09:21:57 +0100
Content-Disposition: inline
In-Reply-To: <7v7iclx4nw.fsf@gitster.siamese.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85458>

On 2008-06-19 00:30:43 -0700, Junio C Hamano wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > So how many parents can a commit have, exactly? Is there a hard
> > limit somewhere, or just a point beyond which some git tools will
> > start behaving strangely?
>
> There is no hard limit at the data structure level.
>
> git-commit-tree has a hard limit of accepting 16 parents. git-blame
> has the same 16-parent limit while following the history (but the
> one in 'next' has lifted the latter limitation).

Thanks.

> But that is purely academic. Anybody who does an octopus with more
> than 8 legs should get his head examined ;-).

Catalin and I are tossing ideas around for how to represent the
history of an StGit patch stack (using a git commit for each log
entry). One complication is that we have to keep references to all
unapplied patches so that gc will leave them alone (and so that they
will get carried along during a pull, in the future). And the number
of unapplied patches is potentially large, so I thought we'd be going
to have to make a tree of "merge" commits to connect them all up.

(What we'd really like, of course, is a way to refer to a set of
commits such that they are guaranteed to be reachable (in the gc and
pull sense), but not considered "parents".)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
