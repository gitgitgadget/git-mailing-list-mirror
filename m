From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Sat, 11 Feb 2006 09:39:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602110936510.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602102032410.3691@g5.osdl.org> <7vslqqo341.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Feb 11 18:39:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7yiw-0002ch-Vw
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 18:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWBKRjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 12:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWBKRjt
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 12:39:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49883 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932343AbWBKRjs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 12:39:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1BHddDZ011532
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 11 Feb 2006 09:39:39 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1BHdcQ6007272;
	Sat, 11 Feb 2006 09:39:39 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslqqo341.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15952>



On Fri, 10 Feb 2006, Junio C Hamano wrote:
> 
> Would you suggest doing that with "checkout-index -v", that
> shows "1 path1\r2 path2\r3 path3\r...\rDone.\n"?

Not if it shows every single path.

When going tty output, we should be careful to limit it to not do tons and 
tons of lines. The download output does gettimeofday to limit itself to 
max 2 times per sec, and the percentage output of git-unpack-objects 
similarly limits itself so that it never spews _tons_ of stuff to the 
terminal.

Under many loads, the terminal will be a lot slower than actually writing 
a file ("context switch to gnome-term + context switch to X + set up 
complex text output").

		Linus
