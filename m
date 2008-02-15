From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] Rename git-core rpm to just git and rename the
	meta-pacakge to git-all.
Date: Fri, 15 Feb 2008 16:37:48 -0500
Message-ID: <1203111468.18847.1.camel@gaara.boston.redhat.com>
References: <1203100163-17509-1-git-send-email-krh@redhat.com>
	 <47B5FF57.5080204@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Feb 15 22:38:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ8Ga-00011z-86
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 22:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889AbYBOVh6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Feb 2008 16:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbYBOVh6
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 16:37:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37734 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755889AbYBOVh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 16:37:56 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m1FLbrOU020011;
	Fri, 15 Feb 2008 16:37:53 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1FLbrBh000589;
	Fri, 15 Feb 2008 16:37:53 -0500
Received: from [192.168.1.105] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1FLbr29031875;
	Fri, 15 Feb 2008 16:37:53 -0500
In-Reply-To: <47B5FF57.5080204@op5.se>
X-Mailer: Evolution 2.21.4 (2.21.4-1.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73984>

On Fri, 2008-02-15 at 22:08 +0100, Andreas Ericsson wrote:
> Kristian H=C3=B8gsberg wrote:
> > ---
> >=20
> > So here's change to fix my favorite annoyance with the git rpm
> > packaging: don't pull in tla when I say yum install git!  The decis=
ion
> > to make 'git' a metapackage is to say the least unconventional and
> > continues to surprise people (here's today discussion:
> > http://marc.info/?t=3D120309228600004&r=3D1&w=3D2).
> >=20
> > I know it's late and most people who use the git rpms are used to i=
nstalling
> > git-core by now, but myself and most of my Red Hat co-workers (who =
should
> > know a thing or two about rpm packaging) have been fooled by the 'g=
it'
> > rpm that pulls in everything.  There's really no precendence for th=
is, quite
> > the opposite: you wouldn't expect yum install gcc to pull in fortra=
n, right?
> >=20
> > The patch below only affects people who know that 'git' is a metapa=
ckage
> > and actually use that to pull in everything (but who does?).  The p=
atch
> > renames the 'git-core' rpm to just 'git', but adds a 'Provides: git=
-core'
> > there so people who have trained themselves to say yum install git-=
core
> > wont get burned.
> >=20
>=20
> Neat, and very nicely done. However, why not add "git-extras" package=
 as
> meta-package that does what just plain "git" package used to do, and
> mentioning the git-extras rpm in the %description of git's package?

It's already there, I called it git-all though.  Mentioning it in the
git rpm description is a good idea.  How about this wording:

"Git is a fast, scalable, distributed revision control system with an
unusually rich command set that provides both high-level operations
and full access to internals.

The git rpm installs the core tools with minimal dependencies.  To
install all git packages, including tools for integrating with other
SCMs, install the git-all meta-package."

Kristian
