From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Verbose git-daemon logging
Date: Thu, 22 Sep 2005 16:58:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509221651000.2553@g5.osdl.org>
References: <20050921213933.GB10575@pasky.or.cz> <7vwtl9mqm5.fsf@assigned-by-dhcp.cox.net>
 <20050922092528.GB21019@pasky.or.cz> <7vd5n0lle8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 01:59:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIayC-0002wM-L6
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 01:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVIVX6y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 19:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVIVX6y
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 19:58:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36494 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751071AbVIVX6w (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 19:58:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8MNwdBo022982
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Sep 2005 16:58:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8MNwW9D028185;
	Thu, 22 Sep 2005 16:58:36 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5n0lle8.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9154>



On Thu, 22 Sep 2005, Junio C Hamano wrote:
> 
> The tail part still looks odd here.  Maybe something like this?

And if you actually want it to be more reliable, don't use fputs. That 
can still split lines, and even if it doesn't, it doesn't help.

> +	buf[buflen++] = '\n';
> +	buf[buflen] = '\0';
> +
> +	fputs(buf, stderr);

Why use "fputs()", when you migth as well do write()?

Also, it would probably be nice if you allow the use of syslog().. 

		Linus
