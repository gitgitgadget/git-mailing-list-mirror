From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: Why doesn't git-apply remove empty file
Date: Thu, 14 Aug 2008 23:10:34 +0200
Message-ID: <20080814211034.GE7138@leksak.fem-net>
References: <38b2ab8a0808120917h10f15c81v4d1f04c0174dc994@mail.gmail.com> <7vod3xpxq2.fsf@gitster.siamese.dyndns.org> <38b2ab8a0808130048t506dbb7ah1d6fcd6bd4f3c90c@mail.gmail.com> <48A357BA.8060003@lsrfire.ath.cx> <alpine.LFD.1.10.0808131602200.3462@nehalem.linux-foundation.org> <38b2ab8a0808141242k4bd6867dt8ef54f160713061f@mail.gmail.com> <alpine.LFD.1.10.0808141246190.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141258180.3324@nehalem.linux-foundation.org> <20080814202159.GD7138@leksak.fem-net> <20080814205447.GC25469@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Francis Moreau <francis.moro@gmail.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 14 23:11:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTk6f-0003Ie-T3
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 23:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743AbYHNVKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 17:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753719AbYHNVKj
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 17:10:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:50557 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752638AbYHNVKi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 17:10:38 -0400
Received: (qmail invoked by alias); 14 Aug 2008 21:10:36 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp005) with SMTP; 14 Aug 2008 23:10:36 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+ANJV2m5iAsJScrMowcNgKgMXRRn8VsuAJjW74gf
	TIzL/eGXrkmSX3
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KTk5a-00046N-HT; Thu, 14 Aug 2008 23:10:34 +0200
Content-Disposition: inline
In-Reply-To: <20080814205447.GC25469@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92401>

Hi,

Jeff King wrote:
> On Thu, Aug 14, 2008 at 10:21:59PM +0200, Stephan Beyer wrote:
> 
> > Instead of generating reject files it puts conflict markers into the file.
> > (If no context matches at all, then perhaps just insert them at the lines
> > that the hunk header says.)
> > And then declaring the files as "unmerged", so that you can see it in
> > git status.
> 
> I use "git am -3" for that. Then you get conflict markers, or you can
> use git-mergetool.

git am -3 looks for the base blob in the "index" line of the patch.

Now imagine you do not have this blob in git, e.g. because you've not
fetched some large side branch from another repo.
Then git am -3 won't help, too. (Yes, in this example fetching the
branch may help, but there may be other examples.)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
