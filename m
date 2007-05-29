From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: GIT on MinGW problem
Date: Tue, 29 May 2007 16:49:31 +0200
Organization: eudaptics software gmbh
Message-ID: <465C3D7B.4364961C@eudaptics.com>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>
		 <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org>
		 <465C064F.B9CE9379@eudaptics.com> <465C1252.9020801@trolltech.com>
		 <465C184F.F6053C0C@eudaptics.com> <f329bf540705290729q18b8ed10t5e61a65b75d3759@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Tue May 29 16:48:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht30A-0002Gm-FD
	for gcvg-git@gmane.org; Tue, 29 May 2007 16:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbXE2Osj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 10:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbXE2Osj
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 10:48:39 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.24]:35461 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbXE2Osj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 10:48:39 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.44)
	id 1Ht300-0007UI-Kr; Tue, 29 May 2007 16:48:36 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6ED156EF; Tue, 29 May 2007 16:48:36 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.043
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48695>

Han-Wen Nienhuys wrote:
> 
> 2007/5/29, Johannes Sixt <J.Sixt@eudaptics.com>:
> 
> > > I get that here too, no matter what I set the mount point to be, and
> > > without the fstab file at all.
> >
> > When I inserted '/usr/bin/sort' I had checked for 'which sort' on my
> > Linux and it gave me /usr/bin/sort. Now I see that /bin/sort is probably
> > the canonical path to sort on any *nix. Will change that. But is this
> > also true for 'find'?
> 
> I suggest that you add $PATH  appropriately (prepending /bin and
> /usr/bin/ ) and then
> let the OS figure it out. The other option is to write an autoconf
> test to discover the proper path.

'sort' (and 'find' for that matter) is not only used by the build
scripts, but also by some shell scripts of the toolset. Hence, the path
would have to be modified for each 'git foo' invocation, IOW, by git.exe
itself. I don't like this solution.

The alternative, to force the user to put his $MSYSDIR/bin before $WINNT
(which would require admin rights, btw, because the system's PATH must
be modified), I like even less.

I've to think a bit more about this.

-- Hannes
