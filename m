From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: git merge and cherry-pick and duplicated commits?
Date: Fri, 16 Jan 2009 00:09:10 +0100
Message-ID: <200901160009.11124.markus.heidelberg@web.de>
References: <2729632a0901131840v5c7ce0c7l3f87c03caabf68de@mail.gmail.com> <496DA3B2.1070807@viscovery.net> <2729632a0901141033p47b4d8dah46f5bac27307d306@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Fri Jan 16 00:10:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNbLg-00048o-O7
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 00:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbZAOXIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 18:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755258AbZAOXIk
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 18:08:40 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:33755 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761AbZAOXIj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 18:08:39 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 4B9CEF8E3BCD;
	Fri, 16 Jan 2009 00:08:36 +0100 (CET)
Received: from [89.59.96.34] (helo=pluto)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LNbKG-00056H-00; Fri, 16 Jan 2009 00:08:36 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <2729632a0901141033p47b4d8dah46f5bac27307d306@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19T03HhitCAnKvhHtNAFWq3f1BLFPCYM2zijBHi
	gVvs3lXB+1r7E3fVyoKr+yCNb3UNIoIZfyPcHXQK4C9XERRmPd
	92eC5LU20lqLyQyItYCw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105894>

skillzero@gmail.com, 14.01.2009:
> On Wed, Jan 14, 2009 at 12:34 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> 
> > After you created the fixup, you have this situation:
> >
> >    o--o--o   <- A (feature branch)
> >   /
> > --o--x        <- X (the fix-up branch)
> >   \
> >    o--o--o   <- Z (probably your master)
> >
> > You merge the fix-up into the feature branch and continue developing the
> > feature:
> >
> >    o--o--o--M--o--o   <- A
> >   /        /
> > --o--x-----'           <- X
> >   \
> >    o--o--o            <- Z
> >
> > Other people need the fix in Z right now, so you merge it into Z as well:
> >
> >    o--o--o--M--o--o   <- A
> >   /        /
> > --o--x-----<           <- X
> >   \        \
> >    o--o--o--N         <- Z
> >
> > You complete your feature and merge it into Z:
> >
> >    o--o--o--M--o--o     <- A
> >   /        /       \
> > --o--x-----<         \   <- X
> >   \        \         \
> >    o--o--o--N---------O <- Z
> >
> > The fix-up commit is only once in your history.
> 
> Thanks for the info. That's what I was hoping, but I was thinking that
> I'd get duplicate commits if I did that. I'll have to try it out when
> I run into this situation again.

Note, that you'd get 2 merge commits for this fix-up commit into branch Z.
The first from merging X into Z, the second is created from merging X
into A and occures in Z when merging A into it.

Markus
