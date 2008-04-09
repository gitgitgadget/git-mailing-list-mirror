From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Friendly refspecs (Was: Re: git annoyances)
Date: Thu, 10 Apr 2008 01:25:00 +0300
Message-ID: <20080409222500.GB19248@mithlond>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net> <20080409200836.GA19248@mithlond> <20080409203453.GA10370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 10 00:25:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjijt-0008Rv-Mp
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 00:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbYDIWZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 18:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753918AbYDIWZN
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 18:25:13 -0400
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:59564 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753889AbYDIWZM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Apr 2008 18:25:12 -0400
Received: from mithlond (80.220.180.181) by pne-smtpout3-sn1.fre.skanova.net (7.3.129)
        id 47A78857003ACBED; Thu, 10 Apr 2008 00:25:01 +0200
Received: from dtw by mithlond with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1Jjiiy-0006bi-8T; Thu, 10 Apr 2008 01:25:00 +0300
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080409203453.GA10370@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79144>

Jeff King wrote (2008-04-09 16:34 -0400):

> On Wed, Apr 09, 2008 at 11:08:36PM +0300, Teemu Likonen wrote:

> >   $ git fetch <URL>
> > 
> > would be equivalent to
> > 
> >   $ git fetch <URL> +refs/heads/*:refs/remotes/<name>/*

> This has been discussed before and rejected, because the point of
> doing a fetch of a URL (rather than a remote name) is to do
> a "one-off" thing.

First, thank you for such a detailed information and giving somewhat
different point of view from mine.

Ok, "git fetch <URL>" has its own "point", as you noted, and no doubt
it's for good reasons. I just had partially misunderstood its point. See
below:

> Almost nobody says "git fetch <URL>"; it is just a subpart of "git
> pull <URL>" [...]

Hmm, maybe. I recently wanted to join two purely local repos together.
Both of them had just one branch. Totally different histories so no
actual mergin would happen; just two branches in the same repo. I don't
know why but "git fetch /the/other/repo/" just happened to be the one
I tried first. I saw it fetched something but as no new branch appeared
and I had never heard of this FETCH_HEAD thing it was a "didn't work,
what should I try next?" thing. I think your idea of showing

>   From git://host/path/to/repo
>    * [new branch]      foo -> FETCH_HEAD

would be really good. At least to me this would have been enough
information. As I'm starting to see the "point of doing fetch <URL>"
I take back what I proposed. Just a bit more information would be nice.

I have to agree with Ingo Molnar that sometimes Git is a bit un- or even
disinformative about what happened. One example is this "git fetch
<URL>". Maybe it's not a "sane thing to do" but users are like this. We
just try something and learn from it. To me "git fetch <URL>" was
a broken command (UI-wise) until I read your message (thanks again!). If
Git had told me that it created FETCH_HEAD I had learned fetch's habits
myself and likely wouldn't have come up with this "broken command"
conclusion.

Another thing I spoke of was this refs/ stuff. I know my way around with
them now, so maybe they are not actually confusing to me anymore. It's
just that I have noticed a pattern: I always use refs/heads/... in
certain places and refs/remotes/ in certain places. If such a pattern is
very common (well, I don't know if it is) one starts to think that maybe
the pattern can/should be hidden and made part of the tool. Just
thoughts.
