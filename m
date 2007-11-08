From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git rebase --skip
Date: Thu, 8 Nov 2007 13:43:05 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711081332550.29952@iabervon.org>
References: <20071107222105.GA31666@glandium.org> <20071108032308.GA5638@sigill.intra.peff.net>
 <20071108102412.GA31187@atjola.homenet>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-2098087668-1194547385=:29952"
Cc: Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 19:43:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqCLf-0001gl-9q
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 19:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761213AbXKHSnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 13:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761141AbXKHSnK
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 13:43:10 -0500
Received: from iabervon.org ([66.92.72.58]:49383 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761047AbXKHSnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 13:43:09 -0500
Received: (qmail 25594 invoked by uid 1000); 8 Nov 2007 18:43:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Nov 2007 18:43:05 -0000
In-Reply-To: <20071108102412.GA31187@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64062>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-2098087668-1194547385=:29952
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 8 Nov 2007, Bj=F6rn Steinbrink wrote:

> On 2007.11.07 22:23:10 -0500, Jeff King wrote:
> > On Wed, Nov 07, 2007 at 11:21:05PM +0100, Mike Hommey wrote:
> >=20
> > > I use git-rebase quite regularly, and I haven't used git-rebase --ski=
p
> > > after a failed merge without first resetting the working tree. I was
> > > wondering if it wouldn't make sense to automatically do the reset whe=
n
> > > running git-rebase --skip.
> >=20
> > I have often been annoyed by this behavior, too, and I can't think of
> > any situation where you _wouldn't_ want the reset to happen.  But I
> > would be more comfortable hearing confirmation from others that they
> > can't think of such a situation.
>=20
> Let's take this history:
>=20
>       C---D---E topic
>      /
>     A---B master
>=20
> You then do:
> git rebase master topic
>=20
> Now D causes conflicts, because B did a similar change, but not quite
> the same, maybe having a bug. So you want to keep parts of D, but it's
> no longer the same commit semantically and the original commit message
> would be bogus. So you resolve the conflicts and do:
>=20
> git commit
> git rebase --skip

I guess that works, and nothing else presently does. But I don't think=20
that's at all intuitive as the correct thing to do (plus it feels too easy=
=20
to get into losing your commit message). Maybe we should have a "git=20
rebase --amend", which does the obvious thing (acts like --continue, but=20
lets you edit the message). It's not like you just did something totally=20
different; the commit is still the replacement for D, it's just less the=20
same.

=09-Daniel
*This .sig left intentionally blank*
--1547844168-2098087668-1194547385=:29952--
