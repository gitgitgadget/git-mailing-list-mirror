From: Sean <seanlkml@sympatico.ca>
Subject: Re: how to use git merge -s subtree?
Date: Sat, 5 Jan 2008 21:13:56 -0500
Message-ID: <BAYC1-PASMTP01FC193EA959D148F19374AE4E0@CEZ.ICE>
References: <20080105230004.GY29972@genesis.frugalware.org>
	<BAYC1-PASMTP12374B54BA370A1E1C6E78AE4E0@CEZ.ICE>
	<flpah7$beg$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Soria Parra <sn_@gmx.net>
X-From: git-owner@vger.kernel.org Sun Jan 06 03:14:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBL20-0000hP-SU
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 03:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbYAFCOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 21:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbYAFCOE
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 21:14:04 -0500
Received: from bay0-omc2-s6.bay0.hotmail.com ([65.54.246.142]:48646 "EHLO
	bay0-omc2-s6.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751771AbYAFCOD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jan 2008 21:14:03 -0500
Received: from BAYC1-PASMTP01 ([65.54.191.161]) by bay0-omc2-s6.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 5 Jan 2008 18:13:57 -0800
X-Originating-IP: [74.15.76.104]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.76.104]) by BAYC1-PASMTP01.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sat, 5 Jan 2008 18:13:57 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1JBL1I-0006KM-Vj; Sat, 05 Jan 2008 21:13:49 -0500
In-Reply-To: <flpah7$beg$2@ger.gmane.org>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.1; i686-pc-linux-gnu)
X-OriginalArrivalTime: 06 Jan 2008 02:13:57.0747 (UTC) FILETIME=[CB665C30:01C85009]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69701>

On Sun, 06 Jan 2008 02:22:47 +0100
David Soria Parra <sn_@gmx.net> wrote:

> > Here's another way that is perhaps a little cleaner:
> > 
> > $ git remote add -f B /path/to/B
> > $ git merge -s ours --no-commit B/master
> > $ git read-tree --prefix=sub/ -u B/master 
> > $ git commit -m "subtree merged B"
> 
> that works perfectly but it doesn't preserve the history, does it?

David,

Yes, the reason to start with the "--no-commit" merge is so that the history
is properly connected once you do the final commit step.  However, I should
have noted in my original message that none of the steps actually use the
subtree merge.  Instead they simply prepare a repository such that
future merging can be done with:

   $ git merge -s subtree B/master.

Cheers,
Sean
