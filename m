From: "Kelly F. Hickel" <kfh@mqsoftware.com>
Subject: RE: Best way to merge two repos with same content, differenthistory
Date: Fri, 5 Jun 2009 15:08:55 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794303117DD2@emailmn.mqsoftware.com>
References: <63BEA5E623E09F4D92233FB12A9F794303117DBF@emailmn.mqsoftware.com> <286817520906050953n1afed29cn6c85f219a0c9b8b5@mail.gmail.com> <63BEA5E623E09F4D92233FB12A9F794303117DC1@emailmn.mqsoftware.com> <robbat2-20090605T183716-227340397Z@orbis-terrarum.net> <63BEA5E623E09F4D92233FB12A9F794303117DCB@emailmn.mqsoftware.com> <robbat2-20090605T194802-473902673Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "Robin H. Johnson" <robbat2@gentoo.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 22:09:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCfiq-0001bP-Mg
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 22:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247AbZFEUI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 16:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbZFEUIz
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 16:08:55 -0400
Received: from emailmn.mqsoftware.com ([66.192.70.108]:28227 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbZFEUIz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 16:08:55 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <robbat2-20090605T194802-473902673Z@orbis-terrarum.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Best way to merge two repos with same content, differenthistory
Thread-Index: AcnmGKJ6O9MxPlsASWaPyfqZ1yNLiwAACtTA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120827>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Robin H. Johnson
> Sent: Friday, June 05, 2009 3:02 PM
> To: Git Mailing List
> Subject: Re: Best way to merge two repos with same content,
> differenthistory
> 
> On Fri, Jun 05, 2009 at 02:06:25PM -0500, Kelly F. Hickel wrote:
> > Robin,
> > 	That's all good news, I have an 8 way box with 32gb of ram
> running a
> > 64 bit Linux, a box with 4 gb of ram panics during the conversion.
> Thanks for your data.
> 
> For comparison, our conversion box is also 8-way, but only 16GiB RAM.
> 
> I'm surprised at how long pass1 is for you, especially since you've
got
> a lot less CVS Files and CVS Revisions than the Gentoo repo (I do
> deduce
> that your individual revisions are larger, averaging at 15KiB vs. our
> 711 bytes).
> 
> I think there's something odd in the total CVS branches/tags count
> however, as the counts there imply an average of 67 branches and 173
> tags per CVS revision. You might want to dig into that part manually
> and
> see about it (not sure of your Python skills). That would probably cut
> down both your pass1 and pass4 times significantly.

Robin, I'm not much with python, so haven't dug into the code much at
all. The numbers are high, although we do create a lot of branches (had
to contribute a fix a year or two to CVS to get the branching time down
from the 2.5 hours it was taking).  At one point I carefully examined
the symbol file that cvs2git was outputting and convinced myself that it
was doing the right thing, but that was awhile ago.

> 
> Hopefully mhagger will get the external blob stuff committed soon, I
> was
> working on validating it's results.
> 
> In doing so discovered a testcase where RCSRevisionReader and
> CVSRevisionReader gave different output themselves, the latter (which
> is
> documented as more accurate otherwise) missing the contents of an
> entire
> file. It's on the cvs2svn-dev mailing list now. Tracing that first,
> thereafter comparing it to the new Git side.
> 
> > git repack -a -d -f --depth=4000 --window=4000 && git pack-refs
--all
> Did those extreme depth/window values actually help size much? The
> Gentoo ones actually didn't improve significantly over
depth=window=50.

I know that they were still (apparently) improving after the 200 mark,
it took long enough at 200 that I just decided to crank the numbers way
up and let it run over the weekend.

> 
> --
> Robin Hugh Johnson
> Gentoo Linux Developer & Infra Guy
> E-Mail     : robbat2@gentoo.org
> GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

I'll be looking forward to a newer faster cvs2git, although I did just
get the graft idea working, so not sure if we'll wait that long or not
(would be nice not to have to muck around with it though).

Thanks,
Kelly
