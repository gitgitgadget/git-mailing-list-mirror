From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Need help for migration from CVS to git in one go (ie, FORGETTING CVS history)
Date: Fri, 7 Nov 2008 01:34:41 +0100
Message-ID: <200811070134.42637.jnareb@gmail.com>
References: <200811060014.57046.fg@one2team.net> <m3zlkdeelm.fsf@localhost.localdomain> <200811061313.50711.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Fri Nov 07 01:36:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyFKd-0004hT-N9
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 01:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbYKGAe5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Nov 2008 19:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752807AbYKGAe5
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 19:34:57 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:64599 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbYKGAe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 19:34:56 -0500
Received: by nf-out-0910.google.com with SMTP id d3so495660nfc.21
        for <git@vger.kernel.org>; Thu, 06 Nov 2008 16:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=0MTWPLvU51dhCcyqtyYYGnJGMkK+W/zDt+Rt8kzdPcU=;
        b=Mb9rbkR2WjjfufGNgbTeFmtaitCuiA0PWM6YVYZ5RC/o0YHkxIi72vxEbHQSsf+Sap
         EkAdjsvNs3iKDj1wTHKTRy4Qg1vxH4SytMVAeFG6ZbD5puoknV19kk9YHr/PmPFdU2O4
         oBCLGCScILUqs2WO7o2rmq0lwNxQzNRvW+WWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PfwYIZLFb7SKsbZAPWvb3urn3id/rrL9Mx1IPb/c2l+mzQtPX1Wp2eARrhxaPXxYzy
         VQtr7xanL68ce5xCj2I4duYPtIsBI7/TEXhAxRn25QnwABaaD4uchfbHL/hNGpYV4scG
         ZT3sWMN24MbYKTdQvYeorAdcyzv8hnUXEWxUs=
Received: by 10.210.18.8 with SMTP id 8mr3004187ebr.47.1226018094706;
        Thu, 06 Nov 2008 16:34:54 -0800 (PST)
Received: from ?192.168.1.11? (abvq140.neoplus.adsl.tpnet.pl [83.8.214.140])
        by mx.google.com with ESMTPS id c4sm10382284nfi.13.2008.11.06.16.34.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Nov 2008 16:34:52 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200811061313.50711.fg@one2team.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100273>

On Thu, 6 Nov 2008, Francis Galiegue wrote:
> Le Thursday 06 November 2008 04:08:16 Jakub Narebski, vous avez =E9cr=
it=A0:
> Hello,
> [...]
> > >
> > > * 52 CVS modules, fine; but then this can become one and 52
> > >   subdirectories in them and still act as separate modules from
> > >   the build system point of view (which I have implemented, so
> > >   I can change it);
> >
> > I think that those CVS modules should become separate repositories,
> > perhaps joined together using submodules. This is one of more
> > difficult things during conversion.
> >
> > Note that in Git commits are always whole tree (whole project)
> > commits.
> >
>=20
> Honestly, I'm not fond of this approach. The problem with submodules =
as far as=20
> I'm concerned is that documentation is "not really there", and (unles=
s the=20
> README of egit is _really_ outdated) that there's no support in egit.
>=20
> I know about commits affecting the whole tree, and even branches and =
tags, and=20
> that's more of an advantage to my eyes, for two reasons:
>=20
> * 99+% of queries currently done on the CVS tree (with Bonsai) cover =
all=20
> modules; only rarely is a single module concerned, and in this case y=
ou just=20
> fill in the appropriate field in the search page anyway;

Well, the mapping of CVS modules into Git repositories, and perhaps
also later binding those Git repositories together using submodules
support is IMHO one of more difficult decisions when deciding on
migration from CVS to Git.

What you would have to ask yourself is which of those CVS modules
are independent, for example having independent version numbers (tags)
and independent branches. And if commit really affects whole tree...

> * creating a branch is one command and that's it. It may also be one =
command=20
> with submodules, but again, the documentation makes me uncomfortable;=
 with=20
> CVS, well... You get the picture.

Submodules are Git repositories of their own. So you have branching
there (almost) as easy as otherwise in Git. The only problem is a bit
lacking UI for binding those submodules together.

>=20
> What's more, I don't think we have the requirement of making specific=
=20
> per-module tags. Not as far as this has been discussed so far, anyway=
, and=20
> not as far as the history shows.

Well, that is one issue that would help in mapping CVS modules to Git
repositories (and submodules).

>=20
> > > * second: even though this may be a "non problem", we use Bonsai,
> > > which has the ability to see what was commited by whom, given a t=
ime
> > > interval (from d1 to d2): the base gitweb allows to search by
> > > commiter, which is good, but it has no date boundaries: do tools
> > > exist for git that can do this? If not, that wouldn't be a big de=
al,
> > > however...
> >
> > First, there are more web interfaces than gitweb, see
> > http://git.or.cz/gitweb/InterfacesFrontendsAndTools
>=20
> Yep, I've yet to try those... There are quite a few!
>=20
> > Second, you can do this from command line, using combination of com=
mit
> > limiting a..b and a...b, or --since=3D<date> or --after=3D<date> an=
d
> > --before=3D<date>, commit message searching --author, --committer, =
and
> > --grep, and path limiting "git log -- <pathspec>".
>=20
> Well, a Web-based search engine is kind of a requirement. I'm the onl=
y one to=20
> do command line... Thanks for the hints, though!

You can also use one of GUI; qgit and gitk + git-gui seems to be quite
mature and cross-platform.

> > Third, it would be not that hard to add more advanced search suppor=
t
> > to gitweb; this is even one of planned features.

I think there are two possible ways of doing it: have a kind of
"advanced search" form, where one can have fill search terms, like
date limit, path limiting etc; or have an option to limit search to
current view context (for example current file or current directory).

> Which brings back to the subject of submodules, since as I said above=
, we=20
> generally search on the entire tree, and per-module searches are rare=
=2E

Hmmm...

>=20
> > > * third: also Bonsai-related; Bonsai can link to Bugzilla by
> > > matching (wild guess) /\b(?:#?)(\d+)\b/ and transforming this int=
o
> > > http://your.bugzilla.fqdn.here/show_bug.cgi?id=3D$1. Does gitweb =
have
> > > this built-in? (haven't looked yet) Is this planned, or has it be=
en
> > > discussed and been considered not worth the hassle?
> >
> > This is (under name of 'committags') in gitweb TODO; gitweb-xmms2
> > support this IIRC or supported this (for Mantis and not Bugzilla
> > though...)
>=20
> Interesting... I'll have a look at it.

Well, now I have bumped priority of this item in my gitweb TODO list...

--=20
Jakub Narebski
Poland
