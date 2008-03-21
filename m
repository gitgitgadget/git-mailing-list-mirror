From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Why rebase with preserve merges asks for merged commits
Date: Fri, 21 Mar 2008 14:14:33 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803211410310.4124@racer.site>
References: <alpine.LSU.1.00.0803201208080.3983@racer.site> <1206018070-3402-1-git-send-email-joerg@alea.gnuu.de> <alpine.LSU.1.00.0803210040270.4124@racer.site> <20080321125650.GA4587@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1750173055-1206105274=:4124"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Fri Mar 21 14:15:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jch5U-0006Sg-T6
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 14:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178AbYCUNOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 09:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755149AbYCUNOd
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 09:14:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:44790 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755122AbYCUNOc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 09:14:32 -0400
Received: (qmail invoked by alias); 21 Mar 2008 13:14:30 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 21 Mar 2008 14:14:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+WiHh8jZSW8I+caLILTyKifmgRNHe4TOZW4k0sWB
	Eux+/sXdsmFc2Y
X-X-Sender: gene099@racer.site
In-Reply-To: <20080321125650.GA4587@alea.gnuu.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77737>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1750173055-1206105274=:4124
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 21 Mar 2008, Jörg Sommer wrote:

> Think of the following situation:
> 
> M----------U          to-be-preserved
>  \          \
>   `--A---B---+---C    squash-and-preserve-merges
> 
> When I do a rebase M..C with preserve merges I can decide about all commits
> including U which came in with the merge.
> 
> U  pick 9604163 unrelated
> A  pick 5ef0364 SaPM-1
> B  pick 22aadcf SaPM-2
> +  pick 828f7d8 Merge branch 'to-be-preserved' into squash-and-preserve-merges
> C  pick 2a15a54 SaPM-3
> 
> Why I can decide about the commit U from the branch to-be-preserved?

Well, -p obviously does not take the commits (it takes a superset in your 
case) you would expect it to take.  I am not sure if that is always the 
correct thing to assume, though.

In the short run, you can do it manually by

	$ git checkout B
	$ git rebase --onto branch1 M
	$ git merge U
	$ git cherry-pick C

Ciao,
Dscho

P.S.: Oh, BTW, just as in German, you have to put the verb before a 
subject in an English question.
--8323584-1750173055-1206105274=:4124--
