From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config
 variable
Date: Wed, 16 Jan 2008 00:17:06 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801160016320.17650@racer.site>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com>
 <alpine.LSU.1.00.0801122123430.8333@wbgn129.biozentrum.uni-wuerzburg.de> <47893F53.2070908@gmail.com> <alpine.LSU.1.00.0801132220200.8333@wbgn129.biozentrum.uni-wuerzburg.de> <478AD5A0.50900@gmail.com> <7vabn9m30a.fsf@gitster.siamese.dyndns.org>
 <478C3CD3.6010504@gmail.com> <7vy7arhas9.fsf@gitster.siamese.dyndns.org> <478D3CD8.3040805@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 01:17:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEvyS-0000m3-J7
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 01:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbYAPARR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 19:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbYAPARQ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 19:17:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:45678 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751423AbYAPARP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 19:17:15 -0500
Received: (qmail invoked by alias); 16 Jan 2008 00:17:13 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp012) with SMTP; 16 Jan 2008 01:17:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ja4spPDvjH+iL7RteHVvZpsFz6WjbuZzBfCCPYY
	zFNeUoeBdESDD4
X-X-Sender: gene099@racer.site
In-Reply-To: <478D3CD8.3040805@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70582>

Hi,

On Tue, 15 Jan 2008, Mark Levedahl wrote:

> Junio C Hamano wrote:
> > > Nope, git submodule *still* requires origin (e.g., execute git
> > > submodule init or update on a detached head).
> > >     
> > 
> > Now I am even more confused.
> > 
> > The approach I suggested in a few paragraphs above, to which you
> > just said "I like this change", is about making "git submodule
> > update" to use the url configured in the upper level repository
> > when it runs "git fetch".  I am looking at around l.238 of
> > git-submodule.sh.  In the current code, it runs "git-fetch"
> > without any parameter, which would allow it default to origin or
> > whatever, which may or may not be desirable depending on where
> > the 'origin' points at.  If you make that particular git-fetch
> > explicitly say where the fetch should be done from, wouldn't it
> > fix the issue for that codepath?  Why does it still require
> > origin?
> 1) If top-level is on a detached head, then the remotes machinery will 
> find current remote is "origin". This is what would be passed down the 
> chain.
> 
> 2) Absent the other changes in the thread, git-submodule-init still 
> invokes git clone *without* -o in the submodules, and thus still defines 
> and points to remote "origin".

There's got to be a way to fix this _without_ affecting other users.

Ciao,
Dscho
