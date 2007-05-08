From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Tue, 8 May 2007 13:07:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705081256410.4167@racer.site>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> 
 <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org> 
 <vpqbqgxak1i.fsf@bauges.imag.fr> <46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 13:07:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlNXj-0001Sb-V8
	for gcvg-git@gmane.org; Tue, 08 May 2007 13:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967077AbXEHLHY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 07:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966486AbXEHLHY
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 07:07:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:35601 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S967077AbXEHLHW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 07:07:22 -0400
Received: (qmail invoked by alias); 08 May 2007 11:07:10 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 08 May 2007 13:07:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/oMcNH1bnodbfLWCZzmrYpUFYRQJ3FpSqyfsh4I6
	PZvMHBV3GKiowL
X-X-Sender: gene099@racer.site
In-Reply-To: <46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46565>

Hi,

On Tue, 8 May 2007, Martin Langhoff wrote:

> Heh. Making the index very visible makes sense when you are merging,

You're saying that the main use of the index is to help merging. I have to 
disagree strongly.

When I have been chasing a bug all over the place, and finally found it, 
my working tree is a mess. Lots of assertions, lots of debugging 
statements, some of them commented out. So, now it is cleanup time, right?

The problem is that more often than not, I broke my fix while cleaning up.

Therefore, I now put all changed files into the index (git add -u), and 
clean up the files one by one, always checking with "git diff" and "git 
diff HEAD" what I still have to do.

Yes, very often I can just take the original version of a file (git reset 
--soft <file...> would be handy here), but it helped me quite a number of 
times to have my messed-up-but-working state in the index.

In a sense, I am using the index as the stash commit we talked about every 
once in a while.

Ciao,
Dscho
