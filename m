From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Make gitk use --early-output
Date: Sat, 3 Nov 2007 22:30:06 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0711032227420.15101@woody.linux-foundation.org>
References: <18221.2285.259487.655684@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 06:30:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoY4A-0005Pe-4c
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 06:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbXKDFaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 01:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbXKDFaO
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 01:30:14 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:32817 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750802AbXKDFaM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 01:30:12 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA45U78O010304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Nov 2007 22:30:08 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA45U6iF017802;
	Sat, 3 Nov 2007 22:30:07 -0700
In-Reply-To: <18221.2285.259487.655684@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=-3.235 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63350>



On Sun, 4 Nov 2007, Paul Mackerras wrote:
>
> This makes gitk use the --early-output flag on the git log command.
> 
> When gitk sees the "Final output:" line from git log, it goes into a
> mode where it basically just checks that it is getting the commits
> again in the same order as before.  If they are, well and good; if
> not, it truncates its internal list at the point of difference and
> proceeds to read in the commits in the new order from there on, and
> re-does the graph layout if necessary.
> 
> This gives a much more immediate feel to the startup; gitk shows its
> window with the first screenful of commits displayed very quickly this
> way.

Goodie. Seems to work for me. I'll tweak the behaviour of --early-output a 
bit more, because right now if things are really cold in the cache, the 
"--early-output" logic will often trigger with just a single commit in the 
list (because the timeout is so short), but it already seems to work 
pretty well.

		Linus
