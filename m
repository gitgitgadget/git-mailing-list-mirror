From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: [PATCH v3 0/5] push: update remote tags only with force
Date: Wed, 14 Nov 2012 09:19:21 +0100
Message-ID: <20121114081921.GA20876@camk.edu.pl>
References: <1352693288-7396-1-git-send-email-chris@rorvick.com>
 <7v4nktdwtp.fsf@alter.siamese.dyndns.org>
 <CAEUsAPYvrR6WsVWCvwoEWA21gzL6Sib0sTyx-c_2tH=8ni69yQ@mail.gmail.com>
 <CAEUsAPZtF-L5J_g1L5d44BKveoAnJ81PatX94fFS4FM=iW33KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 09:19:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYYCI-0002x3-1E
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 09:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432Ab2KNITc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 03:19:32 -0500
Received: from moat.camk.edu.pl ([148.81.175.50]:54431 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755450Ab2KNITb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 03:19:31 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 043E65F004A;
	Wed, 14 Nov 2012 09:18:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lpJipgCo8A0v; Wed, 14 Nov 2012 09:18:38 +0100 (CET)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 0DC515F0049;
	Wed, 14 Nov 2012 09:18:38 +0100 (CET)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id B402443CFD; Wed, 14 Nov 2012 09:19:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAEUsAPZtF-L5J_g1L5d44BKveoAnJ81PatX94fFS4FM=iW33KA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209702>

On Wed, Nov 14, 2012 at 12:29:14AM -0600, Chris Rorvick wrote:

> >>   2. Require force when updating tag references, even on a fast-forward.

> >>      push: flag updates
> >>      push: flag updates that require force
> >>      push: update remote tags only with force

> >>      An email thread initiated by Angelo Borsotti did not come to a
> >>      consensus on how push should behave with regard to tag references.

> > I think the original motivation of allowing fast-forward updates to
> > tags was for people who wanted to have "today's recommended version"
> > tag that can float from day to day. I tend to think that was a
> > misguided notion and it is better implemented with a tip of a
> > branch (iow, I personally am OK with the change to forbid tag
> > updates altogether, without --force).

> >>      I think a key point is that you currently cannot be sure your push
> >>      will not clobber a tag (lightweight or not) in the remote.

> > "Do not update, only add new" may be a good feature, but at the same
> > time I have this suspicion that its usefulness may not necessarily
> > be limited to refs/tags/* hierarchy.

> > I dunno.

> Are you suggesting allowing forwards for just refs/heads/*?  I
> initially went this route based on some feedback in the original
> thread, but being that specific broke a couple tests in t5516 (i.e.,
> pushing to refs/remotes/origin/master and another into refs/tmp/*.)
> My initial thought was that I'd broken something and I need to modify
> the patch, but now I think I should just modify those tests.  Branches
> are restricted to refs/heads/* (if I understand correctly), so
> allowing fast-forwards when pushing should be limited to this
> hierarchy, too.

What about notes? I think they should be treated in the same way as
branches. My impression is that tags are exceptional in this respect.

-- 
  Kacper
