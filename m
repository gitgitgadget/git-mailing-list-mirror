From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] First cut at libifying revlist generation
Date: Sun, 26 Feb 2006 21:20:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602262119200.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0602251608160.22647@g5.osdl.org>
 <7vpsl93395.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602261914270.22647@g5.osdl.org>
 <7vy7zx1j6u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 27 06:20:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDao7-0002Rl-QP
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 06:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWB0FUU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 00:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWB0FUU
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 00:20:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18345 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751474AbWB0FUT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 00:20:19 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1R5KFDZ031072
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Feb 2006 21:20:15 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1R5KCMm008368;
	Sun, 26 Feb 2006 21:20:14 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7zx1j6u.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16826>



On Sun, 26 Feb 2006, Junio C Hamano wrote:
> 
> Not really, because the second invocation of add_one_commit()
> says "I've seen that *commit*", which is correct.  And the story
> is obviously the same if you used longhand "^v1.0.0^0 v1.0.0".

Ok.

I suspect that the simplest fix is to just move "limited" into the "revs" 
structure, the way I did pretty much everything else. That way nothing 
really changes: we'll have the exact same logic, the flag just moved 
around.

		Linus
