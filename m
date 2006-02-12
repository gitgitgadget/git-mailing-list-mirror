From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fetch-clone progress: finishing touches.
Date: Sun, 12 Feb 2006 12:37:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602121230370.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602111041430.3691@g5.osdl.org>
 <7vslqpjq2q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 21:37:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8NyG-0000kI-18
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 21:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWBLUhS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 15:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWBLUhS
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 15:37:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57750 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750712AbWBLUhQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 15:37:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1CKbCDZ021041
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Feb 2006 12:37:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1CKb8GH018852;
	Sun, 12 Feb 2006 12:37:11 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslqpjq2q.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16019>



On Sat, 11 Feb 2006, Junio C Hamano wrote:
> 
>  * While we are doing eye-candy, this makes the silence after
>    "Generating pack..." part a bit more bearable.
> 
>    Likes, dislikes, too-much's?

Too little, actually.

Your change makes

	git clone ssh://...

be silent again, until the download actually starts. The "isatty(2)" thing 
in git-pack-objects won't trigger, because it's actually a socket, not a 
tty ;/

ssh will only set up a pty pair if it starts an interactive shell, not if 
you use the "ssh host cmd" form.

		Linus
