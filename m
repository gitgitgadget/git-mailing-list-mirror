From: "Bevan Watkiss" <bevan.watkiss@cloakware.com>
Subject: RE:
Date: Fri, 8 May 2009 12:14:22 -0400
Message-ID: <049619646E0C4825A1A1D1113FE6422E@caottdt504>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain> <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504> <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain> <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain> <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain> <alpine.DEB.1.10.0905071521130.15782@asgard> <alpine.LFD.2.01.0905071531030.4983@localhost.localdomain> <alpine.DEB.1.10.0905071543120.15782@asgard> <alpine.LFD.2.01.0905071553570.4983@localhost.localdomain> <alpine.DEB.1.10.0905071607080.15782@asgard> <alpine.LFD.2.01.0905071613130.4983@localhost.localdomain> <alpine.DEB.1.10.0905071629230.15782@asga
 rd>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Alex Riesen'" <raa.lkml@gmail.com>,
	"'Git Mailing List'" <git@vger.kernel.org>
To: <david@lang.hm>, "'Linus Torvalds'" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 08 18:18:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Sm9-0000iD-CM
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 18:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917AbZEHQSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 12:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753256AbZEHQSG
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 12:18:06 -0400
Received: from mail.cloakware.com ([142.46.212.116]:42275 "EHLO
	mail.cloakware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbZEHQSF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 12:18:05 -0400
Received: from caottdt504 (bwatkiss-desk.cloakware.com [172.20.201.170])
	(authenticated bits=0)
	by mail.cloakware.com (8.13.1/8.13.1) with ESMTP id n48GH3NP003200;
	Fri, 8 May 2009 12:17:03 -0400
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <alpine.DEB.1.10.0905071629230.15782@asgard>
Thread-Index: AcnPa+glpoaaT5EJQoiiYqOjU/jPmgAiEDBQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4325
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118615>



> -----Original Message-----
> From: david@lang.hm [mailto:david@lang.hm]
> Sent: May 7, 2009 7:31 PM
> To: Linus Torvalds
> Cc: Bevan Watkiss; 'Alex Riesen'; Git Mailing List
> Subject: RE:
> 
> On Thu, 7 May 2009, Linus Torvalds wrote:
> 
> > On Thu, 7 May 2009, david@lang.hm wrote:
> >>
> >> what about a reset --hard? (is there any command that would force the
> files to
> >> be re-written, no matter what git thinks is already there)
> >
> > No, not "git reset --hard" either, I think. Git very much tries to avoid
> > rewriting files, and if you've told it that file contents are stable, it
> > will believe you.
> >
> > In fact, I think people used CE_VALID explicitly for the missing parts
> of
> > "partial checkouts", so if we'd suddenly start writing files despite
> them
> > being marked as ok in the tree, I think we'd have broken that part.
> >
> > (Although again - I'm not sure who would use CE_VALID and friends).
> >
> > If you want to force everything to be rewritten, you should just remove
> > the index (or remove the specific entries in it if you want to do it
> just
> > to a particular file) and then do a "git checkout" to re-read and
> > re-populate the tree.
> >
> > But I'm not really seeing why you want to do this. If you told git that
> it
> > shouldn't care about the working tree, why do you now want it do care?
> 
> to be able to manually recover from the case where someone did things that
> they weren't supposed to
> 
> removing the index and doing a checkout would be a reasonable thing to do
> (at least conceptually), I will admit that I don't remember ever seeing a
> command (or discussion of one) that would let me do that.

Added the patch and now the time is down to 4 1/2 minutes.  Still a little
slow for my needs though.  

Since I'm looking for a more instantaneous update I'll probably use
something more along the lines of
	git fetch origin/master
	git log --name-only ..HEAD
to get the list of files that have changed and copy them from a local
repository.  Nightly doing a real pull to confirm the files are correct and
up to date.

Bevan
