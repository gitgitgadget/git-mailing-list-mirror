From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Question regarding git fetch
Date: Thu, 27 Aug 2009 18:46:57 +0200
Message-ID: <20090827164657.GA17090@atjola.homenet>
References: <1251387045053-3527289.post@n2.nabble.com>
 <32541b130908270836m50553ccatddf4c870eec54ddb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tom Lambda <tom.lambda@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 18:47:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgi7y-0006g6-4M
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 18:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbZH0QrB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Aug 2009 12:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753125AbZH0QrB
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 12:47:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:59413 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753123AbZH0QrA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 12:47:00 -0400
Received: (qmail invoked by alias); 27 Aug 2009 16:47:01 -0000
Received: from i59F5455C.versanet.de (EHLO atjola.homenet) [89.245.69.92]
  by mail.gmx.net (mp071) with SMTP; 27 Aug 2009 18:47:01 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18HXDMk6EkHrAEt77Ni2Nb1vnVJZJDPu4dFA6+Qk2
	jgUq/nArV6qjgF
Content-Disposition: inline
In-Reply-To: <32541b130908270836m50553ccatddf4c870eec54ddb@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127177>

On 2009.08.27 15:36:53 +0000, Avery Pennarun wrote:
> On Thu, Aug 27, 2009 at 3:30 PM, Tom Lambda<tom.lambda@gmail.com> wro=
te:
> > What was a little bit surprising to me is that running "git fetch c=
entral
> > master" does not update refs/remotes/central/master but simply upda=
tes
> > FETCH_HEAD.
>=20
> I've often wanted this myself, especially when doing things like "git
> pull origin master".  However, I know the current behaviour is also
> useful sometimes, and changing it would introduce an unexpected side
> effect.  Git currently promises that your refs/remotes/* branches wil=
l
> never be updated unless you explicitly request it, even if you're
> fetching, merging, and pulling other stuff.  This means you can write
> scripts to do complicated things without triggering unexpected
> user-visible side effects.
>=20
> So basically, I agree that it would often be much more user-friendly
> to do what you're asking.  But it would be less scripting-friendly.  =
I
> don't think anyone has thought of an answer that better balances the
> two.

It would also be pretty hard to implement that. Given the default fetch
refspec, it would "simply" be a matter of mapping the given ref to the
refspec, so e.g. "foo" becomes "refs/heads/foo:refs/remotes/origin/foo"=
=2E
But even just using "git remote add -t master foo git://..." breaks
that, as the fetch refspec in the config will no longer be a glob, and
thus no such mapping is possible.

Bj=F6rn
