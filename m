From: "Kelly F. Hickel" <kfh@mqsoftware.com>
Subject: RE: newb: Given a commit id, find which branches have it as an ancestor
Date: Fri, 13 Mar 2009 08:30:57 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794302E0F9D8@emailmn.mqsoftware.com>
References: <63BEA5E623E09F4D92233FB12A9F794302E0F9B2@emailmn.mqsoftware.com> <63BEA5E623E09F4D92233FB12A9F794302E0F9BA@emailmn.mqsoftware.com> <49BA07E5.2080701@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 13 14:32:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li7V2-00043k-9k
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 14:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123AbZCMNbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 09:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbZCMNbA
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 09:31:00 -0400
Received: from mail.de.mqsoftware.com ([66.192.70.108]:26178 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbZCMNbA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 09:31:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <49BA07E5.2080701@viscovery.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: newb: Given a commit id, find which branches have it as an ancestor
Thread-Index: Acmjq2c70VoV6w9QT7S4fpiqxLKk4wAND0GQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113184>

> -----Original Message-----
> From: Johannes Sixt [mailto:j.sixt@viscovery.net]
> Sent: Friday, March 13, 2009 2:15 AM
> To: Kelly F. Hickel
> Cc: git@vger.kernel.org
> Subject: Re: newb: Given a commit id, find which branches have it as
an
> ancestor
> 
> Kelly F. Hickel schrieb:
> >> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org]
> On
> >> Behalf Of Johannes Sixt
> >> Sent: Thursday, March 12, 2009 10:38 AM
> >> To: Kelly F. Hickel
> >
> >> $ git branch -a --contains the-sha1
> >>
> >> -- Hannes
> >>
> >
> > Thanks, that looks like a really useful command.
> >
> > Unfortunately, in this case it didn't print anything out (neither
did
> > "git branch -r -a sha1").
> >
> > What I'm beginning to suspect is that all the commits that should
> have
> > gone to master went to some unnamed branch.
> > Is that reasonable/possible/likely?  This commit has a full
ancestry,
> > but doesn't appear to be on any branch.
> >
> > In the above question there's an assumption that if a branch exists
> > without a name, then git branch -a --contains wouldn't print
anything
> > out, is that correct?
> 
> Correct.
> 
> Your best bet is perhaps that you create a branch at the commit
> 
>   $ git branch tmp-branch your_sha1
> 
> so that the commits are not lost, then you cherry-pick them to master.
> 
> -- Hannes

Thanks, in the end it turned out that I just hadn't properly understood
the 
Comment about doing your own merge in the git-cvsimport doc.  For
whatever
reason, when doing cvsimport in a workspace on master, after the import
I 
have to do "git merge origin/master" and it fast forwards it and all is
well.
I *don't* have to do that for any of the other branches that get
affected by
the cvsimport, so that threw me for awhile.

Thanks for the help,
Kelly
