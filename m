From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] bisect: test merge base if good rev is not an ancestor of bad rev
Date: Fri, 11 Jul 2008 01:21:34 +0200
Message-ID: <200807110121.34656.chriscool@tuxfamily.org>
References: <20080710054152.b051989c.chriscool@tuxfamily.org> <200807110036.17504.chriscool@tuxfamily.org> <alpine.DEB.1.00.0807110035180.3279@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 01:18:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH5PR-0004IP-2y
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 01:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638AbYGJXRo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2008 19:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbYGJXRn
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 19:17:43 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:41246 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636AbYGJXRn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jul 2008 19:17:43 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id F15B81AB2B2;
	Fri, 11 Jul 2008 01:17:41 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id A4B3C1AB2B7;
	Fri, 11 Jul 2008 01:17:41 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0807110035180.3279@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88051>

Le vendredi 11 juillet 2008, Johannes Schindelin a =E9crit :
> Hi,
>
> On Fri, 11 Jul 2008, Christian Couder wrote:
> > Le jeudi 10 juillet 2008, Junio C Hamano a =E9crit :
> > >  - "Test this merge-base before going forward, please" will add
> > >    typically only one round of check (if you have more merge base=
s
> > >    between good and bad, you need to test all of them are good to=
 be
> > >    sure), so it is not "slower nor more complex".
> >
> > By "slower" I meant that it would need more rounds of check on aver=
age.
> > By "more complex" I meant that more code is needed.
> >
> > And I think you are right, all the merge bases need to be tested so=
 I
> > will send a patch on top of the patch discussed here.
>
> Good luck.  This will open the scenario where people use a proper
> ancestor as "good" revision.  In this case, you test that.

If a proper ancestor is used as good rev, then the merge base between t=
his=20
good rev and the bad rev is this good rev, and as it is known to be goo=
d it=20
doesn't need to be tested by the user. I think my patch handles this we=
ll.

> If it is=20
> "bad" you report that it is the _first_ one.
>
> You are opening a can of worms here, and I doubt that this is a good
> idea.
>
> git-bisect as-is has very precise, and _simple_ semantics, and users
> should really know what they are doing (i.e. not marking something as
> "good" which is on a branch containing a fix).

I think that users don't and can't always know what they are doing. If =
there=20
is a revert in a branch for example, how can they know all the bugs tha=
t it=20
fixes?

> Trying to be too clever here might just make the whole tool rather
> useless.

I don't think so. I think that if user can trust "git bisect" more, the=
y=20
will use it more, and in more automated ways and everyone will win in t=
he=20
end.

Regards,
Christian.
