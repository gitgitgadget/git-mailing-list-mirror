From: Jeff King <peff@peff.net>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Thu, 8 Sep 2011 15:10:53 -0400
Message-ID: <20110908191053.GA16064@sigill.intra.peff.net>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
 <4E6769E3.4070003@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kyle Neath <kneath@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 01:11:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nkL-0002qR-PI
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 01:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236Ab1IHXK5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Sep 2011 19:10:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34669
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744Ab1IHXK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 19:10:56 -0400
Received: (qmail 16328 invoked by uid 107); 8 Sep 2011 19:11:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Sep 2011 15:11:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2011 15:10:53 -0400
Content-Disposition: inline
In-Reply-To: <4E6769E3.4070003@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180998>

On Wed, Sep 07, 2011 at 02:56:03PM +0200, Michael J Gruber wrote:

> So, it's been a year or more that you've been aware of the importance
> of this issue (from your/github's perspective), and we hear about it
> now, at the end of the rc phase. I don't know whether
> jk/http-auth-keyring has been done on github payroll or during spare
> time.

To be absolutely clear here, this feature was 100% paid for by GitHub
(which isn't to say that I don't think it's a good idea. On the
contrary, I think it's awesome; but GitHub money is what provided the
time for me to work on it).

When I started at GitHub in January, I was given a giant list of things
that GitHub felt would make core git better, but that they hadn't the
personnel to improve. And I was told to use my own judgement in adding
or removing items from the list based on what I thought git needed, and
to prioritize as I saw fit. The fact that it took six months for me to
come up with credential patches is because that's how long it took me t=
o
figure out what I wanted to write, and to clear my backlog of other git
tasks.

So I think the wheels have been turning on this for quite a while from
GitHub's perspective.

At the same time, I agree very much with Junio; releasing something wit=
h
a bad API and then having to fix it later is much worse than delaying
the release of a feature by a little bit. And we have very little data
on whether the API is "right" at this point. Initially I was concerned
that there wasn't going to be enough interest while the patches were in
'next', and that we would have to make a release in order to get people
interested enough in writing helpers. But right after I said that, Luka=
s
Sandstr=C3=B6m showed up with a kdewallet helper. And Ted Zlatanov is w=
orking
on something for the freedesktop secrets API.

And already there's been some discussion that perhaps the current
interface isn't quite what we want and is going to need tweaking.
So we are moving forward, and I still hope that we can target the next
release of "master" in 8-10 weeks. But this time with more confidence
that what's being released is actually right.

In the meantime, the best thing we can do to push it forward is to writ=
e
helpers. I implemented some basic ones that should work anywhere, but
aren't as nice as integration with existing keychains. Some people are
working on Linux ones. The single best thing GitHub can do to push this
forward right now is to provide a well-written OS X Keychain helper, an=
d
to provide feedback on whether git's end of the API is good enough.

-Peff
