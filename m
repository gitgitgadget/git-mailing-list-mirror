From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git diff odds
Date: Tue, 25 Mar 2008 19:19:36 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803251914150.2775@woody.linux-foundation.org>
References: <200803260100.m2Q10v2l005189@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Xavier Maillard <xma@gnu.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 03:20:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeLFt-00074o-GG
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 03:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbYCZCUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 22:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754673AbYCZCUE
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 22:20:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44834 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752243AbYCZCUD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2008 22:20:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2Q2JvFu020555
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 25 Mar 2008 19:19:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2Q2Jarq025357;
	Tue, 25 Mar 2008 19:19:48 -0700
In-Reply-To: <200803260100.m2Q10v2l005189@localhost.localdomain>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.258 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78244>



On Wed, 26 Mar 2008, Xavier Maillard wrote:
> 
> With LESS variable set as "-M", git diff displays escape sequence
> instead of the colored ouput (as requested in my .git/config =>
> color.diff=auto).

That's how 'less' works. It shows escape sequences as the escapes by 
default.

> If set to FRSX, it works perfectly.

It's the '-R' part that does the magic.

> Is this a bug ?

No, it's documented less behaviour. See "man less".

If you want to use "-M", you can mix it with R (or the other flags, for 
that matter) and use "LESS=MR" or "LESS=FRSXM" or whatever you like. But 
if you want less to pass through colors, you need that R there somewhere.

(You could use lower-case "r" too, but that's very dangerous, since it 
lets through _all_ escape sequences, including the ones that really screw 
up your terminal experience)

		Linus
