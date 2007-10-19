From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 16:41:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0710191640250.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20071019062219.GA28499@coredump.intra.peff.net> 
 <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com> 
 <20071019073938.GN14735@spearce.org>  <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com>
  <20071019113822.GB16726@thunk.org> <4718A3AB.7090301@viscovery.net> 
 <alpine.LFD.0.9999.0710191009330.19446@xanadu.home>
 <8aa486160710190731v67626fd8wa94ba069a17f73ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Johannes Sixt <j.sixt@viscovery.net>,
	Theodore Tso <tytso@thunk.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 16:41:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iit2R-0001Xp-Fg
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 16:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbXJSOlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 10:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932973AbXJSOlM
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 10:41:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:44527 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933205AbXJSOlL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 10:41:11 -0400
Received: (qmail invoked by alias); 19 Oct 2007 14:41:09 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp052) with SMTP; 19 Oct 2007 16:41:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ykmtYaAFyVgHEuBjpMiI+5up0Dp6q5es04aWb1R
	gcR2cD9jDQNiJD
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <8aa486160710190731v67626fd8wa94ba069a17f73ce@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61721>

Hi,

On Fri, 19 Oct 2007, Santi B?jar wrote:

> On 10/19/07, Nicolas Pitre <nico@cam.org> wrote:
> > On Fri, 19 Oct 2007, Johannes Sixt wrote:
> >
> > > Theodore Tso schrieb:
> > > > ==> git://repo.or.cz/git/spearce.git
> > > >  * branch gitk -> spearce/gitk              (new)
> > > >  * branch maint -> spearce/maint    1aa3d01..e7187e4
> > > >  * branch master -> spearce/master  de61e42..7840ce6
> > > >  * branch next -> spearce/next              895be02..2fe5433
> > > >  + branch pu -> spearce/pu          89fa332...1e4c517
> > > >  * branch todo -> spearce/todo              (new)
> > >
> > > > As far as the padding, it would be a pain to figure out how to make
> > > > the right hand column be padded so that it starts 3 spaces after the
> > > > longest "  * branch foo -> bar" line, but that would look the best.
> > >
> > > But this way it wouldn't be difficult at all:
> > >
> > > ==> git://repo.or.cz/git/spearce.git
> > >  * (new)              gitk -> spearce/gitk
> > >  * 1aa3d01..e7187e4   maint -> spearce/maint
> > >  * de61e42..7840ce6   master -> spearce/master
> > >  * 895be02..2fe5433   next -> spearce/next
> > >  + 89fa332...1e4c517  pu -> spearce/pu
> > >  * (new)              todo -> spearce/todo
> >
> > Actually I think this is the best format so far: one line per branch, no
> > terminal width issue (long branch names are simply wrapped), the
> > old..new info is there also with the single character marker to quickly
> > notice the type of update.
> 
> I like it too. I would like to add some more descripton, because I
> think for newbies the .. and ... can be overlooked. Something like:
> 
> $ git fetch spearce
> ...
> URL: git://repo.or.cz/git/spearce.git
>  * (new)              spearce/gitk: new branch 'gitk'

Nah, that is just duplication.

>  * 1aa3d01..e7187e4   spearce/maint: fast forward to branch 'maint'
>  * de61e42..7840ce6   spearce/master: fast forward to branch 'master'
>  * 895be02..2fe5433   spearce/next: fast forward to branch 'next'
>  + 89fa332...1e4c517  spearce/pu: forcing update to non-fast forward branch 'pu'

Better to say (forced) if need be.  But I do not think so.  I like Hannes' 
proposal as-is.

Ciao,
Dscho
