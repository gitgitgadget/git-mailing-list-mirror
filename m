From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/9] Fix git patch header processing in git-apply.
Date: Mon, 29 Aug 2005 19:00:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508291856080.3243@g5.osdl.org>
References: <11252426672473-git-send-email-robfitz@273k.net>
 <7vslwtein3.fsf@assigned-by-dhcp.cox.net> <20050829235823.GA19351@localhost>
 <Pine.LNX.4.58.0508291744400.3243@g5.osdl.org> <7vacj06xi6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0508291821010.3243@g5.osdl.org> <7vbr3g5hsb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robert Fitzsimons <robfitz@273k.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 04:01:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9vQH-0002mQ-Q8
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 04:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVH3CAS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 22:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVH3CAR
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 22:00:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57986 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751112AbVH3CAQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 22:00:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7U204jA015193
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 Aug 2005 19:00:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7U200s0005028;
	Mon, 29 Aug 2005 19:00:02 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr3g5hsb.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=1.678 required=5 tests=BEST_PORN
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7940>



On Mon, 29 Aug 2005, Junio C Hamano wrote:
> 
> The code is simple enough and I see some beauty in it, but I
> honor your veto, at least for now.

Well, I didn't actually veto it when I saw the feature the first time, 
because I think it's a valid thing to do when applying patches by hand.

It was only when I realized that Robert was trying to use it to import 
from somewhere else that it became broken. An import should use the most 
anal patches possible.

Actually, an import should preferably never use patches at all, since that
never really works for binary data. This is why the CVS importer actually
checks out full files and imports them that way. The patch-based ones will 
fundamentally always have problems.

		Linus
