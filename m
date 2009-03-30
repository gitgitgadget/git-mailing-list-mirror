From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Implementing stat() with FindFirstFile()
Date: Tue, 31 Mar 2009 00:07:10 +0200
Message-ID: <20090330220709.GA68118@macbook.lan>
References: <20090321154738.GA27249@jeeves.jpl.local> <200903212055.15026.j6t@kdbg.org> <20090324215416.GB27249@jeeves.jpl.local> <49CB2BA5.1070100@viscovery.net> <20090326213907.GC27249@jeeves.jpl.local> <alpine.DEB.1.00.0903270320020.10279@pacific.mpi-cbg.de> <20090329224803.GD27249@jeeves.jpl.local> <alpine.DEB.1.00.0903300245080.6454@intel-tinevez-2-302> <20090330051118.GA2681@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@swipnet.se>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 31 00:08:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoPf1-0002vr-45
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 00:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757423AbZC3WHR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 18:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757232AbZC3WHQ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 18:07:16 -0400
Received: from darksea.de ([83.133.111.250]:53634 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755642AbZC3WHO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 18:07:14 -0400
Received: (qmail 12563 invoked from network); 31 Mar 2009 00:07:10 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 31 Mar 2009 00:07:10 +0200
Content-Disposition: inline
In-Reply-To: <20090330051118.GA2681@atjola.homenet>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115194>

On Mon, Mar 30, 2009 at 07:11:18AM +0200, Bj=F6rn Steinbrink wrote:
> On 2009.03.30 02:52:47 +0200, Johannes Schindelin wrote:
> > On Mon, 30 Mar 2009, Magnus B=E4ck wrote:
> > > On Friday, March 27, 2009 at 03:25 CET,
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > On Thu, 26 Mar 2009, Magnus B=E4ck wrote:
> > > > > I'd be very surprised if ZwQueryDirectoryFile() hasn't always=
 been
> > > > > around (I just verified ntdll.dll from NT 4.0), so that's not=
 a
> > > > > worry. Don't know why MSDN reports it as introduced in XP.
> > > >
> > > > As the current maintainer of msysGit, I refuse to have somethin=
g in
> > > > the installer I ship that relies on not-at-all guaranteed inter=
faces.
> > >=20
> > > Although I do appreciate the importance of guaranteed interfaces,
> > > I am also pragmatic. An incompatible change in ntdll.dll would br=
eak
> > > vast amounts of programs, including cygwin. There is a lot to be =
said
> > > about Microsoft and their APIs, but I don't think they have a hab=
it of
> > > changing ABIs or function semantics for userland libraries that h=
ave
> > > been around for 15 years.
> >=20
> > Had you pointed to some document that states that the function has =
been in=20
> > all NT-based versions, that would have done the trick.
>=20
> Not official documentation, but at least from some MS guy it seems:
> http://www.osronline.com/showThread.cfm?link=3D73086 (last message).
>=20
> Apparently, it was in NT3.x, but they document only what's actually
> defined in the header.

How about runtime checking? You could do GetProcAddress(...) and if you
don't get it use the old behaviour. I mean if it really is faster why
not let Users of recent systems benefit from it.

cheers Heiko
