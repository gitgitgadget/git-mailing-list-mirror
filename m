From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] A Perforce importer for git.
Date: Fri, 2 Jun 2006 23:20:05 +0200
Message-ID: <20060602212005.GA7801@steel.home>
References: <BAYC1-PASMTP117796558F3B42B2C18DBCAE980@CEZ.ICE> <81b0412b0606020609o24ee34b4p7b1bcd013136d49a@mail.gmail.com> <20060602094357.ee3d8407.seanlkml@sympatico.ca>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 23:20:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmH48-0005DY-SX
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 23:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWFBVUR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 17:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbWFBVUR
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 17:20:17 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:8169 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030287AbWFBVUP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 17:20:15 -0400
Received: from fwd28.aul.t-online.de 
	by mailout04.sul.t-online.com with smtp 
	id 1FmH41-0007J0-02; Fri, 02 Jun 2006 23:20:13 +0200
Received: from tigra.home (Sx+d98ZFgeJOYFUD0jF0i65TqxxR2wGDL9BkHoH3RxL5xzi2zNcMZ9@[84.160.91.13]) by fwd28.sul.t-online.de
	with esmtp id 1FmH3w-0P36EC0; Fri, 2 Jun 2006 23:20:08 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 81697277B5;
	Fri,  2 Jun 2006 23:20:07 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FmH3u-0005VU-10; Fri, 02 Jun 2006 23:20:06 +0200
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20060602094357.ee3d8407.seanlkml@sympatico.ca>
User-Agent: Mutt/1.5.6i
X-ID: Sx+d98ZFgeJOYFUD0jF0i65TqxxR2wGDL9BkHoH3RxL5xzi2zNcMZ9
X-TOI-MSGID: f1258cf0-0493-4ccb-859c-c14406295d84
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21176>

Sean, Fri, Jun 02, 2006 15:43:57 +0200:
> "Alex Riesen" <raa.lkml@gmail.com> wrote:
> 
> > BTW, can I suggest to import the _currently_ synced state?
> > 
> 
> Note that it never syncs specifically to head, it explicitly asks for
> each revision along the branch and tt doesn't know anything about your
> working state, it can only import commits.

So did get that part right (I didn't actually tried your script, just
read the code).

> Are you looking for the ability to create a single git branch which has

Well, I'm not quite sure it's at all possible... Perforce has a
strange ways for doing history: it is kept for each file (as in CVS),
but you can bundle changes in many files into one "change".
Perforce also has no branches (in the GIT's meaning of the term).
These by Perforce are just server-side directories, without any
relevance to the source whatsoever (just copies).

> the history of the combined view of your stitched together client mappings
> rather than the independent branches held by the server?

I'm rather looking for a ability to manage a single branch where
import "sync" events appear as a merge of changes to the files
involved in the sync. I just haven't figured out yet how to "break" a
Perforce change into changes to single files and import that broken up
commit into git as a merge.

I hope that was clear enough... I think understanding how cvs/svn
imports work should help here - Perforce is actually nothing very
different from them.
