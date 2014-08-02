From: Alex Davidson <descenterace@hotmail.com>
Subject: Re: cherry picking and merge
Date: Sat, 2 Aug 2014 01:18:11 +0100
Message-ID: <BLU436-SMTP260FDB8DC4B2AC1F9132D10D1E40@phx.gbl>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
	 <20140801024329.GA28914@vauxhall.crustytoothpaste.net>
	 <53DBBFE8.8060607@gmail.com>
	 <5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net>
	 <53DBF4C9.2090905@vilain.net>
	 <4E372CD5-33CA-4AF5-8647-F6BBC64BABA8@comcast.net>
	 <CAK3OfOiG8kzKYRUGZJW90t-DyjWf775MfMDxzin0gw94ATS7nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Stump <mikestump@comcast.net>, Sam Vilain <sam@vilain.net>,
	Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git discussion list <git@vger.kernel.org>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 02:22:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDN63-0007lx-Q1
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 02:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbaHBAWr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 20:22:47 -0400
Received: from blu004-omc4s2.hotmail.com ([65.55.111.141]:51648 "EHLO
	BLU004-OMC4S2.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbaHBAWq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 20:22:46 -0400
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Aug 2014 20:22:46 EDT
Received: from BLU436-SMTP260 ([65.55.111.136]) by BLU004-OMC4S2.hotmail.com with Microsoft SMTPSVC(7.5.7601.22712);
	 Fri, 1 Aug 2014 17:17:39 -0700
X-TMN: [5589pfyVRYqaCusBmplKpe0gTPR+5pSe]
X-Originating-Email: [descenterace@hotmail.com]
Received: from [192.168.0.128] ([82.37.171.168]) by BLU436-SMTP260.smtp.hotmail.com over TLS secured channel with Microsoft SMTPSVC(8.0.9200.16384);
	 Fri, 1 Aug 2014 17:17:37 -0700
In-Reply-To: <CAK3OfOiG8kzKYRUGZJW90t-DyjWf775MfMDxzin0gw94ATS7nw@mail.gmail.com>
X-Mailer: Evolution 3.4.4-3 
X-OriginalArrivalTime: 02 Aug 2014 00:17:37.0711 (UTC) FILETIME=[2A6163F0:01CFADE7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254689>

On Fri, 2014-08-01 at 18:40 -0500, Nico Williams wrote:
> On Fri, Aug 1, 2014 at 6:06 PM, Mike Stump <mikestump@comcast.net> wr=
ote:
> > On Aug 1, 2014, at 1:12 PM, Sam Vilain <sam@vilain.net> wrote:
> >> Git merge has a notion of discrete "merge strategies=E2=80=9D.
> >
> >> There's no particular reason that you couldn't implement a merge
> >> strategy which works more like SVN's approach, which essentially d=
oes an
> >> internal rebase and then commits the result.
> >
> > Well, being a simple user, wanting to do a simple thing, I want the=
 default strategy to just work.  [...]
>=20
> Different users want different defaults.  You can't always have the
> one you want.

Or to put it another way: one man's bug is another man's feature.

>=20
> As for rebase, I still don't understand why it doesn't work for you.
> You didn't really explain.  Suppose we're right and it's the right
> solution for you, then you might be ecstatic, but you gotta try it
> first.
> ...
> Nico
> --

Data point:

We've been using a rebase-centric workflow for a while at my current
employer. It's simple and generally straightforward for new development
on master.

However we need to maintain multiple 'released' version branches which
receive hotfixes and (sadly) features from later development, and merge=
s
make it much easier to visualise which releases have received specific
fixes/shinies than cherry-picks do.

In a hybrid merge/rebase workflow it is convenient to have the option o=
f
merges which yield rebase-like output. We have seen awkward merges
outside of master, but I mostly see that as an indication that we
shouldn't be mixing workflows so much, ie. hotfixing one thing with a
cherry-pick and another with a merge (usually only happens when the
branch predates our use of merges).

TL;DR: The option of a rebase-like merge would be a nice feature, but
the default system does not seem so onerous.

Alex
