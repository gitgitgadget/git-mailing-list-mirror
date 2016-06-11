From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: feature request: git svn dommit --preserve-timestamps
Date: Fri, 10 Jun 2016 22:12:54 -0400
Message-ID: <003501d1c386$c7b44850$571cd8f0$@nexbridge.com>
References: <87a8iy6s4e.fsf@free.fr> <20160607000902.GA4445@dcvr.yhbt.net> <87ziqx5z9h.fsf@free.fr> <20160611013948.GA5793@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "'Eric Wong'" <e@80x24.org>,
	"=?utf-8?Q?'Peter_M=C3=BCnster'?=" <pmlists@free.fr>
X-From: git-owner@vger.kernel.org Sat Jun 11 04:13:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBYQK-00036F-Fc
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 04:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbcFKCNN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 22:13:13 -0400
Received: from elephants.elehost.com ([216.66.27.132]:34397 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbcFKCNM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 22:13:12 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.238.43.115])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id u5B2D406073785
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 10 Jun 2016 22:13:05 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <20160611013948.GA5793@dcvr.yhbt.net>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIrld70405KQlF0dNxEwsyz+oCeHwH+lFepAp1aQ/0C/YSVeZ7zE/og
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297088>

Somewhen near June 10, 2016 9:40 PM, Eric Wong wrote:
> Peter M=C3=BCnster <pmlists@free.fr> wrote:
> > On Tue, Jun 07 2016, Eric Wong wrote:
> > > Peter M=C3=BCnster <pmlists@free.fr> wrote:
> > >> It would be nice, if timestamps could be preserved when rewritin=
g
> > >> the git-log.
> > >
> > > Unfortunately, last I checked (a long time ago!), explicitly sett=
ing
> > > revprops might require SVN administrators to enable the feature f=
or
> > > the repo.
> >
> > Not the svn-log, only the git-log.
>=20
> The git log after dcommit is tied to the SVN log, so git-svn can only=
 reflect
> changes which appear in SVN.
>=20
> 	Sidenote: The convention is reply-to-all on lists like
> 	this one which do not require subscription to post.
> 	It prevents the list from being a single-point-of-failure
> 	or censorship.
>=20
> > > It's been a while and I'm not up-to-date with the latest SVN.
> > > Maybe there's a newer/easier way you could give us details about =
:)
> >
> > No, sorry. I don't care about the svn-log.
>=20
> Unfortunately, you would have to care about svn log as long as SVN ex=
ists in
> your workflow and you need to interact with SVN users.
>=20
> git svn tries hard to work transparently and as close to the behavior=
 of the
> upstream SVN repo as possible.

Having had to deal with this in pure git without factoring in git svn, =
this seems to be is a matter of policy rather than technical requiremen=
t. Various customers of mine have decided that using the commit time as=
 a uniform timestamp to be applied to all files pulled in the specific =
commit, is the way to go when doing continuous integration. The solutio=
n that we ended up with was a step in our Jenkins build jobs that would=
 set the timestamp of all files associated with the specific commit to =
the time of the commit itself. Any commit not part of the commit that c=
hanged that state of the repository was untouched. This became arbitrar=
ily complex when the job was impacted by multiple commits, but the gene=
ral consensus of those who made the decisions was to apply all timestam=
ps associated with all commits, in order, of application (Jenkins seems=
 happy to deal with this part), so that the files do keep relatively sa=
ne from a build perspective. Personally, I am relatively happy with thi=
s solution, even if it adds a huge amount of time to the build - genera=
lly more than the build itself - so that timestamps are "sane". Doing i=
t for straight clones does not seem worth it, because timestamps don't =
appear to matter, policy wise, unless official builds are being done. I=
t may be worth considering that in the discussion.=20

My comments are just based on a production perspective, rather than dev=
elopment, so I ask forgiveness for any red-herrings that may be involve=
d.

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664=
400)/NonStop(211288444200000000)
-- In my real life, I talk too much.
