From: Sean <seanlkml@sympatico.ca>
Subject: Re: Commit to more than one branch at once?
Date: Fri, 6 Oct 2006 14:38:04 -0400
Message-ID: <BAYC1-PASMTP020F3D66B3E46CDBE82D40AE130@CEZ.ICE>
References: <45269E02.50407@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 20:38:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVuaJ-0005Nd-Sj
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 20:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422822AbWJFSiJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 14:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422831AbWJFSiJ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 14:38:09 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:23315 "EHLO
	BAYC1-PASMTP02.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1422822AbWJFSiG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 14:38:06 -0400
X-Originating-IP: [65.93.42.136]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.42.136]) by BAYC1-PASMTP02.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 6 Oct 2006 11:38:06 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GVuaD-0003LW-3U; Fri, 06 Oct 2006 14:38:05 -0400
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Message-Id: <20061006143804.abb6c321.seanlkml@sympatico.ca>
In-Reply-To: <45269E02.50407@s5r6.in-berlin.de>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 06 Oct 2006 18:38:06.0445 (UTC) FILETIME=[9062E1D0:01C6E976]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 06 Oct 2006 20:18:42 +0200
Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> if I git-cherry-pick a commit from branch A into branch B, this is shown
> as a difference in "git-log B..A".
> 
> Is it possible to commit a change to two or more branches but preserve
> the identity of the change? IOW, is there an alternative to
> git-cherry-pick that does not have above mentioned side effect?

Short answer:

No.

Slightly longer answer:

Only merging the branches will make the commit show up in branch B with
the same SHA1 number (or identity) that it had in branch A.  This is a
fundamental part of Git.  The sha1 of each commit is based in part on
the sha1 of its parent.  Thus it's impossible[1] to copy a commit to
another branch (ie. reparent it) without changing its identity.

Sean

[1]  Okay, more or less impossible.. don't ask me do the math.
