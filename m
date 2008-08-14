From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: Why doesn't git-apply remove empty file
Date: Thu, 14 Aug 2008 22:21:59 +0200
Message-ID: <20080814202159.GD7138@leksak.fem-net>
References: <38b2ab8a0808120917h10f15c81v4d1f04c0174dc994@mail.gmail.com> <7vod3xpxq2.fsf@gitster.siamese.dyndns.org> <38b2ab8a0808130048t506dbb7ah1d6fcd6bd4f3c90c@mail.gmail.com> <48A357BA.8060003@lsrfire.ath.cx> <alpine.LFD.1.10.0808131602200.3462@nehalem.linux-foundation.org> <38b2ab8a0808141242k4bd6867dt8ef54f160713061f@mail.gmail.com> <alpine.LFD.1.10.0808141246190.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141258180.3324@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francis Moreau <francis.moro@gmail.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 22:23:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTjLu-0001jy-9z
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 22:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324AbYHNUWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 16:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753265AbYHNUWG
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 16:22:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:41095 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752908AbYHNUWF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 16:22:05 -0400
Received: (qmail invoked by alias); 14 Aug 2008 20:22:01 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp033) with SMTP; 14 Aug 2008 22:22:01 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/EIK8lnNfEmLJPGM4zFK7Q61nVMJIRR8aRHabd36
	9Za5kldzg1G8TO
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KTjKZ-00087w-FQ; Thu, 14 Aug 2008 22:21:59 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808141258180.3324@nehalem.linux-foundation.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92395>

Hi,

while at the git-apply topic...

Linus Torvalds wrote:
> On Thu, 14 Aug 2008, Linus Torvalds wrote:
> >
> >   There's no way to do an all-or-nothing patch, which is often 
> >    a huge requirement.
[...]
> 
> ..or to play games with backup and reject files after-the-fact, of course.

What I missed when I first used git-apply (git-am) with some not-so-
well-done patches was something like a "simulated merge" (of course,
only when you ask for it), i.e. something like a user-friendly
--reject behavior:
Instead of generating reject files it puts conflict markers into the file.
(If no context matches at all, then perhaps just insert them at the lines
that the hunk header says.)
And then declaring the files as "unmerged", so that you can see it in
git status.

I've seen two or three people asking on #git for such a feature, so
it looked like I am not the only one who misses this. But yet I've had
no time to implement such a thing.  Or is it even there, hidden?

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
