From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 20:55:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903112049470.10279@pacific.mpi-cbg.de>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>  <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>  <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302> <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
 <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302> <alpine.DEB.1.10.0903110931070.13653@asgard.lang.hm> <alpine.DEB.1.00.0903111800500.10498@intel-tinevez-2-302> <alpine.DEB.1.10.0903111229330.16753@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: saurabh gupta <saurabhgupta1403@gmail.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Wed Mar 11 20:57:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhUWV-0002bn-1s
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 20:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbZCKTxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 15:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbZCKTxq
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 15:53:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:47544 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754480AbZCKTxp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 15:53:45 -0400
Received: (qmail invoked by alias); 11 Mar 2009 19:53:41 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp034) with SMTP; 11 Mar 2009 20:53:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18V5fI6KO0VlWzkPtyhQqgRxH4Oel7y7LdtehWqjX
	/GctCkheQSB3O/
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.10.0903111229330.16753@asgard.lang.hm>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112969>

Hi,

On Wed, 11 Mar 2009, david@lang.hm wrote:

> On Wed, 11 Mar 2009, Johannes Schindelin wrote:
> 
> > On Wed, 11 Mar 2009, david@lang.hm wrote:
> >
> > > On Wed, 11 Mar 2009, Johannes Schindelin wrote:
> > >
> > > > On Wed, 11 Mar 2009, saurabh gupta wrote:
> > > >
> > > > > What I think is to implement file formats other than text like 
> > > > > that written on wiki i.e. latex, xml, or even any database file 
> > > > > (db file). Another idea (although it can be weired also) is to 
> > > > > implement the new file formats in the plug-in formats. For 
> > > > > example, to incorporate the merger engine for a new file format, 
> > > > > a plug-in is created and can be integrated with the present 
> > > > > merger in the git. However, I am not sure how much valid is this 
> > > > > idea to make the present merger in git to be compatible with the 
> > > > > plug-ins for enabling newer file formats.
> > > >
> > > > I am not sure that a plugin structure is needed.  Take, for 
> > > > example, three different .xml based formats: OpenOffice documents, 
> > > > .svg files and Ant build.xml files.  They need very different user 
> > > > interfaces.
> > > >
> > > > > I am thinking of using gtk+ libraries to implement the GUI part 
> > > > > (I am quite comfortable with gtk+).
> > > >
> > > > I mentioned Tcl/Tk, because it is portable, but I'll also take 
> > > > gtk-based stuff ;-)
> > > >
> > > > > However, I think in merging and notifying about the conflicts in 
> > > > > the xml files, other things can also be put forward. Like the 
> > > > > GUI will show the number of tags differing and what are the new 
> > > > > tags added and even if any tag is renamed with the content 
> > > > > unchanged. If possible, how about showing a tree like structure 
> > > > > (just like DOM model) to compare (or diff) the two xml files.
> > > >
> > > > This is a little bit too low-level for my liking.  Taking the 
> > > > OpenOffice example again, the GUI should not expose XML at all...
> > >
> > > don't assume that you have a GUI just to handle a filetype. if you 
> > > have one, good, make use of it. but have a fallback for how to deal 
> > > with things if all you have is a text terminal.
> >
> > I do not think it makes sense to assume all you have at your hands is 
> > a terminal when you try to resolve a merge conflict in an .svg file.
> 
> I'm not saying that you assume that all you have is a terminal, I'm 
> saying that you _support_ the case that all you have is a terminal.

Sorry, no, the GSoC idea was not about "merge helpers that run also in a 
terminal".  The idea was about "Domain specific merge helpers".

If I can choose, I'd rather have support for one more merge helper, even 
if it is all graphical, than an enhancement to support also a terminal.

While I am dreaming: this is the list of domains _I_ would like to see 
supported: LaTeX, OpenOffice documents, .svg files.

But that is not up to me to decide, just to suggest.

Ciao,
Dscho
