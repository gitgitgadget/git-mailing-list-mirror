From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] filter-branch: work correctly with ambiguous
 refnames
Date: Sun, 6 Jan 2008 01:57:39 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801060154150.10101@racer.site>
References: <Pine.LNX.4.64.0712301700580.14355@wbgn129.biozentrum.uni-wuerzburg.de> <1199040667-31850-1-git-send-email-dpotapov@gmail.com> <7v7iiqppkw.fsf@gitster.siamese.dyndns.org> <20080104155114.GS3373@dpotapov.dyndns.org> <7vr6gxjpyn.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0801051601490.10101@racer.site> <7vabnk81aw.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 02:58:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBKmJ-0005iu-QV
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 02:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbYAFB5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 20:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753088AbYAFB5o
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 20:57:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:51531 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752438AbYAFB5n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 20:57:43 -0500
Received: (qmail invoked by alias); 06 Jan 2008 01:57:41 -0000
Received: from R3e32.r.pppool.de (EHLO [192.168.220.101]) [89.54.62.50]
  by mail.gmx.net (mp027) with SMTP; 06 Jan 2008 02:57:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/E3YcCOHbEBcpyQl6wtF8XIoWy5qmnh0yQFyGXKx
	iIY/mPm4cWTfCM
X-X-Sender: gene099@racer.site
In-Reply-To: <7vabnk81aw.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69700>

Hi,

On Sat, 5 Jan 2008, Junio C Hamano wrote:

>  Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>  > Junio wrote:
>  >
>  >> But at that point I would say that exposing the refname dwimming
>  >> logic to the scripts could be a much cleaner solution.
>  >
>  > I considered that when ripping the script from cogito, but it seemed 
>  > to me at that time that not requiring an up-to-date git for testing 
>  > the script would be better.
>  >
>  > Now is a different situation, however, so I agree.
> 
>  It was already tied to the specific git version when
>  git-filter-branch became part of git.git ;-)

Heh.  But that was not my intention (at least _before_ it was in git.git's 
"master"), so that people could test it.

>  I do not use filter-branch myself very often, but I think this
>  is worth fixing.  The additional --no-flags and sed are to deal
>  with something like:
> 
> 	--topo-order master..next
> 
>  although I do not offhand know if filter-branch would work with
>  things like --topo-order and --first-parent.

Frankly, I have no idea, but --topo-order _should_ not matter, whereas 
--first-parent _should_ rewrite only commits in the first-parent chain of 
the given refs.

In any case, from a cursory look I like the 2 patches (except for the 
curly brackets around the single-line "else" clause, but I know your 
opinion about this, so I will not object).

Ciao,
Dscho
