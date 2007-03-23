From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: Git / Subversion Interoperability
Date: Fri, 23 Mar 2007 16:34:27 -0300
Message-ID: <20070323193427.GA12126@c3sl.ufpr.br>
References: <20070322224829.GA7048@c3sl.ufpr.br> <20070323004335.GA17773@spearce.org> <Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk> <20070323012422.GC17773@spearce.org> <Pine.LNX.4.64.0703230128330.4001@beast.quantumfyre.co.uk> <20070323103426.GA15923@diana.vm.bytemark.co.uk> <20070323152102.GA4818@c3sl.ufpr.br> <Pine.LNX.4.64.0703231758020.8105@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Mar 23 20:34:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUpX0-0005O8-Ok
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 20:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992540AbXCWTeb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 23 Mar 2007 15:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933926AbXCWTeb
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 15:34:31 -0400
Received: from urquell.c3sl.ufpr.br ([200.17.202.3]:47042 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933592AbXCWTea (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 15:34:30 -0400
Received: from cohiba (cohiba.c3sl.ufpr.br [200.17.202.52])
	by urquell.c3sl.ufpr.br (Postfix) with SMTP id AB911301B304;
	Fri, 23 Mar 2007 16:34:27 -0300 (BRT)
Received: by cohiba (sSMTP sendmail emulation); Fri, 23 Mar 2007 16:34:27 -0300
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703231758020.8105@reaper.quantumfyre.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42957>

On Fri, Mar 23, 2007 at 06:13:16PM +0000, Julian Phillips wrote:
> On Fri, 23 Mar 2007, Bruno Cesar Ribas wrote:
>=20
> >On Fri, Mar 23, 2007 at 11:34:26AM +0100, Karl Hasselstr=C3=B6m wrot=
e:
> >>On 2007-03-23 01:36:11 +0000, Julian Phillips wrote:
> >>
> >>>In particular it's how the client finds out about things like
> >>>symlinks and line ending conversion. It may be necessary to provid=
e
> >>>some basic support for some of the properties in the svn:...
> >>>namespace in order for the Subversion repo access library not to
> >>>refuse to talk to the git server.
> >>
> >>Maybe the pragmatic solution would be to have built-in handling of =
a
> >>few properties such as svn:executable and svn:ignore that have git
> >>equivalents, and just emulate all other properties with files.
> >
> >My idea is to write the git-svnserver!!! I think it will be easier.
>=20
> Almost certainly - I don't think anyone was proposing otherwise?  The=
 repo=20
> access library I was referring to is one of the libraries used by the=
=20
> client - specifically the one used to talk to a remote server (I thin=
k=20
> it may be called ra or something?  I'm not familiar with Subversion=20
> internals).
>=20
> >
> >To begin coding, i plan to write basic functions [updade,commit,chec=
kout,
> >copy,merge,...] then start to implement most "complex" instructions.
>=20
> Ok, but ...
>=20
> I don't think that merge is a basic function in Subversion.  I believ=
e=20
> that it is all client side using diffs provided by the server into th=
e=20
> working copy, certainly it is up to the user to commit the result.=20
> Unfortunately that would make it necesary to do some very nasty work=20
> server side to try and autodetect merges - git-svnimport (and git-svn=
?)=20
> already does this sort of thing.  There are noises about this changin=
g at=20
> some point though ...
>=20
> >
> >As spearce said before, the idea of this is to migrate from svn to g=
it
> >without many trouble in transition, so basic can work as the initial=
=20
> >thought.
>=20
> Which means that you have to at the very least support the basic=20
> operations of the Subversion supplied svn client.  And my point was t=
hat I=20
> wouldn't be surprised if this meant dealing with properties, since=20
> subversion uses properties to expose things like the log message, com=
mit=20
> date and author for revisions and other misc. info for files.  You ma=
y not=20
> even be able to get commit/checkout working without _some_ property=20
> support.
>=20
> Having said that, I don't think it would be a _bad_ thing if this wor=
k=20
> went far enough that one could replace a Subversion server without an=
y=20
> users even noticing ;)

I began to think about it... the idea to have a git-svnserver is to mov=
e from
svn to git and get my dev team not to worry about the transition at the
start, but it is a good idea to make people get moving to git idea of
devlopment, right?
Or the main idea is that we will have a group devloping under git repo =
and a
group under svn-gateway for the same project? I don't see a point to ha=
ve
this! when a repo type is defined everyone must begin to understand tha=
t way,
even if it was changed in the middle of the project.

When decided above, we can define our dev of this project. Because as p=
eople
make those 'strange' stuff at svn repo that git won't support we will h=
ave to
make some workarounds to get git understand those things, and if we hav=
e some
people migrated do git and some using svn they will not see some 'svn t=
ags'
on git repo.

That's why i think it should be a transition thing from svn to git.



>=20
> --=20
> Julian
>=20
>  ---
> You know you're using the computer too much when:
> a party sucks if theres no computers to use.
> 	--=20
> 	electrofreak


--=20
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br=20
