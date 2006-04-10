From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git log [diff-tree options]...
Date: Sun, 9 Apr 2006 17:06:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604091702190.9504@g5.osdl.org>
References: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604090950590.9504@g5.osdl.org> <7vbqvabn8f.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604091158310.9504@g5.osdl.org>
 <Pine.LNX.4.63.0604092312340.29136@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0604100000430.30000@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy7ye9uk8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 10 02:06:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSjvU-0007wO-Q8
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 02:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWDJAGY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 20:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWDJAGY
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 20:06:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52159 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750853AbWDJAGX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Apr 2006 20:06:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3A06HtH024278
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 9 Apr 2006 17:06:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3A06FWk021043;
	Sun, 9 Apr 2006 17:06:16 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7ye9uk8.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18573>



On Sun, 9 Apr 2006, Junio C Hamano wrote:
> 
> I do not think so.  You should default to --cc only there is no
> explicit command line stuff from the user.

Actually, even that would be wrong, when I think more about it. The 
default for "git-whatchanged" is to do diffing, but default to the "raw" 
diff (just "-r" for recursive).

So the most appropriate default set of flags is likely "-r -c", which also 
means that any subsequent explicit command line stuff will override it (ie 
adding a "-p" should automatically do the right thing).

But the "memmove()" to move the arguments around was definitely broken. 
Much better to just initialize the diff flags manually, I think.

		Linus
