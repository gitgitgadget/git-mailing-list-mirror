From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-svn: multiple branches directories
Date: Sun, 8 Jun 2008 20:51:40 +0200
Message-ID: <20080608185140.GA31698@atjola.homenet>
References: <20080608002349.GB23243@xorcom.com> <e06498070806080900x4ecd730byefedf88aa4feee5e@mail.gmail.com> <20080608183742.GF23243@xorcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 08 20:53:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Q0z-00012U-31
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 20:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606AbYFHSvx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jun 2008 14:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754027AbYFHSvo
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 14:51:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:54102 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752298AbYFHSvn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 14:51:43 -0400
Received: (qmail invoked by alias); 08 Jun 2008 18:51:41 -0000
Received: from i577BA5DD.versanet.de (EHLO atjola.local) [87.123.165.221]
  by mail.gmx.net (mp020) with SMTP; 08 Jun 2008 20:51:41 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+rc6RXANGr01oD4p3Wmxaig8n4I5zjS2fKr6kbU/
	pGwaRsHgZmhvSk
Content-Disposition: inline
In-Reply-To: <20080608183742.GF23243@xorcom.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84307>

On 2008.06.08 21:37:42 +0300, Tzafrir Cohen wrote:
> On Sun, Jun 08, 2008 at 12:00:58PM -0400, Steven Walter wrote:
> > On Sat, Jun 7, 2008 at 8:23 PM, Tzafrir Cohen <tzafrir.cohen@xorcom=
=2Ecom> wrote:
> > > Hi
> > >
> > > Does git-svn support a repository layout where branches may resid=
e under
> > > more than one root?
> > >
> > > /trunk
> > > /branches
> > >  branch1
> > >  branch2
> > >  branch3
> > > /somedir
> > >  branch4
> > >  branch5
> > >  branch6
> > > /tags
> > >  ...
> >=20
> > git-svn does support it.  The way that I interact with repositories
> > like this is to have the main git-svn remote track only the trunk
> > (fetch =3D /trunk:...), and then to add addititonal remotes for eac=
h
> > branch that I want to track.  There may be a nicer way to do it, bu=
t
> > git-svn certainly supports the method just described.
>=20
> Thanks for your answer,
>=20
> I'm afraid I don't follow you. Where do I have to write that and wher=
e?

You can just add more svn-remote to a single git repo with "git svn
init". So you could do:

git svn clone -s svn://host/some/repo
cd repo
git svn init --branches somedir svn://host/some/repo/ svn2
git svn fetch svn2

To fetch all new stuff at once, you would then later use "git svn fetch
--all".

Bj=F6rn
