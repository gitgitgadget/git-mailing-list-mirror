From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: absurdly slow git-diff
Date: Fri, 7 Nov 2008 15:57:23 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811071554590.3468@nehalem.linux-foundation.org>
References: <20081107200126.GA20284@toroid.org> <alpine.LFD.2.00.0811071335010.3468@nehalem.linux-foundation.org> <alpine.DEB.1.10.0811071503120.8736@alien.or.mcafeemobile.com> <alpine.DEB.1.10.0811071517280.8736@alien.or.mcafeemobile.com>
 <alpine.LFD.2.00.0811071540340.3468@nehalem.linux-foundation.org> <alpine.DEB.1.10.0811071547080.8736@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Abhijit Menon-Sen <ams@toroid.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>
To: Davide Libenzi <davidel@xmailserver.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 00:59:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KybEi-000175-O0
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 00:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbYKGX6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 18:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753238AbYKGX6Q
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 18:58:16 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45083 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753151AbYKGX6P (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Nov 2008 18:58:15 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA7NvOfx014572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Nov 2008 15:57:25 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA7NvNt3010196;
	Fri, 7 Nov 2008 15:57:24 -0800
In-Reply-To: <alpine.DEB.1.10.0811071547080.8736@alien.or.mcafeemobile.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.436 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100366>



On Fri, 7 Nov 2008, Davide Libenzi wrote:
> 
> Yeah, similar. Mine is below. There's one less branch in the for loops.

..and has a comment and made the magic constant be named.

Junio, the time difference is quite big for Abhijit's admittedly odd 
test-case:

 - Before:

	[torvalds@nehalem slow-diff]$ time git diff 1 2 > out.old
	
	real	2m19.912s
	user	2m19.885s
	sys	0m0.024s

 - After:

	[torvalds@nehalem slow-diff]$ time ~/git/git diff 1 2 > out

	real	0m0.841s
	user	0m0.816s
	sys	0m0.024s

with no difference in output.

			Linus
